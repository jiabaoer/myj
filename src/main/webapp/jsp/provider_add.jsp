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
<link type="text/css" rel="stylesheet" href="${APP_PATH }/css/style.css" />
<link type="text/css" rel="stylesheet"
	href="${APP_PATH }/css/public.css" />
</head>

<body>
	<jsp:include page="navbar.jsp"></jsp:include>
	<div class="right">
		<div class="location">
			<strong>你现在所在的位置是:</strong> <span> 供应商管理页面 >> 订单添加页面</span>
		</div>
		<div class="providerAdd">
			<form id="providerForm" name="providerForm" method="post">
				<!--div的class 为error是验证错误，ok是验证成功-->
				<div class="">
					<label for="proCode">供应商编码：</label> <input type="text"
						name="proCode" id="proCode" value="">
				</div>
				<div>
					<label for="proName">供应商名称：</label> <input type="text"
						name="proName" id="proName" value=""> <font color="red">*</font>
				</div>
				<div>
					<label for="proContact">联系人：</label> <input type="text"
						name="proContact" id="proContact" value=""> <font
						color="red">*</font>

				</div>
				<div>
					<label for="proPhone">联系电话：</label> <input type="text"
						name="proPhone" id="proPhone" value=""> <font color="red">*</font>
				</div>
				<div>
					<label for="proAddress">联系地址：</label> <input type="text"
						name="proAddress" id="proAddress" value="">
				</div>
				<div>
					<label for="proFax">传真：</label> <input type="text" name="proFax"
						id="proFax" value="">
				</div>
				<div>
					<label for="proDesc">描述：</label> <input type="text" name="proDesc"
						id="proDesc" value="">
				</div>
				<div class="providerAddBtn">
					<input type="button" name="add" id="add" value="保存"> <a
						href="${APP_PATH }/providerListAll"> <input
						type="button" id="back" name="back" value="返回"></a>
				</div>
			</form>
		</div>

	</div>
	</section>

	<footer class="footer"> 版权归源动力 </footer>
	<!--时间js-->
	<script type="text/javascript" src="${APP_PATH }/js/time.js"></script>
	<script src="${APP_PATH }/js/jquery-2.1.0.min.js"></script>
	<script type="text/javascript">
		$("#add").click(function() {
			$.ajax({
				url : "${APP_PATH}/addProvider",
				dataType : "JSON",
				data : $("#providerForm").serialize(),
				type : "POST",
				success : function(result) {
					console.log(result);
					if (result.code == 100) {
						//更新成功
						alert("添加成功");
						window.location.reload();
					} else {
						alert("添加失败");
					}
				}
			});
		});
	</script>
</body>

</html>