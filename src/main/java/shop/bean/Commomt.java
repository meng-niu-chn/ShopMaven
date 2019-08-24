package shop.bean;

public class Commomt {
    private Integer comid;

    private String content;

    private Integer uid;

    private Integer recomid;

    public Integer getComid() {
        return comid;
    }

    public void setComid(Integer comid) {
        this.comid = comid;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public Integer getRecomid() {
        return recomid;
    }

    public void setRecomid(Integer recomid) {
        this.recomid = recomid;
    }
}