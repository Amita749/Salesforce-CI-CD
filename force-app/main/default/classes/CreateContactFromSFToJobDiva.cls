/* 
Name: CreateContactFromSFToJobDiva.cls
Description: This class is from the Contact trigger upon insert and update. It makes callouts to Jobdiva.
Date: 22 February 2024
Version: 1.0
Author: DynPro                      
*/
public class CreateContactFromSFToJobDiva {
    @future(callout=true)
    public static void createContactInJobDiva(Set<Id> setOfConIdsTocreate){
        
        List<Contact> listOfConToUpdate = new List<Contact>();
        List<ErrorLog__c> errorList =new List<ErrorLog__c>();
        Map<String, Object>  requestbody= new Map<String, Object>();       
        try{
            String token=JobDivaAuthorization.authenticationWithJobDiva();       
            for(Contact conRec :[SELECT Id,Name,AccountId,Account.name,Salutation,FirstName,LastName,Department,Title,Email,
                                 AlternateEmail__c,Phone,HomePhone,MobilePhone,OtherPhone,Fax,MailingStreet, MailingCity,
                                 MailingState, MailingPostalCode, MailingCountry,ContactTypes__c
                                 FROM Contact WHERE Id IN:setOfConIdsTocreate])
            {
                
                Http http = new Http();
                HttpRequest req = new HttpRequest();
                Integer status;
                String endpoint = 'https://api.jobdiva.com/apiv2/jobdiva/createContact?';
                String mobilephone;
                if(conRec.MobilePhone !=null){
                    mobilephone=conRec.MobilePhone.replaceAll('\\D','');
                } 
                String workPhone;
                if(conRec.OtherPhone !=null){
                    workPhone=conRec.OtherPhone.replaceAll('\\D','');
                } 
                String Phone;
                if(conRec.Phone !=null){
                   Phone=conRec.Phone.replaceAll('\\D','');
                }    
                //String homePhone=conRec.HomePhone.replaceAll('\\D','');
                
                List<Map<String, Object>> phoneArray= new List<Map<String, Object>>();
                  
                if(String.IsNotBlank(mobilephone)){
                   Map<String, Object>  PhoneMap= new Map<String, Object>();
                    PhoneMap.put('action',0);
                    PhoneMap.put('ext','');
                    PhoneMap.put('phone',mobilephone);
                    PhoneMap.put('type','C');
                    phoneArray.add((Map<String, Object>) PhoneMap);
                }
                if(String.IsNotBlank(workPhone)){
                    Map<String, Object>  PhoneMap= new Map<String, Object>();
                    PhoneMap.put('action',0);
                    PhoneMap.put('ext','');
                    PhoneMap.put('phone',workPhone);
                    PhoneMap.put('type','W');
                    phoneArray.add((Map<String, Object>) PhoneMap);
                }
                if(String.IsNotBlank(Phone)){
                    Map<String, Object>  PhoneMap= new Map<String, Object>();
                    PhoneMap.put('action',0);
                    PhoneMap.put('ext','');
                    PhoneMap.put('phone',Phone);
                    PhoneMap.put('type','M');
                    phoneArray.add((Map<String, Object>) PhoneMap);
                }
                /*if(String.IsNotBlank(homePhone)){
                   Map<String, Object>  PhoneMap= new Map<String, Object>();
                    PhoneMap.put('action',0);
                    PhoneMap.put('ext','');
                    PhoneMap.put('phone',homePhone);
                    PhoneMap.put('type','H');
                    phoneArray.add((Map<String, Object>) PhoneMap);
                }*/
                /*if(String.IsNotBlank(conRec.Fax)){
                   Map<String, Object>  PhoneMap= new Map<String, Object>();
                    PhoneMap.put('action',0);
                    PhoneMap.put('ext','');
                    PhoneMap.put('phone',conRec.Fax);
                    PhoneMap.put('type','X');
                    phoneArray.add((Map<String, Object>) PhoneMap);
                }*/
                System.debug('phone array-->'+phoneArray);
               
                List<Map<String, Object>>  listOfaddressMap= new List<Map<String, Object>>();
                Map<String, Object>  addressMap= new Map<String, Object>();
                
                addressMap.put('action',0);                
                addressMap.put('address1',conRec.MailingStreet);
                addressMap.put('city',conRec.MailingCity);
                addressMap.put('countryId',conRec.MailingCountry);
                addressMap.put('defaultAddress',true);
                addressMap.put('state',conRec.MailingState);
                addressMap.put('deleted',true);
                addressMap.put('freeText','');
                addressMap.put('id',0);                
                addressMap.put('zipCode',conRec.MailingPostalCode);
                listOfaddressMap.add(addressMap);
                
                requestbody.put('addresses',listOfaddressMap);
                requestbody.put('phones',phoneArray);
                
                List<String> stringList = new List<String>();
                if(String.IsNotBlank(conRec.ContactTypes__c)){  
                   stringList.add(conRec.ContactTypes__c);
                   requestbody.put('types',stringList);                  
                }                 
                if(String.isNotBlank(conRec.Account.Name)){
                    requestbody.put('company',conRec.Account.Name);
                }
                if(String.isNotBlank(conRec.FirstName)){
                    requestbody.put('firstname',conRec.FirstName);
                }
                if(String.isNotBlank(conRec.LastName)){
                    requestbody.put('lastname',conRec.LastName);
                }
                if(String.isNotBlank(conRec.Title)){
                     requestbody.put('title',conRec.Title);
                }
                if(String.isNotBlank(conRec.Department)){
                     requestbody.put('department',conRec.Department);
                }
                if(String.isNotBlank(conRec.Email)){
                    requestbody.put('email',conRec.Email);
                }
                if(String.isNotBlank(conRec.AlternateEmail__c)){
                    requestbody.put('alternateemail',conRec.AlternateEmail__c);
                }
                
                System.debug('requestbody-->'+JSON.serialize(requestbody));
                 
                req.setBody(JSON.serialize(requestbody));
                req.setEndpoint(endpoint);
                System.debug('endpoint-->'+endpoint);
                req.setMethod('POST');
                req.setHeader('Authorization', token);
                req.setHeader('Content-Type','Application/json'); 
               
                HTTPResponse res = http.send(req);  
                System.debug('create response--body-->'+res.getbody());
                System.debug('status code-->'+res.getStatus());
                System.debug('status code-->'+res.getStatusCode());
                conRec.JobDivaContactId__c=res.getbody();                
                if(res.getStatusCode() == 200){
                    conRec.JobDivaStatus__c='Created in Jobdiva!';
                }
                if(res.getStatusCode() == 401 || res.getStatusCode() == 403 || res.getStatusCode() == 404 || res.getStatusCode()==500){
                    conRec.JobDivaStatus__c='Record Not Created in Jobdiva.'+ 'The Status code is:'+res.getStatusCode();
                }
                listOfConToUpdate.add(conRec); 
           } 
           if(!listOfConToUpdate.isEmpty()) 
		       update listOfConToUpdate;	
        }         
        catch(Exception ex) {            
            ErrorHandler.addError(ex,'createContactInJobDiva','CreateContactFromSFToJobDiva', errorList, true);             
        }	
    }
    @future(callout=true)
    public static void updateContactInJobDiva(Set<Id> setOfConIdsToUpdate){
        List<Contact> listOfAccToUpdate = new List<Contact>();
        List<ErrorLog__c> errorList =new List<ErrorLog__c>();
        Map<String, Object>  requestbody= new Map<String, Object>();
        System.debug('updated contact-->'+setOfConIdsToUpdate);
        try{
            String token=JobDivaAuthorization.authenticationWithJobDiva();       
            for(Contact conRec :[SELECT Id,Name,JobDivaContactId__c,AccountId,Account.name,Salutation,FirstName,LastName,
                                 Department,Title,AlternateEmail__c,Phone,HomePhone,MobilePhone,OtherPhone,Email,Fax,
                                 IsActive__c,MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry,
                                 ContactTypes__c
                                 FROM Contact WHERE Id IN:setOfConIdsToUpdate])
            {
                system.debug('contact record fetched-->'+conRec);
                Http http = new Http();
                HttpRequest req = new HttpRequest();
                Integer status;
                String endpoint = 'https://api.jobdiva.com/apiv2/jobdiva/updateContact';
                System.debug('update endpoint-->'+endpoint);
                
                if(String.IsNotBlank(conRec.JobDivaContactId__c)){
                    requestbody.put('contactid',conRec.JobDivaContactId__c);
                }
                String mobilephone;
                if(conRec.MobilePhone !=null){
                    mobilephone=conRec.MobilePhone.replaceAll('\\D','');
                } 
                String workPhone;
                if(conRec.OtherPhone !=null){
                    workPhone=conRec.OtherPhone.replaceAll('\\D','');
                } 
                String Phone;
                if(conRec.Phone !=null){
                   Phone=conRec.Phone.replaceAll('\\D','');
                }    
                //String homePhone=conRec.HomePhone.replaceAll('\\D','');
                
                List<Map<String, Object>> phoneArray= new List<Map<String, Object>>();
                  
                /*if(String.IsNotBlank(mobilephone)){
                   Map<String, Object>  PhoneMap= new Map<String, Object>();
                    PhoneMap.put('action',1);
                    PhoneMap.put('ext','');
                    PhoneMap.put('phone',mobilephone);
                    PhoneMap.put('type','C');
                    phoneArray.add((Map<String, Object>) PhoneMap);
                }
                if(String.IsNotBlank(workPhone)){
                    Map<String, Object>  PhoneMap= new Map<String, Object>();
                    PhoneMap.put('action',1);
                    PhoneMap.put('ext','');
                    PhoneMap.put('phone',workPhone);
                    PhoneMap.put('type','W');
                    phoneArray.add((Map<String, Object>) PhoneMap);
                }
                if(String.IsNotBlank(Phone)){
                    Map<String, Object>  PhoneMap= new Map<String, Object>();
                    PhoneMap.put('action',1);
                    PhoneMap.put('ext','');
                    PhoneMap.put('phone',Phone);
                    PhoneMap.put('type','M');
                    phoneArray.add((Map<String, Object>) PhoneMap);
                }*/
                /*if(String.IsNotBlank(homePhone)){
                   Map<String, Object>  PhoneMap= new Map<String, Object>();
                    PhoneMap.put('action',1);
                    PhoneMap.put('ext','');
                    PhoneMap.put('phone',homePhone);
                    PhoneMap.put('type','H');
                    phoneArray.add((Map<String, Object>) PhoneMap);
                }*/
               /* if(String.IsNotBlank(conRec.Fax)){
                   Map<String, Object>  PhoneMap= new Map<String, Object>();
                    PhoneMap.put('action',1);
                    PhoneMap.put('ext','');
                    PhoneMap.put('phone',conRec.Fax);
                    PhoneMap.put('type','X');
                    phoneArray.add((Map<String, Object>) PhoneMap);
                }*/
                
                System.debug('phone array-->'+phoneArray);
               
                List<Map<String, Object>>  listOfaddressMap= new List<Map<String, Object>>();
                Map<String, Object>  addressMap= new Map<String, Object>();
                
                addressMap.put('action',1);                
                addressMap.put('address1',conRec.MailingStreet);
                addressMap.put('city',conRec.MailingCity);
                addressMap.put('countryId',conRec.MailingCountry);
                addressMap.put('defaultAddress',true);
                addressMap.put('state',conRec.MailingState);
                addressMap.put('deleted',true);
                addressMap.put('freeText','');
                addressMap.put('id',1);                
                addressMap.put('zipCode',conRec.MailingPostalCode);
                listOfaddressMap.add(addressMap);
                
                requestbody.put('addresses',listOfaddressMap);
                requestbody.put('phones',phoneArray);                
                                
                List<String> stringList = new List<String>();                
                if(String.IsNotBlank(conRec.ContactTypes__c)){  
                   stringList.add(conRec.ContactTypes__c);
                   requestbody.put('types',stringList);                  
                }  
                if(String.isNotBlank(conRec.Account.Name)){
                    requestbody.put('company',conRec.Account.Name);
                }
                if(String.isNotBlank(conRec.FirstName)){
                    requestbody.put('firstname',conRec.FirstName);
                }
                if(String.isNotBlank(conRec.LastName)){
                    requestbody.put('lastname',conRec.LastName);
                }
                if(String.isNotBlank(conRec.Title)){
                     requestbody.put('title',conRec.Title);
                }
                if(String.isNotBlank(conRec.Department)){
                     requestbody.put('department',conRec.Department);
                }
                if(String.isNotBlank(conRec.Email)){
                    requestbody.put('email',conRec.Email);
                }
                if(String.isNotBlank(conRec.AlternateEmail__c)){
                      requestbody.put('alternateemail',conRec.AlternateEmail__c);
                }                
                if(conRec.IsActive__c ==TRUE){
                      requestbody.put('active ',true);
                }else{
                    requestbody.put('active ',false);
                } 
                System.debug('updated body-->'+JSON.serialize(requestbody));
                req.setBody(JSON.serialize(requestbody));
                req.setEndpoint(endpoint);
                req.setMethod('POST');
                req.setHeader('Authorization', token); 
                req.setHeader('Content-Type','Application/json');
                HTTPResponse res = http.send(req);  
                System.debug('Update response--body-->'+res.getbody());
           } 
           	
        }catch(Exception ex) {            
            ErrorHandler.addError(ex,'updateContactInJobDiva','CreateContactFromSFToJobDiva', errorList, true);             
        }	
     
    }
}