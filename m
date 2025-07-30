Return-Path: <SRS0=g2Vt=2L=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo006.btinternet.com (btprdrgo006.btinternet.com [65.20.50.80])
	by sourceware.org (Postfix) with ESMTP id 5CCC03858D26
	for <cygwin-patches@cygwin.com>; Wed, 30 Jul 2025 15:53:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5CCC03858D26
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5CCC03858D26
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.80
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753890831; cv=none;
	b=swQ+JIZZKrZUUmhbo6VNMJQNy3yh65aN+8qTSD60MmKURekpTIjeXCCbEz+cYGbfllnf1onKP8lg2XonI98ba9HmyiBaWytZAwobhMNWEDlb4DDEE3i0nMssf1E9Pi6yMocixXVBcUnUv11OavVVJi60yUxjAdyJjPPml8RD5/8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753890831; c=relaxed/simple;
	bh=G5XnPovsX1RYtFR4iQ19CS04eliWIuJclZTRO4M0nd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=oxsfRCbSDAWuQxG3YUlMpa/B8APUp8H/wchLC97i0vqKQxTTleE1uGoKmfj3gLHoaUkjt48UeSBnOkxcs1UG7qWiwKgGANIiks5ECXTmHZOhc1OaBdeIqJ3GkulvwAVtQhjBnklRJWu4swkUnliN/jFtMwNJUZomXglzTV93PUs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5CCC03858D26
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 68790449019C44E7
X-Originating-IP: [86.144.41.51]
X-OWM-Source-IP: 86.144.41.51
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelkeefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhvegjtgfgsehtkeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeehgeejkedtuddtledvgeejteefgfeuteffgfekgfegjeffjeetgeeujeeivdehudenucffohhmrghinhepshhouhhrtggvfigrrhgvrdhorhhgnecukfhppeekiedrudeggedrgedurdehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkeeirddugeegrdeguddrhedupdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddugeegqdeguddqhedurdhrrghnghgvkeeiqddugeegrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdeipdhnsggprhgtphhtthhopedvpdhrtghpthht
	oheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehrrgguvghkrdgsrghrthhonhesmhhitghrohhsohhfthdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.144.41.51) by btprdrgo006.btinternet.com (authenticated as jonturney@btinternet.com)
        id 68790449019C44E7; Wed, 30 Jul 2025 16:53:45 +0100
Message-ID: <c6ecaad8-1698-4240-991d-12bf4e503c72@dronecode.org.uk>
Date: Wed, 30 Jul 2025 16:53:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: configure: allow zero-level bootstrapping
 cross-build with --without-cross-bootstrap (and cross-testing without)
To: Radek Barton <radek.barton@microsoft.com>
References: <DB9PR83MB0923F85A909F2724ED5328239259A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <DB9PR83MB0923F85A909F2724ED5328239259A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 25/07/2025 22:40, Radek Barton via Cygwin-patches wrote:
> Hello.
> 
> Sending the follow up of https://sourceware.org/pipermail/cygwin-patches/2025q3/014175.html

Thanks very much for this!

> 
> Radek
> 
> ---
>  From b00a23402a77aae19a1d42a8d06d6c4d371b066b Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Radek=20Barto=C5=88?= <radek.barton@microsoft.com>
> Date: Mon, 21 Jul 2025 10:03:52 +0200
> Subject: [PATCH] Cygwin: configure: allow zero-level bootstrapping cross-build
>   with --without-cross-bootstrap (and cross-testing without)
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> This patch introduces additional changes, on top of the previous changes from
> 437d2d6862b47c6cf10c989706eddf55e5f41efd commit, for building Cygwin with
> a stage1 compiler that does not support linking executables yet, e.g., when
> building a cross-compiler for Cygwin. It allows building just the Cygwin DLL
> and crt0.o, which is sufficient for a stage2 compiler.
> 
> Furthermore, it allows cross-testing of the Cygwin DLL in cross-compilation
> environments that are capable of executing native Cygwin executables,
> e.g. in WSL, if --without-cross-bootstrap is not specified and MinGW toolchain is
> available (because cygrun needs to be built).
> 
> Furthermore, it fixes behavior of --with(out)-cross-bootstrap flag to make it
> semantically compliant with its documentation as discussed at
> https://sourceware.org/pipermail/cygwin-patches/2025q3/014175.html. It defaults
> to --with-cross-bootstrap now which enables MinGW toolchain detection and MinGW
> tools building (and testing).

It feels like maybe this could be broken up into pieces. Some of which 
could be applied now, and some of which maybe need further discussion.

> 
> ChangeLog:
> 
>          * newlib/libc/include/stdlib.h (abort): Remove (void) parameter
>          to fix x64 compilation with GCC 15 cross-compiler.

I'm sure this is correct, but could you explain the issue/show the error?

>          * winsup/configure.ac: Fix --with-cross-bootstrap flag semantics,
>          change target_cpu to build_cpu for MinGW toolchain detection,
>          and conditionally check BFD libraries only when not bootstrapping
>          to avoid "configure: error: link tests are not allowed after
>          AC_NO_EXECUTABLES" error.

Hmmm... so this is interesting... We invoke AC_NO_EXECUTABLES 
unconditionally. but that only forces AC_LINK_IFELSE to give that error 
under some circumstances (presumably when we're cross-compiling).

I did not know that, and of course, it makes it harder to spot when 
you've introduced a cross-compilation problem...

>          * winsup/doc/faq-programming.xml: Fix spacing in documentation
>          for --without-cross-bootstrap flag.
>          * winsup/testsuite/Makefile.am: Make mingw/cygload test conditional
>          on CROSS_BOOTSTRAP, use EXEEXT variable for Unix based cross-compilation
>          environments that are not adding the extension automatically, use
>          dynamic busybox path detection instead of hardcoded paths.
>          * winsup/testsuite/cygrun.sh: Add .exe extension to executable
>          references for proper cross-platform compatibility. This still have two
>          caveats, it assumes cygdrop and cygpath to be present in the
>          environment. This is becase cygdrop is not part of the newlib-cygwin
>          repository and using cygpath built from the repository is failing with

Yeah, this was just me being lazy. It would probably better if the "drop 
admin privs" functionality was integrated into cygrun.

(and then I think it would be useful to make it conditional, as there's 
some tests where it would be useful run with it on, others where it 
needs to be off...)

>          "Warning!  Stack base is 0x600000.  padding ends at 0x5ff7c8.
>          Delta is 2104.  Stack variables could be overwritten!" even for native
>          x64 environments.
> 
> Signed-off-by: Radek Bartoň <radek.barton@microsoft.com>
> ---
>   newlib/libc/include/stdlib.h   |  2 +-
>   winsup/configure.ac            | 22 +++++++++++++---------
>   winsup/doc/faq-programming.xml |  2 +-
>   winsup/testsuite/Makefile.am   | 16 +++++++++++-----
>   winsup/testsuite/cygrun.sh     |  8 ++++----
>   5 files changed, 30 insertions(+), 20 deletions(-)
> 
> diff --git a/newlib/libc/include/stdlib.h b/newlib/libc/include/stdlib.h
> index 55b20fac9..34a43c786 100644
> --- a/newlib/libc/include/stdlib.h
> +++ b/newlib/libc/include/stdlib.h
> @@ -66,7 +66,7 @@ int	__locale_mb_cur_max (void);
>   
>   #define MB_CUR_MAX __locale_mb_cur_max()
>   
> -void	abort (void) _ATTRIBUTE ((__noreturn__));
> +void	abort () _ATTRIBUTE ((__noreturn__));
>   int	abs (int);
>   #if __BSD_VISIBLE
>   __uint32_t arc4random (void);
> diff --git a/winsup/configure.ac b/winsup/configure.ac
> index e7ac814b1..57191fa7f 100644
> --- a/winsup/configure.ac
> +++ b/winsup/configure.ac
> @@ -40,7 +40,9 @@ AM_PROG_AS
>   AC_LANG(C)
>   AC_LANG(C++)
>   
> -AC_ARG_WITH([cross-bootstrap],[AS_HELP_STRING([--with-cross-bootstrap],[do not build programs using the MinGW toolchain or check for MinGW libraries (useful for bootstrapping a cross-compiler)])],[],[with_cross_bootstrap=no])
> +AC_ARG_WITH([cross_bootstrap],
> +    [AS_HELP_STRING([--without-cross-bootstrap],
> +		    [do not build programs using the MinGW toolchain or check for MinGW libraries (useful for bootstrapping a cross-compiler)])])
>   
>   AC_CYGWIN_INCLUDES
>   
> @@ -115,13 +117,13 @@ if test -z "$XMLTO"; then
>       fi
>   fi
>   
> -if test "x$with_cross_bootstrap" != "xyes"; then
> -    AC_CHECK_PROGS(MINGW_CXX, ${target_cpu}-w64-mingw32-g++)
> +if test "x$with_cross_bootstrap" != "xno"; then
> +    AC_CHECK_PROGS(MINGW_CXX, ${build_cpu}-w64-mingw32-g++)
>       test -n "$MINGW_CXX" || AC_MSG_ERROR([no acceptable MinGW g++ found in \$PATH])
> -    AC_CHECK_PROGS(MINGW_CC, ${target_cpu}-w64-mingw32-gcc)
> +    AC_CHECK_PROGS(MINGW_CC, ${build_cpu}-w64-mingw32-gcc)

Hmmm... I have some difficulty seeing how this change is correct.

I mean: If we are building for aarch64, so target compiler is 
aarch64-pc-cygwin-gcc, we also want to build the utils with 
aarch-64-w64-mingw32-gcc, right?

(As an aside, to be hypercorrect, perhaps these should be host_cpu 
rather target_cpu?)

>       test -n "$MINGW_CC" || AC_MSG_ERROR([no acceptable MinGW gcc found in \$PATH])
>   fi
> -AM_CONDITIONAL(CROSS_BOOTSTRAP, [test "x$with_cross_bootstrap" != "xyes"])
> +AM_CONDITIONAL(CROSS_BOOTSTRAP, [test "x$with_cross_bootstrap" != "xno"])
>   
>   AC_EXEEXT
>   
> @@ -134,10 +136,12 @@ AM_CONDITIONAL(BUILD_DUMPER, [test "x$build_dumper" = "xyes"])
>   
>   # libbfd.a doesn't have a pkgconfig file, so we guess what it's dependencies
>   # are, based on what's present in the build environment
> -BFD_LIBS="-lintl -liconv -liberty -lz"
> -AC_CHECK_LIB([sframe], [sframe_decode], [BFD_LIBS="${BFD_LIBS} -lsframe"])
> -AC_CHECK_LIB([zstd], [ZSTD_isError], [BFD_LIBS="${BFD_LIBS} -lzstd"])
> -AC_SUBST([BFD_LIBS])
> +if test "x$with_cross_bootstrap" != "xno"; then
> +    BFD_LIBS="-lintl -liconv -liberty -lz"
> +    AC_CHECK_LIB([sframe], [sframe_decode], [BFD_LIBS="${BFD_LIBS} -lsframe"])
> +    AC_CHECK_LIB([zstd], [ZSTD_isError], [BFD_LIBS="${BFD_LIBS} -lzstd"])
> +    AC_SUBST([BFD_LIBS])
> +fi

So, this seems to call into question the meaning you are giving 
--with-cross-bootstrap.

The help text reads "do not build programs using the MinGW toolchain or 
check for MinGW libraries", which this isn't?

bfd (and it's supporting libs) are linked into dumper, which is a cygwin 
executable, not built with the MinGW tools

Does this maybe want to be conditional on '--disable-utils' instead?

>   
>   AC_CONFIG_FILES([
>       Makefile
> diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xml
> index ae9bdb8dc..696a6462b 100644
> --- a/winsup/doc/faq-programming.xml
> +++ b/winsup/doc/faq-programming.xml
> @@ -707,7 +707,7 @@ Build of <literal>cygserver</literal> can be skipped with
>   <para>
>   In combination, <literal>--disable-cygserver</literal>,
>   <literal>--disable-dumper</literal>, <literal>--disable-utils</literal>
> -and  <literal>--without-cross-bootstrap</literal> allow building of just
> +and <literal>--without-cross-bootstrap</literal> allow building of just
>   <literal>cygwin1.dll</literal> and <literal>crt0.o</literal> for a stage2
>   compiler, when being built with stage1 compiler which does not support linking
>   executables yet (because those files are missing).
> diff --git a/winsup/testsuite/Makefile.am b/winsup/testsuite/Makefile.am
> index 20e06b9c5..7e304db2a 100644
> --- a/winsup/testsuite/Makefile.am
> +++ b/winsup/testsuite/Makefile.am
> @@ -335,8 +335,11 @@ LDADD = $(builddir)/libltp.a $(builddir)/../cygwin/binmode.o $(LDADD_FOR_TESTDLL
>   winsup_api_devdsp_LDADD = -lwinmm $(LDADD)
>   
>   # all tests
> -TESTS = $(check_PROGRAMS) \
> -	mingw/cygload
> +TESTS = $(check_PROGRAMS)
> +
> +if CROSS_BOOTSTRAP
> +TESTS += mingw/cygload$(EXEEXT)
> +endif
>   
>   # expected fail tests
>   XFAIL_TESTS = \
> @@ -351,6 +354,7 @@ LOG_COMPILER = $(srcdir)/cygrun.sh
>   
>   export runtime_root=$(abs_builddir)/testinst/bin
>   export mingwtestdir=$(builddir)/mingw
> +export utilsdir=$(builddir)/../utils
>   
>   # Set up things in the Cygwin 'installation' at testsuite/testinst/ to provide
>   # things which tests need to work
> @@ -369,11 +373,13 @@ export mingwtestdir=$(builddir)/mingw
>   # dependencies other than cygwin1.dll.
>   #
>   
> +BUSYBOX := $(shell which busybox)

Good idea!

But is this going to be empty, leading to a confusing error from cp, if 
busybox ian't installed?

Maybe '$(shell which busybox || echo busybox-missing)' ?

> +
>   check-local:
>   	$(MKDIR_P) ${builddir}/testinst/tmp
> -	cd ${builddir}/testinst/bin && cp /usr/libexec/busybox/bin/busybox.exe sh.exe
> -	cd ${builddir}/testinst/bin && cp /usr/libexec/busybox/bin/busybox.exe sleep.exe
> -	cd ${builddir}/testinst/bin && cp /usr/libexec/busybox/bin/busybox.exe ls.exe
> +	cd ${builddir}/testinst/bin && cp $(BUSYBOX) sh.exe
> +	cd ${builddir}/testinst/bin && cp $(BUSYBOX) sleep.exe
> +	cd ${builddir}/testinst/bin && cp $(BUSYBOX) ls.exe
>   
>   # target to build all the programs needed by check, without running check
>   check_programs: $(check_PROGRAMS)
> diff --git a/winsup/testsuite/cygrun.sh b/winsup/testsuite/cygrun.sh
> index f1673e4db..6dcbb4ea1 100755
> --- a/winsup/testsuite/cygrun.sh
> +++ b/winsup/testsuite/cygrun.sh
> @@ -8,10 +8,10 @@ exe=$1
>   
>   export PATH="$runtime_root:${PATH}"
>   
> -if [ "$1" = "./mingw/cygload" ]
> +if [ "$1" = "./mingw/cygload.exe" ]
>   then
> -    windows_runtime_root=$(cygpath -m $runtime_root)
> -    $mingwtestdir/cygrun "$exe -v -cygwin $windows_runtime_root/cygwin1.dll"
> +    windows_runtime_root=$($utilsdir/cygpath.exe -m $runtime_root)
> +    $mingwtestdir/cygrun.exe "$exe -v -cygwin $windows_runtime_root/cygwin1.dll"
>   else
> -    cygdrop $mingwtestdir/cygrun $exe
> +    cygdrop.exe $mingwtestdir/cygrun.exe $exe
>   fi
Just so I'm clear: adding the explicit '.exe' is neccessary to execute 
files with that exension under WSL?
