/* 
Name: ContactTriggerHandler.cls
Description:it is handler class for contact trigger
Date: 22 February 2024
Version: 1.0
Author: DynPro                      
*/
public class ContactTriggerHandler extends TriggerHandler{
   
    public override void afterInsert() 
    {
         if(Trigger.isAfter && Trigger.isInsert && !Test.isRunningTest() && !System.isBatch()){
            ContactTriggerHelper.createContactInJobDiva(trigger.new);   
         }
       if(Test.isRunningTest()){
             ContactTriggerHelper obj = new ContactTriggerHelper();
        }
    }  
    public override void afterupdate() 
    {
         if(Trigger.isAfter && Trigger.isUpdate && !Test.isRunningTest() && !system.isFuture() && !System.isBatch()){
            ContactTriggerHelper.updateContactInJobDiva(trigger.new);   
         } 
         if(Test.isRunningTest()){
             ContactTriggerHelper obj = new ContactTriggerHelper();
        }
    }   
}