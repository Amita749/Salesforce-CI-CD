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
     @IsTest
    public static void testsub() {
        Integer result = DemoHandler.subNum(100,40);
        System.assertEquals(60, result, '100-40 should equal 60');
    }
    @IsTest
    public static void testmul() {
        Integer result = DemoHandler.mulNum(5,10);
        System.assertEquals(50, result, '5*10 should equal 50');
    }
     @IsTest
    public static void testdiv() {
        Integer result = DemoHandler.divNum(50,10);
        System.assertEquals(5, result, '5 should equal 5');
    }
}