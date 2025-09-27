/**
 * @description       : 
 * @author            : Rhishikesh Sapkal
 * @group             : 
 * @last modified on  : 03-07-2024
 * @last modified by  : Rhishikesh Sapkal
**/
public class FolderNameGenerator {
    public static String getFolderName(String methodName, String recordId){
        if(methodName == 'getAccountFolderName'){
            return getAccountFolderName(recordId);
        } else if (methodName == 'getOpportunityFolderName'){
            return getOpportunityFolderName(recordId);
        }else if(methodName == 'getJobReqFolderName'){
            return getJobReqFolderName(recordId);
        }else if(methodName == 'getLeadFolderName'){
            return getLeadFolderName(recordId);
        }else if(methodName == 'getContactFolderName'){
            return getContactFolderName(recordId);
        }
        return null;
    }

    public static String getAccountFolderName(String recordId){
        Account acc = [SELECT Id, Name FROM Account WHERE ID=: recordId];
        return acc.Name;
    }

    public static String getOpportunityFolderName(String recordId){
        Opportunity opp = [SELECT Id, Name, CreatedDate FROM Opportunity WHERE ID=: recordId];
        Integer year = opp.CreatedDate.year();
        return opp.Name + ' ' + year;
    }

    public static String getJobReqFolderName(String recordId){
        Job_Requisition__c jobReq = [SELECT Id, JoDiva_Job_Id__c FROM Job_Requisition__c WHERE ID=: recordId];
        return jobReq.JoDiva_Job_Id__c;
    }

    public static String getLeadFolderName(String recordId){
        Lead leadRecord = [SELECT Id, Name FROM Lead WHERE ID=: recordId];
        return leadRecord.Name;
    }

    public static String getContactFolderName(String recordId){
        Contact conRecord = [SELECT Id, Name FROM Contact WHERE ID=: recordId];
        return conRecord.Name;
    }
}