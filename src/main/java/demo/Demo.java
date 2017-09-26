package demo;

import com.alibaba.fastjson.JSON;

import java.io.File;

import utilityTool.*;

public class Demo {


    public static void main(String[] args) {

//        String fileCotenxt = "{\"id\":\"\",\"desc\":\"\",\"prepare\":\"\",\"sql\":\"SHOW DATABASES;\",\"except\":\"OK\",\"clean\":{\"type\":\"file/sql\",\"name\":\"testCreateDropDB.sql\"}}";

        String fileContext = SentryConstant.tSrc + File.separator + "test" + File.separator + "demo.json";
        String fileContents = UtilTool.readAllBytes(fileContext);
        System.out.println(fileContents);
        TestCase parse = JSON.parseObject(fileContents, TestCase.class);
//        JSON.parseArray()
        System.out.println(parse.getClean().get(0).getType() + " " + parse.getClean().get(0).getName());
        System.out.println(parse.getId());
    }
}
