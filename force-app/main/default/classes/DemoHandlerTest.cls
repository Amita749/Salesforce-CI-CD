@isTest
public with sharing class DemoHandlerTest {
    @IsTest
    public static void testInDemoHandler() {
        Integer result = DemoHandler.InDemoHandler(5, 10, 15);
        System.assertEquals(30, result, '5 + 10 + 15 should equal 30');
    }
}