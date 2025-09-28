@IsTest
public class InvoiceHelperTest {

    @IsTest
    static void testAdd() {
        Integer result = InvoiceHelper.add(5, 7);
        System.assertEquals(12, result, 'Add method should return the sum of two numbers');
    }
}