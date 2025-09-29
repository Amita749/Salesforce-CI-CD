@isTest
public with sharing class Demo3Test {
    @IsTest
    static void testDemo3Add() {
    Integer result = Demo3.Demo3add(5, 10);
        System.assertEquals(15, result, '5 + 10 should equal 15');
    }
}