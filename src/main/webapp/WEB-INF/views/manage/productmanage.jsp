<%--
  Created by IntelliJ IDEA.
  User: 10283
  Date: 2019/5/12
  Time: 16:05
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
        var currentPid;
        var currentPname;
        var currentPrice;
        var currentImage;
        var currentPdesc;
        var currentIsHot = -1;
        var currentCsid = 0;
        var currentPage;
        var lastPage;

        function save(pid,pname,price,image,pdesc,isHot,csid,currentpage,lastpage) {
            if(currentCsid != 0){
                var oldOption = document.getElementById("option"+currentCsid);
                oldOption.removeAttribute("selected");
            }
            if(currentIsHot != -1){
                var oldOptionHot = document.getElementById("optionIsHot"+currentIsHot);
                oldOptionHot.removeAttribute("selected");
            }
            currentPid = pid;
            currentPname = pname;
            currentPrice = price;
            currentImage = image;
            currentPdesc = pdesc;
            currentIsHot = isHot;
            currentCsid = csid;
            currentPage = currentpage;
            lastPage = lastpage;
            var newOption = document.getElementById("option"+currentCsid);
            newOption.setAttribute("selected","selected");
            document.getElementById("pid").value = pid;
            document.getElementById("editPname").innerHTML = currentPname;
            document.getElementById("editPname").setAttribute("value",currentPname);
            document.getElementById("priceEdit").innerHTML = currentPrice;
            document.getElementById("priceEdit").setAttribute("value",currentPrice);
            /*document.getElementById("imageEdit").innerHTML = currentImage;
            document.getElementById("imageEdit").setAttribute("value",currentImage);*/
            document.getElementById("pdescEdit").innerHTML = currentPdesc;
            document.getElementById("pdescEdit").setAttribute("value",currentPdesc);
            document.getElementById("optionIsHot"+currentIsHot).setAttribute("selected","selected");
        }
        function edit() {
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
            /*var addNameInput = document.getElementById("addCname");
            var addName = addNameInput.value;
            var lastPage = addNameInput.getAttribute("myattribute") + 1;
            // window.location.href ="categoryse_add?cname=" + addName + "&lastPage=" + lastPage;*/
            var flag = check();
            if(flag){
                var form = document.getElementById("addForm");
                form.submit();
            }

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
            if(confirm("确认删除"+currentPname+"吗？")){
                window.location.href ="product_delete?pid="+currentPid+"&currentPage=" + currentPage;
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
        /*function checkResult(message,code,input) {
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
                /!*className =  code == 200 ? "col-sm-10 has-success" : "col-sm-10 has-error";
                addSpan.parentElement.className = className;
                addSpan.innerHTML = message;*!/

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
                /!*className =  code == 200 ? "col-sm-10 has-success" : "col-sm-10 has-error";
                editSpan.parentElement.className = className;
                editSpan.innerHTML = message;*!/

            }
        }*/
        /*function checkCategory(input) {
            /!*var csname = input.value;
            $.ajax({
                url : "categoryse_check?csname=" + csname,
                type : "GET",
                success : function(result) {
                    /!*                    alert(result.code);*!/
                    checkResult(result.extendMap.checkMessage,result.code,input);
                }
            })*!/
        }*/
        
        function check() {
            // alert(document.getElementById("addPname").value);
            // alert(document.getElementById("addPrice").value);
            if(document.getElementById("addPname").value == ""){
                var addSpan = document.getElementById("addPnameSpan");
                addSpan.innerHTML = "商品名称不能为空";
                addSpan.parentElement.className = "col-sm-10 has-error";
                return false;
            } else{
                document.getElementById("addPnameSpan").parentElement.className="col-sm-10";
                document.getElementById("addPnameSpan").innerHTML = "";
            }
            if(document.getElementById("addPrice").value == ""){
                var addSpan = document.getElementById("addPriceSpan");
                addSpan.innerHTML = "价格不能为空";
                addSpan.parentElement.className = "col-sm-10 has-error";
                return false;
            } else {
                document.getElementById("addPriceSpan").parentElement.className="col-sm-10";
                document.getElementById("addPriceSpan").innerHTML = "";
            }
            return true;
        }

        function formReset() {
            var addForm = document.getElementById("addForm");
            var editForm = document.getElementById("editForm");
            addForm.reset(addForm);
            editForm.reset(editForm);
            document.getElementById("addPnameSpan").parentElement.className="col-sm-10";
            document.getElementById("addPnameSpan").innerHTML = "";
            document.getElementById("addPriceSpan").parentElement.className="col-sm-10";
            document.getElementById("addPriceSpan").innerHTML = "";
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
                <form class="form-horizontal" id="addForm" action="product_add" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <input type="hidden" name="lastPage" value="${pageInfo.pages + 1}">
                        <label for="addPname" class="col-sm-2 control-label">Name</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="addPname" placeholder="Name" aria-describedby="addPnameSpan" name="pname">
                            <span id="addPnameSpan" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="categorySecond" class="col-sm-2 control-label">CategorySecond</label>
                        <div class="col-sm-10">
                            <select class="form-control" name="csid" id="categorySecond">
                                <c:forEach items="${cslist}" var="categorySecond">
                                    <option value="${categorySecond.csid}">${categorySecond.csname}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="addPrice" class="col-sm-2 control-label">Price</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="addPrice" placeholder="Price" aria-describedby="addPriceSpan" name="price">
                            <span id="addPriceSpan" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="image" class="col-sm-2 control-label">Image</label>
                        <div class="col-sm-10">
                            <input type="file" class="form-control" id="image" multiple="multiple" name="file">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="pdesc" class="col-sm-2 control-label">Pdesc</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="pdesc" placeholder="pdesc" myattribute="${pageInfo.pages}" name="pdesc">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="isHot" class="col-sm-2 control-label">isHot</label>
                        <div class="col-sm-10" name="isHot">
                            <select class="form-control" name="isHot" id="isHot">
                                    <option value="1">热门商品</option>
                                    <option value="0">非热门商品</option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="submit" class="btn btn-primary" id="addSaveBtn" onclick="add()">保存</button>
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
                <form class="form-horizontal" id="editForm" action="product_update" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <input type="hidden" name="currentPage" value="${pageInfo.pageNum}">
                        <input type="hidden" name="pid" id="pid">
                        <label for="addPname" class="col-sm-2 control-label">Name</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="editPname" placeholder="Name" myattribute="${pageInfo.pages}" name="pname">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="categorySecondEdit" class="col-sm-2 control-label">CategorySecond</label>
                        <div class="col-sm-10">
                            <select class="form-control" name="csid" id="categorySecondEdit">
                                <c:forEach items="${cslist}" var="categorySecond">
                                    <option value="${categorySecond.csid}" id="option${categorySecond.csid}">${categorySecond.csname}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="priceEdit" class="col-sm-2 control-label">Price</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="priceEdit" placeholder="Price" myattribute="${pageInfo.pages}" name="price">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="imageEdit" class="col-sm-2 control-label">Image</label>
                        <div class="col-sm-10">
                            <input type="file" class="form-control" id="imageEdit" multiple="multiple" name="file">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="pdescEdit" class="col-sm-2 control-label">Pdesc</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="pdescEdit" placeholder="pdesc" myattribute="${pageInfo.pages}" name="pdesc">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="isHotEdit" class="col-sm-2 control-label">isHot</label>
                        <div class="col-sm-10" name="isHot">
                            <select class="form-control" name="isHot" id="isHotEdit">
                                <option value="1" id="optionIsHot1">热门商品</option>
                                <option value="0" id="optionIsHot0">非热门商品</option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="editSaveBtn" onclick="edit()">保存</button>
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
                    <th>pname</th>
                    <th>price</th>
                    <th>image</th>
                    <th>pdesc</th>
                    <th>id_hot</th>
                    <th>pdate</th>
                    <th>csid</th>
                    <th>state</th>
                    <th>operator</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${pageInfo.list}" var="product">
                    <tr>
                        <td>${product.pid }</td>
                        <td>${product.pname}</td>
                        <td>${product.price}</td>
                        <td><img style="width: 40px;height: 40px;" src="${product.image}"></td>
                        <td>${product.pdesc}</td>
                        <td>${product.pdesc}</td>
                        <td>${product.isHot}</td>
                        <td>${product.categorySecond.csname}</td>
                        <td>${product.state}</td>
                        <td>
                            <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#editModal" onclick="formReset();save('${product.pid}','${product.pname}','${product.price}','${product.image}','${product.pdesc}',
                                    '${product.isHot}','${product.csid}','${pageInfo.pageNum}','${pageInfo.pages}')">编辑</button>
                            &nbsp;
                            <button type="button" class="btn btn-danger" onclick="save('${product.pid}','${product.pname}','${product.price}','${product.image}','${product.pdesc}',
                                    '${product.isHot}','${product.csid}','${pageInfo.pageNum}','${pageInfo.pages}'); deletec()">删除</button>
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
                                <a href="productmanage?pn=1" aria-label="Previous"> 首页</a>
                            </li>
                            <li class="disabled">
                                <a href="productmanage?pn=${pageInfo.pageNum - 1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li>
                                <a href="productmanage?pn=1" aria-label="Previous"> 首页</a>
                            </li>
                            <li>
                                <a href="productmanage?pn=${pageInfo.pageNum - 1}" aria-label="Previous">
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
                                <li><a href="productmanage?pn=${page}">${page}</a></li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <c:choose>
                        <c:when test="${pageInfo.hasNextPage == false}">
                            <li class="disabled">
                                <a href="productmanage?pn=${pageInfo.pageNum + 1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                            <li class="disabled">
                                <a href="productmanage?pn=${pageInfo.pages}" aria-label="Previous"> 末页</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li>
                                <a href="productmanage?pn=${pageInfo.pageNum + 1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                            <li>
                                <a href="productmanage?pn=${pageInfo.pages}" aria-label="Previous"> 末页</a>
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
