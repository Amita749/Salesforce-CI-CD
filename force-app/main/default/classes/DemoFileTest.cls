@IsTest
public with sharing class DemoFileTest {
   @IsTest
    static void testAddNum() {
        Integer result = DemoFile.addNum(5, 10);
        System.assertEquals(15, result, '5 + 10 should equal 15');
}
}