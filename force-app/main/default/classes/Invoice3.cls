@IsTest
private class Invoice3Test {
    @IsTest
    static void testConstructor() {
        // Instantiate the class
        Invoice3 inv = new Invoice3();
        
        // Optional: assert that the instance is not null
        System.assertNotEquals(null, inv, 'Invoice3 instance should be created');
    }
}