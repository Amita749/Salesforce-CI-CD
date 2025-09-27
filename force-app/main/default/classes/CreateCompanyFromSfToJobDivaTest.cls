@isTest
public class CreateCompanyFromSfToJobDivaTest {
    @testSetup 
     static void testDataSetup() {
         Account accRec = new Account();
         accRec.Name='Cisco india';
         accRec.Industry='banking';
         accRec.CompanyTypes__c='Supplier';
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
     }
     @isTest 
     public static void callFutureMethod() {          
         
          List<Account> listofAcc=[SELECT Id,Name,Industry,type,Website,ParentId,Parent.name,Phone,Fax,Email__c,Weekending__c,OwnerId,owner.name,BillingStreet, BillingCity, BillingState, BillingPostalCode,
                                 BillingCountry,CompanyID__c FROM Account limit 1];
          Set<Id> setOfAccIds = new Set<Id>();
          
          setOfAccIds.add(listofAcc[0].Id);
          
          Test.startTest();
              Test.setMock(HttpCalloutMock.Class, new MockHttpResponseGeneratorTest(false)); 
              CreateCompanyFromSFToJobDiva.createCompnayInJobDiva(setOfAccIds);
              CreateCompanyFromSFToJobDiva.updateCompnayInJobDiva(setOfAccIds);
          Test.stopTest();
     }
     @isTest 
     public static  void callFutureMethodSecond() {          
        
         Account listofAcc=[SELECT Id,Name,Industry,type,Website,ParentId,Parent.name,Phone,Fax,Email__c,Weekending__c,OwnerId,owner.name,BillingStreet, BillingCity, BillingState, BillingPostalCode,
                                 BillingCountry,CompanyID__c
                                 FROM Account limit 1];
          Set<Id> setOfAccIds = new Set<Id>();
          setOfAccIds.add(listofAcc.Id);
                
          Test.startTest();
              Test.setMock(HttpCalloutMock.Class, new MockHttpResponseGeneratorTest(true)); 
              CreateCompanyFromSFToJobDiva.createCompnayInJobDiva(setOfAccIds);
              CreateCompanyFromSFToJobDiva.updateCompnayInJobDiva(setOfAccIds);
          Test.stopTest();
     }
}