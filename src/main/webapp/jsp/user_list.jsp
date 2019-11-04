<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head lang="en">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title></title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<link type="text/css" rel="stylesheet" href="${APP_PATH }/css/style.css">
<link type="text/css" rel="stylesheet"
	href="${APP_PATH }/css/public.css">
<body>
	<jsp:include page="navbar.jsp"></jsp:include>
	<div class="right">
		<div class="location">
			<strong>你现在所在的位置是:</strong> <span>用户管理页面</span>
		</div>
		<%-- <div class="search">
				<form method="get" action="">
					<a href="${APP_PATH }/jsp/user_add.jsp">添加用户</a> <span>用户名：</span> <input
						name="queryname" class="input-text" type="text" value="">
					<span>用户角色：</span> <select name="queryUserRole" id="selectList">
						<option value="0">--请选择--</option>
					</select> <input type="hidden" name="pageIndex" value="1"> <input
						value="查 询" type="submit" id="searchbutton">

				</form>
			</div> --%>
		<!--账单表格 样式和供应商公用-->
		<table class="providerTable" id="UserTable" cellpadding="0"
			cellspacing="0">
			<thead>
				<tr class="firstTr">
					<th width="10%">用户编码</th>
					<th width="20%">用户名称</th>
					<th width="10%">性别</th>
					<th width="10%">年龄</th>
					<th width="10%">电话</th>
					<th width="10%">用户角色</th>
					<th width="30%">操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		<!-- <div class="page-bar">
				<ul class="page-num-ul clearfix" id="pageBar">
				</ul>
				<span class="page-go-form"><label>跳转至</label> <input
					type="text" name="inputPage" id="inputPage" class="page-key">页
					<button type="button" class="page-btn" id="GO">GO</button> </span>
			</div> -->
	</div>
	</section>

	<footer class="footer"> 版权归源动力 </footer>
</body>

<!--时间js-->
<script type="text/javascript" src="${APP_PATH }/js/time.js"></script>
<script src="${APP_PATH }/js/jquery-2.1.0.min.js"></script>
<script type="text/javascript">
	$(function() {
		total();
	});
	function total() {
		$.ajax({
			url : "${APP_PATH}/userById",
			//data : "pn=" + pn,
			type : "GET",
			success : function(result) {
				console.log(result);
				//解析并显示数据					
				billList(result);
				//解析并显示分页信息
				//page_info(result);
			}
		});
	}
	//显示数据
	function billList(result) {
		//清空表格
		$("#UserTable tbody").empty();
		//获取值
		var users = result.extend;
		$.each(users, function(index, us) {
			//用户编码
			var userCode = $("<td></td>").append(us.userCode);
			//用户名称
			var userName = $("<td></td>").append(us.userName);
			//用户性别
			var gender = $("<td></td>").append(us.gender == 1 ? "女" : "男");
			//用户年龄
			var date1 = new Date(us.birthday);
			var Y1 = date1.getFullYear();
			var date2 = new Date();
			var Y2 = date2.getFullYear();
			var birthday = $("<td></td>").append(Y2 - Y1);
			//用户电话
			var phone = $("<td></td>").append(us.phone);
			//用户角色
			var userRole = $("<td></td>").append(us.role.roleName);
			//操作信息
			//查看
			var operation = $("<td></td>").append(
					$("<a></a>").addClass("viewBill").attr("href",
							"${APP_PATH}/userDtail?id=" + us.id + "").append(
							$("<img></img>").attr("src",
									"${APP_PATH}/images/read.png").attr("alt",
									"查看").attr("title", "查看"))).append(
					$("<a></a>").addClass("modifyBill").attr("href",
							"${APP_PATH}/userUpdateDtail?id=" + us.id + "")
							.append(
									$("<img></img>").attr("src",
											"${APP_PATH}/images/xiugai.png")
											.attr("alt", "修改").attr("title",
													"修改")));/* append(
								$("<a></a>").addClass("deleteBill").attr("href",
										"${APP_PATH}/userDeleteDtail?id=" + us.id + "")
										.append(
												$("<img></img>").attr("src",
														"${APP_PATH}/images/schu.png")
														.attr("alt", "删除").attr("title",
																"删除"))); */
			$("<tr></tr>").append(userCode).append(userName).append(gender)
					.append(birthday).append(phone).append(userRole).append(
							operation).appendTo("#UserTable tbody");
		});

	}

	//显示分页
	function page_info(result) {
		$("#pageBar").empty();
		$("#pageBar").append(
				$("<li></li>").append(
						"共条" + result.extend.endRow + "记录&nbsp;&nbsp;"
								+ result.extend.pages + "页"));
		//首页
		var firstPage = $("<a></a>").attr("href", "#").append("首页");
		//上一页
		var prePage = $("<a></a>").attr("href", "#").append("上一页");
		if (result.extend.hasPreviousPage == true) {
			prePage.click(function() {
				total(result.extend.pageNum - 1);
			});
			firstPage.click(function() {
				total(1);
			});
		}
		//下一页
		var nextPage = $("<a></a>").attr("href", "#").append("下一页");
		//最后一页
		var lastPage = $("<a></a>").attr("href", "#").append("最后一页");
		if (result.extend.hasNextPage == true) {
			nextPage.click(function() {
				total(result.extend.pageNum + 1);
			});
			lastPage.click(function() {
				total(result.extend.pages);
			});
		}
		$("#pageBar").append(firstPage).append(prePage).append(nextPage)
				.append(lastPage);
	}
	//跳转页
	$("#GO").click(function() {
		var goPage = $("#inputPage").val();
		total(goPage);
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
							$("<option></option>").append(this.roleName).attr(
									"value", this.id));
				});
			}
		});
	}
</script>
</html>