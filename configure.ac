AC_PREREQ(2.59)
AC_INIT(ganeti-instance-opensuse, 0.1, carlos@pepelabs.net)

AC_CONFIG_AUX_DIR(autotools)
AC_CONFIG_SRCDIR(configure.ac)

AM_INIT_AUTOMAKE([1.9 foreign])

AC_ARG_WITH([os-dir],
  [AS_HELP_STRING([--with-os-dir=DIR],
    [top-level OS directory under which to install]
    [ (default is $datadir/ganeti/os)]
  )],
  [os_dir="$withval"],
  [os_dir="$datadir/ganeti/os"])
AC_SUBST(OS_DIR, $os_dir)

AC_PROG_AWK
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MKDIR_P

AC_PATH_PROG(DUMP, [dump])
if test -z "$DUMP" ; then
  AC_MSG_ERROR([dump not found in $PATH])
fi

AC_PATH_PROG(MAKEDEV, [MAKEDEV])
if test -z "$MAKEDEV" ; then
  AC_MSG_ERROR([MAKEDEV not found in $PATH])
fi

AC_PATH_PROG(LOSETUP, [losetup])
if test -z "$LOSETUP" ; then
  AC_MSG_ERROR([losetup not found in $PATH])
fi

AC_PATH_PROG(KPARTX, [kpartx])
if test -z "$KPARTX" ; then
  AC_MSG_ERROR([kpartx not found in $PATH])
fi

AC_PATH_PROG(RPM, [rpm])
if test -z "$RPM" ; then
  AC_MSG_ERROR([rpm not found in $PATH])
fi

AC_PATH_PROG(SFDISK, [sfdisk])
if test -z "$SFDISK" ; then
  AC_MSG_ERROR([sfdisk not found in $PATH])
fi

AC_PATH_PROG(ZYPPER, [zypper])
if test -z "$ZYPPER" ; then
  AC_MSG_ERROR([zypper not found in $PATH])
fi

AC_CONFIG_FILES([
  Makefile
  common.sh
])
AC_OUTPUT
