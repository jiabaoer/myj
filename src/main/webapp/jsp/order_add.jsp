
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>

<head lang="en">
<meta charset="UTF-8">
<meta http-equiv="Content-Type"
	content="multipart/form-data; charset=utf-8" />
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
			<strong>你现在所在的位置是:</strong> <span>订单管理页面 >> 进货单添加页面</span>
		</div>
		<div class="providerAdd">
			<form id="billForm" name="billForm" method="post"
				action="${APP_PATH}/addOrder" enctype="multipart/form-data">
				<!--div的class 为error是验证错误，ok是验证成功-->
				<div class="">
					<label for="billCode">订单编码：</label> <input type="text"
						name="billCode" id="billCode">
				</div>
				<div>
					<label for="productName">商品名称：</label> <input type="text"
						name="productName" id="productName"> <font color="red"></font>
				</div>
				<div>
					<label for="productDesc">商品描述：</label> <input type="text"
						name="productDesc" id="productDesc"> <font color="red"></font>
				</div>
				<div>
					<label for="productName">图片：</label> <input type="file"
						name="productImg"> <font color="red"></font>
				</div>
				<div>
					<label for="productUnit">商品单位：</label> <input type="text"
						name="productUnit" id="productUnit"> <font color="red"></font>
				</div>
				<div>
					<label for="productCount">商品数量：</label> <input type="text"
						name="productCount" id="productCount"> <font color="red"></font>
				</div>
				<div>
					<label for="totalPrice">总金额：</label> <input type="text"
						name="totalPrice" id="totalPrice"> <font color="red"></font>
				</div>
				<div>
					<label for="providerId">供应商：</label> <input type="hidden"
						value="13" id="pid" /> <select name="providerId" id="providerId">
					</select> <font color="red"></font>
				</div>
				<div>
					<label>是否付款：</label> <input type="radio" name="isPayment" value="1"
						checked="checked">未付款 <input type="radio" name="isPayment"
						value="2">已付款

				</div>
				<div class="providerAddBtn">
					<input type="submit" name="save" id="save" value="保存"><a
						href="${APP_PATH }/orderListAll"> <input type="button"
						id="back" name="back" value="返回"></a>
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
		$(function() {
			providerName();
		});
		//解析并显示下拉表
		function providerName() {
			$.ajax({
				url : "${APP_PATH}/provids",
				type : "GET",
				success : function(result) {
					//console.log(result);
					$.each(result.extend.provids, function() {
						$("#providerId").append(
								$("<option></option>").append(
										this.provider.proName).attr("value",
										this.provider.pId));
					});
				}
			});
		}
		/* $("#save").click(function() {
			//拿到表单对象
			var form = new FormData($("#billForm")[0]);
			$.ajax({
				type : "POST",
				url : "${APP_PATH}/addOrder",
				data : form,
				cache : false, //上传文件不需缓存
				async : false, //这里要设置异步上传，才能成功调用myXhr.upload.addEventListener('progress',function(e){}),progress的回掉函数
				processData : false,//需设置为false，因为data值是FormData对象，不需要对数据做处理
				contentType : false,//需设置为false，因为是FormData对象，且已经声明了属性enctype="multipart/form-data"
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
		}); */
	</script>
</body>

</html>