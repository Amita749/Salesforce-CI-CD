@isTest
public with sharing class ClassCTest {
    @IsTest
    static void testSayHello() {
        // Arrange
        String testName = 'Amita';

        // Act
        String result = ClassC.sayHello(testName);

        // Assert
        System.assertEquals('Hello Amita', result, 'sayHello should return a greeting with the name.');
    }
}
