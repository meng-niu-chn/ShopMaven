package shop.mapper;

import org.apache.ibatis.annotations.Param;
import shop.bean.Order;
import shop.bean.OrderExample;

import java.util.List;

public interface OrderMapper {
    long countByExample(OrderExample example);

    int deleteByExample(OrderExample example);

    int deleteByPrimaryKey(Integer oid);

    int insert(Order record);

    int insertSelective(Order record);

    List<Order> selectByExample(OrderExample example);

    Order selectByPrimaryKey(Integer oid);

    List<Order> selectByExampleWithOI(OrderExample example);

    Order selectByPrimaryKeyWithOI(Integer oid);

    int updateByExampleSelective(@Param("record") Order record, @Param("example") OrderExample example);

    int updateByExample(@Param("record") Order record, @Param("example") OrderExample example);

    int updateByPrimaryKeySelective(Order record);

    int updateByPrimaryKey(Order record);


}