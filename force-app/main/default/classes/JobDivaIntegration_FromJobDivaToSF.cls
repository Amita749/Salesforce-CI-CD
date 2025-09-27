/* 
Name: JobDivaIntegration_FromJobDivaToSF.cls
Description: Batch class to get the updates from JobDiva.
Date: 02 February 2024
Version: 1.0
Author: DynPro                       
*/

global class JobDivaIntegration_FromJobDivaToSF implements Database.batchable<JobDivaWrapper.Data>, Database.Stateful,Database.AllowsCallouts,Schedulable {
    //Added two constructors,one to run without any parameters and one to run with parameter dates if needed
    
    global Date toDate= Date.today();
    global Date fromDate= toDate.addDays(-14); 
    
    global JobDivaIntegration_FromJobDivaToSF() {}
    global JobDivaIntegration_FromJobDivaToSF(Date fromDate, Date toDate) {
        this.fromDate = fromDate;
        this.toDate=toDate;
        /*DisabledTrigger__c obj = new DisabledTrigger__c();
        DisabledTrigger__c objRec = DisabledTrigger__c.getInstance(); 
        //obj.Id=objRec.Id;
        obj.IsActive__c = false;
        //update obj;*/
    }
    
    global Iterable<JobDivaWrapper.Data> start(Database.BatchableContext BC) {
        List<ErrorLog__c> errorList =new List<ErrorLog__c>();
        try{
            String token = JobDivaAuthorization.authenticationWithJobDiva();
            Http http = new Http();
            HttpRequest req = new HttpRequest();
            HTTPResponse res = new HTTPResponse();
            
            String dateStr = fromDate.month() + '/' + fromDate.day() + '/' + fromDate.year();
            String EndDateStr = toDate.month() + '/' + toDate.day() + '/' + toDate.year();
            String endpoint = 'https://api.jobdiva.com/api/bi/NewUpdatedJobRecords?fromDate='+dateStr+'&toDate='+EndDateStr+'&alternateFormat=true';
            req.setEndpoint(endpoint);
            req.setMethod('GET');
            req.setHeader('Authorization', token);        
            res = http.send(req);
            
            System.debug('Response Status Code==> '+res.getStatusCode());
            System.debug('Response Status==> '+res.getStatus());
            System.debug('Response Body==> '+res.getBody());
            
            JobDivaWrapper jobDetail = (JobDivaWrapper) JSON.deserialize(res.getBody(), JobDivaWrapper.class);
            return jobDetail.data;
        }
        catch(Exception ex) {  
            ErrorHandler.addError(ex,'start','JobDivaIntegration_FromJobDivaToSF',errorList, true);
            throw new DMLException(' ' +ex.getMessage());           
        }
    }

    global void execute(Database.BatchableContext BC, List<JobDivaWrapper.Data> listOfJobRecords) {
        List<ErrorLog__c> errorList =new List<ErrorLog__c>();
        try{
            Map<String,Id> mapOfIdByJobDivaId = new Map<String,Id>();
            Map<String,String> mapOfAccCompanyId = new Map<String,String>();
            Map<String,String> mapOfContactId = new Map<String,String>();
            List<Job_Requisition__c> listToUpdate = new List<Job_Requisition__c>();
            Set<Id> setOfJobDivaIds = new Set<Id>();
			
            for(Job_Requisition__c jobObj:[SELECT Id, Name,Account__c,Account__r.CompanyID__c,Contact__c,Contact__r.JobDivaContactId__c,Description__c,JoDiva_Job_Id__c,Status__c 
                                           FROM Job_Requisition__c]){
                mapOfIdByJobDivaId.put(jobObj.JoDiva_Job_Id__c,jobObj.Id);
                mapOfAccCompanyId.put(jobObj.Account__r.CompanyID__c,jobObj.Account__c);
                mapOfContactId.put(jobObj.Contact__r.JobDivaContactId__c,jobObj.Contact__c);                               
            }
        
            for(JobDivaWrapper.Data Obj: listOfJobRecords){
                Job_Requisition__c jobObj = new Job_Requisition__c();                          
                
                if(!mapOfIdByJobDivaId.isEmpty() && mapOfIdByJobDivaId.containsKey(Obj.JOBID)){  
                    String priority;
                    if(obj.PRIORITY =='Normal'){
                        priority=String.valueOf(5);                        
                    }else if(obj.PRIORITY =='Low Priority'){
                        priority=String.valueOf(7);
                    }
                    else if(obj.PRIORITY =='Top Priority'){
                        priority=String.valueOf(6);
                    }
                    else if(obj.PRIORITY =='Red Hot'){
                        priority=String.valueOf(8);
                    }
                    if(!mapOfAccCompanyId.IsEmpty() && mapOfAccCompanyId.ContainsKey(Obj.COMPANYID)){
                          jobObj.Account__c=mapOfAccCompanyId.get(Obj.COMPANYID);  
                    }
                    if(!mapOfContactId.IsEmpty() && mapOfContactId.ContainsKey(Obj.CONTACTID)){
                          jobObj.Contact__c=mapOfContactId.get(Obj.CONTACTID);  
                    }
                   /* DateTime dateStart = (DateTime)Json.deserialize('"'+obj.STARTDATE+'"', DateTime.class);
                    DateTime dateEnd = (DateTime)Json.deserialize('"'+obj.ENDDATE+'"', DateTime.class);
                    Datetime startDate = DateTime.parse(obj.STARTDATE);
                    Datetime endDate= DateTime.parse(obj.ENDDATE);
                    System.debug('startdate-->'+startDate+'enddate-->'+endDate);*/
                    
                    jobObj.Id=mapOfIdByJobDivaId.get(Obj.JOBID);    
                    jobObj.Title__c=Obj.TITLE;
                    jobObj.Status__c=Obj.JOBSTATUS;
                    jobObj.JoDiva_Job_Id__c=obj.JOBID;
                    jobObj.Optional_Ref__c=obj.OPTIONALREFERENCENO;
                    jobObj.MaxAllowedSubmittal__c=Integer.valueOf(!String.isEmpty(obj.MAXALLOWEDSUBMITTALS) ? obj.MAXALLOWEDSUBMITTALS : '0');
                    jobObj.Openings__c=Integer.ValueOf(!String.isEmpty(obj.OPENINGS) ? obj.OPENINGS : '0');
                    jobObj.Fills__c=Integer.ValueOf(!String.isEmpty(obj.FILLS) ? obj.FILLS : '0');
                    jobObj.MaxBillRate__c=Decimal.valueOf(!String.isEmpty(obj.BILLRATEMAX) ? obj.BILLRATEMAX : '0');
                    jobObj.MinBillRate__c=Decimal.valueOf(!String.isEmpty(obj.BILLRATEMIN) ? obj.BILLRATEMIN : '0');
                    jobObj.MaxPayRate__c=Decimal.valueOf(!String.isEmpty(obj.PAYRATEMAX) ? obj.PAYRATEMAX : '0');
                    jobObj.MinPayRate__c=Decimal.valueOf(!String.isEmpty(obj.PAYRATEMIN) ? obj.PAYRATEMIN : '0'); 
                    jobObj.Division__c=obj.DIVISIONID;                   
                    jobObj.Priority__c=priority;
                    jobObj.Job_Type__c=obj.POSITIONTYPE;
                    //jobObj.Start_Date__c=dateStart;
                    //jobObj.End_Date__c=dateEnd;
                    listToUpdate.add(jobObj); 
                    System.debug('job obj records-->'+jobObj); 
                } 
               
            } 
            System.debug('list to update-->'+listToUpdate.size());
            if(!listToUpdate.isEmpty()){   
                Database.SaveResult[] srList = Database.update(listToUpdate, false);
                for (Database.SaveResult sr : srList) {
                    if (sr.isSuccess()) {
                        // Operation was successful, so get the ID of the record that was processed
                        System.debug('Successfully Updated JobRec ID: ' + sr.getId());
                    }else {
                            // Operation failed, so get all errors                
                            for(Database.Error err : sr.getErrors()) {
                                System.debug('The following error has occurred.');                    
                                System.debug(err.getStatusCode() + ': ' + err.getMessage());
                                System.debug('JobRec fields that affected this error: ' + err.getFields());
                            }
    				}                 
              }
        }
        }catch(Exception ex) {
            ErrorHandler.addError(ex,'execute','JobDivaIntegration_FromJobDivaToSF',errorList, true);                    
        }      
    }
    
    global void finish(Database.BatchableContext BC) 
    {       

    }
    global void execute(SchedulableContext SC){
        JobDivaIntegration_FromJobDivaToSF obj = new JobDivaIntegration_FromJobDivaToSF();
        database.executebatch(obj,20);
    }
}