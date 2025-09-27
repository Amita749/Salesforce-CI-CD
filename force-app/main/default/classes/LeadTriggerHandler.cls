/**
    *   @description  Handler class for Lead trigger
    *   @author       DynPro 
*/
public class LeadTriggerHandler extends TriggerHandler {

    public override void beforeInsert() 
    {
         system.debug('Lead handler beforeInsert invoked-->');
         LeadTriggerhelper.assignLeadOwner(trigger.new);
    }
}