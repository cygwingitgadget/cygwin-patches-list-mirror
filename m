Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id 4B7153833006
 for <cygwin-patches@cygwin.com>; Mon, 30 Nov 2020 10:47:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4B7153833006
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N8nrc-1k5Non24KU-015okG for <cygwin-patches@cygwin.com>; Mon, 30 Nov 2020
 11:47:19 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id F0FE0A80D0E; Mon, 30 Nov 2020 11:47:18 +0100 (CET)
Date: Mon, 30 Nov 2020 11:47:18 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Use automake (v3)
Message-ID: <20201130104718.GD303847@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201124133720.45823-1-jon.turney@dronecode.org.uk>
 <20201130102524.GC303847@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201130102524.GC303847@calimero.vinschen.de>
X-Provags-ID: V03:K1:X0LMAA1Rq5I0PU56X/CAnXhrj+7BCJaSI0EhbNVeoj+GObnyNto
 w2iUt+V58L0iOAmawQ8s0DHvNAPkxJvI44fKF/so+h1fiUnMpOy/D2d0KwUixI18eznC978
 RXHusHgguCRLWQEzmfV/mi9SEnbpKxAVixqzCn4aVZlXAtgEmZW8RvVVibF0mh7z2Dpn0Gr
 UqW2ArRNIAlywDhsZvQjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mUH473pAxxs=:bDhMkyhr5JWU2joiRcwCiJ
 VksQJxej1xl/OEAunZ+q3TEi+hvV07FldfbGS8hXqmGVIWZZGsatLBiH+AzxN9VEY4l6k7aeS
 zmk7EzL8kELz2Qjux6FuLI46ea2L2rQ7+g5hujTGtxksEMa6gR+pdwaCpPkSPa/sftHNfEyWq
 Xlv5pHXnr0gojOLIUVsBoSII+fUW1hJsVOviR/cedpRl0G36TGMVQ4AygJaynSCvDc4iGCaYQ
 EZnjh3sA7Fyq/vvvrR8DlnymHVo+zW8Fu/W8wfKWu6XzUgVfmTFRK1vfE8LC3FTGfL7d3QpoI
 oClokiuoMId1MyzwISETwufA/SSoIAp/J/Ax/MyytiF8kgn45lSG9GWp1UzoNQ0vP6eXBl2b5
 OBa+2o7FpGefp8dWWQ0+3E5C6/7YSLECY//JpUhsQq8hPtubaMcI1VTIr/6i1TyD4RMWckBrD
 cCP+kB+6Ng==
X-Spam-Status: No, score=-100.6 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 30 Nov 2020 10:47:23 -0000

On Nov 30 11:25, Corinna Vinschen wrote:
> Hi Jon,
> 
> On Nov 24 13:37, Jon Turney wrote:
> > For ease of reviewing, this patch doesn't contain changes to generated
> > files which would be made by running ./autogen.sh.
> > 
> > v2:
> > * Include tzmap.h in BUILT_SOURCES
> > * Make per-file flags appear after user-supplied CXXFLAGS, so they can
> > override optimization level.
> > * Correct .o files used to define symbols exported by libm.a
> > * Drop gcrt0.o mistakenly incuded in libgmon.a
> > * Add missing line continuations in GMON_FILES value
> > 
> > v3:
> > * use per-file flags for .c compilation
> > * override C{XX,}FLAGS, as they are set on the command line by top-level make
> 
> Running autogen.sh shows a couple of warnings:
> 
> configure.ac:45: warning: 'INCLUDES' is the old name for 'AM_CPPFLAGS' (or '*_CPPFLAGS')
> configure.ac:45: warning: 'INCLUDES' is the old name for 'AM_CPPFLAGS' (or '*_CPPFLAGS')
> configure.ac:45: warning: 'INCLUDES' is the old name for 'AM_CPPFLAGS' (or '*_CPPFLAGS')
> configure.ac:45: warning: 'INCLUDES' is the old name for 'AM_CPPFLAGS' (or '*_CPPFLAGS')
> configure.ac:45: warning: 'INCLUDES' is the old name for 'AM_CPPFLAGS' (or '*_CPPFLAGS')
> testsuite/cygrun/Makefile.am:16: warning: 'INCLUDES' is the old name for 'AM_CPPFLAGS' (or '*_CPPFLAGS')
> configure.ac:45: warning: 'INCLUDES' is the old name for 'AM_CPPFLAGS' (or '*_CPPFLAGS')
> automake: warning: redefinition of 'ps' ...
> /usr/share/automake-1.16/am/program.am: ... 'ps$(EXEEXT)' previously defined here
> utils/Makefile.am:15:   while processing program 'ps'
> utils/mingw/Makefile.am:14: warning: 'INCLUDES' is the old name for 'AM_CPPFLAGS' (or '*_CPPFLAGS')
> 
> Something to worry about?

Also, after applying the patch and autogen-ing, a full build from
top-level fails with some warnings and a final undefined symbol:

make[5]: Entering directory '[...]/x86_64-pc-cygwin/winsup/utils/mingw'
  CXX      ../bloda.o
  CXX      ../cygcheck.o
  CXX      ../dump_setup.o
  CXX      ../ldh.o
  CXX      ../path.o
  CXX      ../cygwin-console-helper.o
  CXX      ../path_testsuite-path.o
  CXX      ../strace.o
  CXX      ../path_testsuite-testsuite.o
[...]/winsup/utils/mingw/../testsuite.cc:18: warning: "TESTSUITE" redefined
   18 | #define TESTSUITE
      | 
<command-line>: note: this is the location of the previous definition
  CXXLD    cygwin-console-helper.exe
  CXXLD    ldh.exe
In file included from [...]/winsup/utils/mingw/../path.cc:263:
[...]/winsup/utils/mingw/../testsuite.h:22:24: warning: ISO C++ forbids converting a string constant to 'char*' [-Wwrite-strings]
   22 | #define TESTSUITE_ROOT "X:\\xyzroot"
      |                        ^~~~~~~~~~~~~
[...]/winsup/utils/mingw/../testsuite.h:22:24: note: in definition of macro 'TESTSUITE_ROOT'
   22 | #define TESTSUITE_ROOT "X:\\xyzroot"
      |                        ^~~~~~~~~~~~~
[...]/winsup/utils/mingw/../testsuite.h:34:4: warning: ISO C++ forbids converting a string constant to 'char*' [-Wwrite-strings]
   34 |  { "O:\\other",           (char*)"/otherdir",        MOUNT_SYSTEM},
      |    ^~~~~~~~~~~
[...]/winsup/utils/mingw/../testsuite.h:35:4: warning: ISO C++ forbids converting a string constant to 'char*' [-Wwrite-strings]
   35 |  { "S:\\some\\dir",       (char*)"/somedir",         MOUNT_SYSTEM},
      |    ^~~~~~~~~~~~~~~
[...]/winsup/utils/mingw/../testsuite.h:22:24: warning: ISO C++ forbids converting a string constant to 'char*' [-Wwrite-strings]
   22 | #define TESTSUITE_ROOT "X:\\xyzroot"
      |                        ^
[...]/winsup/utils/mingw/../testsuite.h:22:24: note: in definition of macro 'TESTSUITE_ROOT'
   22 | #define TESTSUITE_ROOT "X:\\xyzroot"
      |                        ^~~~~~~~~~~~~
[...]/winsup/utils/mingw/../testsuite.h:22:24: warning: ISO C++ forbids converting a string constant to 'char*' [-Wwrite-strings]
   22 | #define TESTSUITE_ROOT "X:\\xyzroot"
      |                        ^
[...]/winsup/utils/mingw/../testsuite.h:22:24: note: in definition of macro 'TESTSUITE_ROOT'
   22 | #define TESTSUITE_ROOT "X:\\xyzroot"
      |                        ^~~~~~~~~~~~~
[...]/winsup/utils/mingw/../testsuite.h:38:4: warning: ISO C++ forbids converting a string constant to 'char*' [-Wwrite-strings]
   38 |  { ".",                   (char*)TESTSUITE_CYGDRIVE, MOUNT_SYSTEM | MOUNT_CYGDRIVE},
      |    ^~~
[...]/winsup/utils/mingw/../path.cc:563:1: warning: 'int mnt_sort(const void*, const void*)' defined but not used [-Wunused-function]
  563 | mnt_sort (const void *a, const void *b)
      | ^~~~~~~~
  CXXLD    path-testsuite.exe
/usr/lib/gcc/x86_64-w64-mingw32/9.2.1/../../../../x86_64-w64-mingw32/bin/ld: ../path_testsuite-path.o:path.cc:(.rdata$.refptr.max_mount_entry[.refptr.max_mount_entry]+0x0): undefined reference to `max_mount_entry'


Corinna
