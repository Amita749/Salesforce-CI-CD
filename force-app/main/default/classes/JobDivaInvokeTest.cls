@isTest(SeeAllData=true)
private  class JobDivaInvokeTest {
  @isTest  
  private static  void doTest() {
         
         test.startTest();
           JobDivaInvoke.invokeBatch();
           Test.setMock(HttpCalloutMock.Class, new MockHttpResponseGeneratorTest()); 
           JobDivaIntegration_FromJobDivaToSF accessBatch = new JobDivaIntegration_FromJobDivaToSF();
           Database.executeBatch(accessBatch, 20);
         test.stoptest();
    }
}