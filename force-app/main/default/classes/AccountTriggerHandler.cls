/**
    *   @description  Handler class for Account trigger
    *   @author       DynPro 
*/
public class AccountTriggerHandler extends TriggerHandler{

    public override void afterInsert() 
    {
         if(Trigger.isAfter && Trigger.isInsert && !Test.isRunningTest()){
            //AccountTriggerHelper.chekIfCompanyExistInJondiva(trigger.new); 
            AccountTriggerHelper.createAccountInJobDiva(trigger.new);                              
         }
         if(Test.isRunningTest()){
             AccountTriggerHelper obj = new AccountTriggerHelper();
        }
    } 
    public override void afterUpdate() 
    {
         if(Trigger.isAfter && Trigger.isUpdate && !Test.isRunningTest() && !system.isFuture() && !System.isBatch()){            
            AccountTriggerHelper.updateAccountInJobDiva(trigger.new);   
         }
        if(Test.isRunningTest()){
            AccountTriggerHelper obj = new AccountTriggerHelper();
        }
    }
    public override void beforeInsert() 
    {
        if(Trigger.isBefore && Trigger.IsInsert){
            AccountTriggerHelper.checkIfAccountIsPresentInSF(trigger.new);
        }
    }    
}