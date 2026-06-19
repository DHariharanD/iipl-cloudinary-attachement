package inflexion.ec_master.handlers;

import java.time.Instant;
import java.util.Map;
import java.util.UUID;

import org.springframework.stereotype.Component;

import com.sap.cds.ql.Insert;
import com.sap.cds.ql.Select;
import com.sap.cds.ql.cqn.CqnAnalyzer;
import com.sap.cds.reflect.CdsModel;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;
import com.sap.cds.services.persistence.PersistenceService;

import cds.gen.resourceservices.ResourceServices_;
import cds.gen.resourceservices.ResourceCategories;
import cds.gen.resourceservices.ResourceCategories_;
import java.util.HashMap;
import cds.gen.resourceservices.ResourceCategoriesAddNodeContext;

@Component
@ServiceName(ResourceServices_.CDS_NAME)
public class ResourceServicesHandler implements EventHandler {

    private final PersistenceService db;
    private final CqnAnalyzer analyzer;

    public ResourceServicesHandler(PersistenceService db, CdsModel model) {
        this.db = db;
        this.analyzer = CqnAnalyzer.create(model);
    }

    @On(event = ResourceCategoriesAddNodeContext.CDS_NAME)
    public void addNode(ResourceCategoriesAddNodeContext context) {

        String parentIdStr = (String) analyzer
                .analyze(context.getCqn())
                .targetKeys()
                .get("ID");

        if (parentIdStr == null) {
            throw new IllegalArgumentException("Parent ID could not be determined. Action must be called on a row.");
        }

        //UUID parentId = UUID.fromString(parentIdStr);
        //String resourceTypeCode = context.getRtCode();

        String hierarchyId = db.run(
                Select.from(ResourceCategories_.class)
                        .columns(ResourceCategories.RESOURCE_HIERARCHY_ID)
                        .where(b -> b.ID().eq(parentIdStr)))
                .single(ResourceCategories.class).getResourceHierarchyId();

        String type = context.getType();
        UUID newId = UUID.randomUUID();

        ResourceCategories newChild = ResourceCategories.create();
        newChild.setId(newId.toString());
        newChild.setCreatedAt(Instant.now());
        newChild.setResourceHierarchyId(hierarchyId);
        newChild.setParentId(parentIdStr);

        if ("Resource Type".equalsIgnoreCase(type)) {

            if (context.getResourceName() == null) {
                throw new IllegalArgumentException("Resource Name is mandatory");
            }

            newChild.setName(context.getResourceName());
            newChild.setDescr(context.getResourceDescription());
            newChild.setChildType("R");

            // Set RtTypes association
            Map<String, Object> rtRef = new HashMap<>();
            rtRef.put("code", context.getRtCode());

            newChild.setResourceType(rtRef);
        } else {
            newChild.setName(context.getName());
            newChild.setDescr(context.getDescription());
            newChild.setChildType("N");
        }

        db.run(Insert.into(ResourceCategories_.class).entry(newChild));

        ResourceCategories createdEntity = db.run(
                Select.from(ResourceCategories_.class).where(b -> b.ID().eq(newId.toString())))
                .single(ResourceCategories.class);

        context.setResult(createdEntity);
        context.setCompleted();
    }
}