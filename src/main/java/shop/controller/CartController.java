package shop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import shop.bean.*;
import shop.service.CartItemService;
import shop.service.CartService;
import shop.service.ProductService;
import shop.service.UserService;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@Controller
public class CartController {

    @Autowired
    ProductService productService;
    @Autowired
    CartItemService cartItemService;
    @Autowired
    UserService userService;
    @Autowired
    CartService cartService;

    @RequestMapping("/addCart")
    public String addCart(@RequestParam("pid") Integer pid, @RequestParam("count") Integer count, HttpSession httpSession){
        Product product = productService.getProductByPid(pid);
        CartItem cartItem = null;
        Double money = product.getPrice()*count;
        Cart cart = (Cart) httpSession.getAttribute("cart");
        System.out.println(cart);

        List<CartItem> cartItems = cart.getCartItems();
        if(cartItems == null){
            cartItems = new ArrayList<>();
        }

        Boolean flag = true;
        for (CartItem ci: cartItems) {
            if(ci.getProduct() != null && ci.getProduct().getPid() == pid) {
                ci.setPcount(ci.getPcount() + count);
                ci.setMoney(ci.getMoney() + money);
                flag = false;
                cartItem = ci;
            }
        }

        if(flag) {
            cartItem = new CartItem();
            cartItem.setPid(pid);
            cartItem.setPcount(count);
            cartItem.setPrice(product.getPrice());
            cartItem.setMoney(count * product.getPrice());
            cartItem.setProduct(product);
            cartItems.add(cartItem);
            cart.setCartItems(cartItems);
        }

        Double total = cart.getTotal();
        if(total == null){
            total = 0.0;
        }
        cart.setTotal(total + money);
        httpSession.setAttribute("cart",cart);

        User user = (User) httpSession.getAttribute("user");
        if (user != null) {
            cartService.updateByCart(cart);
            cartItem.setCartid(cart.getCartid());
            System.out.println("cartItem: " +  cartItem);
            if(flag){
                cartItemService.addCartItemByCI(cartItem);
            } else{
                cartItemService.updateCartItemByCI(cartItem);
            }

            User newUser = userService.getUserByUid(user.getUid());
            httpSession.setAttribute("user",newUser);
            httpSession.setAttribute("cart",newUser.getCart());
        }

        return "customer/cart";
    }

    @RequestMapping("/myCart")
    public String myCart(){
        return "customer/cart";
    }

    @RequestMapping("/delCartItem")
    public String delCartItem(@RequestParam("ciid") Integer ciid,HttpSession httpSession){
        cartItemService.delCartItemByCiid(ciid);
        User odlUser = (User) httpSession.getAttribute("user");
        User newUser = userService.getUserByUid(odlUser.getUid());
        httpSession.setAttribute("user",newUser);
        httpSession.setAttribute("cart",newUser.getCart());
        System.out.println((Cart) httpSession.getAttribute("cart"));
        return "redirect:myCart";
    }

    @RequestMapping("/delCartItemNoDb")
    public String delCartItemNoDb(@RequestParam("pid") Integer pid,HttpSession httpSession){
        Cart cart = (Cart) httpSession.getAttribute("cart");
        Iterator<CartItem> it = cart.getCartItems().iterator();
        while(it.hasNext()){
            CartItem x = it.next();
            if(x.getPid() == pid){
                cart.setTotal(cart.getTotal() - x.getMoney());
                it.remove();
            }
        }
        httpSession.setAttribute("cart",cart);
        return "redirect:myCart";
    }

    @RequestMapping("/numbleUpdateByPid")
    @ResponseBody
    public Message numbleUpdateByPid(@RequestParam("pid") Integer pid, @RequestParam("incOrSub") String incOrSub, HttpSession httpSession){
        Product product = productService.getProductByPid(pid);
        Double money = incOrSub.equals("inc") ? product.getPrice() : -product.getPrice();
        Integer count = incOrSub.equals("inc") ? 1 : -1;
        CartItem cartItem = null;
        Cart cart = (Cart) httpSession.getAttribute("cart");
        System.out.println(cart);

        List<CartItem> cartItems = cart.getCartItems();
        if(cartItems == null){
            cartItems = new ArrayList<>();
        }

        Boolean flag = true;
        for (CartItem ci: cartItems) {
            if(ci.getProduct() != null && ci.getProduct().getPid() == pid) {
                ci.setPcount(ci.getPcount() + count);
                ci.setMoney(ci.getMoney() + money);
                cartItem = ci;
            }
        }

        Double total = cart.getTotal();
        if(total == null){
            total = 0.0;
        }
        cart.setTotal(total + money);
        httpSession.setAttribute("cart",cart);

        User user = (User) httpSession.getAttribute("user");
        if (user != null) {
            cartService.updateByCart(cart);
            cartItem.setCartid(cart.getCartid());
            System.out.println("cartItem: " +  cartItem);

            cartItemService.updateCartItemByCI(cartItem);

            User newUser = userService.getUserByUid(user.getUid());
            httpSession.setAttribute("user",newUser);
            httpSession.setAttribute("cart",newUser.getCart());
        }

        return Message.success().add("ciMoney",cartItem.getMoney()).add("total",cart.getTotal());
    }

    @RequestMapping("/clearCart")
    public String clearCart(HttpSession httpSession){
        User user = (User) httpSession.getAttribute("user");
        Cart cart = (Cart) httpSession.getAttribute("cart");
        Iterator<CartItem> it = cart.getCartItems().iterator();
        while(it.hasNext()){
            CartItem cartitem = it.next();
            if (user != null){
                cartItemService.delCartItemByCiid(cartitem.getCiid());
            }
            it.remove();
        }
        return "customer/cart";
    }
}
