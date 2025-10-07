@isTest
public with sharing class DemoRecordTest {
@isTest
    public static void DemoRecordTest() {
    Test.startTest();
        DemoRecord demo = new DemoRecord();
        Test.stopTest();
    }
    @IsTest
    public static void multiplyTest() {
        Integer result = DemoRecord.multiply(10, 5);
        System.assertEquals(50, result, '5*10 should equal 50');
    }
}