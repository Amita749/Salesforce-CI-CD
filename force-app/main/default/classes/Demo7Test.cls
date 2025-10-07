@isTest
public with sharing class Demo7Test {
    @isTest
    public Demo7Test() {
        Test.startTest();
        Demo7 obj = new Demo7();
        Test.stopTest();
    }
    @isTest
    public static void testAddNumbers() {
        Integer result = Demo7.addNumbers(5, 10);
        System.assertEquals(15, result, '5 + 10 should equal 15');
    }
}