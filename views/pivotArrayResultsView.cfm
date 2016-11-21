<cfif request.eventOutput.responseStruct.success>
	<cfif request.eventOutput.responseStruct.data.isPivotArray>
		<div class="notification success">
			<p>
				<b>YES</b>, this array has a pivot index!
				<br />
				<cfoutput>#request.eventOutput.responseStruct.data.result#</cfoutput>
			</p>
		</div>	
	<cfelse>
		<div class="notification">
			<p><b>NO</b>, this array does not have a pivot index</p>
		</div>
	</cfif>

<cfelse>
	<div class="notification error">
		<h4>Error:</h4>
		<p>
			<cfloop array="#request.eventOutput.responseStruct.errors#" item="errorMessage">
				- <cfoutput>#errorMessage#</cfoutput><br />
			</cfloop>
		</p>
	</div>
</cfif>

