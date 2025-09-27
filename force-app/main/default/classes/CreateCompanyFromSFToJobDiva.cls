/* 
Name: CreateCompanyFromSFToJobDiva.cls
Description: This class is from the Account trigger upon insert and update. It makes callouts to Jobdiva.
Date: 22 February 2024
Version: 1.0
Author: DynPro                      
*/
public class CreateCompanyFromSFToJobDiva {  
    @future(callout=true)     
    public static void createCompnayInJobDiva(Set<Id> setOfAccIdsTocreate){
       
        List<Account> listOfAccToUpdate = new List<Account>();
        List<Account> AccToUpdateFromJobdiva = new List<Account>();
        List<ErrorLog__c> errorList =new List<ErrorLog__c>();     
         List<Object> results  = new  List<Object> ();
        try{
            String token=JobDivaAuthorization.authenticationWithJobDiva();       
            for(Account accRec :[SELECT Id,Name,Industry,type,Website,ParentId,Parent.name,Phone,Fax,Email__c,
                                 Weekending__c,OwnerId,owner.name,BillingStreet, BillingCity, BillingState, BillingPostalCode,
                                 BillingCountry,CompanyTypes__c,Division__c,CompanyExistInJobDiva__c 
                                 FROM Account WHERE Id IN:setOfAccIdsTocreate])
            {     
                Http searchhttp = new Http();
                HttpRequest searchReq = new HttpRequest();
                HTTPResponse searchRes = new HTTPResponse();                
                
                String Searchendpoint = 'https://api.jobdiva.com/api/jobdiva/searchCompany?company='+accRec.Name;
               
                searchReq.setEndpoint(Searchendpoint);
                searchReq.setMethod('GET');
                searchReq.setHeader('Authorization', token);        
                searchRes = searchhttp.send(searchReq);
                System.debug(searchRes.getStatus());
                if(searchRes.getStatusCode()==200)
                {
                    results  = (List<Object>) Json.deserializeUntyped(searchRes.getBody());                   
                   
                    if(!results.isEmpty())
                    {                    
                    for(Object obj : results) 
                    {
                        Map<String, Object> mapvariable = (Map<String, Object>) obj;   
                        Account accRecord = new Account();
                        accRecord.Id=accRec.Id;
                        accRecord.Name=accRec.Name;                        
                        
                        if(String.IsNotblank(String.valueOf(mapvariable.get('id')))){
                            accRecord.CompanyID__c=String.valueOf(mapvariable.get('id'));                              
                        }
                        if(String.IsNotblank(String.valueOf(mapvariable.get('address1')))){
                            accRecord.BillingStreet=String.valueOf(mapvariable.get('address1'));
                        }                        
                        if(String.IsNotblank(String.valueOf(mapvariable.get('city')))){
                            accRecord.BillingCity=String.valueOf(mapvariable.get('city'));
                        }                  
                        if(String.IsNotblank(String.valueOf(mapvariable.get('state')))){
                            accRecord.BillingState=String.valueOf(mapvariable.get('state'));
                        }  
                        if(String.IsNotblank(String.valueOf(mapvariable.get('zipcode')))){
                            accRecord.BillingPostalCode=String.valueOf(mapvariable.get('zipcode'));
                        }
                        if(String.IsNotblank(String.valueOf(mapvariable.get('country')))){
                            accRecord.BillingCountry=String.valueOf(mapvariable.get('country'));
                        }
                        if(String.IsNotblank(String.valueOf(mapvariable.get('phone')))){
                            accRecord.Phone=String.valueOf(mapvariable.get('phone')); 
                        }
                        if(String.IsNotblank(String.valueOf(mapvariable.get('email')))){
                            accRecord.Email__c=String.valueOf(mapvariable.get('email'));
                        }
                        if(String.IsNotblank(String.valueOf(mapvariable.get('url')))){
                            accRecord.Website=String.valueOf(mapvariable.get('url'));
                        }
                        if(String.IsNotblank(String.valueOf(mapvariable.get('company types')))){  
                            String companytype=String.valueOf(mapvariable.get('company types'));
                            if(companytype.contains('Other')){                                     
                                companytype='Other';
                                accRecord.CompanyTypes__c=companytype;                                    
                            }else{
                                accRecord.CompanyTypes__c=String.valueOf(mapvariable.get('company types'));
                            }                                                                                        
                        }    
                        if(String.IsNotblank(String.valueOf(mapvariable.get('parent company name')))){
                            accRecord.ParentId=String.valueOf(mapvariable.get('parent company name'));
                        } 
                        accRecord.CompanyExistInJobDiva__c=true; 
                        accRecord.JobDivaStatus__c='This Account '+ accRecord.CompanyID__c+' is already present in Jobdiva!';  
                        AccToUpdateFromJobdiva.add(accRecord);
                       }
                    }
                    if(!AccToUpdateFromJobdiva.isEmpty()) 
                        update AccToUpdateFromJobdiva;	                     
                }else{
                    System.debug('inside else');
                    Http http = new Http();
                    HttpRequest req = new HttpRequest();                   
                    String endpoint = 'https://api.jobdiva.com/api/jobdiva/createCompany';                    
                    String body='';
                    if(String.IsNotBlank(accRec.Name)){
                        body='&companyname='+EncodingUtil.urlEncode(accRec.Name,'UTF-8');
                    }
                    if(String.IsNotBlank(accRec.Website)){
                        body+='&url='+EncodingUtil.urlEncode(accRec.Website,'UTF-8');
                    }
                    if(String.IsNotBlank(accRec.Fax)){
                        body+='&fax='+EncodingUtil.urlEncode(accRec.Fax,'UTF-8');
                    }
                    if(String.IsNotBlank(accRec.Phone)){
                        body+='&phone='+EncodingUtil.urlEncode(accRec.Phone,'UTF-8');
                    }
                    if(String.IsNotBlank(accRec.Email__c)){
                        body+='&email='+EncodingUtil.urlEncode(accRec.Email__c,'UTF-8');
                    }                
                    if(String.IsNotBlank(accRec.Parent.name)){
                        body+='&parentcompany='+EncodingUtil.urlEncode(accRec.Parent.name,'UTF-8');
                    }
                    if(String.IsNotBlank(accRec.BillingStreet)){
                        body+='&address1='+EncodingUtil.urlEncode(accRec.BillingStreet,'UTF-8');
                    }
                    if(String.IsNotBlank(accRec.BillingCity)){
                        body+='&city='+EncodingUtil.urlEncode(accRec.BillingCity,'UTF-8');
                    }
                    if(String.IsNotBlank(accRec.BillingState)){
                        body+='&state='+EncodingUtil.urlEncode(accRec.BillingState,'UTF-8');
                    }
                    if(String.IsNotBlank(accRec.BillingPostalCode)){
                        body+='&zipcode='+EncodingUtil.urlEncode(accRec.BillingPostalCode,'UTF-8');
                    }
                    if(String.IsNotBlank(accRec.BillingCountry)){
                        body+='&country='+EncodingUtil.urlEncode(accRec.BillingCountry,'UTF-8');
                    }
                    if(String.IsNotBlank(accRec.CompanyTypes__c)){
                        body+='&companytypes='+EncodingUtil.urlEncode(accRec.CompanyTypes__c,'UTF-8');
                    }
                    req.setBody(body);                   
                    req.setEndpoint(endpoint);
                    req.setMethod('POST');
                    req.setHeader('Authorization', token);
                    req.setHeader('Content-Type','application/x-www-form-urlencoded'); 
                    
                    HTTPResponse res = http.send(req);
                    
                    String errorRes=res.getbody();                                  
                    accRec.CompanyID__c=res.getbody();
                    
                    if(res.getStatusCode() == 200){
                        accRec.JobDivaStatus__c='Record Created in Jobdiva!';
                    }
                    if(res.getStatusCode() == 401 || res.getStatusCode() == 403 || res.getStatusCode() == 404 || res.getStatusCode()==500){
                        accRec.JobDivaStatus__c='Record Not Created in Jobdiva.'+ 'The HTTP Response Status code is:'+res.getStatusCode()+'.'; 
                    }
                    listOfAccToUpdate.add(accRec); 
                    System.debug('listOfAccToUpdate-->'+listOfAccToUpdate);
                    if(!listOfAccToUpdate.isEmpty()) 
                        update listOfAccToUpdate;
                }
            }               
        }         
        catch(Exception ex) {            
            ErrorHandler.addError(ex,'createJobInJobDiva','CreateCompanyFromSFToJobDiva', errorList, true); 
        }        
    }
    @future(callout=true)
    public static void updateCompnayInJobDiva(Set<Id> setOfAccIdsToupdate){
        
        List<Account> listOfAccToUpdate = new List<Account>();
        List<ErrorLog__c> errorList =new List<ErrorLog__c>();
        try{
            String token=JobDivaAuthorization.authenticationWithJobDiva();       
            for(Account accRec :[SELECT Id,Name,CompanyID__c,ParentId,Parent.name,Parent.CompanyID__c,Email__c,Industry,type,
                                 Weekending__c,Website,Phone,Fax,BillingAddress,BillingStreet, BillingCity, 
                                 BillingState, BillingPostalCode,BillingCountry ,CompanyTypes__c, Division__c
                                 FROM Account WHERE Id IN:setOfAccIdsToupdate])
            {
                system.debug('after update fires -->'+accRec);
                Http http = new Http();
                HttpRequest req = new HttpRequest();               
                String endpoint = 'https://api.jobdiva.com/api/jobdiva/updateCompany?companyid='+accRec.CompanyID__c;               
                
                Map<String, Object>  addressMap= new Map<String, Object>();
                addressMap.put('action',1); 
                addressMap.put('address1',accRec.BillingStreet);
                addressMap.put('addressId',1); 
                addressMap.put('city',accRec.BillingCity);
                addressMap.put('countryid',accRec.BillingCountry);
                addressMap.put('defaultAddress',true); 
                addressMap.put('email',accRec.Email__c);
                addressMap.put('fax',accRec.Fax);
                addressMap.put('phone',accRec.Phone);
                addressMap.put('state',accRec.BillingState);
                addressMap.put('url',accRec.Website);
                addressMap.put('zipcode',accRec.BillingPostalCode);
                String jsonRequestBody = JSON.serialize(addressMap); 
                //System.debug('url-->'+jsonRequestBody);
                String body='';
                if(String.IsNotBlank(accRec.Name)){
                    body='&companyname='+EncodingUtil.urlEncode(accRec.Name,'UTF-8');
                }
                if(String.IsNotBlank(accRec.Parent.name)){
                    body+='&parentcompany='+EncodingUtil.urlEncode(accRec.Parent.name,'UTF-8');
                }
                if(String.IsNotBlank(accRec.CompanyTypes__c)){
                    body+='&companytypes='+EncodingUtil.urlEncode(accRec.CompanyTypes__c,'UTF-8');
                }
                if(String.IsNotBlank(jsonRequestBody)){
                    body+='&addresses='+EncodingUtil.urlEncode(jsonRequestBody,'UTF-8');
                }
                //System.debug('Update body-->'+body);
                req.setBody(body);
                req.setEndpoint(endpoint);
                req.setMethod('POST');
                req.setHeader('Authorization', token);
                req.setHeader('Content-Type','application/x-www-form-urlencoded');                
                HTTPResponse res = http.send(req);
                //System.debug('Update response--body-->'+res.getbody());
            } 
        }         
        catch(Exception ex) {            
            ErrorHandler.addError(ex,'updateCompnayInJobDiva','CreateCompanyFromSFToJobDiva', errorList, true); 
        }
    }   
}