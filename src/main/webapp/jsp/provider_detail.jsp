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
<link type="text/css" rel="stylesheet" href="css/style.css" />
<link type="text/css" rel="stylesheet" href="css/public.css" />
</head>
<body>
	<jsp:include page="navbar.jsp"></jsp:include>
	<div class="right">
		<div class="location">
			<strong>你现在所在的位置是:</strong> <span> 供应商管理页面 >> 信息查看</span>
		</div>
		<c:forEach items="${list }" var="pro">
			<div class="providerView">
				<p>
					<strong>供应商编码：</strong><span>${pro.proCode }</span>
				</p>
				<p>
					<strong>供应商名称：</strong><span>${pro.proName }</span>
				</p>
				<p>
					<strong>联系人：</strong><span>${pro.proContact }</span>
				</p>
				<p>
					<strong>联系电话：</strong><span>${pro.proPhone }</span>
				</p>
				<p>
					<strong>传真：</strong><span>${pro.proFax }</span>
				</p>
				<p>
					<strong>描述：</strong><span>${pro.proDesc }</span>
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
