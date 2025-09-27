@isTest
private class JobDivaIntegration_FromSFToJobDivaTest {
    @testSetup 
     static void testDataSetup() {
     Account accRec = new Account();
     accRec.Name='Cisco india';
     accRec.CompanyID__c='9378125';   
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
     jobRec.MinBillRate__c=1800;
     jobRec.MaxBillRate__c=2000;
     jobRec.BillRateUnit__c='Day';
     jobRec.MaxPayRate__c=1000;
     jobRec.MinPayRate__c=800;
     jobRec.PayRateUnit__c='Day';    
     jobRec.Start_Date__c=System.today();
     jobRec.Submittal_Date__c=system.today();
     jobRec.End_Date__c=System.today()+30;
     jobRec.Status__c='Open';
     jobRec.Priority__c='6';
     jobRec.MaxAllowedSubmittal__c=2;
     jobRec.ExperienceLevel__c='2';
     jobRec.Openings__c=2;       
     insert jobRec; 
         
     Job_Requisition__c jobRecUpdate = new Job_Requisition__c();     
     jobRecUpdate.Id=jobRec.Id;
     jobRecUpdate.Status__c='ON HOLD';
     update jobRecUpdate; 
     
}
  
  private static testMethod void callFutureMethod() {
             
      Test.startTest();
          List<ErrorLog__c> errorList =new List<ErrorLog__c>();
          List<Contact> listOfContact =[select id,name,firstname,lastname,JobDivaContactId__c,AccountId,MailingCity, MailingState, MailingPostalCode, MailingCountry, MailingStreet 
                                              from contact limit 1];         
         
          List<Job_Requisition__c> listOfJobRequisition = new List<Job_Requisition__c>();
          List<Job_Requisition__c> listOfJobRequisitiontoUpdate=[SELECT Id,Title__c,Name,Account__c,Account__r.CompanyID__c,Contact__c,Contact__r.FirstName,Contact__r.LastName,Opportunity__r.Owner.Name,Description__c,Submittal_Date__c,
                                                                   JoDiva_Job_Id__c,Job_Type__c,Status__c,Start_Date__c,End_Date__c,Division__c,
                                                                   MaxAllowedSubmittal__c,Priority__c,ExperienceLevel__c,Openings__c,AddressLine1__c,AddressLine2__c,City__c,
                                                                   Country__c,State__c,Zipcode__c,MinBillRate__c, MaxBillRate__c,BillRateUnit__c, MinPayRate__c, MaxPayRate__c,PayRateUnit__c
                                                                   FROM Job_Requisition__c Limit 1];
          Map<String, Object> contactMapBody= new Map<String, Object>();                              
          contactMapBody.put('action',0);
          contactMapBody.put('contactId',listOfContact[0].JobDivaContactId__c);
          contactMapBody.put('roleId', 0);
          contactMapBody.put('showOnJob',true);
          String jsonRequestBody = JSON.serialize(contactMapBody);
          Set<Id> setOfIdsToUpdate = new Set<Id>();
          listOfJobRequisition=[SELECT Id FROM Job_Requisition__c LIMIT 1];
          setOfIdsToUpdate.add(listOfJobRequisition[0].Id);
          Test.setMock(HttpCalloutMock.Class, new MockHttpResponseGeneratorTest()); 
          JobDivaIntegration_FromSFToJobDiva.createJobInJobDiva(setOfIdsToUpdate);
          JobDivaIntegration_FromSFToJobDiva.updateJobInJobDiva(setOfIdsToUpdate);        
      Test.stopTest();
  }
}