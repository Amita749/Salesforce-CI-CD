/**
    *   @description  Helper class for Account trigger
    *   @author       DynPro 
*/
public class AccountTriggerHelper {
       
        public static void createAccountInJobDiva(List<Account> listOfAccount)
        {      
                Set<Id> setOfAccIdsTocreate = new Set<Id>();
                for(Account accRecord : listOfAccount){
                    setOfAccIdsTocreate.add(accRecord.Id);                   
                }
               CreateCompanyFromSFToJobDiva.createCompnayInJobDiva(setOfAccIdsTocreate);
             
        }
        public static void updateAccountInJobDiva(List<Account> listOfUpdatedAccount)
        {             
                Set<Id> setOfAccIdsToUpdate = new Set<Id>();
                for(Account accRecord : listOfUpdatedAccount){
                    setOfAccIdsToUpdate.add(accRecord.Id);
                }
               CreateCompanyFromSFToJobDiva.updateCompnayInJobDiva(setOfAccIdsToUpdate);              
        } 
       /* public static void chekIfCompanyExistInJondiva(List<Account> listOfAccountToCreate)
        {             
               Set<Id> setOfAccIdsToCreate = new Set<Id>();
                for(Account accRecord : listOfAccountToCreate){
                    setOfAccIdsToCreate.add(accRecord.Id);
                }
               CreateCompanyFromSFToJobDiva.chekCompanyExistInJondiva(setOfAccIdsToCreate);
               System.debug('after insert chekIfCompanyExistInJondiva invoked!!!');              
        }  */
         public static void checkIfAccountIsPresentInSF(List<Account> listOfNewAccount)
         { 
            
            Map<String,String> mapofAccounts = new Map<String,String>();
             for(Account accRec : [select Id,Name from account]){
                mapofAccounts.put(accRec.Name.toUppercase(),accRec.Id);
             }
             for(Account acct : listOfNewAccount){
                 String accountName=acct.Name.toUppercase();                  
                 if(mapofAccounts.ContainsKey(accountName)){                                       
                      acct.addError('This Account is already Present in Salesforce.Please enter diffrent Account');
                 }
             }
         }
}