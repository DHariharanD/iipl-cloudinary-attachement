# Accident Attachments — Cloudinary Integration

## Overview

This document covers the file attachment feature added to the **Accident Management** module of the IIPL EC project. The original `iipl_ec` project had no attachment capability on the `Accident` entity. This implementation adds full upload, display, and delete support for accident-related documents (PDFs, images, spreadsheets, etc.) using **Cloudinary** as the external file storage backend.

Files are stored in Cloudinary and their metadata (URL, file name, size, type) is persisted in the local PostgreSQL database. The feature is fully integrated with CAP's draft/activate lifecycle so files behave consistently whether the user is creating a new record or editing an existing one.

---

## What Was Changed vs the Original Project

The original `iipl_ec` project had this minimal schema for attachments:

```cds
entity AccidentAttachments : cuid, managed {
    accident  : Association to Accident;
    fileName  : String(255);
    mediaType : String(100);
    url       : String(500);
}
```

No handler, no service action, no UI controller, and no external storage were wired up.

---

## What Was Added

### 1. Schema — `db/vehiclemanagement/accident-management.cds`

The `AccidentAttachments` entity was extended with two additional fields needed for Cloudinary integration:

```cds
entity AccidentAttachments : cuid, managed {
    accident   : Association to Accident;
    fileName   : String(255);
    mediaType  : String(100);
    url        : String(500);
    fileSize   : Integer64;       -- added: file size in bytes for display
    publicId   : String(500);     -- added: Cloudinary public_id needed for deletion
}
```

The `Accident` entity itself was unchanged except for the addition of the `attachments` composition (which was already present but had no backing handler).

### 2. Service — `srv/accident-management-service.cds`

Two custom OData actions were added to `AccidentService`:

```cds
action uploadAccidentFile(
    accident_ID : UUID,
    fileName    : String(255),
    mediaType   : String(100),
    content     : LargeString      -- base64-encoded file content
) returns AccidentAttachments;

action deleteAccidentFile(
    attachment_ID : UUID
);
```

Standard CRUD on `AccidentAttachments` was disabled via annotations (insert, update, delete are all locked) since all mutations go through these custom actions.

### 3. Backend Handler — `srv/src/main/java/inflexion/ec_master/handlers/AccidentAttachmentHandler.java`

**New file.** This is the core of the feature. It handles three concerns:

**Upload (`onUploadAccidentFile`):**
- Receives base64 file content from the UI
- Uploads the file to Cloudinary via `CloudinaryService`
- Always inserts the resulting metadata row into the **draft** attachments table (`AccidentService.AccidentAttachments.drafts`) regardless of whether the user is creating or editing a record
- Returns the new attachment record so the UI can display it immediately

**Save (draftActivate — `beforeDraftActivate`):**
- Fires when the user clicks Save on the Accident Object Page
- Copies all draft attachment rows for the accident into the **active** attachments table (`AccidentService.AccidentAttachments`) with `IsActiveEntity=true`
- Deletes the draft rows after promotion
- Handles the case where CAP also fires this hook during `draftPrepare` (which has a null accident ID) by skipping silently

**Discard (draftCancel — `beforeDraftCancel`):**
- Fires when the user clicks Discard
- Deletes all draft attachment rows for the accident from both Cloudinary and the database
- Skips Cloudinary deletion gracefully if the `publicId` is missing, so the DB row still gets cleaned up

**Delete (`onDeleteAccidentFile`):**
- Searches the draft table first (for in-edit-mode deletes), then the active table (for view-mode deletes)
- Deletes the file from Cloudinary by `publicId`, trying `image`, `raw`, and `video` resource types in sequence
- Deletes the row from the database

### 4. Cloudinary Service — `srv/src/main/java/inflexion/ec_master/handlers/CloudinaryService.java`

**New file.** A Spring `@Service` that wraps the Cloudinary Java SDK:

- **`upload(base64Content, originalName)`** — decodes base64 bytes, uploads to Cloudinary under the `accident-attachments/` folder with a UUID-prefixed public ID, returns the full Cloudinary response map including `secure_url`, `public_id`, and `bytes`
- **`delete(publicId)`** — attempts deletion across all three Cloudinary resource types (`image`, `raw`, `video`) so the caller does not need to track resource type; logs a warning if the file is already gone rather than throwing
- **`sanitiseName(name)`** — strips characters invalid in a Cloudinary public ID

Cloudinary credentials are injected from environment variables via `application.yaml`:

```yaml
cloudinary:
  cloud-name: ${CLOUDINARY_CLOUD_NAME}
  api-key:    ${CLOUDINARY_API_KEY}
  api-secret: ${CLOUDINARY_API_SECRET}
```

### 5. UI Annotations — `app/accident-management/annotations.cds`

The `AccidentAttachments` line item table was annotated to show a clickable file name, MIME type, file size, upload date, and uploader. The file name column uses `UI.DataFieldWithUrl` so clicking it opens the Cloudinary URL directly in the browser:

```cds
annotate service.AccidentAttachments with @(
    UI.LineItem: [
        { $Type: 'UI.DataFieldWithUrl', Value: fileName, Url: url, Label: 'File Name' },
        { $Type: 'UI.DataField', Value: mediaType, Label: 'Type' },
        { $Type: 'UI.DataField', Value: fileSize,  Label: 'Size (bytes)' },
        { $Type: 'UI.DataField', Value: createdAt, Label: 'Uploaded On' },
        { $Type: 'UI.DataField', Value: createdBy, Label: 'Uploaded By' }
    ]
);
```

Internal fields (`publicId`, `url`) are hidden with `@UI.Hidden` since they are only used for the link target and Cloudinary deletion, not for direct display.

### 6. UI Controller — `app/accident-management/webapp/ext/controller/AccidentObjectPageExt.js`

**New file.** A plain JavaScript module (not a ControllerExtension class, exported as a mixin object) that provides the two toolbar action handlers:

**`onUploadAttachment`:**
- Creates a hidden `<input type="file">` element programmatically and triggers a file picker dialog
- Accepts `.pdf`, `.doc`, `.docx`, `.xls`, `.xlsx`, `.png`, `.jpg`, `.jpeg`, `.txt`, `.csv`
- Enforces a 10 MB size limit client-side before reading the file
- Reads the file as a base64 Data URL using `FileReader`, strips the `data:...;base64,` prefix
- Calls the `/uploadAccidentFile(...)` unbound OData action via `oModel.bindContext`
- Shows a `BusyIndicator` while uploading, shows a `MessageToast` on success, `MessageBox.error` on failure
- Calls `oModel.refresh()` after success so the table reloads

**`onDeleteAttachment`:**
- Reads the selected row from the attachments table using `getSelectedItems()` on the inner table
- Shows a confirmation `MessageBox` naming the file to be deleted
- On confirmation, calls the `/deleteAccidentFile(...)` unbound OData action
- Refreshes the model on success

Both handlers use a `resolveAccidentState` helper that walks the component tree to find the current Accident's binding context, with a fallback to the SAP UI5 element registry. This is necessary because Fiori Elements passes action arguments differently depending on whether the button is in the toolbar or a table column.

### 7. UI Controller Wrapper — `app/accident-management/webapp/ext/controller/AccidentObjectPageExt.controller.js`

**New file.** The standard SAP Fiori Elements `ControllerExtension` wrapper that registers `AccidentObjectPageExt.js` as the extension for the Accident Object Page:

```javascript
return ControllerExtension.extend(
    "ns.accidentmanagement.accidentmanagement.ext.controller.AccidentObjectPageExt",
    Object.assign({ override: { onAfterRendering: function() {} } },
                  AccidentObjectPageExt)
);
```

### 8. `manifest.json`

The controller extension was registered and two custom toolbar actions were wired into the `attachments` table's `controlConfiguration`:

```json
"CustomUploadAttachment": {
    "press": "...AccidentObjectPageExt.onUploadAttachment",
    "text": "Upload Attachment",
    "visible": "{= ${ui>/editMode} === 'Editable' }"
},
"CustomDeleteAttachment": {
    "press": "...AccidentObjectPageExt.onDeleteAttachment",
    "text": "Delete Attachment",
    "visible": "{= ${ui>/editMode} === 'Editable' }",
    "requiresSelection": true
}
```

Both buttons are only visible when the page is in edit mode.

---

## How the Draft Lifecycle Works

Understanding why uploads always go to the draft table is important for maintaining this code.

```
User opens Accident in Edit mode
        │
        ▼
CAP creates a draft shadow (IsActiveEntity=false)
UI reads from the DRAFT table
        │
User clicks "Upload Attachment"
        │
        ▼
File → Cloudinary
Row inserted into DRAFT table (IsActiveEntity=false)
UI table refreshes → file appears immediately
        │
        ├── User clicks Save (draftActivate)
        │       │
        │       ▼
        │   beforeDraftActivate fires
        │   Draft attachment rows copied → ACTIVE table (IsActiveEntity=true)
        │   Draft rows deleted
        │   CAP activates the Accident draft
        │   UI switches to IsActiveEntity=true view → files still visible
        │
        └── User clicks Discard (draftCancel)
                │
                ▼
            beforeDraftCancel fires
            Files deleted from Cloudinary
            Draft attachment rows deleted from DB
            Draft Accident discarded by CAP
```

A key design decision: uploads during **create** flow also go to the draft table, because a brand-new Accident is always in draft state until first Save. The same code path handles both cases.

---

## Environment Variables Required

```
CLOUDINARY_CLOUD_NAME=your_cloud_name
CLOUDINARY_API_KEY=your_api_key
CLOUDINARY_API_SECRET=your_api_secret
```

These must be set in the environment before starting the application with the `posts` profile. The `application.yaml` binds them under the `posts` profile section.

---

## File Size and Type Limits

Enforced client-side in `AccidentObjectPageExt.js`:

- **Maximum file size:** 10 MB
- **Accepted types:** `.pdf`, `.doc`, `.docx`, `.xls`, `.xlsx`, `.png`, `.jpg`, `.jpeg`, `.txt`, `.csv`

Server-side, Cloudinary enforces its own limits based on the account plan. No additional server-side type validation is currently implemented.

---

## Cloudinary Folder Structure

All uploaded files land under `accident-attachments/` in your Cloudinary media library, with the naming pattern:

```
accident-attachments/{uuid}-{sanitised-filename}
```

For example: `accident-attachments/3a7f1c2d-Police_Report.pdf`

The `accident-management` tag is applied to every upload for easy filtering in the Cloudinary dashboard.