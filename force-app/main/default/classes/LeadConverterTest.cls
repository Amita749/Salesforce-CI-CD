@isTest
public class LeadConverterTest {

    @isTest
    static void testLeadConversionSuccess() {
        // Get a valid converted status
        String convertedStatus = [
            SELECT MasterLabel 
            FROM LeadStatus 
            WHERE IsConverted = true 
            LIMIT 1
        ].MasterLabel;

        // Create a valid Lead
        Lead testLead = new Lead(
            FirstName = 'John',
            LastName = 'Doe',
            Company = 'Test Company',
            Email = 'john.doe@example.com',
            Phone = '1234567890',
            Status = convertedStatus,
            Business_Unit__c = 'Salesforce'
        );
        insert testLead;

        // Prepare input for method
        LeadConverter.LeadInput input = new LeadConverter.LeadInput();
        input.leadId = testLead.Id;

        Test.startTest();
        List<LeadConverter.LeadOutput> results = LeadConverter.convertLead(new List<LeadConverter.LeadInput>{ input });
        Test.stopTest();

        // Assert conversion worked
        System.assertEquals(true, results[0].success);
        System.assertNotEquals(null, results[0].contactId);
        System.assertEquals(null, results[0].errorMessage);
    }
}