package shop.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import shop.bean.*;
import shop.service.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.Date;
import java.util.List;

//import shop.service.CategorySecondService;

@Controller
public class ManageController {


    @Autowired
    private UserService userService;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private CategorySecondService categorySecondService;
    @Autowired
    private ProductService productService;
    @Autowired
    private OrderService orderService;

    @RequestMapping("/home")
    public String TestHome(){
        System.out.println("home Controller");
        return "manage/home";
    }


    @RequestMapping("/usermanage")
    public String UserManage(Model model, @RequestParam(value = "pn",defaultValue = "1") Integer pn){
        System.out.println("usernamageController");
        PageHelper.startPage(pn, 5);
        List<User> users = userService.getAll();
        PageInfo page = new PageInfo(users, 5);
        model.addAttribute("pageInfo",page);
        return "manage/usermanage";
    }

    /*################    Category    ##################*/

    @RequestMapping("/categorymanage")
    public String CategoryManage(Model model, @RequestParam(value = "pn",defaultValue = "1") Integer pn){
        /*System.out.println("categorymanageController");
        PageHelper.startPage(pn, 5);
        List<Category> categories = categoryService.getAll();
        PageInfo page = new PageInfo(categories, 5);
        model.addAttribute("pageInfo",page);*/
//        return "manage/categorymanage";

        return CategoryList(model,pn);
    }

    public String CategoryList(Model model,Integer pn){
        PageHelper.startPage(pn, 5);
        List<Category> categories = categoryService.getAll();
        PageInfo page = new PageInfo(categories, 5);
        model.addAttribute("pageInfo",page);
        return "manage/categorymanage";
    }

    @RequestMapping("/category_delete")
    public String Category_Delete(Model model,@RequestParam("cid") Integer cid,@RequestParam("currentPage") Integer currentPage){
        System.out.println(cid);
        categoryService.deleteByCid(cid);

        model.addAttribute("message","删除成功！");
        return CategoryList(model,currentPage);
    }

    @RequestMapping("/category_update")
    public String Category_Update(Model model,@RequestParam("cid") String cid,@RequestParam("cname") String cname,@RequestParam("currentPage") Integer currentPage){
        System.out.println(cid);
        Category category = new Category();
        category.setCid(Integer.parseInt(cid));
        category.setCname(cname);
        categoryService.updateByCid(category);

        model.addAttribute("message","修改成功！");
        return CategoryList(model,currentPage);
    }

    @RequestMapping("/category_add")
    public String Category_Add(Model model,@RequestParam("cname") String cname,@RequestParam("lastPage") Integer lastPage){
        Category category = new Category();
        category.setCname(cname);
        categoryService.add(category);

        model.addAttribute("message","新增成功！");
        return CategoryList(model,lastPage);
    }

    @RequestMapping("/category_check")
    @ResponseBody
    public Message Category_Check(@RequestParam("cname") String cname){
        System.out.println("Category_Check: "+ cname);
        boolean flag = categoryService.check(cname);

        if(flag){
            return Message.success().add("checkMessage","菜单名字可用");
        }
        else {
            return Message.fail().add("checkMessage","菜单名字不可用");
        }
    }

    /*##################   CategorySecond   ###################*/

    @RequestMapping("/categorysemanage")
    public String CategorySecondManage(Model model, @RequestParam(value = "pn",defaultValue = "1") Integer pn){
        /*System.out.println("categorymanageController");
        PageHelper.startPage(pn, 5);
        List<Category> categories = categoryService.getAll();
        PageInfo page = new PageInfo(categories, 5);
        model.addAttribute("pageInfo",page);*/
//        return "manage/categorymanage";
        System.out.println("categoruSecondManage");
        return CategorySecondList(model,pn);
    }

    public String CategorySecondList(Model model,Integer pn){
        System.out.println("categorySecondList");

        //Category
        List<Category> categories = categoryService.getAll();
        model.addAttribute("clist",categories);

        //categorySecond
        PageHelper.startPage(pn, 5);
        List<CategorySecond> categorySeconds = categorySecondService.getAll();
        PageInfo page = new PageInfo(categorySeconds, 5);
        model.addAttribute("pageInfo",page);
        return "manage/categorysemanage";
    }



    @RequestMapping("/categoryse_delete")
    public String CategorySecond_Delete(Model model,@RequestParam("csid") Integer csid,@RequestParam("currentPage") Integer currentPage){
        System.out.println(csid);
        categorySecondService.deleteByCsid(csid);

        model.addAttribute("message","删除成功！");
        return CategorySecondList(model,currentPage);
    }

    @RequestMapping("/categoryse_update")
    public String CategorySecond_Update(Model model,CategorySecond categorySecond,@RequestParam("currentPage") Integer currentPage){
        System.out.println(categorySecond);
        categorySecondService.updateByExample(categorySecond);
        model.addAttribute("message","修改成功！");
        return CategorySecondList(model,currentPage);
    }

    @RequestMapping(value = "/categoryse_add",method = RequestMethod.POST)
    public String CategorySecond_Add(Model model,@RequestParam("lastPage") Integer lastPage, CategorySecond categorySecond){
        System.out.println(lastPage);
        System.out.println(categorySecond);
        categorySecondService.add(categorySecond);

        model.addAttribute("message","新增成功！");
        return CategorySecondList(model,lastPage);
    }

    @RequestMapping("/categoryse_check")
    @ResponseBody
    public Message CategorySecond_Check(@RequestParam("csname") String csname){
        System.out.println("Categoryse_Check: "+ csname);
        boolean flag = categorySecondService.check(csname);

        if(flag){
            return Message.success().add("checkMessage","菜单名字可用");
        }
        else {
            return Message.fail().add("checkMessage","菜单名字不可用");
        }
    }

    /*######################          Test Upload and Download         ###########################*/

    @RequestMapping("/testUpDo")
    public String tstUpDo(){
        return "manage/testUpDo";
    }

    @RequestMapping(value="/upload",method=RequestMethod.POST)
    @ResponseBody
    public String upload(MultipartFile file, HttpServletRequest request) throws IOException {
        System.out.println(file);
        String path = request.getSession().getServletContext().getRealPath("/products/imgs");
        System.out.println(path);
        String fileName = file.getOriginalFilename();
        File dir = new File(path,fileName);
        if(!dir.exists()){
            dir.mkdirs();
        }

        file.transferTo(dir);
        return fileName;
    }

    @RequestMapping("/down")
    public void down(HttpServletRequest request,HttpServletResponse response) throws Exception{

        String fileName = request.getSession().getServletContext().getRealPath("/products/imgs")+"/good.png";

        InputStream bis = new BufferedInputStream(new FileInputStream(new File(fileName)));

        String filename = "下载文件.jpg";

        filename = URLEncoder.encode(filename,"UTF-8");

        response.addHeader("Content-Disposition", "attachment;filename=" + filename);

        response.setContentType("multipart/form-data");

        BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());
        int len = 0;
        while((len = bis.read()) != -1){
            out.write(len);
            out.flush();
        }
        out.close();
    }


    /*######################          Product manage         ###########################*/

    @RequestMapping("/productmanage")
    public String ProductManage(Model model, @RequestParam(value = "pn",defaultValue = "1") Integer pn){
        /*System.out.println("categorymanageController");
        PageHelper.startPage(pn, 5);
        List<Category> categories = categoryService.getAll();
        PageInfo page = new PageInfo(categories, 5);
        model.addAttribute("pageInfo",page);*/
//        return "manage/categorymanage";

        return ProductList(model,pn);
    }

    public String ProductList(Model model,Integer pn){

        List<CategorySecond> categorySeconds = categorySecondService.getAll();
        model.addAttribute("cslist",categorySeconds);

        PageHelper.startPage(pn, 5);
        List<Product> products = productService.getAll();
        PageInfo page = new PageInfo(products, 5);
        model.addAttribute("pageInfo",page);
        return "manage/productmanage";
    }

    @RequestMapping("/product_delete")
    public String Product_Delete(Model model,@RequestParam("pid") Integer pid,@RequestParam("currentPage") Integer currentPage){
        System.out.println(pid);
        productService.deleteByPid(pid);

        model.addAttribute("message","删除成功！");
        return ProductList(model,currentPage);
    }

    @RequestMapping("/product_update")
    public String Product_Update(MultipartFile file, HttpServletRequest request,Model model,Product product,@RequestParam("currentPage") Integer currentPage) throws IOException {
        System.out.println(product);
        System.out.println(file);
        /*处理文件*/
        if(!file.isEmpty()){
            String path = request.getSession().getServletContext().getRealPath("/products/imgs");
            System.out.println(path);
            String fileName = Math.random()*100 + file.getOriginalFilename();
            File dir = new File(path,fileName);
            if(!dir.exists()){
                dir.mkdirs();
            }
            file.transferTo(dir);
            product.setImage("products/imgs/"+fileName);
        }

        productService.updateByPid(product);
        model.addAttribute("message","修改成功！");
        return ProductList(model,currentPage);
    }

    @RequestMapping("/product_add")
    public String Product_Add(MultipartFile file, HttpServletRequest request,Model model,Product product,@RequestParam("lastPage") Integer lastPage) throws IOException {
        System.out.println(product);
        System.out.println(file);
        /*处理文件*/
        if (!file.isEmpty()) {
            String path = request.getSession().getServletContext().getRealPath("/products/imgs");
            System.out.println(path);
            String fileName = Math.random()*100 + file.getOriginalFilename();
            File dir = new File(path,fileName);
            if(!dir.exists()){
                dir.mkdirs();
            }
            file.transferTo(dir);
            product.setImage("products/imgs/"+fileName);
        }
        product.setPdate(new Date());
        productService.add(product);

        model.addAttribute("message","新增成功！");
        return ProductList(model,lastPage);
    }

//    @RequestMapping("/product_check")
//    @ResponseBody
//    public Message Product_Check(@RequestParam("cname") String cname){
//        System.out.println("Category_Check: "+ cname);
//        boolean flag = categoryService.check(cname);
//
//        if(flag){
//            return Message.success().add("checkMessage","菜单名字可用");
//        }
//        else {
//            return Message.fail().add("checkMessage","菜单名字不可用");
//        }
//    }

    /*###########################        Order Manage      ##############################*/

    @RequestMapping("ordermanage")
    public String orderManage(Model model,@RequestParam("state") Integer state,@RequestParam(value = "pn",defaultValue = "1") Integer pn){

        PageHelper.startPage(pn, 5);
        List<Order> orders = orderService.getOrdersByState(state);
        PageInfo pageInfo = new PageInfo(orders,5);

        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("state",state);
        return "manage/ordermanage";
    }

    @RequestMapping("/updateOrderManage")
    public String updateOrder(@RequestParam("oid") Integer oid,@RequestParam("state") Integer state,@RequestParam(value = "pn",defaultValue = "1") Integer pn){
        Order order = orderService.getOrderByOid(oid);
        order.setState(order.getState() + 1);
        orderService.update(order);
        return "redirect:/ordermanage?state=" + state + "&pn=" + pn;
    }
}
