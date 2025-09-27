@isTest
public class JobTriggerTest {
@testSetup 
     static void testDataSetup() {
     Account accRec = new Account();
     accRec.Name='Cisco india';
     accRec.CompanyID__c='8125908';    
     Insert accRec;    
       
     Contact conRec = new Contact();
     conRec.LastName='Henry';
     conRec.AccountId=accRec.Id;
     Insert conRec; 
         
     Opportunity opp = new Opportunity();
     opp.Name='cisco opp Rec';
     opp.StageName='Qualification';
     opp.CloseDate=system.today()+30;
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
   @isTest 
    public static void  jobTriggerTestMethod(){
         test.starttest();
          List<Job_Requisition__c> listOfJobRequisition = new List<Job_Requisition__c>();
          List<Job_Requisition__c> listOfJobRequisitiontoUpdate=[SELECT Id,Title__c,Account__r.CompanyID__c,Status__c,JoDiva_Job_Id__c 
                                                                FROM Job_Requisition__c Limit 1]; 
       
         //JobDivaIntegration_FromSFToJobDiva.afterInsert(listOfJobRequisitiontoUpdate);
        test.stoptest();
    }
    @isTest 
    public static void  jobTriggerTestMethodsecond(){
        test.starttest();
          List<Job_Requisition__c> listOfJobRequisition = new List<Job_Requisition__c>();
          List<Job_Requisition__c> listOfJobRequisitiontoUpdate=[SELECT Id,Title__c,Account__r.CompanyID__c,Status__c,JoDiva_Job_Id__c 
                                                                FROM Job_Requisition__c Limit 1]; 
        
         //JobDivaIntegration_FromSFToJobDiva.afterUpdate(listOfJobRequisitiontoUpdate);
        test.stoptest();
    }   
}