<%@page import="java.text.SimpleDateFormat"%>
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
			<strong>你现在所在的位置是:</strong> <span>用户管理页面 >> 用户信息查看页面</span>
		</div>
		<c:forEach items="${list }" var="user">
			<div class="providerAdd">
				<form id="userForm" name="userForm" method="post" action="">
					<input type="hidden" value="${user.id }" name="id">
					<div>
						<label for="userName">用户名称：</label> <input type="text"
							name="userName" id="userName" value="${user.userName }"
							validatestatus="true">
					</div>
					<div>
						<label>用户性别：</label> <select name="gender" id="gender">
							<c:if test="${user.gender==1}">
								<option value="2">男</option>
								<option value="1" selected="selected">女</option>
							</c:if>
							<c:if test="${user.gender==2}">
								<option value="2" selected="selected">男</option>
								<option value="1">女</option>
							</c:if>
						</select>
					</div>
					<%
						SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
					%>
					<div>
						<label for="data">出生日期：</label> <input type="text" 
							id="birthday" name="birthday" value="${user.birthday }"
							
							validatestatus="true">
					</div>

					<div>
						<label for="userphone">用户电话：</label> <input type="text"
							name="phone" id="phone" value="${user.phone }"
							validatestatus="true">
					</div>
					<div>
						<label for="userAddress">用户地址：</label> <input type="text"
							name="address" id="address" value="${user.address } ">
					</div>
					<div>
						<label>用户角色：</label>
						<!-- 列出所有的角色分类 -->
						<input type="hidden" value="${user.userRole }" id="rid"> <select
							name="userRole" id="userRole" validatestatus="true">
						</select>
					</div>
					<div class="providerAddBtn">
						<input type="button" name="save" id="save" value="保存"> <a
							href="${APP_PATH }/jsp/user_list.jsp"> <input type="button"
							id="back" name="back" value="返回"></a>
					</div>
				</form>
			</div>
		</c:forEach>
	</div>
	</section>

	<footer class="footer"> 版权归源动力 </footer>
	<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
	<!--时间js-->
	<script type="text/javascript" src="${APP_PATH }/js/time.js"></script>
	<script src="${APP_PATH }/js/jquery-2.1.0.min.js"></script>
	<script type="text/javascript">
		var rid = $("#rid").val();
		$(function() {
			providerName();
		});
		//解析并显示下拉表
		function providerName() {
			$.ajax({
				url : "${APP_PATH}/roleNames",
				type : "GET",
				success : function(result) {
					//console.log(result);
					$.each(result.extend, function(index, role) {
						$("#userRole").append(
								$("<option></option>").append(role.roleName)
										.attr("value", role.rId));
						if (role.rId == rid) {
							$("#userRole")
									.find("option[value = '" + rid + "']")
									.attr("selected", "selected")
						}
					});
				}
			});
		}
		//更新用户名
		$("#save").click(function() {
			$.ajax({
				url : "${APP_PATH}/updateUser",
				data : "JSON",
				data : $("#userForm").serialize(),
				type : "GET",
				success : function(result) {
					console.log(result);
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