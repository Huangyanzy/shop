<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />	
	<title>test</title>
	<link href="${ctx}/resources/css/kendoUI/kendo.common.min.css" rel="stylesheet">
	<link href="${ctx}/resources/css/kendoUI/kendo.bootstrap.min.css" rel="stylesheet">
	<link href="${ctx}/resources/css/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="${ctx}/resources/css/mycss/login.css" rel="stylesheet" >
    <script src="${ctx}/resources/js/lib/jquery-2.1.4.min.js"></script>
    <script src="${ctx}/resources/js/lib/kendoUI/kendo.all.min.js"></script>
    <script src="${ctx}/resources/css/bootstrap/js//bootstrap.min.js"></script>
    <script src="${ctx}/resources/utils/supersized/supersized.3.2.7.min.js"></script>
    <script src="${ctx}/resources/utils/supersized/supersized-init.js"></script>	
</head>
<body>
	
	
	<%-- 	
	JSTL-EL表达式-绝对路径：${ctx} || ${pageContext.request.contextPath}	<br>
	JSP路径： <%=request.getContextPath() %> || <%=request.getSession() %> ||
			<%=request.getRequestURI() %>
	
	
 	<button onclick="tz()">按钮</button>
	<script>
		function tz() {
			window.location.href="/login"
			//window.history.back(-1);
			//window.navigate("top.jsp");
		}
	</script> 
	--%>
	
</body>
</html>