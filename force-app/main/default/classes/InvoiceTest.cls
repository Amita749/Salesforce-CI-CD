@IsTest
public with sharing class InvoiceTest {
   @IsTest
    static void testAdd() {
        Integer result = Invoice.add(5, 7);
        System.assertEquals(12, result, 'Add method should return the sum of two numbers');
    }
}