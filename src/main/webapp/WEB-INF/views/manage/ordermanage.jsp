<%--
  Created by IntelliJ IDEA.
  User: 10283
  Date: 2019/5/22
  Time: 15:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>UserManage</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <script type="text/javascript" src="${APP_PATH }/static/jquery-3.3.1.js"></script>
    <link
            href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
            rel="stylesheet">
    <script type="text/javascript"
            src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
    <!-- 标题 -->
    <div class="row">
        <div class="col-md-12">
            <h1>UserManage</h1>
        </div>
    </div>
    <!-- 表格 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="stus_table">
                <thead>
                <tr>
                    <th>#</th>
                    <th>total</th>
                    <th>receiveinfo</th>
                    <th>phonum</th>
                    <th>order_time</th>
                    <th>accepter</th>
                    <th>state</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${pageInfo.list}" var="order">
                    <tr>
                        <td>${order.oid }</td>
                        <td>${order.total }</td>
                        <td>${order.receiveinfo}</td>
                        <th>${order.phonum}</th>
                        <td>${order.orderTime }</td>
                        <td>${order.accepter }</td>
                        <td>
                            <c:choose>
                                <c:when test="${order.state == 0}">
                                    未付款
                                </c:when>
                                <c:when test="${order.state == 1}">
                                    已付款。
                                    <a href="${ APP_PATH }/updateOrderManage?oid=${order.oid}&state=${state}&pn=${pageInfo.pageNum}">去发货</a>
                                </c:when>
                                <c:when test="${order.state == 2}">
                                    等待确认收货
                                </c:when>
                                <c:otherwise>
                                    订单完成
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>

            </table>
        </div>
    </div>
    <!-- 分页 -->
    <div class="row">
        <!-- 分页文字信息 -->
        <div class="col-md-6" id="page_info">
            当前 ${pageInfo.pageNum} 页，
            总 ${pageInfo.pages} 页，
            总 ${pageInfo.total} 条记录
        </div>
        <!-- 分页条 -->

        <div class="col-md-6" id="page_nav">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <c:choose>
                        <c:when test="${pageInfo.hasPreviousPage == false}">
                            <li class="disabled">
                                <a href="ordermanage?state=${state}&pn=1" aria-label="Previous"> 首页</a>
                            </li>
                            <li class="disabled">
                                <a href="ordermanage?state=${state}&pn=${pageInfo.pageNum - 1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li>
                                <a href="ordermanage?state=${state}&pn=1" aria-label="Previous"> 首页</a>
                            </li>
                            <li>
                                <a href="ordermanage?state=${state}&pn=${pageInfo.pageNum - 1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>

                    <c:forEach items="${pageInfo.navigatepageNums}" var="page">
                        <c:choose>
                            <c:when test="${page == pageInfo.pageNum}">
                                <li class="active"><span>${page}</span></li>
                            </c:when>
                            <c:otherwise>
                                <li><a href="ordermanage?state=${state}&pn=${page}">${page}</a></li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <c:choose>
                        <c:when test="${pageInfo.hasNextPage == false}">
                            <li class="disabled">
                                <a href="ordermanage?state=${state}&pn=${pageInfo.pageNum + 1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                            <li class="disabled">
                                <a href="ordermanage?state=${state}&pn=${pageInfo.pages}" aria-label="Previous"> 末页</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li>
                                <a href="ordermanage?state=${state}&pn=${pageInfo.pageNum + 1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                            <li>
                                <a href="ordermanage?state=${state}&pn=${pageInfo.pages}" aria-label="Previous"> 末页</a>
                            </li>
                        </c:otherwise>
                    </c:choose>

                </ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>
