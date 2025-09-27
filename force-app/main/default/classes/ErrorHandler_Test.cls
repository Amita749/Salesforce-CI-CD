@IsTest
public with sharing class ErrorHandler_Test {
    
    @isTest
    public static void insertErrorList () {
      Test.startTest();
      List<ErrorLog__c> errList = TestDataFactory.createErrorList();
           insert errList;
        try{
            Opportunity Opp = new Opportunity(StageName='Demonstrating value');
            insert Opp;
        }
        catch(Exception ex){
          ErrorHandler.addError(ex, 'methodName', 'className', errList);
          ErrorHandler.addError(ex, 'methodName', 'className', errList, TRUE);  
        }
      
      Test.stopTest();
        
    }
   
}