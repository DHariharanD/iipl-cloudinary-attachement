package inflexion.ec_master.external;

import com.sap.cds.services.handler.EventHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import com.sap.cds.services.cds.CdsReadEventContext;
import com.sap.cds.services.cds.CqnService;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;
import com.sap.cds.Result;

import cds.gen.projectservice.ProjectService_;
import cds.gen.projectservice.Projectsec_;

@Component
@ServiceName("ProjectService")
public class ProjectHandler implements EventHandler {

    @Autowired
    @Qualifier("API_ENTERPRISE_PROJECT_SRV")
    CqnService remoteService;

    @On(event = CqnService.EVENT_READ, entity = "ProjectService.Projectsec")
    public void getProjects(CdsReadEventContext context) {
        context.setResult(remoteService.run(context.getCqn()));
    }

    @On(event = CqnService.EVENT_READ, entity = "ProjectService.ProjectElement")
    public void getProjectElements(CdsReadEventContext context) {
        // This handles both direct reads and navigation from Projectsec
        context.setResult(remoteService.run(context.getCqn()));
    }
}