/**
    *   @description  Helper class for Job_Requisition__c trigger
    *   @author       DynPro 
*/
public class JobTriggerHelper 
{        
    public static void createJobRecInJobDiva(List<Job_Requisition__c> listOfRecordToBeCreate)    
    {          
        Set<Id> setOfIdsTocreate = new Set<Id>();
        for(Job_Requisition__c record : listOfRecordToBeCreate)
        {
            setOfIdsTocreate.add(record.Id);
        }
        JobDivaIntegration_FromSFToJobDiva.createJobInJobDiva(setOfIdsTocreate);
    }
    public static void updateJobRecInJobDiva(List<Job_Requisition__c> updatedRecordList)    
    {
            Set<Id> setOfIdsToUpdate = new Set<Id>();
            for(Job_Requisition__c record :updatedRecordList)
            {
                setOfIdsToUpdate.add(record.Id);
            }
           JobDivaIntegration_FromSFToJobDiva.updateJobInJobDiva(setOfIdsToUpdate);
    }
}