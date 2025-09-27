public class LeadConverter {
    
    public class LeadInput {
        @InvocableVariable(label='Lead Id' required=true)
        public Id leadId;
    }

    public class LeadOutput {
        @InvocableVariable(label='Was Converted')
        public Boolean success;
        @InvocableVariable(label='Contact Id')
        public Id contactId;
        @InvocableVariable(label='Error Message')
        public String errorMessage;
    }

    @InvocableMethod(label='Convert Lead with Account Match')
    public static List<LeadOutput> convertLead(List<LeadInput> inputs) {
        List<LeadOutput> results = new List<LeadOutput>();

        for (LeadInput input : inputs) {
            LeadOutput output = new LeadOutput();

            try {
                Lead leadRecord = [
                    SELECT Id, Company 
                    FROM Lead 
                    WHERE Id = :input.leadId 
                    LIMIT 1
                ];

                // Try to match existing Account by Company Name
                Account matchedAccount = null;
                List<Account> accounts = [
                    SELECT Id 
                    FROM Account 
                    WHERE Name = :leadRecord.Company 
                    LIMIT 1
                ];

                if (!accounts.isEmpty()) {
                    matchedAccount = accounts[0];
                }

                String convertedStatus = [
                    SELECT MasterLabel 
                    FROM LeadStatus 
                    WHERE IsConverted = true 
                    LIMIT 1
                ].MasterLabel;

                Database.LeadConvert lc = new Database.LeadConvert();
                lc.setLeadId(input.leadId);
                lc.setDoNotCreateOpportunity(true);
                lc.setConvertedStatus(convertedStatus);

                if (matchedAccount != null) {
                    lc.setAccountId(matchedAccount.Id); // Reuse existing account
                }

                Database.LeadConvertResult lcr = Database.convertLead(lc);

                output.success = lcr.isSuccess();
                output.contactId = lcr.getContactId();
                output.errorMessage = lcr.isSuccess() ? null : lcr.getErrors()[0].getMessage();
            } catch (Exception e) {
                output.success = false;
                output.errorMessage = e.getMessage();
            }

            results.add(output);
        }

        return results;
    }
}