<!--- Service to contain logic. This checks the array for a pivot index. --->

<cfparam name="form.arrayFld" default="" />

<!--- get an cfc instance --->
<cfset pivotArrayObj = new sandbox.cfcs.PivotArray() />

<!--- check valid list --->
<cfset response = pivotArrayObj.isListOfNumbers(form.arrayFld) />
<cfif response.success>
	<!--- convert to array and check for pivot index --->
	<cfset theArray = listToArray(trim(form.arrayFld)) />
	<cfset response = pivotArrayObj.isPivotArray(theArray) />
</cfif>
