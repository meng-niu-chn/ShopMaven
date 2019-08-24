<%--
  Created by IntelliJ IDEA.
  User: 10283
  Date: 2019/5/21
  Time: 10:29
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
    <link href="${APP_PATH}/css/common.css" type="text/css" rel="stylesheet">
    <link href="${APP_PATH}/css/cart.css" type="text/css" rel="stylesheet">
</head>
<body>

<div class="container header">
    <div class="span5">
        <div class="logo">
            <a>
                <img src="${APP_PATH}/image/r___________renleipic_01/logo.gif" alt=""/>
            </a>
        </div>
    </div>
    <div class="span9">
        <div class="headerAd">
            <img src="${APP_PATH}/image/header.jpg" width="320" height="50" alt="正品保障" title="正品保障"/>
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

    <!-- 菜单栏 -->
</div>

<div class="container cart">
    <div class="span24">
        <div class="step step1">
            <ul>
                <li  class="current"></li>
                <li>生成订单成功</li>
            </ul>
        </div>
        <table>
            <tbody>
            <th colspan="5">订单编号:${order.oid}&nbsp;&nbsp;&nbsp;&nbsp;</th>
            <tr>
                <th>图片</th>
                <th>商品</th>
                <th>价格</th>
                <th>数量</th>
                <th>小计</th>
            </tr>
            <c:forEach items="${order.orderItems}" var="orderItem">
                <tr>
                    <td width="60">
                        <input type="hidden" name="id" value="22"/>
                        <img src="${orderItem.product.image}">
                    </td>
                    <td>
                        <a target="_blank"> ${orderItem.product.pname}</a>
                    </td>
                    <td>
                            ${orderItem.product.price}
                    </td>
                    <td class="quantity" width="60">
                            ${orderItem. count}
                    </td>
                    <td width="140">
                        <span class="subtotal">${orderItem.money}</span>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <dl id="giftItems" class="hidden" style="display: none;">
        </dl>
        <div class="total">
            <em id="promotion"></em>
            商品金额: <strong id="effectivePrice">${order.total}</strong>
        </div>
        <form id="orderForm" action="payOrder" method="post">
            <input type="hidden" name="oid" value="${orders.oid}"/>
            <div class="span24">
                <p>
                    收货地址：<input name="receiveinfo" type="text" value="" style="width:350px" />
                    <br />
                    收货人&nbsp;&nbsp;&nbsp;：<input name="accepter" type="text" value="" style="width:150px" />
                    <br />
                    联系方式：<input name="phonum" type="text" value="" style="width:150px" />
                </p>
                <hr />
                <p>
                    选择银行：<br/>
                    <input type="radio" name="pd_FrpId" value="ICBC-NET-B2C" checked="checked"/>工商银行
                    <img src="${APP_PATH}/bank_img/icbc.bmp" align="middle"/>&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="pd_FrpId" value="BOC-NET-B2C"/>中国银行
                    <img src="${APP_PATH}/bank_img/bc.bmp" align="middle"/>&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="pd_FrpId" value="ABC-NET-B2C"/>农业银行
                    <img src="${APP_PATH}/bank_img/abc.bmp" align="middle"/>
                    <br/>
                    <input type="radio" name="pd_FrpId" value="BOCO-NET-B2C"/>交通银行
                    <img src="${APP_PATH}/bank_img/bcc.bmp" align="middle"/>&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="pd_FrpId" value="PINGANBANK-NET"/>平安银行
                    <img src="${ APP_PATH }/bank_img/pingan.bmp" align="middle"/>&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="pd_FrpId" value="CCB-NET-B2C"/>建设银行
                    <img src="${APP_PATH}/bank_img/ccb.bmp" align="middle"/>
                    <br/>
                    <input type="radio" name="pd_FrpId" value="CEB-NET-B2C"/>光大银行
                    <img src="${APP_PATH}/bank_img/guangda.bmp" align="middle"/>&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="pd_FrpId" value="CMBCHINA-NET-B2C"/>招商银行
                    <img src="${APP_PATH}/bank_img/cmb.bmp" align="middle"/>
                </p>
                <hr />
                <p style="text-align:right">
                    <!-- 在超链接中添加javascript:document.getElementById('orderForm').submit();代码 功能就相当于提交表单 -->
                    <a href="javascript:document.getElementById('orderForm').submit();">
                        <img src="${APP_PATH}/images/finalbutton.gif" width="204" height="51" border="0" />
                    </a>
                </p>
            </div>
        </form>
    </div>

</div>
<div class="container footer">
    <div class="span24">
        <div class="footerAd">
            <img src="image\r___________renleipic_01/footer.jpg" alt="我们的优势" title="我们的优势" height="52" width="950">
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
