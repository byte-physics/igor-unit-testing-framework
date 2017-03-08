#pragma rtGlobals=3
#pragma ModuleName=Example2

#include "unit-testing"

// Command: run_IGNORE()
// Show the use of optional arguments
// testCase: specify only a single function to execute as Test Case
// name: Name the whole test run

Function run_IGNORE()
	// All of these commands run the test suite "example2-plain.ipf"

	// executes all test cases of this file
	RunTest("example2-plain.ipf")
	// execute only one test case at a time
	RunTest("example2-plain.ipf",testCase="VerifyDefaultStringBehaviour")
	// Give all test suites a descriptive name
	RunTest("example2-plain.ipf",name="My first test")
End

// Making the function static prevents name clashes with other
// procedure files. Using static functions requires also the
// line "#pragma ModuleName" from above.
static Function VerifyDefaultStringBehaviour()

	string nullString
	string emptyString = ""
	string strLow      = "1234a"
	string strUP       = "1234A"

	// by default string comparison is done case insensitive
	CHECK_EQUAL_STR(strLow,strUP)
	CHECK_EQUAL_STR(strLow,strUP,case_sensitive = 0)
	// the next test fails
	WARN_EQUAL_STR(strLow,strUP,case_sensitive = 1)

	CHECK_NEQ_STR(emptyString,nullString)
	CHECK_NEQ_STR(strLow,nullString)
	CHECK_EMPTY_STR(emptyString)
	CHECK_NULL_STR(nullString)
	CHECK_EQUAL_VAR(strlen(strLow),5)
End
