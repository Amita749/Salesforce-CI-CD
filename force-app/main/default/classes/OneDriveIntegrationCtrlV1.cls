/**
 * @description       : 
 * @author            : Rhishikesh Sapkal
 * @group             : 
 * @last modified on  : 03-08-2024
 * @last modified by  : Rhishikesh Sapkal
**/
public class OneDriveIntegrationCtrlV1 {
    public static Integer mockStatusCode = 200;

    @AuraEnabled
    public static UploadDocumentsAndDocumentId checkFolderId(String recordId) {
        Id myId = (Id)recordId;
        String sObjName = myId.getSObjectType().getDescribe().getName();
        OneDriveFileStructure__mdt fileStructure = [SELECT Id, DeveloperName, Label, ParentObjectField__c, FolderIdField__c, 
            SubFolderStructure__c, FieldSetLabel__c, FolderLabelMethodName__c, DocumentFolderParent__c FROM OneDriveFileStructure__mdt WHERE DeveloperName =:sObjName.replace('__c','')] ?? new OneDriveFileStructure__mdt(); 
        if(String.isNotBlank(fileStructure.Id)){
            String query = 'SELECT ID, '+fileStructure.FolderIdField__c +' FROM '+ sObjName + ' WHERE ID =:recordId';
            SObject obj = Database.query(query);
            String folderId = String.valueOf(obj.get(fileStructure.FolderIdField__c));
            if(String.IsBlank(folderId)){
                return null;
            } else {
                String accessToken = getAccessToken();
                List<UploadDocuments> uploadedDocuments = new List<UploadDocuments>();
                UploadDocumentsAndDocumentId docAndDocId = new UploadDocumentsAndDocumentId();
                docAndDocId.uploadDocuments = getFolderDocuments(folderId,'', uploadedDocuments,accessToken);
                docAndDocId.folderId = folderId;
                return docAndDocId;
            }
        } else {
            throw new AuraHandledException('Configuration not available');
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
                            // System.debug(String.valueOf(valuesMap.get('name')));
                            // Map<String,Object> folderValuesMap = (Map<String,Object>)valuesMap.get('folder');
                            // if(Integer.valueOf(folderValuesMap.get('childCount')) > 0 ){
                            //     udList = getFolderDocuments(String.valueOf(valuesMap.get('id')),String.valueOf(valuesMap.get('name')),udList,accessToken);
                            // }
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



	@AuraEnabled
    public static String createFolderAndStructure(String recordId) {
        try{
            Id myId = (Id)recordId;
            String sObjName = myId.getSObjectType().getDescribe().getName();
            OneDriveFileStructure__mdt fileStructure = [SELECT Id, DeveloperName, Label, ParentObjectField__c, FolderIdField__c, 
            SubFolderStructure__c, FieldSetLabel__c, FolderLabelMethodName__c, DocumentFolderParent__c FROM OneDriveFileStructure__mdt WHERE DeveloperName =:sObjName.replace('__c','')] ?? new OneDriveFileStructure__mdt(); 
            if(String.isNotBlank(fileStructure.Id)){
                String accessToken = getAccessToken();
                String endpointUrl = OneDriveIntegrationContants.createFolderURL;
                String folderId = getFolderId(fileStructure, recordId);
                String folderName = FolderNameGenerator.getFolderName(fileStructure.FolderLabelMethodName__c,myId);
                Map<String,String> folderAndFolderId = createFolder(accessToken,folderId,new Set<String>{folderName});
                if(String.isNotBlank(fileStructure.SubFolderStructure__c)){
                    createSubFolderStructure(fileStructure, folderAndFolderId, accessToken, folderName, recordId);
                }

                sObject obj = Schema.getGlobalDescribe().get(sObjName).newSObject();
                obj.put('Id',recordId);
                obj.put(fileStructure.FolderIdField__c, folderAndFolderId.get(folderName));
                update obj;
                return folderAndFolderId.get(folderName);
            } else {
                throw new AuraHandledException('Configuration not available');
            }
        } catch (Exception ex){
            throw new AuraHandledException(ex.getMessage());
        } 
    }

    private static String getFolderId(OneDriveFileStructure__mdt fileStructure, String recordId){
        if(String.IsBlank(fileStructure.ParentObjectField__c)){
            return OneDriveIntegrationContants.mainFolderId;
        } else {
            Id myId = (Id)recordId;
            String sObjName = myId.getSObjectType().getDescribe().getName();
            String query = 'SELECT ID, '+fileStructure.ParentObjectField__c + ' FROM ' + sObjName + ' WHERE ID=:recordId';
            SObject sobj = Database.query(query);
            Id parentId = (Id)sobj.get(fileStructure.ParentObjectField__c);
            String parentsObjName = parentId.getSObjectType().getDescribe().getName();

            OneDriveFileStructure__mdt parentFileStructure = [SELECT Id, DeveloperName, Label, ParentObjectField__c, FolderIdField__c, SubFolderStructure__c, FieldSetLabel__c, FolderLabelMethodName__c, DocumentFolderParent__c 
                                                              FROM OneDriveFileStructure__mdt 
                                                              WHERE DeveloperName =:parentsObjName.replace('__c','')] ?? new OneDriveFileStructure__mdt(); 

            String parentQuery = 'SELECT ID, Folder_Id__c FROM Document_Folder_Id__c WHERE '+ 
            parentFileStructure.DocumentFolderParent__c + ' =: parentId AND Name =: sObjName LIMIT 1';
            Document_Folder_Id__c folder = Database.query(parentQuery) ?? new Document_Folder_Id__c();
            if(String.isNotBlank(folder.Id)){
                return folder.Folder_Id__c;
            } else {
                throw new AuraHandledException('Parent Folder Doesn\'t Exist');
            }
        }
    }

    private static void createSubFolderStructure(OneDriveFileStructure__mdt fileStructure, Map<String,String> folderAndFolderId, String accessToken, String folderName, String recordId){
        List<ObjectFolderStructure> folderStructure = (List<ObjectFolderStructure>) System.JSON.deserialize(fileStructure.SubFolderStructure__c, List<ObjectFolderStructure>.class);
            Map<String,String> subfolders = new Map<String,String>();
            for(ObjectFolderStructure folSrc : folderStructure){
                subfolders.put(folSrc.folderName,folSrc.objectName);
            }
            Map<String,String> subFoldersIds = createFolder(accessToken,folderAndFolderId.get(folderName),subfolders.keySet());
            List<Document_Folder_Id__c> docFolIds = new  List<Document_Folder_Id__c>();
            for(String str : subFoldersIds.keySet()){
                Document_Folder_Id__c docFolId = new Document_Folder_Id__c();
                docFolId.Folder_Id__c = subFoldersIds.get(str);
                docFolId.put(fileStructure.DocumentFolderParent__c,recordId);
                docFolId.Name = subfolders.get(str);
                docFolId.StorageType__c = 'One Drive';
                docFolIds.add(docFolId);
            }
            insert docFolIds;
    }
    
    public static Map<String,String> createFolder(String accessToken, String folderId, Set<String> folderName){
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
                return null;
            }
        }
        return folderAndFolderId;
    }
    
    public static String getAccessToken(){
        String key = EncodingUtil.urlEncode('8b83c05a-248e-4167-b52f-a787b17427cc','UTF-8');
        String secret = EncodingUtil.urlEncode('EfY8Q~hhl6qQWhWx5ZCYnmxsO5XKt5CeADsx9bQW','UTF-8');
        String tokenUrl = 'https://login.microsoftonline.com/'+OneDriveIntegrationContants.tenantId+'/oauth2/v2.0/token';
        String messageBody='client_id='+key+
                          '&scope=https://graph.microsoft.com/.default'+
                          '&client_secret='+secret+
                          '&grant_type=client_credentials';     
        
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint(tokenUrl);
        req.setHeader('content-type', 'application/x-www-form-urlencoded');
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

    private static HTTPResponse getAccessTokenResponse(){
        HTTPResponse res = new HTTPResponse();
        res.setStatusCode(mockStatusCode);
        res.setBody('{"token_type":"Bearer","expires_in":3599,"ext_expires_in":3599,"access_token":"eyJ0eXAiOiJKV1QiLCJub25jZSI6InNHeUgwZ3lfckRFQ21tOG5IU2NFdlBHbEZsYlpGQ09vSU5KUng1elFveGciLCJhbGciOiJSUzI1NiIsIng1dCI6ImtXYmthYTZxczh3c1RuQndpaU5ZT2hIYm5BdyIsImtpZCI6ImtXYmthYTZxczh3c1RuQndpaU5ZT2hIYm5BdyJ9.eyJhdWQiOiJodHRwczovL2dyYXBoLm1pY3Jvc29mdC5jb20iLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC8wMmM1YjA2Ni1jMDcyLTRiODItOTQ3NC00M2FjY2MxMzg1YzYvIiwiaWF0IjoxNzA3NzQ4NjkwLCJuYmYiOjE3MDc3NDg2OTAsImV4cCI6MTcwNzc1MjU5MCwiYWlvIjoiRTJWZ1lMajQvdE95ejlkZUNLM05hMUNQbmpDekNRQT0iLCJhcHBfZGlzcGxheW5hbWUiOiJTYWxlc2ZvcmNlIE9uZWRyaXZlIEludGVncmF0aW9uIiwiYXBwaWQiOiI4YjgzYzA1YS0yNDhlLTQxNjctYjUyZi1hNzg3YjE3NDI3Y2MiLCJhcHBpZGFjciI6IjEiLCJpZHAiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC8wMmM1YjA2Ni1jMDcyLTRiODItOTQ3NC00M2FjY2MxMzg1YzYvIiwiaWR0eXAiOiJhcHAiLCJvaWQiOiJkNjBiZjVkNS1jNzZiLTRiYzYtODk5Yy00NzMyOWNkOWFiOTkiLCJyaCI6IjAuQVJ3QVpyREZBbkxBZ2t1VWRFT3N6Qk9GeGdNQUFBQUFBQUFBd0FBQUFBQUFBQUFjQUFBLiIsInJvbGVzIjpbIlNpdGVzLlJlYWQuQWxsIiwiU2l0ZXMuUmVhZFdyaXRlLkFsbCIsIkZpbGVzLlJlYWRXcml0ZS5BbGwiLCJGaWxlcy5SZWFkLkFsbCJdLCJzdWIiOiJkNjBiZjVkNS1jNzZiLTRiYzYtODk5Yy00NzMyOWNkOWFiOTkiLCJ0ZW5hbnRfcmVnaW9uX3Njb3BlIjoiTkEiLCJ0aWQiOiIwMmM1YjA2Ni1jMDcyLTRiODItOTQ3NC00M2FjY2MxMzg1YzYiLCJ1dGkiOiJ5QkFDQ1B2SGFrZUp5QVBlaUlpMUFBIiwidmVyIjoiMS4wIiwid2lkcyI6WyIwOTk3YTFkMC0wZDFkLTRhY2ItYjQwOC1kNWNhNzMxMjFlOTAiXSwieG1zX3RjZHQiOjE0MjMxNjYwOTN9.I3jxmp-g-TcJqU6azTL38_1Ve9lXvh4AbKGbBIEg7Xl6MtLpt75RzIZ7MqG-3fiIpLBQlyrTPpbmU6JZmgdsMCsxpFu07dlX8BM5TFbqcTUmlyav0L8GvXTeD954M1PC2U75Mj4OGdAOacKefS9HSCd2bVDUIrQMPUlUudW3JkwMieoJzw4TYT3sh0mLZHkkX_HLK0iMEYi92d6LBatFYiFgPkwb_imgjwMWvjXwLj4HY6U9dhAT52irxrRj3Xos7JHgetlAX18LAYoX7W3NUbj3QPreaOmt87ntpdeQebwnj3c-8ntw5C2k54bitmAbJBPOnIra93aUB_sAUOOjeA"}');
        return res;
    }
    
    private static HTTPResponse getFolderDocumentsResponse(){
        HTTPResponse res = new HTTPResponse();
        res.setStatusCode(mockStatusCode);
        res.setBody('{"@odata.context":"https://graph.microsoft.com/v1.0/$metadata#users(\'522e9f6d-99ca-4e82-b244-91b18a8b2fd6\')/drive/root/children","@microsoft.graph.tips":"Use $select to choose only the properties your app needs, as this can lead to performance improvements. For example: GET me/drive/root/children?$select=audio,bundle","value":[{"createdDateTime":"2024-02-12T09:48:49Z","id":"01YRJ35NQZMRWM763AJRGJO6KSYKSJOTCZ","lastModifiedDateTime":"2024-02-12T09:48:49Z","webUrl":"https://dynpro-my.sharepoint.com/personal/sfdc_team_dynpro_com/Documents/Apps"},{"createdDateTime":"2024-02-12T14:51:06Z","id":"01YRJ35NQCFMR4TYPR3ZFK3V7IWVRDNRPJ","name":"Document Manager","webUrl":"https://dynpro-my.sharepoint.com/personal/sfdc_team_dynpro_com/Documents/Document%20Manager"}]}');
        return res;
    }

    private static HTTPResponse uploadFileResponse(){
        HTTPResponse res = new HTTPResponse();
        res.setStatusCode(mockStatusCode);
        res.setBody('{"@microsoft.graph.downloadUrl":"https://dynpro-my.sharepoint.com/personal/sfdc_team_dynpro_com/_layouts/15/download.aspx?UniqueId=0772d569-43c8-4c9f-b8f9-b67c8ef7342a&Translate=false&tempauth=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwMDAwMDAwMy0wMDAwLTBmZjEtY2UwMC0wMDAwMDAwMDAwMDAvZHlucHJvLW15LnNoYXJlcG9pbnQuY29tQDAyYzViMDY2LWMwNzItNGI4Mi05NDc0LTQzYWNjYzEzODVjNiIsImlzcyI6IjAwMDAwMDAzLTAwMDAtMGZmMS1jZTAwLTAwMDAwMDAwMDAwMCIsIm5iZiI6IjE3MDc3NDkwMDMiLCJleHAiOiIxNzA3NzUyNjAzIiwiZW5kcG9pbnR1cmwiOiJ5WVUrZWJFSkV1TzV2TXU3SWp0Y0RybFVDRjdoYkdsVkdmT0Rva0hKa3RVPSIsImVuZHBvaW50dXJsTGVuZ3RoIjoiMTUwIiwiaXNsb29wYmFjayI6IlRydWUiLCJjaWQiOiJLUHo5R1c1N2gwQ3pwd3NWYjJHelNRPT0iLCJ2ZXIiOiJoYXNoZWRwcm9vZnRva2VuIiwic2l0ZWlkIjoiTXpsaE0yTXhaV1V0TWpVek5pMDBNakEyTFdJMFlURXROelprWW1KbE9EVm1NREU0IiwiYXBwX2Rpc3BsYXluYW1lIjoiU2FsZXNmb3JjZSBPbmVkcml2ZSBJbnRlZ3JhdGlvbiIsIm5hbWVpZCI6IjhiODNjMDVhLTI0OGUtNDE2Ny1iNTJmLWE3ODdiMTc0MjdjY0AwMmM1YjA2Ni1jMDcyLTRiODItOTQ3NC00M2FjY2MxMzg1YzYiLCJyb2xlcyI6ImFsbHNpdGVzLnJlYWQgYWxsc2l0ZXMud3JpdGUgYWxsZmlsZXMud3JpdGUgYWxsZmlsZXMucmVhZCIsInR0IjoiMSIsImlwYWRkciI6IjIwLjE5MC4xNDUuMTY5In0.sJ1yuSieiGCZkQjkt0UYeZjcva-ev731NiMrWk0RNx0&ApiVersion=2.0","createdDateTime":"2024-02-12T12:49:32Z","id":"01YRJ35NTJ2VZAPSCDT5GLR6NWPSHPONBK","name":"Test.txt","webUrl":"https://dynpro-my.sharepoint.com/personal/sfdc_team_dynpro_com/Documents/Test.txt"}');
        return res;
    }

    private static HTTPResponse deleteDocumentResponse(){
        HTTPResponse res = new HTTPResponse();
        res.setStatusCode(mockStatusCode);
        return res;
    }
    
    private static HTTPResponse calloutResponse(){
        HTTPResponse res = new HTTPResponse();
        res.setStatusCode(mockStatusCode);
        return res;
    }

    private static HTTPResponse createFolderAndSubFolderResponse(){
        HTTPResponse res = new HTTPResponse();
        res.setStatusCode(mockStatusCode);
        res.setBody('{"id":"01YRJ35NTJ2VZAPSCDT5GLR6NWPSHPONBK"}');
        return res;
    }
    
    public class ObjectFolderStructure {
        public String objectName;
        public String folderName;
    }

    public class UploadFileContent {
        @AuraEnabled public Integer fileIndex {get;set;}
        @AuraEnabled public String title {get;set;}
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
        @AuraEnabled public String folderId {get;set;}
    }
}