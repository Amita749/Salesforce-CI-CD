@istest
public class CreatingDemoRecordTest {
    @istest
    static void callingdemo()
    {
        account ac = new account (name='demo');
        insert ac;
        contact c = new contact (firstname= 'Dynpro',lastname='Demo',accountid=ac.id);
        insert c;
        CreatingDemoRecord.demo(ac,c);
        
    }

}