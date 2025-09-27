/**
 * @description       : 
 * @author            : Rhishikesh Sapkal
 * @group             : 
 * @last modified on  : 03-08-2024
 * @last modified by  : Rhishikesh Sapkal
**/
public class OneDriveIntegrationContants {
    // public static String driveId = '4225c0e8-d50f-4f76-ac90-e56d02da3e21';
    //public static String driveId = '522e9f6d-99ca-4e82-b244-91b18a8b2fd6'; //CLZ
    public static String driveId = 'b!8ta1zegmg02HNO0P3r-rdN6vNml-BzVPnroKZTMEa57-BYyz4_LNT6lUcZ37NfLP'; //DYnpro

    // public static String mainFolderId = '01DOFYM6WSUYXLWKCNFZG3YYIYAWMRG26F';
    // public static String mainFolderId = '01YRJ35NQCFMR4TYPR3ZFK3V7IWVRDNRPJ'; //CLZ
    public static String mainFolderId = '01AEQUF55KXH2ZD3A3MRFI3NB7BOWJRZOO';//DYnpro

    // public static String tenantId = '02c5b066-c072-4b82-9474-43accc1385c6';
    public static String tenantId = '02c5b066-c072-4b82-9474-43accc1385c6';//DYnpro

    public static String createFolderURL = 'https://graph.microsoft.com/v1.0/drives/{0}/items/{1}/children';
    public static String getFolderDocuments = 'https://graph.microsoft.com/v1.0/drives/{0}/items/{1}/children';
    public static String deleteFolderURL = 'https://graph.microsoft.com/v1.0/drives/{0}/items/{1}';
    public static String uploadDocumentURL = 'https://graph.microsoft.com/v1.0/drives/{0}/items/{1}:/{2}:/content?@microsoft.graph.conflictBehavior=rename';
    public static Integer maxDepth = 5;
}