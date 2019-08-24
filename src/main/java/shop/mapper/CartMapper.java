package shop.mapper;

import org.apache.ibatis.annotations.Param;
import shop.bean.Cart;
import shop.bean.CartExample;

import java.util.List;

public interface CartMapper {
    long countByExample(CartExample example);

    int deleteByExample(CartExample example);

    int deleteByPrimaryKey(Integer cartid);

    int insert(Cart record);

    int insertSelective(Cart record);

    List<Cart> selectByExample(CartExample example);

    Cart selectByPrimaryKey(Integer cartid);

    List<Cart> selectByExampleWithItems(CartExample example);

    Cart selectByPrimaryKeyWithItems(Integer cartid);

    int updateByExampleSelective(@Param("record") Cart record, @Param("example") CartExample example);

    int updateByExample(@Param("record") Cart record, @Param("example") CartExample example);

    int updateByPrimaryKeySelective(Cart record);

    int updateByPrimaryKey(Cart record);
}