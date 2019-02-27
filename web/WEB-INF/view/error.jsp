<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!doctype html>
<html lang="zh-cn">
<head>
    <title>404 Not Found</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width" />
    <style>
		body {
		    background-color: #daecee;
		}
		
		#error {
		    position: absolute;
		    top: 50%;
		    left: 50%;
		    margin-top: -303px;
		    margin-left: -303px;
		}    
	    .top-banner {
	    	background-color: #333;
	    }
		*, *:after, *:before { -webkit-box-sizing: border-box; -moz-box-sizing: border-box; box-sizing: border-box; }
		.clearfix:after{visibility:hidden;display:block;font-size:0;content:" ";clear:both;height:0}
		.clearfix{*zoom:1}
		.fl{float:left}
		.fr{float:right}
		.fl,.fr{_display:inline}
		.top-banner {
			position:absolute;
			z-index: 999;
			left:0;
			top:0;
			height:40px;
			line-height:40px;
			padding:0 30px;
			width:100%;
			font-size: 13px;
			background-color: rgba(255, 255, 255, 0.15);
			color: #fff;
			font-family: "å®‹ä½“","Microsoft Yahei","Helvetica Neue",Helvetica,Arial,sans-serif;
			font-size: 15px;
			/*text-shadow: 1px 1px 3px #333;*/
			/*box-shadow: 0 1px 0 #999;*/
		}
		.top-banner a {
			color: #fff;
			text-decoration: none;
		}
    </style>
</head>
<body>
    <div id="error">
    	<img src="${ctx}/resources/images/404.png" alt="404 page not found" id="error404-image" />
    </div>
    <div style="position:fixed;bottom:0;height:90px;width:100%">
    <div class="footer-banner" style="width:728px; margin:0 auto"></div>
	</div>
</body>
</html>
