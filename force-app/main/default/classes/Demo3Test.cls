public with sharing class Demo3Test {
    public Demo3Test() {
    Integer result = Demo3.Demo3add(5, 10);
        System.assertEquals(15, result, '5 + 10 should equal 15');
}
}