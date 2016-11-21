<!--- Handler for address checker form --->

<cfsavecontent variable="JsScripts">
	<script type="text/javascript" src="/sandbox/js/addressForm.js"></script>
</cfsavecontent>
<cfhtmlhead text="#JsScripts#">

<cfinclude template="../views/addressFormView.cfm" />      

