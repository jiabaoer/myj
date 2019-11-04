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
<link type="text/css" rel="stylesheet" href="${APP_PATH}/css/style.css" />
<link type="text/css" rel="stylesheet" href="${APP_PATH}/css/public.css" />
</head>
<body>
	<jsp:include page="navbar.jsp"></jsp:include>
	<div class="right">
		<div class="location">
			<strong>你现在所在的位置是:</strong> <span>密码修改页面</span>
		</div>
		<div class="providerAdd">
			<form id="userForm" name="userForm" method="post">
				<div class="info"></div>
				<div class="">
					<label for="oldPassword">旧密码：</label> <input type="password"
						name="oldpassword" id="oldpassword" value=""> <font
						color="red"></font>
				</div>
				<div>
					<label for="newPassword">新密码：</label> <input type="password"
						name="newpassword" id="newpassword" value=""> <font
						color="red"></font>
				</div>
				<div>
					<label for="reNewPassword">确认新密码：</label> <input type="password"
						name="rnewpassword" id="rnewpassword" value=""> <font
						color="red"></font>
				</div>
				<div class="providerAddBtn">
					<!--<a href="#">保存</a>-->
					<input type="button" name="save" id="updatePassword" value="保存"
						class="input-button">
				</div>
			</form>
		</div>
	</div>
	</section>
	<footer class="footer"> 版权归源动力 </footer>
	<!--时间js-->
	<script type="text/javascript" src="${APP_PATH}/js/time.js"></script>
	<script src="${APP_PATH }/js/jquery-2.1.0.min.js"></script>
	<script type="text/javascript">
		$("#updatePassword")
				.click(
						function() {
							if ($("#newpassword").val() == $("#rnewpassword")
									.val()) {
								$
										.ajax({
											url : "${APP_PATH}/userById",
											type : "GET",
											success : function(result) {
												//console.log(result);
												//获取旧密码
												$
														.each(
																result.extend,
																function() {
																	var password = $(
																			"#oldpassword")
																			.val();
																	if (this.userPassword == password) {
																		//校验密码成功
																		//修改密码
																		$
																				.ajax({
																					url : "${APP_PATH}/updatePasswordById?userPassword="
																							+ $(
																									"#rnewpassword")
																									.val(),
																					type : "GET",
																					success : function(
																							result) {
																						//console.log(result);
																						//修改成功
																						if (result.code == 100) {
																							alert("修改成功");
																						} else {
																							alert("修改失败");
																						}
																					}
																				});
																	} else {
																		//校验密码失败
																		alert("旧密码输入错误");
																	}
																});
											}
										});
							} else {
								alert("两次密码不一致");
							}
						});
	</script>
</body>
</html>
