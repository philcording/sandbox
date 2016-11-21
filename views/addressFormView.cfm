<h2>Address Finder</h2>

<div>
	<p>
		This form can be used to lookup an address
	</p>
</div>

<form name="addressFrm" id="address-form">	

	<p class="mandatory-legend">Fields marked with an asterix(*) are mandatory.</p>

	<fieldset>
		<legend>Enter personal details</legend>

		<!--- Person name --->
		<div>
			<label for="personName">Name: *</label>
			<input type="text" name="personName" tabindex="1" autocomplete="off" autofocus="autofocus" placeholder="Firstname Lastname"  />
		</div>

		<!--- dob --->
		<div>
			<label for="dob">Date of birth: *</label>
			<input type="text" name="dob" tabindex="2" autocomplete="off" placeholder="dd/mm/yyyy" />
		</div>

		<!--- house number --->
		<div>
			<label for="houseNum">House number: *</label>
			<input type="text" name="houseNum" tabindex="3" autocomplete="off" placeholder="eg 18" />
		</div>

		<!--- post code --->
		<div>
			<label for="postCode">Post code: *</label>
			<input type="text" name="postCode" tabindex="4" autocomplete="off" placeholder="eg AA12 3BC" />
		</div>

		<!--- submit button (lookup postcode) --->
		<div>
			<label for="submitPostcode">&nbsp</label>
			<input type="submit" value="find address" name="submitPostcode" tabindex="5" />
		</div>

		<div id="address-detail-fields" class="hidden">
			<!--- Street 1 --->
			<div>
				<label for="street1">Street 1: </label>
				<input type="text" name="street1" autocomplete="off" />
			</div>
	
			<!--- Street 2 --->
			<div>
				<label for="street2">Street 2: </label>
				<input type="text" name="street2" autocomplete="off" />
			</div>
	
			<!--- Street 3 --->
			<div>
				<label for="street3">Street 3: </label>
				<input type="text" name="street3" autocomplete="off" />
			</div>
	
			<!--- Street 4 --->
			<div>
				<label for="street4">Street 4: </label>
				<input type="text" name="street4" autocomplete="off" />
			</div>
	
			<!--- locality --->
			<div>
				<label for="locality">Locality: </label>
				<input type="text" name="locality" autocomplete="off" />
			</div>
	
			<!--- city --->
			<div>
				<label for="city">Town/city: </label>
				<input type="text" name="city" autocomplete="off" />
			</div>
	
			<!--- county --->
			<div>
				<label for="county">County: </label>
				<input type="text" name="county" autocomplete="off" />
			</div>
	
			<!--- submit button (save address) --->
			<div>
				<label for="submitAddress">&nbsp;</label>
				<input type="submit" name="submitAddress" value="Save address" tabindex="6"/>
				<a id="reset-form" href="javascript:null;">reset form</a>
			</div>
		</div>

	</fieldset>
</form>

<div id="address-form-errors" class="error notification hidden">
	<h4>Error:</h4>
	<p></p>
</div>

<div id="address-list"> <!-- Address table is loaded here --></div>

