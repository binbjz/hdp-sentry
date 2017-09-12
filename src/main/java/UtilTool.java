import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.HashMap;
import java.util.Map;


public class UtilTool {
    public static void main(String[] args) {
//        String[] cmd = {"/bin/bash", "-c", "ifconfig en0 | grep -w inet"};
        String[] cmd = {"/bin/bash", "-c", "ifconfig en0"};
        System.out.println("exit code:\n" + execCommand(cmd).get(0));
        System.out.println();
        System.out.println("command result:\n" + execCommand(cmd).get(1));

        System.out.println("======>>");
        String sourcesPath = Paths.get(".").toAbsolutePath().normalize().toString() + File.separator + "resources";
        String filePath = sourcesPath + File.separator + "ifconfig_en0.txt";
        System.out.println(readAllBytes(filePath));

        System.out.println("======>>");
        String filePath2 = sourcesPath + File.separator + "ifconfig_en0_new.txt";
        System.out.println(filePath2);
        writeAllBytes(filePath2, execCommand(cmd).get(1).toString());
    }


    /**
     * This method demonstrates exeCommand().
     * It will return command results with Map type object.
     * <p>
     * return map(exitCode, command output results)
     */
    public static Map execCommand(String... str) {
        Map<Integer, String> map = new HashMap<>();
        ProcessBuilder pb = new ProcessBuilder(str);
        pb.redirectErrorStream(true);
        Process process = null;
        try {
            process = pb.start();
        } catch (IOException e) {
            e.printStackTrace();
        }

        BufferedReader reader = null;
        if (process != null) {
            reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
        }
        StringBuilder stringBuilder = new StringBuilder();
        String line;
        try {
            if (reader != null) {
                while ((line = reader.readLine()) != null) {
                    stringBuilder.append(line).append("\n");
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            if (process != null) {
                process.waitFor();
            }
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        if (process != null) {
            map.put(0, String.valueOf(process.exitValue()));
        }
        map.put(1, stringBuilder.substring(0, stringBuilder.length() - 1));
        return map;
    }


    /**
     * This method demonstrates readAllBytes().
     * It will return file results with string type.
     */
    public static String readAllBytes(String filePath) {
        String content = "";

        try {
            content = new String(Files.readAllBytes(Paths.get(filePath)));
        } catch (IOException e) {
            e.printStackTrace();
        }

        return content;
    }


    /**
     * This method demonstrates writeAllBytes().
     * It will write string type object into file.
     */
    public static void writeAllBytes(String filePath, String contents) {
        try {
            Files.write(Paths.get(filePath), contents.getBytes("utf-8"),
                    StandardOpenOption.CREATE, StandardOpenOption.TRUNCATE_EXISTING);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
