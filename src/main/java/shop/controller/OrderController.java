package shop.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import shop.bean.*;
import shop.service.CartItemService;
import shop.service.OrderItemService;
import shop.service.OrderService;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

@Controller
public class OrderController {

    @Autowired
    OrderService orderService;
    @Autowired
    OrderItemService orderItemService;
    @Autowired
    CartItemService cartItemService;

    @RequestMapping("/toOrder")
    public String toOrder(HttpSession httpSession){

        User user = (User) httpSession.getAttribute("user");
        Cart cart = (Cart) httpSession.getAttribute("cart");

        System.out.println("size:::::" + cart.getCartItems().size());

        if (cart.getCartItems().size() == 0 || cart.getCartItems().get(0).getCiid() == null) {
            System.out.println("toOrder-------myCart");
            return "redirect:/myCart";
        } else {
            Order order = new Order();
            order.setUid(user.getUid());
            order.setState(0);
            order.setTotal(cart.getTotal());
            order.setOrderTime(new Date());
            orderService.addOrder(order);

            System.out.println(order);
            List<OrderItem> orderItems = new ArrayList<>();

/*        for (CartItem cartitem : cart.getCartItems()) {
            OrderItem orderItem = new OrderItem();
            orderItem.setCount(cartitem.getPcount());
            orderItem.setPid(cartitem.getPid());
            orderItem.setMoney(cartitem.getMoney());
            orderItem.setOid(order.getOid());
            orderItemService.addOrderItem(orderItem);
            orderItem.setProduct(cartitem.getProduct());
            orderItems.add(orderItem);
            cartItemService.delCartItemByCiid(cartitem.getCiid());
            cart.getCartItems().remove(cartitem);
        }*/

            Iterator<CartItem> it = cart.getCartItems().iterator();
            while(it.hasNext()){
                CartItem cartitem = it.next();
                OrderItem orderItem = new OrderItem();
                orderItem.setCount(cartitem.getPcount());
                orderItem.setPid(cartitem.getPid());
                orderItem.setMoney(cartitem.getMoney());
                orderItem.setOid(order.getOid());
                orderItemService.addOrderItem(orderItem);
                orderItem.setProduct(cartitem.getProduct());
                orderItems.add(orderItem);
                cartItemService.delCartItemByCiid(cartitem.getCiid());
                //cart.getCartItems().remove(cartitem);
                it.remove();
            }
            cart.setTotal(0.0);
            order.setOrderItems(orderItems);
            System.out.println(order);
            httpSession.setAttribute("order",order);
            return "customer/order";
        }
    }

    @RequestMapping("toPay")
    public String toPay(@RequestParam("oid") Integer oid,HttpSession httpSession){
        Order order = orderService.getOrderByOiidWithOI(oid);
        httpSession.setAttribute("order",order);
        return "customer/order";
    }

    @RequestMapping("/payOrder")
    public String payOrder(HttpSession httpSession, @RequestParam("receiveinfo") String receiveinfo, @RequestParam("accepter") String accepter, @RequestParam("phonum") String phonum){
        System.out.println("payOrder");
        Order order = (Order) httpSession.getAttribute("order");
        order.setState(1);
        order.setReceiveinfo(receiveinfo);
        order.setAccepter(accepter);
        order.setPhonum(phonum);
        orderService.update(order);

        return "redirect:/myOrder";
    }

    @RequestMapping("/myOrder")
    public String myOrder(HttpSession httpSession, Model model,@RequestParam(value = "pn",defaultValue = "1") Integer pn){
        User user = (User) httpSession.getAttribute("user");
        PageHelper.startPage(pn, 5);
        List<Order> orders = orderService.getOrdersByUid(user.getUid());
        PageInfo pageInfo = new PageInfo(orders,5);

        System.out.println(orders);
        model.addAttribute("pageInfo",pageInfo);
        return "customer/orders";
    }

    @RequestMapping("/updateOrder")
    public String updateOrder(@RequestParam("oid") Integer oid,@RequestParam(value = "pn",defaultValue = "1") Integer pn){
        Order order = orderService.getOrderByOid(oid);
        order.setState(order.getState() + 1);
        orderService.update(order);
        return "redirect:/myOrder?pn=" + pn;
    }
}
