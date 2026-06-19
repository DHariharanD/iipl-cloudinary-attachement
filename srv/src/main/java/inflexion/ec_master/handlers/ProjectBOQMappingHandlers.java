// package inflexion.ec_master.handlers;

// import cds.gen.projectboqmappingservice.ProjectBOQMapping;
// import cds.gen.projectboqmappingservice.ProjectBOQMapping_;
// import cds.gen.projectboqmappingservice.ProjectPlanning_;
// import com.sap.cds.ql.Select;
// import com.sap.cds.ql.cqn.CqnAnalyzer;
// import com.sap.cds.reflect.CdsModel;
// import com.sap.cds.services.cds.CdsReadEventContext;
// import com.sap.cds.services.cds.CqnService;
// import com.sap.cds.services.handler.EventHandler;
// import com.sap.cds.services.handler.annotations.On;
// import com.sap.cds.services.handler.annotations.ServiceName;
// import com.sap.cds.services.persistence.PersistenceService;
// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.stereotype.Component;

// @Component
// @ServiceName("ProjectBOQMappingService")
// public class ProjectBOQMappingHandlers implements EventHandler {

//     @Autowired
//     PersistenceService db;

//     @Autowired
//     CdsModel model;

//     @On(event = CqnService.EVENT_READ, entity = ProjectBOQMapping_.CDS_NAME)
//     public void onReadProjectBOQMapping(CdsReadEventContext context) {

//         System.out.println(">>> ProjectBOQMapping READ HANDLER START");

//         // Read by key (if UI requests a single record)
//         CqnAnalyzer analyzer = CqnAnalyzer.create(model);
//         Object mappingIdObj = analyzer.analyze(context.getCqn())
//                                       .targetKeys()
//                                       .get(ProjectBOQMapping.ID);

//         if (mappingIdObj != null) {
//             String mappingId = mappingIdObj.toString();

//             // Safe read of the mapping
//             ProjectBOQMapping mapping = db.run(
//                     Select.from(ProjectBOQMapping_.class)
//                           .columns(m -> m._all()) // just fetch all columns
//                           .where(m -> m.ID().eq(mappingId))
//             ).first(ProjectBOQMapping.class).orElse(null);

//             context.setResult(mapping != null ? java.util.Collections.singletonList(mapping) : java.util.Collections.emptyList());
//         } else {
//             // Default read for collection
//             context.setResult(db.run(context.getCqn()));
//         }

//         System.out.println(">>> ProjectBOQMapping READ HANDLER END");
//     }
// }