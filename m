Return-Path: <cygwin-patches-return-6254-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23997 invoked by alias); 8 Mar 2008 15:30:40 -0000
Received: (qmail 23983 invoked by uid 22791); 8 Mar 2008 15:30:38 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 08 Mar 2008 15:30:16 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1JY102-0000pM-EZ 	for cygwin-patches@cygwin.com; Sat, 08 Mar 2008 15:30:14 +0000
Message-ID: <47D2B0B4.14B6EC5F@dessent.net>
Date: Sat, 08 Mar 2008 15:30:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [patch] reorganize utils/Makefile.in
Content-Type: multipart/mixed;  boundary="------------9D2D93C2007F81E5CEABFBE1"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00028.txt.bz2

This is a multi-part message in MIME format.
--------------9D2D93C2007F81E5CEABFBE1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 1281


This patch is a revamping of the Makefile in winsup/utils.  The current
Makefile.in is fugly, in my humble opinion.  It's got lots of repeated
rules and it's not very clear how one is supposed to add or change
things.  This patch does use GNU make specific features, but I'm quite
sure we already use them in other places, e.g. $(wildcard ...),
$(patsubst ...), $(shell ...) etc. are all GNU make features AFAIK and
those are all over the place in winsup.

I've also attached a copy of the patched Makefile.in if it's easier to
review that way; the diff is quite ugly.  As you can see the total
number of lines in the file is decreased by about 70, and that's
including a number of comments that I have added to document how to use
the file.

I have tried fairly hard to make sure that no actual behavior has
changed.  I diffed a before and after run and the only real difference
seemed to be the order that things ran, as well as a couple of flags
moved to a different spot in their commands.  I also tested the case
where libbfd.a/libintl.a are absent, causing the dumper parts to be
skipped as well as missing a MinGW zlib for cygcheck.  I haven't tested
a crosscompile but I can if that's necessary.  I have tested builds in
both a combined tree as well as just winsup.

Brian
--------------9D2D93C2007F81E5CEABFBE1
Content-Type: text/plain; charset=us-ascii;
 name="winsup_utils_makefile_reorg.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="winsup_utils_makefile_reorg.patch"
Content-length: 12101

2008-03-08  Brian Dessent  <brian@dessent.net>

	* Makefile.in: Reorganize considerably, using GNU make's
	static pattern rules and target-specific variables.

 Makefile.in |  229 +++++++++++++++++++++---------------------------------------
 1 file changed, 81 insertions(+), 148 deletions(-)

Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/utils/Makefile.in,v
retrieving revision 1.68
diff -u -p -r1.68 Makefile.in
--- Makefile.in	21 Dec 2007 03:32:46 -0000	1.68
+++ Makefile.in	8 Mar 2008 13:57:57 -0000
@@ -1,6 +1,6 @@
 # Makefile for Cygwin utilities
 # Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004,
-# 2005, 2006, 2007 Red Hat, Inc.
+# 2005, 2006, 2007, 2008 Red Hat, Inc.
 
 # This file is part of Cygwin.
 
@@ -36,161 +36,115 @@ override CXXFLAGS+=-fno-exceptions -fno-
 
 include $(srcdir)/../Makefile.common
 
-LIBICONV:=@libiconv@
-libbfd:=${shell $(CC) -B$(bupdir2)/bfd/ --print-file-name=libbfd.a}
-libintl:=${shell $(CC) -B$(bupdir2)/intl/ --print-file-name=libintl.a}
-build_dumper:=${shell test -r $(libbfd) -a -r $(libintl) -a -n "$(LIBICONV)" && echo 1}
-
-libz:=${shell x=$$($(CC) -mno-cygwin --print-file-name=libz.a); cd $$(dirname $$x); dir=$$(pwd); case "$$dir" in *mingw*) echo $$dir/libz.a ;; esac}
-zlib_h:=-include ${patsubst %/lib/mingw/libz.a,%/include/zlib.h,${patsubst %/lib/libz.a,%/include/zlib.h,$(libz)}}
-zconf_h:=${patsubst %/zlib.h,%/zconf.h,$(zlib_h)}
-ifeq "${libz}" ""
-zlib_h:=
-zconf_h:=
-libz:=
-endif
-
-DUMPER_INCLUDES:=-I$(bupdir2)/bfd -I$(updir1)/include
-
-libcygwin:=$(cygwin_build)/libcygwin.a
-libuser32:=$(w32api_lib)/libuser32.a
-libkernel32:=$(w32api_lib)/libkernel32.a
-ALL_DEP_LDLIBS:=$(libcygwin) $(w32api_lib)/libnetapi32.a \
-		$(w32api_lib)/libadvapi32.a $(w32api_lib)/libkernel32.a \
-		$(w32api_lib)/libuser32.a
-
-ALL_LDLIBS:=${patsubst $(w32api_lib)/lib%.a,-l%,\
-	      ${filter-out $(libuser32),\
-	       ${filter-out $(libkernel32),\
-		${filter-out $(libcygwin), $(ALL_DEP_LDLIBS)}}}}
-
-MINGW_LIB:=$(mingw_build)/libmingw32.a
-DUMPER_LIB:=${libbfd} ${libintl} -L$(bupdir1)/libiberty $(LIBICONV) -liberty
-MINGW_LDLIBS:=${filter-out $(libcygwin),$(ALL_LDLIBS) $(MINGW_LIB)}
-MINGW_DEP_LDLIBS:=${ALL_DEP_LDLIBS} ${MINGW_LIB}
-ALL_LDFLAGS:=-B$(newlib_build)/libc -B$(w32api_lib) $(LDFLAGS) $(ALL_LDLIBS)
-DUMPER_LDFLAGS:=$(ALL_LDFLAGS) $(DUMPER_LIB)
-MINGW_CXX:=${patsubst %/cygwin/include,%/mingw/include,${filter-out -I$(newlib_source)/%,$(COMPILE_CXX)}} -I$(updir)
-
-PROGS:=	cygcheck.exe cygpath.exe getfacl.exe kill.exe mkgroup.exe \
-	mkpasswd.exe mount.exe passwd.exe ps.exe regtool.exe setfacl.exe \
-	setmetamode.exe ssp.exe strace.exe umount.exe ipcrm.exe ipcs.exe
-
-CLEAN_PROGS:=$(PROGS)
-ifndef build_dumper
-PROGS:=warn_dumper $(PROGS)
-else
-PROGS+=dumper$(EXEEXT)
-CLEAN_PROGS+=dumper.exe
-endif
-
 .SUFFIXES:
 .NOEXPORT:
+.PHONY: all install clean realclean warn_dumper warn_cygcheck_zlib
 
-.PHONY: all install clean realclean warn_dumper
-
-all: Makefile $(PROGS)
-
-strace.exe: strace.o path.o $(MINGW_DEP_LDLIBS)
-ifdef VERBOSE
-	$(CXX) $(MINGW_CXXFLAGS) -o $@ ${wordlist 1,2,$^} -B$(mingw_build)/ $(MINGW_LDFLAGS)
-else
-	@echo $(CXX) -o $@ ${wordlist 1,2,$^} ${filter-out -B%, $(MINGW_CXXFLAGS) $(MINGW_LDFLAGS)};\
-	$(CXX) $(MINGW_CXXFLAGS) -o $@ ${wordlist 1,2,$^} -B$(mingw_build)/ $(MINGW_LDFLAGS)
-endif
-
-cygcheck.exe: cygcheck.o bloda.o path.o dump_setup.o $(MINGW_DEP_LDLIBS)
-ifeq "$(libz)" ""
-	@echo '*** Building cygcheck without package content checking due to missing mingw libz.a.'
-endif
-ifdef VERBOSE
-	$(CXX) $(MINGW_CXXFLAGS) -o $@ ${wordlist 1,4,$^} -B$(mingw_build)/ $(MINGW_LDFLAGS) $(libz)
+ALL_LDLIBS     := -lnetapi32 -ladvapi32
+ALL_LDFLAGS    := -B$(newlib_build)/libc -B$(w32api_lib) $(LDFLAGS) $(ALL_LDLIBS)
+ALL_DEP_LDLIBS := $(cygwin_build)/libcygwin.a ${patsubst -l%,\
+                    $(w32api_lib)/lib%.a,$(ALL_LDLIBS) -lkernel32 -luser32}
+
+MINGW_LIB        := $(mingw_build)/libmingw32.a
+MINGW_LDLIBS     := $(ALL_LDLIBS) $(MINGW_LIB)
+MINGW_DEP_LDLIBS := $(ALL_DEP_LDLIBS) $(MINGW_LIB)
+MINGW_CXX        := ${patsubst %/cygwin/include,%/mingw/include,\
+                      ${filter-out -I$(newlib_source)/%,$(COMPILE_CXX)}} -I$(updir)
+
+# List all binaries to be linked in Cygwin mode.  Each binary on this list
+# must have a corresponding .o of the same name.
+CYGWIN_BINS := ${addsuffix .exe,cygpath getfacl ipcrm ipcs kill mkgroup \
+        mkpasswd mount passwd ps regtool setfacl setmetamode ssp umount }
+
+# List all binaries to be linked in MinGW mode.  Each binary on this list
+# must have a corresponding .o of the same name.
+MINGW_BINS := ${addsuffix .exe,strace cygcheck}
+
+# List all objects to be compiled in MinGW mode.  Any object not on this
+# list will will be compiled in Cygwin mode implicitly, so there is no
+# need for a CYGWIN_OBJS.
+MINGW_OBJS := bloda.o cygcheck.o dump_setup.o path.o strace.o
+
+# If a binary should link in any objects besides the .o with the same
+# name as the binary, then list those here.
+strace.exe: path.o
+cygcheck.exe: bloda.o path.o dump_setup.o
+
+# Provide any necessary per-target variable overrides.
+cygpath.exe: ALL_LDFLAGS += -lntdll
+
+# Check for dumper's requirements and enable it if found.
+LIBICONV := @libiconv@
+libbfd   := ${shell $(CC) -B$(bupdir2)/bfd/ --print-file-name=libbfd.a}
+libintl  := ${shell $(CC) -B$(bupdir2)/intl/ --print-file-name=libintl.a}
+build_dumper := ${shell test -r $(libbfd) -a -r $(libintl) -a -n "$(LIBICONV)" && echo 1}
+ifdef build_dumper
+CYGWIN_BINS += dumper.exe
+dumper.o module_info.o parse_pe.o: CXXFLAGS += -I$(bupdir2)/bfd -I$(updir1)/include
+dumper.o parse_pe.o: dumper.h
+dumper.exe: module_info.o parse_pe.o
+dumper.exe: ALL_LDFLAGS += ${libbfd} ${libintl} -L$(bupdir1)/libiberty $(LIBICONV) -liberty
 else
-	@echo $(CXX) -o $@ ${wordlist 1,4,$^} ${filter-out -B%, $(MINGW_CXXFLAGS) $(MINGW_LDFLAGS)} $(libz);\
-	$(CXX) $(MINGW_CXXFLAGS) -o $@ ${wordlist 1,4,$^} -B$(mingw_build)/ $(MINGW_LDFLAGS) $(libz)
+all: warn_dumper
 endif
 
-dumper.o: dumper.cc dumper.h
-ifdef VERBOSE
-	${filter-out -nostdinc,$(COMPILE_CXX)} $c -o $@ $(DUMPER_INCLUDES) ${firstword $^}
+# Check for availability of a MinGW libz and enable for cygcheck.
+libz:=${shell x=$$($(CC) -mno-cygwin --print-file-name=libz.a); cd $$(dirname $$x); dir=$$(pwd); case "$$dir" in *mingw*) echo $$dir/libz.a ;; esac}
+ifdef libz
+zlib_h  := -include ${patsubst %/lib/mingw/libz.a,%/include/zlib.h,${patsubst %/lib/libz.a,%/include/zlib.h,$(libz)}}
+zconf_h := ${patsubst %/zlib.h,%/zconf.h,$(zlib_h)}
+dump_setup.o: MINGW_CXXFLAGS += $(zconf_h) $(zlib_h)
+cygcheck.exe: MINGW_LDFLAGS += $(libz)
 else
-	@echo $(CXX) $c $(CFLAGS) $(DUMPER_INCLUDES) ... $(basename $@).cc;\
-	${filter-out -nostdinc,$(COMPILE_CXX)} $c -o $(@D)/$(basename $@)$o $(DUMPER_INCLUDES) $<
+all: warn_cygcheck_zlib
 endif
 
-module_info.o: module_info.cc
-ifdef VERBOSE
-	${filter-out -nostdinc,$(COMPILE_CXX)} $c -o $@ $(DUMPER_INCLUDES) ${firstword $^}
-else
-	@echo $(CXX) $c $(CFLAGS) $(DUMPER_INCLUDES) ... $(basename $@).cc;\
-	${filter-out -nostdinc,$(COMPILE_CXX)} $c -o $(@D)/$(basename $@)$o $(DUMPER_INCLUDES) $<
-endif
+# the rest of this file contains generic rules
 
-parse_pe.o: parse_pe.cc dumper.h
-ifdef VERBOSE
-	${filter-out -nostdinc,$(COMPILE_CXX)} $c -o $@ $(DUMPER_INCLUDES) ${firstword $^}
-else
-	@echo $(CXX) $c $(CFLAGS) $(DUMPER_INCLUDES) ... $(basename $@).cc;\
-	${filter-out -nostdinc,$(COMPILE_CXX)} $c -o $(@D)/$(basename $@)$o $(DUMPER_INCLUDES) $<
-endif
+all: Makefile $(CYGWIN_BINS) $(MINGW_BINS)
 
-path.o: path.cc
+# how to compile a MinGW object
+$(MINGW_OBJS): %.o: %.cc
 ifdef VERBOSE
 	$(MINGW_CXX) $c -o $(@D)/$(basename $@)$o $(MINGW_CXXFLAGS) $<
 else
-	@echo $(MINGW_CXX) $c -o $(@D)/$(basename $@)$o $(MINGW_CXXFLAGS) ... $^;\
-	${MINGW_CXX} $c -o $(@D)/$(basename $@)$o $(MINGW_CXXFLAGS) $<
-endif
-
-dump_setup.o: dump_setup.cc
-ifdef VERBOSE
-	$(MINGW_CXX) $(zconf_h) $(zlib_h) $c -o $(@D)/$(basename $@)$o $(MINGW_CXXFLAGS) $<
-else
-	@echo $(MINGW_CXX) $c -o $(@D)/$(basename $@)$o $(MINGW_CXXFLAGS) ... $^;\
-	$(MINGW_CXX) $(zconf_h) $(zlib_h) $c -o $(@D)/$(basename $@)$o $(MINGW_CXXFLAGS) $<
+	@echo $(MINGW_CXX) $c $(MINGW_CXXFLAGS) ... $(*F).cc;\
+	$(MINGW_CXX) $c -o $(@D)/$(basename $@)$o $(MINGW_CXXFLAGS) $<
 endif
 
-bloda.o: bloda.cc
+# how to link a MinGW binary
+$(MINGW_BINS): %.exe: %.o
 ifdef VERBOSE
-	${MINGW_CXX} $c -o $(@D)/$(basename $@)$o $(MINGW_CXXFLAGS) -I$(updir) $<
+	$(CXX) $(MINGW_CXXFLAGS) -o $@ ${filter %.o,$^} -B$(mingw_build)/ $(MINGW_LDFLAGS)
 else
-	@echo $(MINGW_CXX) $c -o $(@D)/$(basename $@)$o $(MINGW_CXXFLAGS) ... $^;\
-	${MINGW_CXX} $c -o $(@D)/$(basename $@)$o $(MINGW_CXXFLAGS) -I$(updir) $<
+	@echo $(CXX) -o $@ ${filter %.o,$^} ${filter-out -B%, $(MINGW_CXXFLAGS) $(MINGW_LDFLAGS)};\
+	$(CXX) $(MINGW_CXXFLAGS) -o $@ ${filter %.o,$^} -B$(mingw_build)/ $(MINGW_LDFLAGS)
 endif
 
-cygcheck.o: cygcheck.cc
+# how to link a Cygwin binary
+$(CYGWIN_BINS): %.exe: %.o 
 ifdef VERBOSE
-	${MINGW_CXX} $c -o $(@D)/$(basename $@)$o $(MINGW_CXXFLAGS) -I$(updir) $<
+	$(CXX) -o $@ ${filter %.o,$^} -B$(cygwin_build)/ $(ALL_LDFLAGS)
 else
-	@echo $(MINGW_CXX) $c -o $(@D)/$(basename $@)$o $(MINGW_CXXFLAGS) ... $^;\
-	${MINGW_CXX} $c -o $(@D)/$(basename $@)$o $(MINGW_CXXFLAGS) -I$(updir) $<
+	@echo $(CXX) -o $@ ${filter %.o,$^} ... ${filter-out -B%, $(ALL_LDFLAGS)};\
+	$(CXX) -o $@ ${filter %.o,$^} -B$(cygwin_build)/ $(ALL_LDFLAGS)
 endif
 
-strace.o: strace.cc
-ifdef VERBOSE
-	$(MINGW_CXX) $c -o $(@D)/$(basename $@)$o $(MINGW_CXXFLAGS) -I$(updir) $<
-else
-	@echo $(MINGW_CXX) $c -o $(@D)/$(basename $@)$o $(MINGW_CXXFLAGS) ... $^;\
-	$(MINGW_CXX) $c -o $(@D)/$(basename $@)$o $(MINGW_CXXFLAGS) -I$(updir) $<
-endif
+# note: how to compile a Cygwin object is covered by the pattern rule in Makefile.common
 
-kill.exe: kill.o
-ifdef VERBOSE
-	$(CXX) -o $@ $^ -B$(cygwin_build)/ $(ALL_LDFLAGS) $(KILL_LIB)
-else
-	@echo $(CXX) -o $@ $^ ${filter-out -B%, $(ALL_LDFLAGS)};\
-	$(CXX) -o $@ $^ -B$(cygwin_build)/ $(ALL_LDFLAGS) $(KILL_LIB)
-endif
+# these dependencies ensure that the required in-tree libs are built first
+$(MINGW_BINS): $(MINGW_DEP_LDLIBS)
+$(CYGWIN_BINS): $(ALL_DEP_LDLIBS)
 
 clean:
-	rm -f *.o $(CLEAN_PROGS)
+	rm -f *.o $(CYGWIN_BINS) $(MINGW_BINS)
 
 realclean: clean
-	rm -f  Makefile config.cache
+	rm -f Makefile config.cache
 
 install: all
 	$(SHELL) $(updir1)/mkinstalldirs $(bindir)
-	for i in $(PROGS) ; do \
+	for i in $(CYGWIN_BINS) $(MINGW_BINS) ; do \
 	  n=`echo $$i | sed '$(program_transform_name)'`; \
 	  $(INSTALL_PROGRAM) $$i $(bindir)/$$n; \
 	done
@@ -198,7 +152,7 @@ install: all
 $(cygwin_build)/libcygwin.a: $(cygwin_build)/Makefile
 	@$(MAKE) -C $(@D) $(@F)
 
-$(mingw_build)/libmingw32.a: $(mingw_build)/Makefile
+$(MINGW_LIB): $(mingw_build)/Makefile
 	@$(MAKE) -C $(@D) $(@F)
 
 warn_dumper:
@@ -208,26 +162,5 @@ warn_dumper:
 	@echo '*** sources from sources.redhat.com.  Then, configure and build these'
 	@echo '*** libraries.  Otherwise, you can safely ignore this warning.'
 
-dumper.exe: module_info.o parse_pe.o dumper.o $(ALL_DEP_LDLIBS)
-ifdef VERBOSE
-	$(CXX) -o $@ ${wordlist 1,3,$^} -B$(cygwin_build)/ $(DUMPER_LDFLAGS)
-else
-	@echo $(CXX) -o $@ ${wordlist 1,3,$^} ${filter-out -B%, $(DUMPER_LDFLAGS)};\
-	$(CXX) -o $@ ${wordlist 1,3,$^} -B$(cygwin_build)/ $(DUMPER_LDFLAGS)
-endif
-
-cygpath.exe: cygpath.o $(ALL_DEP_LDLIBS)
-ifdef VERBOSE
-	$(CXX) -o $@ ${firstword $^} -B$(cygwin_build)/ $(ALL_LDFLAGS) -lntdll
-else
-	@echo $(CXX) -o $@ ${firstword $^} ${filter-out -B%, $(ALL_LDFLAGS) -lntdll};\
-	$(CXX) -o $@ ${firstword $^} -B$(cygwin_build)/ $(ALL_LDFLAGS) -lntdll
-endif
-
-%.exe: %.o $(ALL_DEP_LDLIBS)
-ifdef VERBOSE
-	$(CXX) -o $@ ${firstword $^} -B$(cygwin_build)/ $(ALL_LDFLAGS)
-else
-	@echo $(CXX) -o $@ ${firstword $^} ... ${filter-out -B%, $(ALL_LDFLAGS)};\
-	$(CXX) -o $@ ${firstword $^} -B$(cygwin_build)/ $(ALL_LDFLAGS)
-endif
+warn_cygcheck_zlib:
+	@echo '*** Building cygcheck without package content checking due to missing mingw libz.a.'

--------------9D2D93C2007F81E5CEABFBE1
Content-Type: text/plain; charset=us-ascii;
 name="Makefile.in"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Makefile.in"
Content-length: 5749

# Makefile for Cygwin utilities
# Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004,
# 2005, 2006, 2007, 2008 Red Hat, Inc.

# This file is part of Cygwin.

# This software is a copyrighted work licensed under the terms of the
# Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
# details.

SHELL:=@SHELL@

srcdir:=@srcdir@
VPATH:=@srcdir@
prefix:=@prefix@
exec_prefix:=@exec_prefix@

bindir:=@bindir@
program_transform_name:=@program_transform_name@

override INSTALL:=@INSTALL@
override INSTALL_PROGRAM:=@INSTALL_PROGRAM@
override INSTALL_DATA:=@INSTALL_DATA@

EXEEXT:=@EXEEXT@
EXEEXT_FOR_BUILD:=@EXEEXT_FOR_BUILD@

CC:=@CC@
CC_FOR_TARGET:=$(CC)
CXX:=@CXX@
CXX_FOR_TARGET:=$(CXX)

CFLAGS:=@CFLAGS@
CXXFLAGS:=@CXXFLAGS@
override CXXFLAGS+=-fno-exceptions -fno-rtti -DHAVE_DECL_GETOPT=0

include $(srcdir)/../Makefile.common

.SUFFIXES:
.NOEXPORT:
.PHONY: all install clean realclean warn_dumper warn_cygcheck_zlib

ALL_LDLIBS     := -lnetapi32 -ladvapi32
ALL_LDFLAGS    := -B$(newlib_build)/libc -B$(w32api_lib) $(LDFLAGS) $(ALL_LDLIBS)
ALL_DEP_LDLIBS := $(cygwin_build)/libcygwin.a ${patsubst -l%,\
                    $(w32api_lib)/lib%.a,$(ALL_LDLIBS) -lkernel32 -luser32}

MINGW_LIB        := $(mingw_build)/libmingw32.a
MINGW_LDLIBS     := $(ALL_LDLIBS) $(MINGW_LIB)
MINGW_DEP_LDLIBS := $(ALL_DEP_LDLIBS) $(MINGW_LIB)
MINGW_CXX        := ${patsubst %/cygwin/include,%/mingw/include,\
                      ${filter-out -I$(newlib_source)/%,$(COMPILE_CXX)}} -I$(updir)

# List all binaries to be linked in Cygwin mode.  Each binary on this list
# must have a corresponding .o of the same name.
CYGWIN_BINS := ${addsuffix .exe,cygpath getfacl ipcrm ipcs kill mkgroup \
        mkpasswd mount passwd ps regtool setfacl setmetamode ssp umount }

# List all binaries to be linked in MinGW mode.  Each binary on this list
# must have a corresponding .o of the same name.
MINGW_BINS := ${addsuffix .exe,strace cygcheck}

# List all objects to be compiled in MinGW mode.  Any object not on this
# list will will be compiled in Cygwin mode implicitly, so there is no
# need for a CYGWIN_OBJS.
MINGW_OBJS := bloda.o cygcheck.o dump_setup.o path.o strace.o

# If a binary should link in any objects besides the .o with the same
# name as the binary, then list those here.
strace.exe: path.o
cygcheck.exe: bloda.o path.o dump_setup.o

# Provide any necessary per-target variable overrides.
cygpath.exe: ALL_LDFLAGS += -lntdll

# Check for dumper's requirements and enable it if found.
LIBICONV := @libiconv@
libbfd   := ${shell $(CC) -B$(bupdir2)/bfd/ --print-file-name=libbfd.a}
libintl  := ${shell $(CC) -B$(bupdir2)/intl/ --print-file-name=libintl.a}
build_dumper := ${shell test -r $(libbfd) -a -r $(libintl) -a -n "$(LIBICONV)" && echo 1}
ifdef build_dumper
CYGWIN_BINS += dumper.exe
dumper.o module_info.o parse_pe.o: CXXFLAGS += -I$(bupdir2)/bfd -I$(updir1)/include
dumper.o parse_pe.o: dumper.h
dumper.exe: module_info.o parse_pe.o
dumper.exe: ALL_LDFLAGS += ${libbfd} ${libintl} -L$(bupdir1)/libiberty $(LIBICONV) -liberty
else
all: warn_dumper
endif

# Check for availability of a MinGW libz and enable for cygcheck.
libz:=${shell x=$$($(CC) -mno-cygwin --print-file-name=libz.a); cd $$(dirname $$x); dir=$$(pwd); case "$$dir" in *mingw*) echo $$dir/libz.a ;; esac}
ifdef libz
zlib_h  := -include ${patsubst %/lib/mingw/libz.a,%/include/zlib.h,${patsubst %/lib/libz.a,%/include/zlib.h,$(libz)}}
zconf_h := ${patsubst %/zlib.h,%/zconf.h,$(zlib_h)}
dump_setup.o: MINGW_CXXFLAGS += $(zconf_h) $(zlib_h)
cygcheck.exe: MINGW_LDFLAGS += $(libz)
else
all: warn_cygcheck_zlib
endif

# the rest of this file contains generic rules

all: Makefile $(CYGWIN_BINS) $(MINGW_BINS)

# how to compile a MinGW object
$(MINGW_OBJS): %.o: %.cc
ifdef VERBOSE
	$(MINGW_CXX) $c -o $(@D)/$(basename $@)$o $(MINGW_CXXFLAGS) $<
else
	@echo $(MINGW_CXX) $c $(MINGW_CXXFLAGS) ... $(*F).cc;\
	$(MINGW_CXX) $c -o $(@D)/$(basename $@)$o $(MINGW_CXXFLAGS) $<
endif

# how to link a MinGW binary
$(MINGW_BINS): %.exe: %.o
ifdef VERBOSE
	$(CXX) $(MINGW_CXXFLAGS) -o $@ ${filter %.o,$^} -B$(mingw_build)/ $(MINGW_LDFLAGS)
else
	@echo $(CXX) -o $@ ${filter %.o,$^} ${filter-out -B%, $(MINGW_CXXFLAGS) $(MINGW_LDFLAGS)};\
	$(CXX) $(MINGW_CXXFLAGS) -o $@ ${filter %.o,$^} -B$(mingw_build)/ $(MINGW_LDFLAGS)
endif

# how to link a Cygwin binary
$(CYGWIN_BINS): %.exe: %.o 
ifdef VERBOSE
	$(CXX) -o $@ ${filter %.o,$^} -B$(cygwin_build)/ $(ALL_LDFLAGS)
else
	@echo $(CXX) -o $@ ${filter %.o,$^} ... ${filter-out -B%, $(ALL_LDFLAGS)};\
	$(CXX) -o $@ ${filter %.o,$^} -B$(cygwin_build)/ $(ALL_LDFLAGS)
endif

# note: how to compile a Cygwin object is covered by the pattern rule in Makefile.common

# these dependencies ensure that the required in-tree libs are built first
$(MINGW_BINS): $(MINGW_DEP_LDLIBS)
$(CYGWIN_BINS): $(ALL_DEP_LDLIBS)

clean:
	rm -f *.o $(CYGWIN_BINS) $(MINGW_BINS)

realclean: clean
	rm -f Makefile config.cache

install: all
	$(SHELL) $(updir1)/mkinstalldirs $(bindir)
	for i in $(CYGWIN_BINS) $(MINGW_BINS) ; do \
	  n=`echo $$i | sed '$(program_transform_name)'`; \
	  $(INSTALL_PROGRAM) $$i $(bindir)/$$n; \
	done

$(cygwin_build)/libcygwin.a: $(cygwin_build)/Makefile
	@$(MAKE) -C $(@D) $(@F)

$(MINGW_LIB): $(mingw_build)/Makefile
	@$(MAKE) -C $(@D) $(@F)

warn_dumper:
	@echo '*** Not building dumper.exe since some required libraries are'
	@echo '*** missing: libbfd.a and libintl.a.'
	@echo '*** If you need this program, check out the naked-bfd and naked-intl'
	@echo '*** sources from sources.redhat.com.  Then, configure and build these'
	@echo '*** libraries.  Otherwise, you can safely ignore this warning.'

warn_cygcheck_zlib:
	@echo '*** Building cygcheck without package content checking due to missing mingw libz.a.'

--------------9D2D93C2007F81E5CEABFBE1--

