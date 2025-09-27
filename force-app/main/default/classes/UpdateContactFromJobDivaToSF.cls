/* 
Name: UpdateContactFromJobDivaToSF.cls
Description: This is batch class which fetch update contact from jobdiva to SF and make callout.
Date: 28 February 2024
Version: 1.0
Author: DynPro                      
*/
global class UpdateContactFromJobDivaToSF implements Database.batchable<UpdateContactFromJobDivaToSFWrapper.Data>,Database.Stateful,Database.AllowsCallouts,Schedulable{
     global Date toDate= Date.today();
     global Date fromDate= toDate.addDays(-20);
     global UpdateContactFromJobDivaToSF() {}
     global UpdateContactFromJobDivaToSF(Date fromDate, Date toDate) {
        this.fromDate = fromDate;
        this.toDate=toDate;
    }
    global  Iterable<UpdateContactFromJobDivaToSFWrapper.Data> start(Database.BatchableContext BC) 
    {
         List<ErrorLog__c> errorList =new List<ErrorLog__c>();
        try{
                String token = JobDivaAuthorization.authenticationWithJobDiva();
                Http http = new Http();
                HttpRequest req = new HttpRequest();
                HTTPResponse res = new HTTPResponse();
                
                String dateStr = fromDate.month() + '/' + fromDate.day() + '/' + fromDate.year();
                String EndDateStr = toDate.month() + '/' + toDate.day() + '/' + toDate.year();
                String endpoint = 'https://api.jobdiva.com/api/bi/NewUpdatedContactRecords?fromDate='+dateStr+'&toDate='+EndDateStr+'&alternateFormat=true';
                req.setEndpoint(endpoint);
                req.setMethod('GET');
                req.setHeader('Authorization', token);        
                res = http.send(req);
            
                System.debug('Response Status Code==> '+res.getStatusCode());
                System.debug('Response Status==> '+res.getStatus());
                System.debug('Response Body==> '+res.getBody());
            
                UpdateContactFromJobDivaToSFWrapper companyDetail = (UpdateContactFromJobDivaToSFWrapper) JSON.deserialize(res.getBody(), UpdateContactFromJobDivaToSFWrapper.class);
                return companyDetail.data;
            }
            catch(Exception ex) {  
                ErrorHandler.addError(ex,'start','UpdateContactFromJobDivaToSF',errorList, true);
                throw new DMLException(' ' +ex.getMessage());           
            }
    }
    global void execute(Database.BatchableContext BC, List<UpdateContactFromJobDivaToSFWrapper.Data> listOfupdatedContacts)
    {
        Map<String,String> mapOfConIds = new Map<String,String>();
        Map<String,String> mapOfAccount = new Map<String,String>();
        List<Contact> listToUpdateCon = new List<Contact>();
        List<ErrorLog__c> errorList =new List<ErrorLog__c>();
        try
        {
            if(!listOfupdatedContacts.IsEmpty())
            { 
                for(Contact conRec :[SELECT Id,Name,JobDivaContactId__c,AccountId,Account.name,Salutation,FirstName,LastName,Department,Title,Email,AlternateEmail__c,HomePhone,Fax,Phone,MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry
                                      FROM Contact])
                {
                    mapOfConIds.put(conRec.JobDivaContactId__c,conRec.Id);
                    mapOfAccount.put(conRec.Account.name,conRec.AccountId);
                }    
                for(UpdateContactFromJobDivaToSFWrapper.Data conRecord : listOfupdatedContacts)
                {   
                    Contact updateCon = new Contact();
                    if(mapOfConIds.containsKey(conRecord.CONTACTID))
                    {
                        updateCon.Id=mapOfConIds.get(conRecord.CONTACTID);
                        updateCon.FirstName=conRecord.FIRSTNAME;
                        updateCon.LastName=conRecord.LASTNAME;
                        if(mapOfAccount.containsKey(conRecord.COMPANYNAME)){
                            updateCon.AccountId=mapOfAccount.get(conRecord.COMPANYNAME);
                        } 
                        updateCon.Title=conRecord.TITLE;
                        updateCon.Department=conRecord.DEPARTMENT;
                        if(String.IsNotBlank(conRecord.ACTIVE) && conRecord.ACTIVE=='1'){
                            updateCon.IsActive__c=true;
                        }else{
                            updateCon.IsActive__c=false;
                        }                      
                        updateCon.Email=conRecord.EMAIL;
                        updateCon.AlternateEmail__c=conRecord.ALTERNATE_EMAIL;
                        updateCon.Phone=conRecord.CELLPHONE;
                        updateCon.HomePhone=conRecord.HOMEPHONE;
                        updateCon.OtherPhone=conRecord.WORKPHONE;
                        updateCon.Fax=conRecord.FAX;
                        updateCon.MailingStreet=conRecord.ADDRESS1;
                        updateCon.MailingCity=conRecord.CITY;
                        updateCon.MailingState=conRecord.STATE;
                        updateCon.MailingCountry=conRecord.COUNTRYID;
                        updateCon.MailingPostalCode=conRecord.ZIPCODE;
                        updateCon.SALESPIPELINE__c=conRecord.SALES_PIPELINE;
                        updateCon.ContactTypes__c=conRecord.CONTACT_TYPES;
                        listToUpdateCon.add(updateCon);
                    }
                }
                if(!listToUpdateCon.IsEmpty()){
                       Database.SaveResult[] srList = Database.update(listToUpdateCon, false);                
                 for (Database.SaveResult sr : srList) {
                    if (sr.isSuccess()) {
                       System.debug('Successfully updated Contact IDS== ' + sr.getId());
                    }else {                                      
                        for(Database.Error err : sr.getErrors()) {
                            System.debug('The following error has occurred.');                    
                            System.debug(err.getStatusCode() + ': ' + err.getMessage());
                            System.debug('Contact fields that affected this error: ' + err.getFields());
                        }
    				}                 
                  }
                }
            }
         }catch(Exception ex) {
            ErrorHandler.addError(ex,'execute','UpdateContactFromJobDivaToSF',errorList, true);                    
        }   
    }
    global void finish(Database.BatchableContext BC) 
    { 
        
    }
    global void execute(SchedulableContext SC){
        UpdateContactFromJobDivaToSF obj = new UpdateContactFromJobDivaToSF();
        database.executebatch(obj,20);
    }
}