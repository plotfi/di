#
#  di makefile - D
#
#  Copyright 2011 Brad Lanam Walnut Creek CA, USA
#

OBJ_EXT = .o
EXE_EXT =

CC = cc
DC = gdc

#
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

###
# mkconfig variables

MKC_DIR = ../mkconfig
MKCONFIG_TYPE = sh
MKC_REQLIB = di.reqlibs
# set to -e to echo command lines.
MKCECHO =

###
# main

# have to get various environment variables set up.

#        DTESTFLAGS="$$DC_OPT $$DC_RELEASE $$DC_INLINE" di-programs

# compiling w/o the unittest flag doesn't work w/incremental linking
.PHONY: all
all:	di.env
	. ./di.env; \
	$(MAKE) -e MKCONFIG_TYPE=sh \
		DTESTFLAGS="$$DC_UNITTEST" di-programs

#        DTESTFLAGS="$$DC_UNITTEST $$DC_COV $$DC_DEBUG" \

.PHONY: all-test
all-test: di.env
	. ./di.env; \
	$(MAKE) -e MKCONFIG_TYPE=sh \
		DTESTFLAGS="$$DC_UNITTEST $$DC_COV " \
		LIBS="$(LIBS) $$DC_LIBS" di-programs

###
# environment

#### possibly merge features/env.dat w/C version???

di.env:	features/env.dat ../dioptions.dat
	@-$(RM) -f di.env tests.done
	CFLAGS="-I`pwd`/../C" $(_MKCONFIG_SHELL) \
		$(MKC_DIR)/mkconfig.sh features/env.dat

###
# cleaning

# leaves:
#   config.d, di.env, di.reqlibs
.PHONY: clean
clean:
	@-rm -f di di.exe mi mi.exe \
		*.o *.obj *.lst *.gcno *.gcda *.gcov \
		mkconfig.log mkconfig.cache mkc*.vars *~ \
		> /dev/null 2>&1

# leaves:
#   _mkconfig_runtests, _tmp_mkconfig
.PHONY: realclean
realclean:
	@$(MAKE) clean > /dev/null 2>&1
	@-$(RM) -rf config.d di.env $(MKC_REQLIB) \
		>/dev/null 2>&1

# leaves:
.PHONY: distclean
distclean:
	@$(MAKE) realclean > /dev/null 2>&1
	@-$(RM) -rf _mkconfig_runtests _tmp_mkconfig test_di \
		>/dev/null 2>&1

###
# installation

.PHONY: install
install:	di-programs di.env
	. ./di.env;cd ..;$(MAKE) -e prefix=$(prefix) LOCALEDIR=$(LOCALEDIR) FROMDIR=D install

###
# programs

.PHONY: di-programs
di-programs:	di$(EXE_EXT)

###
# configuration file

../dioptions.dat:	../features/dioptions.dat
	cd ../;$(MAKE) dioptions.dat

config.d:	di.env ../dioptions.dat features/mkconfig.dat
	@-$(RM) -f config.d tests.done
	@if [ "$(DI_NO_NLS)" != "" ]; then \
		echo "*** User requested no NLS"; \
		$(MKC_DIR)/mkcsetopt.sh -o ../dioptions.dat NLS F; fi
	@. ./di.env;$(_MKCONFIG_SHELL) \
		$(MKC_DIR)/mkconfig.sh \
		features/mkconfig.dat; fi

$(MKC_REQLIB):	di.env config.d
	$(_MKCONFIG_SHELL) $(MKC_DIR)/mkc.sh -reqlib -o \
		$(MKC_REQLIB) config.d

###
# executables

OBJECTS = config$(OBJ_EXT) di$(OBJ_EXT) \
	dihelp$(OBJ_EXT) dilocale$(OBJ_EXT) \
	diquota$(OBJ_EXT) diskpart$(OBJ_EXT) display$(OBJ_EXT) \
	dispopts$(OBJ_EXT) digetoptn$(OBJ_EXT) options$(OBJ_EXT)

di$(EXE_EXT):	$(OBJECTS) $(MKC_REQLIB)
	$(_MKCONFIG_SHELL) $(MKC_DIR)/mkc.sh -link $(MKCECHO) -c $(DC) \
	-o di$(EXE_EXT) -r $(MKC_REQLIB) -- $(LDFLAGS) $(OBJECTS) $(LIBS)

###
# objects

config$(OBJ_EXT):	config.d
	$(_MKCONFIG_SHELL) $(MKC_DIR)/mkc.sh -comp $(MKCECHO) -c $(DC) -o $@ \
		-- $(DFLAGS) $(DTESTFLAGS) config.d

di$(OBJ_EXT):	di.d config$(OBJ_EXT) \
		diskpart$(OBJ_EXT) dihelp$(OBJ_EXT) \
		dilocale$(OBJ_EXT) diquota$(OBJ_EXT) \
		display$(OBJ_EXT) dispopts$(OBJ_EXT) \
		digetoptn$(OBJ_EXT) options$(OBJ_EXT)
	$(_MKCONFIG_SHELL) $(MKC_DIR)/mkc.sh -comp $(MKCECHO) -c $(DC) -o $@ \
		-- $(DFLAGS) $(DTESTFLAGS) di.d

digetoptn$(OBJ_EXT):	digetoptn.d config$(OBJ_EXT)
	$(_MKCONFIG_SHELL) $(MKC_DIR)/mkc.sh -comp $(MKCECHO) -c $(DC) -o $@ \
		-- $(DFLAGS) $(DTESTFLAGS) digetoptn.d

dihelp$(OBJ_EXT):	dihelp.d config$(OBJ_EXT) dilocale$(OBJ_EXT)
	$(_MKCONFIG_SHELL) $(MKC_DIR)/mkc.sh -comp $(MKCECHO) -c $(DC) -o $@ \
		-- $(DFLAGS) $(DTESTFLAGS) dihelp.d

dilocale$(OBJ_EXT):	dilocale.d config$(OBJ_EXT)
	$(_MKCONFIG_SHELL) $(MKC_DIR)/mkc.sh -comp $(MKCECHO) -c $(DC) -o $@ \
		-- $(DFLAGS) $(DTESTFLAGS) dilocale.d

diquota$(OBJ_EXT):	diquota.d config$(OBJ_EXT) diskpart$(OBJ_EXT)
	$(_MKCONFIG_SHELL) $(MKC_DIR)/mkc.sh -comp $(MKCECHO) -c $(DC) -o $@ \
		-- $(DFLAGS) $(DTESTFLAGS) diquota.d

diskpart$(OBJ_EXT):	diskpart.d config$(OBJ_EXT)
	$(_MKCONFIG_SHELL) $(MKC_DIR)/mkc.sh -comp $(MKCECHO) -c $(DC) -o $@ \
		-- $(DFLAGS) $(DTESTFLAGS) diskpart.d

display$(OBJ_EXT):	display.d config$(OBJ_EXT) dilocale$(OBJ_EXT) \
		diskpart$(OBJ_EXT) dispopts$(OBJ_EXT) \
		options$(OBJ_EXT)
	$(_MKCONFIG_SHELL) $(MKC_DIR)/mkc.sh -comp $(MKCECHO) -c $(DC) -o $@ \
		-- $(DFLAGS) $(DTESTFLAGS) display.d

dispopts$(OBJ_EXT):	dispopts.d config$(OBJ_EXT)
	$(_MKCONFIG_SHELL) $(MKC_DIR)/mkc.sh -comp $(MKCECHO) -c $(DC) -o $@ \
		-- $(DFLAGS) $(DTESTFLAGS) dispopts.d

options$(OBJ_EXT):	options.d config$(OBJ_EXT) \
		dispopts$(OBJ_EXT) dihelp$(OBJ_EXT) digetoptn$(OBJ_EXT)
	$(_MKCONFIG_SHELL) $(MKC_DIR)/mkc.sh -comp $(MKCECHO) -c $(DC) -o $@ \
		-- $(DFLAGS) $(DTESTFLAGS) options.d

