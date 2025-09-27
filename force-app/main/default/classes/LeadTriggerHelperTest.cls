@isTest
public class LeadTriggerHelperTest {
    @testSetup 
    static void testDataSetup() {
         Profile adminProfile = [Select Id From Profile Where Name = 'System Administrator'];
         DisabledTrigger__c obj = new DisabledTrigger__c(); 
         obj.name='DisabledTrigger';
         obj.IsActive__c=true;
         Insert obj; 
        
        //User ownerRec=[select id,name from User where profileId=:adminProfile.Id limit 1];
        user u = New User(
            UserName = 'test_' + math.random() + '@test.com',
            FirstName = 'Test-First',
            LastName = 'Test-Last',
            Alias = 'test',
            email = 'test' + math.random() + '@test.com',
            CommunityNickName = string.valueOf(math.random()).substring(0,6),
            ProfileID = adminProfile.id,
            TimeZoneSidKey = 'America/New_York', 
            LocaleSidKey = 'en_US', 
            EmailEncodingKey = 'UTF-8', 
            LanguageLocaleKey = 'en_US'            
         );
       insert u;
        
        Lead leadRec = new Lead();
        leadRec.FirstName='test';
        leadRec.LastName=' one-';
        leadRec.Company='Web';
        leadRec.OwnerId=u.Id;
        leadRec.Email='test@gmail.com';
        leadRec.City='pune';
        leadRec.Country='india';
        leadRec.LeadSource='DynPro Contact Us';
        
        insert leadRec;
    }
    public static testMethod void assignleadOwner() {
        List<lead> leadList=[select id,name,company,Email,city,country from lead limit 1];
    }
}