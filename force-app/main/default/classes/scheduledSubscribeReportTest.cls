@isTest
public class scheduledSubscribeReportTest {
    @isTest(SeeAllData=true) 
    static void testSetup() { 
        Blob content;
        Test.startTest(); 
         List <Report> reportList = [SELECT Id,DeveloperName FROM Report WHERE 
                                   DeveloperName =:System.Label.SubscribeReportName];  
        System.debug('reportlist-->'+reportList);
        String reportId = (String)reportList.get(0).get('Id');      
        System.debug('reportIds-->'+reportId);    
        //Run the report 
        Reports.ReportMetadata reportMetadata = Reports.ReportManager.describeReport(reportId).getReportMetadata();      
        Reports.ReportResults results = Reports.ReportManager.runReport(reportId, true);
        String instanceName = URL.getOrgDomainUrl().toExternalForm();
        string url=instanceName+'/servlet/PrintableViewDownloadServlet?isdtp=p1&reportId='+reportId;
        ApexPages.PageReference objPage = new ApexPages.PageReference(url);
        
        
        Test.setCurrentPage(objPage);
        content=blob.valueOf('Unit.Test');
        subscribeReportToNonSalesforceUser.runReportAndSendResult();
        
        
            scheduledSubscribeReport obj = new scheduledSubscribeReport();        
            String sch = '0 0 10 * * ?'; 
            system.schedule('subscribe Report', sch, obj); 
        Test.stopTest();
     }

}