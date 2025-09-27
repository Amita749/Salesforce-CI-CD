/**
    *   @description  Helper class for Lead trigger
    *   @author       DynPro 
*/
public class LeadTriggerhelper {
    public static Boolean Flag=true;
    public static void assignLeadOwner(List<Lead> listOfNewLead){
        if(Flag)
        {
            Flag=false;
            system.debug('Lead helper invoked-->');
            List<User> listofuser=[select id,name from user where name like'Tyler%'];
            for(Lead leadRec : listOfNewLead){
                if(leadRec.LeadSource == 'DynPro Contact Us') 
                {
                    List<Account> listOfAcc=Database.query('SELECT ID,name,OwnerId from Account where name like\''+'%'+leadRec.company+'%\'');
                  
                    if(listOfAcc.size() >0)
                    {    
                         leadRec.AccountOwner__c =listOfAcc[0].OwnerId;
                                              
                    }else{                         
                         leadRec.AccountOwner__c =listofuser[0].Id;
                    }   	 
                
               }
            }
         }
     } 
    
}