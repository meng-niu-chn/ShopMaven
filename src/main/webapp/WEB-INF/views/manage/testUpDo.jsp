<%--
  Created by IntelliJ IDEA.
  User: 10283
  Date: 2019/5/12
  Time: 14:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
nihao
    <form action="${pageContext.request.contextPath }/upload"
          method="post" enctype="multipart/form-data">
        选择文件:<input type="file" name="file" width="120px"> <input
            type="submit" value="上传">
    </form>
    <hr>
    <form action="${pageContext.request.contextPath }/down"
          method="get">
        <input type="submit" value="下载">
    </form>
</body>
</html>
