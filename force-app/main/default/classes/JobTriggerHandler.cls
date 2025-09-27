/**
    *   @description  Handler class for Jon Job_Requisition__c trigger
    *   @author       DynPro 
*/
public class JobTriggerHandler extends TriggerHandler{
 
     public override void afterInsert() 
     {
         if(Trigger.isAfter && Trigger.isInsert){        
            if(!System.isBatch() && !Test.isRunningTest()){
                System.debug('Job trigger After insert Invoked--');
                JobTriggerHelper.createJobRecInJobDiva(trigger.new);               
            }
         }
         if(!System.isBatch() && !System.isFuture() && Test.isRunningTest())
         {
            
         }
     }
     public override void afterUpdate() 
     {
         if(!System.isBatch() && !System.isFuture() && !Test.isRunningTest()){
            System.debug('Job trigger After update Invoked--');
            JobTriggerHelper.updateJobRecInJobDiva(trigger.new); 
         }
         if(!System.isBatch() && !System.isFuture() && Test.isRunningTest())
         {
             
         }         
     }
}