#pragma rtGlobals=3

/// Tests two variables for unequality
/// @param var1    first variable
/// @param var2    second variable
/// @param flags   actions flags
static Function NEQ_VAR_WRAPPER(var1, var2, flags)
  variable var1, var2
  variable flags

  incrAssert()

  if( shouldDoAbort() )
    return NaN
  endif

  if( EQUAL_VAR(var1, var2) )
    if( flags & OUTPUT_MESSAGE )
      printFailInfo()
    endif
    if( flags & INCREASE_ERROR )
      incrError()
    endif
    if( flags & ABORT_FUNCTION )
      abortNow()
    endif
  endif
End

/// Compares two strings for unequality
/// @param str1            first string
/// @param str2            second string
/// @param flags           actions flags
/// @param case_sensitive  (optional) should the comparison be done case sensitive (1) or case insensitive (0, the default)
static Function NEQ_STR_WRAPPER(str1, str2, flags, [case_sensitive])
  string &str1, &str2
  variable case_sensitive
  variable flags

  incrAssert()

  if( shouldDoAbort() )
    return NaN
  endif

  if(ParamIsDefault(case_sensitive))
    case_sensitive = 0
  endif

  if( EQUAL_STR(str1, str2, case_sensitive) )
    if( flags & OUTPUT_MESSAGE )
      printFailInfo()
    endif
    if( flags & INCREASE_ERROR )
      incrError()
    endif
    if( flags & ABORT_FUNCTION )
      abortNow()
    endif
  endif
End

/// Compares two variables and determines if they are close
/// @param var1            first variable
/// @param var2            second variable
/// @param flags           actions flags
/// @param tol             (optional) tolerance, defaults to 1e-8
/// @param strong_or_weak  (optional) defaults to 1 (strong condition)
static Function CLOSE_VAR_WRAPPER(var1, var2, flags, [tol, strong_or_weak])
  variable var1, var2
  variable flags
  variable tol
  variable strong_or_weak

  incrAssert()

  if( shouldDoAbort() )
    return NaN
  endif

  if(ParamIsDefault(strong_or_weak))
    strong_or_weak  = 1
  endif

  if(ParamIsDefault(tol))
    tol = 1e-8
  endif

  if( !CLOSE_VAR(var1, var2, tol, strong_or_weak) )
    if( flags & OUTPUT_MESSAGE )
      printFailInfo()
    endif
    if( flags & INCREASE_ERROR )
      incrError()
    endif
    if( flags & ABORT_FUNCTION )
      abortNow()
    endif
  endif
End

/// Tests if var is small
/// @param var        variable
/// @param flags      actions flags
/// @param tol        (optional) tolerance, defaults to 1e-8
static Function SMALL_VAR_WRAPPER(var, flags, [tol])
  variable var
  variable flags
  variable tol

  incrAssert()

  if( shouldDoAbort() )
    return NaN
  endif

  if(ParamIsDefault(tol))
    tol = 1e-8
  endif

  if( !SMALL_VAR(var, tol) )
    if( flags & OUTPUT_MESSAGE )
      printFailInfo()
    endif
    if( flags & INCREASE_ERROR )
      incrError()
    endif
    if( flags & ABORT_FUNCTION )
      abortNow()
    endif
  endif
End

/// Compares two strings for equality
/// @param str1           first string
/// @param str2           second string
/// @param flags          actions flags
/// @param case_sensitive (optional) should the comparison be done case sensitive (1) or case insensitive (0, the default)
static Function EQUAL_STR_WRAPPER(str1, str2, flags, [case_sensitive])
  string &str1, &str2
  variable case_sensitive
  variable flags

  incrAssert()

  if( shouldDoAbort() )
    return NaN
  endif

  if(ParamIsDefault(case_sensitive))
    case_sensitive = 0
  endif

  if( !EQUAL_STR(str1, str2, case_sensitive) )
    if( flags & OUTPUT_MESSAGE )
      printFailInfo()
    endif
    if( flags & INCREASE_ERROR )
      incrError()
    endif
    if( flags & ABORT_FUNCTION )
      abortNow()
    endif
  endif
End

/// Tests a wave for existence and its type
/// @param wv         wave reference
/// @param flags      actions flags
/// @param majorType  major wave type
/// @param minorType  (optional) minor wave type
/// @see waveTypes
static Function TEST_WAVE_WRAPPER(wv, flags, majorType, [minorType])
  Wave/Z wv
  variable majorType, minorType
  variable flags

  incrAssert()

  if( shouldDoAbort() )
    return NaN
  endif

  variable result = WaveExists(wv)
  DebugOutput("Assumption that the wave exists",result)

  if(!result)
    if( flags & OUTPUT_MESSAGE )
      printFailInfo()
    endif
    if( flags & INCREASE_ERROR )
      incrError()
    endif
    if( flags & ABORT_FUNCTION )
      abortNow()
    endif
  endif

  result = ( WaveType(wv,1) != majorType )
  string str
  sprintf str, "Assumption that the wave's main type is %d", majorType
  DebugOutput(str,result)

  if(!result)
    if( flags & OUTPUT_MESSAGE )
      printFailInfo()
    endif
    if( flags & INCREASE_ERROR )
      incrError()
    endif
    if( flags & ABORT_FUNCTION )
      abortNow()
    endif
  endif

  if(!ParamIsDefault(minorType))
    result = WaveType(wv,0) & minorType

    sprintf str, "Assumption that the wave's sub type is %d", minorType
    DebugOutput(str,result)

    if(!result)
      if( flags & OUTPUT_MESSAGE )
        printFailInfo()
      endif
      if( flags & INCREASE_ERROR )
        incrError()
      endif
      if( flags & ABORT_FUNCTION )
        abortNow()
      endif
    endif
  endif
End

/// Tests two variables for equality
/// @param var1   first variable
/// @param var2   second variable
/// @param flags  actions flags
static Function EQUAL_VAR_WRAPPER(var1, var2, flags)
  variable var1, var2
  variable flags

  incrAssert()

  if( shouldDoAbort() )
    return NaN
  endif

  if( !EQUAL_VAR(var1, var2) )
    if( flags & OUTPUT_MESSAGE )
      printFailInfo()
    endif
    if( flags & INCREASE_ERROR )
      incrError()
    endif
    if( flags & ABORT_FUNCTION )
      abortNow()
    endif
  endif
End

/// Tests two waves for equality
/// @param wv1    first wave
/// @param wv2    second wave
/// @param flags  actions flags
/// @param mode   (optional) features of the waves to compare, defaults to all modes, defined at @ref CheckWaveModes
/// @param tol    (optional) tolerance for comparison, by default 0.0 which means do byte-by-byte comparison ( relevant only for mode=WAVE_DATA )
static Function EQUAL_WAVE_WRAPPER(wv1, wv2, flags, [mode, tol])
  Wave/Z wv1, wv2
  variable flags
  variable mode, tol

  incrAssert()

  if( shouldDoAbort() )
    return NaN
  endif

  variable result = WaveExists(wv1)
  DebugOutput("Assumption that the first wave (wv1) exists",result)

  if(!result)
    if( flags & OUTPUT_MESSAGE )
      printFailInfo()
    endif
    if( flags & INCREASE_ERROR )
      incrError()
    endif
    if( flags & ABORT_FUNCTION )
      abortNow()
    endif
    return NaN
  endif

  result = WaveExists(wv2)
  DebugOutput("Assumption that the second wave (wv2) exists",result)

  if(!result)
    if( flags & OUTPUT_MESSAGE )
      printFailInfo()
    endif
    if( flags & INCREASE_ERROR )
      incrError()
    endif
    if( flags & ABORT_FUNCTION )
      abortNow()
    endif
    return NaN
  endif

  result = !WaveRefsEqual(wv1, wv2)
  DebugOutput("Assumption that both waves are distinct",result)

  if(!result)
    if( flags & OUTPUT_MESSAGE )
      printFailInfo()
    endif
    if( flags & INCREASE_ERROR )
      incrError()
    endif
    if( flags & ABORT_FUNCTION )
      abortNow()
    endif
    return NaN
  endif

  if(ParamIsDefault(mode))
    Make/U/I/FREE modes = { WAVE_DATA, WAVE_DATA_TYPE, WAVE_SCALING, DATA_UNITS, DIMENSION_UNITS, DIMENSION_LABELS, WAVE_NOTE, WAVE_LOCK_STATE, DATA_FULL_SCALE, DIMENSION_SIZES}
  else
    Make/U/I/FREE modes = { mode }
  endif

  if(ParamIsDefault(tol))
    tol = 0.0
  endif

  variable i
  for(i = 0; i < DimSize(modes,0); i+=1)
    mode = modes[i]
    result = EqualWaves(wv1, wv2, mode, tol)
    string str
    sprintf str, "Assuming equality using mode %03d for waves %s and %s", mode, NameOfWave(wv1), NameOfWave(wv2)
    DebugOutput(str,result)

    if(!result)
      if( flags & OUTPUT_MESSAGE )
        printFailInfo()
      endif
      if( flags & INCREASE_ERROR )
        incrError()
      endif
      if( flags & ABORT_FUNCTION )
        abortNow()
      endif
    endif
  endfor
End

/// Checks if a string is null
/// @param str string to check
/// @return 1 for null strings and zero otherwise
static Function NULL_STR(str)
  string &str

  variable result = ( numtype(strlen(str)) == 2 )

  DebugOutput("Assumption of str being null is ", result)
  return result
End

/// Tests two variables for equality
/// @param var1           first variable
/// @param var2           second variable
/// @return 1 if both variables are equal and zero otherwise
static Function EQUAL_VAR(var1, var2)
  variable var1, var2

  variable result
  variable type1 = numType(var1)
  variable type2 = numType(var2)

  if( type1 == type2 && type1 == 2 ) // both variables being NaN is also true
    result = 1
  else
    result = ( var1 == var2 )
  endif

  string str
  sprintf str, "%g == %g", var1, var2
  DebugOutput(str, result)
  return result
End

/// Checks if a variable is small
/// @param var variable to check
/// @param tol tolerance for comparison
/// @return 1 if var is small compared to tol
static Function SMALL_VAR(var, tol)
  variable var
  variable tol

  variable result = ( abs(var) < abs(tol) )

  string str
  sprintf str, "%g ~ 0 with tol %g", var, tol
  DebugOutput(str, result)
  return result
End

/// Compares two variables (floating point type) if they are close
/// @param var1           first variable
/// @param var2           second variable
/// @param tol            absolute tolerance of the comparison
/// @param strong_or_weak Use the strong (1) condition or the weak (0)
/// @return          1 if they are close and zero otherwise
///
/// Based on the implementation of "Floating-point comparison algorithms" in the C++ Boost unit testing framework
///
/// Literature:
/// The art of computer programming (Vol II). Donald. E. Knuth. 0-201-89684-2. Addison-Wesley Professional;
/// 3 edition, page 234 equation (34) and (35)
static Function CLOSE_VAR(var1, var2, tol, strong_or_weak)
  variable var1, var2
  variable tol
  variable strong_or_weak

  variable diff  = abs(var1 - var2)
  variable d1   = diff/var1
  variable d2   = diff/var2

  variable result
  if(strong_or_weak == 1)
    result = ( d1 <= tol && d2 <= tol )
  elseif(strong_or_weak == 0)
    result = ( d1 <= tol || d2 <= tol )
  else
    printf "Unknown mode %d\r", strong_or_weak
  endif

  string str
  sprintf str, "%g ~ %g with %s check and tol %g", var1, var2, SelectString(strong_or_weak,"weak","strong"), tol
  DebugOutput(str, result)
  return result
End

/// @return 1 if both strings are equal and zero otherwise
static Function EQUAL_STR(str1, str2, case_sensitive)
  string &str1, &str2
  variable case_sensitive

  variable result
  if( NULL_STR(str1) && NULL_STR(str2) )
    result = 1
  elseif( NULL_STR(str1) || NULL_STR(str2) )
    result = 0
  else
    result = ( cmpstr(str1, str2, case_sensitive) == 0 )
  endif

  string str
  sprintf str, "\"%s\" == \"%s\" %s case", SelectString(NULL_STR(str1),"(null)",str1), SelectString(NULL_STR(str2),"(null)",str2), SelectString(case_sensitive,"not respecting","respecting")
  DebugOutput(str, result)

  return result
End

/// Tests if the current data folder is empty
///
/// Counted are all objects like waves, strings, variables, folders
/// @return 1 if empty and zero otherwise
static Function CDF_EMPTY_WRAPPER(flags)
  variable flags

  incrAssert()

  if( shouldDoAbort() )
    return NaN
  endif

  string folder = ":"
  variable result = ( CountObjects(folder,1) + CountObjects(folder,2) + CountObjects(folder,3) + CountObjects(folder,4)  == 0 )

  if( !result )
    if( flags & OUTPUT_MESSAGE )
      printFailInfo()
    endif
    if( flags & INCREASE_ERROR )
      incrError()
    endif
    if( flags & ABORT_FUNCTION )
      abortNow()
    endif
  endif

  DebugOutput("Assumption that the current data folder is empty is", result)
  return result
End

/// Tests if var is true (1)
/// @param var    variable to test
/// @param flags  actions flags
static Function TRUE_WRAPPER(var, flags)
  variable var
  variable flags

  incrAssert()

  if( shouldDoAbort() )
    return NaN
  endif

  variable result = ( var == 1 )
  DebugOutput(num2istr(var), result)

  if( !result )
    if( flags & OUTPUT_MESSAGE )
      printFailInfo()
    endif
    if( flags & INCREASE_ERROR )
      incrError()
    endif
    if( flags & ABORT_FUNCTION )
      abortNow()
    endif
  endif
End

/// Tests if str is null
/// @param var    string to test
/// @param flags  actions flags
static Function NULL_STR_WRAPPER(str, flags)
  string &str
  variable flags

  incrAssert()

  if( shouldDoAbort() )
    return NaN
  endif

  if( !NULL_STR(str) )
    if( flags & OUTPUT_MESSAGE )
      printFailInfo()
    endif
    if( flags & INCREASE_ERROR )
      incrError()
    endif
    if( flags & ABORT_FUNCTION )
      abortNow()
    endif
  endif
End

/// Tests if str is empty
/// @param var    string to test
/// @param flags  actions flags
static Function EMPTY_STR_WRAPPER(str, flags)
  string &str
  variable flags

  incrAssert()

  if( shouldDoAbort() )
    return NaN
  endif

  variable result = ( strlen(str) == 0 )
  DebugOutput("Assumption that the string is empty is",result)

  if( !result )
    if( flags & OUTPUT_MESSAGE )
      printFailInfo()
    endif
    if( flags & INCREASE_ERROR )
      incrError()
    endif
    if( flags & ABORT_FUNCTION )
      abortNow()
    endif
  endif
End

/// Force the test case to fail
Function FAIL()
  TRUE_WRAPPER(0, REQUIRE_MODE)
End

///@addtogroup VariableAssertions
///@{

/// Warns if var is not true (1)
/// @param var variable
Function WARN(var)
  variable var

  TRUE_WRAPPER(var, WARN_MODE)
End

/// Checks that var is true (1)
/// @param var variable
Function CHECK(var)
  variable var

  TRUE_WRAPPER(var, CHECK_MODE)
End

/// Requires that var is true (1)
/// @param var variable
Function REQUIRE(var)
  variable var

  TRUE_WRAPPER(var, REQUIRE_MODE)
End

/// Tests two variables for equality
/// @param var1        first variable
/// @param var2        second variable
Function WARN_EQUAL_VAR(var1, var2)
  variable var1, var2

  EQUAL_VAR_WRAPPER(var1, var2, WARN_MODE)
End

/// Checks two variables for equality
/// @param var1        first variable
/// @param var2        second variable
Function CHECK_EQUAL_VAR(var1, var2)
  variable var1, var2

  EQUAL_VAR_WRAPPER(var1, var2, CHECK_MODE)
End

/// Requires that two variables are equal
/// @param var1        first variable
/// @param var2        second variable
Function REQUIRE_EQUAL_VAR(var1, var2)
  variable var1, var2

  EQUAL_VAR_WRAPPER(var1, var2, REQUIRE_MODE)
End

/// Tests two variables for unequality
/// @param var1     first variable
/// @param var2     second variable
Function WARN_NEQ_VAR(var1, var2)
  variable var1, var2

  NEQ_VAR_WRAPPER(var1, var2, WARN_MODE)
End

/// Checks two variables for unequality
/// @param var1        first variable
/// @param var2        second variable
Function CHECK_NEQ_VAR(var1, var2)
  variable var1, var2

  NEQ_VAR_WRAPPER(var1, var2, CHECK_MODE)
End

/// Requires that two variables are unequal
/// @param var1        first variable
/// @param var2        second variable
Function REQUIRE_NEQ_VAR(var1, var2)
  variable var1, var2

  NEQ_VAR_WRAPPER(var1, var2, REQUIRE_MODE)
End

/// Compares two variables and determines if they are close
/// @param var1            first variable
/// @param var2            second variable
/// @param tol             (optional) tolerance, defaults to 1e-8
/// @param strong_or_weak  (optional) defaults to 1 (strong condition)
Function WARN_CLOSE_VAR(var1, var2, [tol, strong_or_weak])
  variable var1, var2
    variable tol
    variable strong_or_weak

  if(ParamIsDefault(tol) && ParamIsDefault(strong_or_weak))
      CLOSE_VAR_WRAPPER(var1, var2, WARN_MODE)
  elseif(ParamIsDefault(tol))
      CLOSE_VAR_WRAPPER(var1, var2, WARN_MODE, strong_or_weak=strong_or_weak)
  elseif(ParamIsDefault(strong_or_weak))
      CLOSE_VAR_WRAPPER(var1, var2, WARN_MODE, tol=tol)
  else
      CLOSE_VAR_WRAPPER(var1, var2, WARN_MODE, tol=tol, strong_or_weak=strong_or_weak)
  endif
End

/// Checks if two variables are close
/// @param var1            first variable
/// @param var2            second variable
/// @param tol             (optional) tolerance, defaults to 1e-8
/// @param strong_or_weak  (optional) defaults to 1 (strong condition)
Function CHECK_CLOSE_VAR(var1, var2, [tol, strong_or_weak])
  variable var1, var2
    variable tol
    variable strong_or_weak

  if(ParamIsDefault(tol) && ParamIsDefault(strong_or_weak))
      CLOSE_VAR_WRAPPER(var1, var2, CHECK_MODE)
  elseif(ParamIsDefault(tol))
      CLOSE_VAR_WRAPPER(var1, var2, CHECK_MODE, strong_or_weak=strong_or_weak)
  elseif(ParamIsDefault(strong_or_weak))
      CLOSE_VAR_WRAPPER(var1, var2, CHECK_MODE, tol=tol)
  else
      CLOSE_VAR_WRAPPER(var1, var2, CHECK_MODE, tol=tol, strong_or_weak=strong_or_weak)
  endif
End

/// Requires that two variables are close
/// @param var1            first variable
/// @param var2            second variable
/// @param tol             (optional) tolerance, defaults to 1e-8
/// @param strong_or_weak  (optional) defaults to 1 (strong condition)
Function REQUIRE_CLOSE_VAR(var1, var2, [tol, strong_or_weak])
  variable var1, var2
    variable tol
    variable strong_or_weak

  if(ParamIsDefault(tol) && ParamIsDefault(strong_or_weak))
      CLOSE_VAR_WRAPPER(var1, var2, REQUIRE_MODE)
  elseif(ParamIsDefault(tol))
      CLOSE_VAR_WRAPPER(var1, var2, REQUIRE_MODE, strong_or_weak=strong_or_weak)
  elseif(ParamIsDefault(strong_or_weak))
      CLOSE_VAR_WRAPPER(var1, var2, REQUIRE_MODE, tol=tol)
  else
      CLOSE_VAR_WRAPPER(var1, var2, REQUIRE_MODE, tol=tol, strong_or_weak=strong_or_weak)
  endif
End

/// Tests if var is small
/// @param var        variable
/// @param tol        (optional) tolerance, defaults to 1e-8
Function WARN_SMALL_VAR(var, [tol])
  variable var
   variable tol

  if(ParamIsDefault(tol))
      SMALL_VAR_WRAPPER(var, WARN_MODE)
  else
      SMALL_VAR_WRAPPER(var, WARN_MODE, tol=tol)
  endif
End

/// Checks that var is small
/// @param var        variable
/// @param tol        (optional) tolerance, defaults to 1e-8
Function CHECK_SMALL_VAR(var, [tol])
  variable var
   variable tol

  if(ParamIsDefault(tol))
      SMALL_VAR_WRAPPER(var, CHECK_MODE)
  else
      SMALL_VAR_WRAPPER(var, CHECK_MODE, tol=tol)
  endif
End

/// Requires that var is small
/// @param var        variable
/// @param tol        (optional) tolerance, defaults to 1e-8
Function REQUIRE_SMALL_VAR(var, [tol])
  variable var
   variable tol

  if(ParamIsDefault(tol))
      SMALL_VAR_WRAPPER(var, REQUIRE_MODE)
  else
      SMALL_VAR_WRAPPER(var, REQUIRE_MODE, tol=tol)
  endif
End

///@}
///@addtogroup StringAssertions
///@{

/// Warns if str is not null
/// @param str string
Function WARN_EMPTY_STR(str)
  string &str

  EMPTY_STR_WRAPPER(str, WARN_MODE)
End

/// Checks that str is null
/// @param str string
Function CHECK_EMPTY_STR(str)
  string &str

  EMPTY_STR_WRAPPER(str, CHECK_MODE)
End

/// Requires that str is null
/// @param str string
Function REQUIRE_EMPTY_STR(str)
  string &str

  EMPTY_STR_WRAPPER(str, REQUIRE_MODE)
End

/// Warns if str is not empty
/// @param str string
Function WARN_NULL_STR(str)
  string &str

  NULL_STR_WRAPPER(str, WARN_MODE)
End

/// Checks that str is empty
/// @param str string
Function CHECK_NULL_STR(str)
  string &str

  NULL_STR_WRAPPER(str, CHECK_MODE)
End

/// Requires that str is empty
/// @param str string
Function REQUIRE_NULL_STR(str)
  string &str

  NULL_STR_WRAPPER(str, REQUIRE_MODE)
End

/// Tests two strings for equality
/// @param str1            first string
/// @param str2            second string
/// @param case_sensitive  (optional) should the comparison be done case sensitive (1) or case insensitive (0, the default)
Function WARN_EQUAL_STR(str1, str2, [case_sensitive])
  string &str1, &str2
  variable case_sensitive

  if(ParamIsDefault(case_sensitive))
      EQUAL_STR_WRAPPER(str1, str2, WARN_MODE)
  else
      EQUAL_STR_WRAPPER(str1, str2, WARN_MODE, case_sensitive=case_sensitive)
  endif
End

/// Checks two strings for equality
/// @param str1            first string
/// @param str2            second string
/// @param case_sensitive  (optional) should the comparison be done case sensitive (1) or case insensitive (0, the default)
Function CHECK_EQUAL_STR(str1, str2, [case_sensitive])
  string &str1, &str2
   variable case_sensitive

  if(ParamIsDefault(case_sensitive))
      EQUAL_STR_WRAPPER(str1, str2, CHECK_MODE)
  else
      EQUAL_STR_WRAPPER(str1, str2, CHECK_MODE, case_sensitive=case_sensitive)
  endif
End

/// Requires that two strings are equal
/// @param str1            first string
/// @param str2            second string
/// @param case_sensitive  (optional) should the comparison be done case sensitive (1) or case insensitive (0, the default)
Function REQUIRE_EQUAL_STR(str1, str2, [case_sensitive])
  string &str1, &str2
    variable case_sensitive

  if(ParamIsDefault(case_sensitive))
      EQUAL_STR_WRAPPER(str1, str2, REQUIRE_MODE)
  else
      EQUAL_STR_WRAPPER(str1, str2, REQUIRE_MODE, case_sensitive=case_sensitive)
  endif
End

/// Tests two strings for unequality
/// @param str1            first string
/// @param str2            second string
/// @param case_sensitive  (optional) should the comparison be done case sensitive (1) or case insensitive (0, the default)
Function WARN_NEQ_STR(str1, str2, [case_sensitive])
  string &str1, &str2
   variable case_sensitive

  if(ParamIsDefault(case_sensitive))
      NEQ_STR_WRAPPER(str1, str2, WARN_MODE)
  else
      NEQ_STR_WRAPPER(str1, str2, WARN_MODE, case_sensitive=case_sensitive)
  endif
End

/// Checks two strings for unequality
/// @param str1            first string
/// @param str2            second string
/// @param case_sensitive  (optional) should the comparison be done case sensitive (1) or case insensitive (0, the default)
Function CHECK_NEQ_STR(str1, str2, [case_sensitive])
  string &str1, &str2
   variable case_sensitive

  if(ParamIsDefault(case_sensitive))
      NEQ_STR_WRAPPER(str1, str2, CHECK_MODE)
  else
      NEQ_STR_WRAPPER(str1, str2, CHECK_MODE, case_sensitive=case_sensitive)
  endif
End

/// Requires that two strings are unequal
/// @param str1            first string
/// @param str2            second string
/// @param case_sensitive  (optional) should the comparison be done case sensitive (1) or case insensitive (0, the default)
Function REQUIRE_NEQ_STR(str1, str2, [case_sensitive])
  string str1, str2
    variable case_sensitive

  if(ParamIsDefault(case_sensitive))
      EQUAL_STR_WRAPPER(str1, str2, REQUIRE_MODE)
  else
      EQUAL_STR_WRAPPER(str1, str2, REQUIRE_MODE, case_sensitive=case_sensitive)
  endif
End

///@}
///@addtogroup WaveAssertions
///@{

/// Tests a wave for existence and its type
/// @param wv         wave reference
/// @param majorType  major wave type
/// @param minorType  (optional) minor wave type
/// @see waveTypes
Function WARN_WAVE(wv, majorType, [minorType])
  Wave/Z wv
  variable majorType, minorType

  if(ParamIsDefault(minorType))
    TEST_WAVE_WRAPPER(wv, majorType, WARN_MODE)
  else
    TEST_WAVE_WRAPPER(wv, majorType, WARN_MODE, minorType=minorType)
  endif
End

/// Checks a wave for existence and its type
/// @param wv         wave reference
/// @param majorType  major wave type
/// @param minorType  (optional) minor wave type
/// @see waveTypes
Function CHECK_WAVE(wv, majorType, [minorType])
  Wave/Z wv
  variable majorType, minorType

  if(ParamIsDefault(minorType))
    TEST_WAVE_WRAPPER(wv, majorType, CHECK_MODE)
  else
    TEST_WAVE_WRAPPER(wv, majorType, CHECK_MODE, minorType=minorType)
  endif
End

/// Requires that a wave exists and has a certain type
/// @param wv         wave reference
/// @param majorType  major wave type
/// @param minorType  (optional) minor wave type
/// @see waveTypes
Function REQUIRE_WAVE(wv, majorType, [minorType])
  Wave/Z wv
  variable majorType, minorType

  if(ParamIsDefault(minorType))
    TEST_WAVE_WRAPPER(wv, majorType, REQUIRE_MODE)
  else
    TEST_WAVE_WRAPPER(wv, majorType, REQUIRE_MODE, minorType=minorType)
  endif
End

/// Tests two waves for equality
/// @param wv1   first wave
/// @param wv2   second wave
/// @param mode  (optional) features of both waves to compare, defaults to all modes, defined at @ref CheckWaveModes
/// @param tol   (optional) tolerance for comparison, by default 0.0 which means do byte-by-byte comparison ( relevant only for mode=WAVE_DATA )
Function WARN_EQUAL_WAVES(wv1, wv2, [mode, tol])
  Wave/Z wv1, wv2
  variable mode, tol

  if(ParamIsDefault(mode) && ParamIsDefault(tol))
      EQUAL_WAVE_WRAPPER(wv1, wv2, WARN_MODE)
  elseif(ParamIsDefault(tol))
      EQUAL_WAVE_WRAPPER(wv1, wv2, WARN_MODE, mode=mode)
  elseif(ParamIsDefault(mode))
      EQUAL_WAVE_WRAPPER(wv1, wv2, WARN_MODE, tol=tol)
  else
      EQUAL_WAVE_WRAPPER(wv1, wv2, WARN_MODE, tol=tol, mode=mode)
  endif
End

/// Checks two waves for equality
/// @param wv1    first wave
/// @param wv2    second wave
/// @param mode   (optional) features of both waves to compare, defaults to all modes, defined at @ref CheckWaveModes
/// @param tol    (optional) tolerance for comparison, by default 0.0 which means do byte-by-byte comparison ( relevant only for mode=WAVE_DATA )
Function CHECK_EQUAL_WAVES(wv1, wv2, [mode, tol])
  Wave/Z wv1, wv2
  variable mode, tol

  if(ParamIsDefault(mode) && ParamIsDefault(tol))
      EQUAL_WAVE_WRAPPER(wv1, wv2, CHECK_MODE)
  elseif(ParamIsDefault(tol))
      EQUAL_WAVE_WRAPPER(wv1, wv2, CHECK_MODE, mode=mode)
  elseif(ParamIsDefault(mode))
      EQUAL_WAVE_WRAPPER(wv1, wv2, CHECK_MODE, tol=tol)
  else
      EQUAL_WAVE_WRAPPER(wv1, wv2, CHECK_MODE, tol=tol, mode=mode)
  endif
End

/// Checks two waves for equality
/// @param wv1    first wave
/// @param wv2    second wave
/// @param mode   (optional) features of both waves to compare, defaults to all modes, defined at @ref CheckWaveModes
/// @param tol    (optional) tolerance for comparison, by default 0.0 which means do byte-by-byte comparison ( relevant only for mode=WAVE_DATA )
Function REQUIRE_EQUAL_WAVES(wv1, wv2, [mode, tol])
  Wave/Z wv1, wv2
  variable mode, tol

  if(ParamIsDefault(mode) && ParamIsDefault(tol))
      EQUAL_WAVE_WRAPPER(wv1, wv2, REQUIRE_MODE)
  elseif(ParamIsDefault(tol))
      EQUAL_WAVE_WRAPPER(wv1, wv2, REQUIRE_MODE, mode=mode)
  elseif(ParamIsDefault(mode))
      EQUAL_WAVE_WRAPPER(wv1, wv2, REQUIRE_MODE, tol=tol)
  else
      EQUAL_WAVE_WRAPPER(wv1, wv2, REQUIRE_MODE, tol=tol, mode=mode)
  endif
End

///@}

///@addtogroup FolderAssertions
///@{

/// Warns if the current data folder is not empty
Function WARN_EMPTY_FOLDER()
  CDF_EMPTY_WRAPPER(WARN_MODE)
End

/// Checks that the current data folder is empty
Function CHECK_EMPTY_FOLDER()
  CDF_EMPTY_WRAPPER(CHECK_MODE)
End

/// Requires that the current data folder is empty
Function REQUIRE_EMPTY_FOLDER()
  CDF_EMPTY_WRAPPER(REQUIRE_MODE)
End
///@}

