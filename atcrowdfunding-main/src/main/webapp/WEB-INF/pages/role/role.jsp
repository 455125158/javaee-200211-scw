<%--
  Created by IntelliJ IDEA.
  User: xugang2
  Date: 2020/5/19
  Time: 16:19
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
        table tbody tr:nth-child(odd){background:#F4F4F4;}
        table tbody td:nth-child(even){color:#C00;}
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 角色维护</a></div>
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
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <form class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input id="conditionInp" class="form-control has-success" type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button id="queryRoleBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button id="batchDelRoleBtn" type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button id="showAddModalBtn" type="button" class="btn btn-primary" style="float:right;"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr >
                                <th width="30">#</th>
                                <th width="30"><input type="checkbox"></th>
                                <th>名称</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%-- 角色列表 --%>


                            </tbody>
                            <tfoot>
                            <tr >
                                <td colspan="6" align="center">
                                    <ul class="pagination">

                                    </ul>
                                </td>
                            </tr>

                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/include/base_js.jsp"%>

<%-- 新增角色的modal  模态框：默认不会显示 --%>
<div class="modal fade" id="addRoleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="exampleModalLabel">新增角色</h4>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="recipient-name" class="control-label">角色名称:</label>
                        <input name="name" type="text" class="form-control" id="recipient-name">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button id="addRoleBtn" type="button" class="btn btn-primary">提交</button>
            </div>
        </div>
    </div>
</div>


<%--更新角色的框--%>
<div class="modal fade" id="updateRoleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >更新角色</h4>
            </div>
            <div class="modal-body">
                <form>
                    <input type="hidden" name="id" />
                    <div class="form-group">
                        <label for="recipient-name" class="control-label">角色名称:</label>
                        <input name="name" type="text" class="form-control" id="name">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button id="updateRoleBtn" type="button" class="btn btn-primary">提交</button>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
    //声明接受总页码的全局变量
    var pages;
    var page;

    // 修改角色按钮单击事件
    $("tbody").delegate(".showUpdateRoleModalBtn", "click", function (){
        var roleId = this.id;
        $.get("${PATH}/role/getRole", {id:roleId}, function (role){
            $("#updateRoleModal input[name='id']").val(role.id);
            $("#updateRoleModal input[name='name']").val(role.name);

            $("#updateRoleModal").modal("toggle");
        });
    });
    // 修改角色提示框 确认按钮 单击事件
    $("#updateRoleModal #updateRoleBtn").click(function () {
        $.ajax({
            "type":"post",
            "data": $("#updateRoleModal form").serialize(),
            "url":"${PATH}/role/updateRole",
            success:function (data) {
                if(data=="ok"){
                    //角色更新成功
                    $("#updateRoleModal").modal("hide");
                    //刷新当前页面
                    initRoleTable(page);
                }
            }
        });
    });



    //=============================角色批量删除：如果需要直接查找异步生成标签，需要动态委派
    //1、给全选框绑定单击事件
    $("thead :checkbox").click(function () {
        //查找子复选框，可以直接查找
        $("tbody :checkbox").prop("checked",this.checked);
    });
    //2、给所有的子复选框绑定单击事件[动态委派]
    $("tbody").delegate(":checkbox","click" , function () {
        var totalCount = $("tbody :checkbox").length;
        var checkedCount = $("tbody :checkbox:checked").length;
        $("thead :checkbox").prop("checked",totalCount==checkedCount);
    })
    //2、给批量删除按钮绑定单击事件
    $("#batchDelRoleBtn").click(function () {
        //在子复选框中将角色的id绑定到标签中
        //<input id="'+ this.id +'" type="checkbox"></td>
        //获取被选中的子复选框的角色的id集合
        var roleIdsArr = new Array();
        $("tbody :checkbox:checked").each(function () {
            var roleId = this.id;//要删除的角色id
            roleIdsArr.push(roleId);
        });
        //提交批量删除的请求:删除role时后台需要批量删除的角色id的集合
        //ids=1,2,3
        var roleIdStrs = roleIdsArr.join();
        $.ajax({
            type:"get",
            data:{ids:roleIdStrs},
            url:"${PATH}/role/batchDelRole",
            success:function (data) {
                if(data=="ok"){
                    //提示
                    layer.msg("批量删除成功");
                    //刷新当前页面
                    initRoleTable(page);
                }
            }
        });
    });

    //======================角色新增的代码
    //点击新增按钮弹出模态框的单击事件
    $("#showAddModalBtn").click(function () {
        $('#addRoleModal').modal('toggle');
    });
    //给模态框提交按钮绑定单击事件：点击时收集角色数据异步提交给后台保存，响应成功关闭模态框，跳转到最后一页显示添加的结果
    $("#addRoleModal #addRoleBtn").click(function () {
        $.ajax({
            type:"post",
            data: $("#addRoleModal form").serialize(),
            url:"${PATH}/role/addRole",
            success:function (data) {
                //如果后端增删改成功，相应ok字符串代表成功
                if(data=="ok"){
                    //关闭模态框
                    $('#addRoleModal').modal('toggle');
                    //跳转到最后一页
                    //使用总页码
                    initRoleTable(pages+1);
                }
            }
        });
    });

    //=======================================================================以下是角色异步查询解析显示的代码
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

    $("tbody .btn-success").click(function(){
        window.location.href = "assignPermission.html";
    });
    //当打开用户维护的相关页面时，设置用户维护所在的父菜单的子菜单列表显示
    $("a:contains('角色维护')").parents("ul:hidden").show();
    //设置当前模块超链接高亮显示
    $(".tree a:contains('角色维护')").css("color" , "red");

    //当前页面已经解析完成，页面中暂时还没有角色列表的数据，默认需要查询第一页数据显示
    //通过ajax请求第一页数据显示
    initRoleTable(1);
    //在指定区域监控，当有标签生成时检查如果是tfoot中的a标签则绑定事件
    //delegate动态委派方法： 参数1：要动态绑定事件的标签的选择器字符串，参数2：事件类型 ，参数3：事件处理函数
    $("tfoot ul").delegate(".navA","click",function () {
        //根据被点击的a标签异步查询a对应的页码数据并显示到页面中
        //this代表被点击的页码的超链接
        var pageNum = $(this).attr("pageNum");
        //alert(pageNum);
        //点击分页导航栏时，如果有条件，需要按照条件查询分页数据
        //无论收集条件input有没有输入内容，查询分页数据时都获取条件进行带条件的分页查询
        var condition = $("#conditionInp").val();
        initRoleTable(pageNum,condition);
    });
    //将异步请求分页角色集合并解析的代码块提取成函数
    function initRoleTable(pageNum , condition){
        //每次加载分页的角色列表时，需要将之前的分页数据清除
        $("tbody").empty();//掏空
        $("tfoot ul").empty();
        $.ajax({
            type:"get",
            url: "${PATH}/role/getRoles",
            data:{"pageNum":pageNum,"condition":condition},
            success:function (pageInfo) {
                //pageInfo中包含总页码和当前页码
                page = pageInfo.pageNum;
                pages = pageInfo.pages;
                //服务器响应成功后的回调函数
                layer.msg("请求role列表成功...");
                console.log(pageInfo);
                //dom解析将pageINfo的数据遍历显示到表格中
                //1、遍历pageInfo.list ，一条记录对应一行显示到table的tbody内[ 一个集合对应表格，一个对象对应一行，对象一个属性使用一个单元格  ]
                initRoleList(pageInfo);
                //2、生成分页导航栏   ，每个页面都生成一个li标签  设置到tfoot的ul中
                initRoleNav(pageInfo);
                //3、给分页导航栏的a标签绑定单击事件
                //页面加载完成后立即执行 给分页导航栏绑定单击事件，点击时跳转到超链接对应的页码
                /*$("tfoot ul .navA").click(function () {
                    alert("hehe...");
                });*/
            }
        });
    }

    //将解析生成分页导航栏的代码提权到函数中
    function initRoleNav(pageInfo){
        //上一页
        //判断，如果有上一页可以点击，如果没有上一页 禁用
        if(pageInfo.isFirstPage){
            //当前页是第一页，禁用
            $('<li class="disabled"><a href="javascript:void(0);">上一页</a></li>').appendTo("tfoot ul.pagination");
        }else{
            //当前页不是第一页，可以用
            $('<li><a pageNum="'+(pageInfo.pageNum-1)+'" class="navA" href="javascript:void(0);">上一页</a></li>').appendTo("tfoot ul.pagination");
        }
        //中间页码：当前页高亮显示
        $.each(pageInfo.navigatepageNums , function(){
            // this  代表正在遍历的页码
            //判断正在遍历的页码是否为当前页，当前页高亮，否则正常
            if(this==pageInfo.pageNum){
                $('<li class="active"><a href="javascript:void(0);">'+this+' <span class="sr-only">(current)</span></a></li>').appendTo("tfoot ul.pagination");
            }else {
                $('<li><a pageNum="'+this+'" class="navA" href="javascript:void(0);">'+this+'</a></li>').appendTo("tfoot ul.pagination");
            }
        });
        //下一页
        if(pageInfo.isLastPage){
            //当前页是最后一页，禁用
            $('<li class="disabled"><a href="javascript:void(0);">下一页</a></li>').appendTo("tfoot ul.pagination");
        }else{
            //当前页不是最后一页，可以用
            $('<li><a pageNum="'+(pageInfo.pageNum+1)+'" class="navA" href="javascript:void(0);">下一页</a></li>').appendTo("tfoot ul.pagination");
        }
    }


    //将解析pageInfo.list生成表格数据的代码抽取成函数
    function initRoleList(pageInfo){
        //自动遍历list集合，每遍历一个元素都会调用一次funcion函数
        $.each(pageInfo.list,function (i) {//i代表元素索引 从0开始计算
            //this代表正在调用方法的角色的json对象  this.name获取角色的name值
            $('<tr>\n' +
                '<td>'+(++i)+'</td>\n' +
                '<td><input id="'+ this.id +'" type="checkbox"></td>\n' +
                '<td>'+ this.name +'</td>\n' +
                '<td>\n' +
                '<button type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>\n' +
                '<button id="'+this.id+'" type="button" class="btn btn-primary btn-xs showUpdateRoleModalBtn"><i class=" glyphicon glyphicon-pencil"></i></button>\n' +
                '<button id="'+this.id+'" type="button" class="btn btn-danger btn-xs delRoleBtn"><i class=" glyphicon glyphicon-remove"></i></button>\n' +
                '</td>\n' +
                '</tr>').appendTo("tbody");

        })
        //================删除单击事件
        //在role集合遍历显示完成之后绑定单击事件
        $("tbody .delRoleBtn").click(function () {
            var roleId = this.id;//获取删除按钮所在行的角色id
            //发起异步请求交给后台删除
            $.get("${PATH}/role/delRole" , {id:roleId} , function (data) {
                if(data=="ok"){
                    //删除成功
                    layer.msg("删除成功");
                    //刷新当前页面
                    initRoleTable(page);
                }
            });
        });
    }

    //给带条件查询的按钮绑定单击事件
    $("#queryRoleBtn").click(function () {
        //1、条件
        var condition = $("#conditionInp").val();
        //2、页码
        var pageNum = 1;
        initRoleTable(pageNum,condition);
    });


</script>
</body>
</html>

