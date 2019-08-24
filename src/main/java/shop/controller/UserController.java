package shop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import shop.bean.Cart;
import shop.bean.Message;
import shop.bean.User;
import shop.service.CartService;
import shop.service.UserService;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

@Controller
public class UserController {

    @Autowired
    UserService userService;

    @Autowired
    CartService cartService;

    @RequestMapping("/getLogin")
    public String login(HttpSession httpSession){
        User user = (User) httpSession.getAttribute("user");
        if (user == null){
            return "customer/login";
        }
        return "redirect:index";
    }

    @RequestMapping("/checkImg")
    public void checkImg(HttpServletRequest request , HttpServletResponse response) throws IOException {

        int width = 120;
        int height = 30;

        // 步骤一 绘制一张内存中图片
        BufferedImage bufferedImage = new BufferedImage(width, height,
                BufferedImage.TYPE_INT_RGB);

        // 步骤二 图片绘制背景颜色 ---通过绘图对象
        Graphics graphics = bufferedImage.getGraphics();// 得到画图对象 --- 画笔
        // 绘制任何图形之前 都必须指定一个颜色
        graphics.setColor(getRandColor(200, 250));
        graphics.fillRect(0, 0, width, height);

        // 步骤三 绘制边框
        graphics.setColor(Color.WHITE);
        graphics.drawRect(0, 0, width - 1, height - 1);

        // 步骤四 四个随机数字
        Graphics2D graphics2d = (Graphics2D) graphics;
        // 设置输出字体
        graphics2d.setFont(new Font("宋体", Font.BOLD, 18));

        // String words
        // ="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890";
        String words = "\u7684\u4e00\u4e86\u662f\u6211\u4e0d\u5728\u4eba\u4eec\u6709\u6765\u4ed6\u8fd9\u4e0a\u7740\u4e2a\u5730\u5230\u5927\u91cc\u8bf4\u5c31\u53bb\u5b50\u5f97\u4e5f\u548c\u90a3\u8981\u4e0b\u770b\u5929\u65f6\u8fc7\u51fa\u5c0f\u4e48\u8d77\u4f60\u90fd\u628a\u597d\u8fd8";
        Random random = new Random();// 生成随机数
        // 定义StringBuffer
        StringBuffer sb = new StringBuffer();
        // 定义x坐标
        int x = 10;
        for (int i = 0; i < 4; i++) {
            // 随机颜色
            graphics2d.setColor(new Color(20 + random.nextInt(110), 20 + random
                    .nextInt(110), 20 + random.nextInt(110)));
            // 旋转 -30 --- 30度
            int jiaodu = random.nextInt(60) - 30;
            // 换算弧度
            double theta = jiaodu * Math.PI / 180;

            // 生成一个随机数字
            int index = random.nextInt(words.length()); // 生成随机数 0 到 length - 1
            // 获得字母数字
            char c = words.charAt(index);
            sb.append(c);
            // 将c 输出到图片
            graphics2d.rotate(theta, x, 20);
            graphics2d.drawString(String.valueOf(c), x, 20);
            graphics2d.rotate(-theta, x, 20);
            x += 30;
        }

        // 将生成的字母存入到session中
        request.getSession().setAttribute("checkcode", sb.toString());
        System.out.println(sb.toString());
        // 步骤五 绘制干扰线
        graphics.setColor(getRandColor(160, 200));
        int x1;
        int x2;
        int y1;
        int y2;
        for (int i = 0; i < 30; i++) {
            x1 = random.nextInt(width);
            x2 = random.nextInt(12);
            y1 = random.nextInt(height);
            y2 = random.nextInt(12);
            graphics.drawLine(x1, y1, x1 + x2, x2 + y2);
        }

        // 将上面图片输出到浏览器 ImageIO
        graphics.dispose();// 释放资源
        ImageIO.write(bufferedImage, "jpg", response.getOutputStream());
    }

    private Color getRandColor(int fc, int bc) {
        // 取其随机颜色
        Random random = new Random();
        if (fc > 255) {
            fc = 255;
        }
        if (bc > 255) {
            bc = 255;
        }
        int r = fc + random.nextInt(bc - fc);
        int g = fc + random.nextInt(bc - fc);
        int b = fc + random.nextInt(bc - fc);
        return new Color(r, g, b);
    }

    @RequestMapping("/userLogin")
    public String checkLogin(User toUser, @RequestParam("checkImg") String checkImg, Model model,HttpSession httpSession){
        String sessionCode = (String) httpSession.getAttribute("checkcode");
        System.out.println("sessionCode: " + sessionCode);
        System.out.println("checkImg: " + checkImg);
        if (!checkImg.equalsIgnoreCase(sessionCode)){
            model.addAttribute("message","验证码输入错误!");
            return "customer/login";
        } else {
            User user = userService.getUserByUser(toUser);
            System.out.println("user : " + user);
            if (user == null){
                model.addAttribute("message","用户名或密码输入错误！");
                return "customer/login";
            }else {
                httpSession.setAttribute("user",user);
                httpSession.setAttribute("cart",user.getCart());
                System.out.println("user:cart: " + user.getCart());
                return "customer/index";
            }
        }
    }

    @RequestMapping("/userLogout")
    public String userLogout(HttpSession httpSession){
        httpSession.removeAttribute("user");
        httpSession.removeAttribute("cart");
        return "redirect:index";
    }

    @RequestMapping("/register")
    public String register(){
        return "customer/register";
    }

    @RequestMapping("/usernameCheck")
    @ResponseBody
    public Message usernameCheck(@RequestParam("username") String username){

        boolean flag = userService.usernameCheck(username);
        if (username == "" || username == null){
            return Message.fail();
        }
        if(flag){
            return Message.success();
        }
        else {
            return Message.fail();
        }
    }

    @RequestMapping("/userRegist")
    public String userRegist(User user, @RequestParam("checkImg") String checkImg, @RequestParam("addrP") String addrP, @RequestParam("addrC") String addrC, @RequestParam("addrA") String addrA, HttpSession httpSession,Model model){
        String sessionCode = (String) httpSession.getAttribute("checkcode");
        System.out.println("sessionCode: " + sessionCode);
        System.out.println("checkImg: " + checkImg);
        if (!userService.usernameCheck(user.getUsername())){
            model.addAttribute("message","用户名不可用!");
            return "customer/register";
        }
        if (!checkImg.equalsIgnoreCase(sessionCode)){
            model.addAttribute("message","验证码输入错误!");
            return "customer/register";
        } else {
            System.out.println(user);
            String addr = "";
            if (!addrP.equals("请选择省份"))
                addr += addrP;
            else if (!addrC.equals("请选择城市"))
                addr += "-" + addrC;
            else if (!addrA.equals("请选择区县"))
                addr += "-" + addrA;
            user.setAddr(addr);
            userService.addUser(user);
            System.out.println(user);

            Cart cart = new Cart();
            cart.setUid(user.getUid());
            cartService.addCart(cart);

            model.addAttribute("message","注册成功!");
            return "customer/login";
        }
    }

}
