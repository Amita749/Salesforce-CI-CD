/* 
Name: UpdateContactFromJobDivaToSF.cls
Description: This is batch class which fetch update from jobdiva to SF and make callout.
Date: 28 February 2024
Version: 1.0
Author: DynPro                      
*/
global class UpdateCompnayFromJobDivaToSF implements Database.batchable<UpdateCompanyFromJobDivaToSFWrapper.Data>,Database.Stateful,Database.AllowsCallouts,Schedulable{
    global Date toDate= Date.today();
    global Date fromDate= toDate.addDays(-14); 
    global UpdateCompnayFromJobDivaToSF() {}
    global UpdateCompnayFromJobDivaToSF(Date fromDate, Date toDate) {
        this.fromDate = fromDate;
        this.toDate=toDate;
    }
    global Iterable<UpdateCompanyFromJobDivaToSFWrapper.Data> start(Database.BatchableContext BC) 
    {
        List<ErrorLog__c> errorList =new List<ErrorLog__c>();
        try{
            String token = JobDivaAuthorization.authenticationWithJobDiva();
            Http http = new Http();
            HttpRequest req = new HttpRequest();
            HTTPResponse res = new HTTPResponse();
            
            String dateStr = fromDate.month() + '/' + fromDate.day() + '/' + fromDate.year();
            String EndDateStr = toDate.month() + '/' + toDate.day() + '/' + toDate.year();
            String endpoint = 'https://api.jobdiva.com/api/bi/NewUpdatedCompanyRecords?fromDate='+dateStr+'&toDate='+EndDateStr+'&alternateFormat=true';
            req.setEndpoint(endpoint);
            req.setMethod('GET');
            req.setHeader('Authorization', token);        
            res = http.send(req);
            
            System.debug('Response Status Code==> '+res.getStatusCode());
            System.debug('Response Status==> '+res.getStatus());
            System.debug('Response Body==> '+res.getBody());
            
            UpdateCompanyFromJobDivaToSFWrapper companyDetail = (UpdateCompanyFromJobDivaToSFWrapper) JSON.deserialize(res.getBody(), UpdateCompanyFromJobDivaToSFWrapper.class);
            return companyDetail.data;
        }
        catch(Exception ex) {  
            ErrorHandler.addError(ex,'start','UpdateCompnayFromJobDivaToSF',errorList, true);
            throw new DMLException(' ' +ex.getMessage());           
        }
    }
    global void execute(Database.BatchableContext BC, List<UpdateCompanyFromJobDivaToSFWrapper.Data> listOfupdatedCompany) {
        
        Map<String,String> mapOfAccIds = new Map<String,String>();
        List<Account> listToUpdateAcc = new List<Account>();
        List<ErrorLog__c> errorList =new List<ErrorLog__c>();
        try
        {
            if(!listOfupdatedCompany.IsEmpty())
            {               
              
                for(Account accRec :[SELECT Id,Name,Industry,type,Website,CompanyID__c,ParentId,Parent.name,Phone,Fax,Email__c,Weekending__c,OwnerId,owner.name,BillingStreet, BillingCity, BillingState, BillingPostalCode,
                                     BillingCountry FROM Account])
                {
                           mapOfAccIds.put(accRec.CompanyID__c,accRec.Id);              
                }
                for(UpdateCompanyFromJobDivaToSFWrapper.Data companyRec : listOfupdatedCompany)
                {   
                    Account updateAcc = new Account();
                    if(mapOfAccIds.containsKey(companyRec.COMPANYID))
                    {
                        updateAcc.Id=mapOfAccIds.get(companyRec.COMPANYID);
                        updateAcc.name=companyRec.COMPANYNAME;
                        updateAcc.BillingStreet=companyRec.ADDRESS1;
                        updateAcc.BillingCity=companyRec.CITY;
                        updateAcc.BillingState=companyRec.STATE;
                        updateAcc.BillingPostalCode=companyRec.ZIPCODE;
                        updateAcc.BillingCountry=companyRec.COUNTRYID;
                        updateAcc.Phone=companyRec.PHONE;
                        updateAcc.Fax=companyRec.FAX;
                        updateAcc.Website=companyRec.URL;
                        updateAcc.Email__c=companyRec.EMAIL;
                        updateAcc.Industry=companyRec.INDUSTRY;
                        listToUpdateAcc.add(updateAcc);
                    }
                }
                if(!listToUpdateAcc.IsEmpty()){
                    Database.SaveResult[] srList = Database.update(listToUpdateAcc, false);
                
                 for (Database.SaveResult sr : srList) {
                    if (sr.isSuccess()) {
                       System.debug('Successfully Updated Compnay IDs=== ' + sr.getId());
                    }else {                                      
                        for(Database.Error err : sr.getErrors()) {
                            System.debug('The following error has occurred.');                    
                            System.debug(err.getStatusCode() + ': ' + err.getMessage());
                            System.debug('Compnay fields that affected this error: ' + err.getFields());
                        }
    				}                 
                }
            }        
         }       
        }catch(Exception ex) {
            ErrorHandler.addError(ex,'execute','UpdateCompnayFromJobDivaToSF',errorList, true);                    
        }  
    }
    global void finish(Database.BatchableContext BC) 
    { 
        
    }
    global void execute(SchedulableContext SC){
        UpdateCompnayFromJobDivaToSF obj = new UpdateCompnayFromJobDivaToSF();
        database.executebatch(obj,20);
    }
}