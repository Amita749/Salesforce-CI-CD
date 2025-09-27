@isTest
private class JobDivaIntegration_FromJobDivaToSFTest {
  
  @testSetup 
     static void testDataSetup() {
     Account accRec = new Account();
     accRec.Name='Cisco india';
     accRec.CompanyID__c='8125908';   
     Insert accRec;    
       
     Contact conRec = new Contact();
     conRec.LastName='Henry';
     conRec.FirstName='stephan';    
     conRec.AccountId=accRec.Id;
     conRec.JobDivaContactId__c='26623900';
     Insert conRec;          
         
     Opportunity opp = new Opportunity();
     opp.Name='cisco opp Rec';
     opp.StageName='Qualification';
     opp.CloseDate=system.today()+30;
     opp.Business_Unit__c='Mulesoft';    
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
         jobRec.Openings__c=4;
         JobRec.Payrate__c=1200.00;
         jobRec.MinBillRate__c=1300.00;
         jobRec.MaxBillRate__c=1200.00;
         JobRec.Rate__c=1300.00;
         JobRec.MaxAllowedSubmittal__c=20;
         insert jobRec; 
     
     Job_Requisition__c jobRecUpdate = new Job_Requisition__c();     
     jobRecUpdate.Id=jobRec.Id;
     jobRecUpdate.Priority__c='5';
     update jobRecUpdate; 
     
} 
@isTest 
    public static void  testCallout(){
          test.startTest(); 
             Account accRec = new Account();
             accRec.Name='Cisco india';
             accRec.CompanyID__c='9378125';   
             Insert accRec;    
               
             Contact conRec = new Contact();
             conRec.LastName='Mark';
             conRec.FirstName='couglan'; 
             conRec.AccountId=accRec.Id;
             conRec.JobDivaContactId__c='26623964';
             Insert conRec;          
                 
             Opportunity opp = new Opportunity();
             opp.Name='cisco opp Rec';
             opp.StageName='Qualification';
             opp.CloseDate=system.today()+30;
             opp.Business_Unit__c='Mulesoft';
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
             jobRec.MinBillRate__c=1300.00;
             jobRec.MaxBillRate__c=1200.00;
             jobRec.Openings__c=Integer.ValueOf(4);
             JobRec.Payrate__c=Decimal.valueOf(1200);
             JobRec.Rate__c=Decimal.valueOf(1300);
             JobRec.MaxAllowedSubmittal__c=Integer.ValueOf(20);
             insert jobRec; 
             
             System.debug('inserted job rec-->'+jobRec);
             Job_Requisition__c jobRecUpdate = new Job_Requisition__c();     
             jobRecUpdate.Id=jobRec.Id;
             jobRecUpdate.Priority__c='5';
             update jobRecUpdate; 
              List<Job_Requisition__c> listOfJobRequisition = new List<Job_Requisition__c>();
              List<Job_Requisition__c> listOfJobRequisitiontoUpdate=[SELECT Id, Name,Account__c,Account__r.CompanyID__c,Description__c,JoDiva_Job_Id__c,Status__c, 
                                                                     Rate__c,Start_Date__c,Submittal_Date__c,End_Date__c,Priority__c,Openings__c,Payrate__c,MaxAllowedSubmittal__c
                                                                     FROM Job_Requisition__c where id=:jobRec.Id];
               System.debug('list of job rec-->'+listOfJobRequisitiontoUpdate);
               Date toDate= Date.today();
               Date fromDate= toDate.addDays(-14);        
             
             Test.setMock(HttpCalloutMock.Class, new MockHttpResponseGeneratorTest());             
             JobDivaIntegration_FromJobDivaToSF batchObj= new JobDivaIntegration_FromJobDivaToSF(toDate,fromDate);
             Id jobid= Database.executeBatch(batchObj);
             String sch = '0 0 23 * * ?';
             System.schedule('JobDiva to Sf Update', sch, batchObj );       
           
           test.stoptest();
         }  
}