@IsTest
public with sharing class AccTest {
      @IsTest
    static void addTest() {
        Integer result = Acc.add(5, 7);
        System.assertEquals(12, result, 'Add method should return the sum of two numbers');
    }
    }
