/* 
Name: JobDivaAuthorization.cls
Description: This class contains logic to authenticate with JobDiva and return the token which is required for all the other API callouts to JobDiva.
Date: 02 February 2024
Version: 1.0
Author: Minal Patil                       
*/

public class JobDivaAuthorization{
   
	public static String authenticationWithJobDiva(){
    	try{
            String token;
            Http http = new Http();
            HttpRequest req = new HttpRequest();
            String username = System.Label.JobDivaUsername;
            String password = System.Label.JobdivaPassword;
            String clientId = System.Label.JobDivaClientId;
            String endpoint = 'https://api.jobdiva.com/api/authenticate?clientid='+clientId+'&username='+username+'&password='+password;
            req.setEndpoint(endpoint);
            req.setMethod('GET');
            req.setHeader('Content-Type','application/text'); 
                   
            HTTPResponse res = http.send(req);
            System.debug('Response Status Code==> '+res.getStatusCode());
            System.debug('Response Status==> '+res.getStatus()); 
            token=res.getBody();
            if(res.getStatusCode() == 201 || res.getStatusCode() == 200){
                System.debug('Response Body==> '+res.getBody());
                token=res.getBody();               
            }else{
                System.debug('Response Body==> '+res.getBody());
            }
        	return token;
    	}    
        catch(Exception ex) {            
            throw new DMLException(' ' +ex.getMessage());           
        }   
    }
}