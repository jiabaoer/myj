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
			<strong>你现在所在的位置是:</strong> <span>订单管理页面 >>进货单添加页面</span>
		</div>
		<c:forEach items="${list }" var="bill">
			<div class="providerAdd">
				<form id="billForm" name="billForm" method="post" action=""
					enctype="multipart/form-data">
					<input type="hidden" value="${bill.bId }" name="bId" />
					<!--div的class 为error是验证错误，ok是验证成功-->
					<div class="">
						<label for="billCode">订单编码：</label> <input type="text"
							name="billCode" id="billCode" value="${bill.billCode }"
							readonly="readonly">
					</div>
					<div>
						<label for="productName">商品名称：</label> <input type="text"
							name="productName" id="productName" value="${bill.productDesc }">
						<font color="red"></font>
					</div>
					<div>
						<label for="productName">图片：</label> <input type="file"
							name="productImg"> <img src="images/buy.png"
							style="width: 40px; height: 40px; vertical-align: bottom;" /> <font
							color="red"></font>
					</div>
					<div>
						<label for="productUnit">商品单位：</label> <input type="text"
							name="productUnit" id="productUnit" value="${bill.productUnit }">
						<font color="red"></font>
					</div>
					<div>
						<label for="productCount">商品数量：</label> <input type="text"
							name="productCount" id="productCount"
							value="${bill.productCount }"> <font color="red"></font>
					</div>
					<div>
						<label for="totalPrice">总金额：</label> <input type="text"
							name="totalPrice" id="totalPrice" value="${bill.totalPrice }">
						<font color="red"></font>
					</div>
					<div>
						<label for="providerId">供应商： </label> <input type="hidden"
							value="${bill.providerId }" id="pid" /> <select
							name="providerId" id="providerId">
						</select> <font color="red"></font>
					</div>
					<div>
						<label>是否付款：</label>
						<c:if test="${bill.isPayment==1 }">
							<input type="radio" name="isPayment" value="1" checked="checked">未付款 
								<input type="radio" name="isPayment" value="2">已付款
								</c:if>
						<c:if test="${bill.isPayment==2 }">
							<input type="radio" name="isPayment" value="1">未付款
								<input type="radio" name="isPayment" value="2" checked="checked">已付款
							</c:if>
					</div>
					<div class="providerAddBtn">
						<input type="button" name="save" id="save" value="保存"> <a
							href="${APP_PATH }/orderListAll"> <input type="button"
							id="back" name="back" value="返回"></a>
					</div>
				</form>
			</div>
		</c:forEach>
	</div>
	</section>

	<footer class="footer"> 版权归源动力 </footer>
	<!--时间js-->
	<script type="text/javascript" src="${APP_PATH }/js/time.js"></script>
	<script src="${APP_PATH }/js/jquery-2.1.0.min.js"></script>
	<script type="text/javascript">
		var pid = $("#pid").val();
		$(function() {
			providerName();
		});
		//解析并显示下拉表
		function providerName() {
			$.ajax({
				url : "${APP_PATH}/provids",
				type : "GET",
				success : function(result) {
					console.log(result);
					$.each(result.extend.provids, function() {
						$("#providerId").append(
								$("<option></option>").append(
										this.provider.proName).attr("value",
										this.provider.pId));
						if (this.provider.pId == pid) {
							$("#providerId").find(
									"option[value = '" + pid + "']").attr(
									"selected", "selected")
						}
					});
				}
			});
		}
		//提交要修改的内容
		$("#save").click(function() {
			$.ajax({
				url : "${APP_PATH}/updateDtail",
				type : "POST",
				dataType : "JSON",
				data : $("#billForm").serialize(),
				success : function(result) {
					//console.log(result);
					if (result.code == 100) {
						//更新成功
						alert("更新成功");
					} else {
						alert("更新失败");
					}
				}
			});

		});
	</script>
</body>

</html>