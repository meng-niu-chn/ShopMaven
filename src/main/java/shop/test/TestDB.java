package shop.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import shop.bean.Order;
import shop.mapper.OrderMapper;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class TestDB {

    /*@Autowired
    CategorySecondService categorySecondService;
    @Autowired
    ProductService productService;
    @Autowired
    CategoryService categoryService;
    @Autowired
    CartMapper cartMapper;
    @Autowired
    UserMapper userMapper;*/
    @Autowired
    OrderMapper orderMapper;

    @Test
    public void test(){
        /*System.out.println(categorySecondService);
        List<CategorySecond> list = categorySecondService.getAll();
        System.out.println(list);*/
        /*System.out.println(productService);
        List<Product> list = productService.getAll();*/
        /*System.out.println(categoryService);
        List<Integer> list = categoryService.getCisdsByCid(1);
        System.out.println(list);*/
        /*List<Cart> carts = cartMapper.selectByExampleWithItems(null);
        System.out.println(carts);
        System.out.println(cartMapper.selectByPrimaryKeyWithItems(1));*/
        /*System.out.println(userMapper.selectByExampleWithCart(null));
        System.out.println(userMapper.selectByPrimaryKey(1));*/

        /*User user = new User();
        user.setUsername("testst");
        userMapper.insert(user);*/
        /*Order order = new Order();
        orderMapper.insert(order);*/

        List<Order> orders = orderMapper.selectByExampleWithOI(null);
        System.out.println(orders);

    }
}
