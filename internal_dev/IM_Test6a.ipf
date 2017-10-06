#pragma rtGlobals=3
#pragma IndependentModule=ABCD
#pragma ModuleName=test6a
#include "unit-testing"

// RunTest("example5-overridehooks.ipf;example5-overridehooks-otherSuite.ipf")

static Function CheckSquareRoot()
	CHECK_EQUAL_VAR(sqrt(4.0),2.0)
	CHECK_CLOSE_VAR(sqrt(2.0),1.4142,tol=1e-4)
End

static Function CheckSquareRoot2()
	CHECK_EQUAL_VAR(sqrt(4.0),2.0)
	CHECK_CLOSE_VAR(sqrt(2.0),1.4142,tol=1e-4)
End
