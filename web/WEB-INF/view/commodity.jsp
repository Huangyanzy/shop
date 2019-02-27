<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="sid" value="${sessionScope.user.userid}"/>

<!DOCTYPE html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
	<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
	<title>商品管理</title>
	<link href="${ctx}/resources/css/kendoUI/kendo.common.min.css" rel="stylesheet">
	<link href="${ctx}/resources/css/kendoUI/kendo.bootstrap.min.css" rel="stylesheet">
	<link href="${ctx}/resources/css/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="${ctx}/resources/css/mycss/test.css" rel="stylesheet" >
    <script src="${ctx}/resources/js/lib/jquery-2.1.4.min.js"></script>
    <script src="${ctx}/resources/js/lib/kendoUI/kendo.all.min.js"></script>
    <script src="${ctx}/resources/css/bootstrap/js//bootstrap.min.js"></script>	
</head>

<style>
	/* 图片添加图标 */
	.addIcon {
		height: 50px;
		width: 50px;
		cursor: pointer;
	}
</style>

<body>	

	<div style="display:none">
		<input type="text" id="search"><button id="search_btn">搜索</button>
	</div>

	<!-- 商品信息管理 -->
	<div id="grid"></div>
	<!-- 图片管理 -->
	<div id="grid2"></div>
	
	<script>	
		$(document).ready(function(){
			//商品信息管理
			var dataSource=new kendo.data.DataSource({
				transport: {
					read: {
						url: "${ctx}/commodity/listBySid",
						data: {"sid":"${sid}"},
						dataType: "json",
						type: "post"
					},
					update: {
						url: "${ctx}/commodity/update",
						dataType: "json",
						type: "post"
					},
					create: {
						url: "${ctx}/commodity/create",
						dataType: "json",
						type: "post"
					},
					destroy: {
						url: "${ctx}/commodity/delete",
						dataType: "json",
						type: "post"
					}
				},
				//batch: true,
				pageSize: 5,
				schema: {
					model: {
						id: "comid",
						fields: {
							comid: {
								editable: false,
								nullable: true
							},
							comname: {
								type:"string",
								validation:{required:true}
							},
							price: {
								type:"number",
								validation:{required:true,min:0}
							},
							stock: {
								type:"number",
								validation:{required:true,min:1}
							},
							description: {
								type:"string",
								validation:{required:true}
							},
							compic: {
								type:"string",
								//defaultValue: "1.jpg"
							},
							sold: {
								type:"number",
								defaultValue:0,
								editable: false
							},
							sellerid: {
								type:"number",
								defaultValue:"${sid}"
							}
						}
					}
				}				
			});
			var grid=$("#grid").kendoGrid({
				dataSource: dataSource,
				columns: [
							{field:"comid",title:"商品编号",width:"100px"},
							{field:"comname",title:"名称",width:"100px"},
							{field:"price",title:"价格",format:"{0:c}",width:"100px"},
							{field:"stock",title:"库存",format:"{0:n0}",width:"100px"},
							{field:"description",title:"描述",width:"200px"},
							{field:"compic",title:"图片",width:"200px", /* editor:picSelect, */ template:"<img style='height:50px;width:50px;' src='#=compic#'" },
							{field:"sold",title:"已售",format:"{0:n0}",width:"100px"},
							{command:["edit","destroy"],title:"&nbsp;",width:"250px"}
				],				
				//height: 550,
				pageable: {
					//buttonCount: 4,
					//pageSizes: [2,4,"all"]					
					refresh: true,
					input: true
				},
				resizable: true,
				toolbar: ["create"],
				editable: "inline",
				filterable: true,
				selectable: true
			}).data("kendoGrid");
			
			$('#search_btn').on('click',function(){
				$('#search').trigger('change');
			});
			$('#search').on('change',function(e){
				var comname=$('#search').val();
	    		dataSource=new kendo.data.DataSource({
					transport: {
						read: {
							url: "${ctx}/commodity/searchForComPg",
							data: {"sellerid":"${sid}","comname":comname},
							dataType: "json",
							type: "get"
						},
						update: {
							url: "${ctx}/commodity/update",
							dataType: "json",
							type: "post"
						},
						create: {
							url: "${ctx}/commodity/create",
							dataType: "json",
							type: "post"
						},
						destroy: {
							url: "${ctx}/commodity/delete",
							dataType: "json",
							type: "post"
						}
					},
					//batch: true,
					pageSize: 5,
					schema: {
						model: {
							id: "comid",
							fields: {
								comid: {
									editable: false,
									nullable: true
								},
								comname: {
									type:"string",
									validation:{required:true}
								},
								price: {
									type:"number",
									validation:{required:true,min:0}
								},
								stock: {
									type:"number",
									validation:{required:true,min:1}
								},
								description: {
									type:"string",
									validation:{required:true}
								},
								compic: {
									type:"string",
									//defaultValue: "1.jpg"
								},
								sold: {
									type:"number",
									defaultValue:0
								},
								sellerid: {
									type:"number",
									defaultValue:"${sid}"
								}
							}
						}
					}	
	    		});				
				grid.setDataSource(dataSource);
			});			
			
			//图片管理
			var dataSource2=new kendo.data.DataSource({
				transport: {
					read: {
						url: "${ctx}/commodity/listBySid",
						data: {"sid":"${sid}"},
						dataType: "json",
						type: "get"
					}
				},
				schema: {
					model: {
						id: "comid",
						fields: {
/* 							picid: {
								editable: false,
								nullable: true
							}, */
							comid: {
								editable: false
							},
							comname: {
								type:"string",
								validation:{required:true}
							}
/* 							compic: {
								type:"string",
								defaultValue: "1.jpg"
							} */
						}
					}
				}
			});
			//图片模板
			var picTem='<img class="addIcon" src="${ctx}/resources/images/commodity/+.png" onclick="selPic(this)">'+
						'<input id="filename" type="file" onchange="addPic(this)">';
			/*
			$("#grid2").kendoGrid({
				dataSource: dataSource2,
				columns: [
							{field:"comid",title:"商品编号",width:"100px"},
							{field:"comname",title:"名称",width:"200px"},
							{field:"compic",title:"图片",width:"350px", template:picTem },
				],				
				pageable: {
					pageSize: 2,
					refresh: true
				},
				resizable: true,
			});			
			*/
		});
		
		//触发添加图片的事件
		function selPic(ts) {
			//console.log($(ts).next());
			var picSel=$(ts).next();	//获取文件选择
			$(picSel).trigger('click');		//激活事件
			
		}	
		
		//添加商品图片
		function addPic(ts) {
			//console.log($(ts).val());
			var compic=getFileName($(ts).val());	//获取文件名
			//console.log(picName);			
			var comid=$(ts).parent().siblings().first().text();		//获取商品编号
			//console.log(comid);
			$.ajax({
				type: "get",
				url: "${ctx}/commodity/addPic",
				data: {"comid":comid,"compic":compic},
				success: function(rt) {
					alert('success');
				},
				error: function() {
					alert('error');
				}
			});
		}
		
		//获取文件名
		function getFileName(o) {
			var pos=o.lastIndexOf("\\");
			return o.substring(pos+1);
		}
		
		function picSelect(container,options) {
			//$('<input class="k-input k-textbox" name="'+options.field+'">').appendTo(container);
			$('<input id="filename" class="k-input k-textbox" type="text" name="'+options.field+'">').appendTo(container);
			$('<input type="file">').appendTo(container).kendoUpload({
				multiple: false,
				select: onSelect
			});
		}
		//文件选择后触发事件
		function onSelect(e) {
			$.each(e.files,function(index,value) {
				var fname=value.name;
				console.log("1: "+fname);
				console.log("2: "+$('#filename').val());
				//$('#filename').attr("value",fname);
				$('#filename').val(fname);
			});
		}
		
		
	</script>
        
</body>
</html>