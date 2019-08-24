package shop.bean;

import java.util.Date;
import java.util.List;

public class Order {
    private Integer oid;

    private Double total;

    private Integer state;

    private String receiveinfo;

    private String phonum;

    private Date orderTime;

    private Integer uid;

    private String accepter;

    private List<OrderItem> orderItems;

    public Integer getOid() {
        return oid;
    }

    public void setOid(Integer oid) {
        this.oid = oid;
    }

    public Double getTotal() {
        return total;
    }

    public void setTotal(Double total) {
        this.total = total;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public String getReceiveinfo() {
        return receiveinfo;
    }

    public void setReceiveinfo(String receiveinfo) {
        this.receiveinfo = receiveinfo == null ? null : receiveinfo.trim();
    }

    public String getPhonum() {
        return phonum;
    }

    public void setPhonum(String phonum) {
        this.phonum = phonum == null ? null : phonum.trim();
    }

    public Date getOrderTime() {
        return orderTime;
    }

    public void setOrderTime(Date orderTime) {
        this.orderTime = orderTime;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getAccepter() {
        return accepter;
    }

    public void setAccepter(String accepter) {
        this.accepter = accepter == null ? null : accepter.trim();
    }

    public List<OrderItem> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }

    @Override
    public String toString() {
        return "Order{" +
                "oid=" + oid +
                ", total=" + total +
                ", state=" + state +
                ", receiveinfo='" + receiveinfo + '\'' +
                ", phonum='" + phonum + '\'' +
                ", orderTime=" + orderTime +
                ", uid=" + uid +
                ", accepter='" + accepter + '\'' +
                ", orderItems=" + orderItems +
                '}';
    }
}