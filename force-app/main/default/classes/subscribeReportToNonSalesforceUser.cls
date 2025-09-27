/* -------------------------------------------------------------------------------------------------
Name:            subscribeReportToNonSalesforceUser.cls
Description:     Used to Run&Subscribe a Report to Non Salesforce User

Date             Version     Author          Summary of Changes 
-----------      ----------  ------------    --------------------------------------------------
July 2024        1.0         DynPro      Initial Release
--------------------------------------------------------------------------------------------------*/
public class subscribeReportToNonSalesforceUser {
   @future(callout=true)
    public static  void runReportAndSendResult(){
        
        List <Report> reportList = [SELECT Id,DeveloperName FROM Report WHERE 
                                    DeveloperName =:System.Label.SubscribeReportName];

        String reportId = (String)reportList.get(0).get('Id');
        
        //Run the report        
        Reports.ReportResults results = Reports.ReportManager.runReport(reportId, true);
        String instanceName = URL.getOrgDomainUrl().toExternalForm();
        string url=instanceName+'/servlet/PrintableViewDownloadServlet?isdtp=p1&reportId='+reportId;
        ApexPages.PageReference objPage = new ApexPages.PageReference(url);
        
        //Get report content
         Blob content;
        if(Test.isRunningTest())
         {
             content=blob.valueOf('Unit.Test');
         }else{
              content=objPage.getContent();
         }
        
        
        Messaging.EmailFileAttachment objMsgEmailAttach = new Messaging.EmailFileAttachment();
        objMsgEmailAttach.setFileName('OpportunitiesDetails'+'.xlsx');
        objMsgEmailAttach.setBody(content);
        objMsgEmailAttach.setContentType('text/xlsx');
        
        List<OrgWideEmailAddress> orgWideEmailAddress=[select Id,address,displayName from OrgWideEmailAddress WHERE displayName='noreply@salesforce.com'];
        List<EmailTemplate> templates = [SELECT Id, Subject,HtmlValue,body FROM EmailTemplate WHERE DeveloperName = 'SubscribeReportNonSFUser'];  
       
        String toaddress=System.label.Subscribe_ReportNonSFUser;
        List<String> listoftoAddress = new List<String>();
        listoftoAddress=toaddress.Split(';');
        
        //listoftoAddress.add(str); 
        System.debug('to address--->'+listoftoAddress);
        
        Messaging.SingleEmailMessage mailMsg = new Messaging.SingleEmailMessage();
        
        mailMsg.setToAddresses(listoftoAddress);        
        mailMsg.setTemplateId(templates[0].Id);
        mailMsg.setSubject(templates[0].Subject);
        mailMsg.setOrgWideEmailAddressId(orgWideEmailAddress[0].Id);
        String body = templates[0].body;
        mailMsg.setHtmlBody(body); 
        mailMsg.setFileAttachments(new Messaging.EmailFileAttachment[]{objMsgEmailAttach}); 
        Messaging.SendEmailResult[] sendResults = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mailMsg}, false);
    }
    
}