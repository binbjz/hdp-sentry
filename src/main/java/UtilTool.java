import com.sun.tools.internal.jxc.apt.Const;

import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.util.regex.*;


public class UtilTool {
    public static void main(String[] args) {
        // execute command
//        String cmds = "ifconfig bond0 && ps aux | head";
//        String[] callCmd = {"/bin/bash", "-c", cmds};
//        System.out.println("exit code:\n" + execCommand(callCmd).get(0));
//        System.out.println();
//        System.out.println("command result:\n" + execCommand(callCmd).get(1));
//        System.out.println();
//
        // execute script
//        String[] callScript = {"/bin/bash", scripts};
        String scripts = "/opt/meituan/qa_test/sentry_role.sh check";
        String[] callScript = {"/bin/bash", "-c", "source" + " " + scripts};
        System.out.println("exit code:\n" + execCommand(callScript).get(0));
        System.out.println();
        System.out.println("command result:\n" + execCommand(callScript).get(1));


        //System.out.println("======>>");
        //String scripts2 = "/Users/zhaobin/Downloads/test.sh";
        //String[] callScript2 = {"/bin/bash", "-c", "source" + " " + scripts2};
        //System.out.println(ConstantSentry.workspacePath);
        //String input = execCommand(callScript2).get(1).toString();
        //System.out.println(ConstantSentry.resourcePath);
        //String filePath2 = ConstantSentry.resourcePath + File.separator + "results.txt";
        //writeAllBytes(filePath2, input);
        //System.out.println("======>>");
        //System.out.println(readFileByLine(filePath2));
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
                    line = filterResults(line);
                    if (line == null || line.length() == 0) {
                        continue;
                    }
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

    /**
     * This method demonstrates readFileByLine().
     * It will read file by line.
     */
    public static String readFileByLine(String filename) {

        StringBuilder stringBuilder = new StringBuilder();
        try (BufferedReader br = new BufferedReader(new FileReader(filename))) {
            String line;
            while ((line = br.readLine()) != null) {
                stringBuilder.append(line).append("\n");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return stringBuilder.substring(0, stringBuilder.length() - 1);
    }

    /**
     * This method will filter strings that contain time
     * example: "17/09/13 14:39:55 INFO xxxxxx" will be replaced with an empty string
     */
    public static String filterResults(String str) {
        String REGEX = "(\\d{2}|\\d{4})(/|-)\\d{1,2}(/|-)\\d{1,2}\\s+\\d{2}:\\d{2}:\\d{2}";
        String REGEX2 = "Just a placeholder";
        String REPLACE = "";
        // String REGEX2 = "([a-zA-Z]+(:?)\\s+(!?))+";
        //String REPLACE = "<******>";
        String prefixes = REGEX + "|" + REGEX2;
        String REGEXS = "(" + prefixes + ")";
        Pattern p = Pattern.compile(REGEXS, Pattern.CASE_INSENSITIVE);
        Matcher m = p.matcher(str);
        if (m.find()) {
            str = REPLACE;
        }
        return str;
    }
}
