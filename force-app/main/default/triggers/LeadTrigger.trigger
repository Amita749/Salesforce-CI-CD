/**
    *   @description  Lead trigger to perform various operation on Lead Object
    *   @author       DynPro 
*/
trigger LeadTrigger on Lead (before insert) {
    
    DisabledTrigger__c obj = DisabledTrigger__c.getInstance();     
    if(obj.IsActive__c == true)
    {
         new LeadTriggerHandler().run();  
         system.debug('Lead trigger invoked-->');
    } 
         
}