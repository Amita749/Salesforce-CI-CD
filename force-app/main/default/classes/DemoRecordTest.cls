@isTest
public with sharing class DemoRecordTest {
@isTest
    public static void DemoRecordTest() {
    Test.startTest();
        DemoRecord demo = new DemoRecord();
        Test.stopTest();
    }
    @IsTest
    public static void addDemoRecordTest() {
        Integer result = DemoRecord.addNum(5, 10);
        System.assertEquals(15, result, '5+10 should equal 15');
    }
}