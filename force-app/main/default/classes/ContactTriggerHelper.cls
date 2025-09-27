/* 
Name: ContactTriggerHelper.cls
Description:it is helper class for contact trigger
Date: 22 February 2024
Version: 1.0
Author: DynPro                      
*/
public class ContactTriggerHelper {
    
   public static void createContactInJobDiva(List<Contact> listOfNewContact)
    {
            Set<Id> setOfConIdsTocreate = new Set<Id>();
            for(Contact conRecord : listOfNewContact){
                setOfConIdsTocreate.add(conRecord.Id);
            }
            if(!setOfConIdsTocreate.isEmpty()){
               CreateContactFromSFToJobDiva.createContactInJobDiva(setOfConIdsTocreate); 
            }
    } 
    public static void updateContactInJobDiva(List<Contact> listOfupdatedContact)
    {
            Set<Id> setOfConIdsToUpdate = new Set<Id>();
            for(Contact conRecord : listOfupdatedContact){
                setOfConIdsToUpdate.add(conRecord.Id);
            }
            if(!setOfConIdsToUpdate.isEmpty()){
                CreateContactFromSFToJobDiva.updateContactInJobDiva(setOfConIdsToUpdate);
            }
    } 
}