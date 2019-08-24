package shop.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import shop.bean.Order;
import shop.bean.OrderExample;
import shop.mapper.OrderMapper;

import java.util.List;

@Service
public class OrderService {

    @Autowired
    OrderMapper orderMapper;

    public void addOrder(Order order) {
        orderMapper.insertSelective(order);
    }

    public void update(Order order) {
        orderMapper.updateByPrimaryKey(order);
    }

    public List<Order> getOrdersByUid(Integer uid) {
        OrderExample example = new OrderExample();
        OrderExample.Criteria criteria = example.createCriteria();
        criteria.andUidEqualTo(uid);
        List<Order> orders = orderMapper.selectByExampleWithOI(example);
        System.out.println(orders);
        return orders;
    }

    public Order getOrderByOid(Integer oid) {
        return orderMapper.selectByPrimaryKey(oid);
    }

    public Order getOrderByOiidWithOI(Integer oid) {
        return orderMapper.selectByPrimaryKeyWithOI(oid);
    }

    public List<Order> getOrdersByState(Integer state) {
        if (state == -1) {
            return orderMapper.selectByExample(null);
        } else {
            OrderExample example = new OrderExample();
            OrderExample.Criteria criteria = example.createCriteria();
            criteria.andStateEqualTo(state);
            List<Order> orders = orderMapper.selectByExample(example);
            System.out.println(orders);
            return orders;
        }
    }
}
