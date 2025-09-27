@isTest
private class HelloWorldClassTest {
    @isTest
    static void testSayHello() {
        Test.startTest();
        String result = HelloWorldClass.sayHello();
        Test.stopTest();

        System.assertEquals('Hello World', result, 'Method should return Hello World');
    }
}