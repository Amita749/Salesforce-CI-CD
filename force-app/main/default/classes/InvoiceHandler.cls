public with sharing class InvoiceHandler {
    public InvoiceHandler() {
    System.debug('InvoiceHandler constructor called');
    }
    public static Integer addNum(Integer a, Integer b) {
     return a+b;
    }
    public static Integer addSub(Integer a, Integer b) {
     return a-b;
    }
}