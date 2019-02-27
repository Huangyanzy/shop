<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
	<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
	<title>已买历史</title>
	<link href="${ctx}/resources/css/kendoUI/kendo.common.min.css" rel="stylesheet">
	<link href="${ctx}/resources/css/kendoUI/kendo.bootstrap.min.css" rel="stylesheet">
	<link href="${ctx}/resources/css/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="${ctx}/resources/utils/font-awesome/css/font-awesome.min.css" rel="stylesheet">	
	<link href="${ctx}/resources/css/mycss/history.css" rel="stylesheet" >
    <script src="${ctx}/resources/js/lib/jquery-2.1.4.min.js"></script>
    <script src="${ctx}/resources/js/lib/kendoUI/kendo.all.min.js"></script>
    <script src="${ctx}/resources/css/bootstrap/js/bootstrap.min.js"></script>	
</head>

<style>
</style>

<body>	
	
	<div class="outer">
		<div class="top_bar">
			<div class="cominfo">
				商品
			</div>
			<div class="price">
				单价（元）
			</div>
			<div class="num">
				数量
			</div>
			<div class="total">
				订单总额
			</div>
			<div class="status">
				交易状态
			</div>
		</div>
	
		<c:forEach var="order" items="${order}">
			<div>
				<table>
					<tr class="tr_first">
						<td class="td_time">
							<div class="time">
								<i class="fa fa-clock-o" aria-hidden="true"></i> 
								${order.time}
							</div>
							订单号:${order.orderid}
						</td>
						<td colspan="2">卖家:${order.sellername}</td>
						<td></td>
						<td></td>					
					</tr>
					<c:forEach var="com" items="${order.comlist}" varStatus="status">
						<c:choose>
							<c:when test="${status.last==false}">
								<tr class="tr_com tr_com_hb">
							</c:when>
							<c:otherwise>
								<tr class="tr_com">
							</c:otherwise>
						</c:choose>
							<td class="td_pic">
								<input type="hidden" value="${com.commodity.comid}" />
								<img src="${com.commodity.compic}" >
								${com.commodity.comname}
							</td>
							<td class="td_price">
								<fmt:formatNumber pattern="#.##" value="${com.commodity.price}" minFractionDigits="2"/>
							</td>
							<td class="td_num">
								${com.num}
							</td>
							<c:choose>
								<c:when test="${status.first==true}">
									<c:choose>
										<c:when test="${status.count!=fn:length(order.comlist)}">
											<td class="td_total no_bottom">
												<fmt:formatNumber pattern="#.##" value="${order.total}" minFractionDigits="2"/>
											</td>
											<td class="td_status no_bottom">
												交易成功<br>
												订单详情									
											</td>											
										</c:when>
										<c:otherwise>
											<td class="td_total">
												<fmt:formatNumber pattern="#.##" value="${order.total}" minFractionDigits="2"/>
											</td>
											<td class="td_status">
												交易成功<br>
												订单详情									
											</td>											
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${status.count!=fn:length(order.comlist)}">
											<td class="td_total no_bottom"></td>
											<td class="td_status no_bottom"></td>											
										</c:when>
										<c:otherwise>
											<td class="td_total"></td>
											<td class="td_status"></td>										
										</c:otherwise>
									</c:choose>								
								</c:otherwise>
							</c:choose>							
							<!--
							<c:choose>
								<c:when test="${status.last==false}">
									<td class="td_total td_total_hb">
								</c:when>
								<c:otherwise>
									<td class="td_total">
								</c:otherwise>
							</c:choose>						
								<c:if test="${status.first==true}">
									<fmt:formatNumber pattern="#.##" value="${order.total}" minFractionDigits="2"/>
									</td>
									<td>
										交易成功<br>
										订单详情
									</td>
								</c:if>
							-->										
							<!--
							<c:if test="${status.first==true}">
								<td class="td_total" rowspan="${fn:length(order.comlist)}">
									<fmt:formatNumber pattern="#.##" value="${order.total}" minFractionDigits="2"/>
								</td>							
							</c:if>
							-->
						</tr>
					</c:forEach>
				</table>
				<br>
			</div>
		</c:forEach>
	</div>
	
	<!--
	<div style="height:50px;"></div>
	<c:forEach var="order" items="${order}">
		订单时间:${order.time},订单号:${order.orderid},卖家ID:${order.sellerid},卖家名:${order.sellername}<br>
		<c:forEach var="com" items="${order.comlist}">
			compic:${com.commodity.compic},
			comid:${com.commodity.comid},
			comname:${com.commodity.comname},
			price:${com.commodity.price},
			num:${com.num}
			<br>
		</c:forEach>
		订单总额:${order.total}
		<br>--------------<br><br>
	</c:forEach>	
    --> 
    <script>
   
    </script>
        
</body>
</html>