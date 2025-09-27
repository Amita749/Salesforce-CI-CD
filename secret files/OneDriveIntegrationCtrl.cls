/**
 * @description       : 
 * @author            : Rhishikesh Sapkal
 * @group             : 
 * @last modified on  : 02-12-2024
 * @last modified by  : Rhishikesh Sapkal
**/
public class OneDriveIntegrationCtrl {
    public static Integer mockStatusCode = 200;

    @AuraEnabled
    public static UploadDocumentsAndDocumentId checkFolderId(String recordId) {
        Id myId = (Id)recordId;
        Opportunity opp;
        Lead ld;
        String sObjName = myId.getSObjectType().getDescribe().getName();
        String folderId;
        System.debug('sObjName: '+sObjName);
        if (sObjName == 'Lead'){
            ld = [SELECT Id, Folder_Id__c FROM Lead WHERE Id =: recordId ];
            folderId = ld.Folder_Id__c;
        }else{
          // if(sObjName == 'ResidentialLoanApplication'){
          //     ResidentialLoanApplication la = [SELECT Id, OpportunityId FROM ResidentialLoanApplication WHERE Id =: recordId];
          //     recordId = la.OpportunityId;
          //  } 
            opp = [SELECT Id, Folder_Id__c FROM Opportunity WHERE Id =: recordId ];
            folderId = opp.Folder_Id__c;
        }
        System.debug('folderId: '+folderId);
        
        if(String.isBlank(folderId)){
            return null;
        }else{
            Map<String,String> docFolIds = new Map<String,String>();

            for(Document_Folder_Id__c docFolId :[SELECT Type__c, Opportunity__c, Folder_Id__c FROM Document_Folder_Id__c WHERE Opportunity__c =: recordId OR Lead__c =:recordId]){
                docFolIds.put(docFolId.type__c,docFolId.Folder_Id__c);
            }
            UploadDocumentsAndDocumentId docAndDocId = new UploadDocumentsAndDocumentId();
            List<UploadDocuments> uploadDocuments = new List<UploadDocuments>();
            String accessToken = getAccessToken();
            docAndDocId.uploadDocuments = getFolderDocuments(folderId,'',uploadDocuments,accessToken);
            docAndDocId.folderId = folderId;
            docAndDocId.docFolIds = docFolIds;
            return docAndDocId;
        }
    }

    @AuraEnabled
    public static List<UploadDocuments> getFolderDocuments(String folderId,String fileType,List<UploadDocuments> udList, String accessToken){
        try{
            String endpointUrl = String.format(OneDriveIntegrationContants.getFolderDocuments, new List<String>{OneDriveIntegrationContants.driveId,folderId});
            HTTPResponse res = !Test.isRunningTest()?callout(endpointURL, accessToken,'GET',null,null):getFolderDocumentsResponse();

            if(res.getStatusCode() == 200){
                String responseText = res.getBody();
                Map<String,Object> responseMap =(Map<String,Object>)JSON.deserializeUntyped(responseText) ;
                List<Object> responseMapList = (List<Object>)responseMap.get('value');
                
                if(responseMapList.size()>0){
                    for(Object values : responseMapList){
                        Map<String,Object> valuesMap = (Map<String,Object>)values;
                        if(valuesMap.containsKey('folder')){
                            System.debug(String.valueOf(valuesMap.get('name')));
                            Map<String,Object> folderValuesMap = (Map<String,Object>)valuesMap.get('folder');
                            if(Integer.valueOf(folderValuesMap.get('childCount')) > 0 ){
                                udList = getFolderDocuments(String.valueOf(valuesMap.get('id')),String.valueOf(valuesMap.get('name')),udList,accessToken);
                            }
                        } else {
                            UploadDocuments ud = new UploadDocuments();
                            ud.downloadUrl = String.valueOf(valuesMap.get('@microsoft.graph.downloadUrl')); 
                            ud.webUrl = String.valueOf(valuesMap.get('webUrl'));
                            ud.fileName = String.valueOf(valuesMap.get('name'));
                            ud.fileId = String.valueOf(valuesMap.get('id'));
                            ud.fileType = fileType;
                            String sDatetime=String.valueOf(valuesMap.get('createdDateTime'));
                            Datetime dtime=DateTime.Valueof(sDatetime.replace('T', ' '));
                            ud.createdDate = Date.newinstance(dtime.year(), dtime.month(), dtime.day());
                            udList.add(ud);
                        }
                    }
                }
                System.debug('udList: '+udList);
                return udList;   
            }
            return null;
        } catch (Exception e){
            System.debug(e.getMessage());
            return null;
        }
    }

    @AuraEnabled
    public static FolderAndSubFolderId createFolderAndSubFolder(String recordId) {
        FolderAndSubFolderId fAndSubFId = new FolderAndSubFolderId();
        String mainFolderName;
        Lead ld;
        Opportunity oppNum;
        Id myId = (Id)recordId;
        String sObjName = myId.getSObjectType().getDescribe().getName();
        if (sObjName == 'Lead'){
            ld = [SELECT Id, Lead_Number__c FROM Lead WHERE Id =: recordId ];
            mainFolderName = ld.Lead_Number__c;
        }else{
            oppNum = [SELECT Id,Opportunity_Number__c FROM Opportunity WHERE Id =: recordId ];
            mainFolderName = oppNum.Opportunity_Number__c;
        }
        
        String accessToken = getAccessToken();
        String endpointUrl = OneDriveIntegrationContants.createFolderURL;
        String folderId = OneDriveIntegrationContants.mainFolderId;

        Map<String,String> folderAndFolderId = createFolder(accessToken,folderId,new List<String>{mainFolderName});

        if(folderAndFolderId!=null){
            List<String> folderName = new List<String>{'Pre-Project','Project-Initiation-Documents',
            'RFI','Requirements-Design','ITT','Project-Financial-Accounting',
            'Contracts','Project-Plan','Work-Packages','QA-Integration-Testing',
            'Change-Control-Requests','Stakeholder-Communications',
            'Service-Transition-to-BaU','Project-Logs','Project-Closure'};            
            fAndSubFId.folderId = folderAndFolderId.get(mainFolderName);
            fAndSubFId.subFolderIds = createFolder(accessToken,fAndSubFId.folderId,folderName);
            if (sObjName == 'Lead'){
                Lead l = [SELECT Id, Folder_Id__c FROM Lead WHERE Id =: recordId ];
                l.Folder_Id__c = fAndSubFId.folderId;
                update l;
            } else {
                Opportunity opp = [SELECT Id, Folder_Id__c FROM Opportunity WHERE Id =: recordId ];
                opp.Folder_Id__c = fAndSubFId.folderId;
                update opp;
            }
              
            List<Document_Folder_Id__c> docFolIds = new  List<Document_Folder_Id__c>();
            for(String str : fAndSubFId.subFolderIds.keySet()){
                Document_Folder_Id__c docFolId = new Document_Folder_Id__c();
                docFolId.Folder_Id__c = fAndSubFId.subFolderIds.get(str);
                if (sObjName == 'Lead'){
                    docFolId.Lead__c = recordId;
                } else {
                    docFolId.Opportunity__c = recordId;
                }
                docFolId.Type__c = str;
                docFolId.StorageType__c = 'One Drive';
                docFolIds.add(docFolId);
            }
            insert docFolIds;
        }
        return fAndSubFId;
    }

    public static Map<String,String> createFolder(String accessToken, String folderId, List<String> folderName){
        Map<String,String> folderAndFolderId = new Map<String,String>();
        for(String fn : folderName){
            String endpointURL = String.format(OneDriveIntegrationContants.createFolderURL, new List<String>{OneDriveIntegrationContants.driveId,folderId});
            String folderBody = '{"name": "'+fn+'","folder": {},"@microsoft.graph.conflictBehavior": "rename"}';
            HTTPResponse res = !Test.isRunningTest()?callout(endpointURL, accessToken,'POST',folderBody,null):createFolderAndSubFolderResponse();
            if (res.getStatusCode() == 201){
                String responseText = res.getBody();
                Map<String,object> responseMap =(Map<String,object>)JSON.deserializeUntyped(responseText) ;  
                String folId = String.valueOf(responseMap.get('id'));
                folderAndFolderId.put(fn,folId);
            }else{
                //Throw Error
                return null;
            }
        }
        return folderAndFolderId;
    }

    @AuraEnabled
    public static List<UploadDocuments> uploadFile(List<UploadFileContent> files){
        try {
            String accessToken = getAccessToken();
            List<UploadDocuments> udList = new List<UploadDocuments>();
            for(UploadFileContent fc : files){
                fc.title = fc.title.replaceAll(' ', '%20');
                String endpointURL = String.format(OneDriveIntegrationContants.uploadDocumentURL, new List<String>{OneDriveIntegrationContants.driveId,fc.fileTypeId,fc.title});
                System.debug(endpointURL);
                HTTPResponse res = !Test.isRunningTest()?callout(endpointURL, accessToken,'PUT',null,EncodingUtil.base64Decode(fc.versionData)):uploadFileResponse();
                System.debug(res.getBody());
                if(res.getStatusCode() == 200 || res.getStatusCode() == 201){
                    String responseText = res.getBody();
                    Map<String,object> responseMap =(Map<String,object>)JSON.deserializeUntyped(responseText) ;
                    UploadDocuments ud = new UploadDocuments();
                    ud.downloadUrl = String.valueOf(responseMap.get('@microsoft.graph.downloadUrl')); 
                    ud.webUrl = String.valueOf(responseMap.get('webUrl'));
                    ud.fileName = String.valueOf(responseMap.get('name'));
                    ud.fileId = String.valueOf(responseMap.get('id'));
                    ud.fileType = fc.fileType;
                    String sDatetime=String.valueOf(responseMap.get('createdDateTime'));
                    Datetime dtime=DateTime.Valueof(sDatetime.replace('T', ' '));
                    ud.createdDate = Date.newinstance(dtime.year(), dtime.month(), dtime.day());
                    udList.add(ud);
                }
            }
            System.debug(udList);
            return udList;
        }catch(Exception e){
            System.debug(e.getMessage());
            return null;
        }
        
    }

    @AuraEnabled
    public static String deleteDocument(String documentId){
        try {
            String accessToken = getAccessToken();
            String endpointUrl = String.format(OneDriveIntegrationContants.deleteFolderURL, new List<String>{OneDriveIntegrationContants.driveId,documentId});
            HTTPResponse res = !Test.isRunningTest()?callout(endpointURL, accessToken,'DELETE',null,null):deleteDocumentResponse();
            if(res.getStatusCode() == 204){
                return 'True';
            }
            return 'False';
        }catch(Exception e){
            return 'False';
        }  
    }

    public static string getAccessToken(){
        // base64Encoded Secret ID
        // String key = EncodingUtil.urlEncode('75edcbe8-bc50-476b-97ff-d8eaddcf5b04','UTF-8');
        String key = EncodingUtil.urlEncode('8b83c05a-248e-4167-b52f-a787b17427cc','UTF-8');
        // base64Encoded Secret Value
        // String secret = EncodingUtil.urlEncode('77t8Q~IEpaSx5Rx45ZG-rWXAyc2fwshpS8FY1bPp','UTF-8');
        String secret = EncodingUtil.urlEncode('EfY8Q~hhl6qQWhWx5ZCYnmxsO5XKt5CeADsx9bQW','UTF-8');

        String tokenUrl = 'https://login.microsoftonline.com/'+OneDriveIntegrationContants.tenantId+'/oauth2/v2.0/token';
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint(tokenUrl);
        req.setHeader('content-type', 'application/x-www-form-urlencoded');
        
        String messageBody='client_id='+key+
            '&scope=https://graph.microsoft.com/.default'+
            '&client_secret='+secret+
            '&grant_type=client_credentials';        
        
        req.setHeader('Content-length', String.valueOf(messageBody.length()));
        req.setBody(messageBody);
        req.setTimeout(60*1000);
        
        Http callout = new Http();
        String responseText;
        HttpResponse response = !Test.isRunningTest()?callout.send(req):getAccessTokenResponse();

        if(response.getStatusCode()==200)
        {            
            responseText = response.getBody();
            Map<String,object> responseMap =(Map<String,object>)JSON.deserializeUntyped(responseText) ;  
            String token=String.valueOf(responseMap.get('access_token'));
            return token;
        }
        return '';
    }

    public static HTTPResponse callout(String endpointUrl, String accessToken, String method, String body, Blob data){
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpointUrl);
        req.setMethod(method);
        req.setHeader('Authorization','Bearer ' + accessToken);
        req.setHeader('Content-Encoding', 'UTF-8');
        req.setHeader('Content-type', 'application/json');
        req.setHeader('accept', 'application/json');
        req.setTimeout(120000);
        if(body != null){
            req.setBody(body);
        }
        if(data != null){
            req.setBodyAsBlob(data); 
        }
        Http http = new Http();
        return !Test.isRunningTest()?http.send(req):calloutResponse();
    }

    public class FolderAndSubFolderId {
        @AuraEnabled public String folderId {get;set;}
        @AuraEnabled public Map<String,String> subFolderIds {get;set;}
    }

    public class UploadFileContent {
        @AuraEnabled public Integer fileIndex {get;set;}
        @AuraEnabled public String title {get;set;}
        @AuraEnabled public String fileType {get;set;}
        @AuraEnabled public String fileTypeId {get;set;}
        @AuraEnabled public String versionData {get;set;}
    }

    public class UploadDocuments {
        @AuraEnabled public String downloadUrl {get;set;}
        @AuraEnabled public String webUrl {get;set;}
        @AuraEnabled public Date createdDate {get;set;}
        @AuraEnabled public String fileName {get;set;}
        @AuraEnabled public String fileId {get;set;}
        @AuraEnabled public String fileType {get;set;}
    }

    public class UploadDocumentsAndDocumentId {
        @AuraEnabled public List<UploadDocuments> uploadDocuments {get;set;}
        @AuraEnabled public Map<String,String> docFolIds {get;set;}
        @AuraEnabled public String folderId {get;set;}
    }

    private static HTTPResponse getAccessTokenResponse(){
        HTTPResponse res = new HTTPResponse();
        res.setStatusCode(mockStatusCode);
        res.setBody('{"token_type":"Bearer","expires_in":3599,"ext_expires_in":3599,"access_token":"eyJ0eXAiOiJKV1QiLCJub25jZSI6InNHeUgwZ3lfckRFQ21tOG5IU2NFdlBHbEZsYlpGQ09vSU5KUng1elFveGciLCJhbGciOiJSUzI1NiIsIng1dCI6ImtXYmthYTZxczh3c1RuQndpaU5ZT2hIYm5BdyIsImtpZCI6ImtXYmthYTZxczh3c1RuQndpaU5ZT2hIYm5BdyJ9.eyJhdWQiOiJodHRwczovL2dyYXBoLm1pY3Jvc29mdC5jb20iLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC8wMmM1YjA2Ni1jMDcyLTRiODItOTQ3NC00M2FjY2MxMzg1YzYvIiwiaWF0IjoxNzA3NzQ4NjkwLCJuYmYiOjE3MDc3NDg2OTAsImV4cCI6MTcwNzc1MjU5MCwiYWlvIjoiRTJWZ1lMajQvdE95ejlkZUNLM05hMUNQbmpDekNRQT0iLCJhcHBfZGlzcGxheW5hbWUiOiJTYWxlc2ZvcmNlIE9uZWRyaXZlIEludGVncmF0aW9uIiwiYXBwaWQiOiI4YjgzYzA1YS0yNDhlLTQxNjctYjUyZi1hNzg3YjE3NDI3Y2MiLCJhcHBpZGFjciI6IjEiLCJpZHAiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC8wMmM1YjA2Ni1jMDcyLTRiODItOTQ3NC00M2FjY2MxMzg1YzYvIiwiaWR0eXAiOiJhcHAiLCJvaWQiOiJkNjBiZjVkNS1jNzZiLTRiYzYtODk5Yy00NzMyOWNkOWFiOTkiLCJyaCI6IjAuQVJ3QVpyREZBbkxBZ2t1VWRFT3N6Qk9GeGdNQUFBQUFBQUFBd0FBQUFBQUFBQUFjQUFBLiIsInJvbGVzIjpbIlNpdGVzLlJlYWQuQWxsIiwiU2l0ZXMuUmVhZFdyaXRlLkFsbCIsIkZpbGVzLlJlYWRXcml0ZS5BbGwiLCJGaWxlcy5SZWFkLkFsbCJdLCJzdWIiOiJkNjBiZjVkNS1jNzZiLTRiYzYtODk5Yy00NzMyOWNkOWFiOTkiLCJ0ZW5hbnRfcmVnaW9uX3Njb3BlIjoiTkEiLCJ0aWQiOiIwMmM1YjA2Ni1jMDcyLTRiODItOTQ3NC00M2FjY2MxMzg1YzYiLCJ1dGkiOiJ5QkFDQ1B2SGFrZUp5QVBlaUlpMUFBIiwidmVyIjoiMS4wIiwid2lkcyI6WyIwOTk3YTFkMC0wZDFkLTRhY2ItYjQwOC1kNWNhNzMxMjFlOTAiXSwieG1zX3RjZHQiOjE0MjMxNjYwOTN9.I3jxmp-g-TcJqU6azTL38_1Ve9lXvh4AbKGbBIEg7Xl6MtLpt75RzIZ7MqG-3fiIpLBQlyrTPpbmU6JZmgdsMCsxpFu07dlX8BM5TFbqcTUmlyav0L8GvXTeD954M1PC2U75Mj4OGdAOacKefS9HSCd2bVDUIrQMPUlUudW3JkwMieoJzw4TYT3sh0mLZHkkX_HLK0iMEYi92d6LBatFYiFgPkwb_imgjwMWvjXwLj4HY6U9dhAT52irxrRj3Xos7JHgetlAX18LAYoX7W3NUbj3QPreaOmt87ntpdeQebwnj3c-8ntw5C2k54bitmAbJBPOnIra93aUB_sAUOOjeA"}');
        return res;
    }
    
    private static HTTPResponse calloutResponse(){
        HTTPResponse res = new HTTPResponse();
        res.setStatusCode(mockStatusCode);
        return res;
    }
    
    private static HTTPResponse deleteDocumentResponse(){
        HTTPResponse res = new HTTPResponse();
        res.setStatusCode(mockStatusCode);
        return res;
    }
    
    private static HTTPResponse uploadFileResponse(){
        HTTPResponse res = new HTTPResponse();
        res.setStatusCode(mockStatusCode);
        res.setBody('{"@microsoft.graph.downloadUrl":"https://dynpro-my.sharepoint.com/personal/sfdc_team_dynpro_com/_layouts/15/download.aspx?UniqueId=0772d569-43c8-4c9f-b8f9-b67c8ef7342a&Translate=false&tempauth=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwMDAwMDAwMy0wMDAwLTBmZjEtY2UwMC0wMDAwMDAwMDAwMDAvZHlucHJvLW15LnNoYXJlcG9pbnQuY29tQDAyYzViMDY2LWMwNzItNGI4Mi05NDc0LTQzYWNjYzEzODVjNiIsImlzcyI6IjAwMDAwMDAzLTAwMDAtMGZmMS1jZTAwLTAwMDAwMDAwMDAwMCIsIm5iZiI6IjE3MDc3NDkwMDMiLCJleHAiOiIxNzA3NzUyNjAzIiwiZW5kcG9pbnR1cmwiOiJ5WVUrZWJFSkV1TzV2TXU3SWp0Y0RybFVDRjdoYkdsVkdmT0Rva0hKa3RVPSIsImVuZHBvaW50dXJsTGVuZ3RoIjoiMTUwIiwiaXNsb29wYmFjayI6IlRydWUiLCJjaWQiOiJLUHo5R1c1N2gwQ3pwd3NWYjJHelNRPT0iLCJ2ZXIiOiJoYXNoZWRwcm9vZnRva2VuIiwic2l0ZWlkIjoiTXpsaE0yTXhaV1V0TWpVek5pMDBNakEyTFdJMFlURXROelprWW1KbE9EVm1NREU0IiwiYXBwX2Rpc3BsYXluYW1lIjoiU2FsZXNmb3JjZSBPbmVkcml2ZSBJbnRlZ3JhdGlvbiIsIm5hbWVpZCI6IjhiODNjMDVhLTI0OGUtNDE2Ny1iNTJmLWE3ODdiMTc0MjdjY0AwMmM1YjA2Ni1jMDcyLTRiODItOTQ3NC00M2FjY2MxMzg1YzYiLCJyb2xlcyI6ImFsbHNpdGVzLnJlYWQgYWxsc2l0ZXMud3JpdGUgYWxsZmlsZXMud3JpdGUgYWxsZmlsZXMucmVhZCIsInR0IjoiMSIsImlwYWRkciI6IjIwLjE5MC4xNDUuMTY5In0.sJ1yuSieiGCZkQjkt0UYeZjcva-ev731NiMrWk0RNx0&ApiVersion=2.0","createdDateTime":"2024-02-12T12:49:32Z","id":"01YRJ35NTJ2VZAPSCDT5GLR6NWPSHPONBK","name":"Test.txt","webUrl":"https://dynpro-my.sharepoint.com/personal/sfdc_team_dynpro_com/Documents/Test.txt"}');
        return res;
    }
    
    private static HTTPResponse createFolderAndSubFolderResponse(){
        HTTPResponse res = new HTTPResponse();
        res.setStatusCode(mockStatusCode);
        res.setBody('{"id":"01YRJ35NTJ2VZAPSCDT5GLR6NWPSHPONBK"}');
        return res;
    }
    
    private static HTTPResponse getFolderDocumentsResponse(){
        HTTPResponse res = new HTTPResponse();
        res.setStatusCode(mockStatusCode);
        res.setBody('{"@odata.context":"https://graph.microsoft.com/v1.0/$metadata#users(\'522e9f6d-99ca-4e82-b244-91b18a8b2fd6\')/drive/root/children","@microsoft.graph.tips":"Use $select to choose only the properties your app needs, as this can lead to performance improvements. For example: GET me/drive/root/children?$select=audio,bundle","value":[{"createdDateTime":"2024-02-12T09:48:49Z","id":"01YRJ35NQZMRWM763AJRGJO6KSYKSJOTCZ","lastModifiedDateTime":"2024-02-12T09:48:49Z","webUrl":"https://dynpro-my.sharepoint.com/personal/sfdc_team_dynpro_com/Documents/Apps"},{"createdDateTime":"2024-02-12T14:51:06Z","id":"01YRJ35NQCFMR4TYPR3ZFK3V7IWVRDNRPJ","name":"Document Manager","webUrl":"https://dynpro-my.sharepoint.com/personal/sfdc_team_dynpro_com/Documents/Document%20Manager"}]}');
        return res;
    }
    
}