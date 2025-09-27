/* -------------------------------------------------------------------------------------------------
Name:            scheduledSubscribeReport.cls
Description:     Scheduled subscribeReportToNonSalesforceUser Apex class on weekly

Date             Version     Author          Summary of Changes 
-----------      ----------  ------------    --------------------------------------------------
July 2024        1.0         DynPro      Initial Release
--------------------------------------------------------------------------------------------------*/
global class scheduledSubscribeReport Implements Schedulable{

        global void execute(SchedulableContext sc)
        {
           subscribeReportToNonSalesforceUser.runReportAndSendResult();
        }    
}