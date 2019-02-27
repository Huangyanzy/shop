<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="bid" value="${sessionScope.user.userid}" />
<!DOCTYPE html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
	<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
	<title>购物车</title>
	<link href="${ctx}/resources/css/kendoUI/kendo.common.min.css" rel="stylesheet">
	<link href="${ctx}/resources/css/kendoUI/kendo.bootstrap.min.css" rel="stylesheet">
	<link href="${ctx}/resources/css/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="${ctx}/resources/utils/jquery-confirm/dist/jquery-confirm.min.css" rel="stylesheet">
	<link href="${ctx}/resources/utils/font-awesome/css/font-awesome.min.css" rel="stylesheet">	
	<link href="${ctx}/resources/css/mycss/shoppingcart.css" rel="stylesheet" >
    <script src="${ctx}/resources/js/lib/jquery-2.1.4.min.js"></script>
    <script src="${ctx}/resources/js/lib/kendoUI/kendo.all.min.js"></script>
    <script src="${ctx}/resources/css/bootstrap/js//bootstrap.min.js"></script>
    <script src="${ctx}/resources/utils/jquery-confirm/dist/jquery-confirm.min.js"></script>    	
</head>

<style>
	
</style>

<body>	
	
	<div class="top_bar">		
		<div class="top_allsel">
			<input class="allSel" type="checkbox" />
			全选
		</div>
		<div class="top_cominfo">
			商品信息
		</div>
		<div class="top_price">
			单价（元）
		</div>
		<div class="top_num">
			数量
		</div>
		<div class="top_total">
			金额（元）
		</div>
		<div class="top_op">
			操作
		</div>		
	</div>
	
	<c:forEach var="seller" items="${sellerlist}">
		<div class="outer">
			<div class="seller_info">
				<input id="sellerid" type="hidden" value="${seller.id}" />
				<input class="partSel" type="checkbox"/>
				<span class="seller_name">卖家：</span><c:out value="${seller.name}" />
			</div>
			<div class="item_outer">
				<c:forEach var="com" items="${comlist}">
					<c:if test="${com.commodity.sellerid==seller.id}">
						<div class="item_content">
							<div class="item_onesel">
								<input class="oneSel" type="checkbox">
							</div>
							<div class="item_pic">
								<img src="${com.commodity.compic}">
							</div>
							<div class="item_info">
								<input id="comid" type="hidden" value="${com.commodity.comid}" />
								<c:out value="${com.commodity.comname}" />
							</div>
							<div class="item_price">
								<fmt:formatNumber pattern="#.##" value="${com.commodity.price}" minFractionDigits="2" />
							</div>
							<div class="item_num">
								<input class="num" type="number" min="1" max="999" step="1" value="${com.num}" onchange="numChange(this)" />
							</div>
							<div class="item_total">
								<fmt:formatNumber pattern="#.##" value="${com.commodity.price*com.num}" minFractionDigits="2" />
							</div>
							<div class="item_op">
								<a class="oneDel">删除</a>
							</div>
						</div>																						
					</c:if>
				</c:forEach>
			</div>
		</div>
	</c:forEach>
	
	<div class="bottom_bar">
		<div class="bottom_allsel">
			<input class="allSel" type="checkbox" />
			全选
		</div>
		<div class="bottom_del">
			<a id="batchDel">删除</a>
		</div>
		<div class="bottom_selected">
			已选商品&nbsp;<span>0</span>&nbsp;件
		</div>
		<div class="bottom_total">
			合计：<span>¥</span><span>0.00</span>
		</div>
		<div class="bottom_btn">
			<button id="checkout" class="btn btn-primary btn-lg" disabled>结算</button>
		</div>
	</div>
	
	<!--
	<div style="height:200px;">
	</div>
	---------------------<br>
	<c:forEach var="seller" items="${sellerlist}">
		卖家id:<c:out value="${seller.id}" /><br>
		卖家名:<c:out value="${seller.name}" /><br>
		商品列表:	
		<c:forEach var="com" items="${comlist}">
			<c:if test="${com.commodity.sellerid==seller.id}">
				comid=<c:out value="${com.commodity.comid}" />,
				comname=<c:out value="${com.commodity.comname}" />,
				price=<c:out value="${com.commodity.price}" />,
				num=<c:out value="${com.num}" />,
				total=<c:out value="${com.commodity.price*com.num}" /><br>
			</c:if>
		</c:forEach>
		-------------<br>
	</c:forEach>
	 -->
	
	<script>
	
		//数量变化
		function numChange(ts) {
			var num=$(ts).val();//修改后的数量
			var price=$(ts).parents('.item_num').prev().text();//单价
			var total=num*price;//总价
			$(ts).parents('.item_num').next().text(total.toFixed(2));//修改前台显示
			update();
			//修改后台
			var comid=$(ts).parents('.item_num').siblings('.item_info').children("#comid").val();
			$.ajax({
				url: '${ctx}/shoppingcart/updateNum',
				type: 'post',
				data: {'buyerid':'${bid}','comid':comid,'num':num}
			});
		}
		
		function update() {//更新数据状态
 			var comlist=$('.item_content');//商品列表
			var selNum=0;//已选商品数目
			var total=0;//合计
			var price=0;//单价
			var num=0;//数量
			$(comlist).each(function(){
				var cb=$(this).children('.item_onesel').find('.oneSel').get(0).checked;
				if(cb==true) {//复选框被勾选
					 price=$(this).children('.item_price').text();
					 num=$(this).children('.item_num').find('input:last').val();;
					 total+=price*num;
					 selNum++;
				}
			});
			if(selNum!=0) {
				$('.bottom_btn #checkout').removeAttr("disabled");
			}else {
				$('.bottom_btn #checkout').attr("disabled","");
			}
			var bSelNum=$('.bottom_selected').find('span');//更新选择数
			var bTotal=$('.bottom_total').find('span:last');//更新合计
			bSelNum.text(selNum);
			bTotal.text(total.toFixed(2));
		}
		
		//全选
		function allSel(ts) {
			var acb=$('input[type="checkbox"]');
			if(ts.checked==true) {
				$(acb).each(function(){
					if(this!=ts) {
						this.checked=true;
					}			
				});
			}else {
				$(acb).each(function(){
					if(this!=ts) {
						this.checked=false;
					}			
				});				
			}
		}
		
		//部分选
		function partSel(ts) {
			var partCb=$(ts).parents('.outer').find('input[type="checkbox"]');
			if(ts.checked==true) {
				$(partCb).each(function(){
					if(this!=ts) {
						this.checked=true;
					}
				});
			}else{
				$(partCb).each(function(){
					if(this!=ts) {
						this.checked=false;
					}
				});				
			}
		}
		
		//单选
		function oneSel(ts) {
			var cb=$(ts).parents('.item_outer').find('input[type="checkbox"]');
			var isASel=true;
			$(cb).each(function(){
				if(this.checked==false) {
					isASel=false;
				} 
			});
			var fcb=$(ts).parents('.outer').find('.partSel').get(0);
			fcb.checked=isASel;
		}
		
		//单选和部分选后检查全选
		function check() {
 			var comlist=$('.item_content');//商品列表
 			var isASel=true;
			$(comlist).each(function(){
				var cb=$(this).children('.item_onesel').find('.oneSel').get(0).checked;
				if(cb==false) {
					isASel=false;
				}
			});
			$('.allSel').each(function(){
				this.checked=isASel;
			});
		}
		
		function pIsSel(ts) {//判断卖家列表下是否有商品被选
			var part=$(ts).find('.item_content');
			var isSel=false;
			$(part).each(function(){
				var cb=$(this).children('.item_onesel').find('.oneSel').get(0).checked;
				if(cb==true) {
					isSel=true;
				}
			});
			return isSel;
		}
		
		//结算购物车
		function checkOut() {
			$.confirm({
				icon: 'fa fa-cart-arrow-down',
				title: false,
				content: '确认结算吗？',
				confirmButton: '确定',
				cancelButton: '关闭',
				theme: 'black',
				animation: 'rotateY',
				closeIcon: true,
				confirm: function() {
					 $.dialog({
						 theme: 'black',
						 title: '<i class="fa fa-spinner fa-spin"></i>',
						 closeIcon: true,
						 backgroundDismiss: true,
						 //content: 'url:${ctx}/commodity/buy?buyerid='+buyerid+'&comid='+comid+'&num='+num,
						 content: 'url:${ctx}/commodity/waiting',
						 contentLoaded: function(data,status,xhr) {
							 var self=this;
							 setTimeout(function(){
								var outer=$('.outer');		
								var dataArr=[];
								$(outer).each(function(){
									if(pIsSel(this)) {//有商品被选
										var buyerid='${bid}';
										var sellerid=$(this).children('.seller_info').find('#sellerid').val();
										var part=$(this).find('.item_content');
										var comArr=[],numArr=[],total=0,comid,num;
										$(part).each(function(){
											var cb=$(this).children('.item_onesel').find('.oneSel').get(0).checked;
											if(cb==true) {
												comid=$(this).children('.item_info').find('#comid').val();
												num=$(this).children('.item_num').find('input:last').val();
												comArr.push({"comid":comid,"num":num});
												//comidArr.push(comid);
												//numArr.push(num);
												total+=parseFloat($(this).children('.item_total').text());
											}
										});
										//var data='{buyerid:"'+buyerid+'",sellerid:"'+sellerid+'",comidArr:"'+comidArr+'",numArr:"'+numArr+'",total:"'+total.toFixed(2)+'"}';
										var data={"buyerid":buyerid,"sellerid":sellerid,"cominfo":comArr,"total":total.toFixed(2)};
										dataArr.push(data);
									}
									//console.log(this);
								});
								var content=null,title=null;
								$.ajax({
									url: '${ctx}/shoppingcart/checkout',
									type: 'post',
									async: false,
									//data: {'buyerid':'${bid}','comidArr':comidArr,'numArr':numArr,'total':total},
									data: JSON.stringify(dataArr),
									//dataType: 'json',
									contentType: "application/json;charset=utf-8",
									//traditional: true,
									success: function() {
										content='结算成功!';
										title='<i class="fa fa-check"></i>';										
										console.log('checkout success');
									},
									error: function() {
										content='结算失败!';
										title='<i class="fa fa-close"></i>'										
										console.log('checkout error');
									}
								});			
								batchDel();//批量删除
								self.setContent(content);
								self.setTitle(title);
							 },1500);
						 }
					 });					
				}
			});			
			/*
			var comlist=$('.item_content');
			//var comArr=[];
			var comidArr=[];
			var numArr=[];
			var total=$('.bottom_total').children('span:last').text();//订单总额
			//var comidArr=[];//购买列表id
			//var numArr=[];//购买数量列表
			var isSel,comid,num;			
			$(comlist).each(function(){
				isSel=$(this).children('.item_onesel').find('.oneSel').get(0).checked;
				if(isSel) {//如果商品被勾选
					comid=$(this).children('.item_info').find('#comid').val();
					num=$(this).children('.item_num').find('input:last').val();
					//comArr.push('{"comid":'+comid+',"num":'+num+'}');					
					comidArr.push(comid);
					numArr.push(num);					
				}
			});
			*/
			/*
			$.confirm({
				 icon: 'fa fa-share',
				 title: false,
				 content: '确定结算？',
				 confirmButton: '是',
				 cancelButton: '否',
				 theme: 'black',
				 animation: "rotateY",
				 closeIcon: false,
				 confirm: function() {
					 var buyerid='${bid}';
					 var comid=$('#modal_comid').val();
					 var num=numerictextbox.value();
					 $.dialog({
						 theme: 'black',
						 title: '<i class="fa fa-spinner fa-spin"></i>',
						 closeIcon: true,
						 backgroundDismiss: true,
						 content: 'url:${ctx}/commodity/buy?buyerid='+buyerid+'&comid='+comid+'&num='+num,
						 contentLoaded: function(data,status,xhr) {
							 var self=this;
							 setTimeout(function(){
								 self.setContent('successs');
								 self.setTitle('<i class="fa fa-check"></i>');
							 },1500);
						 }
					 });
					 
				 }
			});
			*/
		}
		//外层删除
		function outerDel() {
			var outer=$('.outer');//所有父层
			$(outer).each(function(){
				var num=$(this).find('.item_content').length;
				if(num==0) {//没有子层
					$(this).remove();
				}
			});
		}		
		//单项删除
		function oneDel(ts) {
			$.confirm({
				icon: 'fa fa-trash',
				title: false,
				content: '确认要删除该商品吗？',
				confirmButton: '确定',
				cancelButton: '关闭',
				theme: 'black',
				animation: 'rotateY',
				closeIcon: true,
				confirm: function() {
					/*
					var parent=$(ts).parents('.outer');//父层级
					var num=$(parent).find('.item_content').length;//子层级个数
					if(num==1) {//子层级只有一个
						parent.remove();					
					}else {
						var del=$(ts).parents('.item_content');
						del.remove();						
					}
					*/
					$(ts).parents('.item_content').remove();										
					outerDel();
					update();
					var buyerid='${bid}';
					var comid=$(ts).parent('.item_op').siblings('.item_info').children('#comid').val();
					var dt=[{"buyerid":buyerid,"comid":comid}];
					$.ajax({
						url: '${ctx}/shoppingcart/delete',
						type: 'post',
						data: JSON.stringify(dt),
						contentType: 'application/json;charset=utf-8',
						success: function() {
							console.log('success');
						},
						error: function() {
							console.log('error');
						}
					});
				}
			});

		}
		//批量删除
		function batchDel() {			
			var comlist=$('.item_content');
			var delArr=[];
			var dt=[];
			var buyerid='${bid}';
			var delNum=0;
			$(comlist).each(function(){
				var isCheck=$(this).find('.oneSel').get(0).checked;
				if(isCheck==true) {
					delArr.push(this);
					var comid=$(this).find('#comid').val();
					dt.push({'buyerid':buyerid,'comid':comid});
					delNum++;
				}
			});
			if(delNum!=0) {
				$(delArr).remove();
				outerDel();
				update();
				$.ajax({
					url: '${ctx}/shoppingcart/delete',
					type: 'post',
					data: JSON.stringify(dt),
					contentType: 'application/json;charset=utf-8',
					success: function() {
						console.log('success');
					},
					error: function() {
						console.log('error');
					}
				});
			}			
		}		
		function batchDelConfirm(){
			$.confirm({
				icon: 'fa fa-trash',
				title: false,
				content: '确认要删除这些商品吗？',
				confirmButton: '确定',
				cancelButton: '关闭',
				theme: 'black',
				animation: 'rotateY',
				closeIcon: true,
				confirm: function() {
					batchDel();
				}
			});
		}
		$(document).ready(function(){
			
			var numerictextbox=$('.num').kendoNumericTextBox({
				format: 'n0'
			}).data("kendoNumericTextBox");
			
			$('.allSel').on('click',function(){//全选
				allSel(this);
				update();
			});
			
			$('.partSel').on('click',function(){//部分选
				partSel(this);
				check();
				update();
			});
			
			$('.oneSel').on('click',function(){//单选
				oneSel(this);
				check();
				update();
			});
			
			$('#checkout').on('click',function(){//结算
				checkOut();
			});
			
			$('.oneDel').on('click',function(){//单项删除
				oneDel(this);
			});
			
			$('#batchDel').on('click',function(){//批量删除
				batchDelConfirm();
			});
		});
	</script>
        
</body>
</html>