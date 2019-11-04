<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>

<head lang="en">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title></title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<link type="text/css" rel="stylesheet" href="${APP_PATH}/css/style.css">
<link type="text/css" rel="stylesheet" href="${APP_PATH}/css/public.css">
<body>
	<jsp:include page="navbar.jsp"></jsp:include>
	<div class="right">
		<div class="location">
			<strong>你现在所在的位置是:</strong> <span> 供应商管理页面</span>
		</div>
		<div class="search">
			<form method="get" action="" id="providerFrom">
				<a href="${APP_PATH }/jsp/provider_add.jsp">添加供应商</a> <span>供应商编码：</span>
				<input name="queryProCode" id="queryProCode" type="text" value="">
				<span>供应商名称：</span> <input name="queryProName" type="text"
					id="queryProName" value=""> <input value="查 询"
					type="submit" id="searchbutton">
			</form>
		</div>
		<!--账单表格 样式和供应商公用-->
		<table class="providerTable" id="providerTable" cellpadding="0"
			cellspacing="0">
			<thead>
				<tr class="firstTr">
					<th width="10%">供应商编码</th>
					<th width="20%">供应商名称</th>
					<th width="10%">联系人</th>
					<th width="10%">联系电话</th>
					<th width="10%">传真</th>
					<th width="10%">创建时间</th>
					<th width="30%">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${extend.list }" var="pro">
					<tr>
						<td><span>${pro.proCode }</span></td>
						<td><span>${pro.proName }</span></td>
						<td><span>${pro.proContact }</span></td>
						<td><span>${pro.proPhone }</span></td>
						<td><span>${pro.proPhone}</span></td>
						<td><span> <fmt:formatDate
									value="${pro.creationDatePro }" pattern="yyyy-MM-dd" /></span></td>
						<td><span><a class="viewProvider"
								href="${APP_PATH}/providerDtail?id=${pro.pId }"><img
									src="images/read.png" alt="查看" title="查看"></a></span> <span><a
								class="modifyProvider"
								href="${APP_PATH}/providerUpdateDtail?id=${pro.pId }"><img
									src="images/xiugai.png" alt="修改" title="修改"></a></span> <span><a
								class="deleteProvider" id="delete" deleteId="${pro.pId }"><img
									src="images/schu.png" alt="删除" title="删除"></a></span></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="page-bar" id="pageBar">
			<ul class="page-num-ul clearfix">
				<li>共${extend.total}条记录,共${extend.pages }页&nbsp;&nbsp;
					当前第${extend.pageNum }页</li>
				<a href="${APP_PATH }/providerListAll?pn=1">首页</a>
				<a
					href="${APP_PATH }/providerListAll?pn=${extend.prePage==1?1:extend.prePage}">上一页</a>
				<a
					href="${APP_PATH }/providerListAll?pn=${extend.nextPage==extend.pages?extend.pages:extend.nextPage}">下一页</a>
				<a href="${APP_PATH }/providerListAll?pn=${extend.pages}">最后一页</a>
				&nbsp;&nbsp;
			</ul>
			<span class="page-go-form"><label>跳转至</label> <input
				type="text" name="inputPage" id="inputPage" class="page-key">页
				<button type="button" class="page-btn">GO</button> </span>
		</div>
	</div>
	</section>

	<footer class="footer"> 版权归源动力 </footer>
	<!--时间js-->
	<script type="text/javascript" src="${APP_PATH}/js/time.js"></script>
	<script src="${APP_PATH }/js/jquery-2.1.0.min.js"></script>
	<script type="text/javascript">
		var currentPage;
		//页面加载完成
		$(function() {
			//total(1);
		});
		function total(pn) {
			$.ajax({
				url : "${APP_PATH}/providerListAll",
				data : "pn=" + pn,
				type : "GET",
				success : function(result) {
					//console.log(result);
					//解析并显示数据					
					billList(result);
					//解析并显示分页信息
					page_info(result);
				}
			});
		}
		//显示数据
		function billList(result) {
			//清空表格
			//$("#providerTable tbody").empty();
			//获取值
			var pros = result.extend.list;
			$
					.each(
							pros,
							function(index, pro) {
								//供应商编码
								var proCode = $("<td></td>")
										.append(pro.proCode);
								//供应商名称
								var proName = $("<td></td>")
										.append(pro.proName);
								//供应商联系人
								var proContact = $("<td></td>").append(
										pro.proContact);
								//联系电话
								var proPhone = $("<td></td>").append(
										pro.proPhone);
								//传真
								var proFax = $("<td></td>").append(pro.proFax);
								//创建时间
								var date = new Date(pro.creationDatePro);
								Y = date.getFullYear();
								M = (date.getMonth() + 1 < 10 ? '0'
										+ (date.getMonth() + 1) : date
										.getMonth() + 1);
								D = date.getDate();
								var creationDate = $("<td></td>").append(
										Y + "-" + M + "-" + D);
								//操作信息
								//查看
								var operation = $("<td></td>")
										.append(
												$("<a></a>")
														.addClass("viewBill")
														.attr(
																"href",
																"${APP_PATH}/providerDtail?id="
																		+ pro.pId
																		+ "")
														.append(
																$("<img></img>")
																		.attr(
																				"src",
																				"${APP_PATH}/images/read.png")
																		.attr(
																				"alt",
																				"查看")
																		.attr(
																				"title",
																				"查看")))
										.append(
												$("<a></a>")
														.addClass("modifyBill")
														.attr(
																"href",
																"${APP_PATH}/providerUpdateDtail?id="
																		+ pro.pId
																		+ "")
														.append(
																$("<img></img>")
																		.attr(
																				"src",
																				"${APP_PATH}/images/xiugai.png")
																		.attr(
																				"alt",
																				"修改")
																		.attr(
																				"title",
																				"修改")))
										.append(
												$("<a></a>")
														.addClass("deleteBill")
														.attr("id", "delete")
														.attr("deleteId",
																pro.pId)
														.append(
																$("<img></img>")
																		.attr(
																				"src",
																				"${APP_PATH}/images/schu.png")
																		.attr(
																				"alt",
																				"删除")
																		.attr(
																				"title",
																				"删除")));
								$("<tr></tr>").append(proCode).append(proName)
										.append(proContact).append(proPhone)
										.append(proFax).append(creationDate)
										.append(operation).appendTo(
												"#providerTable tbody");
							});

		}

		//显示分页
		function page_info(result) {
			//$("#pageBar").empty();
			$("#pageBar").append(
					$("<li></li>").append(
							"共" + result.extend.total + "条记录&nbsp;&nbsp;共"
									+ result.extend.pages + "页,当前第"
									+ result.extend.pageNum + "页"));
			currentPage = result.extend.pageNum;
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
		//根据id删除
		$(document).on("click", "#delete", function() {
			if (confirm("确认删除吗？"))
				$.ajax({
					url : "${APP_PATH}/providerDeleteDtail",
					type : "POST",
					data : "id=" + $(this).attr("deleteId"),
					success : function(result) {
						if (result.code = 100) {
							alert("删除成功");
							//跳转当前页
							total(currentPage);
						} else {
							alert("删除失败");
						}
					}
				})
		});
		//查询供应商
		$("#searchbutton").click(
				function() {
					//清空表格
					$("#bill_table tbody").empty();
					$("#pageBar").empty();
					$.ajax({
						url : "${APP_PATH}/selectProviderConditions",
						dataType : "JSON",
						data : "queryProCode=" + $("#queryProCode").val()
								+ "&queryProName=" + $("#queryProName").val(),
						type : "GET",
						success : function(result) {
							console.log(result);
							//解析并显示数据					
							billList(result);
							//解析并显示分页信息
							page_info(result);
						}
					});
				});
	</script>
</body>
</html>