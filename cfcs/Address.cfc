<cfcomponent extends="BaseAPI" output="false"
	hint="Contains methods regarding postal addresses">
	<!--- Test comment --->
	<!--- cfc level constant variables --->
	<cfset variables.addressLookupServiceUrl = 'https://api.getaddress.io/v2/uk'>
	<cfset variables.apiKey = '4g9yrpu8uU-yr53wuLmUnQ6435'>

	<!--- Method to find an address given house number and post code. --->
	<!--- Uses getAddress.io API. For documentation see: https://getaddress.io/Documentation --->
	<cffunction
		name="LookupAddress"
        access="remote"
		returntype="struct"
        returnformat="json"
        output="false"
		hint="Finds an address for house number and post code. Returns a BaseAPI struct {success, errors[], data{}}"
		description="Uses address finder API https://getaddress.io">

		<cfargument name="houseNum" type="string" required="true" hint="house number" />
		<cfargument name="postCode" type="string" required="true" hint="valid UK postcode" />

		<cfset var response = this.GetNewResponse() /> <!--- response returned by this method --->
		<cfset var urlToSend = "" />
		<cfset var cfhttpResponse = structNew() />
		<cfset var addressCheckerReturnStruct = structNew() />
		<cfset var returnAddress = structNew() />

		<!--- NB. For a complete solution and security one would validate arguments server side (houseNum and postCode) --->

		<!--- Example call: https://api.getaddress.io/v2/uk/CF241QX/2?api-key=4g9yrpu8uU-yr53wuLmUnQ6435 --->
		<cfset urlToSend = addressLookupServiceUrl
			& "/" & UrlEncodedFormat(arguments.postCode)
			& "/" & UrlEncodedFormat(arguments.houseNum)
			& "?api-key=" & apiKey />

		<cfhttp url="#urlToSend#" method="get" result="cfhttpResponse" />

		<!--- Check for a successful 200 HTTP status code and handle errors --->
		<cftry>
			<cfswitch expression="#cfhttpResponse.responseHeader.status_code#">
				<cfcase value="400">
					<cfset response.success = false />
					<cfset ArrayAppend(response.errors, "Post code not recognised as a valid UK post code (status 400).") />
				</cfcase>
				<cfcase value="401">
					<cfset response.success = false />
					<cfset ArrayAppend(response.errors, "The address service lookup is not available - invalid key (status 401).") />
				</cfcase>
				<cfcase value="404">
					<cfset response.success = false />
					<cfset ArrayAppend(response.errors, "No addresses found for this postcode (status 404).") />
				</cfcase>
				<cfcase value="429">
					<cfset response.success = false />
					<cfset ArrayAppend(response.errors, "The address service lookup is not available - allowed limit exceeded (status 429).") />
				</cfcase>
				<cfcase value="500">
					<cfset response.success = false />
					<cfset ArrayAppend(response.errors, "The address service lookup is not available (status 500).") />
				</cfcase>
			</cfswitch>

			<cfcatch>
				<cfset response.success = false />
				<cfset ArrayAppend(response.errors, "The address service lookup cannot be reached.") />
			</cfcatch>
		</cftry>

		<cfif response.success> <!--- no errors yet --->
			<!--- deserialize JSON response to a CF struct --->
			<cfset addressCheckerReturnStruct = DeserializeJSON(cfhttpResponse.fileContent) />

			<!--- Check "Addresses" array for more than one address returned. If so display "too many addresses" error --->
			<!--- For full functionality one would return a list of addresses to the form for the user to select which one they wanted. --->
			<cfif ArrayLen(addressCheckerReturnStruct.addresses) eq 1>
				<!--- we have a winner - a single address! --->
				<!--- 'addresses' is a one item array containing a 7 item csv list containing address fields. Format as a nice useable struct --->
				<cfset returnAddress.line1 = ListGetAt(addressCheckerReturnStruct.addresses[1],1) />
				<cfset returnAddress.line2 = ListGetAt(addressCheckerReturnStruct.addresses[1],2) />
				<cfset returnAddress.line3 = ListGetAt(addressCheckerReturnStruct.addresses[1],3) />
				<cfset returnAddress.line4 = ListGetAt(addressCheckerReturnStruct.addresses[1],4) />
				<cfset returnAddress.locality = ListGetAt(addressCheckerReturnStruct.addresses[1],5) />
				<cfset returnAddress.city = ListGetAt(addressCheckerReturnStruct.addresses[1],6) />
				<cfset returnAddress.county = ListGetAt(addressCheckerReturnStruct.addresses[1],7) />

				<!--- add to response structure to be returned --->
				<cfset response.data = returnAddress />

			<cfelse>
				<!--- error: multiple addresses --->
				<cfset response.success = false />
				<cfset ArrayAppend(response.errors, "More than one address returned. Please try a different post code/house number.") />
			</cfif>

		</cfif>

		<cfreturn response />
	</cffunction>


	<cffunction
		name="SaveAddress"
        access="remote"
		returntype="struct"
        returnformat="json"
        output="false"
		hint="Persists an address to the session scope. Returns a BaseAPI struct {success, errors[], data{}}">

		<cfargument name="personName" type="string" required="true" hint="person's name" />
		<cfargument name="dob" type="string" required="true" hint="date of birth" />
		<cfargument name="houseNum" type="string" required="true" hint="house number" />
		<cfargument name="postCode" type="string" required="true" hint="valid UK postcode" />
		<cfargument name="street1" type="string" required="true" hint="first line of street address" />
		<cfargument name="street2" type="string" required="false" default="" hint="second line of street address" />
		<cfargument name="street3" type="string" required="false" default="" hint="third line of street address" />
		<cfargument name="street4" type="string" required="false" default="" hint="fourth line of street address" />
		<cfargument name="locality" type="string" required="true" hint="locality" />
		<cfargument name="city" type="string" required="true" hint="town or city" />
		<cfargument name="county" type="string" required="true" hint="county" />

		<!--- For a complete solution and security one would validate arguments server side --->

		<cfset var response = this.GetNewResponse() /> <!--- response returned by this method --->

		<cftry>
			<cfset ArrayAppend(session.addresses,arguments) />
			<cfset response.data = arguments />
			<cfcatch>
				<cfset response.success = false />
				<cfset ArrayAppend(response.errors, "Error accessing the session scope. Address not saved.") />
			</cfcatch>
		</cftry>

		<cfreturn response />

	</cffunction>


	<cffunction
		name="GetAddresses"
        access="remote"
		returntype="struct"
        returnformat="json"
        output="false"
		hint="Retrieves an array of all persisted addressed address (in the session). Returns a BaseAPI struct {success, errors[], data{}}">

		<cfset var response = this.GetNewResponse() /> <!--- response returned by this method --->

		<cftry>
			<cfset response.data = session.addresses />
			<cfcatch>
				<cfset response.success = false />
				<cfset ArrayAppend(response.errors, "Error accessing the session scope. Addresses not retrieved.") />
			</cfcatch>
		</cftry>

		<cfreturn response>
	</cffunction>


</cfcomponent>