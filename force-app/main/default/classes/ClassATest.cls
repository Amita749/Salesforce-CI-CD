@IsTest
public with sharing class ClassATest {

    @IsTest
    static void testClassAConstructor() {
        // Create an instance of ClassA
        ClassA obj = new ClassA();
        
        // Optionally perform assertions
        System.assertNotEquals(null, obj, 'ClassA instance should be created');
        
        // Debug statements are optional
        System.debug('ClassA instance created successfully');
    }
     @IsTest
    static void testMethodDev() {
        ClassA obj = new ClassA();
        obj.methodDev();
        System.debug('methodDev executed successfully');
    }


}