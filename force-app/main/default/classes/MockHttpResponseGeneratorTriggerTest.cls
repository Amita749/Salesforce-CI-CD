@isTest
global class MockHttpResponseGeneratorTriggerTest {

    global HTTPResponse respond(HTTPRequest req){
            try{
                String username = System.Label.JobDivaUsername;
                String password = System.Label.JobdivaPassword;
                String clientId = System.Label.JobDivaClientId;                
                String endpoint = 'https://api.jobdiva.com/api/authenticate?clientid='+clientId+'&username='+username+'&password='+password;    
                String body='[{"firstname":"test","lastname":"dynpro-22feb"}]';
               
               if(req.getEndpoint()==endpoint){
                    HttpResponse res= new HttpResponse();
                    res.setHeader('Content-Type','application/json');                   
                    res.setBody(body);                
                    res.setStatusCode(200);
                    System.debug('MockHttpResponseGenerator Test Class Response--->'+res);
                    return res;                
               }else{
                     Date toDate= Date.today();
                     Date fromDate= toDate.addDays(-14); 
                     String dateStr = fromDate.month() + '/' + fromDate.day() + '/' + fromDate.year();
                     String EndDateStr = toDate.month() + '/' + toDate.day() + '/' + toDate.year();
                     String endpoints ='https://api.jobdiva.com/api/bi/NewUpdatedJobRecords?fromDate='+dateStr+'&toDate='+EndDateStr+'&alternateFormat=true';
                     String bodys='{"data": [{"TITLE": "UI UX","COMPANYID": "8125908","JOBSTATUS": "FILLED","JOBID ": "21076137","MAXALLOWEDSUBMITTALS":"22","OPENINGS":"2","PAYRATEMAX":"122.00","BILLRATEMAX":"133.00","DIVISIONID":"253174","PRIORITY":"5","POSITIONTYPE":"Contract"}]}';
                        
                   HttpResponse res= new HttpResponse();
                   res.setHeader('Content-Type','application/json');                   
                   res.setBody(bodys);                        
                   res.setStatusCode(200);                        
                   return res;   
               }
        }catch(Exception ex){
                System.debug('ERROR Message>>>'+ex.getMessage()+' Error Line Number>>> '+ex.getLineNumber());
        }
            return null;
         }
    }