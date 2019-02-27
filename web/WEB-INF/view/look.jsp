<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="bid" value="${sessionScope.user.userid}" />

<!DOCTYPE html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
	<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
	<title>商品列表</title>
	<link href="${ctx}/resources/css/kendoUI/kendo.common.min.css" rel="stylesheet">
	<link href="${ctx}/resources/css/kendoUI/kendo.bootstrap.min.css" rel="stylesheet">
	<link href="${ctx}/resources/css/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="${ctx}/resources/utils/jquery-confirm/dist/jquery-confirm.min.css" rel="stylesheet">
	<link href="${ctx}/resources/utils/font-awesome/css/font-awesome.min.css" rel="stylesheet">
	<link href="${ctx}/resources/css/mycss/look.css" rel="stylesheet" >
    <script src="${ctx}/resources/js/lib/jquery-2.1.4.min.js"></script>
    <script src="${ctx}/resources/js/lib/kendoUI/kendo.all.min.js"></script>
    <script src="${ctx}/resources/css/bootstrap/js//bootstrap.min.js"></script>
    <script src="${ctx}/resources/utils/jquery-confirm/dist/jquery-confirm.min.js"></script>
    
</head>

<style>

</style>

<body>	
	
<!-- 	<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
		打开模态框
	</button> -->
	
	<div style="display:none;">
		<input type="text" id="search"><button id="search_btn">搜索</button>
	</div>
	
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<input type="hidden" id="modal_comid">				
				<!-- 模态框——图片 -->
				<div class="modal_pic">
					<div>
						<img id="modal_compic">
					</div>
				</div>
				<!-- 模态框——商品名 -->
				<div class="modal_name">
					<div>
						<span id="modal_comname"></span>
					</div>
				</div>
				<!-- 模态框——价格库存 -->
				<div class="modal_info">
					<div>
						<div class="modal_info1">
							<span class="symbol">¥</span>
							<span id="modal_price"></span>
						</div>
						<div class="modal_info2">
							已售：
							<span id="modal_sold"></span>
							件
						</div>
					</div>
				</div>
				<!-- 模态框——数量 -->
				<div class="modal_num">
					数量： 
					<input id="modal_num" type="number" min="1" max="999" step="1" >
				</div>
				<input type="hidden" id="modal_sellerid">
				<!-- 模态框——按钮 -->
				<div class="modal_btn">
					<div>
						<button class="left btn btn-default" onclick="addCart()">
							<span class="glyphicon glyphicon-shopping-cart"></span> 加入购物车
						</button>
						<button class="right btn btn-default" onclick="buy()">
							<span class="glyphicon glyphicon-hand-right"></span> 立即购买
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div>
		<div id="listView"></div>
		<div id="pager" class="k-pager-wrap"></div>
	</div>
    
    <script type="text/x-kendo-template" id="template">
		<div class="product">
			<input name="comid" type="hidden" value="#:comid#" >
			<img src="#:compic#" alt="#:comname#" />
			<h3>#:comname#</h3>
			<p onclick="imgClick(this)">#:kendo.toString(price,"c")#</p>
		</div> 	
    </script>
    
    <script>
		//数量文本框
		var numerictextbox=$('#modal_num').kendoNumericTextBox({
			format: 'n0'
		}).data("kendoNumericTextBox"); 
		
    	$(document).ready(function(){
    		var dataSource=new kendo.data.DataSource({
    			transport: {
    				read: {
    					url: '${ctx}/commodity/allCommodity',
    					dataType: 'json'
    				}
    			},
    			pageSize: 21
    		});
			$('#listView').kendoListView({
				dataSource: dataSource,
				template: kendo.template($('#template').html())
			});
			$('#pager').kendoPager({
				dataSource: dataSource
			});
			$('#search_btn').on('click',function(){
				$('#search').trigger('change');
			});
			$('#search').on('change',function(e){
				var listView=$('#listView').data('kendoListView');
				var comname=$('#search').val();
	    		dataSource=new kendo.data.DataSource({
	    			transport: {
	    				read: {
	    					url: '${ctx}/commodity/searchForLookPg',
	    					data: {'comname':comname},
	    					dataType: 'json'
	    				}
	    			},
	    		});				
				listView.setDataSource(dataSource);
			});
    	});
    	function imgClick(ts) {
    		var comid=$(ts).parent().children("input[name=comid]").val();
    		//console.log(comid);
     		$.ajax({
    			url: '${ctx}/commodity/oneCommodity',
    			type: 'post',
    			data: {"comid":comid},
    			dataType: 'json',
    			success: function(rt) {
    				//alert('success');
    				$("#modal_comid").val(rt.comid);
    				$('#modal_compic').attr('src',rt.compic);
     				$('#modal_comname').text(rt.comname);
     				$('#modal_price').text(rt.price);
     				$('#modal_sold').text(rt.sold);
     				$("#modal_sellerid").val(rt.sellerid);
     				numerictextbox.value(1);
    			},
    			error: function() {
    				alert('error');
    			}
    		});
    		$('#myModal').modal('show');
    	}
    	function addCart() {
			$.confirm({
				 icon: 'fa fa-cart-arrow-down',
				 title: false,
				 content: '确定加入购物车？',
				 confirmButton: '是',
				 cancelButton: '否',
				 theme: 'black',
				 animation: "rotateY",
				 closeIcon: true,
				 confirm: function() {	//确认加入购物车
					 var buyerid='${bid}';//当前买家id
					 var comid=$('#modal_comid').val();//商品id
					 var num=numerictextbox.value();//购买数量
					 var sellerid=$('#modal_sellerid').val();//卖家id
					 var url='${ctx}/commodity/addCart?buyerid='+buyerid+'&comid='+comid+'&num='+num+'&sellerid='+sellerid;
					 //console.log("buyerid="+buyerid+",comid="+comid+",num="+num);
					 $.dialog({						 
						 theme: 'black',
						 title: '<i class="fa fa-spinner fa-spin"></i>',
						 closeIcon: true,
						 backgroundDismiss: true,
						 content: 'url:'+url,
						 contentLoaded: function(data,status,xhr) {
							 var self=this;
							 var content,title;
							 if(status=='success') {
								content='商品加入购物车成功';
								title='<i class="fa fa-check"></i>';
							 }else {
								content='商品加入购物车失败';
								title='<i class="fa fa-close"></i>';								 
							 }
							 setTimeout(function(){
									self.setContent(content);
									self.setTitle(title);								 
							},1500);							 
						 }
						 /*
						 content: function() {
							 var self=this;
							setTimeout(function(){	
								$.ajax({									
								 	url: '${ctx}/commodity/addCart',
								 	type: 'get',
								 	data: {'buyerid':buyerid,'comid':comid,'num':num},
								 	dataType: 'json',
								}).done(function(rt) {
									self.setContent('商品加入购物车成功');
									self.setTitle('<i class="fa fa-check"></i>');								 
								}).fail(function() {
								 	self.setContent('商品加入购物车失败');
								 	self.setTitle('<i class="fa fa-close"></i>');								 
								});
							},1500);
						 }
						 */
					 });					 
				 }
				 /*
				 onAction:function(action) {				 
					if(action=='confirm') {//选择是
						var buyerid='${bid}';//当前买家id
						var comid=$('#modal_comid').val();//商品id
						var num=numerictextbox.value();//购买数量							
						$.ajax({
							 url: '${ctx}/commodity/addCart',
							 type: 'get',
							 data: {'buyerid':buyerid,'comid':comid,'num':num},
							 dataType: 'json',
							 success: function(rt) {
									self.setContent('商品成功加入购物车');
									self.setTitle('<i class="fa fa-check"></i>');	 									
									//console.log(self.$icon);
							 },
							 error: function() {
								 self.setContent('商品加入购物车失败');
								 self.setTitle('<i class="fa fa-close"></i>');
							 }
						});
						$.alert({						 
							 theme: 'black',
							 //icon: 'fa fa-spinner fa-spin',
							 title: '<i class="fa fa-spinner fa-spin fa-2x"></i>',
							 content: '&nbsp;',
							 closeIcon: false,
							 autoClose: 'confirm|1500',
							 confirm: function() {
								 alert('confirmed');
							 }
						 });		
					}					 
				 }
				 */
			});    		
    	}
    	function buy() {
			$.confirm({
				 icon: 'fa fa-share',
				 title: false,
				 content: '确定购买？',
				 confirmButton: '是',
				 cancelButton: '否',
				 theme: 'black',
				 animation: "rotateY",
				 closeIcon: false,
				 confirm: function() {//确认购买
					 var buyerid='${bid}';
					 var sellerid=$('#modal_sellerid').val();
					 var comid=parseInt($('#modal_comid').val());
					 var num=numerictextbox.value();
					 var price=parseFloat($('#modal_price').text());
					 var total=price*num;
					 var info={"buyerid":buyerid,"sellerid":sellerid,"cominfo":[{"comid":comid,"num":num}],"total":total};					 
					 $.dialog({
						 theme: 'black',
						 title: '<i class="fa fa-spinner fa-spin"></i>',
						 closeIcon: true,
						 backgroundDismiss: false,
						 //content: 'url:${ctx}/commodity/buy?buyerid='+buyerid+'&comid='+comid+'&num='+num,
						 content: 'url:${ctx}/commodity/waiting',
						 contentLoaded: function(data,status,xhr) {
							 var self=this;
							 setTimeout(function(){
								 var content=null,title=null;
								 $.ajax({
									url: '${ctx}/commodity/buy',
									type: 'post',
									async: false,
									data: JSON.stringify(info),
									contentType: "application/json;charset=utf-8",
									success: function() {
										content='商品购买成功!';
										title='<i class="fa fa-check"></i>';
									},
									error: function() {
										content='商品购买失败!';
										title='<i class="fa fa-close"></i>';										
									}
								 });
								 self.setContent(content);
								 self.setTitle(title);
							 },1500);
						 }
					 });
				 }
			});
    	}
    </script>
    
</body>
</html>