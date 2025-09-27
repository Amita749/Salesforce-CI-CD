/**
    *   @description  Trigger for Job_Requisition__c trigger
    *   @author       DynPro 
*/
trigger JobTrigger on Job_Requisition__c (after insert,after update) {
    
    DisabledTrigger__c obj = DisabledTrigger__c.getInstance();  
    if(obj.IsActive__c == true){
        new JobTriggerHandler().run();
    }
}