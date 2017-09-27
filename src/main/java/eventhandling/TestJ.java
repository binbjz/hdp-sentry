package eventhandling;

import com.alibaba.fastjson.JSON;
import utilitytool.SentryConstant;
import utilitytool.UtilTool;

import java.io.File;
import java.util.List;

public class TestJ {
    public static void main(String[] args) {

        String fileContext = SentryConstant.tSrc + File.separator + "TestServerAll" + File.separator + SentryConstant.jsonInput + File.separator + File.separator + "TestServerAll.json";
        String fileContents = UtilTool.readAllBytes(fileContext);
        System.out.println(fileContents);
        List<TCBean> tcBeans = JSON.parseArray(fileContents, TCBean.class);
        int testCount = tcBeans.size();
        int columnNum = 7;

        Object[][] obj = new Object[testCount][columnNum];

        for (int i = 0; i < tcBeans.size(); i++) {
            obj[i][0] = tcBeans.get(i).getId();
            obj[i][1] = tcBeans.get(i).getTag();
            obj[i][2] = tcBeans.get(i).getDesc();
            obj[i][3] = tcBeans.get(i).getCases().get(0).getType();
            obj[i][4] = tcBeans.get(i).getCases().get(0).getName();
            obj[i][5] = tcBeans.get(i).getCases().get(1).getType();
            obj[i][6] = tcBeans.get(i).getCases().get(1).getName();


            System.out.println(obj[i][0]);
            System.out.println(obj[i][1]);
            System.out.println(obj[i][2]);
            System.out.println(obj[i][3]);
            System.out.println(obj[i][4]);
            System.out.println(obj[i][5]);
            System.out.println(obj[i][6]);
            System.out.println("=======");
        }
//        Iterator<TCBean> iterator = tcBeans.iterator();
//        while (iterator.hasNext()) {
//            TCBean next = iterator.next();
//            System.out.println(next.getId());
//            System.out.println(next.getTag());
//            System.out.println(next.getDesc());
//
//            System.out.println(next.getCases().get(0).getType());
//            System.out.println(next.getCases().get(0).getName());
//            System.out.println();
//            System.out.println(next.getCases().get(1).getType());
//            System.out.println(next.getCases().get(1).getName());
//        }

//        TCBean parse = JSON.parseObject(fileContents, TCBean.class);

//        System.out.println(parse.getId());
//        System.out.println(parse.getTag());
//        System.out.println(parse.getDesc());
//
//        System.out.println(parse.getCases().get(0).getType());
//        System.out.println(parse.getCases().get(0).getName());
//        System.out.println();
//        System.out.println(parse.getCases().get(1).getType());
//        System.out.println(parse.getCases().get(1).getName());
    }
}