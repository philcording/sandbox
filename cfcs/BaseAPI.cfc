<cfcomponent
	output="false"
	hint="provides base API functionality.">

	<cffunction 
		name="GetNewResponse"
		access="public"
		returntype="struct"
		output="false"
		hint="Returns a new API response struct {success, errors[], data{}}">

		<cfset local.response = {
			success = true,
			errors = [],
			data = {}
			} />

		<!--- Return the empty response object. --->
		<cfreturn local.response />
	</cffunction>

</cfcomponent>