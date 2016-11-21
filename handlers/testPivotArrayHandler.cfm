<!--- Handler to process submit test pivot array form and display results --->

<cfinclude template="../services/checkPivotArrayService.cfm" />

<!--- request.eventOutput is used to store data for use in views --->

<cfif IsDefined("response.data.testlist")>
	<cfset request.eventOutput.arrayFld = response.data.testlist>
<cfelse>	
	<cfset request.eventOutput.arrayFld = form.arrayFld>
</cfif>
<cfset request.eventOutput.responseStruct = response>

<cfinclude template="../views/pivotArrayFormView.cfm" />

<cfinclude template="../views/pivotArrayResultsView.cfm" />

