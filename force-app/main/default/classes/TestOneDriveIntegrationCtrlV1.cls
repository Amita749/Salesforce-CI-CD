/**
 * @description       : 
 * @author            : Rhishikesh Sapkal
 * @group             : 
 * @last modified on  : 03-08-2024
 * @last modified by  : Rhishikesh Sapkal
**/
@isTest
private class TestOneDriveIntegrationCtrlV1{

	@testSetup static void setup(){

		Document_folder_id__c documentfolderidcObj = new Document_folder_id__c (
			Folder_Id__c = 'test value'
		);
		insert documentfolderidcObj;
		 
	}

	@isTest
    public static void getAccessTokenTest(){
        Test.startTest();
        OneDriveIntegrationCtrlV1.getAccessToken();
        Test.stopTest();
    }
    
    @isTest
    public static void getAccessTokenTestFail(){
        Test.startTest();
        OneDriveIntegrationCtrlV1.mockStatusCode = 400;
        OneDriveIntegrationCtrlV1.getAccessToken();
        Test.stopTest();
    }
    
    @isTest
    public static void calloutTest(){
        Test.startTest();
        OneDriveIntegrationCtrlV1.callout('test','test','test','test',null);
        Test.stopTest();
    }
    
    @isTest
    public static void deleteDocumentTest(){
        Test.startTest();
        OneDriveIntegrationCtrlV1.mockStatusCode = 204;
        OneDriveIntegrationCtrlV1.deleteDocument('test');
        Test.stopTest();
    }
    
    @isTest
    public static void deleteDocumentTestNegative(){
        Test.startTest();
        OneDriveIntegrationCtrlV1.deleteDocument('test');
        Test.stopTest();
    }
    
    @isTest
    public static void uploadFileTest(){
        OneDriveIntegrationCtrlV1.UploadFileContent ufc = new OneDriveIntegrationCtrlV1.UploadFileContent();
        ufc.fileIndex = 1;
        ufc.title = 'test';
		ufc.fileTypeId = 'test';
		ufc.versionData = 'test';
        OneDriveIntegrationCtrlV1.uploadFile(new List<OneDriveIntegrationCtrlV1.UploadFileContent>{ufc});
        
    }
    
    @isTest
    public static void createFolderAndSubFolderTest(){
        Account l1 = new Account(Name = 'TestCompany1');
        insert l1;
        Test.startTest();
        OneDriveIntegrationCtrlV1.mockStatusCode = 201;
        OneDriveIntegrationCtrlV1.createFolderAndStructure(l1.Id);
        Test.stopTest();
    }


	   
    @isTest
    public static void checkFolderIdTest(){
        Lead l1 = new Lead(LastName = 'Test', Company='TestCompany',Folder_Id__c='Test');
        insert l1;
        Test.startTest();
        OneDriveIntegrationCtrlV1.mockStatusCode = 201;
        OneDriveIntegrationCtrlV1.checkFolderId(l1.Id);
        Test.stopTest();
    }
    
    @isTest
    public static void folderNameGeneratorTest(){
        Lead l1 = new Lead(LastName = 'Test', Company='TestCompany',Folder_Id__c='Test');
        Account a1 = new Account(Name = 'TestCompany1');
        Opportunity o1 = new Opportunity(Name = 'TestCompany1',Folder_Id__c='Test', StageName='Prospect', CloseDate=System.today(), Business_Unit__c='Salesforce');
        Contact c1 = new Contact(LastName = 'Test',Folder_Id__c='Test');
        
        insert l1;
        insert a1;
        insert o1;
        insert c1;
        /*Job_Requisition__c r1 = new Job_Requisition__c(Name = 'Test', Status__c='On Hold', Opportunity__c = o1.Id, Contact__c = c1.Id, Title__c = 'Test', Account__c = a1.Id, 
                                                       Division__c= 'test', Priority__c='low', Rate__c=0, Start_Date__c=System.today(), End_Date__c=System.today(), Submittal_Date__c=System.today());
        insert r1;*/
        Test.startTest();
        FolderNameGenerator.getFolderName('getAccountFolderName',a1.Id);
        FolderNameGenerator.getFolderName('getOpportunityFolderName',o1.Id);
        //FolderNameGenerator.getFolderName('getJobReqFolderName',r1.Id);
        FolderNameGenerator.getFolderName('getLeadFolderName',l1.Id);
        FolderNameGenerator.getFolderName('getContactFolderName',c1.Id);
        Test.stopTest();
    }
}