dnl Check for SSDEEP Libraries
dnl CHECK_SSDEEP(ACTION-IF-FOUND [, ACTION-IF-NOT-FOUND])
dnl Sets:
dnl  SSDEEP_CFLAGS
dnl  SSDEEP_LDFLAGS

AC_DEFUN([CHECK_SSDEEP],
[dnl

SSDEEP_CFLAGS=""
SSDEEP_LDFLAGS=""
SSDEEP_LDADD=""

AC_ARG_WITH(
    ssdeep,
    [AC_HELP_STRING([--with-ssdeep=PATH],[Path to ssdeep prefix])],
    [test_paths="${with_ssdeep}"],
    [test_paths="/usr/lib /usr/local/lib /usr/local/libfuzzy /usr/local/fuzzy /usr/local /opt/libfuzzy /opt/fuzzy /opt /usr"])

  AC_MSG_CHECKING([for ssdeep path])
  
  SSDEEP_LIB_NAME="fuzzy"
  SSDEEP_LIB_FILENAME="lib$SSDEEP_LIB_NAME.so"

  if test -z "$withssdeep" -o "$withssdeep" = "yes"; then
    for i in ${test_paths}; do
      if test -f "$i/$SSDEEP_LIB_FILENAME"; then
        SSDEEP_LIB_DIR="$i"
      fi
    done
    if test "$SSDEEP_LIB_DIR" = ""; then
      AC_MSG_ERROR(["Could not find '$SSDEEP_LIB_FILENAME'. Try specifying the path to the ssdeep build directory."])
    fi
  elif test "$withssdeep" = "no"; then
    AC_MSG_ERROR(["ssdeep support is disabled."])
  else
    if test -f "$withssdeep/$SSDEEP_LIB_FILENAME"; then
      SSDEEP_LIB_DIR="$withssdeep"
    else
      if test -f "$withssdeep/.libs/$SSDEEP_LIB_FILENAME"; then
        SSDEEP_LIB_DIR="$withssdeep/.libs/"
      else
        AC_MSG_ERROR(["Could not find ssdeep library '$withssdeep/.libs/$SSDEEP_LIB_FILENAME'. Try specifying the path to the ssdeep build directory."])
      fi
    fi
  fi

  SSDEEP_LDFLAGS="-L$SSDEEP_LIB_DIR -l$SSDEEP_LIB_NAME"
  SSDEEP_LDADD="-l$SSDEEP_LIB_NAME"

  if test -z "$withssdeep" -o "$withssdeep" = "yes"; then
    for i in /usr/include /usr/local/include; do
      if test -f "$i/$SSDEEP_LIB_NAME.h"; then
        SSDEEP_CFLAGS="-I$i"
      fi
    done
    if test "$SSDEEP_CFLAGS" = ""; then
      AC_MSG_ERROR(["Could not find ssdeep '$SSDEEP_LIB_NAME.h' header file. Try specifying the path to the ssdeep build directory."])
    fi
  else
    if test -f "$withssdeep/../$SSDEEP_LIB_NAME.h"; then
      SSDEEP_CFLAGS="-I$withssdeep/../"
    else
      if test -f "$withssdeep/$SSDEEP_LIB_NAME.h"; then
        SSDEEP_CFLAGS="-I$withssdeep"
      else
        AC_MSG_ERROR(["Could not find ssdeep '$SSDEEP_LIB_NAME.h' header file. Try specifying the path to the ssdeep build directory."])
      fi
    fi
  fi
  
 
AC_SUBST(SSDEEP_LDFLAGS)
AC_SUBST(SSDEEP_LDADD)
AC_SUBST(SSDEEP_CFLAGS)

    if test -z "${SSDEEP_CFLAGS}"; then
      ifelse([$2], , AC_MSG_NOTICE([optional ssdeep library not found]), $2)
    else
      AC_MSG_NOTICE([using ssdeep: ${SSDEEP_CFLAGS} ${SSDEEP_LDFLAGS}])
      SSDEEP_CFLAGS="-DWITH_SSDEEP ${SSDEEP_CFLAGS}"
      ifelse([$1], , , $1) 
    fi 

])
