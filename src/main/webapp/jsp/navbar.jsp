<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
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
	<!--头部-->
	<header class="publicHeader">
		<h1>美宜佳库存管理系统</h1>
		<div class="publicHeaderR">
			<p>
				<span>下午好！</span><span style="color: #fff21b" id="userName"></span>
				, 欢迎你！
			</p>
			<a href="${APP_PATH }/deleteSession">退出</a>
		</div>
	</header>
	<!--时间-->
	<section class="publicTime">
		<span id="time">2018年08月13日&nbsp;18:48:55&nbsp;星期一</span> <a href="#">温馨提示：为了能正常浏览，请使用高版本浏览器！（IE10+）</a>
	</section>
	<!--主体内容-->
	<section class="publicMian">
		<div class="left">
			<h2 class="leftH2">
				<span class="span1"></span>功能列表 <span></span>
			</h2>
			<nav>
				<ul class="list">
					<li><a href="${APP_PATH }/orderListAll" name="mainframe">进货单管理</a></li>
					<li><a href="${APP_PATH }/providerListAll">供应商管理</a></li>
					<li><a href="${APP_PATH }/jsp/user_list.jsp">用户管理</a></li>
					<li><a href="${APP_PATH }/jsp/pwdmodify.jsp">密码修改</a></li>
					<li><a href="${APP_PATH}/">退出系统</a></li>
				</ul>
			</nav>
		</div>
</body>
<script src="${APP_PATH }/js/jquery-2.1.0.min.js"></script>
<script type="text/javascript">
	$(function() {
		$.ajax({
			url : "${APP_PATH}/userById",
			type : "GET",
			success : function(result) {
				//console.log(result);
				$.each(result.extend, function() {
					$("#userName").append(this.userName);
					$("#role").append(this.role.roleName);
				});
			}
		});
	});
</script>
</html>