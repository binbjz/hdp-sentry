package eventhandling;

import com.alibaba.fastjson.JSON;
import utilitytool.UtilTool;

import java.util.List;

public class DataProviderObj {

    public static Object[][] dataGenerator(String jsonFile) {
        System.out.println("Generating testData from " + jsonFile);

        String fileContents = UtilTool.readAllBytes(jsonFile);
//        System.out.println(fileContents);
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
        }

        return obj;
    }
}