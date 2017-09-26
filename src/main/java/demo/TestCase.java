package demo;

import java.util.List;

public class TestCase {

    private String id;
    private String desc;
    private String prepare;
    private String sql;
    private String except;
    private List<CleanObject> clean;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public String getPrepare() {
        return prepare;
    }

    public void setPrepare(String prepare) {
        this.prepare = prepare;
    }

    public String getSql() {
        return sql;
    }

    public void setSql(String sql) {
        this.sql = sql;
    }

    public String getExcept() {
        return except;
    }

    public void setExcept(String except) {
        this.except = except;
    }

    public List<CleanObject> getClean() {
        return clean;
    }

    public void setClean(List<CleanObject> clean) {
        this.clean = clean;
    }
}
