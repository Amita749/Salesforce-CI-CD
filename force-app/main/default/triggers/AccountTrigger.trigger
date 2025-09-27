/**
    *   @description  Handler class for Account trigger
    *   @author       DynPro 
*/
trigger AccountTrigger on Account (after insert, after update,before insert) {
    
    DisabledTrigger__c obj = DisabledTrigger__c.getInstance();  
    if(obj.IsActive__c == true){
        new AccountTriggerHandler().run();   
    }  
}