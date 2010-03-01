#!/bin/sh
#
#  Copyright 2010 Brad Lanam Walnut Creek, CA USA
#

echo ${EN} "rpmbuild${EC}" >&3

cd ..
. ./mkconfig.cache

if [ ${di_cfg__command_rpmbuild} = "0" ];then
  echo ${EN} " skipped${EC}" >&3
  exit 0
fi

rvers=`rpmbuild --version | tr -cd '0-9'`
if [ $rvers -lt 470 ]; then
  echo ${EN} " old version skipped${EC}" >&3
  exit 0
fi

DI_VERSION=`grep DI_VERSION version.h | sed  -e 's/"$//' -e 's/.*"//'`

grc=0
if [ -f di-${DI_VERSION}.tar.gz ]; then
  make DI_DIR="." DI_VERSION=${DI_VERSION} testrpmbuild
  rc=$?
  if [ $rc -ne 0 ]; then grc=$rc; fi
elif [ -f ../di-${DI_VERSION}.tar.gz ]; then
  make DI_DIR=".." DI_VERSION=${DI_VERSION} testrpmbuild
  rc=$?
  if [ $rc -ne 0 ]; then grc=$rc; fi
else
  echo "Unable to locate di-${DI_VERSION}.tar.gz"
  grc=1
fi

exit $grc
