public class ErrorHandler {
 public static void addError(Exception ex,String methodName,String className, List<ErrorLog__c> errorLogList)
    {           
        ErrorLog__c errRec = new ErrorLog__c();
        //errRec.RecordId__c=recordId; //Remove recordId
        errRec.ClassTriggerName__c=className;
        errRec.ErrorDescription__c=ex.getMessage();
        errRec.MethodName__c = methodName;
        errRec.ErrorType__c=ex.getTypeName();
        errRec.LineNumber__c=String.valueOf(ex.getLineNumber());
        errRec.SendEmailNotification__c=false;
        errRec.UserId__c=System.UserInfo.getUserId();      
        errRec.StackTrace__c = ex.getStackTraceString();
        errRec.Cause__c = String.valueOf(ex.getCause());
        errorLogList.add(errRec);
        insertLogs(errorLogList); 
    }
    public static void addError(Exception ex,String methodName,String className, List<ErrorLog__c> errorLogList, Boolean isNotify)
    { 
        String recordId;
        System.debug('exception type: '+ex.getTypeName());
        if(ex.getTypeName() =='System.DmlException'){
            for (Integer index = 0; index < ex.getNumDml(); index++){
                System.debug('1 exception id:'+ ex.getDmlId(index) + ' on fields ' + ex.getDmlFieldNames(index) );   
                recordId = ex.getDmlId(index);
            }
        }
        ErrorLog__c errRec = new ErrorLog__c();
        errRec.ClassTriggerName__c=className;
        errRec.ErrorDescription__c=ex.getMessage();
        errRec.MethodName__c = methodName;
        errRec.ErrorType__c=ex.getTypeName();
        errRec.LineNumber__c=String.valueOf(ex.getLineNumber());
        errRec.SendEmailNotification__c=isNotify;
        errRec.UserId__c=System.UserInfo.getUserId();      
        errRec.StackTrace__c = ex.getStackTraceString();
        errRec.Cause__c = String.valueOf(ex.getCause());
        errRec.RecordId__c = recordId;
        errorLogList.add(errRec);
        insertLogs(errorLogList);        
    }
    public static void insertLogs(List<ErrorLog__c> errorLogList){
        if(!errorLogList.isEmpty()){
            //insert errorLogList;
            Database.insert(errorLogList,false);
            System.debug('error log list-->'+errorLogList);
        }
    }
}