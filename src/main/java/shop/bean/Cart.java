package shop.bean;

import java.util.List;

public class Cart {
    private Integer cartid;

    private Integer uid;

    private Double total;

    private List<CartItem> cartItems;

    public Integer getCartid() {
        return cartid;
    }

    public void setCartid(Integer cartid) {
        this.cartid = cartid;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public Double getTotal() {
        return total;
    }

    public void setTotal(Double total) {
        this.total = total;
    }

    public List<CartItem> getCartItems() {
        return cartItems;
    }

    public void setCartItems(List<CartItem> cartItems) {
        this.cartItems = cartItems;
    }

    @Override
    public String toString() {
        return "Cart{" +
                "cartid=" + cartid +
                ", uid=" + uid +
                ", total=" + total +
                ", cartItems=" + cartItems +
                '}';
    }
}