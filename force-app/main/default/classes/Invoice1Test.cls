@IsTest
public class Invoice1Test {
 @IsTest
    static void testAdd() {
        Integer result = Invoice1.add(5, 7);
        System.assertEquals(12, result, 'Add method should return the sum of two numbers');
    }
}