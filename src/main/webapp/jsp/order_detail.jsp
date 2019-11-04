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
			<strong>你现在所在的位置是:</strong> <span>进货单页面 >> 信息查看</span>
		</div>
		<c:forEach items="${list }" var="bill">
			<div class="providerView">
				<p>
					<strong>订单编号：</strong><span>${bill.billCode }</span>
				</p>
				<p>
					<strong>商品名称：</strong><span>${bill.productName }</span>
				</p>
				<p>
					<strong>商品图片：</strong><img src="images/buy.png"
						style="width: 40px; height: 40px; vertical-align: bottom;" />
				</p>
				<p>
					<strong>商品单位：</strong><span>${bill.productUnit }</span>
				</p>
				<p>
					<strong>商品数量：</strong><span>${bill.productCount }</span>
				</p>
				<p>
					<strong>总金额：</strong><span>${bill.totalPrice }</span>
				</p>
				<p>
					<strong>供应商：</strong><span>${bill.provider.proName }</span>
				</p>
				<p>
					<strong>是否付款：</strong> <span>${bill.isPayment==1?"未付款":"已付款" }</span>
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
