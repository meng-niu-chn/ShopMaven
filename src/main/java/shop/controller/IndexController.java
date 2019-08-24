package shop.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import shop.bean.Cart;
import shop.bean.Category;
import shop.bean.Product;
import shop.service.CategoryService;
import shop.service.ProductService;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class IndexController {

    @Autowired
    CategoryService categoryService;
    @Autowired
    ProductService productService;

    @RequestMapping({"/index","/"})
    public String getIndex(Model model, HttpSession httpSession){
        Cart cart = (Cart) httpSession.getAttribute("cart");
        if(cart == null){
            cart = new Cart();
            cart.setCartid(0);
            cart.setUid(0);
            cart.setTotal(0D);
            httpSession.setAttribute("cart",cart);
        }

        List<Category> categories = categoryService.getAllWithSeconds();
        PageHelper.startPage(1, 8);
        List<Product> hotProducts = productService.getHotProducts();
        PageInfo hotPage = new PageInfo(hotProducts, 5);

        PageHelper.startPage(1, 8);
        List<Product> newProducts = productService.getNewProducts();
        PageInfo newPage = new PageInfo(newProducts, 5);

        httpSession.setAttribute("categories",categories);
        model.addAttribute("hotProducts",hotPage);
        model.addAttribute("newProducts",newPage);
        return "customer/index";
    }

}
