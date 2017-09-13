import java.nio.file.Paths;

public class ConstantSentry {
    public static final String workspacePath = Paths.get(".").toAbsolutePath().normalize().toString();
    public static final String resourcePath = Paths.get("src/main/resources").toAbsolutePath().toString();

}
