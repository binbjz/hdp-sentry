package utilitytool;

import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.util.regex.*;


public class UtilTool {
    public static void main(String[] args) {
        //Just for debug
        String cmds = "ifconfig";
        String[] callCmd = {"/bin/bash", "-c", cmds};
        System.out.println("exit code:\n" + execCommand(callCmd).get(0).toString());
        System.out.println();
        System.out.println("command result:\n" + execCommand(callCmd).get(1).toString());


        String regx = " ...  20 more\n";
        String regx2 = "  )'";
        String regx3 = "... 71 elided ddasd";
        String regx4 = "  )";
        System.out.println(filterResults(regx2));


        /*String filterTmpPath = SentryConstant.wsPath + File.separator + "src" + File.separator + "main" + File.separator + "java" + File.separator + "utilitytool" + File.separator;
        String fileName = filterTmpPath + "filterTmp.txt";
        System.out.println(fileName);

        StringBuilder stringBuilder2 = new StringBuilder();
        try (BufferedReader br2 = new BufferedReader(new FileReader(fileName))) {
            String line;
            while ((line = br2.readLine()) != null) {
                line = filterResults(line);
                if (line == null || line.length() == 0) {
                    continue;
                }
                stringBuilder2.append(line).append("\n");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }*/

//        String str = "Loading data to table encrypt_db4alter.supply partition (day=2011-01-02)";
//        System.out.println(filterResults(str));
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

        String line;
        StringBuilder stringBuilder = new StringBuilder();
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

        try {
            map.put(1, stringBuilder.toString());
        } catch (StringIndexOutOfBoundsException e) {
            if (stringBuilder.toString().length() == 0) {
                return map;
            }
        }
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
        return stringBuilder.toString();
    }

    /**
     * This method demonstrates arrToStr().
     * Return a string which is the concatenation of the strings in array.
     */
    public static String arrToStr(String[] str) {
        StringBuilder sb = new StringBuilder();
        for (String s : str) {
            sb.append(s).append(" ");
        }

        String str2 = sb.substring(0, sb.length() - 1);
        return str2;
    }

    /**
     * This method will filter strings that contain time and specified string
     * example: "17/09/13 14:39:55 INFO xxxxxx" will be replaced with an empty string
     */
    public static String filterResults(String str) {
        // String REGEX = "([a-zA-Z]+(:?)\\s+(!?))+";
//        String REGEX = "((\\d{2}|\\d{4})(/|-)\\d{1,2}(/|-)\\d{1,2}\\s+\\d{2}:\\d{2}(:\\d{2})?)";
//        String REGEX2 = ".*(Time|CliDriver|Logging).*";
        String REGEX = "((\\d{2}|\\d{4})(/|-)\\d{1,2}(/|-)\\d{1,2}\\s+\\d{2}:\\d{2}(:\\d{2})?|\\d{2}:\\d{2}|(\\d{2}|\\d{4})(/|-)\\d{1,2}(/|-)\\d{1,2})";
        String REGEX2 = ".*(Time|CliDriver|Logging|Stage|reduce|MapReduce|Job|Query).*";
        String REGEX3 = "^\\s*at\\s+(org|sun|java|com|javax|scala).*";
        String REGEX4 = "^\\s*(\\.+\\s+\\d+\\s+.*|(\\)'|\\))).*";
        String REPLACE = "";
        String prefixes = REGEX + "|" + REGEX2 + "|" + REGEX3 + "|" + REGEX4;
        String REGEXS = "(" + prefixes + ")";
        Pattern p = Pattern.compile(REGEXS, Pattern.CASE_INSENSITIVE);
        Matcher m = p.matcher(str);
        if (m.find()) {
            str = REPLACE;
        }
        return str;
    }
}
