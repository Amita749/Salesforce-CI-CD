public class CreatingDemoRecord 
{
    public static demo__c demo(account ac , contact c )
    {
        demo__c d = new demo__c ();
        d.Name = 'Dynpro Demo';
        d.Account__c = ac.id;
        d.Contact__c= c.id;
        d.Are_You_Indian__c = true;
        d.Is_Checked__c = true;
        d.State__c = 'MH';
        insert d;
        system.debug(d);
        return d;
    }

}