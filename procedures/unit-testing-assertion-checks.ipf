#pragma rtGlobals=3
#pragma version=1.08
#pragma TextEncoding="UTF-8"
#pragma ModuleName=UTF_Checks

// Licensed under 3-Clause BSD, see License.txt

/// @cond HIDDEN_SYMBOL

static Constant NUMTYPE_NAN = 2

/// @name CountObjects and CountObjectsDFR constant
/// @anchor TypeFlags
/// @{
static Constant COUNTOBJECTS_WAVES      = 1
static Constant COUNTOBJECTS_VAR        = 2
static Constant COUNTOBJECTS_STR        = 3
static Constant COUNTOBJECTS_DATAFOLDER = 4
/// @}

static Function IsDataFolderEmpty(folder)
	string folder

	return ((CountObjects(folder, COUNTOBJECTS_WAVES) + CountObjects(folder, COUNTOBJECTS_VAR) + CountObjects(folder, COUNTOBJECTS_STR) + CountObjects(folder, COUNTOBJECTS_DATAFOLDER)) == 0)
End

static Function IsTrue(var)
	variable var

	return (var == 1)
End

static Function IsNullString(str)
	string &str

	return (numtype(strlen(str)) == NUMTYPE_NAN)
End

static Function IsEmptyString(str)
	string &str

	return (strlen(str) == 0)
End

static Function IsProperString(str)
	string &str

	return !IsEmptyString(str) && !IsNullString(str)
End

static Function AreVariablesEqual(var1, var2)
	variable var1, var2

	variable type1 = numType(var1)
	variable type2 = numType(var2)

	if(type1 == type2 && type1 == NUMTYPE_NAN) // both variables being NaN is also true
		return 1
	else
		return (var1 == var2)
	endif
End

static Function IsVariableSmall(var, tol)
	variable var
	variable tol

	return (abs(var) < abs(tol))
End

static Function AreVariablesClose(var1, var2, tol, strong_or_weak)
	variable var1, var2
	variable tol
	variable strong_or_weak

	strong_or_weak = !!strong_or_weak

	variable diff = abs(var1 - var2)
	variable d1   = diff / abs(var1)
	variable d2   = diff / abs(var2)

	// printf "d1 %.15g, d2 %.15g, d1 - d2 %.15g, strong %d, weak %d\r", d1, d2, d1 - d2, (d1 <= tol && d2 <= tol), (d1 <= tol || d2 <= tol)

	if(strong_or_weak == 1)
		return (d1 <= tol && d2 <= tol)
	else
		return (d1 <= tol || d2 <= tol)
	endif
End

/// @return 1 if both strings are equal and zero otherwise
static Function AreStringsEqual(str1, str2, case_sensitive)
	string &str1, &str2
	variable case_sensitive

	case_sensitive = !!case_sensitive

	if(IsNullString(str1) && IsNullString(str2))
		return 1
	elseif(IsNullString(str1) || IsNullString(str2))
		return 0
	else
		return (cmpstr(str1, str2, case_sensitive) == 0)
	endif
End

static Function HasWaveMajorType(wv, majorType)
	WAVE/Z wv
	variable majorType

	variable type, type1, type2

	type2 = WaveType(wv, 2)
	type1 = WaveType(wv, 1)

	if(type1 > 0 && type1 <= 4)
		type = type | 2^(type1 - 1)
	endif

	if(type2 > 0 && type2 <= 2)
		type = type | 2^(type2 + 3)
	endif

	if((type1 == 0 && type2 == 0) || !WaveExists(wv))
		type = NULL_WAVE
	endif

	return (type & majorType) == majorType
End

static Function HasWaveMinorType(wv, minorType)
	WAVE/Z wv
	variable minorType

	variable type

	type = WaveExists(wv) ? WaveType(wv, 0) : NULL_WAVE

	return (type & minorType) == minorType
End

/// @endcond // HIDDEN_SYMBOL
