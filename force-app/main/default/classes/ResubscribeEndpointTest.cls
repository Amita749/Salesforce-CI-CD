@isTest
private class ResubscribeEndpointTest {

    @testSetup
    static void setupData() {
        // Create a test Contact
        Contact testContact = new Contact(
            FirstName = 'Test',
            LastName = 'User',
            Email = 'test@example.com',
            Unsubscribe__c = false
        );
        insert testContact;
    }

    @isTest
    static void testValidResubscribe() {
        Contact c = [SELECT Id, Unsubscribe__c FROM Contact LIMIT 1];

        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/unsubscribe/' + c.Id;
        req.httpMethod = 'GET';
        req.addParameter('id', c.Id);
        req.addParameter('token', 'secureToken123');

        RestContext.request = req;
        RestContext.response = new RestResponse();

        String result = ResubscribeEndpoint.doResubscribe();
        System.assertEquals('You have been successfully unsubscribed!', result);

        Contact updated = [SELECT Unsubscribe__c FROM Contact WHERE Id = :c.Id];
        System.assertEquals(true, updated.Unsubscribe__c);
    }

    @isTest
    static void testInvalidToken() {
        Contact c = [SELECT Id FROM Contact LIMIT 1];

        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/unsubscribe/' + c.Id;
        req.httpMethod = 'GET';
        req.addParameter('id', c.Id);
        req.addParameter('token', 'wrongToken');

        RestContext.request = req;
        RestContext.response = new RestResponse();

        String result = ResubscribeEndpoint.doResubscribe();
        System.assertEquals('Unauthorized request.', result);
    }

    @isTest
    static void testMissingContactId() {
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/unsubscribe/';
        req.httpMethod = 'GET';
        req.addParameter('token', 'secureToken123');

        RestContext.request = req;
        RestContext.response = new RestResponse();

        String result = ResubscribeEndpoint.doResubscribe();
        System.assertEquals('Missing Contact ID.', result);
    }

    @isTest
    static void testContactNotFound() {
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/unsubscribe/';
        req.httpMethod = 'GET';
        req.addParameter('id', '003000000000000AAA'); // Fake ID
        req.addParameter('token', 'secureToken123');

        RestContext.request = req;
        RestContext.response = new RestResponse();

        String result = ResubscribeEndpoint.doResubscribe();
        System.assertEquals('No contact found for the given ID.', result);
    }
}