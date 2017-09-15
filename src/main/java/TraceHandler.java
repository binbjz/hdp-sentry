import java.lang.reflect.Method;

/**
 * Getting the name of the currently executing method
 */
public class TraceHandler {
    private static Method m;

    static {
        try {
            m = Throwable.class.getDeclaredMethod("getStackTraceElement", int.class);
            m.setAccessible(true);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static String getMethodName(final int depth) {
        try {
            StackTraceElement element = (StackTraceElement) m.invoke(
                    new Throwable(), depth + 1);
            return element.getMethodName();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}