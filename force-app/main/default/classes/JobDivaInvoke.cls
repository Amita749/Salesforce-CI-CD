/* 
Name: JobDivaInvoke.cls
Description: This class is called from the flow - InvokeJobDiva, It calls the batch class to bring in the updates from JobDiva to SF on that particular record.
Date: 02 February 2024
Version: 1.0
Author: Minal Patil                       
*/
public class JobDivaInvoke {
    @InvocableMethod
    public static void invokeBatch() {
        JobDivaIntegration_FromJobDivaToSF accessBatch = new JobDivaIntegration_FromJobDivaToSF();
        Database.executeBatch(accessBatch, 20);
    }
}