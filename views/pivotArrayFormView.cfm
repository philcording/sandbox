<h2>Array Pivot Index Checker</h2>
<div>
	<p>
		This function will allow you to enter an array and check to see if it has a pivot index, that is,
		<br />where the numbers either side of an element sum to the same value.
	</p>
	<p>
		Please enter a comma seperated list of numbers to test if an array has a pivot index.
		<br />For example, '3,2,3,15,1,7' has a pivot index of 15 because the values either side sum to 8. 
	</p>
</div>

<form name="arrayFrm" id="arrayFrm" method="post" action="/sandbox/index.cfm?event=testPivotArray">
	<fieldset>
		<div>
			<label for="arrayFld">Enter an array of numbers:</label>
			<cfoutput>
				<input 
					type="text" 
					name="arrayFld" 
					tabindex="1" 
					autofocus="autofocus" 
					autocomplete="off" 
					placeholder="eg 4,11,6,8,3"
					value="#request.eventOutput.arrayFld#" />
			</cfoutput>
			<input type="submit" value="Submit" tabindex="2" />
		</div>
	</fieldset>
</form>

