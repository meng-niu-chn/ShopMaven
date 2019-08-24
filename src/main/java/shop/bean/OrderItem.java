package shop.bean;

public class OrderItem {
    private Integer oiid;

    private Integer count;

    private Double money;

    private Integer pid;

    private Integer oid;

    private Product product;

    public Integer getOiid() {
        return oiid;
    }

    public void setOiid(Integer oiid) {
        this.oiid = oiid;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public Double getMoney() {
        return money;
    }

    public void setMoney(Double money) {
        this.money = money;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public Integer getOid() {
        return oid;
    }

    public void setOid(Integer oid) {
        this.oid = oid;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    @Override
    public String toString() {
        return "OrderItem{" +
                "oiid=" + oiid +
                ", count=" + count +
                ", money=" + money +
                ", pid=" + pid +
                ", oid=" + oid +
                ", product=" + product +
                '}';
    }
}