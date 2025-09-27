@isTest
private class JobDivaAuthorizationTest {
   @isTest 
    public static void  testCallout(){
           Test.setMock(HttpCalloutMock.Class, new MockHttpResponseGeneratorTest());
           JobDivaAuthorization.authenticationWithJobDiva();
  }
}