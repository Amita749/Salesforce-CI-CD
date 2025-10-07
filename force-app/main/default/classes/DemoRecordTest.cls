@isTest
public with sharing class DemoRecordTest {
@isTest
    public static void DemoRecordTest() {
    Test.startTest();
        DemoRecord demo = new DemoRecord();
        Test.stopTest();
    }
     @IsTest
    public static void subDemoRecordTest() {
        Integer result = DemoRecord.subNum(15, 10);
        System.assertEquals(5, result, '15-10 should equal 5');
    }
}