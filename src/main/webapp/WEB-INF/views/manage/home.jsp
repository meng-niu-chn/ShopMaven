<%--
  Created by IntelliJ IDEA.
  User: 10283
  Date: 2019/5/7
  Time: 21:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta http-equiv="Content-Language" content="zh-cn">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <style>
        body
        {
            SCROLLBAR-ARROW-COLOR: #ffffff;  SCROLLBAR-BASE-COLOR: #dee3f7;
        }
    </style>
</head>

<frameset rows="103,*,43" frameborder=1 border="1" framespacing="1">
    <frame src="${pageContext.request.contextPath}/jsps/top.jsp" name="topFrame" scrolling="NO" noresize>
    <frameset cols="159,*">
        <frame src="${pageContext.request.contextPath}/jsps/left.jsp" name="leftFrame" noresize scrolling="YES">
        <frame src="${pageContext.request.contextPath}/jsps/right.jsp" name="mainFrame">
    </frameset>
</frameset>
</html>
