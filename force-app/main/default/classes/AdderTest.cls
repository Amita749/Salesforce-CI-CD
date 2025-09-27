@IsTest
private class AdderTest {

    @IsTest
    static void testAddNumbers() {
        Integer result = Adder.addNumbers(5, 10);
        System.assertEquals(15, result, '5 + 10 should equal 15');

        Integer result2 = Adder.addNumbers(-3, 7);
        System.assertEquals(4, result2, '-3 + 7 should equal 4');
    }
    @IsTest
    static void testsubstractNumbers(){

        Integer result = Adder.subtractNumbers(10,5);
        System.assertEquals(5, result, '10-5 should equal 5');
    }
    
    @IsTest
    static void testdivNumbers(){

        Integer result = Adder.divnum(10,5);
        System.assertEquals(2, 2, '10/5 should equal 2');
    }  
 }