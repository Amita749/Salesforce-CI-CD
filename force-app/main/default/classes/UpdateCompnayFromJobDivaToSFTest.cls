@isTest
private class UpdateCompnayFromJobDivaToSFTest {
@testSetup 
    static void testDataSetup() {
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
         accRec.CompanyID__c='8125908';          
         Insert accRec; 
        
        Account accRecOne = new Account();
        accRecOne.id=accRec.Id;
        accRecOne.name='test class data';
        accRecOne.Phone='0987656789';
        update accRecOne;
    }
    @isTest 
    public static void  testCallout()
    {
         test.starttest();
              List<Account> listOfAcc = [SELECT Id,Name,Industry,type,Website,CompanyID__c,ParentId,Parent.name,Phone,Fax,Email__c,Weekending__c,OwnerId,owner.name,BillingStreet, BillingCity, BillingState, BillingPostalCode,
                                         BillingCountry FROM Account where CompanyID__c='8125908'];
              System.debug('account-->'+listOfAcc[0].CompanyID__c);
              Date toDate= Date.today();
              Date fromDate=Date.today();
              //Date fromDate= toDate.addDays(-14);
              Test.setMock(HttpCalloutMock.Class, new MockHttpResponseGeneratorTest());
              UpdateCompnayFromJobDivaToSF batchObj= new UpdateCompnayFromJobDivaToSF(toDate,fromDate);
              Id jobid= Database.executeBatch(batchObj);
              String sch = '0 0 5 * * ?';
              System.schedule('JobDiva to Sf Company Update', sch, batchObj );
         test.stoptest();
    }
}