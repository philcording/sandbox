/* This file creates an AddressForm object, it's properties and methods, to deal with the address form */
/* It kinda works like a handler for all of the address functionality since it's all in AJAX */

$(document).ready(function(){
	// Create an instance of the address form object on doc load
	var objAddressForm = new AddressForm();

});


// Create a Javascript class to handle the address form.
function AddressForm(){
	var objSelf = this;

	// Get a jQuery reference to the form.
	this.Form = $("#address-form");

	// Get jQuery references to the key fields in our form. This way, we don't have to keep looking them up.
	this.DOMRef = {
		personName: this.Form.find("input[name='personName']"),
		dob: this.Form.find("input[name='dob']"),
		houseNum: this.Form.find("input[name='houseNum']"),
		postCode: this.Form.find("input[name='postCode']"),
		street1: this.Form.find("input[name='street1']"),
		street2: this.Form.find("input[name='street2']"),
		street3: this.Form.find("input[name='street3']"),
		street4: this.Form.find("input[name='street4']"),
		locality: this.Form.find("input[name='locality']"),
		city: this.Form.find("input[name='city']"),
		county: this.Form.find("input[name='county']"),
		submitPostcode: this.Form.find("input[name='submitPostcode']"),
		submitAddress: this.Form.find("input[name='submitAddress']")
		};

	// Bind handlers to form submits (post code lookup).
	this.DOMRef.submitPostcode.on("click",
		function( objEvent ){
			objSelf.SubmitForm(); // Submit the form via AJAX.
			return( false ); // Cancel default event.
		});

	// Bind handlers to form submits (save address).
	this.DOMRef.submitAddress.on("click",
		function( objEvent ){
			objSelf.SaveAddress(); // Submit the form via AJAX.
			return( false ); // Cancel default event.
		});
	
	// Bind the listener for the address updated event (custom event).
	$(document).bind("addressSaved",
    	function(){
        	// Get the contacts for the contact list.
        	objSelf.GetAddresses();
    	});

	$('#reset-form').on("click",
		function( objEvent ){
			objSelf.ResetForm();
			return( false ); // Cancel default event.
		});

    // Get the initial list of saved addresses
	this.GetAddresses();
}


// Function to validate mandatory form fields
AddressForm.prototype.ValidateForm = function(){
	var ret = true;	
	if(this.DOMRef.personName.val().trim().length == 0){
		ret = false;	
		this.DisplayFieldError(this.DOMRef.personName);
	}
	if(this.DOMRef.dob.val().trim().length == 0){
		ret = false;	
		this.DisplayFieldError(this.DOMRef.dob);
	}
	if(this.DOMRef.houseNum.val().trim().length == 0){
		ret = false;	
		this.DisplayFieldError(this.DOMRef.houseNum);
	}
	if(this.DOMRef.postCode.val().trim().length == 0){
		ret = false;	
		this.DisplayFieldError(this.DOMRef.postCode);
	}

	return ret;
}

// Basic display field level errors
AddressForm.prototype.DisplayFieldError = function(field){
	field.after("<span class='error'>* required</span>");
}


// Define a method to submit the form via AJAX.
AddressForm.prototype.SubmitForm = function(){
	var objSelf = this;

	$(".error").hide(); // hide any errors

	if(!this.ValidateForm()){
		return;
	};

	// Submit form via AJAX.
	$.ajax({
		type: "post",
		url: "/sandbox/cfcs/Address.cfc",
		data: {
			method: "LookupAddress",
			houseNum: this.DOMRef.houseNum.val(),
			postCode: this.DOMRef.postCode.val()
			},
		dataType: "json",

		// Define response handlers.
		success: function( objResponse ){
			// Check to see if request was successful.
			if (objResponse.SUCCESS){
				objSelf.populateForm(objResponse.DATA);
			} else {
				// The response was not successful. Show errors to the user.
				objSelf.ShowErrors( objResponse.ERRORS );
			}
		},
		
		error: function( objRequest, strError ){
			objSelf.ShowErrors([ "An unknown AJAX connection error occurred." ]);
		}
	});
}


// Define a method to populate the HTML address form
AddressForm.prototype.populateForm = function( objAddress ){
	this.DOMRef.street1.val(objAddress.LINE1);
	this.DOMRef.street2.val(objAddress.LINE2);
	this.DOMRef.street3.val(objAddress.LINE3);
	this.DOMRef.street4.val(objAddress.LINE4);
	this.DOMRef.locality.val(objAddress.LOCALITY);
	this.DOMRef.city.val(objAddress.CITY);
	this.DOMRef.county.val(objAddress.COUNTY);
	
	$("#address-detail-fields").show(400);
}


// Define a method to save the address date to the server via AJAX.
AddressForm.prototype.SaveAddress = function(){
	var objSelf = this;
	var ajaxData = "method=SaveAddress&"+this.Form.serialize();

	// hide any errors
	$(".error").hide();

	// Submit form via AJAX.
	$.ajax({
		type: "post",
		url: "/sandbox/cfcs/Address.cfc",
		data: ajaxData,
		dataType: "json",
		// Define response handlers.
		success: function( objResponse ){
			// Check to see if request was successful.
			if (objResponse.SUCCESS){
				objSelf.ResetForm();

				// Trigger the update event. This will allow anything listening for this event on the document 
				// to react to it and update a display if needed.
				$( document ).trigger( "addressSaved");

			} else {
				// The response was not successful. Show errors to the user.
				objSelf.ShowErrors( objResponse.ERRORS );
			}
		},
		error: function( objRequest, strError ){
			objSelf.ShowErrors([ "An unknown AJAX connection error occurred." ]);
		}
	});
}


// Define a method to get the stored addresses.
AddressForm.prototype.GetAddresses = function(objAddresses){
	// Get addresses via AJAX and load into container
	$("#address-list").load("/sandbox/handlers/addressDisplayHandler.cfm");
};



// Define a method to help display form level errors.
AddressForm.prototype.ShowErrors = function( arrErrors ){
	var strError = "";
	// Loop over each error to build up the error string.
	$.each(
		arrErrors,
		function( intI, strValue ){
			strError += (" - " + strValue + "<br />");
		}
	);

	// Display the error(s)
	$("#address-form-errors p").html(strError);
	$("#address-form-errors").show();
}


// Define a method to reset the address form
AddressForm.prototype.ResetForm = function(){
	// Clear the form, focus on first field and hide additional address fields
	this.Form.get(0).reset();
	this.DOMRef.personName.focus();
	$("#address-detail-fields").hide(400);
	$(".error").hide();
	$("span.error").remove;
}

