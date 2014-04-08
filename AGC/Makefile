# Copyright 2003-2007,2009-2010 Ronald S. Burkey <info@sandroid.org>
#
# This file is part of yaAGC.
#
# yaAGC is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# yaAGC is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with yaAGC; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
# Filename:	Makefile
# Purpose:	This makefile is used (recursively) to build all
#		components of the Virtual AGC project, for Linux and
#		similar targets.
# Mods:		10/22/03 RSB	Wrote.
#		11/02/03 RSB	Added Luminary131.
#		11/13/03 RSB	Added Colossus249.
#		05/01/04 RSB	Now provide yadsky also as yaDSKY, after install.
#		05/06/04 RSB	Now installs *.ini.
#		05/13/04 RSB	Now excludes *CVS* and *snprj* from the tarball.
#		05/14/04 RSB	Added PREFIX (for setting the installation
#				directory.
#		05/18/04 RSB	Added a datestamp to the dev. snapshot.
#		05/31/04 RSB	Move snapshot to ftp.
#		07/03/04 RSB	Added the Validation directory.
#		07/14/04 RSB	Added ControlPulseSim
#		08/09/04 RSB	Eliminate the contents of autom4te.cache/* when 
#				building a snapshot.  (These contents mess up
#				'configure' on some systems.)
#		08/10/04 RSB	Added the Sim* shell scripts to the installable
#				files.
#		08/12/04 RSB	Added NVER.  Went to v0.90.
#		08/13/04 RSB	Went to v20040813
#		08/24/04 RSB	Exclude ephemeris data from development snapshot,
#				but make a second file for it.
#		08/25/04 RSB	Added yaIMU.
# 		08/29/04 RSB	Made snapshot-ephemeris a separate target from
#				snapshot.
#		08/30/04 RSB	Moved the directory for snapshots from ftp space
#				into http space.
#		09/02/04 RSB	Changed yaIMU to yaUniverse.
#		01/10/05 RSB	Added binLEMAP.
#		04/30/05 RSB	Added CFLAGS
#		05/08/05 RSB	Added a 'snapshot' target.
#		05/14/05 RSB	Made some Mac OS X related changes for 'snapshot'.
#		05/28/05 RSB	Added yaDEDA.
#		06/02/05 RSB	Added yaAGS.
#		06/14/05 RSB	Updated the version code.
#		06/19/05 RSB	Added the NOGUI=yes command-line option.
#		07/06/05 RSB	Added Artemis072
#		07/28/05 RSB	Oops!  Had multiple "snapshot" targets.
#		08/04/05 RSB	Added the CURSES variable.
#		08/06/05 RSB	Now detect build-platform type using the
#				OSTYPE environment variable, which seems to
#				be reasonably consistent in distinguishing
#				at least the following cases:
#					OSTYPE=linux	
#					OSTYPE=darwin	(MacOS X)
#					OSTYPE=msys	(Msys on Win32)
#					OSTYPE=cygwin	(CygWin on Win32)
#				All of these cases use the "linux" Makefile,
#				but with very minor flourishes, except the
#				Msys case, which uses Makefile.Win32 instead.
#		01/09/06 RSB	Removed the prefix '-' from the lines that
#				build Artemis072.
#		02/26/06 RSB	Now creates a script called VirtualAgcUninstall
#				during installation.
#		03/05/07 RSB	Changed the default compiler flags to include
#				"-DALLOW_BSUB".  This allows yaAGC and friends
#				to pass instructions in the BSUB register upon
#				exiting from an interrupt-service routine.
#		03/01/09 RSB	Updated the version code.
#		03/05/09 RSB	Now builds VirtualAGC.
#		03/06/09 RSB	There are new targets: 'default' is the same 
#				as 'all'.  'all-archs' is like 'all', except 
# 				that 'all' builds only for the native platform
#				while 'all-archs' is used when running under
#				Linux to create the Linux, Win32, and Mac
#				stuff.
#		03/11/09 RSB	yaTelemetry added.
#		03/12/09 RSB	yaDSKY replaced by yaDSKY2, by default..
#		03/13/09 RSB	Added provisions for replacing yaDEDA by yaDEDA2.
#		03/16/09 RSB	"make clean" would fail if ./configure hadn't
#				been performed due to the fact that it isn't
#				needed when yaDSKY and yaDEDA aren't built.
#		03/19/09 RSB	Will now *try* to build yaDSKY/yaDEDA even if
#				yaDSKY2/yaDEDA2 are selected, and vice-versa.
#				However, failure won't a fatal error.  If find
#				it useful for both to be available for 
#				debugging.
#		03/28/09 RSB	Merged in yaACA3.
#		04/14/09 RSB	Made some mods to help this build in Solaris.
#		04/25/09 RSB	Fixed dev snapshots to exclude .svn directories.
#		04/26/09 RSB	Backed out all of the stuff that relies on
#				Makefile.Win32, and most stuff for OS 
#				auto-detection.  Removed the "os" target.
#				Removed the "install" target.
#		05/02/09 RSB	Added DEV_STATIC to change builds of binary
#				installers so that the wxWidgets-based programs
#				are dynamic-linked rather than static-linked.
#				However, it doesn't appear to me as though it
#				would change the size of the binary packages
#				in any significant way to use the dynamic
#				libraries, so I don't bother to do it.
#				Updated to make work with FreeBSD (PC-BSD 7.1).
#				Adjusted for SOLARIS.
#		05/23/09 RSB	Added Comanche055 to the normal build sequence.
#		06/07/09 RSB	Added Luminary099 to the normal build sequence.
#		06/29/09 RSB	Added the 'listings' target.
#		08/02/09 RSB	Now that I got rid of libreadline on the Win32
#				productin build (yesterday), I'm beginning to
#				experience readline-related problems (but 
#				different ones) on Linux.  I'm completely
#				disabling readline for all platforms for now,
#				until these problems can be fixed.
#		09/08/09 JL	Commented out Artemis072 from main build. 
#		01/30/10 RSB	Added yaASM.
#		02/16/10 RSB	Adjustments associated with getting
#				Artemis072 into the installers.
#		02/20/10 RSB	Updated version to 20100220 for release.
#		2011-04-27 JL	Added Colossus237.
#		2011-05-26 JL	Cleanup and rearrange. Add a 'missions' target to
#				build all mission versions. Make use of
#				parens/braces consistent. Add some shortcut 
#				variables for use in sub-make actions.
#
# The build box is always Linux for cross-compiles.  For native compiles:
#	Use "make MACOSX=yes" for Mac OS X.
#	Use "make SOLARIS=yes" for Solaris.
#	Use "make WIN32=yes" for Windows.
#	Use "gmake FREEBSD=yes" for FreeBSD.
#	Use "make" for Linux.

# NVER is the overall version code for the release.
NVER:=\\\"20100220\\\"
DATE:=`date +%Y%m%d`

# DON'T CHANGE THE FOLLOWING SWITCH *********************************
# This switch determines whether or not wxWidgets programs are built
# statically linked or dynamically linked for the binary installers
# associated with the development snapshots.  It has nothing whatever
# to do with normal builds by normal users.  Uncommented, they're
# static.  Commented, they're dynamic.  And yes, DEV_STATIC *should*
# be repeated.  I haven't fully worked out yet how to get the dynamic
# libraries into the installers, however, so don't use them!
DEV_STATIC=DEV_STATIC=yes
# *******************************************************************

# Comment out the following line(s) to use yaDSKY rather than yaDSKY2 and/or 
# yaDEDA by yaDEDA2.  yaDSKY/yaDEDA have been replaced by yaDSKY2/yaDEDA2 
# principally because yaDSKY/yaDEDA are gtk+ based while yaDSKY2/yaDEDA2
# are wxWidgets based.  At present, I consider wxWidgets superior to gtk+
# (in this particular application) because: a) I can get it to work on a 
# wider range of platforms; b) I can link statically to it rather than 
# being forced to use shared libraries.  yaDSKY2/yaDEDA2 are drop-in 
# identically-featured replacements for yaDSKY/yaDEDA, except that certain
# options useful only in debugging or *only* for GTK+ aren't implemented.
# These include the --test-downlink, --relative-pixmaps, and --show-packets
# switches.  yaTelemetry has already been made available (and is the preferred
# method) to provide the --test-downlink functionaly.  And, of course, the 
# original versions of yaDSKY/yaDEDA are still available even though not 
# compiled by default.
YADSKY_SUFFIX=2
YADEDA_SUFFIX=2

# Uncomment the following line (or do 'make NOREADLINE=yes') if the build 
# gives errors related to readline.
NOREADLINE=yes

# The following line, if uncommented, allows my production builds for Win32
# to use libreadline.  If commented, they can't.  Native Win32 builds aren't
# affected.
#ReadlineForWin32=yes

# Uncomment the following line (or do 'make CURSES=yes') if the build fails
# with an indication that libcurses.a is needed.
#CURSES=yes

SNAP_PREFIX = /usr/local/yaAGC

# Some adjustments for building in Solaris
ifdef SOLARIS
#NOREADLINE=yes
LIBS+=-L/usr/local/lib
LIBS+=-lsocket
LIBS+=-lnsl
endif

# Some adjustments for building in Mac OS X
ifdef MACOSX
#NOREADLINE=yes
ISMACOSX:=MACOSX=yes
endif

# Some adjustments for building in FreeBSD
ifdef FREEBSD
LIBS+=`pkg-config --libs gtk+-2.0`
LIBS+=`pkg-config --libs glib`
endif

# GROUP is the main group to which the USER belongs.  This seems to be defined
# as an environment variable in Mac OS X, but not in Linux.  You can override this
# with a command-line assignment, but it is only used for the 'snapshot' target.
# For example, "make GROUP=wheel snapshot".  However, the default behavior should
# be okay in Linux or Mac OS X (I hope).
ifndef GROUP
GROUP = users
endif

# Note:  The default build uses no CFLAGS; this makes it easier for a user in
# the field to build it, since unexpected problems won't throw them for a loop.
# But I personally want to build with 
#	CFLAGS=-Wall -Werror
# to catch every possible problem before sending it out into the world.
ifeq ($(USER),rburkey)
WEBSITE=../sandroid.org/public_html/apollo
CFLAGS=-Wall -Werror -DALLOW_BSUB
yaACA=
else 
WEBSITE=..
CFLAGS=-DALLOW_BSUB
yaACA=-
endif

# Note:  The CURSES variable is misnamed.  It really is just any special libraries
# for yaAGC, yaAGS, or yaACA3 that depend on Win32 vs. non-Win32 native builds.
ifdef WIN32
EXT=.exe
CFLAGS+=-I/usr/local/include
LIBS+=-L/usr/local/lib
LIBS+=-lkernel32
LIBS+=-lwsock32
CURSES=../yaAGC/random.c
CURSES+=-lregex
else
CURSES=-lcurses
endif

# We assume a *nix build environment.

include Makefile.yaAGC
ifndef PREFIX
PREFIX=/usr/local
endif

BUILD = $(MAKE) PREFIX=$(PREFIX) NVER=$(NVER) CFLAGS="$(CFLAGS)" CURSES="$(CURSES)" LIBS2="$(LIBS)" NOREADLINE=$(NOREADLINE) ReadlineForWin32=$(ReadlineForWin32) $(ARCHS) EXT=$(EXT)

# List of mission software directories to be built.
MISSIONS = Luminary131 Colossus249 Comanche055 Luminary099 Artemis072 Colossus237 # Solarium055

SUBDIRS = Tools yaLEMAP yaAGC yaAGS
ifndef NOGUI
ifeq "$(YADEDA_SUFFIX)" ""
SUBDIRS += yaDEDA/src
else
SUBDIRS += yaDEDA2
endif
ifeq "$(YADSKY_SUFFIX)" ""
SUBDIRS += yaDSKY/src
else
SUBDIRS += yaDSKY2
endif
endif
SUBDIRS += yaYUL yaUniverse yaACA2
ifndef WIN32
SUBDIRS += yaACA
endif
SUBDIRS += yaACA3
SUBDIRS += $(MISSIONS)
SUBDIRS += Validation ControlPulseSim yaTelemetry jWiz VirtualAGC
.PHONY: $(SUBDIRS)

.PHONY: default
default: all

.PHONY: all all-archs

.PHONY: missions $(MISSIONS) clean-missions
missions: $(MISSIONS)

$(MISSIONS): yaYUL
	$(BUILD) -C $@

clean-missions:
	for subdir in $(MISSIONS) ; do make -C $$subdir clean ; done

.PHONY: corediffs
corediffs: yaYUL Tools
	for subdir in $(MISSIONS) ; do make -C $$subdir corediff.txt ; done

all: ARCHS=default
all-archs: ARCHS=all-archs
all all-archs: $(SUBDIRS)

Tools yaLEMAP yaAGC yaAGS yaYUL yaUniverse yaACA2 yaACA yaACA3 ControlPulseSim:
	$(BUILD) -C $@ 

yaDEDA:
	$(BUILD) -C yaDEDA/src -f Makefile.all-archs 
	-$(BUILD) -C yaDEDA2 $(DEV_STATIC)

yaDEDA2:
	-$(BUILD) -C yaDEDA/src -f Makefile.all-archs 
	$(BUILD) -C $@ $(DEV_STATIC)

yaDSKY:
	-$(BUILD) -C yaDSKY/src -f Makefile.all-archs 
	-cp yaDSKY/src/yadsky yaDSKY/src/yaDSKY
	$(BUILD) -C yaDSKY2 $(DEV_STATIC)

yaDSKY2:
	-$(BUILD) -C yaDSKY/src -f Makefile.all-archs 
	-cp yaDSKY/src/yadsky yaDSKY/src/yaDSKY
	$(BUILD) -C $@ $(DEV_STATIC)

yaTelemetry:
	$(BUILD) -C $@ $(DEV_STATIC)

jWiz:
	$(BUILD) -C $@ $(ISMACOSX) $(DEV_STATIC)

VirtualAGC:
	$(BUILD) -C $@ "YADSKY_SUFFIX=$(YADSKY_SUFFIX)" "YADEDA_SUFFIX=$(YADEDA_SUFFIX)" $(ISMACOSX) $(DEV_STATIC)

# This target is for making HTML assembly listings for the website.
.PHONY: listings
AGC_LISTINGS = $(addprefix listing-agc-, $(MISSIONS))
listings: $(AGC_LISTINGS) listing-aea-FP6 listing-aea-FP8

listing-agc-%:
	rm -f $(WEBSITE)/listings/$*/*.html
	mkdir -p $(WEBSITE)/listings/$*
	cd $* && ../yaYUL/yaYUL --html MAIN.agc >MAIN.lst
	mv $*/*.agc.html $(WEBSITE)/listings/$*
	cp Apollo32.png $(WEBSITE)/listings/$*

listing-aea-%:
	rm -f $(WEBSITE)/listings/$*/*.html
	mkdir -p $(WEBSITE)/listings/$*
	cd $* && ../yaLEMAP/yaLEMAP --html $*.aea
	mv $*/*.aea.html $(WEBSITE)/listings/$*
	cp Apollo32.png $(WEBSITE)/listings/$*

# Here are targets for building the development snapshot, 
# creating the binary installers, and updating local directory
# which sources the Virtual AGC website.  The "snapshot" target
# does this locally, whilst the "buildbox" target does it on a
# (remote) box with a controlled build environment.

.PHONY: snapshot
snapshot: dev binaries

.PHONY: buildbox
buildbox: dev
	sh ./BuildBox.sh

.PHONY: binaries
binaries: clean all-archs
	cp -a VirtualAGC/VirtualAGC-installer $(WEBSITE)/Downloads
	cp -a VirtualAGC/VirtualAGC-setup.exe $(WEBSITE)/Downloads
	cp -a VirtualAGC/VirtualAGC.app.tar.gz $(WEBSITE)/Downloads
	ls -ltr $(WEBSITE)/Downloads | tail -4

# I used this only for creating a development snapshot.  It's no use to anybody
# else, I expect.
.PHONY: dev
dev:	clean
	rm -f $(WEBSITE)/Downloads/yaAGC-dev-$(DATE).tar.bz2
	tar -C .. --exclude=*CVS* --exclude=*snprj* --exclude="*.core" \
		--exclude=yaAGC/yaDSKY/autom4te.cache/* \
		--exclude=yaAGC/yaDSKY/configure \
		--exclude=yaAGC/yaDSKY/config.log \
		--exclude=yaAGC/yaDSKY/config.status \
		--exclude=yaAGC/yaDSKY/aclocal.m4 \
		--exclude=yaAGC/yaDSKY/Makefile.in \
		--exclude=yaAGC/yaDSKY/Makefile \
		--exclude=yaAGC/yaDEDA/autom4te.cache/* \
		--exclude=yaAGC/yaDEDA/configure \
		--exclude=yaAGC/yaDEDA/config.log \
		--exclude=yaAGC/yaDEDA/config.status \
		--exclude=yaAGC/yaDEDA/aclocal.m4 \
		--exclude=yaAGC/yaDEDA/Makefile.in \
		--exclude=yaAGC/yaDEDA/Makefile \
		--exclude=*~ --exclude=*.bak \
		--exclude=*.svn* \
		--exclude=*xvpics* \
		--bzip2 -cvf $(WEBSITE)/Downloads/yaAGC-dev-$(DATE).tar.bz2 yaAGC
	ls -ltr $(WEBSITE)/Downloads
		
snapshot-ephemeris:
	cd .. ; tar --bzip2 -cvf $(WEBSITE)/Downloads/yaAGC-ephemeris.tar.bz2 yaAGC/yaUniverse/*.txt
	ls -l $(WEBSITE)/Downloads

clean: clean-missions
	$(MAKE) -C yaLEMAP clean
	$(MAKE) -C yaASM clean
	$(MAKE) -C yaAGC clean
	$(MAKE) -C yaAGS clean
	$(MAKE) -C yaDSKY/src -f Makefile.all-archs clean
	rm -f yaDSKY/src/yaDSKY
	$(MAKE) -C yaDEDA/src -f Makefile.all-archs clean
	$(MAKE) -C yaYUL clean
	$(MAKE) -C yaUniverse clean
	$(yaACA)$(MAKE) -C yaACA clean
	$(yaACA)$(MAKE) -C yaACA2 clean
	$(yaACA)$(MAKE) -C yaACA3 clean
	$(MAKE) -C Luminary131 clean
	$(MAKE) -C Colossus249 clean
	$(MAKE) -C Comanche055 clean
	$(MAKE) -C Luminary099 clean
	$(MAKE) -C Artemis072 clean
	$(MAKE) -C Colossus237 clean
	$(MAKE) -C Validation clean
	$(MAKE) -C ControlPulseSim clean
	$(MAKE) -C VirtualAGC clean
	$(MAKE) -C yaTelemetry clean
	$(MAKE) -C jWiz clean
	$(MAKE) -C yaDSKY2 clean
	$(MAKE) -C yaDEDA2 clean
	$(MAKE) -C yaACA2 clean
	$(MAKE) -C Tools clean
	rm -f `find . -name "core"`

autogen:
	echo PREFIX=$(PREFIX) >Makefile.yaAGC
ifndef NOGUI
	cd yaDSKY && ./autogen.sh --prefix=$(PREFIX)
	cd yaDEDA && ./autogen.sh --prefix=$(PREFIX)
endif

