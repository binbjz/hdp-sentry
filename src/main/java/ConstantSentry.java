import java.io.File;
import java.nio.file.Paths;

public class ConstantSentry {
    public static final String resourcesPath = Paths.get(".").toAbsolutePath().normalize().toString() + File.separator + "resources";

}
