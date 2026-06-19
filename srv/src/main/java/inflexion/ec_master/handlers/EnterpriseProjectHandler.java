package inflexion.ec_master.handlers;

import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;
import com.sap.cds.services.cds.CdsCreateEventContext;

import org.springframework.stereotype.Component;

import java.util.Map;
import java.util.List;

import com.sap.cloud.sdk.cloudplatform.connectivity.DestinationAccessor;
import com.sap.cloud.sdk.cloudplatform.connectivity.HttpDestination;
import com.sap.cloud.sdk.cloudplatform.connectivity.HttpClientAccessor;

import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.HttpResponse;
import org.apache.http.Header;

@Component
@ServiceName("ProjectServices")
public class EnterpriseProjectHandler implements EventHandler {

    @On(event = "CREATE", entity = "ProjectServices.Projects")
    public void onCreate(CdsCreateEventContext context) {

        Map<String, Object> data = context.getCqn().entries().get(0);

        try {

            // ================= DESTINATION =================
            HttpDestination destination =
                    DestinationAccessor
                            .getDestination("ITS_S4")
                            .asHttp();

            HttpClient httpClient =
                    HttpClientAccessor.getHttpClient(destination);

            // ================= FETCH CSRF TOKEN =================
            String servicePath =
                    "/sap/opu/odata/sap/API_ENTERPRISE_PROJECT_SRV/";

            HttpGet get =
                    new HttpGet(destination.getUri() + servicePath);

            get.setHeader("x-csrf-token", "Fetch");

            HttpResponse getResponse =
                    httpClient.execute(get);

            Header csrfHeader =
                    getResponse.getFirstHeader("x-csrf-token");

            if (csrfHeader == null) {
                throw new RuntimeException(
                        "CSRF Token not received from S/4"
                );
            }

            String csrfToken = csrfHeader.getValue();

            // ================= POST =================
            HttpPost post =
                    new HttpPost(
                            destination.getUri()
                                    + "/sap/opu/odata/sap/API_ENTERPRISE_PROJECT_SRV/A_EnterpriseProject"
                    );

            // ================= REQUEST BODY =================
            String json =
                    "{"
                            + "\"Project\":\"" + data.get("Project") + "\","
                            + "\"ProjectDescription\":\"" + data.get("ProjectDescription") + "\","
                            + "\"EnterpriseProjectType\":\"" + data.get("EnterpriseProjectType") + "\","
                            + "\"PriorityCode\":\"" + data.get("PriorityCode") + "\","
                            + "\"ProjectStartDate\":\"" + data.get("ProjectStartDate") + "\","
                            + "\"ProjectEndDate\":\"" + data.get("ProjectEndDate") + "\","
                            + "\"CompanyCode\":\"" + data.get("CompanyCode") + "\","
                            + "\"ProjectProfileCode\":\"" + data.get("ProjectProfileCode") + "\","
                            + "\"ProfitCenter\":\"" + data.get("ProfitCenter") + "\","
                            + "\"ResponsibleCostCenter\":\"" + data.get("ResponsibleCostCenter") + "\","
                            + "\"ProjectCurrency\":\"" + data.get("ProjectCurrency") + "\""
                            + "}";

            post.setEntity(
                    new StringEntity(
                            json,
                            ContentType.APPLICATION_JSON
                    )
            );

            post.setHeader("x-csrf-token", csrfToken);
            post.setHeader("Accept", "application/json");

            // ================= EXECUTE =================
            HttpResponse response =
                    httpClient.execute(post);

            // ================= RESPONSE =================
            int statusCode =
                    response.getStatusLine().getStatusCode();

            if (statusCode == 201 || statusCode == 200) {

                context.setResult(List.of(data));

            } else {

                throw new RuntimeException(
                        "S/4 Project Creation Failed : "
                                + response.getStatusLine()
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            throw new RuntimeException(
                    "Project Creation Failed : "
                            + e.getMessage()
            );
        }
    }
}