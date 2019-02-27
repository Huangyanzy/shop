<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>注册</title>
	<link href="${ctx}/resources/css/kendoUI/kendo.common.min.css" rel="stylesheet">
	<link href="${ctx}/resources/css/kendoUI/kendo.bootstrap.min.css" rel="stylesheet">
	<link href="${ctx}/resources/css/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="${ctx}/resources/css/mycss/register.css" rel="stylesheet" >
    <script src="${ctx}/resources/js/lib/jquery-2.1.4.min.js"></script>
    <script src="${ctx}/resources/js/lib/kendoUI/kendo.all.min.js"></script>
    <script src="${ctx}/resources/css/bootstrap/js//bootstrap.min.js"></script>
    <script src="${ctx}/resources/utils/supersized/supersized.3.2.7.min.js"></script>
    <script src="${ctx}/resources/utils/supersized/supersized-init.js"></script>    
	<style type="text/css">
		/*
 		#bg {
			background-image: url('${ctx}/resources/images/login/3.jpg');
	    	background-size: 100% 100%;
	    	background-repeat: no-repeat;
		}
		body {		
			background: url('${ctx}/resources/images/login/3.jpg') 50% 50% / cover no-repeat fixed;
		}
		 */
	</style>    			  
</head>
<body>
	<!-- 阴影 -->
	<div id="shadow">
		<!-- 登录按钮 -->
		<div id="log_btn">
			<a href="${ctx}/login" class="btn btn-success">登录</a>
		</div>
		<!-- 注册表单 -->
		<div id="reg_form">
			<form action="${ctx}/login/user_register" method="POST">
				<div class="form-group">
				  <label>用户名</label><font class="required">&nbsp;*</font>
				  <input type="text" class="form-control" id="username" name="username" placeholder="Name" required>
				  <p id="nameval" style="color:red;display:none;font-size:16px;"></p>
				</div>
				
				<div class="form-group">
				  <label>密码</label><font class="required">&nbsp;*</font>
				  <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
				</div>
				
				<div class="form-group">
				  <label>确认密码</label><font class="required">&nbsp;*</font>
				  <input type="password" class="form-control" id="repassword" name="repassword" placeholder="Repeat Password" required>
				  <p id="pwval" style="color:red;display:none;font-size:16px;"></p>
				</div>
				
				<div class="form-group">
				  <label>用户类型</label><font class="required">&nbsp;*</font><br>
				  <label class="radio-inline"><input type="radio" name="usertype" value="buyer" checked> 买家</label>
					<label class="radio-inline"><input type="radio" name="usertype" value="seller"> 卖家</label>
				</div>
						  	  
				<div class="form-group">
				  <label>邮箱</label><font class="required">&nbsp;*</font>
				  <input type="email" class="form-control" name="email" placeholder="Email" required>
				</div>
				
				<div class="form-group">
				  <label>手机</label>
				  <input type="tel" class="form-control" name="phone" placeholder="Phone">
				</div>	  
				
				<div class="form-group">
				  <label>地址</label>
				  <input type="text" class="form-control" name="address" placeholder="Address">
				</div>
				
				<input type="hidden" name="userpic" value="${ctx}/resources/images/user/0.png">
										  		 
				<div class="form-group">
					<button type="reset" class="btn btn-danger">重置</button>
					<button type="submit" id="reg_btn" class="btn btn-primary">注册</button>
				</div>	
			</form> 
		</div>
	</div>		
	
	<script>
		$(document).ready(function(){
			var subflag1=true;
			var subflag2=true;
			/* 判断用户名是否存在 */
			var uname=$("#username");
 			uname.blur(function(){
 				var nameval=$("#nameval");
 				if($.trim(uname.val())!="") {
	 				$.ajax({
						type:"GET",
						url:"${ctx}/login/regval",
	  					data:{'username':uname.val()},
	  					dataType:"json",
						async:true,
						success:function(ret) {
							if(ret.exist=="true"){
								nameval.html("该用户名已注册")
								nameval.css("display","block");
								subflag1=false;
							}else {
								nameval.css("display","none");
								subflag1=true;
							}
						},
						error:function() {
							alert("request error");
						}
					});
 				}
			});
			/* 判断密码是否一致 */
			var repas=$("#repassword");
			repas.blur(function(){
				var pas=$("#password");
				var pwval=$("#pwval");
				if(repas.val()!=pas.val()) {
					pwval.html("两次输入密码不一致");
					pwval.css("display","block");
					subflag2=false;
				}else {
					pwval.html("");
					pwval.css("display","none");
					subflag2=true;
				}
				
			});
			/* 判断注册表单是否可以成功提交 */
 			$("#reg_btn").click(function(){
				$("form").submit(function(){
					if(subflag1==false||subflag2==false) {
						return false;
					}else {
						alert("注册成功");
						return true;
					}					
				});
			}); 
		}); 
	</script>
</body>
</html>
