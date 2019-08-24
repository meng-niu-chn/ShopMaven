<%--
  Created by IntelliJ IDEA.
  User: 10283
  Date: 2019/5/14
  Time: 10:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Products</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <link href="${APP_PATH }/css/slider.css"
          rel="stylesheet" type="text/css" />
    <link href="${APP_PATH }/css/common.css"
          rel="stylesheet" type="text/css" />
    <link href="${APP_PATH }/css/index.css"
          rel="stylesheet" type="text/css" />
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

<div class="container productList">
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
        <div id="result" class="result table clearfix">
            <ul>
                <c:forEach items="${pageInfo.list}" var="product">
                    <li>
                        <a href="${APP_PATH}/findProductByPid?pid=${product.pid}" target="_blank">
                            <img src="${product.image}" style="display: inline-block;" width="170" height="170">
                            <span style="color: green;align:center;">${product.pname}</span>
                            <span class="price">商城价： ￥${product.price} </span>
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <div class="pagination">
            <span>第${pageInfo.pageNum}/${pageInfo.pages}页</span>
            <c:if test="${pageInfo.hasPreviousPage != false}">
                <a
                        href="${APP_PATH}/findProductsBy${id}${lid}&pn=1"
                        class="firstPage">&nbsp;</a>
                <a
                        href="${APP_PATH}/findProductsBy${id}${lid}&pn=${pageInfo.pageNum - 1}"
                        class="previousPage">&nbsp;</a>
            </c:if>

            <c:forEach items="${pageInfo.navigatepageNums}" var="page">
                <c:choose>
                    <c:when test="${page == pageInfo.pageNum}">
                        <span class="currentPage">${page}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="${APP_PATH}/findProductsBy${id}${lid}&pn=${page}">${page}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>


            <c:if test="${pageInfo.hasNextPage != false}">
                <a class="nextPage"
                   href="${APP_PATH}/findProductsBy${id}${lid}&pn=${pageInfo.pageNum +1}">&nbsp;</a>
                <a class="lastPage"
                   href="${APP_PATH}/findProductsBy${id}${lid}&pn=${pageInfo.total}">&nbsp;</a>
            </c:if>
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
