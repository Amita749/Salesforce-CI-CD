@isTest
public class UpdateContactFromJobDivaToSFTest {
  @testSetup 
    static void testDataSetup() {
        Account accRec = new Account();
         accRec.Name='Cisco india';
         accRec.CompanyID__c='8125908'; 
         accRec.Website='www.test.com';
         accRec.Phone='9347833';
         accRec.Fax='33489';
         accRec.Email__c='sangetac350@gmail.com';
         Insert accRec; 
        
        Contact conRec = new Contact();        
        conRec.AccountId=accRec.Id;
        conRec.Salutation='mr.';
        conRec.FirstName='Test';
        conRec.LastName='tesing-';
        conRec.Department='HR';
        conRec.Title='Developer';
        conRec.Email='test@gmail.com';
        conRec.AlternateEmail__c='testingrecord@gmail.com';
        conRec.HomePhone='9034423';
        conRec.Fax='3442432';
        conRec.Phone='343442';
        conRec.MailingStreet='suit 500';
        conRec.MailingCity='Newyork';
        conRec.MailingState='CA';
        conRec.MailingPostalCode='4324';
        conRec.MailingCountry='united states';
        insert conRec;
    }
     private static testMethod void callFutureMethod() {
          
          List<Contact> listofContact=[SELECT Id,Name,AccountId,Account.name,Salutation,FirstName,LastName,Department,Title,Email,AlternateEmail__c,HomePhone,Fax,Phone,MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry
                                       FROM Contact limit 1];
         Test.startTest();
                 Test.setMock(HttpCalloutMock.Class, new MockHttpResponseGeneratorTest());
                 UpdateContactFromJobDivaToSF obj = new UpdateContactFromJobDivaToSF();
                 Database.executeBatch(obj);
                String sch = '0 0 20 * * ?';
                System.schedule('JobDiva to Sf Contact Update', sch, obj);
         Test.stopTest();
     }    
}