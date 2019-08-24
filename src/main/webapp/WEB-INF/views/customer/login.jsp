<%--
  Created by IntelliJ IDEA.
  User: 10283
  Date: 2019/5/15
  Time: 20:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>Title</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <link href="${APP_PATH }/css/common.css"
          rel="stylesheet" type="text/css" />
    <link href="${APP_PATH }/css/login.css"
          rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function change(){
            var img = document.getElementById("checkImg");
            img.src="${APP_PATH}/checkImg?"+new Date();
        }
    </script>
</head>
<body>
<div class="container header">
    <div class="span5">
        <div class="logo">
            <a href="${APP_PATH}"> <img
                    src="${APP_PATH}/image/r___________renleipic_01/logo.gif" alt="">
            </a>
        </div>
    </div>
    <div class="span9">
        <div class="headerAd">
            <img src="${APP_PATH}/image/header.jpg" width="320" height="50" alt="正品保障"
                 title="正品保障">
        </div>
    </div>
    <div class="span10 last">
        <div class="topNav clearfix">
            <ul>
                <li id="headerLogin" class="headerLogin" style="display: list-item;">
                    <a href="#" data-toggle="modal" data-target="#loginModal">登录</a>
                </li>
                <li id="headerRegister" class="headerRegister" style="display: list-item;">
                    <a href="${APP_PATH }/register">注册</a>
                </li>

            </ul>
        </div>

    </div>

</div>
<div class="container login">
    <div class="span12">
        <div class="ad">
            <img src="${APP_PATH}/image/login.jpg" width="500" height="330" alt="会员登录"
                 title="会员登录">
        </div>
    </div>
    <div class="span12 last">
        <div class="wrap">
            <div class="main">
                <div class="title">
                    <strong>会员登录</strong>USER LOGIN
                </div>
                <form id="loginForm" method="post"
                      action="userLogin" novalidate="novalidate">
                    <table>
                        <tbody>
                        <tr>
                            <th>用户名:</th>
                            <td>
                                <input type="text" id="username" name="username"
                                       class="text" maxlength="20">
                                <span id="span1" style="color:green;"></span>
                            </td>
                        </tr>
                        <tr>
                            <th>密&nbsp;&nbsp;码:</th>
                            <td><input type="password" id="password" name="passeord"
                                       class="text" maxlength="20" autocomplete="off"></td>
                        </tr>
                        <tr>
                            <th>验证码:</th>
                            <td>
										<span class="fieldSet">
										<input type="text" id="captcha" name="checkImg" class="text captcha" maxlength="4" autocomplete="off">
										<img id="checkImg" class="captchaImage" src="${APP_PATH}/checkImg"
                                             title="点击更换验证码" onclick="change()"> 
										</span>
                            </td>
                        </tr>
                        <%--<tr>
                            <th>&nbsp;</th>
                            <td><label> <input type="checkbox"
                                               id="isRememberUsername" name="isRememberUsername"
                                               value="true">记住用户名
                            </label> <label> &nbsp;&nbsp;<a>找回密码</a>
                            </label></td>
                        </tr>--%>
                        <tr>
                            <th></th>
                            <td style="color:#ff0000;"><input type="submit" class="submit" value="登 录">
                                &nbsp;${message}
                            </td>
                        </tr>
                        <tr class="register">
                            <th>&nbsp;</th>
                            <td>
                                <dl>
                                    <dt>还没有注册账号？</dt>
                                    <dd>
                                        立即注册即可体验在线购物！ <a href="${APP_PATH }/register">立即注册</a>
                                    </dd>
                                </dl>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="container footer">
    <div class="span24">
        <div class="footerAd">
            <img src="${APP_PATH}/css/footer.jpg" alt="我们的优势" title="我们的优势" width="950" height="52">
        </div>
    </div>
    <div class="span24">
        <ul class="bottomNav">
            <li><hr></li>
        </ul>
    </div>
    <div class="span24">
        <div class="copyright">Copyright © 网上商城 版权所有</div>
    </div>
</div>
</body>
</html>
