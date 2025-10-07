@isTest
public with sharing class InvoiceHandlerTest {
    @isTest
    public static void testInvoiceHandler() {
        Test.startTest();
        InvoiceHandler handler = new InvoiceHandler();
        Test.stopTest();
    }
     @IsTest
    public static void addInvoiceHandler() {
        Integer result = InvoiceHandler.addNum(5, 10);
        System.assertEquals(15, result, '5+10 should equal 15');
    }
}