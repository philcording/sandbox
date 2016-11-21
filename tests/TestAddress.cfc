<cfcomponent displayname="TestAddress"  extends="mxunit.framework.TestCase">

  <!--- this will run once after initialization and before setUp() --->
  <cffunction name="beforeTests" returntype="void" access="public" hint="put things here that you want to run before all tests">
    <cfscript>
      obj = createObject("component","sandbox.cfcs.Address");
    </cfscript>
  </cffunction>



  <cffunction name="TestAPIgetAddressServerAutheticatesKey" access="public" returntype="void">
    <cfhttp url="https://api.getaddress.io/usage?api-key=4g9yrpu8uU-yr53wuLmUnQ6435">
    <cfdump var="#cfhttp#">
    <cfscript>
	  expected = 200;
	  actual = cfhttp.ResponseHeader.status_code;
	  assertEquals(expected,actual, "Pinged https://api.getaddress.io with the stored key. Should have got an authenticated response" );
    </cfscript>
  </cffunction>


  <cffunction name="testLookupAddressPostcodeNotFound404" access="public" returntype="void">
    <cfscript>
	  // Pass in post code that cannot be found 
	  assertFalse( obj.LookupAddress("2","XX4 04X").success,  "LookupAddress post code not found. Should return success=false");
    </cfscript>
  </cffunction>

  <cffunction name="testLookupAddressPostcodeNotValid400" access="public" returntype="void">
    <cfscript>
	  // Pass in post code that is not valid 
	  assertFalse( obj.LookupAddress("2","XX4 00X").success,  "LookupAddress post code not valid. Should return success=false");
    </cfscript>
  </cffunction>


  <cffunction name="testLookupAddressValidPostcode" access="public" returntype="void">
    <cfscript>
	  // Pass in post code that is valid
	  assertTrue( obj.LookupAddress("2","CF24 1QX").success,  "LookupAddress post code not valid. Should return success=true");
	  assertIsStruct(obj.LookupAddress("2","CF24 1QX").data);
    </cfscript>
  </cffunction>


  <cffunction name="testSaveAddress" access="public" returntype="void">
    <cfscript>
	  // Pass in post code that is valid
	  testAddress = structNew();
	  testAddress.personName="Bob"; 
	  testAddress.dob="01/01/1990";
	  testAddress.houseNum="2";
	  testAddress.postCode="XX1 1XX";
	  testAddress.street1="XX1 1XX";
	  testAddress.street2="c";
	  testAddress.street3="";
	  testAddress.street4="";
	  testAddress.locality="b";
	  testAddress.city="London";
	  testAddress.county="c";

	  expected = arrayLen(session.addresses) + 1;
	  assertTrue(obj.SaveAddress("Bob","01/01/1990","2","XX1 1XX","b","c","","","d","London","London").success,
	    "SaveAddress - Address should have saved with a success message.");
	  actual = arrayLen(session.addresses);
	  assertEquals(expected,actual, "SaveAddress - There should be an extra address in the array session.addresses" );

      //clean up and remove address
      arrayDeleteAt(session.addresses,actual);

    </cfscript>
  </cffunction>


  <cffunction name="testGetAddresses" access="public" returntype="void">
    <cfscript>
	  // Pass in post code that is valid
	  assertTrue( obj.GetAddresses().success,  "GetAddresses should return success=true");
	  assertIsArray(obj.GetAddresses().data);
    </cfscript>
  </cffunction>


</cfcomponent>

