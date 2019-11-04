<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head lang="en">
<meta charset="UTF-8">
<title></title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<link type="text/css" rel="stylesheet" href="${APP_PATH }/css/style.css" />
<link type="text/css" rel="stylesheet"
	href="${APP_PATH }/css/public.css" />
</head>

<body>
	<jsp:include page="navbar.jsp"></jsp:include>
	<div class="right">
		<div class="location">
			<strong>你现在所在的位置是:</strong> <span>用户管理页面 >> 信息查看</span>
		</div>
		<c:forEach items="${list }" var="user">
			<div class="providerView">
				<p>
					<strong>用户编号：</strong><span>${user.userCode }</span>
				</p>
				<p>
					<strong>用户名称：</strong><span>${user.userName }</span>
				</p>
				<p>
					<strong>用户性别：</strong> <span>${user.gender==1?"女":"男" } </span>
				</p>
				<p>
					<strong>出生日期：</strong><span> ${user.birthday } </span>
				</p>
				<p>
					<strong>用户电话：</strong><span>${user.phone }</span>
				</p>
				<p>
					<strong>用户地址：</strong><span>${user.address } </span>
				</p>
				<p>
					<strong>用户角色：</strong><span>${user.role.roleName}</span>
				</p>
				<div class="providerAddBtn">
					<input type="button" onclick="javascript:history.go(-1)" id="back"
						name="back" value="返回">
				</div>
			</div>
		</c:forEach>
	</div>
	</section>
	<footer class="footer"> 版权归源动力 </footer>
	<!--时间js-->
	<script type="text/javascript" src="${APP_PATH }/js/time.js"></script>
</body>

</html>