@RestResource(urlMapping='/unsubscribe/*')
global with sharing class ResubscribeEndpoint {

    @HttpGet
    global static String doResubscribe() {
        RestRequest req = RestContext.request;
        String contactId = req.params.get('id');
        String token = req.params.get('token');

        // Optional security check
        if (token != 'secureToken123') {
            return 'Unauthorized request.';
        }

        if (String.isBlank(contactId)) {
            return 'Missing Contact ID.';
        }

        List<Contact> contacts = [
            SELECT Id, Unsubscribe__c 
            FROM Contact 
            WHERE Id = :contactId 
            LIMIT 1
        ];

        if (contacts.isEmpty()) {
            return 'No contact found for the given ID.';
        }

        Contact c = contacts[0];
        c.Unsubscribe__c = true;

        try {
            update c;
            return 'You have been successfully unsubscribed!';
        } catch (Exception e) {
            return 'Error updating contact: ' + e.getMessage();
        }
    }
}