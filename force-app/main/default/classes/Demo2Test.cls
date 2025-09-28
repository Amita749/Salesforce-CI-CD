public with sharing class Demo2Test {
    public Demo2Test() {
      Integer result = demo2.addNum(5, 10);
        System.assertEquals(15, result, '5 + 10 should equal 15');
}
    }
