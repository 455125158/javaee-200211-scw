<%--
  Created by IntelliJ IDEA.
  User: xugang2
  Date: 2020/5/18
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="tree">
    <ul style="padding-left:0px;" class="list-group">
        <%--  获取存在域中的菜单集合遍历显示 --%>
        <c:choose>
            <c:when test="${empty pmenus}">
                <%--获取菜单失败--%>
                <h3>获取菜单失败</h3>
            </c:when>
            <c:otherwise>
                <c:forEach items="${pmenus}" var="pmenu">
                    <c:choose>
                        <c:when test="${empty pmenu.children}">
                            <%--父菜单没有子菜单--%>
                            <li class="list-group-item tree-closed" >
                                <a href="${PATH}/${pmenu.url}"><i class="${pmenu.icon}"></i> ${pmenu.name}</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <%--有子菜单--%>
                            <li class="list-group-item tree-closed">
                                <span><i class="${pmenu.icon}"></i> ${pmenu.name} <span class="badge" style="float:right">${pmenu.children.size()}</span></span>
                                <ul style="margin-top:10px;display:none;">
                                        <%-- 遍历有子菜单的父菜单的子菜单集合 --%>
                                    <c:forEach items="${pmenu.children}" var="menu">
                                        <li style="height:30px;">
                                            <a href="${PATH}/${menu.url}"><i class="${menu.icon}"></i> ${menu.name}</a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </li>

                        </c:otherwise>

                    </c:choose>
                </c:forEach>
            </c:otherwise>
        </c:choose>


    </ul>
</div>

