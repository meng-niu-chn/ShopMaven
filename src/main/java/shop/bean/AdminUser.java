package shop.bean;

public class AdminUser {
    private Integer aid;

    private String ausername;

    private String apassword;

    public Integer getAid() {
        return aid;
    }

    public void setAid(Integer aid) {
        this.aid = aid;
    }

    public String getAusername() {
        return ausername;
    }

    public void setAusername(String ausername) {
        this.ausername = ausername == null ? null : ausername.trim();
    }

    public String getApassword() {
        return apassword;
    }

    public void setApassword(String apassword) {
        this.apassword = apassword == null ? null : apassword.trim();
    }
}