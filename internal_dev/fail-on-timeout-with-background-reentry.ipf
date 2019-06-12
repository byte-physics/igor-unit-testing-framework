#pragma rtGlobals=3
#pragma TextEncoding="UTF-8"

#include "unit-testing"

// Example of how to use the failOnTimeOut feature
// The testcase `First` must have one error in the end.

Function ReEntryTask(s)
	STRUCT WMBackgroundStruct &s

	return !mod(trunc(datetime), 5)
End

Function First()

	CtrlNamedBackGround testtask, proc=ReEntryTask, period = 1, start
	RegisterUTFMonitor("testtask", 1, "Second_reentry", timeout = 1, failOntimeout = 1)
End

Function Second_REENTRY()

	PASS()
End
