@isTest
public class TestDataFactory {
     public static List<ErrorLog__c> errorList = new List<ErrorLog__c>();
 public static List<ErrorLog__c> createErrorList () {

        for(Integer i=0; i<=5; i++){
            ErrorLog__c errRec = new ErrorLog__c();
            errRec.ClassTriggerName__c = 'OpportunityLineItemTriggerHelper';
            errRec.ErrorDescription__c = 'SObject row was retrieved via SOQL without querying the requested field: QuoteLineItem.Category__c';
            errRec.MethodName__c = 'UpdateOpptyLineItems';
            errRec.ErrorType__c = 'System.SObjectException';
            errRec.LineNumber__c = '35';
            errRec.SendEmailNotification__c = false;
            errRec.UserId__c= System.UserInfo.getUserId();      
            errRec.StackTrace__c = 'Class.OpportunityLineItemTriggerHelper.UpdateOpptyLineItems: line 35, column 1 Class.OpportunityLineItemTriggerHandler.beforeInsert: line 15, column 1';
            errRec.Cause__c = '';
            errorList.add(errRec);
        }
        return errorList;
    }
}