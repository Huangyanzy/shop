<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="sid" value="${sessionScope.user.userid}"/>
<!DOCTYPE html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
	<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
	<title>营业图表</title>
	<link href="${ctx}/resources/css/kendoUI/kendo.common.min.css" rel="stylesheet">
	<link href="${ctx}/resources/css/kendoUI/kendo.bootstrap.min.css" rel="stylesheet">
	<link href="${ctx}/resources/css/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="${ctx}/resources/css/mycss/test.css" rel="stylesheet" >
    <script src="${ctx}/resources/js/lib/jquery-2.1.4.min.js"></script>
    <script src="${ctx}/resources/js/lib/kendoUI/kendo.all.min.js"></script>
    <script src="${ctx}/resources/css/bootstrap/js//bootstrap.min.js"></script>	
</head>

<body>	
	
	<div class="options">
        <input id="typeColumn" name="seriesType" type="radio" value="column" checked="checked" autocomplete="off" />
        <label for="typeColumn">柱状图</label>
        <input id="typeBar" name="seriesType" type="radio" value="bar" autocomplete="off" />
        <label for="typeBar">条形图</label>
	</div>
	<div id="chart1"></div>
	<div id="chart2"></div>	
	<script>
		var comname=[],soldNum=[];
		var time=[],total=[];
		var series1=[],series2=[];
		$(document).ready(function(){
			$.ajax({
				url: '${ctx}/commodity/listBySid',
				data: {'sid':'${sid}'},
				dataType: 'json',
				async: false,
				success: function(data) {					
					for(var i=0;i<data.length;i++) {
						comname.push(data[i].comname);
						soldNum.push(data[i].sold);
					}				
				},
				error: function() {
					console.log('error');
				}
			});
			$.ajax({
				url: '${ctx}/commodity/dayTotal',
				data: {'sid':'${sid}'},
				dataType: 'json',
				async: false,
				success: function(data) {					
					for(var i=0;i<data.length;i++) {
						time.push(data[i].time);
						total.push(data[i].total);
					}				
				},
				error: function() {
					console.log('error');
				}
			});			
	        series1.push({
	            name: "售出数量",
	            data: soldNum,
	            markers: { type: "square" },
	            color: '#428BCA'
	        });        
            $("#chart1").kendoChart({
                title: {
                    text: "商品售出情况"
                },
                legend: {
                    position: "bottom"
                },
                seriesDefaults: {
                    type: "column",
                    stack: true
                },
                series: series1,
                valueAxis: {
                    line: {
                        visible: false
                    }
                },
                categoryAxis: {
                    categories: comname,
                    majorGridLines: {
                        visible: false
                    }
                },
                tooltip: {
                    visible: true,
                    format: "{0}"
                }
            });
            $('.options').bind('change',refresh);
	        series2.push({
	            name: "日销售额",
	            data: total,
	            markers: { type: "square" },
	            color: '#428BCA'
	        });	            
            $("#chart2").kendoChart({
                title: {
                    text: "每日营业总额"
                },
                legend: {
                    position: "bottom"
                },
                seriesDefaults: {
                    type: "column",
                    stack: true
                },
                series: series2,
                valueAxis: {
                    line: {
                        visible: false
                    }
                },
                categoryAxis: {
                    categories: time,
                    majorGridLines: {
                        visible: false
                    }
                },
                tooltip: {
                    visible: true,
                    format: "{0}"
                }
            });            
			
		});
        function refresh() {
            var chart1 = $("#chart1").data("kendoChart"),
            	chart2 = $('#chart2').data("kendoChart"),
                type = $("input[name=seriesType]:checked").val();

            for (var i = 0, length = series1.length; i < length; i++) {
                series1[i].type = type;
                series2[i].type = type;
            };

            chart1.setOptions({
                series: series1
            });

            chart2.setOptions({
                series: series2
            });            
        }
	</script>
        
</body>
</html>