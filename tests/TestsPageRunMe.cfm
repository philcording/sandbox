<cfscript>
	testSuite = createObject("component","mxunit.framework.TestSuite").TestSuite();	

 	testSuite.addAll("sandbox.tests.TestPivotArray");
 	testSuite.addAll("sandbox.tests.TestAddress");

	//Run the tests and save everything in "results"
 	results = testSuite.run();

	//Now print the results.
	writeOutput(results.getResultsOutput('html'));

</cfscript>
