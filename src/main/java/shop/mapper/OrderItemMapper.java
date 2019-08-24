package shop.mapper;

import org.apache.ibatis.annotations.Param;
import shop.bean.OrderItem;
import shop.bean.OrderItemExample;

import java.util.List;

public interface OrderItemMapper {
    long countByExample(OrderItemExample example);

    int deleteByExample(OrderItemExample example);

    int deleteByPrimaryKey(Integer oiid);

    int insert(OrderItem record);

    int insertSelective(OrderItem record);

    List<OrderItem> selectByExample(OrderItemExample example);

    OrderItem selectByPrimaryKey(Integer oiid);

    List<OrderItem> selectByExampleWithProduct(OrderItemExample example);

    OrderItem selectByPrimaryKeyWithProduct(Integer oiid);

    int updateByExampleSelective(@Param("record") OrderItem record, @Param("example") OrderItemExample example);

    int updateByExample(@Param("record") OrderItem record, @Param("example") OrderItemExample example);

    int updateByPrimaryKeySelective(OrderItem record);

    int updateByPrimaryKey(OrderItem record);
}