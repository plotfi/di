#!/bin/sh
#
# $Id$
# $Revision$
#
# Copyright 2011-2012 Brad Lanam Walnut Creek, CA, USA
#

maindodisplay () {
  snm=$2
  if [ "$1" = "-d" ]; then
    echo $snm
    exit 0
  fi
}

maindoquery () {
  if [ "$1" = "-q" ]; then
    exit $2
  fi
}

chkccompiler () {
  if [ "${CC}" = "" ]; then
    echo ${EN} " no C compiler; skipped${EC}" >&5
    exit 0
  fi
}

chkdcompiler () {
  if [ "${DC}" = "" ]; then
    echo ${EN} " no D compiler; skipped${EC}" >&5
    exit 0
  fi
}

getsname () {
  tsnm=$1
  tsnm=`echo $tsnm | sed -e 's,.*/,,' -e 's,\.sh$,,'`
  scriptnm=${tsnm}
}

dosetup () {
  grc=0
  stag=$1
  shift
  script=$@
  set -f
}

dorunmkc () {
  drmclear="-C"
  if [ "$1" = "-nc" ];then
    drmclear=""
    shift
  fi
  case ${script} in
    *mkconfig.sh)
      ${_MKCONFIG_SHELL} ${script} -d `pwd` \
          ${drmclear} ${_MKCONFIG_RUNTESTDIR}/${scriptnm}.dat
      ;;
    *)
      perl ${script} ${drmclear} ${_MKCONFIG_RUNTESTDIR}/${scriptnm}.dat
      ;;
  esac
  if [ "$1" = "reqlibs" ]; then
    case $script in
      *mkconfig.sh)
        ${_MKCONFIG_SHELL} ${_MKCONFIG_RUNTOPDIR}/mkc.sh -d `pwd` -reqlib $2
        ;;
    esac
  fi
}

chkccompile () {
  fn=$1
  ${CC} -c ${CPPFLAGS} ${CFLAGS} ${fn}
  if [ $? -ne 0 ]; then
    echo "## compile of ${fn} failed"
    grc=1
  fi
}

chkouthcompile () {
  if [ $grc -eq 0 ]; then
    > testouth.c echo '
#include <stdio.h>
#include <out.h>
int main () { return 0; }
'
    chkccompile testouth.c
  fi
}

chkdcompile () {
  fn=$1

  bfn=$fn
  bfn=`echo $fn | sed 's/\.d$//'`
  cmd="${_MKCONFIG_DIR}/mkc.sh -d `pwd` -complink -e -c ${DC} \
      -o ${bfn}${OBJ_EXT} -- ${DFLAGS} ${fn} "
  eval ${cmd}
  if [ $? -ne 0 ]; then
    echo "## compile of ${fn} failed"
    grc=1
  fi
}

chkdiff () {
  f1=$1
  f2=$2

  echo "## diff of $f1 $f2"
  diff -b $f1 $f2
  rc=$?
  if [ $rc -ne 0 ]; then
    echo "## diff of $f1 $f2 failed"
    grc=$rc;
  fi
}

chkgrep () {
  pat=$1
  fn=$2
  arg=$3
  arg2=$4

  if [ "$arg" = "wc" ]; then
    tl=`egrep -l "$pat" ${fn} 2>/dev/null | wc -l`
    rc=$?
    if [ ${tl} -ne ${arg2} ]; then
      grc=1
    fi
  else
    egrep -l "$pat" ${fn} >/dev/null 2>&1
    rc=$?
  fi
  if [ "$arg" = "" -a $rc -ne 0 ]; then
    grc=$rc
    echo "## ${fn}: grep for '$pat' failed"
  fi
  if [ "$arg" = "neg" -a $rc -eq 0 ]; then
    grc=$rc
    echo "## ${fn}: grep for '$pat' succeeded when it should not"
  fi
}

chkouth () {
  xp=$1
  shift
  chkgrep "$xp" out.h $@
}

chkoutd () {
  xp=$1
  shift
  chkgrep "$xp" out.d $@
}

chkcache () {
  xp=$1
  shift
  chkgrep "$xp" mkconfig.cache $@
}

chkenv () {
  xp=$1
  shift
  chkgrep "$xp" test.env $@
}

testcleanup () {
  if [ "$stag" != "none" ]; then
    for x in out.h out.d testouth.c opts test.env mkconfig.log \
        mkconfig.cache mkconfig.reqlibs c.env \
	mkc_none_mkc.vars mkc_none_c.vars mkc_out_c.vars mkc_out_d.vars \
	mkc_none_env.vars \
	$@; do
      test -f ${x} && mv ${x} ${x}${stag}
    done
  fi
}
