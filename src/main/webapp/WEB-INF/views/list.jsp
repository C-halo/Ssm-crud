<%--
  Created by IntelliJ IDEA.
  User: Halo
  Date: 2021/6/1, 0001
  Time: 20:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%--    为了使用c foreach调用标签库--%>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <%--    web路径问题：
    不以/开始时相对路径：找资源以当前路径为基准，
    以/开头，是服务器的路径（http://localhost:3306）:需要加上项目名--%>
    <title>Title</title>
    <link rel="stylesheet" href="static/bootstrap-3.4.1-dist/css/bootstrap.min.css">
    <script src="static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="static/js/jquery.min.js"></script>
</head>
<body>
<%--搭建页面--%>
<div class="container">
    <%--    标题--%>
    <div class="row">
        <div class="col-lg-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--    按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary">新增</button>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>
    <%--    显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <tr>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                <c:forEach items="${pageInfo.list}" var="emps">
                    <tr>
                        <th>${emps.empId}</th>
                        <th>${emps.empName}</th>
                        <th>${emps.gender=="M"?"男":"女"}</th>
                        <th>${emps.email}</th>
                        <th>${emps.department.deptName}</th>
                        <th>
                            <button class="btn btn-primary btn-sm">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                编辑
                            </button>
                        </th>
                        <th>
                            <button class="btn btn-danger btn-sm">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                删除
                            </button>
                        </th>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
    <%--    显示分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6">
            当前第${pageInfo.pageNum}页,共有${pageInfo.pages}页，共有${pageInfo.total}条记录
        </div>
        <%--分页条信息--%>
        <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <c:if test="${pageInfo.hasPreviousPage}">
<%--                        如果有上一页再显示--%>
                        <li><a href="${APP_PATH}/emps?pn=1">首页</a></li>
                        <li>
                            <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>

                    <c:forEach items="${pageInfo.navigatepageNums}" var="page_num">
                        <%--                        是否为当前页码，显示激活状态--%>
                        <c:if test="${page_num == pageInfo.pageNum}">
                            <li class="active"><a href="#">${page_num}</a></li>
                        </c:if>
                        <c:if test="${page_num != pageInfo.pageNum}">
                            <li><a href="${APP_PATH}/emps?pn=${page_num}">${page_num}</a></li>
                        </c:if>
                    </c:forEach>
                    <c:if test="${pageInfo.hasNextPage}">
<%--                        是否有下一页--%>
                        <li>
                            <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                        <li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a></li>
                    </c:if>
                </ul>
            </nav>
        </div>
    </div>
</div>
</body>