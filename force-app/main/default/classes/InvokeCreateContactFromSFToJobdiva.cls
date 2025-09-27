/* 
Name: InvokeCreateContactFromSFToJobdiva.cls
Description:it is Apex class to call CreateContactFromSFToJobDiva calss future method.
Date: 22 April 2024
Version: 1.0
Author: DynPro                      
*/
public class InvokeCreateContactFromSFToJobdiva {
   @InvocableMethod(Label='Create Contact From Sf to Jobdiva' description = 'Contact List')
    public static void invokecreateContact(List<Contact> listOfContactToBeCreate) {
        
        Set<Id> setOfContactIds = new Set<Id>();
        for(Contact conRec : listOfContactToBeCreate){
            setOfContactIds.Add(conRec.Id);
        }
        CreateContactFromSFToJobDiva.createContactInJobDiva(setOfContactIds);
    }
}