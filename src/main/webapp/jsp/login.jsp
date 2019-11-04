<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta charset="UTF-8">
<title>系统登录 -</title>
<%
	session.setAttribute("APP_PATH", request.getContextPath());
%>
<link type="text/css" rel="stylesheet" href="${APP_PATH}/css/style.css">
</head>
<body class="login_bg">
	<section class="loginBox">
		<header class="loginHeader">
			<h1>美宜佳库存管理系统</h1>
		</header>
		<section class="${APP_PATH}/loginCont">
			<small style="color: red;" id="info">${loginInfo}</small>
			<form class="loginForm" action="Userlogin" method="POST" id="login">
				<div class="info"></div>
				<div class="inputbox">
					<label for="user">用户名：</label> <input type="text"
						class="input-text" name="userCode" placeholder="请输入用户名"
						id="userCode">
				</div>
				<div class="inputbox">
					<label for="mima">密码：</label> <input type="password"
						name="userPassword" placeholder="请输入密码" id="userPassword">
				</div>
				<div class="inputbox">
					<label for="mima">验证码：</label> <input type="text"
						style="width: 30%;" name="code" placeholder="请输入验证码"> <img
						src="#" style="width: 90px; height: 37px; vertical-align: bottom;" />
				</div>
				<div class="subBtn">
					<input type="submit" value="登录"> <input type="reset"
						value="重置">
				</div>
			</form>
		</section>
	</section>
</body>
<script src="${APP_PATH}/js/jquery-2.1.0.min.js"></script>
</html>