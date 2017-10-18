package utilitytool;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.util.regex.*;


public class UtilTool {
    private static final String className = TraceHandler.getSTElement(0, "className");
    private static final Logger logger = LoggerFactory.getLogger(className);

    public static void main(String[] args) {
        //Just for debug
        String cmds = "ifconfig";
        String[] callCmd = {"/bin/bash", "-c", cmds};
        System.out.println("exit code:\n" + execCommand(callCmd).get(0).toString());
        System.out.println();
        System.out.println("command result:\n" + execCommand(callCmd).get(1).toString());

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
        
        /** //execute script
         //String[] callScript = {"/bin/bash", scripts};
         String scripts = "/opt/meituan/qa_test/sentry_role.sh check";
         String[] callScript = {"/bin/bash", "-c", "source" + " " + scripts};
         ("exit code:\n" + execCommand(callScript).get(0));
         System.out.println("command result:\n" + execCommand(callScript).get(1));

         System.out.println("======>>");
         String scripts2 = "/Users/zhaobin/Downloads/test.sh";
         String[] callScript2 = {"/bin/bash", "-c", "source" + " " + scripts2};
         System.out.println(utilitytool.SentryConstant.wsPath);
         String input = execCommand(callScript2).get(1).toString();
         System.out.println(utilitytool.SentryConstant.jSrc);
         String filePath2 = utilitytool.SentryConstant.tSrc + File.separator + "results.txt";
         writeAllBytes(filePath2, input);
         System.out.println("======>>");
         System.out.println(readFileByLine(filePath2)); */
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

        try {
            map.put(1, stringBuilder.toString());
        } catch (StringIndexOutOfBoundsException e) {
            if ((stringBuilder.toString() == null) || (stringBuilder.toString().length() == 0)) {
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
        String REGEX = "(((\\d{2}|\\d{4})(/|-)\\d{1,2}(/|-)\\d{1,2})?|(\\d{2}|\\d{4})(/|-)\\d{1,2}(/|-)\\d{1,2}\\s+\\d{2}:\\d{2}(:\\d{2})?|\\d{2}:\\d{2})";
        String REGEX2 = ".*(Time|CliDriver|Logging|Stage|reduce|MapReduce|Job|Query).*";
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

    /**
     * This method will pre-execute or post-execute sql for each object with highest privilege
     */
    public static void privilHandler(String clsName, String sqlFile, String action) {
        String privilAction = String.format(" %s ", action);

        String sentrySh = SentryConstant.jSrc + File.separator + SentryConstant.sentry_sh + privilAction + SentryConstant.prePri;
        String[] sentryCmd = {"/bin/bash", "-c", "source " + sentrySh};
        logger.info(UtilTool.arrToStr(sentryCmd));
        logger.info("exit code:\n" + UtilTool.execCommand(sentryCmd).get(0));

        String hiveSh = SentryConstant.jSrc + File.separator + SentryConstant.hive_sh + " proxy_user " + "super";
        String[] hiveCmd = {"/bin/bash", "-c", "source " + hiveSh};
        logger.info(UtilTool.arrToStr(hiveCmd));
        logger.info("exit code:\n" + UtilTool.execCommand(hiveCmd).get(0));

        String hiveSqlPath = SentryConstant.tSrc + File.separator + clsName + File.separator + SentryConstant.hiveSqlSrc;
        String hiveSql = SentryConstant.hiveExec + " -f " + hiveSqlPath + File.separator + sqlFile;
        String[] sqlCmd = {"/bin/bash", "-c", hiveSql};
        logger.info(UtilTool.arrToStr(sqlCmd));

        Map map = UtilTool.execCommand(sqlCmd);
        logger.info("exit code:\n" + map.get(0).toString());
        logger.info("command result:\n" + map.get(1).toString());
    }
}
