<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html>
<title><tiles:insertAttribute name="title" ignore="true" /></title>
<head>
<tiles:insertAttribute name="header"  />
<script type="text/javascript">
	var myLayout;

	$(document).ready(function() {
		myLayout = $('body').layout({
			north__minSize : 90,
			spacing_open : 0

		});

	});
</script>
</head>
<body>

	<div class="ui-layout-north" style="border: 0; padding-left: 30px; padding-top: 20px">
			<tiles:insertAttribute name="top" />

	</div>

<!-- 	<div class="ui-layout-west" style="border: 0;background-color:#f5f5f5"> -->
<%-- 	<tiles:insertAttribute name="left" /> --%>
<!-- <!-- 		West --> -->
<!-- <!-- 		<p> --> -->
<!-- <!-- 			<button onclick="myLayout.close('west')">Close Me</button> --> -->
<!-- <!-- 		</p> --> -->
<!-- 	</div> -->

<!-- 	<div class="ui-layout-south" style="border: 0;background-color:#f5f5f5"> -->
<%-- 	<tiles:insertAttribute name="foot" /> --%>
<!-- <!-- 		South --> -->
<!-- <!-- 		<p> --> -->
<!-- <!-- 			<button onclick="myLayout.toggle('north')">Toggle North Pane</button> --> -->
<!-- <!-- 		</p> --> -->
<!-- 	</div> -->

<!-- 	<div class="ui-layout-east" style="border: 0;background-color:#f5f5f5"> -->
<%-- 	<tiles:insertAttribute name="right" /> --%>
<!-- <!-- 		East --> -->
<!-- <!-- 		<p> --> -->
<!-- <!-- 			<button onclick="myLayout.close('east')">Close Me</button> --> -->
<!-- <!-- 		</p> --> -->

<!-- 	</div> -->

	<div class="ui-layout-center" style="padding: 0px;border: 0;background-color:#f5f5f5">
		<tiles:insertAttribute name="body" />
		
	</div>

</body>
</html>