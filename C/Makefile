#
#  di makefile - C
#
#  Copyright 2001-2018 Brad Lanam Walnut Creek CA, USA
#

CC = cc
# for tests.done
DC = gdc

OBJ_EXT = .o
EXE_EXT =
MAKE = make

###
# common programs
#
CAT = cat
CHGRP = chgrp
CHMOD = chmod
CHOWN = chown
CP = cp
LN = ln
MKDIR = mkdir
MV = mv
RM = rm
RPMBUILD = rpmbuild
SED = sed
TEST = test

###
# installation options
#
prefix = /usr/local
LOCALEDIR = $(prefix)/share/locale

###
# additional flags/libraries
#
DI_CPPFLAGS = -DDI_LOCALE_DIR=\"$(LOCALEDIR)\"

###
# mkconfig variables

MKC_DIR = ../mkconfig
MKCONFIG_TYPE = sh
MKC_REQLIB = di.reqlibs
MKC_TCLREQLIB = di-tcl.reqlibs

###
# main

# have to get various environment variables set up.

.PHONY: all
all:	all-sh

.PHONY: all-sh
all-sh:	di.env
	. ./di.env;$(MAKE) -e MKCONFIG_TYPE=sh di-programs

.PHONY: all-perl
all-perl:	di.env
	. ./di.env;$(MAKE) -e MKCONFIG_TYPE=perl di-programs

# tcl interface
.PHONY: tcl-sh
tcl-sh:	di-sh.env
	. ./di-sh.env;$(MAKE) -e MKCONFIG_TYPE=sh tcl-programs

# this is not working...need to research
#tcl-perl:	di-sh.env
#	. ./di-sh.env;$(MAKE) -e MKCONFIG_TYPE=perl tcl-programs

# perl interface
.PHONY: perl-sh
perl-sh:	di-sh.env
	. ./di-sh.env;$(MAKE) -e MKCONFIG_TYPE=sh perl-programs

.PHONY: perl-perl
perl-perl:	di-sh.env
	. ./di-sh.env;$(MAKE) -e MKCONFIG_TYPE=perl perl-programs

.PHONY: test
test:		tests.done

###
# environment

di.env:	features/env.dat ../dioptions.dat
	@-$(RM) -f di.env tests.done
	CC=$(CC) $(_MKCONFIG_SHELL) $(MKC_DIR)/mkconfig.sh features/env.dat

di-sh.env:	features/shenv.dat
	@-$(RM) -f di-sh.env tests.done
	CC=$(CC) $(_MKCONFIG_SHELL) $(MKC_DIR)/mkconfig.sh features/shenv.dat

###
# specific builds

# This was tested using vc++ 5.0. (many years ago)
# seriously out of date; config.cygwin.gcc is incorrect for this build.
.PHONY: windows
windows:
	@$(MAKE) ../dioptions.dat
	copy /y NUL: di.env
	-del config.h
	copy /y /b NUL:+configs\config.cygwin.gcc config.h
	copy /y NUL: $(MKC_REQLIB)
	$(MAKE) \
		CC=cl LD=cl EXE_EXT=".exe" OBJ_EXT=".obj" \
		CFLAGS="$(CFLAGS) -nologo -O2 \
		-DDEFAULT_FORMAT=\\\"MbuvpT\\\"" \
		LDFLAGS="-nologo -O2" di-programs

# This was tested using cygwin
.PHONY: windows-gcc
windows-gcc:
	@$(MAKE) ../dioptions.dat
	@echo ':' > di.env;chmod a+rx di.env
	@-$(RM) -f config.h mkconfig.cache mkc*.vars tests.done
	$(CP) -f configs/config.cygwin.gcc config.h
	@echo '-lintl' > $(MKC_REQLIB)
	$(MAKE) \
		CC=gcc LD=gcc EXE_EXT=".exe" OBJ_EXT=".o" \
		CFLAGS="$(CFLAGS) -g -O2 \
		-DDEFAULT_FORMAT=\\\"MbuvpT\\\"" \
		LDFLAGS="-g -O2" di-programs

# Gets an immediate segmentation fault.
.PHONY: windows-clang
windows-clang:
	@$(MAKE) ../dioptions.dat
	@echo ':' > di.env;chmod a+rx di.env
	@-$(RM) -f config.h mkconfig.cache mkc*.vars tests.done
	$(CP) -f configs/config.cygwin.clang config.h
	@echo '-lintl' > $(MKC_REQLIB)
	$(MAKE) \
		CC=clang LD=clang EXE_EXT=".exe" OBJ_EXT=".o" \
		CFLAGS="$(CFLAGS) -g -O2 \
		--without-libintl-prefix \
		--without-libiconv-prefix \
		-DDEFAULT_FORMAT=\\\"MbuvpT\\\"" \
		LDFLAGS="-g -O2" di-programs

.PHONY: windows-msys
windows-msys:
	MAKE=mingw32-make
	cp ../features/dioptions.dat ../dioptions.dat
	> di.env
	-rm config.h
	cp configs/config.mingw config.h
	> $(MKC_REQLIB)
	$(MAKE) \
		MAKE=$(MAKE) \
		CC=gcc \
		EXE_EXT=".exe" OBJ_EXT=".o" \
		CFLAGS="$(CFLAGS) -g -O2 \
		-DDEFAULT_FORMAT=\\\"MbuvpT\\\"" \
		LDFLAGS="-g -O2" di-programs

.PHONY: windows-mingw
windows-mingw:
	MAKE=mingw32-make
	copy /y /b NUL:+..\features\dioptions.dat ..\dioptions.dat
	copy /y NUL: di.env
	-del config.h
	copy /y /b NUL:+configs\config.mingw config.h
	copy /y NUL: $(MKC_REQLIB)
	$(MAKE) \
		MAKE=$(MAKE) \
		CC=gcc LD=gcc \
		EXE_EXT=".exe" OBJ_EXT=".o" \
		CFLAGS="$(CFLAGS) -g -O2 \
		-DDEFAULT_FORMAT=\\\"MbuvpT\\\"" \
		LDFLAGS="-g -O2" mingw-di.exe

.PHONY: os2-gcc
os2-gcc:
	@echo ':' > di.env;chmod a+rx di.env
	$(MAKE) MKCONFIG_TYPE=perl \
		CC=gcc LD=gcc EXE_EXT=".exe" OBJ_EXT=".o" \
		CFLAGS="$(CFLAGS) -g -O2 \
		LDFLAGS="-g -O2 -Zexe" di.exe

.PHONY: bsd43-cc
bsd43-cc:
	@$(MAKE) ../dioptions.dat
	@echo ':' > di.env;chmod a+rx di.env
	@-$(RM) -f config.h mkconfig.cache mkc*.vars tests.done
	sleep 1
	$(CP) configs/config.bsd43.cc config.h
	sleep 1
	@touch $(MKC_REQLIB)
	$(MAKE) _MKCONFIG_SHELL=$(MKCONFIG_SHELL) \
		CC=cc LD=cc EXE_EXT="" OBJ_EXT=".o" \
		CFLAGS="$(CFLAGS) -O" \
		LDFLAGS="-O" di-programs

.PHONY: bsd43-gcc
bsd43-gcc:
	@$(MAKE) ../dioptions.dat
	@echo ':' > di.env;chmod a+rx di.env
	@-$(RM) -f config.h mkconfig.cache mkc*.vars tests.done
	sleep 1
	$(CP) configs/config.bsd43.gcc config.h
	sleep 1
	@touch $(MKC_REQLIB)
	$(MAKE) _MKCONFIG_SHELL=$(MKCONFIG_SHELL) \
		CC=gcc LD=gcc EXE_EXT="" OBJ_EXT=".o" \
		CFLAGS="$(CFLAGS) -O2" \
		LDFLAGS="-O2" di-programs

.PHONY: ultrix-cc
ultrix-cc:
	@$(MAKE) ../dioptions.dat
	@echo ':' > di.env;chmod a+rx di.env
	@-$(RM) -f config.h mkconfig.cache mkc*.vars tests.done
	sleep 1
	$(CP) configs/config.ultrix.cc config.h
	sleep 1
	@touch $(MKC_REQLIB)
	$(MAKE) _MKCONFIG_SHELL=$(MKCONFIG_SHELL) \
		CC=cc LD=cc EXE_EXT="" OBJ_EXT=".o" \
		CFLAGS="$(CFLAGS) -O" \
		LDFLAGS="-O" di-programs

.PHONY: ultrix-gcc
ultrix-gcc:
	@$(MAKE) ../dioptions.dat
	@echo ':' > di.env;chmod a+rx di.env
	@-$(RM) -f config.h mkconfig.cache mkc*.vars tests.done
	sleep 1
	$(CP) configs/config.ultrix.gcc config.h
	sleep 1
	@echo '-lintl' > $(MKC_REQLIB)
	$(MAKE) _MKCONFIG_SHELL=$(MKCONFIG_SHELL) \
		CC=gcc LD=gcc EXE_EXT="" OBJ_EXT=".o" \
		CFLAGS="$(CFLAGS) -O2" \
		LDFLAGS="-O2" di-programs

.PHONY: hpux-cc
hpux-cc:
	@$(MAKE) -e ../dioptions.dat
	@$(MAKE) CC=/usr/ccs/bin/cc -e di.env
	@-$(RM) -f config.h mkconfig.cache mkc*.vars tests.done
	sleep 1
	$(CP) configs/config.hpux.bcc config.h
	sleep 1;touch $(MKC_REQLIB)
	. ./di.env;$(MAKE) -e CC=/usr/ccs/bin/cc \
		_MKCONFIG_SHELL=$(MKCONFIG_SHELL) di-programs

.PHONY: xenix-cc
xenix-cc:
	@$(MAKE) ../dioptions.dat
	@echo ':' > di.env;chmod a+rx di.env
	@-$(RM) -f config.h mkconfig.cache mkc*.vars tests.done
	sleep 1
	$(CP) configs/conf.xenix.cc config.h
	sleep 1
	@touch $(MKC_REQLIB)
	$(MAKE) _MKCONFIG_SHELL=$(MKCONFIG_SHELL) \
		CC=cc LD=cc EXE_EXT="" OBJ_EXT=".o" \
		CFLAGS="$(CFLAGS) -O" \
		LDFLAGS="-O" di-programs

###
# cleaning

# leaves:
#   config.h configtcl.h di.reqlibs
#   ../dioptions.dat, tests.done, test_di, di.env, di-sh.env
.PHONY: clean
clean:
	@-$(RM) -rf di mi \
		di.exe mingw-di.exe mi.exe \
		tcldiskspace.bld diskspace.so diskspace.dylib diskspace.dll \
		perlfilesysdi.bld libdiperl.a \
		*.o *.obj mkconfig.log \
		tests.done _tmp_mkconfig tests.d/chksh* \
		mkconfig.cache mkc*.vars \
		getoptn_test* gconfig.h getoptn.reqlibs \
		mkconfig.reqlibs \
		Perl/Filesys-di-*.tar.gz \
		Perl/Makefile.old \
		>/dev/null 2>&1
	@-cd Perl; \
		if [ -f Makefile ]; then \
		$(MAKE) clean; \
		fi
	@-find . -name '*~' -print | xargs rm

# leaves:
#   _mkconfig_runtests, _tmp_mkconfig, ../dioptions.dat
#   tests.done, test_di
.PHONY: realclean
realclean:
	@$(MAKE) clean > /dev/null 2>&1
	@-$(RM) -rf config.h configtcl.h gconfig.h \
		di.env di-sh.env $(MKC_REQLIB) $(MKC_TCLREQLIB) \
		>/dev/null 2>&1

# leaves:
#   ../dioptions.dat
.PHONY: distclean
distclean:
	@$(MAKE) realclean > /dev/null 2>&1
	@-$(RM) -rf tests.done test_di \
		_mkconfig_runtests _tmp_mkconfig \
		*~ *.orig */*.orig \
		>/dev/null 2>&1
	@-cd Perl; \
		if [ -f Makefile ]; then \
		$(MAKE) distclean; \
		fi

###
# installation

.PHONY: install
install:	di-programs di.env
	. ./di.env;cd ..;$(MAKE) -e prefix=$(prefix) LOCALEDIR=$(LOCALEDIR) FROMDIR=C install

###
# programs

.PHONY: di-programs
di-programs:	di$(EXE_EXT)
.PHONY: tcl-programs
tcl-programs:	tcldiskspace.bld
.PHONY: perl-programs
perl-programs:	perlfilesysdi.bld

###
# configuration file

../dioptions.dat:	../features/dioptions.dat
	cd ../;$(MAKE) dioptions.dat

config.h:	di.env ../dioptions.dat features/mkconfig.dat
	@-$(RM) -f config.h tests.done
	@if [ "$(DI_NO_NLS)" != "" ]; then \
		echo "*** User requested no NLS"; \
		$(MKC_DIR)/mkc.sh -setopt -o ../dioptions.dat NLS F; fi
	@if [ "$(MKCONFIG_TYPE)" = "sh" -o "$(MKCONFIG_TYPE)" = "" ]; then \
		. ./di.env;$(_MKCONFIG_SHELL) \
		$(MKC_DIR)/mkconfig.sh \
		features/mkconfig.dat; fi
	@if [ "$(MKCONFIG_TYPE)" = "perl" ]; then \
		. ./di.env;perl \
		$(MKC_DIR)/mkconfig.pl \
		features/mkconfig.dat; fi

configtcl.h:	di-sh.env ../dioptions.dat features/mkconfig-tcl.dat
	@-$(RM) -f configtcl.h
	@if [ "$(MKCONFIG_TYPE)" = "sh" -o "$(MKCONFIG_TYPE)" = "" ]; then \
		. ./di-sh.env;$(_MKCONFIG_SHELL) \
		$(MKC_DIR)/mkconfig.sh \
		features/mkconfig-tcl.dat; fi
	@if [ "$(MKCONFIG_TYPE)" = "perl" ]; then \
		. ./di-sh.env;perl \
		$(MKC_DIR)/mkconfig.pl \
		features/mkconfig-tcl.dat; fi

$(MKC_REQLIB):	di.env config.h
	$(_MKCONFIG_SHELL) $(MKC_DIR)/mkc.sh -reqlib \
		-o $(MKC_REQLIB) config.h

$(MKC_TCLREQLIB):	di.env configtcl.h
	$(_MKCONFIG_SHELL) $(MKC_DIR)/mkc.sh -reqlib \
		-o $(MKC_TCLREQLIB) configtcl.h


###
# executables

LIBOBJECTS = dimain$(OBJ_EXT) didiskutil$(OBJ_EXT) \
		digetentries$(OBJ_EXT) digetinfo$(OBJ_EXT) \
		diquota$(OBJ_EXT)  display$(OBJ_EXT) getoptn$(OBJ_EXT) \
		options$(OBJ_EXT) realloc$(OBJ_EXT) strdup$(OBJ_EXT) \
		strstr$(OBJ_EXT) trimchar$(OBJ_EXT)

MAINOBJECTS = di$(OBJ_EXT)

TCLOBJECTS = tcldiskspace$(OBJ_EXT)

di$(EXE_EXT):	$(MKC_REQLIB) $(MAINOBJECTS) $(LIBOBJECTS)
	@echo "*** Using libs: `$(CAT) $(MKC_REQLIB)`"
	$(CC) -o di$(EXE_EXT) \
		$(LDFLAGS) $(MAINOBJECTS) $(LIBOBJECTS) $(LIBS) \
		`$(CAT) $(MKC_REQLIB)`

tcldiskspace.bld:	$(MKC_REQLIB) $(MKC_TCLREQLIB) $(TCLOBJECTS) \
		$(LIBOBJECTS)
	@echo "*** Using libs: `$(CAT) $(MKC_TCLREQLIB)` `$(CAT) $(MKC_REQLIB)`"
	$(_MKCONFIG_SHELL) $(MKC_DIR)/mkc.sh \
		-sharedlib -e diskspace$(SHLIB_EXT) \
		$(TCLOBJECTS) $(LIBOBJECTS) $(LIBS) \
		`$(CAT) $(MKC_TCLREQLIB)` `$(CAT) $(MKC_REQLIB)`
	touch tcldiskspace.bld

perlfilesysdi.bld:	$(MKC_REQLIB) $(LIBOBJECTS)
	@echo "*** Using libs: `$(CAT) $(MKC_REQLIB)`"
	$(_MKCONFIG_SHELL) $(MKC_DIR)/mkc.sh \
		-staticlib -e libdiperl \
		$(LIBOBJECTS) $(LIBS) \
		`$(CAT) $(MKC_REQLIB)`
	# Don't know how to pass additional libs to Makefile.PL
	# so pass all the information.
	( \
	cd Perl ; \
	perl Makefile.PL LIBS="-L.. -ldiperl `$(CAT) ../$(MKC_REQLIB)`" ; \
	make ; \
	make test ; \
	)
	touch perlfilesysdi.bld

mingw-di$(EXE_EXT):	$(MAINOBJECTS) $(LIBOBJECTS)
	$(CC) -o mingw-di$(EXE_EXT) \
		$(CFLAGS) $(LDFLAGS) $(LIBOBJECTS) $(LIBS)

###
# objects

di$(OBJ_EXT):		di.c config.h di.h dimain.h getoptn.h \
				options.h version.h
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $(DI_CPPFLAGS) di.c

tcldiskspace$(OBJ_EXT):		tcldiskspace.c config.h di.h \
				dimain.h getoptn.h \
				options.h
	$(CC) -c $(CFLAGS) $(CPPFLAGS) \
		$(DI_CPPFLAGS) tcldiskspace.c

dimain$(OBJ_EXT):	dimain.c config.h di.h dimain.h getoptn.h \
				options.h
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $(DI_CPPFLAGS) dimain.c

digetinfo$(OBJ_EXT):	digetinfo.c config.h di.h dimntopt.h
	$(CC) -c $(CFLAGS) $(CPPFLAGS) digetinfo.c

didiskutil$(OBJ_EXT):	didiskutil.c config.h di.h dimntopt.h
	$(CC) -c $(CFLAGS) $(CPPFLAGS) didiskutil.c

digetentries$(OBJ_EXT):	digetentries.c config.h di.h dimntopt.h
	$(CC) -c $(CFLAGS) $(CPPFLAGS) digetentries.c

diquota$(OBJ_EXT):	diquota.c config.h di.h
	$(CC) -c $(CFLAGS) $(CPPFLAGS) diquota.c

display$(OBJ_EXT):	display.c config.h di.h display.h options.h version.h
	$(CC) -c $(CFLAGS) $(CPPFLAGS) display.c

getoptn$(OBJ_EXT):	getoptn.c config.h getoptn.h
	$(CC) -c $(CFLAGS) $(CPPFLAGS) getoptn.c

options$(OBJ_EXT):	options.c config.h di.h options.h
	$(CC) -c $(CFLAGS) $(CPPFLAGS) options.c

realloc$(OBJ_EXT):	realloc.c config.h di.h
	$(CC) -c $(CFLAGS) $(CPPFLAGS) realloc.c

strdup$(OBJ_EXT):	strdup.c config.h di.h
	$(CC) -c $(CFLAGS) $(CPPFLAGS) strdup.c

strstr$(OBJ_EXT):	strstr.c config.h di.h
	$(CC) -c $(CFLAGS) $(CPPFLAGS) strstr.c

trimchar$(OBJ_EXT):	trimchar.c config.h di.h
	$(CC) -c $(CFLAGS) $(CPPFLAGS) trimchar.c

###
# regression testing

.PHONY: all-test
all-test:	tests.done

tests.done: $(MKC_DIR)/runtests.sh
	@echo "## running tests"
	CC=$(CC) DC=$(DC) $(_MKCONFIG_SHELL) \
		$(MKC_DIR)/runtests.sh ./tests.d
	touch tests.done

# needs environment
.PHONY: testrpmbuild
testrpmbuild:
	-$(TEST) -d ./rpmbuild && rm -rf ./rpmbuild
	$(MKDIR) -p ./rpmbuild/SOURCES
	$(MKDIR) -p ./rpmbuild/BUILD
	$(CP) -f $(DI_DIR)/di-$(DI_VERSION).tar.gz ./rpmbuild/SOURCES
	$(RPMBUILD) --define="_topdir `pwd`/rpmbuild" -ba ../di.spec
	$(TEST) -f ./rpmbuild/RPMS/$(MARCH)/di-$(DI_VERSION)-1.$(MARCH).rpm || exit 1
	$(TEST) -f ./rpmbuild/SRPMS/di-$(DI_VERSION)-1.src.rpm || exit 1
	$(TEST) -d ./rpmbuild && rm -rf ./rpmbuild

# needs environment
.PHONY: rtest-env
rtest-env:
	@echo "$(_MKCONFIG_SYSTYPE)"
	@echo "$(_MKCONFIG_SYSREV)"
	@echo "$(_MKCONFIG_SYSARCH)"
	@echo "$(CC)"
	@echo "$(_MKCONFIG_USING_GCC)"
	@echo "$(CFLAGS)"
	@echo "$(LDFLAGS)"
	@echo "$(LIBS)"
	@echo "$(OBJ_EXT)"
	@echo "$(EXE_EXT)"
	@echo "$(XMSGFMT)"

gconfig.h:	di.env features/getoptn.dat
	@-$(RM) -f gconfig.h
	@if [ "$(MKCONFIG_TYPE)" = "sh" -o "$(MKCONFIG_TYPE)" = "" ]; then \
		. ./di.env;$(_MKCONFIG_SHELL) \
		$(MKC_DIR)/mkconfig.sh \
		features/getoptn.dat; fi
	@if [ "$(MKCONFIG_TYPE)" = "perl" ]; then \
		. ./di.env;perl \
		$(MKC_DIR)/mkconfig.pl \
		features/getoptn.dat; fi

getoptn_test$(OBJ_EXT):	getoptn.c gconfig.h getoptn.h
	$(CC) -o getoptn_test$(OBJ_EXT) \
		-c $(CFLAGS) $(CPPFLAGS) $(DI_CPPFLAGS) \
		-DTEST_GETOPTN=1 getoptn.c

getoptn.reqlibs:	di.env gconfig.h
	$(_MKCONFIG_SHELL) $(MKC_DIR)/mkc.sh -reqlib \
		-o getoptn.reqlibs gconfig.h

getoptn_test.exe:	getoptn_test$(OBJ_EXT) getoptn.reqlibs
	$(CC) -o getoptn_test.exe $(LDFLAGS) getoptn_test$(OBJ_EXT) \
		`$(CAT) getoptn.reqlibs`

