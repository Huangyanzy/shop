<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@ include file="/WEB-INF/common.jsp" %> --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
	<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
	<title>登录</title>
	<link href="${ctx}/resources/css/kendoUI/kendo.common.min.css" rel="stylesheet">
	<link href="${ctx}/resources/css/kendoUI/kendo.bootstrap.min.css" rel="stylesheet">
	<link href="${ctx}/resources/css/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="${ctx}/resources/css/mycss/login.css" rel="stylesheet" >
    <script src="${ctx}/resources/js/lib/jquery-2.1.4.min.js"></script>
    <script src="${ctx}/resources/js/lib/kendoUI/kendo.all.min.js"></script>
    <script src="${ctx}/resources/css/bootstrap/js//bootstrap.min.js"></script>
    <script src="${ctx}/resources/utils/supersized/supersized.3.2.7.min.js"></script>
    <script src="${ctx}/resources/utils/supersized/supersized-init.js"></script>
    		
	<style type="text/css">
		/*
 		#bg {		
			background:url('${ctx}/resources/images/login/5.jpg');
	    	background-size: 100% 100%;
	    	background-repeat: no-repeat;
		}
		body {		
			background: url('${ctx}/resources/images/login/5.jpg') 50% 50% / cover no-repeat fixed;
		}
		*/	
	</style>
</head>
<body>
	<!--阴影  -->
	<div id="shadow">
		<!-- 注册按钮 -->
		<div id="reg_btn">
			<a href="${ctx}/register" class="btn btn-success">注册</a>
		</div>		
		<!-- 登录表单 -->
		<div id="log_form">
			<div class="form-group">
				<span class="glyphicon glyphicon-user" aria-hidden="true"></span> <label>用户名</label> 
				<input type="text" class="form-control" id="username" name="username" placeholder="Name">
				<p id="nameval" style="color:red;display:none;font-size:16px;">用户不存在</p>
			</div>
			<div class="form-group">
				<span class="glyphicon glyphicon-lock" aria-hidden="true"></span> <label>密码</label> 
				<input type="password" class="form-control" id="password" name="password" placeholder="Password">
				<p id="pwval" style="color:red;display:none;font-size:16px;">密码错误</p>
			</div>
			<div class="hehe checkbox">
				<label><input type="checkbox">记住我</label>
			</div>
			<button type="submit" id="log_btn" class="btn btn-primary">登录</button>
		</div>
	</div>
	
    <script>
    	$(document).ready(function(){
    		$("input").blur(function(){
    			$("#nameval,#pwval").css("display","none");
    		});
    		/* 登录验证 */
			$("#log_btn").click(function(){
				var uname=$("#username");
				var pass=$("#password");
				//alert(uname.val()+"*");
				if($.trim(uname.val())!=""&&$.trim(pass.val())!="") {
					$.ajax({
						url:"${ctx}/login/logval",
						type:"get",
						data:{"username":uname.val(),"password":pass.val()},
						dataType:"json",
						async:true,
						success:function(ret){
							if(ret.msg=="ok") {
								window.location.href="${ctx}/main";
							}
							else if(ret.msg=="nouser") {
								//alert("用户不存在！");
								$("#nameval").css("display","block");
							}else if(ret.msg=="pwerror") {
								//alert("密码错误！");
								$("#pwval").css("display","block");
							}
							
						},
						error:function(){
							alert("error");							
						}
					});
					
				}else {
					alert("用户名或密码不能为空!");
				}
/* 				$("form").submit(function(){
					return false;
				}); */								
			});
    	});

    </script>    
</body>
</html>