package shop.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import shop.bean.Cart;
import shop.bean.CartItem;
import shop.bean.CartItemExample;
import shop.mapper.CartItemMapper;

@Service
public class CartItemService {
    @Autowired
    CartItemMapper cartItemMapper;
    @Autowired
    CartService cartService;

    public void addCartItemByCI(CartItem cartItem) {
        cartItemMapper.insertSelective(cartItem);
    }

    public void delCartItemByCiid(Integer ciid) {
        CartItem cartItem = cartItemMapper.selectByPrimaryKey(ciid);
        Cart cart = cartService.getCartByCartid(cartItem.getCartid());
        cart.setTotal(cart.getTotal()-cartItem.getMoney());
        cartService.updateByCart(cart);
        cartItemMapper.deleteByPrimaryKey(ciid);
    }

    public void updateCartItemByCI(CartItem cartItem) {
        CartItemExample example = new CartItemExample();
        CartItemExample.Criteria  criteria = example.createCriteria();
        criteria.andPidEqualTo(cartItem.getPid());
        criteria.andCartidEqualTo(cartItem.getCartid());
        cartItemMapper.updateByExampleSelective(cartItem,example);
    }
}
