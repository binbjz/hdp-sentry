package utilitytool;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

/**
 * Getting the currently executing Class internal information
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

    public static String getSTElement(final int depth, String key) {
        try {
            StackTraceElement element = (StackTraceElement) m.invoke(
                    new Throwable(), depth + 1);
            if (key == null || key.length() == 0) {
                throw new IllegalArgumentException("object is null");
            }

            switch (key) {
                case "className":
                    return element.getClassName();
                case "methodName":
                    return element.getMethodName();
                case "lineNum":
                    return String.valueOf(element.getLineNumber());
                case "fileName":
                    return element.getFileName();
            }
        } catch (IllegalArgumentException | IllegalAccessException | InvocationTargetException e) {
            e.printStackTrace();
            System.exit(1);
        }
        return null;
    }
}
