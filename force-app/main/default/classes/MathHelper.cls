public class MathHelper {

    // Method 1: Add two numbers
    public Integer add(Integer a, Integer b) {
        return a + b;
    }

    // Method 2: Subtract two numbers
    public Integer subtract(Integer a, Integer b) {
        return a - b;
    }

   

    // Method 4: Divide two numbers
    public Decimal divide(Decimal a, Decimal b) {
        if(b == 0) {
            System.debug('Cannot divide by zero');
            return null;
        }
        return a / b;
    }

  
}