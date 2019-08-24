package shop.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import shop.bean.Product;
import shop.service.CategoryService;
import shop.service.ProductService;

import java.util.List;

@Controller
public class ProductController {

    @Autowired
    ProductService productService;
    @Autowired
    CategoryService categoryService;

    @RequestMapping("/findProductsByCsid")
    public String getProductsByCsid(@RequestParam("csid") Integer csid, Model model,@RequestParam(value = "pn",defaultValue = "1") Integer pn){
        PageHelper.startPage(pn, 12);
        List<Product> products = productService.getProductsByCsid(csid);
        PageInfo pageInfo = new PageInfo(products,5);
        model.addAttribute("pageInfo",pageInfo);

        model.addAttribute("id","Csid");
        model.addAttribute("lid","?csid="+csid);
        return "customer/products";
    }

    @RequestMapping("/findProductsByCid")
    public String getProductsByCid(@RequestParam("cid") Integer cid, Model model,@RequestParam(value = "pn",defaultValue = "1") Integer pn){
        System.out.println(pn);
        List<Integer> csids = categoryService.getCisdsByCid(cid);
        PageHelper.startPage(pn, 12);
        List<Product> products = productService.getProductsByCsids(csids);
        PageInfo pageInfo = new PageInfo(products,5);
        model.addAttribute("pageInfo",pageInfo);

        model.addAttribute("id","Cid");
        model.addAttribute("lid","?cid="+cid);
        return "customer/products";
    }

    @RequestMapping("/findProductByPid")
    public String getProductBypid(@RequestParam("pid") Integer pid,Model model) {
        Product product = productService.getProductByPid(pid);
        model.addAttribute("product",product);
        return "customer/product";
    }
}
