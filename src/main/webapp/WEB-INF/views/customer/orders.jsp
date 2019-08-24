<%--
  Created by IntelliJ IDEA.
  User: 10283
  Date: 2019/5/21
  Time: 22:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>Title</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <link href="${APP_PATH}/css/common.css"
          rel="stylesheet" type="text/css" />
    <link href="${APP_PATH}/css/cart.css"
          rel="stylesheet" type="text/css" />
    <link href="${APP_PATH}/css/product.css"
          rel="stylesheet" type="text/css" />
</head>
<body>
<div class="container header">
    <div class="span5">
        <div class="logo">
            <a> <img
                    src="${APP_PATH}/image/r___________renleipic_01/logo.gif"
                    alt="" />
            </a>
        </div>
    </div>
    <div class="span9">
        <div class="headerAd">
            <img src="${pageContext.request.contextPath}/image/header.jpg"
                 width="320" height="50" alt="正品保障" title="正品保障" />
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
        <div class="step step1">
            <ul>
                <li class="current"></li>
                <li>我的订单</li>
            </ul>
        </div>
        <table>
            <tbody>
            <c:forEach items="${pageInfo.list }" var="order">
                <tr>
                    <th colspan="5">订单编号:<font color="red">${order.oid}</font>&nbsp;&nbsp;&nbsp;&nbsp;
                        订单金额:<font color="red">${order.total}</font>&nbsp;&nbsp;&nbsp;&nbsp;
                        订单状态： <c:if test="${order.state==0}">
                            <a style="color: red;"
                               href="${APP_PATH}/toPay?oid=${order.oid}">付款</a>
                        </c:if>
                        <c:if test="${order.state==1}">
                            已付款即将发货
                        </c:if>
                        <c:if test="${order.state==2}">已发货，
                            <a style="color: red;"
                               href="${APP_PATH}}/updateOrder?oid=${order.oid}&pn=${pageInfo.pageNum}">确认收货</a>
                        </c:if>
                        <c:if test="${order.state==3}">
                            交易成功
                        </c:if>
                    </th>
                </tr>
                <tr>
                    <th>图片</th>
                    <th>商品</th>
                    <th>价格</th>
                    <th>数量</th>
                    <th>小计</th>
                </tr>
                <c:forEach items="${order.orderItems}" var="orderItem">
                    <tr>
                        <td width="60"><img
                                src="${orderItem.product.image}" />
                        </td>
                        <td>${orderItem.product.pname}</td>
                        <td>${orderItem.product.price}</td>
                        <td class="quantity" width="60">
                                ${orderItem.count}
                        </td>
                        <td width="140">
								    <span class="subtotal">
								    	￥ ${orderItem.money}
									</span>
                        </td>
                    </tr>
                </c:forEach>
            </c:forEach>

            <tr>
                <th colspan="5">
                    <div class="pagination">
                        <span>第${pageInfo.pageNum}/${pageInfo.pages}页</span>
                        <c:if test="${pageInfo.hasPreviousPage != false}">
                            <a
                                    href="myOrder?pn=1"
                                    class="firstPage">&nbsp;</a>
                            <a
                                    href="myOrder?pn=${pageInfo.pageNum - 1}"
                                    class="previousPage">&nbsp;</a>
                        </c:if>

                        <c:forEach items="${pageInfo.navigatepageNums}" var="page">
                            <c:choose>
                                <c:when test="${page == pageInfo.pageNum}">
                                    <span class="currentPage">${page}</span>
                                </c:when>
                                <c:otherwise>
                                    <a href="myOrder?pn=${page}">${page}</a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>


                        <c:if test="${pageInfo.hasNextPage != false}">
                            <a class="nextPage"
                               href="myOrder?pn=${pageInfo.pageNum +1}">&nbsp;</a>
                            <a class="lastPage"
                               href="myOrder?pn=${pageInfo.total}">&nbsp;</a>
                        </c:if>
                    </div>
                </th>
            </tr>
            </tbody>
        </table>
    </div>

</div>
<div class="container footer">
    <div class="span24">
        <div class="footerAd">
            <img src="image\r___________renleipic_01/footer.jpg" alt="我们的优势"
                 title="我们的优势" height="52" width="950">
        </div>
    </div>
    <div class="span24">
        <ul class="bottomNav">
            <li><hr></hr></li>
        </ul>
    </div>
    <div class="span24">
        <div class="copyright">Copyright ©  网上商城 版权所有</div>
    </div>
</div>
</body>
</html>
