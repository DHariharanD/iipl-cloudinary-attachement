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
@ServiceName("BusinessPartnerServices")
public class BPHandler implements EventHandler {

    @On(event = "CREATE", entity = "BusinessPartnerServices.BusinessPartners")
    public void onCreate(CdsCreateEventContext context) {
        Map<String, Object> data = context.getCqn().entries().get(0);

        try {
            // 1. Get Destination
            HttpDestination destination = DestinationAccessor.getDestination("ITS_S4").asHttp();
            
            // ✅ Use HttpClientAccessor - it handles internal BTP proxying and cookies
            HttpClient httpClient = HttpClientAccessor.getHttpClient(destination);

            // 2. Fetch Token 
            // Added trailing slash "/" - S/4 often returns 404/403 without it on the service root
            String servicePath = "/sap/opu/odata/sap/API_BUSINESS_PARTNER/"; 
            HttpGet get = new HttpGet(destination.getUri() + servicePath);
            get.setHeader("x-csrf-token", "Fetch");

            HttpResponse getResponse = httpClient.execute(get);
            Header csrfHeader = getResponse.getFirstHeader("x-csrf-token");

            // ✅ Critical Fix: Check for null before calling .getValue()
            if (csrfHeader == null) {
                throw new RuntimeException("S/4 did not return a CSRF token. Status: " + getResponse.getStatusLine());
            }
            String csrfToken = csrfHeader.getValue();

            // 3. POST to S/4
            HttpPost post = new HttpPost(destination.getUri() + "/sap/opu/odata/sap/API_BUSINESS_PARTNER/A_BusinessPartner");
            
            String json = "{"
                + "\"BusinessPartnerCategory\":\"" + data.get("BusinessPartnerCategory") + "\","
                + "\"BusinessPartnerGrouping\":\"" + data.get("BusinessPartnerGrouping") + "\","
                + "\"FirstName\":\"" + data.get("FirstName") + "\","
                + "\"LastName\":\"" + data.get("LastName") + "\""
                + "}";

            post.setEntity(new StringEntity(json, ContentType.APPLICATION_JSON));
            post.setHeader("x-csrf-token", csrfToken);
            // HttpClientAccessor maintains the session cookies automatically

            HttpResponse response = httpClient.execute(post);

            // 4. Return result to UI
            if (response.getStatusLine().getStatusCode() == 201) {
                context.setResult(List.of(data));
            } else {
                throw new RuntimeException("S/4 Creation Failed: " + response.getStatusLine().getReasonPhrase());
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Creation failed: " + e.getMessage());
        }
    }
}
