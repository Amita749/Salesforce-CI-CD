/**
    *   @description  Helper class for Account trigger
    *   @author       DynPro 
*/
public class AccountTiggerHelper {
    
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
        /*public static void chekIfCompanyExistInJondiva(List<Account> listOfAccountToCreate)
        {             
               Set<Id> setOfAccIdsToCreate = new Set<Id>();
                for(Account accRecord : listOfAccountToCreate){
                    setOfAccIdsToCreate.add(accRecord.Id);
                }
               CreateCompanyFromSFToJobDiva.chekCompanyExistInJondiva(setOfAccIdsToCreate);
               System.debug('before insert chekIfCompanyExistInJondiva invoked!!!');
              
        }  */      

}