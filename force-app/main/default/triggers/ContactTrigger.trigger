/* 
Name: ContactTrigger.cls
Description:it performs trigger level activities
Date: 22 February 2024
Version: 1.0
Author: DynPro                      
*/
trigger ContactTrigger on Contact (after insert,after update) {
    
    DisabledTrigger__c obj = DisabledTrigger__c.getInstance();  
    if(obj.IsActive__c == true){
        List<Contact> listOfNewcontact=Trigger.new;
        for(Contact conRec : listOfNewcontact)
            if(conRec.IsConvertedFromLead__c == true && trigger.IsInsert){
                System.debug('Trigger not fired');
                return;
            }else{
                 new ContactTriggerHandler().run();
            }     
    }    
}