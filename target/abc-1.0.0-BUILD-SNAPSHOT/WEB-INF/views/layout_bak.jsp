<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<title>Simple Layout Demo</title>

	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/static/external/css/layout-default.css">

	<script type="text/javascript" src="<%=request.getContextPath() %>/static/external/js/jquery.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/static/external/js/jquery-ui.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/static/external/js/jquery.layout.js"></script>

	<script type="text/javascript">

	var myLayout;

	$(document).ready(function(){

		myLayout = $('body').layout({
			west__minSize:	50
		,	east__minSize:	200
		});
 
 	});

	</script>

</head>
<body>

<!-- manually attach allowOverflow method to pane -->
<div class="ui-layout-north"> North </div>

<div class="ui-layout-west">West
	<p><button onclick="myLayout.close('west')">Close Me</button></p>
</div>

<div class="ui-layout-south"> South
	<p><button onclick="myLayout.toggle('north')">Toggle North Pane</button></p>
</div>

<div class="ui-layout-east"> East
	<p><button onclick="myLayout.close('east')">Close Me</button></p>

	<p>...</p><p>...</p><p>...</p><p>...</p><p>...</p><p>...</p><p>...</p><p>...</p><p>...</p>
	<p>...</p><p>...</p><p>...</p><p>...</p><p>...</p><p>...</p><p>...</p><p>...</p><p>...</p>
	<p>...</p><p>...</p><p>...</p><p>...</p><p>...</p><p>...</p><p>...</p><p>...</p><p>...</p>
	<p>...</p><p>...</p><p>...</p><p>...</p><p>...</p><p>...</p><p>...</p><p>...</p><p>...</p>
</div>

<div class="ui-layout-center">
	This center pane auto-sizes to fit the space <I>between</I> the 'border-panes'
	<p>This layout uses default options, except for a minSize on East and West panes</p>
	<p>The Close and Toggle buttons are examples of <B>custom buttons</B></p>
	<p><a href="http://layout.jquery-dev.com/demos.cfm">UI Layout Demos page</a></p>
	<p>...</p><p>...</p><p>...</p><p>...</p><p>...</p><p>...</p><p>...</p><p>...</p><p>...</p>
	<p>...</p><p>...</p><p>...</p><p>...</p><p>...</p><p>...</p><p>...</p><p>...</p><p>...</p>
	<p>...</p><p>...</p><p>...</p><p>...</p><p>...</p><p>...</p><p>...</p><p>...</p><p>...</p>
	<p>...</p><p>...</p><p>...</p><p>...</p><p>...</p><p>...</p><p>...</p><p>...</p><p>...</p>
</div>

</body>
</html>