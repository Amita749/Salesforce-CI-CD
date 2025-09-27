@isTest
public class StudentHandlerTest {
    @isTest
    static void testGetStudentInfo() {
        String info = StudentHandler.getStudentInfo();
        System.assert(info.contains('Test Student'));
        System.assert(info.contains('1'));
        System.assert(info.contains('85'));
    }
}