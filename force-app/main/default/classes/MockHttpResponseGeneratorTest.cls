@isTest
    global class MockHttpResponseGeneratorTest implements HttpCalloutMock {
        global Boolean ifcreate;
        @TestVisible MockHttpResponseGeneratorTest(Boolean ifcreate){
            this.ifcreate=ifcreate;
        }
        global HTTPResponse respond(HTTPRequest req){
            try{
                String searchcompanyEndpoint='https://api.jobdiva.com/api/jobdiva/searchCompany?company=Cisco india';
                String createcompanyEndpoint='https://api.jobdiva.com/api/jobdiva/createCompany';
                String username = System.Label.JobDivaUsername;
                String password = System.Label.JobdivaPassword;
                String clientId = System.Label.JobDivaClientId;                
                String endpoint = 'https://api.jobdiva.com/api/authenticate?clientid='+clientId+'&username='+username+'&password='+password;    
                String body='[{"firstname":"test","lastname":"dynpro-22feb"}]';
                
               System.debug('Endpoint--->'+req.getEndpoint());
                System.debug('ifcreate--->'+ifcreate);
               if(req.getEndpoint()==endpoint){
                    HttpResponse res= new HttpResponse();
                    res.setHeader('Content-Type','application/json');                   
                    res.setBody(body);                
                    res.setStatusCode(200);                  
                    return res;                
               }else if(req.getEndpoint() == searchcompanyEndpoint){ 
                   System.debug('inside searchcompanyEndpoint if');
                   String endpoints=searchcompanyEndpoint;                   
                   String bodys='[{"id":9378125,"name":"Cisco india","address1":"suit 500,","address2":null,"city":"Loss Angeles","state":"CA","zipcode":"3842","country":"United sates","phone":"9347833","fax":"33489","email":"sangetac350@gmail.com","url":"www.test.com","company types":"Supplier"}]';
                   
                   HttpResponse res= new HttpResponse();
                   res.setBody(bodys);
                   res.setHeader('Content-Type','application/json'); 
                   if(ifcreate)
                     res.setStatusCode(400);
                   else
                     res.setStatusCode(200); 
                   return res;   
               }else if(req.getEndpoint() == createcompanyEndpoint){ 
                   System.debug('inside createcompanyEndpoint if');
                   System.debug('createcompanyEndpoint-->'+createcompanyEndpoint);
                   String endpoints=createcompanyEndpoint;                   
                   String bodys='&companyname=Test+India&url=www.testingapril.com&email=test%40gmail.com&';
                   
                   HttpResponse res= new HttpResponse();
                   res.setBody(bodys);
                   res.setHeader('Content-Type','application/json');
                   res.setStatusCode(200);                        
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