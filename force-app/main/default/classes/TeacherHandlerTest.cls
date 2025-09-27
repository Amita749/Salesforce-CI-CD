@isTest
public class TeacherHandlerTest {
@isTest
     static void testGetTeacherInfo() {
        String info = TeacherHandler.getTeacherInfo();
        System.assert(info.contains('Test teacher'));
        System.assert(info.contains('test123@gmail.com'));
       
    }
}