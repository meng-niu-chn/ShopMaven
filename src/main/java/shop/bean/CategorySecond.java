package shop.bean;

public class CategorySecond {
    private Integer csid;

    private String csname;

    private Integer cid;

    private Category category;

    public Integer getCsid() {
        return csid;
    }

    public void setCsid(Integer csid) {
        this.csid = csid;
    }

    public String getCsname() {
        return csname;
    }

    public void setCsname(String csname) {
        this.csname = csname == null ? null : csname.trim();
    }

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    @Override
    public String toString() {
        return "CategorySecond{" +
                "csid=" + csid +
                ", csname='" + csname + '\'' +
                ", cid=" + cid +
                ", category=" + category +
                '}';
    }
}