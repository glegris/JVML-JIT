import java.util.Vector;

public class SimpleTest {
    public static void main(String[] args) {
        
        //Class clazz = SimpleTest.class.getSuperclass();
        
        System.out.println("hello");
        
        long a;
        int b;
        float c;
        double d;

        // Division and negatives.
        a = -16L;
        a /= 4L;

        // Over/underflow.
        a = 9223372036854775807L;
        a += 9223372036854775807L;

        a = 9223372036854775806L;
        a *= 235L;

        a = -9223372036854775808L;
        a -= 9223372036854775807L;

        a = -9223372036854775802L;
        a *= 235L;

        // Conversion.
        a = 5000L;
        b = (int)a;
        c = (float)a;
        d = (double)a;


        // Conversion (with over/underflow for ints).
        a = 132938835129648L;
        b = (int)a;
        c = (float)a;
        d = (double)a;


        // Conversion to long.

        b = 1000;
        c = 2000;
        d = 3000;

        a = (long)b * 2147483648L;

        a = (long)c * 2147483648L;

        a = (long)d * 2147483648L;
        
        Vector<String> v = new Vector<String>();
        v.add("string added in vector");
        System.out.println(v.get(0));
        
    }
}
