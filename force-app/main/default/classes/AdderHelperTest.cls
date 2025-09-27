@isTest
public with sharing class AdderHelperTest {

    @IsTest
    static void testAddNumbers() {
        Integer result = AdderHelper.addNumbers(5, 10);
        System.assertEquals(15, result, '5 + 10 should equal 15');
}

    @IsTest
    static void testAddNum() {
        Integer result = AdderHelper.addNum(5, 10,2);
        System.assertEquals(17, result, '5 + 10+2 should equal 17');
}
     @IsTest
    static void testMulNum() {
        Integer result = AdderHelper.multiplyNum(5, 10,2);
        System.assertEquals(100, result, '5*10*2 should equal 100');
}
}