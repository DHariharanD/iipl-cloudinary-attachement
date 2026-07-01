# Accident Attachments — Cloudinary Integration

## Overview

This repository now includes a working attachment flow for the Accident Management app. Users can upload accident-related files, preview or download them, and delete them again. Files are stored in Cloudinary, while the attachment metadata is saved in the CAP service layer and exposed through the Fiori UI.

The current implementation is centered around the Accident Management UI, the CAP service, and the Java handler layer that connects the app to Cloudinary.

---

## What changed in the current implementation

The main work completed in this repo includes:

- A new attachment entity and metadata fields in the schema
- Custom OData actions for upload and delete
- A Java handler that calls the Cloudinary SDK
- UI annotations for the attachments table
- A Fiori extension for upload, delete, preview, and download actions
- Manifest wiring for the new toolbar and action column

---

## 1. Schema changes

The schema is defined in [db/vehiclemanagement/accident-management.cds](db/vehiclemanagement/accident-management.cds).

The Accident entity already exposes an attachments composition, and the attachment entity now carries the fields needed for Cloudinary integration:

```cds
entity AccidentAttachments : cuid, managed {
    accident     : Association to Accident;
    fileName     : String(255);
    mediaType    : String(100);
    url          : String(500);
    fileSize     : Integer64;
    publicId     : String(500);
    description  : String(500);
}
```

This allows the app to keep the Cloudinary URL, public ID, file size, and an optional description alongside the standard managed fields.

---

## 2. Service layer changes

The service contract is defined in [srv/accident-management-service.cds](srv/accident-management-service.cds).

Two custom OData actions were added to the Accident service:

```cds
action uploadAccidentFile(
    accident_ID : UUID,
    fileName    : String(255),
    mediaType   : String(100),
    content     : LargeString,
    description : String(500)
) returns AccidentAttachments;

action deleteAccidentFile(
    attachment_ID : UUID
);
```

The Accident service is also enabled for drafts through the CAP draft mechanism.

---

## 3. Backend handler

The core backend logic is implemented in [srv/src/main/java/inflexion/ec_master/handlers/AccidentAttachmentHandler.java](srv/src/main/java/inflexion/ec_master/handlers/AccidentAttachmentHandler.java).

The handler currently covers:

- Uploading a file from the UI as base64 content
- Sending the file to Cloudinary
- Saving the resulting metadata to the attachment entity
- Deleting the Cloudinary object and the DB row when an attachment is removed

The handler validates the incoming parameters, resolves the accident context, and returns the created attachment metadata to the UI.

---

## 4. Cloudinary integration

The Cloudinary SDK wrapper is implemented in [srv/src/main/java/inflexion/ec_master/external/CloudinaryService.java](srv/src/main/java/inflexion/ec_master/external/CloudinaryService.java).

It currently provides:

- Upload support using the Cloudinary Java SDK
- Public ID generation with a UUID-based naming strategy
- Folder handling based on the accident vehicle number
- Resource type selection based on the provided MIME type
- Deletion support that tries the common Cloudinary resource types

The service expects these environment variables:

```text
CLOUDINARY_CLOUD_NAME
CLOUDINARY_API_KEY
CLOUDINARY_API_SECRET
```

---

## 5. UI annotations and table behavior

The UI annotations are in [app/accident-management/annotations.cds](app/accident-management/annotations.cds).

The attachments table now exposes:

- File name
- Description
- Uploaded date
- Uploaded by

The technical fields such as public ID, file size, and URL are hidden from the UI and are used internally for storage and deletion logic.

---

## 6. Fiori UI extension

The main UI logic is in [app/accident-management/webapp/ext/controller/AccidentObjectPageExt.js](app/accident-management/webapp/ext/controller/AccidentObjectPageExt.js).

It provides:

- Upload action for selecting and sending files to the backend
- Delete action for removing the selected attachment
- Preview action for opening supported files in a browser tab
- Download action for saving files locally with the correct extension

### Current client-side limits

- Maximum file size: 10 MB
- Accepted file types: .pdf, .doc, .docx, .xls, .xlsx, .png, .jpg, .jpeg, .txt, .csv

The upload flow includes a confirmation dialog where the user can add a short description before sending the file.

---

## 7. Action buttons and manifest wiring

The controller wrapper is in [app/accident-management/webapp/ext/controller/AccidentObjectPageExt.controller.js](app/accident-management/webapp/ext/controller/AccidentObjectPageExt.controller.js), and the action fragment is in [app/accident-management/webapp/ext/fragment/AttachmentActionsColumn.fragment.xml](app/accident-management/webapp/ext/fragment/AttachmentActionsColumn.fragment.xml).

The manifest in [app/accident-management/webapp/manifest.json](app/accident-management/webapp/manifest.json) wires the new toolbar actions into the attachments table and registers the controller extension for the Object Page flow.

---

## 8. Current behavior summary

When a user uploads an attachment:

1. The file is selected in the UI.
2. The file is read as base64 and sent to the upload action.
3. The backend uploads it to Cloudinary.
4. The Cloudinary URL and metadata are stored in the attachment entity.
5. The attachments table is refreshed so the new file appears immediately.

When a user deletes an attachment:

1. The selected row is identified.
2. The backend deletes the Cloudinary object using the stored public ID.
3. The attachment record is removed from the service data.
4. The model is refreshed.

---

## Cloudinary storage pattern

Uploaded files are stored under a Cloudinary path that follows this pattern:

```text
accident-attachments/<vehicleNo>/<uuid>-<sanitised-file-name>
```

All uploads are tagged with the label accident-management for easier identification in the Cloudinary dashboard.

---

## How to run locally

1. Set the required Cloudinary environment variables before starting the app at .env / default-env.json in root / srv:

```text
CLOUDINARY_CLOUD_NAME=your_cloud_name
CLOUDINARY_API_KEY=your_api_key
CLOUDINARY_API_SECRET=your_api_secret
```

These values are required by the Cloudinary service so uploads can be sent to your Cloudinary account.

2. Install the Node.js dependencies:

```bash
npm install
```

This installs the frontend and CAP-related packages used by the project.

3. Build the CAP project:

```bash
cds build
```

This compiles the CAP application artifacts and prepares the project for deployment and runtime.

4. Build the Java service:

```bash
mvn clean install -DskipTests
```

This compiles the Java backend, packages it, and installs the build output without running tests.

5. Compile the Java sources again if needed:

```bash
mvn compile
```

This runs a direct Java compilation step and is useful when you want a quick rebuild.

6. Deploy the CAP model and database artifacts:

```bash
cds deploy
```

This applies the CDS model changes and deploys the relevant database/service artifacts.

7. Start the backend service with CAP watch:

```bash
mvn cds:watch
```

This runs the service in development mode and watches for changes.

Alternatively, you can start the Spring Boot app directly:

```bash
mvn spring-boot:run
```

8. Open the app and navigate to the Accident Management Object Page to test upload, preview, download, and delete actions.
