public with sharing class ClassA {
    public ClassA() {
System.debug('new line added');
    }
    // Method added in Dev org
    public void methodDev() {
        System.debug('Dev method executed');
    }
}