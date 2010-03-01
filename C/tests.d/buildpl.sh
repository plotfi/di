#!/bin/sh
#
#  Copyright 2010 Brad Lanam Walnut Creek, CA USA
#

echo ${EN} "build w/mkconfig.pl${EC}" >&3

cd ..
make distclean
instdir="`pwd`/test_di"
prefix=${instdir} LOCALEDIR=${prefix}/share/locale ./Build -mkpl
rc=$?

exit $rc
