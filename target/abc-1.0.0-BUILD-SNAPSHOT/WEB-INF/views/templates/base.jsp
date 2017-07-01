<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html>
<title><tiles:insertAttribute name="title" ignore="true" /></title>
<head><tiles:insertAttribute name="header"  /></head>
<body>

	<div class="ui-layout-north" style="border: 0; padding-left: 30px; padding-top: 20px">
			<tiles:insertAttribute name="top" />

	</div>

	<div class="ui-layout-west" style="border: 0;background-color:#f5f5f5">
	<tiles:insertAttribute name="left" />
<!-- 		West -->
<!-- 		<p> -->
<!-- 			<button onclick="myLayout.close('west')">Close Me</button> -->
<!-- 		</p> -->
	</div>

	<div class="ui-layout-south" style="border: 0;background-color:#f5f5f5">
	<tiles:insertAttribute name="foot" />
<!-- 		South -->
<!-- 		<p> -->
<!-- 			<button onclick="myLayout.toggle('north')">Toggle North Pane</button> -->
<!-- 		</p> -->
	</div>

	<div class="ui-layout-east" style="border: 0;background-color:#f5f5f5">
	<tiles:insertAttribute name="right" />
<!-- 		East -->
<!-- 		<p> -->
<!-- 			<button onclick="myLayout.close('east')">Close Me</button> -->
<!-- 		</p> -->

	</div>

	<div class="ui-layout-center" style="border: 0;background-color:#f5f5f5">
		<tiles:insertAttribute name="body" />
		
	</div>

</body>
</html>