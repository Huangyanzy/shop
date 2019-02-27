<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
	<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
	<title>首页</title>
	<link href="${ctx}/resources/css/kendoUI/kendo.common.min.css" rel="stylesheet">
	<link href="${ctx}/resources/css/kendoUI/kendo.bootstrap.min.css" rel="stylesheet">
	<link href="${ctx}/resources/css/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="${ctx}/resources/utils/unslider/dist/css/unslider.css" rel="stylesheet" >
    <script src="${ctx}/resources/js/lib/jquery-2.1.4.min.js"></script>
    <script src="${ctx}/resources/js/lib/kendoUI/kendo.all.min.js"></script>
    <script src="${ctx}/resources/css/bootstrap/js//bootstrap.min.js"></script>
    <script src="${ctx}/resources/utils/unslider/dist/js/unslider-min.js"></script>
</head>

<style>
	body {
		background-color: #fff;
	}
	.outer {
	    position: relative;
	    width: 100%;
	    height: 700px;
	    text-align: center;
	    line-height: 700px;
	}
	.my-slider img {
		width: 1000px;
		height: 650px;
	}
</style>

<body>	
	<div class="outer">
		<div class="my-slider">
		    <ul>
		        <li>
		            <img src="${ctx}/resources/images/homepage/1.jpg">
		        </li>
		        <li >
		            <img src="${ctx}/resources/images/homepage/2.jpg">
		        </li>
		        <li>
		            <img src="${ctx}/resources/images/homepage/3.jpg">
		        </li>
		     </ul>
		</div>
	</div>
	<script>
		$(document).ready(function(){
			$('.my-slider').unslider({
				//animation: 'fade',
				autoplay: true,
				arrows: false,
				nav: false,
				animateHeight: true
			});
		});
	</script>
        
</body>
</html>