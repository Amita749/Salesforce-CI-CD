@isTest
private class AccountTriggerHelperTest {
    @testSetup 
     static void testDataSetup() {
         Profile salesPersonProfile = [Select Id From Profile Where Name = 'System Administrator'];
         DisabledTrigger__c obj = new DisabledTrigger__c(); 
         obj.name='DisabledTrigger';
         obj.IsActive__c=true;
         Insert obj;    
         Account accRec = new Account();
         accRec.Name='Cisco india';
         accRec.Industry='banking';
         accRec.type='Supllier';
         accRec.Website='www.test.com';
         accRec.Phone='9347833';
         accRec.Fax='33489';
         accRec.Email__c='sangetac350@gmail.com';
         accRec.Weekending__c='friday';
         accRec.BillingStreet='suit 500';
         accRec.BillingCity='Loss Angeles';
         accRec.BillingState='CA';
         accRec.BillingPostalCode='3842';
         accRec.BillingCountry='United sates';    
         accRec.CompanyID__c='9378125';          
         Insert accRec; 
         
         Account acct = new Account();
         acct.Id=accRec.Id;
         acct.Weekending__c='Saturday';
         acct.BillingState='LA';
         update acct;
            
          
     }
    
    private static testMethod void callFutureMethod() {      
            List<Account> listofAcc=[SELECT Id,Name,Industry,type,Website,ParentId,Parent.name,Phone,Fax,Email__c,Weekending__c,OwnerId,owner.name,BillingStreet, BillingCity, BillingState, BillingPostalCode,
                                   BillingCountry FROM Account limit 1];
         Test.startTest(); 
            Test.setMock(HttpCalloutMock.Class, new MockHttpResponseGeneratorTest(true)); 
            
                AccountTriggerHelper.createAccountInJobDiva(listofAcc);
                AccountTriggerHelper.updateAccountInJobDiva(listofAcc);
                AccountTriggerHelper.checkIfAccountIsPresentInSF(listofAcc);
         Test.StopTest();
    }
}