<h4>Saved Addresses</h4>
<table class="data">
	<thead>
		<tr>
			<th>Name</th>
			<th>DOB</th>
			<th>House No.</th>
			<th>Post code</th>
			<th>Street 1</th>
			<th>Street 2</th>
			<th>Street 3</th>
			<th>Street 4</th>
			<th>Locality</th>
			<th>Town/City</th>
			<th>County</th>
		</tr>
	</thead>

	<cfif !request.eventOutput.responseStruct.success>
	<div class="notification error">
		<h4>Error</h4>
		<p>Unable to retreive addresses</p>
	</div>
	<cfelseif IsDefined("request.eventOutput.responseStruct.data")>
		<tbody>
			<cfloop array="#request.eventOutput.responseStruct.data#" item="address">
				<tr>
				<cfoutput>
					<td>#address.personName#</td>
					<td>#address.dob#</td>
					<td>#address.houseNum#</td>
					<td>#address.postCode#</td>
					<td>#address.street1#</td>
					<td>#address.street2#</td>
					<td>#address.street3#</td>
					<td>#address.street4#</td>
					<td>#address.locality#</td>
					<td>#address.city#</td>
					<td>#address.county#</td>
				</cfoutput>
				</tr>
			</cfloop>
		</tbody>
	</cfif>
</table>