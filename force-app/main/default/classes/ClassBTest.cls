@isTest
public class ClassBTest {

    @IsTest
    static void testSayHello() {
        // Arrange
        String testName = 'Amita';

        // Act
        String result = ClassB.sayHello(testName);

        // Assert
        System.assertEquals('Hello, Amita!', result);
    }
}