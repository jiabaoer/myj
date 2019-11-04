<%@page import="java.text.SimpleDateFormat"%>
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
<link type="text/css" rel="stylesheet" href="${APP_PATH }/css/style.css">
<link type="text/css" rel="stylesheet"
	href="${APP_PATH }/css/public.css">
</head>
<body class="is-loading">
	<jsp:include page="navbar.jsp"></jsp:include>
	<div class="right">
		<div class="location">
			<strong>你现在所在的位置是:</strong> <span>进货单管理页面</span>
		</div>
		<div class="search">
			<form method="get" action="#" id="selectFrom">
				<a href="${APP_PATH}/jsp/order_add.jsp">添加进货单</a> <span>商品名称：</span>
				<input style="width: 120px;" name="productName" id="productName"
					type="text" value=""> <span>供应商：</span> <select
					name="proName" id="selectList">
					<option value="">--请选择--</option>
				</select> <span>是否付款：</span> <select name="isPayment">
					<option value="">--请选择--</option>
					<option value="1">未付款</option>
					<option value="2">已付款</option>
				</select> <input value="查 询" type="submit" id="searchbutton"
					onclick="Query()">
			</form>
		</div>
		<!--账单表格 样式和供应商公用-->
		<table class="providerTable" cellpadding="0" cellspacing="0"
			id="bill_table">
			<thead>
				<tr class="firstTr">
					<th width="10%">订单编码</th>
					<th width="10%">图片</th>
					<th width="10%">商品名称</th>
					<th width="10%">供应商</th>
					<th width="10%">订单金额</th>
					<th width="5%">数量</th>
					<th width="10%">是否付款</th>
					<th width="10%">创建时间</th>
					<th width="30%">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${pageInfo.list }" var="bill">
					<tr>
						<td><span>${bill.billCode }</span></td>
						<td><span><img src="${APP_PATH}/images/buy.png"
								style="width: 40px; height: 40px;"></span></td>
						<td><span>${bill.productName }</span></td>
						<td><span>${ bill.provider.proName}</span></td>
						<td><span>${ bill.totalPrice}</span></td>
						<td>${bill.productCount }</td>
						<td><span> ${bill.isPayment == 1 ? "未付款" : "已付款" } </span></td>
						<td><span><fmt:formatDate
									value="${bill.creationDateBl}" pattern="yyyy-MM-dd" />
						</span></td>
						<td><span><a class="viewBill"
								href="${APP_PATH}/ordereDtail?id=${bill.bId}"> <img
									src="images/read.png" alt="查看" title="查看">
							</a> </span> <span> <a class="modifyBill"
								href="${APP_PATH}/ordereUpdateDtail?id=${bill.bId}"> <img
									src="images/xiugai.png" alt="修改" title="修改">
							</a>
						</span> <span><a class="deleteBill" href="javascript:;"
								id="delete" deleteId="${bill.bId}"> <img
									src="images/schu.png" onclick="delete_order()" alt="删除"
									title="删除"></a> </span></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="page-bar">
			<ul class="page-num-ul clearfix" id="pageBar">
				<li>共${pageInfo.total}条记录,共${pageInfo.pages }页&nbsp;&nbsp;
					当前第${pageInfo.pageNum }页</li>
				<a href="${APP_PATH }/orderListAll?pn=1">首页</a>
				<a
					href="${APP_PATH }/orderListAll?pn=${pageInfo.prePage==1?1:pageInfo.prePage-1}">上一页</a>
				<a
					href="${APP_PATH }/orderListAll?pn=${pageInfo.nextPage==pageInfo.pages?pageInfo.pages:pageInfo.nextPage}">下一页</a>
				<a href="${APP_PATH }/orderListAll?pn=${pageInfo.pages}">最后一页</a>
				&nbsp;&nbsp;
			</ul>
			<span class="page-go-form"><label>跳转至</label> <input
				type="text" name="inputPage" id="inputPage" class="page-key">页
				<button type="button" class="page-btn" id="GO">GO</button> </span>
		</div>
	</div>
	</section>
	<footer class="footer"> 版权归源动力 </footer>
	<!--时间js-->
	<script type="text/javascript" src="${APP_PATH }/js/time.js"></script>
	<script src="${APP_PATH }/js/jquery-2.1.0.min.js"></script>
	<script type="text/javascript">
		var currentPage;
		$(function() {
			selects();
			//total(1);
		});
		function total(pn) {
			$.ajax({
				url : "${APP_PATH}/orderListAll",
				dataType : "JSON",
				data : "pn=" + pn,
				type : "GET",
				success : function(result) {
					//console.log(result);
					//解析并显示数据					
					//billList(result);
					//解析并显示分页信息
					//page_info(result);
					$.ajax({
						url : "${APP_PATH}/provids",
						type : "GET",
						success : function(result) {
							//console.log(result);
							$.each(result.extend.provids, function() {
								$("<option></option>").append(
										this.provider.proName).attr("value",
										this.provider.proName).appendTo(
										"#selectList");
							});
						}
					});
				}
			});
		}
		//显示数据
		function billList(result) {
			//清空表格
			//$("#bill_table tbody").empty();
			//获取值
			var bills = result.extend.pageInfo.list;
			$
					.each(
							bills,
							function(index, bill) {
								//订单编码
								var billCode = $("<td></td>").append(
										bill.billCode);
								//订单图片
								var productImg = $("<td></td>").append(
										$("<img></img>").attr("src",
												"${APP_PATH}/images/buy.png"));
								//商品名称
								var productName = $("<td></td>").append(
										bill.productName);
								//供应商
								var proName = $("<td></td>").append(
										bill.provider.proName);
								//订单金额
								var totalPrice = $("<td></td>").append(
										bill.totalPrice);
								//订单数量
								var productCount = $("<td></td>").append(
										bill.productCount);
								//是否支付（1：未支付 2：已支付）
								var isPayment = $("<td></td>").append(
										bill.isPayment == 1 ? "未付款" : "已付款");
								//创建时间
								var date = new Date(bill.creationDateBl);
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
																"${APP_PATH}/ordereDtail?id="
																		+ bill.bId
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
																"${APP_PATH}/ordereUpdateDtail?id="
																		+ bill.bId
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
																bill.bId)
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
								$("<tr></tr>").append(billCode).append(
										productImg).append(productName).append(
										proName).append(totalPrice).append(
										productCount).append(isPayment).append(
										creationDate).append(operation)
										.appendTo("#bill_table tbody");
							});

		}
		//显示分页
		function page_info(result) {
			//$("#pageBar").empty();
			$("#pageBar").append(
					$("<li></li>").append(
							"共" + result.extend.pageInfo.total
									+ "条记录&nbsp;&nbsp;共"
									+ result.extend.pageInfo.pages + "页,当前第"
									+ result.extend.pageInfo.pageNum + "页"));
			currentPage = result.extend.pageInfo.pageNum;
			//首页
			var firstPage = $("<a></a>").attr("href", "#").append("首页");
			firstPage.click(function() {
				total(1);
			});
			//上一页
			var prePage = $("<a></a>").attr("href", "#").append("上一页");
			prePage.click(function() {
				total(result.extend.pageInfo.prePage);
			});
			//下一页
			var nextPage = $("<a></a>").attr("href", "#").append("下一页");
			nextPage.click(function() {
				total(result.extend.pageInfo.nextPage);
			});
			//最后一页
			var lastPage = $("<a></a>").attr("href", "#").append("最后一页");
			lastPage.click(function() {
				total(result.extend.pageInfo.pages);
			});
			$("#pageBar").append(firstPage).append(prePage).append(nextPage)
					.append(lastPage);
		}
		//跳转页
		$("#GO").click(function() {
			var goPage = $("#inputPage").val();
			total(goPage);
		});
		//供应商下拉列表
		function selects() {
			$.ajax({
				url : "${APP_PATH}/provids",
				type : "GET",
				success : function(result) {
					//console.log(result);
					$.each(result.extend.provids, function() {
						$("<option></option>").append(this.provider.proName)
								.attr("value", this.provider.proName).appendTo(
										"#selectList");
					});
				}
			});
		}

		//根据id删除
		$(document).on("click", "#delete", function() {
			if (confirm("确认删除吗？"))
				$.ajax({
					url : "${APP_PATH}/ordereDeleteDtail",
					data : "id=" + $(this).attr("deleteId"),
					type : "GET",
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
		//搜索功能
		$("#selects").click(function() {
			$("#selectList").val() = $("#selectList").attr("selected","selected");
			//清空表格
			$("#bill_table tbody").empty();
			$("#pageBar").empty();
			$.ajax({
				url : "${APP_PATH}/selects",
				data : $("#selectFrom").serialize(),
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