<cfcomponent displayname="TestPivotArray"  extends="mxunit.framework.TestCase">

  <!--- this will run once after initialization and before setUp() --->
  <cffunction name="beforeTests" returntype="void" access="public" hint="put things here that you want to run before all tests">
    <cfscript>
      obj = createObject("component","sandbox.cfcs.PivotArray");
    </cfscript>
  </cffunction>

  <cffunction name="testIsListOfNumbersFailsOnNull" access="public" returntype="void">
    <cfscript>
	  // Pass in blank string 
	  assertFalse( obj.isListOfNumbers("").success,  "isListOfNumbers should have returned false for an empty string");
    </cfscript>
  </cffunction>

  <cffunction name="testIsListOfNumbersFailsOnString" access="public" returntype="void">
    <cfscript>
	  // Pass in string 
	  assertFalse( obj.isListOfNumbers("abc").success,  "isListOfNumbers should have returned false for a string of characters");
    </cfscript>
  </cffunction>

  <cffunction name="testIsListOfNumbersSuccess" access="public" returntype="void">
    <cfscript>
	  // Pass in valid list of numbers 
	  assertTrue( obj.isListOfNumbers("12,12,1").success,  "isListOfNumbers should have returned true for a valid list of numbers");
    </cfscript>
  </cffunction>

  <cffunction name="testIsPivotArrayNotEnoughNumbers" access="public" returntype="void">
    <cfscript>
	  // Pass in array that is too short 
	  assertFalse( obj.isPivotArray([12,14]).success,  "IsPivotArray should have returned false for an array of less than 2 numbers");
    </cfscript>
  </cffunction>

  <cffunction name="testIsPivotArrayWeHaveValidArrayButNoPivot" access="public" returntype="void">
    <cfscript>
	  // Pass in a good array that does not have a pivot index 
	  assertTrue( obj.isPivotArray([12,14,18,20]).success,  "IsPivotArray should have returned true for running succesfully");
	  assertFalse( obj.isPivotArray([12,14,18,20]).data.isPivotArray,  "IsPivotArray should have returned false for an array that has no pivot index");
    </cfscript>
  </cffunction>


  <cffunction name="testIsPivotArrayWeHaveValidArrayWithPivot" access="public" returntype="void">
    <cfscript>
	  // Pass in a good array that DOES have a pivot index 
	  assertTrue( obj.isPivotArray([12,8,20,10,9,1]).success,  "IsPivotArray should have returned true for running succesfully");
	  assertTrue( obj.isPivotArray([12,8,20,10,9,1]).data.isPivotArray,  "IsPivotArray should have returned true for an array that has a pivot index");
    </cfscript>
  </cffunction>

</cfcomponent>