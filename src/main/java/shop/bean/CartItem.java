package shop.bean;

public class CartItem {
    private Integer ciid;

    private Integer pid;

    private Integer pcount;

    private Double price;

    private Double money;

    private Integer cartid;

    private Product product;

    public Integer getCiid() {
        return ciid;
    }

    public void setCiid(Integer ciid) {
        this.ciid = ciid;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public Integer getPcount() {
        return pcount;
    }

    public void setPcount(Integer pcount) {
        this.pcount = pcount;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Double getMoney() {
        return money;
    }

    public void setMoney(Double money) {
        this.money = money;
    }

    public Integer getCartid() {
        return cartid;
    }

    public void setCartid(Integer cartid) {
        this.cartid = cartid;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    @Override
    public String toString() {
        return "CartItem{" +
                "ciid=" + ciid +
                ", pid=" + pid +
                ", pcount=" + pcount +
                ", price=" + price +
                ", money=" + money +
                ", cartid=" + cartid +
                ", product=" + product +
                '}';
    }
}