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
			<strong>你现在所在的位置是:</strong> <span>用户管理页面 >> 用户添加页面</span>
		</div>
		<div class="providerAdd">
			<form id="userForm" name="userForm" method="post">
				<input type="hidden" name="method" value="add">
				<!--div的class 为error是验证错误，ok是验证成功-->
				<div>
					<label for="userCode">用户编码：</label> <input type="text"
						name="userCode" id="userCode" value="" validatestatus="false">
				</div>
				<div>
					<label for="userName">用户名称：</label> <input type="text"
						name="userName" id="userName" value=""> <font color="red">*</font>
				</div>
				<div>
					<label for="userPassword">用户密码：</label> <input type="password"
						name="userPassword" id="userPassword" value=""> <font
						color="red">*</font>
				</div>
				<div>
					<label for="ruserPassword">确认密码：</label> <input type="password"
						name="ruserPassword" id="ruserPassword" value=""> <font
						color="red">*</font>
				</div>
				<div>
					<label>用户性别：</label> <select name="gender" id="gender">
						<option value="1" selected="selected">男</option>
						<option value="2">女</option>
					</select>
				</div>
				<div>
					<label for="birthday">出生日期：</label> <input type="text"
						class="Wdate" id="birthday" name="birthday" readonly="readonly"
						onclick="WdatePicker();"> <font color="red">*</font>
				</div>
				<div>
					<label for="phone">用户电话：</label> <input type="text" name="phone"
						id="phone" value=""> <font color="red">*</font>
				</div>
				<div>
					<label for="address">用户地址：</label> <input name="address"
						id="address" value="">
				</div>
				<div>
					<label>用户角色：</label>
					<!-- 列出所有的角色分类 -->
					<select name="userRole" id="selectList">
					</select> <font color="red">*</font>
				</div>
				<div class="providerAddBtn">
					<input type="button" name="add" id="add" value="保存"> <a
						href="${APP_PATH }/jsp/user_list.jsp"> <input type="button"
						id="back" name="back" value="返回"></a>
				</div>
			</form>
		</div>

	</div>
	</section>
	<footer class="footer"> 版权归源动力 </footer>
	<script type="text/javascript"
		src="${APP_PATH }/js/My97DatePicker/WdatePicker.js"></script>
	<!--时间js-->
	<script type="text/javascript" src="${APP_PATH }/js/time.js"></script>
	<script src="${APP_PATH }/js/jquery-2.1.0.min.js"></script>
	<script type="text/javascript">
		$(function() {
			selectList();
		});

		//解析并显示搜索下拉列表
		function selectList() {
			$.ajax({
				url : "${APP_PATH}/roleNames",
				type : "GET",
				success : function(result) {
					//console.log(result);
					$.each(result.extend, function() {
						$("#selectList").append(
								$("<option></option>").append(this.roleName)
										.attr("value", this.id));
					});
				}
			});
		}
	</script>
</body>

</html>