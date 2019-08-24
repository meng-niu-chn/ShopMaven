<%--
  Created by IntelliJ IDEA.
  User: 10283
  Date: 2019/5/14
  Time: 20:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Product</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <link href="${APP_PATH }/css/common.css"
          rel="stylesheet" type="text/css" />
    <link href="${APP_PATH }/css/cart.css"
          rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${APP_PATH }/static/jquery-3.3.1.js"></script>
    <script type="text/javascript">
        function incNumble(pid) {
            $.ajax({
                url:"numbleUpdateByPid?pid=" + pid + "&incOrSub=" + "inc",
                type:"GET",
                success:function(result){
                    $("#no"+pid).val(parseInt($("#no"+pid).val())+1);
                    $("#money"+pid).html(result.extendMap.ciMoney);
                    $("#effectivePrice").html(result.extendMap.total);
                }
            });
        }
        function subNumble(pid) {
            if(parseInt( $("#no"+pid).val()) > 1){
                $.ajax({
                    url:"numbleUpdateByPid?pid=" + pid + "&incOrSub=" + "sub",
                    type:"GET",
                    success:function(result){
                        alert(result);
                        $("#no"+pid).val(parseInt($("#no"+pid).val())-1);
                        $("#money"+pid).html(result.extendMap.ciMoney);
                        $("#effectivePrice").html(result.extendMap.total);
                    }
                });
            }
        }
    </script>
</head>
<body>
<div class="container header">
    <div class="span5">
        <div class="logo">
            <a href="${APP_PATH}/index"> <img src="${APP_PATH }/css/logo.gif" alt="服装商城">
            </a>
        </div>
    </div>
    <div class="span9">
        <div class="headerAd">
            <img src="${APP_PATH }/css/header.jpg" alt="正品保障" title="正品保障" width="320" height="50">
        </div>
    </div>


    <div class="span10 last">
        <div class="topNav clearfix">
            <ul>
                <c:choose>
                    <c:when test="${user == null}">
                        <li id="headerLogin" class="headerLogin" style="display: list-item;">
                            <a href="${APP_PATH }/getLogin" >登录</a>
                        </li>
                        <li id="headerRegister" class="headerRegister" style="display: list-item;">
                            <a href="${APP_PATH }/register">注册</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li id="headerLogin" class="headerLogin" style="display: list-item;">
                                ${loginUser.username}
                        </li>
                        <li id="headerLogin" class="headerLogin" style="display: list-item;">
                            <a href="${APP_PATH}/myOrder?page=1" style="color: red;">我的订单</a>|
                        </li>
                        <div class="cart">
                            <a href="${APP_PATH}/myCart">购物车</a>
                        </div>
                        <li id="headerLogout" class="headerLogout" style="display: list-item;">
                            <a href="${APP_PATH}/userLogout">退出</a>
                        </li>
                    </c:otherwise>
                </c:choose>

            </ul>
        </div>


    </div>
    <div class="span24">
        <ul class="mainNav">
            <li><a href="${APP_PATH}/index">首页</a> |</li>
            <c:forEach items="${categories}" var="category">
                <li><a href="${APP_PATH}/findProductsByCid?cid=${category.cid}&pn=1">${category.cname}</a> |</li>
            </c:forEach>
        </ul>
    </div>

</div>

<div class="container cart">
    <div class="span24">
        <div class="step step1"></div>
        <table>
            <tbody>
            <tr>
                <th>图片</th>
                <th>商品</th>
                <th>价格</th>
                <th>数量</th>
                <th>小计</th>
                <th>操作</th>
            </tr>

            <c:forEach items="${cart.cartItems}" var="cartItem">
                <c:if test="${cartItem.product.pid != null}">
                    <tr>
                        <!-- 商品图片 -->
                        <td width="60">
                            <input type="hidden" name="id" value="22">
                            <img src="${cartItem.product.image}"></td>
                        <!-- 商品名称 -->
                        <td><a target="_blank"> ${cartItem.product.pname}</a></td>
                        <!-- 商品单价 -->
                        <td>${cartItem.price}</td>
                        <!-- 商品数量 -->
                        <td class="quantity" width="120">
                                    <ul style="list-style: none;">
                                        <li style="display: block; float: left; vertical-align: middle;"><button onclick="incNumble(${cartItem.product.pid})">+</button></li>
                                        <li><input type="text" value="${cartItem.pcount}" disabled="disabled" id="no${cartItem.product.pid}"/></li>
                                        <li style="display: block; float: left; vertical-align: middle;"><button onclick="subNumble(${cartItem.product.pid})">-</button></li>
                                    </ul>
                        </td>
                        <!-- 小计 -->
                        <td class="quantity" width="60" id="money${cartItem.product.pid}">${cartItem.money}</td>
                        <!-- caozuo -->
                        <td>
                                <c:choose>
                                    <c:when test="${user != null}">
                                        <button><a href="${APP_PATH}/delCartItem?ciid=${cartItem.ciid}" class="delete">删除</a></button>
                                    </c:when>
                                    <c:otherwise>
                                        <button><a href="${APP_PATH}/delCartItemNoDb?pid=${cartItem.product.pid}" class="delete">删除</a></button>
                                    </c:otherwise>
                                </c:choose>
                        </td>
                    </tr>
                </c:if>
            </c:forEach>


            </tbody>
        </table>
        <dl id="giftItems" class="hidden" style="display: none;">
        </dl>
        <div class="total">
            <em id="promotion"></em>赠送积分: <em id="effectivePoint">${cartItem.money}</em> 商品金额: <strong id="effectivePrice">${cart.total}</strong>
        </div>
        <div class="bottom">
            <a href="clearCart" id="clear" class="clear">清空购物车</a>
            <a href="toOrder" id="submit" class="submit">提交订单</a>
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
