@isTest
private class ContactTriggerHelperTest {
    @testSetup 
    static void testDataSetup() {
         Profile salesPersonProfile = [Select Id From Profile Where Name = 'System Administrator'];
         DisabledTrigger__c obj = new DisabledTrigger__c(); 
         obj.name='DisabledTrigger';
         obj.IsActive__c=true;
         Insert obj;
         Account accRec = new Account();
         accRec.Name='Cisco india';
         accRec.CompanyID__c='9378125'; 
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
        
        Contact con= new Contact();
        con.id=conRec.Id;
        con.Department='Finance';
        con.Title='tester';
        con.Email='testing@gmail.com';
        update con;
     }
    private static testMethod void callFutureMethod() {
        List<Contact> listofContact=[SELECT Id,Name,AccountId,Account.name,Salutation,FirstName,LastName,Department,Title,Email,AlternateEmail__c,HomePhone,Fax,Phone,MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry
                                       FROM Contact Limit 1];
         
       Test.startTest();
              Test.setMock(HttpCalloutMock.Class, new MockHttpResponseGeneratorTest(true)); 
               ContactTriggerHelper.createContactInJobDiva(listofContact);
               ContactTriggerHelper.updateContactInJobDiva(listofContact);        
        Test.StopTest();
    }
}