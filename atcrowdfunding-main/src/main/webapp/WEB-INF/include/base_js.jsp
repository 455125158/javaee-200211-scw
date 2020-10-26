<%--
  Created by IntelliJ IDEA.
  User: xugang2
  Date: 2020/5/18
  Time: 9:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<script src="jquery/jquery-2.1.1.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script src="script/docs.min.js"></script>
<script src="script/back-to-top.js"></script>
<script src="layer/layer.js"></script>

<%--注销的单击事件--%>
<script type="text/javascript">
    $("#logoutA").click(function () {
        layer.confirm("您确定退出吗？", {"title":"登出提示", icon:3},function (){
            window.location = "${PATH}/admin/logout";
        })
    })

</script>
