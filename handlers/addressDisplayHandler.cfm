<!--- Handler for use displaying address list. Called via AJAX --->

<cfsetting showdebugoutput="false" />

<cfinclude template="../services/getAddressesService.cfm" />

<!--- request.eventOutput is used to store data for use in views --->
<cfset request.eventOutput.responseStruct = response />

<cfinclude template="../views/addressesDisplayView.cfm" />


