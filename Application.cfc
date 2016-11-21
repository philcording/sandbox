<cfcomponent output="false">

	<cfset this.name = "relaywareTestWebsite" />
	<cfset this.applicationTimeout = createTimespan(0,2,0,0) />
	<cfset this.sessionManagement = true />
	<cfset this.sessionTimeout = createTimespan(0,0,20,0) />

	<!--- OnSessionStart() method --->
	<cffunction name="OnSessionStart" access="public" returntype="boolean" output="false">

		<!--- Clear the session scope --->
		<cfset StructClear(session) />

		<!--- Create the array to store addresses. This will be just an array of structs. --->
		<cfset session.addresses = [] />
        <cfreturn true />
    </cffunction>


	<!--- onRequestStart() method --->
	<cffunction name="onRequestStart" returntype="boolean" >
		<cfargument name="targetPage" type="string" required="true" />

		<!--- request.eventOutput structure used to pass any variables to the views --->
		<cfset this.eventOutput = structNew()>
		<cfreturn true />
	</cffunction>

</cfcomponent>

