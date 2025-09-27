/* 
Name: JobDivaIntegration_FromSFToJobDiva.cls
Description: This class is from the JobTrigger trigger upon insert and update. It makes callouts to Jobdiva.
Date: 02 February 2024
Version: 1.0
Author: DynPro                      
*/
public class JobDivaIntegration_FromSFToJobDiva {   
    
    @future(callout=true)
    public static void createJobInJobDiva(Set<Id> setOfIdsToCreate){ 
        List<ErrorLog__c> errorList =new List<ErrorLog__c>();
        try{
            
            String token=JobDivaAuthorization.authenticationWithJobDiva();       
            List<Job_Requisition__c> listToUpdateJobDivaIds = new List<Job_Requisition__c>();
            
            for(Job_Requisition__c jobObj:[SELECT Id,Title__c,Name,Account__c,Account__r.CompanyID__c,Contact__c,Contact__r.JobDivaContactId__c,Contact__r.FirstName,Contact__r.LastName,Opportunity__r.Owner.Name,Description__c,Submittal_Date__c,
                                           JoDiva_Job_Id__c,Optional_Ref__c,Job_Type__c,Status__c,Start_Date__c,End_Date__c,Division__c,
                                           MaxAllowedSubmittal__c,Priority__c,ExperienceLevel__c,Openings__c,AddressLine1__c,AddressLine2__c,City__c,
                                           Country__c,State__c,Zipcode__c,MinBillRate__c, MaxBillRate__c,BillRateUnit__c, MinPayRate__c, MaxPayRate__c,PayRateUnit__c
                                           FROM Job_Requisition__c where Id IN:setOfIdsToCreate])
            {       
                Http http = new Http();
                HttpRequest req = new HttpRequest();
                Integer status;
                String endpoint = 'https://api.jobdiva.com/api/jobdiva/createJob';
                if(jobObj.Status__c.equalsIgnoreCase('OPEN')){
                    status=0;
                }
                else if(jobObj.Status__c.equalsIgnoreCase('ON HOLD')){
                    status=1;
                } 
                String companyId;
                Integer accid;
                if(String.IsNotBlank(jobObj.Account__r.CompanyID__c)){
                    companyId=jobObj.Account__r.CompanyID__c;
                    accid=Integer.valueOf(jobObj.Account__r.CompanyID__c);
                }
                
                
                System.debug('companyId--->'+companyId);                 
                
                Map<String, Object> contactMapBody= new Map<String, Object>();
                              
                contactMapBody.put('action',0);
                contactMapBody.put('contactId',jobObj.Contact__r.JobDivaContactId__c);
                contactMapBody.put('roleId', 0);
                contactMapBody.put('showOnJob',true);
                
                String jsonRequestBody = JSON.serialize(contactMapBody);
                System.debug('jsonRequestBody-->'+jsonRequestBody);
                String dateStart;
                if(jobObj.Start_Date__c !=null){
                   dateStart = jobObj.Start_Date__c.month() + '/' + jobObj.Start_Date__c.day() + '/' + jobObj.Start_Date__c.year(); 
                }
                String dateEnd;
                if(jobObj.End_Date__c !=null){
                   dateEnd = jobObj.End_Date__c.month() + '/' + jobObj.End_Date__c.day() + '/' + jobObj.End_Date__c.year();
                }
                String submitaldate=jobObj.Submittal_Date__c.month()+ '/' + jobObj.Submittal_Date__c.day() + '/' + jobObj.Submittal_Date__c.year();
                String body='title='+jobObj.Title__c+'&description='+jobObj.Description__c+'&status='+status+'&jobtype='+jobObj.Job_Type__c;
                body+='&priority='+jobObj.Priority__c+'&divisionid='+jobObj.Division__c+'&contacts='+jsonRequestBody;
                
                if(accid !=null){
                   body+='&companyid='+accid;
                }
                if(String.IsNotBlank(dateStart)){
                   body+='&startdate='+dateStart; 
                }
                if(String.IsNotBlank(dateEnd)){
                    body+='&enddate='+dateEnd;
                }
                if(jobObj.MaxBillRate__c !=null){
                    body+='&maxbillrate='+jobObj.MaxBillRate__c;
                }
                if(jobObj.MinBillRate__c !=null){
                    body+='&minbillrate='+jobObj.MinBillRate__c;
                }
                if(String.IsNotBlank(jobObj.BillRateUnit__c)){
                    body+='&billrateunit='+jobObj.BillRateUnit__c;
                }
                if(jobObj.MaxPayRate__c !=null){
                    body+='&maxpayrate='+jobObj.MaxPayRate__c;
                }
                if(jobObj.MinPayRate__c !=null){
                    body+='&minpayrate='+jobObj.MinPayRate__c;
                }
               if(String.IsNotBlank(jobObj.PayRateUnit__c)){
                    body+='&payrateunit='+jobObj.PayRateUnit__c;
                }
                if(jobObj.MaxAllowedSubmittal__c !=null){
                    body+='&maxsubmittals='+jobObj.MaxAllowedSubmittal__c;
                }
                if(String.IsNotBlank(jobObj.ExperienceLevel__c)){
                     body+='&experience='+jobObj.ExperienceLevel__c;
                }
                if(jobObj.Openings__c !=null){
                      body+='&openings='+jobObj.Openings__c;
                }
                if(String.IsNotBlank(jobObj.AddressLine1__c)){
                      body+='&address1='+jobObj.AddressLine1__c;
                }
                if(String.IsNotBlank(jobObj.City__c)){
                      body+='&city='+jobObj.City__c;
                }
                if(String.IsNotBlank(jobObj.State__c)){
                      body+='&state='+jobObj.State__c;
                }
                if(String.IsNotBlank(jobObj.Zipcode__c)){
                      body+='&zipcode='+jobObj.Zipcode__c;
                }
                if(String.IsNotBlank(jobObj.Country__c)){
                      body+='&countryid='+jobObj.Country__c;
                }
                System.debug('body-->'+body);
                req.setBody(body);
                req.setEndpoint(endpoint);
                req.setMethod('POST');
                req.setHeader('Authorization', token);
                req.setHeader('Content-Type','application/x-www-form-urlencoded'); 
               
                HTTPResponse res = http.send(req);   
                jobObj.JoDiva_Job_Id__c=res.getbody();
                // get reponse from job diva with another api and update in same update call.
                System.debug('create response--->'+res.getbody());
                listToUpdateJobDivaIds.add(jobObj);                
                System.debug('listToUpdateJobDivaIds '+ listToUpdateJobDivaIds);             
           }
            if(!listToUpdateJobDivaIds.IsEmpty()){
                update listToUpdateJobDivaIds;
            } 
		   	
        }    
        catch(Exception ex) {            
            ErrorHandler.addError(ex,'createJobInJobDiva','JobDivaIntegration_FromSFToJobDiva', errorList, true); 
            
        }	
    }
    
    @future(callout=true)     
    public static void updateJobInJobDiva(Set<Id> setOfIdsToUpdate){
       
        List<ErrorLog__c> errorList =new List<ErrorLog__c>();
        try{
            
            String token=JobDivaAuthorization.authenticationWithJobDiva();     
            for(Job_Requisition__c jobObj:[SELECT Id,Title__c,Name,Account__c,Account__r.CompanyID__c,Contact__c,Contact__r.JobDivaContactId__c,Contact__r.FirstName,Contact__r.LastName,Opportunity__r.Owner.Name,Description__c,Submittal_Date__c,
                                           JoDiva_Job_Id__c,Job_Type__c,Status__c,Start_Date__c,End_Date__c,Division__c,
                                           MaxAllowedSubmittal__c,Priority__c,ExperienceLevel__c,Openings__c,AddressLine1__c,AddressLine2__c,City__c,
                                           Country__c,State__c,Zipcode__c,MinBillRate__c, MaxBillRate__c,MaxPayRate__c, MinPayRate__c,Fills__c
                                           FROM Job_Requisition__c where Id IN:setOfIdsToUpdate])
            {   
                if(jobObj.JoDiva_Job_Id__c !=null)
                {  
                    Http http = new Http();
                    HttpRequest req = new HttpRequest();
                    Integer status;
                    String endpoint = 'https://api.jobdiva.com/api/jobdiva/updateJob?jobid='+jobObj.JoDiva_Job_Id__c;            
                    if(jobObj.Status__c.equalsIgnoreCase('OPEN')){
                        status=0;
                    }
                    else if(jobObj.Status__c.equalsIgnoreCase('ON HOLD')){
                        status=1;
                    } 
                    else if(jobObj.Status__c.equalsIgnoreCase('FILLED')){
                        status=2;
                    }else if(jobObj.Status__c.equalsIgnoreCase('CANCELLED')){
                        status=3;
                    }
                    else if(jobObj.Status__c.equalsIgnoreCase('CLOSED')){
                        status=4;
                    }
                    else if(jobObj.Status__c.equalsIgnoreCase('EXPIRED')){
                        status=5;
                    }
                    else if(jobObj.Status__c.equalsIgnoreCase('IGNORED')){
                        status=6;
                    }
                    String companyId;
                    Integer accid;
                    if(String.IsNotBlank(jobObj.Account__r.CompanyID__c)){
                        companyId=jobObj.Account__r.CompanyID__c;
                        accid=Integer.valueOf(jobObj.Account__r.CompanyID__c);
                    }
                    System.debug('companyId--->'+companyId);
                    Map<String, Object> contactMapBody= new Map<String, Object>();                                  
                    
                    contactMapBody.put('action',1);
                    contactMapBody.put('contactId',jobObj.Contact__r.JobDivaContactId__c);
                    contactMapBody.put('roleId', 0);
                    contactMapBody.put('showOnJob',true);
                    
                    String jsonRequestBody = JSON.serialize(contactMapBody);
                    System.debug('jsonRequestBody-->'+jsonRequestBody);
                                        
                    String dateStart;
                    if(jobObj.Start_Date__c !=null){
                       dateStart = jobObj.Start_Date__c.month() + '/' + jobObj.Start_Date__c.day() + '/' + jobObj.Start_Date__c.year(); 
                    }
                    String dateEnd;
                    if(jobObj.End_Date__c !=null){
                       dateEnd = jobObj.End_Date__c.month() + '/' + jobObj.End_Date__c.day() + '/' + jobObj.End_Date__c.year();
                    }
                    String submitaldate=jobObj.Submittal_Date__c.month()+ '/' + jobObj.Submittal_Date__c.day() + '/' + jobObj.Submittal_Date__c.year();
                    String body='title='+jobObj.Title__c+'&description='+jobObj.Description__c+'&status='+status+'&jobtype='+jobObj.Job_Type__c;
                    body+='&priority='+jobObj.Priority__c+'&contacts='+jsonRequestBody;
                    body+='&divisionid='+jobObj.Division__c; 
                    
                    if(accid !=null){
                      body+='&companyid='+accid;
                    }
                    if(String.IsNotBlank(dateStart)){
                        body+='&startdate='+dateStart; 
                    }
                    if(String.IsNotBlank(dateEnd)){
                        body+='&enddate='+dateEnd;
                    }
                    if(jobObj.MaxBillRate__c !=null){
                        body+='&maxbillrate='+jobObj.MaxBillRate__c;
                    }
                    if(jobObj.MinBillRate__c !=null){
                        body+='&minbillrate='+jobObj.MinBillRate__c;
                    }
                    if(jobObj.MaxPayRate__c !=null){
                        body+='&maxpayrate='+jobObj.MaxPayRate__c;
                    }
                    if(jobObj.MinPayRate__c !=null){
                        body+='&minpayrate='+jobObj.MinPayRate__c;
                    }
                    if(jobObj.MaxAllowedSubmittal__c !=null){
                        body+='&maxsubmittals='+jobObj.MaxAllowedSubmittal__c;
                    }
                    if(String.IsNotBlank(jobObj.ExperienceLevel__c)){
                        body+='&experience='+jobObj.ExperienceLevel__c;
                        System.debug('Inside Experience level-->'+jobObj.ExperienceLevel__c);
                    }                   
                    if(jobObj.Openings__c !=null){
                        body+='&openings='+jobObj.Openings__c;
                    }
                    if(jobObj.Fills__c !=null){
                        body+='&fills='+jobObj.Fills__c;
                    }
                    if(String.IsNotBlank(jobObj.AddressLine1__c)){
                        body+='&address1='+jobObj.AddressLine1__c;
                    }
                    if(String.IsNotBlank(jobObj.City__c)){
                        body+='&city='+jobObj.City__c;
                    }
                    if(String.IsNotBlank(jobObj.State__c)){
                        body+='&state='+jobObj.State__c;
                    }
                    if(String.IsNotBlank(jobObj.Zipcode__c)){
                        body+='&zipcode='+jobObj.Zipcode__c;
                    }
                    if(String.IsNotBlank(jobObj.Country__c)){
                        body+='&countryid='+jobObj.Country__c;
                    }
                    System.debug('body-->'+JSON.serialize(body));
                    
                    req.setBody(body);
                    req.setEndpoint(endpoint);
                    req.setMethod('POST');
                    req.setHeader('Authorization', token);
                    req.setHeader('Content-Type','application/x-www-form-urlencoded');             
                   
                    HTTPResponse res = http.send(req);               
                   
                    System.debug('update Response Body==> '+res.getBody()); 
                }   
            }    
        }           
        catch(Exception ex) {  
             ErrorHandler.addError(ex,'updateJobInJobDiva','JobDivaIntegration_FromSFToJobDiva', errorList,true);                      
        }    	
    }
}