<%--
  Created by IntelliJ IDEA.
  User: 10283
  Date: 2019/5/14
  Time: 15:40
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
<%--    <link href="${APP_PATH }/css/slider.css"
          rel="stylesheet" type="text/css" />--%>
    <link href="${APP_PATH }/css/common.css"
          rel="stylesheet" type="text/css" />
<%--    <link href="${APP_PATH }/css/index.css"
          rel="stylesheet" type="text/css" />--%>
    <link href="${APP_PATH }/css/product.css"
          rel="stylesheet" type="text/css" />
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

<div class="container productContent">
    <div class="span6">
        <div class="hotProductCategory">

            <c:forEach items="${categories}" var="category">
                <dl>
                    <dt>
                        <a href="${APP_PATH}/findProductsByCid?cid=${category.cid}&pn=1">${category.cname}</a>
                    </dt>
                    <c:forEach items="${category.categorySeconds}" var="categorySecond">
                        <dd>
                            <a href="${APP_PATH}/findProductsByCsid?csid=${categorySecond.csid}&pn=1">${categorySecond.csname}</a>
                        </dd>
                    </c:forEach>
                </dl>

            </c:forEach>
        </div>
    </div>

    <div class="span18 last">
        <div class="productImage">
            <div class="zoomPad">
                <img style="opacity: 1;" title="" class="medium" src="${product.image}">
                <div style="display: block; top: 0px; left: 162px; width: 0px; height: 0px; position: absolute; border-width: 1px;" class="zoomPup"></div>
                <div style="position: absolute; z-index: 5001; left: 312px; top: 0px; display: block;" class="zoomWindow">
                    <div style="width: 368px;" class="zoomWrapper">
                        <div style="width: 100%; position: absolute; display: none;" class="zoomWrapperTitle"></div>
                        <div style="width: 0%; height: 0px;" class="zoomWrapperImage">
                            <img src="${product.image}" style="position: absolute; border: 0px none; display: block; left: -432px; top: 0px;">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="name">
            ${product.pname}
        </div>
        <div class="sn">
            <div>
                编号：
                ${product.pid}
            </div>
        </div>
        <div class="info">
            <dl>
                <dt>亿家价:</dt>
                <dd>
                    <strong>￥： ${product.price} 元
                    </strong> 参 考 价：
                    <del>
                        ￥ ${product.price + 100} 元
                    </del>
                </dd>
            </dl>
            <dl>
                <dt>促销:</dt>
                <dd>
                    <a target="_blank" title="限时抢购 ">限时抢购</a>
                </dd>
            </dl>
            <dl>
                <dt></dt>
                <dd>
                    <span> </span>
                </dd>
            </dl>
        </div>
        <form id="cartForm" action="${APP_PATH }/addCart" method="post">
            <input type="hidden" name="pid" value="${product.pid}">
            <div class="action">
                <dl class="quantity">
                    <dt>购买数量:</dt>
                    <dd>
                        <input id="count" name="count" value="1" maxlength="4" onpaste="return false;" type="text">
                        <div>
                            <!-- 设置数量的增加或减少 -->
                            <span id="increase" class="increase" onclick="javascript:document.getElementById('count').value = parseInt(document.getElementById('count').value) + 1">&nbsp;</span>
                            <span id="decrease" class="decrease" onclick="javascript:document.getElementById('count').value -=  document.getElementById('count').value > 1 ? 1  : 0">&nbsp;</span>
                        </div>
                    </dd>
                    <dd>件</dd>
                </dl>
                <div class="buy">
                    <input id="addCart" class="addCart" value="加入购物车" type="submit" title="点击加入购物车">
                </div>
            </div>
        </form>
        <div id="bar" class="bar">
            <ul>
                <li id="introductionTab"><a href="#introduction">商品介绍</a></li>

            </ul>
        </div>

        <div id="introduction" name="introduction" class="introduction">
            <div class="title">
                <strong>${product.pdesc}</strong>
            </div>
            <div>
                <img src="${product.image}">
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
