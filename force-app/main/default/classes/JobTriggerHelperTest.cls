@isTest
private class JobTriggerHelperTest {
@testSetup 
     static void testDataSetup() {
         Profile salesPersonProfile = [Select Id From Profile Where Name = 'System Administrator'];
         DisabledTrigger__c obj = new DisabledTrigger__c(); 
         obj.name='DisabledTrigger';
         obj.IsActive__c=true;
         Insert obj;  
         
     Account accRec = new Account();
     accRec.Name='Cisco india';
     accRec.CompanyID__c='8125908';    
     Insert accRec;    
       
     Contact conRec = new Contact();
     conRec.FirstName='mark';    
     conRec.LastName='Henry';
     conRec.AccountId=accRec.Id;
     conRec.JobDivaContactId__c='26623964';    
     conRec.MailingStreet='suit22';
     conRec.MailingCity='PUNE';
     conRec.MailingState='CA';
     conRec.MailingCountry='United States';
     conRec.MailingPostalCode='12345';    
     Insert conRec; 
         
     Opportunity opp = new Opportunity();
     opp.Name='cisco opp Rec';
     opp.StageName='Qualification';
     opp.CloseDate=system.today()+30;
     opp.Business_Unit__c='Salesforce';    
     Insert opp;    
         
     Job_Requisition__c jobRec = new Job_Requisition__c();
     jobRec.Opportunity__c=opp.Id;        
     jobRec.Name='Test Name';
     jobRec.Title__c='Mr.';
     jobRec.Contact__c=conRec.Id;
     jobRec.Account__c=accRec.Id;
     jobRec.Division__c='253174';
     jobRec.Job_Type__c='Contract'; 
     jobRec.Rate__c=1800;
     jobRec.Start_Date__c=System.today();
     jobRec.Submittal_Date__c=system.today();
     jobRec.End_Date__c=System.today()+30;
     jobRec.Status__c='Open';
     jobRec.Priority__c='6';
     jobRec.JoDiva_Job_Id__c='21076137';  
     jobRec.MaxAllowedSubmittal__c=2;
     jobRec.ExperienceLevel__c='2';
     jobRec.Openings__c=2;
     jobRec.MinBillRate__c=1500;
     jobRec.MaxBillRate__c=2000;    
     insert jobRec; 
         
     Job_Requisition__c jobRecUpdate = new Job_Requisition__c();     
     jobRecUpdate.Id=jobRec.Id;
     jobRecUpdate.Status__c='Filled';
     update jobRecUpdate; 
         
     Job_Requisition__c jobRecUpdateSecond = new Job_Requisition__c();     
     jobRecUpdateSecond.Id=jobRec.Id;
     jobRecUpdateSecond.Status__c='CLOSED';
     update jobRecUpdateSecond; 
   }    
   
  private static testMethod void callFutureMethod() { 
          List<Job_Requisition__c> listOfJobRequisition = new List<Job_Requisition__c>();
          List<Job_Requisition__c> listOfJobRequisitiontoUpdate=[SELECT Id,Title__c,Rate__c,Name,Account__c,Account__r.CompanyID__c,Contact__c,Contact__r.JobDivaContactId__c,Contact__r.FirstName,Contact__r.LastName,Opportunity__r.Owner.Name,Description__c,Submittal_Date__c,
                                           JoDiva_Job_Id__c,Optional_Ref__c,Job_Type__c,Status__c,Start_Date__c,End_Date__c,Payrate__c,Division__c,
                                           MaxAllowedSubmittal__c,Priority__c,ExperienceLevel__c,Openings__c,AddressLine1__c,AddressLine2__c,City__c,
                                           Country__c,State__c,Zipcode__c
                                           FROM Job_Requisition__c Limit 1]; 
         test.starttest();
          Test.setMock(HttpCalloutMock.Class, new MockHttpResponseGeneratorTest()); 
           JobTriggerHelper.createJobRecInJobDiva(listOfJobRequisitiontoUpdate);
           JobTriggerHelper.updateJobRecInJobDiva(listOfJobRequisitiontoUpdate);
         test.stoptest();
    }
    /*@isTest 
    public static void  jobTriggerTestMethodsecond(){
        test.starttest();
           Test.setMock(HttpCalloutMock.Class, new MockHttpResponseGeneratorTest()); 
          List<Job_Requisition__c> listOfJobRequisition = new List<Job_Requisition__c>();
          List<Job_Requisition__c> listOfJobRequisitiontoUpdate=[SELECT Id,Title__c,Account__r.CompanyID__c,Status__c,JoDiva_Job_Id__c 
                                                                FROM Job_Requisition__c Limit 1]; 
        
        test.stoptest();
    }*/   
}