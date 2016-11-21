<!DOCTYPE html>
<!--- Rudimentry wiring for quick and dirty MVC handling.
 In practice one would use a framework such as ColdBox, FW/1, Model-Glue etc.
 One would also separate out the headers and footers for menus etc.
  --->
<cfsetting showdebugoutput="false">

<html>

<head>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<link rel="stylesheet" type="text/css" href="includes/css/global.css" />
	<!--- add in jQueryUI library and styles --->
	<script src="/sandbox/includes/jQuery/jquery-ui.min.js"></script>
	<link rel="stylesheet" href="/sandbox/includes/jQuery/jquery-ui.min.css">
</head>

<body>
	<div id="main-container">
		<div id="header-and-menu">
			<a href="index.cfm?event=pivotArrayForm">Test pivot array</a>
			<a href="index.cfm?event=addressFinder">Address finder</a>
			<span>ColdFusion Test - Phil Cording</span>
		</div>
	
	  <!--- query parm url.event + 'Handler' defines the handler --->
	  <cfparam name="url.event" type="string" default="pivotArrayForm" />
	  <cfset eventHandler = url.event & "Handler" />
	
	  <cfinclude template="handlers/#eventHandler#.cfm" />      
	
	</div>

</body>
</html>





