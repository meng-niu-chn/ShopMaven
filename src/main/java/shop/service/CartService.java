package shop.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import shop.bean.Cart;
import shop.mapper.CartMapper;

@Service
public class CartService {
    @Autowired
    CartMapper cartMapper;

    public void updateByCart(Cart cart) {
        cartMapper.updateByPrimaryKeySelective(cart);
    }

    public Cart getCartByCartid(Integer cartid) {
        return cartMapper.selectByPrimaryKey(cartid);
    }

    public void addCart(Cart cart) {
        cartMapper.insert(cart);
    }
}
