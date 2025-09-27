@IsTest
public class OneDriveIntegrationCtrlTest {
	@isTest
    public static void getAccessTokenTest(){
        Test.startTest();
        OneDriveIntegrationCtrl.getAccessToken();
        Test.stopTest();
    }
    
    @isTest
    public static void getAccessTokenTestFail(){
        Test.startTest();
        OneDriveIntegrationCtrl.mockStatusCode = 400;
        OneDriveIntegrationCtrl.getAccessToken();
        Test.stopTest();
    }
    
    @isTest
    public static void calloutTest(){
        Test.startTest();
        OneDriveIntegrationCtrl.callout('test','test','test','test',null);
        Test.stopTest();
    }
    
    @isTest
    public static void deleteDocumentTest(){
        Test.startTest();
        OneDriveIntegrationCtrl.mockStatusCode = 204;
        OneDriveIntegrationCtrl.deleteDocument('test');
        Test.stopTest();
    }
    
    @isTest
    public static void deleteDocumentTestNegative(){
        Test.startTest();
        OneDriveIntegrationCtrl.deleteDocument('test');
        Test.stopTest();
    }
    
    @isTest
    public static void uploadFileTest(){
        OneDriveIntegrationCtrl.UploadFileContent ufc = new OneDriveIntegrationCtrl.UploadFileContent();
        ufc.fileIndex = 1;
        ufc.title = 'test';
        ufc.fileType = 'test';
		ufc.fileTypeId = 'test';
		ufc.versionData = 'test';
        OneDriveIntegrationCtrl.uploadFile(new List<OneDriveIntegrationCtrl.UploadFileContent>{ufc});
        
    }
    
    @isTest
    public static void createFolderAndSubFolderTest(){
        Lead l1 = new Lead(LastName = 'Test', Company='TestCompany');
        insert l1;
        Test.startTest();
        OneDriveIntegrationCtrl.mockStatusCode = 201;
        OneDriveIntegrationCtrl.createFolderAndSubFolder(l1.Id);
        Test.stopTest();
    }


	   
    @isTest
    public static void checkFolderIdTest(){
        Lead l1 = new Lead(LastName = 'Test', Company='TestCompany',Folder_Id__c='Test');
        insert l1;
        Test.startTest();
        OneDriveIntegrationCtrl.mockStatusCode = 201;
        OneDriveIntegrationCtrl.checkFolderId(l1.Id);
        Test.stopTest();
    }
}