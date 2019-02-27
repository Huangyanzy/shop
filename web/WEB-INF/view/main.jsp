<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.demo.model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%
	//获取当前用户的id、name、pic、type
	User user=(User)session.getAttribute("user");
	String uname=user.getUsername();
	String upic=user.getUserpic();
	String utype=user.getUsertype();
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
	<link href="${ctx}/resources/utils/font-awesome/css/font-awesome.min.css" rel="stylesheet">	
	<link href="${ctx}/resources/css/mycss/main.css" rel="stylesheet" >
    <script src="${ctx}/resources/js/lib/jquery-2.1.4.min.js"></script>
    <script src="${ctx}/resources/js/lib/kendoUI/kendo.all.min.js"></script>
    <script src="${ctx}/resources/css/bootstrap/js//bootstrap.min.js"></script>
</head>

<body>
	<div class="icon_refresh" onclick="refreshTab()">
		<i class="fa fa-refresh fa-spin fa-lg fa-fw" aria-hidden="true"></i>
	</div>
	<!-- 水平划分 -->	
	<div id="vertical">
		<!-- 上面板 -->
		<div id="top-pane">
			<div id="title-bar">
				<a href=""><img id="logo" src="${ctx}/resources/images/logo.png"></a>
				<span id="logo_tile">Shopping</span>
			</div>
			<div id="search" class="k-textbox k-space-right">
                <input type="text" id="search-input" style="width:100%" />
                <a href="#" class="k-icon k-i-search">&nbsp;</a>
            </div>			
			<div id="state-bar">
				<img src="<%=upic %>" id="upic" class="img-circle">
				<span id="name"><%=uname %></span>
				<a id="logout" href="${ctx}/main/logout">注销</a>
			</div>
		</div>
		<!-- 下面板 -->		
		<div id="bottom-pane">
			<!-- 垂直划分 -->
			<div id="horizontal">
				<!-- 左导航栏 -->
				<div id="left-nav">			
					<li id="nav1">用户管理 
						<ul>
							<li onclick="openTab('个人信息')">&nbsp;&nbsp;&nbsp;&nbsp;个人信息</li>						
							<li onclick="openTab('已买历史')">&nbsp;&nbsp;&nbsp;&nbsp;已买历史</li>
						</ul>
					</li>
					<li id="nav2">交易管理
						<ul>
							<li onclick="openTab('商品列表')">&nbsp;&nbsp;&nbsp;&nbsp;商品列表</li>
							<li onclick="openTab('购物车')">&nbsp;&nbsp;&nbsp;&nbsp;购物车</li>
						</ul>
					</li>
					<!-- 只有卖家才拥有的权限 -->
					<% if(utype.equals("seller")) { %>
					<li id="nav3">卖家权限
						<ul>
							<li onclick="openTab('商品管理')">&nbsp;&nbsp;&nbsp;&nbsp;商品管理</li>
							<li onclick="openTab('已卖列表')">&nbsp;&nbsp;&nbsp;&nbsp;已卖列表</li>
							<li onclick="openTab('营业图表')">&nbsp;&nbsp;&nbsp;&nbsp;营业图表</li>
						</ul>
					</li>
					<% } %>
				</div>
				<!-- 右面板——导航栏 -->				
				<!-- 选项卡 -->
				<div id="right-tab">
					<div id="tabstrip">					
						<ul id="tablist">
							<li id="homepage">首页</li> 
						</ul>
						<div>
							<iframe id="if_homepage" src="main/page/homepage" frameborder="0"></iframe>													
						</div>						
					</div>
				</div>				
			</div>
		</div>
	</div>
	<script>
		/* 选项卡 */			
		var tabstrip=$("#tabstrip").kendoTabStrip({
							navigatable:true,
							animation: {
								open: {
									effects: "fadeIn"
								}
							}
							}).data("kendoTabStrip");		
		$(document).ready(function() {
			/* 初始化kendoui */
			kendoUi();
			//搜索框自动完成
			$('#search-input').kendoAutoComplete({
				minLength: 1,
				dataTextField: 'comname',
				filter: 'contains',
				//highlightFirst: true,
				suggest: true,
                headerTemplate: '<div class="dropdown-header k-widget k-header">' +
                '<span>图片</span>' + '<span>名字</span>' +'</div>',
            	 template: '<span class="k-state-default" style="background-image: url(\'#:data.compic#\')"></span>' +
                 '<span class="k-state-default"><h3>#: data.comname #</h3><p>#: data.description #</p></span>',
                 dataSource: {
                	 transport: {
                		 read: {
                			 dataType: 'json',
                			 url: '${ctx}/commodity/allCommodity'
                		 }
                	 },
                	 pageSize: 6
                 },
                 height: 500
			});
			$('#search-input').on('keypress',function(e){
				//找到当前选项卡组
				var tablist=tabstrip.tabGroup.children();
				var curtab=null;
				//遍历找到当前已打开的选项卡
				tablist.each(function(){
					if($(this).attr("aria-selected")=="true") {
						curtab=$(this);
					}
				});	
				var tabCName=curtab.children("span:eq(1)").text();
				var tabEName=tabUrl(tabCName);
				var inp=$('#search-input').val();
				if(tabEName=='look'&&e.keyCode==13) {									
					var lookPage_search=$('#look').contents().find('#search');
					lookPage_search.val(inp);
					var lookPage_search_btn=$('#look').contents().find('#search_btn');
					$(lookPage_search_btn).trigger('click');
				}else if(tabEName='commodity'&&e.keyCode==13) {
					var comPage_search=$('#commodity').contents().find('#search');
					comPage_search.val(inp);
					var comPage_search_btn=$('#commodity').contents().find('#search_btn');
					$(comPage_search_btn).trigger('click');
				}
			});
		});
		
		/* kendoUi */
		function kendoUi() {
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
			$("#left-nav").kendoPanelBar();
			var nav=$("#left-nav").data("kendoPanelBar");
			nav.expand($('[id^="nav"]'));		
			//展开首页				
			tabstrip.activateTab($("#homepage"));	
		}
		/* 看选项卡是否已存在，找到返回引用，否则为不存在 */
		function isExistTab(tabname) {
			var tablist=tabstrip.tabGroup.children();	//返回选项卡列表的引用	
			var tab=null;
			tablist.each(function() {
				if($(this).children("span:eq(1)").text()==tabname) {
// 					console.log($(this).children("span:eq(1)").text());
					tab=$(this);		
				}
			});
			return tab;
		}
		function tabUrl(tabname) {
			var taburl=null;
			switch(tabname) {
			case '首页':
				taburl='if_homepage';
				break;
			case '个人信息':
				taburl='userinfo';
				break;
			case '已买历史':
				taburl='buyhistory';
				break;
			case '商品列表':
				taburl='look';
				break;
			case '购物车':
				taburl='shoppingcart';
				break;
			case '商品管理':
				taburl='commodity';
				break;
			case '已卖列表':
				taburl='sellhistory';
				break;
			case '营业图表':
				taburl='chart';
				break;			
			}
			return taburl;
		}
		/* 打开选项卡 */
		function openTab(tabname) {
			var tab=isExistTab(tabname);
			//若选项卡不存在，新创建
			var pname=tabUrl(tabname);
			if(tab==null) {
				tabstrip.append(
						[{
						text: tabname,
						encoded: false,
						content: '<iframe id="'+pname+'" src="main/page/'+pname+'" frameborder="0"></iframe>'
						}]
				);
				var curtab=isExistTab(tabname);	//获取创建的选项卡引用
				tabstrip.activateTab(curtab);
				curtab.append("<span class='glyphicon glyphicon-remove' onclick='closeTab(\""+tabname+"\")'></span>");
				/*
				$.ajax({
					type : "get",
					url : "${ctx}/main/page/" + tabname,
					async : true,
					success : function(rtpage) {
						//根据返回的页面生成选项卡  						
						//console.log(tabstrip);
						tabstrip.append(
								[{
								text: tabname,
								encoded: false,
								content: "<iframe srcdoc='"+rtpage+"' frameborder='0'></iframe>"
								}]
						);						
						var curtab=isExistTab(tabname);	//获取创建的选项卡引用
						tabstrip.activateTab(curtab);
						curtab.append("<span class='glyphicon glyphicon-remove' onclick='closeTab(\""+tabname+"\")'></span>");						
					},
					error : function() {
						alert("error");
					}				
				});
				*/
			}else {
				tabstrip.activateTab(tab);
				//refreshTab(pname);
			}
		}
		//刷新选项卡
		function refreshTab() {
			//找到当前选项卡组
			var tablist=tabstrip.tabGroup.children();
			var curtab=null;
			//遍历找到当前已打开的选项卡
			tablist.each(function(){
				if($(this).attr("aria-selected")=="true") {
					curtab=$(this);
				}
			});	
			var tabCName=curtab.children("span:eq(1)").text();
			var tabEName=tabUrl(tabCName);
			document.getElementById(tabEName).contentWindow.location.reload(true);
		}
		/* 关闭选项卡*/
		function closeTab(tabname) {
			//var tablist=tabstrip.items();	//获取选项卡列表
			var tablist=tabstrip.tabGroup.children();
			var deltab=isExistTab(tabname);	//获取要关闭选项卡的引用
			var curtab=deltab;
			//遍历找到当前已打开的选项卡
			tablist.each(function(){
				if($(this).attr("aria-selected")=="true") {
					curtab=$(this);
				}
			});
			//如果当前选项卡等于需关闭选项卡，判断后面位置来打开选项卡，若不相等，直接关闭
			if(curtab.text()==deltab.text()) {	//关闭当前选项卡
				if(curtab.next().length==0) {	//后面无选项卡	
 					var opentab=curtab.prev();
					tabstrip.remove(deltab);
					tabstrip.activateTab(opentab);	//打开前面 			
				}else {	//后面有选项卡
					var opentab=curtab.next();
					tabstrip.remove(deltab);
					tabstrip.activateTab(opentab);	//打开后面
				}
			}else {
				tabstrip.remove(deltab);
			}
		}
		function getIFrameDOM(iID) {
			return document.getElementByID(iID).contentWindow.document;
		}
	</script>

</body>
</html>
