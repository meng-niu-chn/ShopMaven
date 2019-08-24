<%--
  Created by IntelliJ IDEA.
  User: 10283
  Date: 2019/5/11
  Time: 14:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>CategoryManage</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <script type="text/javascript" src="${APP_PATH }/static/jquery-3.3.1.js"></script>
    <link
            href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
            rel="stylesheet">
    <script type="text/javascript"
            src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        var currentCsid;
        var currentCsname;
        var currentCid = 0;
        var currentPage = 1;

        function save(csid,csname,cid,pn) {
            if(currentCid != 0){
                var oldOption = document.getElementById("option"+currentCid);
                oldOption.removeAttribute("selected");
            }
            currentCsid = csid;
            currentCsname = csname;
            currentCid = cid;
            currentPage = pn;
            var newOption = document.getElementById("option"+currentCid);
            newOption.setAttribute("selected","selected");
            document.getElementById("newCname").setAttribute("placeholder",currentCsname);
            document.getElementById("newCname").setAttribute("value",currentCsname);
        }
        /*function toPage(pn) {
            window.location.href = "categorymanage?pn="+pn;
        }*/
        function edit() {
            document.getElementById("csidInput").setAttribute("value",currentCsid);
            document.getElementById("editForm").submit();
            /*$.ajax({
                url:"category_update?cid=" + currentCid + "&cname=" + newName,
                type:"GET",
                success:function(result){
                    alert(result);
                    toPage(currentPage);
                }
            });*/
        }
        function add(){
            var addNameInput = document.getElementById("addCname");
            var addName = addNameInput.value;
            var lastPage = addNameInput.getAttribute("myattribute") + 1;
            // window.location.href ="categoryse_add?cname=" + addName + "&lastPage=" + lastPage;
            var form = document.getElementById("addForm");
            form.submit();
            /* $.ajax({
                 url:"category_add?cname=" + addName,
                 type:"GET",
                 success:function(result){
                     alert(result);
                     toPage(last+1);
                 }
             });*/
        }
        function deletec() {
            /*alert(cid);*/
            if(confirm("确认删除"+currentCsname+"吗？")){
                window.location.href ="categoryse_delete?csid="+currentCsid+"&currentPage=" + currentPage;
                /*$.ajax({
                    url:"category_delete?cid=" + currentCid,
                    type:"GET",
                    success:function(result){
                        alert(result);
                        toPage(currentPage);
                    }
                });*/
            }
        }
        function checkResult(message,code,input) {
            if(input.id == "addCname"){
                var addSpan = document.getElementById("addSpan");
                var addSaveBtn = document.getElementById("addSaveBtn");
                if(code == 200){
                    addSpan.parentElement.className = "col-sm-10 has-success";
                    addSaveBtn.removeAttribute("disabled");
                }else{
                    addSpan.parentElement.className = "col-sm-10 has-error";
                    addSaveBtn.setAttribute("disabled","disabled");
                }
                addSpan.innerHTML = message;
                /*className =  code == 200 ? "col-sm-10 has-success" : "col-sm-10 has-error";
                addSpan.parentElement.className = className;
                addSpan.innerHTML = message;*/

            } else {
                var editSpan = document.getElementById("editSpan");
                var editSaveBtn = document.getElementById("editSaveBtn");
                if(code == 200){
                    editSpan.parentElement.className = "col-sm-10 has-success";
                    editSaveBtn.removeAttribute("disabled");
                }else{
                    editSpan.parentElement.className = "col-sm-10 has-error";
                    editSaveBtn.setAttribute("disabled","disabled");
                }
                editSpan.innerHTML = message;
                /*className =  code == 200 ? "col-sm-10 has-success" : "col-sm-10 has-error";
                editSpan.parentElement.className = className;
                editSpan.innerHTML = message;*/

            }
        }
        function checkCategory(input) {
            var csname = input.value;
            $.ajax({
                url : "categoryse_check?csname=" + csname,
                type : "GET",
                success : function(result) {
/*                    alert(result.code);*/
                    checkResult(result.extendMap.checkMessage,result.code,input);
                }
            })
        }

        function formReset() {
            var addForm = document.getElementById("addForm");
            var editForm = document.getElementById("editForm");
            addForm.reset(addForm);
            editForm.reset(editForm);
            document.getElementById("addSpan").parentElement.className="col-sm-10";
            document.getElementById("editSpan").parentElement.className = "col-sm-10";
            document.getElementById("addSpan").innerHTML = "";
            document.getElementById("editSpan").innerHTML = "";
        }

    </script>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>

<body>
<div id="alertDiv" myattribute="${message}">

</div>
<c:if test="${message != null}">
    <script type="text/javascript">
        alertDiv = document.getElementById("alertDiv");
        message = alertDiv.getAttribute("myattribute");
        alert(message);
    </script>
</c:if>

<!-- addModal -->
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" >
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="addModalLabel">Modal title</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="addForm" action="categoryse_add" method="post">
                    <div class="form-group">
                        <label for="cid" class="col-sm-2 control-label">一级菜单</label>
                        <div class="col-sm-10">
                            <input type="hidden" name="lastPage" value="${pageInfo.pages + 1}">
                            <select class="form-control" name="cid" id="cid">
                                <c:forEach items="${clist}" var="category">
                                    <option value="${category.cid}">${category.cname}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <label for="addCname" class="col-sm-2 control-label">Name</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="addCname" placeholder="Name" myattribute="${pageInfo.pages}" aria-describedby="addSpan" onchange="checkCategory(this)" name="csname">
                            <span id="addSpan" class="help-block"></span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="addSaveBtn" onclick="add()" disabled="disabled">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- editModal -->
<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="editForm" action="categoryse_update" method="post">
                    <div class="form-group">
                        <label for="cName" class="col-sm-2 control-label">oldCname</label>
                        <div class="col-sm-10">
                            <%--<input type="email" class="form-control" id="inputEmail3" placeholder="Email">--%>
                            <%--<input id="oldCname" class="form-control" type="text" placeholder="" readonly>--%>
                                <input type="hidden" name="currentPage" value="${pageInfo.pageNum}">
                                <input type="hidden" name="csid" id="csidInput">
                                <select class="form-control" id="cName" name="cid" onchange="javascript:{document.getElementById('editSaveBtn').removeAttribute('disabled')}">
                                    <c:forEach items="${clist}" var="category">
                                        <option value="${category.cid}" id="option${category.cid}">${category.cname}</option>
                                    </c:forEach>
                                </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="newCname" class="col-sm-2 control-label">newName</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="newCname" aria-describedby="editSpan" name="csname" onblur="checkCategory(this)">
                            <span id="editSpan" class="help-block"></span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="editSaveBtn" onclick="edit()" disabled="disabled">保存</button>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <!-- 标题 -->
    <div class="row">
        <div class="col-md-12">
            <h1>CategoryManage</h1>
        </div>
        <div class="col-md-9 text-right">
            <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#addModal" onclick="formReset()">
                添加
            </button>
        </div>
    </div>
    <!-- 表格 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="stus_table">
                <thead>
                <tr>
                    <th>#</th>
                    <th>csname</th>
                    <th>cname</th>
                    <th>operate</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${pageInfo.list}" var="categorySecond">
                    <tr>
                        <td>${categorySecond.csid }</td>
                        <td>${categorySecond.csname}</td>
                        <td>${categorySecond.category.cname}</td>
                        <td>
                            <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#editModal" onclick="formReset();save('${categorySecond.csid}','${categorySecond.csname}','${categorySecond.category.cid}','${pageInfo.pageNum}')">编辑</button>
                            &nbsp;
                            <button type="button" class="btn btn-danger" onclick="save('${categorySecond.csid}','${categorySecond.csname}','${categorySecond.category.cid}','${pageInfo.pageNum}'); deletec()">删除</button>
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
                                <a href="categorysemanage?pn=1" aria-label="Previous"> 首页</a>
                            </li>
                            <li class="disabled">
                                <a href="categorysemanage?pn=${pageInfo.pageNum - 1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li>
                                <a href="categorysemanage?pn=1" aria-label="Previous"> 首页</a>
                            </li>
                            <li>
                                <a href="categorysemanage?pn=${pageInfo.pageNum - 1}" aria-label="Previous">
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
                                <li><a href="categorysemanage?pn=${page}">${page}</a></li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <c:choose>
                        <c:when test="${pageInfo.hasNextPage == false}">
                            <li class="disabled">
                                <a href="categorysemanage?pn=${pageInfo.pageNum + 1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                            <li class="disabled">
                                <a href="categorysemanage?pn=${pageInfo.pages}" aria-label="Previous"> 末页</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li>
                                <a href="categorysemanage?pn=${pageInfo.pageNum + 1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                            <li>
                                <a href="categorysemanage?pn=${pageInfo.pages}" aria-label="Previous"> 末页</a>
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
