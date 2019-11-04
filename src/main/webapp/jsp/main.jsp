<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta charset="UTF-8">
<title></title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<link type="text/css" rel="stylesheet" href="${APP_PATH}/css/style.css">
<link type="text/css" rel="stylesheet" href="${APP_PATH}/css/public.css">
<body>
<jsp:include page="navbar.jsp"></jsp:include>
		<div class="right">
			<img class="wColck" src="images/clock.jpg" alt="">
			<div class="wFont">
				<h2 id="role"></h2>
				<p>欢迎来到美宜佳库存管理系统!</p>
			</div>
		</div>
	</section>
	<footer class="footer"> 版权归源动力 </footer>
	<!--时间js-->
	<script type="text/javascript" src="${APP_PATH}/js/time.js"></script>
	<script src="${APP_PATH }/js/jquery-2.1.0.min.js"></script>
</body>
</html>