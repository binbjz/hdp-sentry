package eventhandling;


import java.util.List;

public class TCBean {

    private String id;
    private String tag;
    private String desc;
    private List<FileBean> cases;

    public List<FileBean> getCases() {
        return cases;
    }

    public void setCases(List<FileBean> cases) {
        this.cases = cases;
    }


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }
}
