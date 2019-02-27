<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%
	//获取当前用户的id、name、pic、type
/* 	int uid=(int)session.getAttribute("userid");
	String uname=(String)session.getAttribute("username");
	String upic=(String)session.getAttribute("userpic"); */
	int utype=0;	//1为买家，2为卖家
	//System.out.println("当前用户信息："+uid+" "+uname+" "+upic);
%>
<!DOCTYPE html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
	<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
	<title>主界面</title>
	<link href="${ctx}/resources/css/kendoUI/kendo.common.min.css" rel="stylesheet">
	<link href="${ctx}/resources/css/kendoUI/kendo.bootstrap.min.css" rel="stylesheet">
	<link href="${ctx}/resources/css/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="${ctx}/resources/css/mycss/main.css" rel="stylesheet" >
    <script src="${ctx}/resources/js/lib/jquery-2.1.4.min.js"></script>
    <script src="${ctx}/resources/js/lib/kendoUI/kendo.all.min.js"></script>
    <script src="${ctx}/resources/css/bootstrap/js//bootstrap.min.js"></script>
</head>

<body>
	<!-- 水平划分 -->	
	<div id="vertical">
		<!-- 上面板 -->
		<div id="top-pane">
			<div id="title-bar">
				<a href=""><img id="logo" src="${ctx}/resources/images/logo.png"></a>
				<span id="logo_tile">Shopping</span>
			</div>
			<div id="search" class="k-textbox k-space-right">
                <input type="text" id="search-input"/>
                <a href="#" class="k-icon k-i-search">&nbsp;</a>
            </div>			
			<div id="state-bar">
				<img src="" id="upic" class="img-circle">
				<span id="name"></span>
				<a id="logout" href="${ctx}/main/logout">注销</a>
			</div>
		</div>
		<!-- 下面板 -->		
		<div id="bottom-pane">
			<!-- 垂直划分 -->
			<div id="horizontal">
				<!-- 左导航栏 -->
				<div id="navigation">
					<li id="nav1">用户管理 
						<ul>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;个人信息</li>						
							<li>&nbsp;&nbsp;&nbsp;&nbsp;已买历史</li>
						</ul>
					</li>
					<li id="nav2">交易管理
						<ul>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;商品列表</li>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;购物车</li>
						</ul>
					</li>
					<!-- 只有卖家才拥有的权限 -->
					
					<li id="nav3">卖家权限
						<ul>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;商品管理</li>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;已卖列表</li>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;营业图表</li>
						</ul>
					</li>
				
				</div>
				<!-- 右导航栏 -->
				<div>right</div>
			</div>
		</div>
	</div>
	
	<script>
		$(document).ready(function(){
			/* 水平布局 */
			$("#vertical").kendoSplitter({
				orientation: "vertical",
				panes: [
					{size:"50px",resizable:false,scrollable:false},
					{}
				]
			});
			/* 垂直布局 */
 			$("#horizontal").kendoSplitter({
				orientation: "horizontal",
				panes: [
					{collapsible:true,size:"200px",max:"200px"},
					{collapsible:false}
				]
			});	
 			/* 导航栏 */ 			
 			$("#navigation").kendoPanelBar();
 			var nav=$("#navigation").data("kendoPanelBar");
 			nav.expand($('[id^="nav"]'));
 			
		});
			
	</script>

</body>
</html>
