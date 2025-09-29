@isTest
public with sharing class DemoHandlerTest {
    @IsTest
    public static void testInDemoHandler() {
        Integer result = DemoHandler.InDemoHandler(5, 10, 15);
        System.assertEquals(30, result, '5 + 10 + 15 should equal 30');
    }
     @IsTest
    public static void testadd() {
        Integer result = DemoHandler.addNum(5, 10, 15,20);
        System.assertEquals(50, result, '5 + 10 + 15 +20 should equal 50');
    }
}