package shop.mapper;

import org.apache.ibatis.annotations.Param;
import shop.bean.CartItem;
import shop.bean.CartItemExample;

import java.util.List;

public interface CartItemMapper {
    long countByExample(CartItemExample example);

    int deleteByExample(CartItemExample example);

    int deleteByPrimaryKey(Integer ciid);

    int insert(CartItem record);

    int insertSelective(CartItem record);

    List<CartItem> selectByExample(CartItemExample example);

    CartItem selectByPrimaryKey(Integer ciid);

    List<CartItem> selectByExampleWithProduct(CartItemExample example);

    CartItem selectByPrimaryKeyWithProduct(Integer ciid);

    int updateByExampleSelective(@Param("record") CartItem record, @Param("example") CartItemExample example);

    int updateByExample(@Param("record") CartItem record, @Param("example") CartItemExample example);

    int updateByPrimaryKeySelective(CartItem record);

    int updateByPrimaryKey(CartItem record);
}