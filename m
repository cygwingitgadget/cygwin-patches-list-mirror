Return-Path: <cygwin-patches-return-5863-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24461 invoked by alias); 22 May 2006 17:32:29 -0000
Received: (qmail 24050 invoked by uid 22791); 22 May 2006 17:32:24 -0000
X-Spam-Check-By: sourceware.org
Received: from palrel11.hp.com (HELO palrel11.hp.com) (156.153.255.246)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 22 May 2006 17:32:10 +0000
Received: from smtp2.ptp.hp.com (smtp2.ptp.hp.com [15.1.28.240]) 	by palrel11.hp.com (Postfix) with ESMTP id F3CE0340A7 	for <cygwin-patches@cygwin.com>; Mon, 22 May 2006 10:32:08 -0700 (PDT)
Received: from hpsje.cup.hp.com (hpsje.cup.hp.com [16.89.92.85]) 	by smtp2.ptp.hp.com (Postfix) with ESMTP id D3521255771 	for <cygwin-patches@cygwin.com>; Mon, 22 May 2006 17:32:08 +0000 (UTC)
Received: (from sje@localhost) by hpsje.cup.hp.com (8.9.3 (PHNE_24419+JAGae58098)/8.7.3 TIS Messaging 5.0) id KAA21829; Mon, 22 May 2006 10:32:08 -0700 (PDT)
Date: Mon, 22 May 2006 17:32:00 -0000
From: Steve Ellcey <sje@cup.hp.com>
Message-Id: <200605221732.KAA21829@hpsje.cup.hp.com>
To: cygwin-patches@cygwin.com
Subject: Re: Using newer autoconf in src/winsup directory
In-Reply-To: <20060521211801.GB26270@trixie.casa.cgf.cx>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00051.txt.bz2

> I tried to rebuild the top-level configure.in with autoconf 2.59 but
> there were a few complaints.  If you have patches to deal with the
> problems updating to a newer version, they would be appreciated.
> Otherwise, I'll probably wait for someone who knows more about autoconf
> to offer changes.
> 
> cgf

Here is a patch for all the configure scripts in winsup.  Note that I
created a new file acinclude.m4 in winsup, this means that you need to
run aclocal before running autoconf when regenerating the configure
scripts.  The advantage to this is that we can remove the duplicate
definitions of LIB_AC_PROG_CC_GNU, LIB_AC_PROG_CC, and LIB_AC_PROG_CXX
from the multiple configure scripts and just have one definition in
winsup/acinclude.m4.

I verified that I could regenerate all the configure scripts without
getting any errors or warnings with this patch but I didn't actually
build anything because I probably wouldn't know what to expect on any
system where I tried to build anyway so the patch needs more testing.

The changes made were to the definition of the LIB_AC_PROG_CC_GNU macro
(Changes were stolen from newlib.)  and in the handling of the
AC_CONFIG_SUBDIRS calls.  Everything else seemed to work fine.

Steve Ellcey
sje@cup.hp.com

2006-05-22  Steve Ellcey  <sje@cup.hp.com>

	* acinclude.m4: New.
	* aclocal.m4: Regenerate.
	* configure.in: Update to 2.59.
	* cygserver/configure.in: Ditto.
	* cygwin/configure.in: Ditto.
	* doc/configure.in: Ditto.
	* mingw/configure.in: Ditto.
	* mingw/mingwex/configure.in: Ditto.
	* mingw/profile/configure.in: Ditto.
	* subauth/configure.in: Ditto.
	* testsuite/configure.in: Ditto.
	* utils/configure.in: Ditto.
	* w32api/configure.in: Ditto.
	* configure: Regenerate.
	* cygserver/configure: Ditto.
	* cygwin/configure: Ditto.
	* doc/configure: Ditto.
	* mingw/configure: Ditto.
	* mingw/mingwex/configure: Ditto.
	* mingw/profile/configure: Ditto.
	* subauth/configure: Ditto.
	* testsuite/configure: Ditto.
	* utils/configure: Ditto.
	* w32api/configure: Ditto.

*** /proj/opensrc/nightly/src/src/winsup/acinclude.m4	Mon May 22 10:21:12 2006
--- /disk3/src/src/winsup/acinclude.m4	Mon May 22 09:47:03 2006
***************
*** 0 ****
--- 1,66 ----
+ dnl This provides configure definitions used by all the winsup
+ dnl configure.in files.
+ 
+ # FIXME: We temporarily define our own version of AC_PROG_CC.  This is
+ # copied from autoconf 2.12, but does not call AC_PROG_CC_WORKS.  We
+ # are probably using a cross compiler, which will not be able to fully
+ # link an executable.  This should really be fixed in autoconf
+ # itself.
+ 
+ AC_DEFUN([LIB_AC_PROG_CC_GNU],
+ [AC_CACHE_CHECK(whether we are using GNU C, ac_cv_prog_gcc,
+ [dnl The semicolon is to pacify NeXT's syntax-checking cpp.
+ cat > conftest.c <<EOF
+ #ifdef __GNUC__
+   yes;
+ #endif
+ EOF
+ if AC_TRY_COMMAND(${CC-cc} -E conftest.c) | egrep yes >/dev/null 2>&1; then
+   ac_cv_prog_gcc=yes
+ else
+   ac_cv_prog_gcc=no
+ fi])])
+ 
+ AC_DEFUN([LIB_AC_PROG_CC],
+ [AC_BEFORE([$0], [AC_PROG_CPP])dnl
+ AC_CHECK_PROG(CC, gcc, gcc)
+ _AM_DEPENDENCIES(CC)
+ if test -z "$CC"; then
+   AC_CHECK_PROG(CC, cc, cc, , , /usr/ucb/cc)
+   test -z "$CC" && AC_MSG_ERROR([no acceptable cc found in \$PATH])
+ fi
+ 
+ LIB_AC_PROG_CC_GNU
+ 
+ if test $ac_cv_prog_gcc = yes; then
+   GCC=yes
+ dnl Check whether -g works, even if CFLAGS is set, in case the package
+ dnl plays around with CFLAGS (such as to build both debugging and
+ dnl normal versions of a library), tasteless as that idea is.
+   ac_test_CFLAGS="${CFLAGS+set}"
+   ac_save_CFLAGS="$CFLAGS"
+   CFLAGS=
+   _AC_PROG_CC_G
+   if test "$ac_test_CFLAGS" = set; then
+     CFLAGS="$ac_save_CFLAGS"
+   elif test $ac_cv_prog_cc_g = yes; then
+     CFLAGS="-g -O2"
+   else
+     CFLAGS="-O2"
+   fi
+ else
+   GCC=
+   test "${CFLAGS+set}" = set || CFLAGS="-g"
+ fi
+ ])
+ 
+ AC_DEFUN([LIB_AC_PROG_CXX],
+ [AC_BEFORE([$0], [AC_PROG_CPP])dnl
+ AC_CHECK_TOOL(CXX, g++, g++)
+ if test -z "$CXX"; then
+   AC_CHECK_PROG(CXX, c++, c++, , , )
+   test -z "$CC" && AC_MSG_ERROR([no acceptable cc found in \$PATH])
+ fi
+ 
+ CXXFLAGS='$(CFLAGS)'
+ ])
*** /proj/opensrc/nightly/src/src/winsup/configure.in	Mon Jan 16 09:48:36 2006
--- /disk3/src/src/winsup/configure.in	Mon May 22 09:45:45 2006
*************** dnl details.
*** 9,70 ****
  dnl
  dnl Process this file with autoconf to produce a configure script.
  
! AC_PREREQ(2.12)dnl
  AC_INIT(Makefile.in)
  
  INSTALL=`cd $srcdir/..; echo $(pwd)/install-sh -c`
  
  AC_PROG_INSTALL
- 
- dnl FIXME: We temporarily define our own version of AC_PROG_CC.  This is
- dnl copied from autoconf 2.12, but does not call AC_PROG_CC_WORKS.  We
- dnl are probably using a cross compiler, which will not be able to fully
- dnl link an executable.  This should really be fixed in autoconf
- dnl itself.
- 
- AC_DEFUN(LIB_AC_PROG_CC,
- [AC_BEFORE([$0], [AC_PROG_CPP])dnl
- AC_CHECK_TOOL(CC, gcc, gcc)
- if test -z "$CC"; then
-   AC_CHECK_PROG(CC, cc, cc, , , /usr/ucb/cc)
-   test -z "$CC" && AC_MSG_ERROR([no acceptable cc found in \$PATH])
- fi
- 
- AC_PROG_CC_GNU
- 
- if test $ac_cv_prog_gcc = yes; then
-   GCC=yes
- dnl Check whether -g works, even if CFLAGS is set, in case the package
- dnl plays around with CFLAGS (such as to build both debugging and
- dnl normal versions of a library), tasteless as that idea is.
-   ac_test_CFLAGS="${CFLAGS+set}"
-   ac_save_CFLAGS="$CFLAGS"
-   CFLAGS=
-   AC_PROG_CC_G
-   if test "$ac_test_CFLAGS" = set; then
-     CFLAGS="$ac_save_CFLAGS"
-   elif test $ac_cv_prog_cc_g = yes; then
-     CFLAGS="-g -O2"
-   else
-     CFLAGS="-O2"
-   fi
- else
-   GCC=
-   test "${CFLAGS+set}" = set || CFLAGS="-g"
- fi
- ])
- 
- AC_DEFUN(LIB_AC_PROG_CXX,
- [AC_BEFORE([$0], [AC_PROG_CPP])dnl
- AC_CHECK_TOOL(CXX, g++, g++)
- if test -z "$CXX"; then
-   AC_CHECK_PROG(CXX, c++, c++, , , )
-   test -z "$CC" && AC_MSG_ERROR([no acceptable cc found in \$PATH])
- fi
- 
- CXXFLAGS='$(CFLAGS)'
- ])
- 
  AC_CANONICAL_SYSTEM
  
  LIB_AC_PROG_CC
--- 9,20 ----
  dnl
  dnl Process this file with autoconf to produce a configure script.
  
! AC_PREREQ(2.59)dnl
  AC_INIT(Makefile.in)
  
  INSTALL=`cd $srcdir/..; echo $(pwd)/install-sh -c`
  
  AC_PROG_INSTALL
  AC_CANONICAL_SYSTEM
  
  LIB_AC_PROG_CC
*************** no)	use_cygserver=;;
*** 79,100 ****
  esac
  ])
  
! SUBDIRS='cygwin w32api'
! test -d $srcdir/mingw && SUBDIRS="mingw $SUBDIRS"
  
  case "$with_cross_host" in
    ""|*cygwin*)
!     # test -d $srcdir/bz2lib && SUBDIRS="$SUBDIRS bz2lib"
!     # test -d $srcdir/zlib && SUBDIRS="$SUBDIRS zlib"
!     # test -d $srcdir/subauth && SUBDIRS="$SUBDIRS subauth"
!     test -n "$use_cygserver" -a -d $srcdir/cygserver && SUBDIRS="$SUBDIRS cygserver"
!     SUBDIRS="$SUBDIRS utils doc"
      ;;
  esac
  
- AC_CONFIG_SUBDIRS($SUBDIRS)
- 
  AC_PROG_MAKE_SET
  
- AC_SUBST(SUBDIRS)
  AC_OUTPUT(Makefile)
--- 29,56 ----
  esac
  ])
  
! AC_CONFIG_SUBDIRS(cygwin w32api)
! if test -d $srcdir/mingw; then
!   AC_CONFIG_SUBDIRS(mingw)
! fi
  
  case "$with_cross_host" in
    ""|*cygwin*)
!     if test -d $srcdir/bz2lib; then
!       AC_CONFIG_SUBDIRS(bz2lib)
!     fi
!     if test -d $srcdir/zlib; then
!       AC_CONFIG_SUBDIRS(zlib)
!     fi
!     if test -d $srcdir/subauth; then
!       AC_CONFIG_SUBDIRS(subauth)
!     fi
!     if ftest -n "$use_cygserver" -a -d $srcdir/cygserver; then
!       AC_CONFIG_SUBDIRS(cygserer)
!     AC_CONFIG_SUBDIRS(utils doc)
      ;;
  esac
  
  AC_PROG_MAKE_SET
  
  AC_OUTPUT(Makefile)
*** /proj/opensrc/nightly/src/src/winsup/cygserver/configure.in	Fri Jul 25 18:53:05 2003
--- /disk3/src/src/winsup/cygserver/configure.in	Mon May 22 09:52:28 2006
*************** dnl details.
*** 9,70 ****
  dnl
  dnl Process this file with autoconf to produce a configure script.
  
! AC_PREREQ(2.12)dnl
  AC_INIT(cygserver.cc)
  
  INSTALL=`cd $srcdir/../..; echo $(pwd)/install-sh -c`
  
  AC_PROG_INSTALL
- 
- dnl FIXME: We temporarily define our own version of AC_PROG_CC.  This is
- dnl copied from autoconf 2.12, but does not call AC_PROG_CC_WORKS.  We
- dnl are probably using a cross compiler, which will not be able to fully
- dnl link an executable.  This should really be fixed in autoconf
- dnl itself.
- 
- AC_DEFUN(LIB_AC_PROG_CC,
- [AC_BEFORE([$0], [AC_PROG_CPP])dnl
- AC_CHECK_TOOL(CC, gcc, gcc)
- if test -z "$CC"; then
-   AC_CHECK_PROG(CC, cc, cc, , , /usr/ucb/cc)
-   test -z "$CC" && AC_MSG_ERROR([no acceptable cc found in \$PATH])
- fi
- 
- AC_PROG_CC_GNU
- 
- if test $ac_cv_prog_gcc = yes; then
-   GCC=yes
- dnl Check whether -g works, even if CFLAGS is set, in case the package
- dnl plays around with CFLAGS (such as to build both debugging and
- dnl normal versions of a library), tasteless as that idea is.
-   ac_test_CFLAGS="${CFLAGS+set}"
-   ac_save_CFLAGS="$CFLAGS"
-   CFLAGS=
-   AC_PROG_CC_G
-   if test "$ac_test_CFLAGS" = set; then
-     CFLAGS="$ac_save_CFLAGS"
-   elif test $ac_cv_prog_cc_g = yes; then
-     CFLAGS="-gstabs+ -O2"
-   else
-     CFLAGS="-O2"
-   fi
- else
-   GCC=
-   test "${CFLAGS+set}" = set || CFLAGS="-g"
- fi
- ])
- 
- AC_DEFUN(LIB_AC_PROG_CXX,
- [AC_BEFORE([$0], [AC_PROG_CPP])dnl
- AC_CHECK_TOOL(CXX, g++, g++)
- if test -z "$CXX"; then
-   AC_CHECK_PROG(CXX, c++, c++, , , )
-   test -z "$CC" && AC_MSG_ERROR([no acceptable cc found in \$PATH])
- fi
- 
- CXXFLAGS='$(CFLAGS)'
- ])
- 
  AC_CANONICAL_SYSTEM
  
  LIB_AC_PROG_CC
--- 9,22 ----
  dnl
  dnl Process this file with autoconf to produce a configure script.
  
! AC_PREREQ(2.59)dnl
  AC_INIT(cygserver.cc)
  
+ AC_CONFIG_AUX_DIR(..)
+ 
  INSTALL=`cd $srcdir/../..; echo $(pwd)/install-sh -c`
  
  AC_PROG_INSTALL
  AC_CANONICAL_SYSTEM
  
  LIB_AC_PROG_CC
*** /proj/opensrc/nightly/src/src/winsup/cygwin/configure.in	Sun Aug  7 19:27:42 2005
--- /disk3/src/src/winsup/cygwin/configure.in	Mon May 22 09:49:56 2006
*************** dnl details.
*** 9,71 ****
  dnl
  dnl Process this file with autoconf to produce a configure script.
  
! AC_PREREQ(2.12)dnl
  AC_INIT(init.cc)
  AC_CONFIG_HEADER(config.h)
  
  INSTALL="/bin/sh "`cd $srcdir/../..; echo $(pwd)/install-sh -c`
  
  AC_PROG_INSTALL
- 
- dnl FIXME: We temporarily define our own version of AC_PROG_CC.  This is
- dnl copied from autoconf 2.12, but does not call AC_PROG_CC_WORKS.  We
- dnl are probably using a cross compiler, which will not be able to fully
- dnl link an executable.  This should really be fixed in autoconf
- dnl itself.
- 
- AC_DEFUN(LIB_AC_PROG_CC,
- [AC_BEFORE([$0], [AC_PROG_CPP])dnl
- AC_CHECK_TOOL(CC, gcc, gcc)
- if test -z "$CC"; then
-   AC_CHECK_PROG(CC, cc, cc, , , /usr/ucb/cc)
-   test -z "$CC" && AC_MSG_ERROR([no acceptable cc found in \$PATH])
- fi
- 
- AC_PROG_CC_GNU
- 
- if test $ac_cv_prog_gcc = yes; then
-   GCC=yes
- dnl Check whether -g works, even if CFLAGS is set, in case the package
- dnl plays around with CFLAGS (such as to build both debugging and
- dnl normal versions of a library), tasteless as that idea is.
-   ac_test_CFLAGS="${CFLAGS+set}"
-   ac_save_CFLAGS="$CFLAGS"
-   CFLAGS=
-   AC_PROG_CC_G
-   if test "$ac_test_CFLAGS" = set; then
-     CFLAGS="$ac_save_CFLAGS"
-   elif test $ac_cv_prog_cc_g = yes; then
-     CFLAGS="-gstabs+ -O2"
-   else
-     CFLAGS="-O2"
-   fi
- else
-   GCC=
-   test "${CFLAGS+set}" = set || CFLAGS="-g"
- fi
- ])
- 
- AC_DEFUN(LIB_AC_PROG_CXX,
- [AC_BEFORE([$0], [AC_PROG_CPP])dnl
- AC_CHECK_TOOL(CXX, g++, g++)
- if test -z "$CXX"; then
-   AC_CHECK_PROG(CXX, c++, c++, , , )
-   test -z "$CC" && AC_MSG_ERROR([no acceptable cc found in \$PATH])
- fi
- 
- CXXFLAGS='$(CFLAGS)'
- ])
- 
  AC_CANONICAL_SYSTEM
  
  LIB_AC_PROG_CC
--- 9,23 ----
  dnl
  dnl Process this file with autoconf to produce a configure script.
  
! AC_PREREQ(2.59)dnl
  AC_INIT(init.cc)
  AC_CONFIG_HEADER(config.h)
  
+ AC_CONFIG_AUX_DIR(..)
+ 
  INSTALL="/bin/sh "`cd $srcdir/../..; echo $(pwd)/install-sh -c`
  
  AC_PROG_INSTALL
  AC_CANONICAL_SYSTEM
  
  LIB_AC_PROG_CC
*** /proj/opensrc/nightly/src/src/winsup/doc/configure.in	Mon Dec  3 20:20:30 2001
--- /disk3/src/src/winsup/doc/configure.in	Mon May 22 09:56:33 2006
*************** dnl details.
*** 9,49 ****
  
  dnl Process this file with autoconf to produce a configure script.
  
! AC_PREREQ(2.12)
  AC_INIT(cygwin-api.in.sgml)
! 
! AC_DEFUN(LIB_AC_PROG_CC,
! [AC_BEFORE([$0], [AC_PROG_CPP])dnl
! AC_CHECK_TOOL(CC, gcc, gcc)
! if test -z "$CC"; then
!   AC_CHECK_PROG(CC, cc, cc, , , /usr/ucb/cc)
!   test -z "$CC" && AC_MSG_ERROR([no acceptable cc found in \$PATH])
! fi
! 
! if test $ac_cv_prog_gcc = yes; then
!   GCC=yes
! dnl Check whether -g works, even if CFLAGS is set, in case the package
! dnl plays around with CFLAGS (such as to build both debugging and
! dnl normal versions of a library), tasteless as that idea is.
!   ac_test_CFLAGS="${CFLAGS+set}"
!   ac_save_CFLAGS="$CFLAGS"
!   CFLAGS=
!   AC_PROG_CC_G
!   if test "$ac_test_CFLAGS" = set; then
!     CFLAGS="$ac_save_CFLAGS"
!   elif test $ac_cv_prog_cc_g = yes; then
!     CFLAGS="-g -O2"
!   else
!     CFLAGS="-O2"
!   fi
!   if test "$ac_test_CXXFLAGS" != set; then
!     CXXFLAGS='$(CFLAGS)'
!   fi
! else
!   GCC=
!   test "${CFLAGS+set}" = set || CFLAGS="-g"
! fi
! ])
  
  AC_CANONICAL_SYSTEM
  
--- 9,17 ----
  
  dnl Process this file with autoconf to produce a configure script.
  
! AC_PREREQ(2.59)
  AC_INIT(cygwin-api.in.sgml)
! AC_CONFIG_AUX_DIR(..)
  
  AC_CANONICAL_SYSTEM
  
*** /proj/opensrc/nightly/src/src/winsup/mingw/configure.in	Tue May  6 07:46:05 2003
--- /disk3/src/src/winsup/mingw/configure.in	Mon May 22 09:58:25 2006
*************** dnl You should have received a copy of t
*** 16,64 ****
  dnl along with this program; if not, write to the Free Software
  dnl Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  
! AC_PREREQ(2.12)
  AC_INIT(dllmain.c)
! 
! dnl FIXME: We temporarily define our own version of AC_PROG_CC.  This is
! dnl copied from autoconf 2.12, but does not call AC_PROG_CC_WORKS.  We
! dnl are probably using a cross compiler, which will not be able to fully
! dnl link an executable.  This should really be fixed in autoconf
! dnl itself.
! 
! AC_DEFUN(LIB_AC_PROG_CC,
! [AC_BEFORE([$0], [AC_PROG_CPP])dnl
! AC_CHECK_TOOL(CC, gcc, gcc)
! if test -z "$CC"; then
!   AC_CHECK_PROG(CC, cc, cc, , , /usr/ucb/cc)
!   test -z "$CC" && AC_MSG_ERROR([no acceptable cc found in \$PATH])
! fi
! 
! AC_PROG_CC_GNU
! 
! if test $ac_cv_prog_gcc = yes; then
!   GCC=yes
! dnl Check whether -g works, even if CFLAGS is set, in case the package
! dnl plays around with CFLAGS (such as to build both debugging and
! dnl normal versions of a library), tasteless as that idea is.
!   ac_test_CFLAGS="${CFLAGS+set}"
!   ac_save_CFLAGS="$CFLAGS"
!   CFLAGS=
!   AC_PROG_CC_G
!   if test "$ac_test_CFLAGS" = set; then
!     CFLAGS="$ac_save_CFLAGS"
!   elif test $ac_cv_prog_cc_g = yes; then
!     CFLAGS="-g -O2"
!   else
!     CFLAGS="-O2"
!   fi
!   if test "$ac_test_CXXFLAGS" != set; then
!     CXXFLAGS='$(CFLAGS)'
!   fi
! else
!   GCC=
!   test "${CFLAGS+set}" = set || CFLAGS="-g"
! fi
! ])
  
  LIB_AC_PROG_CC
  
--- 16,24 ----
  dnl along with this program; if not, write to the Free Software
  dnl Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  
! AC_PREREQ(2.59)
  AC_INIT(dllmain.c)
! AC_CONFIG_AUX_DIR(..)
  
  LIB_AC_PROG_CC
  
*************** AC_SUBST(WINDRES)
*** 88,95 ****
  AC_ALLOCA
  
  AC_CANONICAL_SYSTEM
! SUBDIRS="profile mingwex"
! configdirs="profile mingwex"
  HEADER_SUBDIR=""
  
  LIBGMON_A=libgmon.a
--- 48,54 ----
  AC_ALLOCA
  
  AC_CANONICAL_SYSTEM
! AC_CONFIG_SUBDIRS(profile mingwex)
  HEADER_SUBDIR=""
  
  LIBGMON_A=libgmon.a
*************** esac
*** 117,133 ****
  # to match the libmingwthrd.a name.
  THREAD_DLL=mingwm
  
- if test -n "$configdirs"; then
-   AC_CONFIG_SUBDIRS($configdirs)
- fi
- 
  MKINSTALLDIRS=$ac_aux_dir/mkinstalldirs
  AC_SUBST(MKINSTALLDIRS)
  AC_SUBST(MNO_CYGWIN)
  AC_SUBST(THREAD_DLL)
  AC_SUBST(LIBM_A)
  AC_SUBST(LIBGMON_A)
- AC_SUBST(SUBDIRS)
  AC_SUBST(HEADER_SUBDIR)
  AC_SUBST(W32API_INCLUDE)
  
--- 76,87 ----
*** /proj/opensrc/nightly/src/src/winsup/mingw/mingwex/configure.in	Tue May  6 09:04:24 2003
--- /disk3/src/src/winsup/mingw/mingwex/configure.in	Mon May 22 09:59:29 2006
*************** dnl You should have received a copy of t
*** 16,22 ****
  dnl along with this program; if not, write to the Free Software
  dnl Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  
! AC_PREREQ(2.13)
  AC_INIT(imaxabs.c)
  
  CC=${CC-cc}
--- 16,22 ----
  dnl along with this program; if not, write to the Free Software
  dnl Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  
! AC_PREREQ(2.59)
  AC_INIT(imaxabs.c)
  
  CC=${CC-cc}
*** /proj/opensrc/nightly/src/src/winsup/mingw/profile/configure.in	Tue May  6 09:04:25 2003
--- /disk3/src/src/winsup/mingw/profile/configure.in	Mon May 22 09:59:49 2006
*************** dnl You should have received a copy of t
*** 16,22 ****
  dnl along with this program; if not, write to the Free Software
  dnl Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  
! AC_PREREQ(2.13)
  AC_INIT(gcrt0.c)
  
  CC=${CC-cc}
--- 16,22 ----
  dnl along with this program; if not, write to the Free Software
  dnl Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  
! AC_PREREQ(2.59)
  AC_INIT(gcrt0.c)
  
  CC=${CC-cc}
*** /proj/opensrc/nightly/src/src/winsup/subauth/configure.in	Fri May  4 06:19:37 2001
--- /disk3/src/src/winsup/subauth/configure.in	Mon May 22 10:01:01 2006
*************** dnl Autoconf configure script for Cygwin
*** 15,72 ****
  dnl
  dnl Process this file with autoconf to produce a configure script.
  
! AC_PREREQ(2.12)
! 
  AC_INIT(Makefile.in)
  
! dnl FIXME: We temporarily define our own version of AC_PROG_CC.  This is
! dnl copied from autoconf 2.12, but does not call AC_PROG_CC_WORKS.  We
! dnl are probably using a cross compiler, which will not be able to fully
! dnl link an executable.  This should really be fixed in autoconf
! dnl itself.
! 
! AC_DEFUN(LIB_AC_PROG_CC,
! [AC_BEFORE([$0], [AC_PROG_CPP])dnl
! AC_CHECK_PROG(CC, gcc, gcc)
! if test -z "$CC"; then
!   AC_CHECK_PROG(CC, cc, cc, , , /usr/ucb/cc)
!   test -z "$CC" && AC_MSG_ERROR([no acceptable cc found in \$PATH])
! fi
! 
! AC_PROG_CC_GNU
! 
! if test $ac_cv_prog_gcc = yes; then
!   GCC=yes
! dnl Check whether -g works, even if CFLAGS is set, in case the package
! dnl plays around with CFLAGS (such as to build both debugging and
! dnl normal versions of a library), tasteless as that idea is.
!   ac_test_CFLAGS="${CFLAGS+set}"
!   ac_save_CFLAGS="$CFLAGS"
!   CFLAGS=
!   AC_PROG_CC_G
!   if test "$ac_test_CFLAGS" = set; then
!     CFLAGS="$ac_save_CFLAGS"
!   elif test $ac_cv_prog_cc_g = yes; then
!     CFLAGS="-g -O2"
!   else
!     CFLAGS="-O2"
!   fi
! else
!   GCC=
!   test "${CFLAGS+set}" = set || CFLAGS="-g"
! fi
! ])
! 
! AC_DEFUN(LIB_AC_PROG_CXX,
! [AC_BEFORE([$0], [AC_PROG_CPP])dnl
! AC_CHECK_TOOL(CXX, g++, g++)
! if test -z "$CXX"; then
!   AC_CHECK_PROG(CXX, c++, c++, , , )
!   test -z "$CC" && AC_MSG_ERROR([no acceptable cc found in \$PATH])
! fi
! 
! CXXFLAGS='$(CFLAGS)'
! ])
  
  AC_CANONICAL_SYSTEM
  
--- 15,24 ----
  dnl
  dnl Process this file with autoconf to produce a configure script.
  
! AC_PREREQ(2.59)
  AC_INIT(Makefile.in)
  
! AC_CONFIG_AUX_DIR(..)
  
  AC_CANONICAL_SYSTEM
  
*** /proj/opensrc/nightly/src/src/winsup/testsuite/configure.in	Sat Sep  2 20:58:16 2000
--- /disk3/src/src/winsup/testsuite/configure.in	Mon May 22 10:02:10 2006
*************** dnl details.
*** 9,15 ****
  dnl
  dnl Process this file with autoconf to produce a configure script.
  
! AC_PREREQ(2.12)
  AC_INIT(Makefile.in)
  
  AC_PROG_CC
--- 9,15 ----
  dnl
  dnl Process this file with autoconf to produce a configure script.
  
! AC_PREREQ(2.59)
  AC_INIT(Makefile.in)
  
  AC_PROG_CC
*** /proj/opensrc/nightly/src/src/winsup/utils/configure.in	Fri Jul 25 17:28:47 2003
--- /disk3/src/src/winsup/utils/configure.in	Mon May 22 10:02:49 2006
*************** dnl details.
*** 9,66 ****
  
  dnl Process this file with autoconf to produce a configure script.
  
! AC_PREREQ(2.12)
! 
  AC_INIT(mount.cc)
! 
! dnl FIXME: We temporarily define our own version of AC_PROG_CC.  This is
! dnl copied from autoconf 2.12, but does not call AC_PROG_CC_WORKS.  We
! dnl are probably using a cross compiler, which will not be able to fully
! dnl link an executable.  This should really be fixed in autoconf
! dnl itself.
! 
! AC_DEFUN(LIB_AC_PROG_CC,
! [AC_BEFORE([$0], [AC_PROG_CPP])dnl
! AC_CHECK_PROG(CC, gcc, gcc)
! if test -z "$CC"; then
!   AC_CHECK_PROG(CC, cc, cc, , , /usr/ucb/cc)
!   test -z "$CC" && AC_MSG_ERROR([no acceptable cc found in \$PATH])
! fi
! 
! AC_PROG_CC_GNU
! 
! if test $ac_cv_prog_gcc = yes; then
!   GCC=yes
! dnl Check whether -g works, even if CFLAGS is set, in case the package
! dnl plays around with CFLAGS (such as to build both debugging and
! dnl normal versions of a library), tasteless as that idea is.
!   ac_test_CFLAGS="${CFLAGS+set}"
!   ac_save_CFLAGS="$CFLAGS"
!   CFLAGS=
!   AC_PROG_CC_G
!   if test "$ac_test_CFLAGS" = set; then
!     CFLAGS="$ac_save_CFLAGS"
!   elif test $ac_cv_prog_cc_g = yes; then
!     CFLAGS="-g -O2"
!   else
!     CFLAGS="-O2"
!   fi
! else
!   GCC=
!   test "${CFLAGS+set}" = set || CFLAGS="-g"
! fi
! ])
! 
! AC_DEFUN(LIB_AC_PROG_CXX,
! [AC_BEFORE([$0], [AC_PROG_CPP])dnl
! AC_CHECK_TOOL(CXX, g++, g++)
! if test -z "$CXX"; then
!   AC_CHECK_PROG(CXX, c++, c++, , , )
!   test -z "$CC" && AC_MSG_ERROR([no acceptable cc found in \$PATH])
! fi
! 
! CXXFLAGS='$(CFLAGS)'
! ])
  
  AC_CANONICAL_SYSTEM
  
--- 9,17 ----
  
  dnl Process this file with autoconf to produce a configure script.
  
! AC_PREREQ(2.59)
  AC_INIT(mount.cc)
! AC_CONFIG_AUX_DIR(..)
  
  AC_CANONICAL_SYSTEM
  
*** /proj/opensrc/nightly/src/src/winsup/w32api/configure.in	Fri Mar 26 18:25:36 2004
--- /disk3/src/src/winsup/w32api/configure.in	Mon May 22 10:03:30 2006
*************** dnl but WITHOUT ANY WARRANTY; without ev
*** 7,13 ****
  dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  dnl GNU General Public License for more details.
  
! AC_PREREQ(2.12)
  AC_INIT(lib/scrnsave.c)
  
  AC_CANONICAL_SYSTEM
--- 7,13 ----
  dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  dnl GNU General Public License for more details.
  
! AC_PREREQ(2.59)
  AC_INIT(lib/scrnsave.c)
  
  AC_CANONICAL_SYSTEM
