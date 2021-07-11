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
    <script type="text/javascript" src="static/js/jquery.min.js"></script>
    <link rel="stylesheet" href="static/bootstrap-3.4.1-dist/css/bootstrap.min.css">
    <script src="static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>

</head>
<body>
<!-- 员工添加模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empsName_add_input"
                                   placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input"
                                   placeholder="empName@halo.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_add_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 员工修改模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input"
                                   placeholder="empName@halo.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">修改</button>
            </div>
        </div>
    </div>
</div>

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
            <button type="button" id="emp_add_btn" class="btn btn-primary">新增</button>
            <button type="button" id="emp_delete_btn" class="btn btn-danger">删除</button>
        </div>
    </div>
    <%--    显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>

                <%--                <c:forEach items="${pageInfo.list}" var="emps">--%>
                <%--                    <tr>--%>
                <%--                        <th>${emps.empId}</th>--%>
                <%--                        <th>${emps.empName}</th>--%>
                <%--                        <th>${emps.gender=="M"?"男":"女"}</th>--%>
                <%--                        <th>${emps.email}</th>--%>
                <%--                        <th>${emps.department.deptName}</th>--%>
                <%--                        <th>--%>
                <%--                            <button class="btn btn-primary btn-sm">--%>
                <%--                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>--%>
                <%--                                编辑--%>
                <%--                            </button>--%>
                <%--                        </th>--%>
                <%--                        <th>--%>
                <%--                            <button class="btn btn-danger btn-sm">--%>
                <%--                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>--%>
                <%--                                删除--%>
                <%--                            </button>--%>
                <%--                        </th>--%>
                <%--                    </tr>--%>
                <%--                </c:forEach>--%>
            </table>
        </div>
    </div>
    <%--    显示分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area"></div>
        <div class="col-md-6" id="page_nav_area"></div>
        <%--分页条信息--%>
        <%--        <div class="col-md-6">--%>
        <%--            <nav aria-label="Page navigation">--%>
        <%--                <ul class="pagination">--%>
        <%--                    <c:if test="${pageInfo.hasPreviousPage}">--%>
        <%--                        &lt;%&ndash;                        如果有上一页再显示&ndash;%&gt;--%>
        <%--                        <li><a href="${APP_PATH}/emps?pn=1">首页</a></li>--%>
        <%--                        <li>--%>
        <%--                            <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">--%>
        <%--                                <span aria-hidden="true">&laquo;</span>--%>
        <%--                            </a>--%>
        <%--                        </li>--%>
        <%--                    </c:if>--%>

        <%--                    <c:forEach items="${pageInfo.navigatepageNums}" var="page_num">--%>
        <%--                        &lt;%&ndash;                        是否为当前页码，显示激活状态&ndash;%&gt;--%>
        <%--                        <c:if test="${page_num == pageInfo.pageNum}">--%>
        <%--                            <li class="active"><a href="#">${page_num}</a></li>--%>
        <%--                        </c:if>--%>
        <%--                        <c:if test="${page_num != pageInfo.pageNum}">--%>
        <%--                            <li><a href="${APP_PATH}/emps?pn=${page_num}">${page_num}</a></li>--%>
        <%--                        </c:if>--%>
        <%--                    </c:forEach>--%>
        <%--                    <c:if test="${pageInfo.hasNextPage}">--%>
        <%--                        &lt;%&ndash;                        是否有下一页&ndash;%&gt;--%>
        <%--                        <li>--%>
        <%--                            <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">--%>
        <%--                                <span aria-hidden="true">&raquo;</span>--%>
        <%--                            </a>--%>
        <%--                        </li>--%>
        <%--                        <li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a></li>--%>
        <%--                    </c:if>--%>
        <%--                </ul>--%>
        <%--            </nav>--%>
        <%--        </div>--%>
    </div>
</div>
<script type="text/javascript">
    var totalpagenum, currentPage;
    //页面加载完成后，直接去发送ajax请求，要到分页数据
    $(function () {
        //默认去首页
        to_page(1);
    });

    function to_page(pn) {
        $("#check_all").prop("checked", false);
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn=" + pn,
            type: "GET",
            success: function (result) {
                //1,解析并显示员工数据
                build_emps_table(result);
                //2，解析并显示分页信息
                build_page_info(result);
                //3，解析并显示分页条数据
                build_page_nav(result);
            }
        });
    }

    // 页面加载完成发送ajax请求,拿到分页数据
    $(function () {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn=1",
            type: "GET",
            success: function (result) {
                // console.log(result);
                //1,解析并显示员工数据
                build_emps_table(result);
                //2，解析并显示分页信息
                build_page_info(result);
                //3，解析并显示分页条数据
                build_page_nav(result);
            }
        });
    });


    //建立表单
    function build_emps_table(result) {
        //清空table表格
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == 'M' ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            editBtn.attr("edit-id", item.empId)
            var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            deleteBtn.attr("del-id", item.empId)
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(deleteBtn);
            $("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(genderTd).append(emailTd).append(deptNameTd)
                .append(btnTd).appendTo("#emps_table tbody");
        });
    }

    //解析显示分页信息
    function build_page_info(result) {
        //清空分页信息
        $("#page_info_area").empty();
        $("#page_info_area").append("当前第" + result.extend.pageInfo.pageNum + "页,共有" +
            result.extend.pageInfo.pages + "页，共有" + result.extend.pageInfo.total + "条记录");
    }

    //解析显示分页条
    function build_page_nav(result) {
        totalpagenum = result.extend.pageInfo.pages
        currentPage = result.extend.pageInfo.pageNum
        //清空分页条
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        //构建元素
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.pageInfo.hasPreviousPage === false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            //为元素添加翻页事件
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
            firstPageLi.click(function () {
                to_page(1);
            });
        }
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        if (result.extend.pageInfo.hasNextPage === false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            });
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }
        ul.append(firstPageLi).append(prePageLi);

        //遍历给ul中添加页码提示
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum === item) {
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });

        ul.append(nextPageLi).append(lastPageLi);
        //把ul加入到nav
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }

    //清空表单样式及内容
    function reset_form(ele) {
        $(ele)[0].reset();
        //清空表单内容
        $(ele).find("*").removeClass("has-success has-error");
        $(ele).find(".help-block").text("");
    }

    //点击新增按钮弹出
    $("#emp_add_btn").click(function () {

        //清除表单数据（表单完整重置（表单的数据，表单的样式））
        reset_form("#empAddModal form");
        //显示员工数据
        getDepts("#empAddmodal select");
        // 弹出模态框
        $("#empAddModal").modal({
            backdrop: "static"
        });
    });

    // 获得部门信息
    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            async: false,
            success: function (result) {
                // console.log(result);
                $.each(result.extend.depts, function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo(ele)
                });
            }
        });
    }

    //校验表单数据
    function validate_add_form() {
        // 校验用户名
        // 拿到要校验的数据，使用正则表达式
        var empName = $("#empsName_add_input").val();
        //匹配中英文，数字及_
        var regname = /[\u4e00-\u9fa5_a-zA-Z0-9_]{4,12}/
        if (!regname.test(empName)) {
            // alert("用户名不合法，可以是4-12位的中文，英文，数字和_的组合")
            show_validate_msg("#empsName_add_input", "error", "用户名不合法，可以是4-12位的中文，英文，数字和_的组合");
            return false;
        } else (
            show_validate_msg("#empsName_add_input", "success", "")
        )
        // 校验邮箱信息
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            // alert("邮箱格式不正确")
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
            return false;
        } else {
            show_validate_msg("#email_add_input", "success", "");
        }
        return true;
    }

    //显示校验结果的提示信息
    function show_validate_msg(ele, status, msg) {
        //清除当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success" === status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" === status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    // 检验用户名是否可用
    $("#empsName_add_input").change(function () {
        //发送ajax请求校验用户名是否可用
        var empName = this.value;
        $.ajax({
            url: "${APP_PATH}/checkUser",
            data: "empName=" + empName,
            type: "GET",
            success: function (result) {
                if (result.code == 100) {
                    show_validate_msg("#empsName_add_input", "success", "用户名可用");
                    //添加自定义属性
                    $("#emp_save_btn").attr("ajax_user", "success");
                } else {
                    //用户名不可用时显示后台传过来的错误信息
                    show_validate_msg("#empsName_add_input", "error", result.extend.imsg);
                    $("#emp_save_btn").attr("ajax_user", "error");
                }
            }
        });
    });

    //绑定更新按钮，保存修改后的员工信息
    $("#emp_update_btn").click(function () {
        //校验邮箱信息
        var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            show_validate_msg("#email_update_input", "error", "邮箱格式不正确");
            return false;
        } else {
            show_validate_msg("#email_update_input", "success", "");
        }
        //发送ajax请求保存更新的员工数据
        $.ajax({
            url: "${APP_PATH}/emp/" + $(this).attr("edit-id"),
            type: "PUT",
            data: $("#empUpdateModal form").serialize(),
            success: function (result) {
                //关闭模态框
                $("#empUpdateModal").modal('hide');
                alert("修改成功");
                //回到本页面
                to_page(currentPage);
            }

        });
    });

    //获得员工信息
    function getEmp(id) {
        $.ajax({
            url: "${APP_PATH}/emp/" + id,
            type: "GET",
            success: function (result) {
                var empDate = result.extend.emp;
                $("#empName_update_static").text(empDate.empName);
                $("#email_update_input").val(empDate.email);
                $("#empUpdateModal input[name=gender]").val([empDate.gender]);
                $("#empUpdateModal select").val([empDate.dId]);
            }
        });
    }

    // 保存员工信息
    $("#emp_save_btn").click(function () {

        // 先对要提交给服务器的数据进行校验
        // if (!validate_add_form()) {
        //     return false;
        // }
//保存时判断用户名是否可用(用户名是否已经存在）
        if ($(this).attr("ajax_user") === "error") {
            return false;
        }
        //1,模态框中填写的表单数据提交给服务器进行保存
        //2，发送ajax请求保存员工
        $.ajax({
            url: "${APP_PATH}/emp",
            type: "POST",
            data: $("#empAddModal form").serialize(),
            success: function (result) {
                if (result.code === 100) {
                    alert("保存成功");
                    $("#empAddModal").modal('hide');
                    to_page(totalpagenum + 1);
                } else {
                    if (undefined !== result.extend.errors.email) {
                        show_validate_msg("#email_add_input", "error", result.extend.errors.email);
                        alert("邮箱错误");
                    }
                    if (undefined !== result.extend.errors.empName) {

                        show_validate_msg("#empsName_add_input", "error", result.extend.errors.empName);
                        alert("用户名错误");
                    }
                }

            }
        });
    });

    //绑定修改按钮，调出模态框
    $(document).on("click", ".edit_btn", function () {
        //查出部门信息，并显示部门列表
        getDepts("#empUpdateModal select");
        //查出员工信息，显示员工信息
        getEmp($(this).attr("edit-id"));
        //把员工的id传递给模态框的更新按钮
        $("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));
        $("#empUpdateModal").modal({
            backdrop: "static"
        });
    });

    //删除员工
    $(document).on("click", ".delete_btn", function () {
        //父元素下的第三个td的值，即是员工名称
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId = $(this).attr("del-id")
        //查出员工信息，显示员工信息
        if (confirm("确认删除【" + empName + "】员工嘛?")) {
            $.ajax({
                url: "${APP_PATH}/emp/" + empId,
                type: "DELETE",
                success: function (result) {
                    alert(result.msg);
                    //回到本页面
                    to_page(currentPage);
                }
            });
        }
    });

    //完成全选/全不选功能
    $("#check_all").click(function () {
        //注意，这里不要使用attr，attr获取checked的属性是underfined
        //prop修改和读取dom原生属性的值，attr对应自定义属性
        $(".check_item").prop("checked", $(this).prop("checked"));
    });

    //当手动将本页全部选择时，标题栏全选框应自动选定
    $(document).on("click", ".check_item", function () {
        var flag = $(".check_item:checked").length === $(".check_item").length;
        $("#check_all").prop("checked", flag);
    });

    //批量删除按钮
    $("#emp_delete_btn").click(function () {
        var empName = "";
        var del_id_str = "";
        $.each($(".check_item:checked"), function () {
            //拼装员工名称
            empName += $(this).parents("tr").find("td:eq(2)").text() + ",";
            //拼装员工id字符串
            del_id_str += $(this).parents("tr").find("td:eq(1)").text() + "-";
        });
        // 去除员工名称结尾多余-字符
        empName = empName.substring(0, empName.length - 1);
        if (confirm("确认删除【" + empName + "】吗？")) {
            //发送请求
            $.ajax({
                url: "${APP_PATH}/emp/" + del_id_str,
                type: "DELETE",
                success: function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            });
        }
    });

</script>
</body>
</html>