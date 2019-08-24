<%--
  Created by IntelliJ IDEA.
  User: 10283
  Date: 2019/5/7
  Time: 22:17
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
                        <th>username</th>
                        <th>name</th>
                        <th>email</th>
                        <th>phone</th>
                        <th>address</th>
                        <th>state</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${pageInfo.list}" var="user">
                        <tr>
                            <td>${user.uid }</td>
                            <td>${user.username }</td>
                            <td>${user.name}</td>
                            <th>${user.email}</th>
                            <td>${user.phone }</td>
                            <td>${user.addr }</td>
                            <td>${user.state }</td>
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
                                    <a href="usermanage?pn=1" aria-label="Previous"> 首页</a>
                                </li>
                                <li class="disabled">
                                    <a href="usermanage?pn=${pageInfo.pageNum - 1}" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li>
                                    <a href="usermanage?pn=1" aria-label="Previous"> 首页</a>
                                </li>
                                <li>
                                    <a href="usermanage?pn=${pageInfo.pageNum - 1}" aria-label="Previous">
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
                                    <li><a href="usermanage?pn=${page}">${page}</a></li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>

                        <c:choose>
                            <c:when test="${pageInfo.hasNextPage == false}">
                                <li class="disabled">
                                    <a href="usermanage?pn=${pageInfo.pageNum + 1}" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                                <li class="disabled">
                                    <a href="usermanage?pn=${pageInfo.pages}" aria-label="Previous"> 末页</a>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li>
                                    <a href="usermanage?pn=${pageInfo.pageNum + 1}" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="usermanage?pn=${pageInfo.pages}" aria-label="Previous"> 末页</a>
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
