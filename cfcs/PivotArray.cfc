<cfcomponent 
	extends="BaseAPI" 
	output="false"
	hint="Provides functionality to check if a list or array has a 'pivot' index.">

	<cffunction 
		name="isListOfNumbers"
		access="public"
		returntype="struct"
		output="false"
		hint="Test if a string is a valid list of numbers. Returns a BaseAPI struct {success, errors[], data}">

		<cfargument name="testList" type="string" required="true" hint="A string to check for is a CF list" />
		<cfset var response = this.GetNewResponse() />

		<!--- Check 1 - Check field is not null --->
		<cfif !Len(Trim(arguments.testList))>
			<cfset response.success = false />
			<cfset ArrayAppend(response.errors, "Please enter some data in the field above.") />
		</cfif>

		<!---Check 2 - The only characters allowed are commas and numbers--->
		<cfif !IsValid("Regex",arguments.testList,"[\d,]*")>
			<cfset response.success = false />
			<cfset ArrayAppend(response.errors, "The array can only contain commas and numbers please.") />
		</cfif>

		<cfreturn response />
	</cffunction>


	<cffunction
		name="isPivotArray"
		access="public"
		returntype="struct"
		output="false"
		hint="Test if an array has a 'pivot' index. A pivot index is one where the values before and after it sum to the same value. For example, '3,2,3,15,1,7' has a pivot index of 15.  Returns a BaseAPI struct {success, errors[], data}."
		>
		
		<cfargument name="testArray" type="array" required="true" />

		<cfset var response = this.GetNewResponse() />
		<cfset response.data.isPivotArray = false />

		<cfset var i = 0 /> <!--- loop index --->
		<cfset var arraySliceA = arrayNew(1) />
		<cfset var arraySliceB = arrayNew(1) />

		<!--- Check 1 - Check array has more than one item --->
		<cfif ArrayLen(arguments.testArray) eq 1>
			<cfset response.success = false />
			<cfset ArrayAppend(response.errors, "Please enter a comma seperated list of more than one number, eg, 1,2,3,10,3,2,1") />
		
		<!---Check 2 - Check array has more than 2 items then it's too small so cannot be a pivot array --->
		<cfelseif ArrayLen(arguments.testArray) eq 2>
			<cfset response.success = false />
			<cfset ArrayAppend(response.errors, "An array cannot have a pivot index unless it has at least 3 values.") />
		</cfif>

		<cfif response.success>
			<!--- We have an array of more than 3 numbers. Test for pivot --->
			<cfloop from="1" to="#arrayLen(arguments.testArray)#" index="i">
				<cfif i gt 1 and i lt ArrayLen(arguments.testArray)>
					<cfset arraySliceA = ArraySlice(arguments.testArray, 1, i - 1) />
					<cfset arraySliceB = ArraySlice(arguments.testArray, i + 1) />
					<cfif ArraySum(arraySliceA) eq ArraySum(arraySliceB)>
						<cfset response.data.isPivotArray = true />
						<cfset response.data.result = "This array has a pivot around item #i# (value #arguments.testArray[i]#)." />
						<cfbreak>
					</cfif>
				</cfif>
			</cfloop>
		</cfif>

		<!--- return the list cleaned up without any null elements --->
		<cfset response.data.testList = arrayToList(arguments.testArray)>

		<cfreturn response />

	</cffunction>

</cfcomponent>