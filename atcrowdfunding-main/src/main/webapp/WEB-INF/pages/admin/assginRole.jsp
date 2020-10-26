<%--
  Created by IntelliJ IDEA.
  User: xugang2
  Date: 2020/5/22
  Time: 11:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <%@ include file="/WEB-INF/include/base_css.jsp"%>

    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="user.html">众筹平台 - 用户维护</a></div>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <%@ include file="/WEB-INF/include/admin_loginbar.jsp"%>

            <form class="navbar-form navbar-right">
                <input type="text" class="form-control" placeholder="Search...">
            </form>
        </div>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <%@include file="/WEB-INF/include/admin_menubar.jsp"%>

        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <ol class="breadcrumb">
                <li><a href="#">首页</a></li>
                <li><a href="#">数据列表</a></li>
                <li class="active">分配角色</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-body">
                    <form role="form" class="form-inline">
                        <div class="form-group">
                            <label for="exampleInputPassword1">未分配角色列表</label><br>
                            <select id="unAssignedRoleSel" class="form-control" multiple size="10" style="width:300px;overflow-y:auto;">
                                <c:forEach items="${unAssginedRoles}" var="role">
                                    <option value="${role.id}">${role.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <ul>
                                <%--  分配角色按钮 --%>
                                <li id="assginRoleBtn" class="btn btn-default glyphicon glyphicon-chevron-right"></li>
                                <br>
                                <%-- 删除角色按钮--%>
                                <li id="unAssginRoleBtn" class="btn btn-default glyphicon glyphicon-chevron-left" style="margin-top:20px;"></li>
                            </ul>
                        </div>
                        <div class="form-group" style="margin-left:40px;">
                            <label for="exampleInputPassword1">已分配角色列表</label><br>
                            <select id="assignedRoleSel" class="form-control" multiple size="10" style="width:300px;overflow-y:auto;">
                                <c:forEach items="${assginedRoles}" var="role">
                                    <option value="${role.id}">${role.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="myModalLabel">帮助</h4>
            </div>
            <div class="modal-body">
                <div class="bs-callout bs-callout-info">
                    <h4>测试标题1</h4>
                    <p>测试内容1，测试内容1，测试内容1，测试内容1，测试内容1，测试内容1</p>
                </div>
                <div class="bs-callout bs-callout-info">
                    <h4>测试标题2</h4>
                    <p>测试内容2，测试内容2，测试内容2，测试内容2，测试内容2，测试内容2</p>
                </div>
            </div>
            <!--
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              <button type="button" class="btn btn-primary">Save changes</button>
            </div>
            -->
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/include/base_js.jsp"%>
<script type="text/javascript">
    //==========================取消分配角色的按钮的单击事件
    $("#unAssginRoleBtn").click(function () {
        //1、获取被选中的已分配的角色option选项的角色id
        if($("#assignedRoleSel :selected").length==0)return;
        var roleIds = new Array();
        $("#assignedRoleSel :selected").each(function () {
            roleIds.push(this.value);
        });
        var adminId = "${param.id}";
        //2、提交异步请求删除该管理员已分配的角色
        //在js中  json对象和  js对象 一样的
        //随着技术发展，多平台之间传输数据(纯文本 java/html/txt/xml)时之前的结构[自定义格式文本、xml(冗余)]
        //js的对象写法又具有自我描述性，又比较简洁，逐渐各个平台都是用js的对象表示方式描述数据互相传递
        //并且各语言都内置了解析json字符串转为  json对象的api
        //其他平台统一json格式时要求：json对象的属性名必须使用双引号引起
        $.ajax({
            "type":"post",
            data:{"adminId":adminId , "roleIds":roleIds.join()},
            url:"${PATH}/admin/unAssignedRoleToAdmin",
            success:function (data) {
                if(data=="ok"){
                    //3、通过dom操作，在删除已分配角色成功后将选中的已分配的option移到未分配的列表中
                    $("#assignedRoleSel :selected").appendTo("#unAssignedRoleSel");
                    layer.msg("取消已分配角色成功");
                }
            }
        });


    });



    //==========================分配角色按钮的单击事件
    $("#assginRoleBtn").click(function () {
        var roleIds = new Array();
        if($("#unAssignedRoleSel :selected").length==0)return;
        //1、获取被选中的未分配的option选项 对应的角色id
        $("#unAssignedRoleSel :selected").each(function () {
            //this代表正在遍历的被选中的option
            var roleId = this.value;
            roleIds.push(roleId);
        });
        //获取要分配角色的管理员id
        var adminId = "${param.id}";
        //2、提交分配角色的异步请求
        $.ajax({
            type:"post",
            data:{roleIds:roleIds.join(),adminId:adminId},
            url:"${PATH}/admin/assginRoleToAdmin",
            success:function(result){
                if(result=="ok"){
                    //3、后台添加成功并相应后，通过dom操作将被选中的未分配的option选项 dom操作移动到已分配的角色列表中
                    $("#unAssignedRoleSel :selected").appendTo("#assignedRoleSel");//从页面中查找的标签移动时相当剪切
                    layer.msg("分配角色成功");
                }
            }
        });


    });









    $(function () {
        $(".list-group-item").click(function(){
            if ( $(this).find("ul") ) {
                $(this).toggleClass("tree-closed");
                if ( $(this).hasClass("tree-closed") ) {
                    $("ul", this).hide("fast");
                } else {
                    $("ul", this).show("fast");
                }
            }
        });
    });


    //当打开用户维护的相关页面时，设置用户维护所在的父菜单的子菜单列表显示
    $("a:contains('用户维护')").parents("ul:hidden").show();
    //设置当前模块超链接高亮显示
    $(".tree a:contains('用户维护')").css("color" , "red");
</script>
</body>
</html>

