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
    @ISTest 
    public static void mulInvoiceHandler() {
        Integer result = InvoiceHandler.mulNum(50, 10);
        System.assertEquals(500, result, '50*10 should equal 500');
    }
    @isTest 
    public static void subInvoiceHandler() {
        Integer result = InvoiceHandler.subNum(50, 10);
        System.assertEquals(40, result, '50-10 should equal 40');
    }
}