package shop.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import shop.bean.OrderItem;
import shop.mapper.OrderItemMapper;

@Service
public class OrderItemService {

    @Autowired
    OrderItemMapper orderItemMapper;

    public void addOrderItem(OrderItem orderItem) {
        orderItemMapper.insert(orderItem);
    }
}
