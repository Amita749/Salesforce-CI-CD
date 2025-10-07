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
        Integer result = InvoiceHandler.addSub(50, 10);
        System.assertEquals(5, result, '50-10 should equal 5');
    }
}