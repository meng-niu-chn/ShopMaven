<%--
  Created by IntelliJ IDEA.
  User: 10283
  Date: 2019/5/7
  Time: 21:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>

    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>

    <script type="text/javascript" src="../static/jquery-3.3.1.js"></script>
    <link href="../static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="../static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <link href="../static/dtree/dtree.css" rel="stylesheet">

</head>
<body>
<%--<a class="text-left" href="${APP_PATH}/usermanage" target="mainFrame">用户管理</a><br>
<a class="text-left" href="${APP_PATH}/catemanage" target="mainFrame">分类管理</a><br>
<a class="text-left" href="${APP_PATH}/productmanage" target="mainFrame">商品管理</a><br>
<a class="text-left" href="${APP_PATH}/testUpDo" target="mainFrame">测试上传</a><br>--%>
<div id="menu" class="dtree">
    <script type="text/javascript" src="../static/dtree/dtree.js"></script>
    <script type="text/javascript">
        d = new dTree('d');
        d.config.useLines = false;
        d.config.useIcons = false;
        d.add('01','-1','系统菜单');
        d.add('0101','01','用户管理','${APP_PATH}/usermanage','','mainFrame');

        d.add('0102','01','商品管理','${APP_PATH}/productmanage','','mainFrame');

        d.add('0103','01','分类管理','','','mainFrame');
        d.add('010301','0103','一级分类管理','${APP_PATH}/categorymanage','','mainFrame');
        d.add('010302','0103','二级分类管理','${APP_PATH}/categorysemanage','','mainFrame');

        d.add('0104','01','订单管理','','','mainFrame');
        d.add('010401','0104','所有订单','${APP_PATH}/ordermanage?state=-1','','mainFrame');
        d.add('010402','0104','未付款订单','${APP_PATH}/ordermanage?state=0','','mainFrame');
        d.add('010403','0104','已付款订单','${APP_PATH}/ordermanage?state=1','','mainFrame');
        d.add('010404','0104','已发货订单','${APP_PATH}/ordermanage?state=2','','mainFrame');
        d.add('010405','0104','完成的订单','${APP_PATH}/ordermanage?state=3','','mainFrame');

        document.write(d);
    </script>
</div>

</body>
</html>
