<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.demo.model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%
	User user=(User)session.getAttribute("user");
	String upic=user.getUserpic();
%>
<!DOCTYPE html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
	<title>个人信息</title>
	<link href="${ctx}/resources/css/kendoUI/kendo.common.min.css" rel="stylesheet">
	<link href="${ctx}/resources/css/kendoUI/kendo.bootstrap.min.css" rel="stylesheet">
	<link href="${ctx}/resources/css/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="${ctx}/resources/utils/font-awesome/css/font-awesome.min.css" rel="stylesheet">
	<link href="${ctx}/resources/utils/jquery-confirm/dist/jquery-confirm.min.css" rel="stylesheet">	
	<link href="${ctx}/resources/css/mycss/userinfo.css" rel="stylesheet">
	<script src="${ctx}/resources/js/lib/jquery-2.1.4.min.js"></script>
	<script src="${ctx}/resources/js/lib/kendoUI/kendo.all.min.js"></script>
	<script src="${ctx}/resources/css/bootstrap/js//bootstrap.min.js"></script>
	<script src="${ctx}/resources/utils/jquery-confirm/dist/jquery-confirm.min.js"></script>	
</head>

<style>

</style>

<body>
	<!-- 个人信息修改表单 -->
	<div class="form-outer">
		<form onsubmit="return false;">
			<div id="userinfo" class="form-horizontal">
				<div class="form-group">
					<label for="email" class="col-sm-2 control-label">邮箱</label>
					<div class="col-sm-8">
						<input type="email" class="form-control" id="email" value="${email}">
					</div>
					<p id="emval" style="position:relative;top:10px;color:red;display:none;font-size:16px;">邮箱不能为空</p>
				</div>			
				<div class="form-group">
					<label for="newpass" class="col-sm-2 control-label">新密码</label>
					<div class="col-sm-8">
						<input type="password" class="form-control" id="newpass">
					</div>
				</div>
				<div class="form-group">
					<label for="renewpass" class="col-sm-2 control-label">确认密码</label>
					<div class="col-sm-8">
						<input type="password" class="form-control" id="renewpass">
						<p id="pwval" style="position:relative;top:10px;color:red;display:none;font-size:16px;">两次密码输入不一致</p>
					</div>
					
				</div>
				<div class="form-group">
					<label for="phone" class="col-sm-2 control-label">手机</label>
					<div class="col-sm-8">
						<input type="tel" class="form-control" id="phone" value="${phone}">
					</div>
				</div>
				<div class="form-group">
					<label for="address" class="col-sm-2 control-label">收货地址</label>
					<div class="col-sm-8">
						<textarea id="address" rows="3" class="form-control">${address}</textarea>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-8">					
						<button id="info_update_btn" class="btn btn-success">						
							<i class="glyphicon glyphicon-saved"></i> 更新资料
						</button>			
					</div>				
				</div>
			</div>
		</form>		
		<!-- 头像修改 -->
		<div id="avatar">
			<img class="thumbail" src="<%=upic %>">
			<input type="file" name="avatar" style="display:none">
			<button id="upload-btn" class="btn btn-default">
				<i class="glyphicon glyphicon-cloud-upload"></i> 上传头像
			</button>
		</div>
	</div>

	<span id="notification"></span>
		
	<script>
			
		function getFileName(o) {
			var pos=o.lastIndexOf("\\");
			return o.substring(pos+1);
		} 
		//动态获取通知宽度
		function notLeftWidth() {
			return 0.45*($('html').width());
		}
		
		$(document).ready(function(){
			 
			//消息提示窗口
			var notificationWidget=$("#notification").kendoNotification({
				hideOnClick: false,	
				autoHideAfter: 1500,
				//allowHideAfter: 1000,
 				position: {
					left: notLeftWidth,
					top: 0,
				}
			}).data("kendoNotification");
									
			//点击上传激活图片选项
			$("#upload-btn").click(function(){
				$("input[name=avatar]").trigger("click");
				return false;
			});
			
			//图片修改时调用请求修改图片
			$("input[name=avatar]").change(function(){
/* 				var formData=new FormData();
				formData.append('file',$('input[name=avatar]')[0].files[0]); */
 				var pic='${ctx}/resources/images/user/'+getFileName($("input[name=avatar]").val());
				if(pic!='') {
					$.ajax({
						type: 'get',
						url: '${ctx}/userinfo/upload',
						data: {"avatar":pic},
						success: function(rt) {
							var nsrc=rt.navatar;
							$(".thumbail").attr("src",nsrc);	//修改缩略图
							$('body',window.parent.document).find('#upic').attr('src',nsrc);
							//notificationWidget.show("头像修改成功","success");
							prompt('头像修改成功!');
						}, 
						error: function() {
							//notificationWidget.show("头像修改失败","error");
							prompt('头像修改失败!');
						}
					});
				}
			});	
			
			var isflag1=true;
			
			//密码输入不一致提示
			$("#renewpass").blur(function(){
				var pass1=$('#newpass').val();
				var pass2=$('#renewpass').val();
				if(pass1!=pass2) {
					$('#pwval').css('display','inline-block');
					isflag1=false;
				}else {
					$('#pwval').css('display','none');
					isflag1=true;
				}
			});
			
			$("#info_update_btn").click(function(){
				var email=$('#email').val();
				var isflag2=true;
				//如果邮箱为空，出现提示
				if($.trim(email)=='') {
					$('#emval').css('display','inline-block');
					isflag2=false;
				}else {
					$('#emval').css('display','none');
					isflag2=true;
				}
				//出现提示不能提交
				if(isflag1==false||isflag2==false) {
					return false;
				}
				var password=$('#newpass').val();
				var repass=$('#renewpass').val();
				var phone=$('#phone').val();
				var address=$('#address').val();
				//console.log(email+"*"+password+"*"+phone+"*"+address);
				if(password=="") {
					password=null;	
				}else if(repass=="") {//如果只填了一个密码
					$('#pwval').css('display','inline-block')
					return false;
				}
				var newinfo={"email":email,"password":password,"phone":phone,"address":address};
				//var newinfo=email;
				//console.log(newinfo);
 				$.ajax({
					type: 'post',					
					url: '${ctx}/userinfo/infomodify',
					data: JSON.stringify(newinfo),
					//dataType: 'json',
					contentType: 'application/json',
					success: function() {
						//notificationWidget.show("信息修改成功","success");
						prompt('信息修改成功!');
					},
					error: function() {
						//notificationWidget.show("信息修改失败","error");
						prompt('信息修改失败!');
					} 
				});
			});
			
		});
		
		function prompt(info) {//
			$.dialog({
			    title: false,
			    icon: 'fa fa-check-circle',
			    content: info,
			    confirmButton: '确定',
			    closeIcon: false,
			    theme: 'black',
			    animation: 'top',
			    backgroundDismiss: true
			});				
		}
		
	</script>
</body>
</html>