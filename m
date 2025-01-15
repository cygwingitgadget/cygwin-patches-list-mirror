Return-Path: <SRS0=SYvf=UH=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	by sourceware.org (Postfix) with ESMTPS id 60DDC38515CF
	for <cygwin-patches@cygwin.com>; Wed, 15 Jan 2025 19:43:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 60DDC38515CF
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 60DDC38515CF
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736970222; cv=none;
	b=l8Gj33nGnf3+mRo/ZrM1mVTBJF+ilKHWtqJ/Lk5D2smUlm6n/0AMv6Jx9DfvP547zCOAB2sES30so0JAoGAbikMdhNKMAX+/tRmrT7fM7chEw5zIc3b4PjxkeTv9jLG7ryafTrMtIcjiw5Q0LgAGxSYtIIvOhpHKWxPEf+vvUo0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736970222; c=relaxed/simple;
	bh=8U6axPYMdDNtBs2JV6rW1zZ9OhNdoGxhvijVbkVavSc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Wz19Eg7dTWSjwzFXORSLJCPWbYDq8Qaq5hBMo8AKfwXHBRVXrgq9QkQJNoy4Snjq+ETCCK9LxRQCO9udycljJ3LvRhMpH3lp/dfjeQLqgZ/T0hMujfGVqihCJCYtxNEnWD0DP175Moy6wkN+VNiemS0KKe/P90IRrS7K0jCwiro=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 60DDC38515CF
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=Itbpm0j/
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id EC861AE323;
	Wed, 15 Jan 2025 19:43:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf07.hostedemail.com (Postfix) with ESMTPA id 591052002D;
	Wed, 15 Jan 2025 19:43:35 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com (Cygwin Patches)
Subject: [PATCH v6 7/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 merge function variants on one line
Date: Wed, 15 Jan 2025 12:39:24 -0700
Message-ID: <148e7ac405bab0b01c09056f3ffb4d228fc609ff.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
References: <cover.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Organization: Systematic Software
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 591052002D
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: zh5ei51gsbige3axaashufcwcg8t8m65
X-Rspamd-Server: rspamout05
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1+26EPCYqTmGsO4jnKmKe5K55ZwBDraoUc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=he; bh=hXz3wlheyLlpguIgkqIPlmfMDu8xualLGf8thIWWbqU=; b=Itbpm0j/D5hFEdwv8cKlmtQeA/ZsU1c5T4LSEddf6yvWUA9H3j5GbruFeOIWenMw0/ZjyHKM3vqYjlrFfEfRMB/BN8e+KnlSwaKmynB2kYg4YLwSsz/wP94Qwr97S3wCMjoBsY9oAwbTxJXGZyBG9bRm4jcM4WmlISSNHfNVwj9zZTWyobjNTBQBuAbpnwDkEu3kQmYolU9VB/ww8DA6UUXLwpJewDh3DzgS23lItm0GyjR1v4BbB02M83L+G9pvotEt+qoIkFhjPMpXXhiS3sRUqMvL+faQO05F3x/Oly35YyhcvDv9S2Xq7WWhfeFo77OfnZTU/eM+3br8GSDBBA==
X-HE-Tag: 1736970215-308476
X-HE-Meta: U2FsdGVkX1/MWTa13ODL5frfRoynkCA3UPWD7LipK6b0QQNcLXcSgkcVRv4AKYK3UNhNms98WbeuSsvdaHi0XfkN7tqtCv4ssNRsY+7cwZyBotbYjxIyIGexbUrWMyMnQ2w7BBJJpnlxmlbivCpRC50m0Fa7c9ZydrymrP1ZHtQI9HG2h6WtIknHggLDYteJGKZi39loVNorQSNieL/Nuq+3YHGeCPtIqwHnpOOscH8KEvEFBA//WR4FloFXSgpxvkP29zw4BrncyQSbpgNRlxGG0TIPv1B4LdS4fmmBjvUkHUxNgJHAPYyt/shz5z5YYrfi50x67TbHTNTSqXSYdtgaJmIVYdG3ZY1L9K0FaESDEu5NmnH93IW4lebw0IWC/ilgJq/2pME=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Move related functions to put base entries and variants on the same line.

Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 winsup/doc/posix.xml | 1209 ++++++++++++------------------------------
 1 file changed, 345 insertions(+), 864 deletions(-)

diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 1a1becd5e5c8..a9f293d0f19e 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -1,4 +1,4 @@
-<?xml version="1.0" encoding='UTF-8'?>
+/<?xml version="1.0" encoding='UTF-8'?>
 <!DOCTYPE chapter PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
     "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">
 
@@ -16,27 +16,16 @@ ISO/IEC DIS 9945 Information technology
 - Issue 8.</para>
 
 <screen>
-    CMPLX			(available in "complex.h" header)
-    CMPLXF			(available in "complex.h" header)
-    CMPLXL			(available in "complex.h" header)
-    FD_CLR
-    FD_ISSET
-    FD_SET
-    FD_ZERO
-    _Exit
-    _exit
-    a64l
+    CMPLX/CMPLXF/CMPLXL		(available in "complex.h" header)
+    FD_CLR/FD_ISSET/FD_SET/FD_ZERO
+    _Exit/_exit
+    a64l/l64a
     abort
     abs
-    accept
-    accept4
-    access
-    acos
-    acosf
-    acosl
-    acosh
-    acoshf
-    acoshl
+    accept/accept4
+    access/faccessat
+    acos/acosf/acosl
+    acosh/acoshf/acoshl
     aio_cancel
     aio_error
     aio_fsync
@@ -46,27 +35,16 @@ ISO/IEC DIS 9945 Information technology
     aio_write
     alarm
     aligned_alloc		(ISO C11)
-    alphasort
-    asctime
-    asctime_r
-    asin
-    asinf
-    asinl
-    asinh
-    asinhf
-    asinhl
+    alphasort/scandir
+    asctime/asctime_r
+    asin/asinf/asinl
+    asinh/asinhf/asinhl
     asprintf
     assert			(SVID - available in "assert.h" header)
     at_quick_exit		(ISO C11)
-    atan
-    atanf
-    atanl
-    atan2
-    atan2f
-    atan2l
-    atanh
-    atanhf
-    atanhl
+    atan/atanf/atanl
+    atan2/atan2f/atan2l
+    atanh/atanhf/atanhl
     atexit
     atof
     atoi
@@ -76,158 +54,81 @@ ISO/IEC DIS 9945 Information technology
     atomic_compare_exchange_strong_explicit	(available in "stdatomic.h" header)
     atomic_compare_exchange_weak		(available in "stdatomic.h" header)
     atomic_compare_exchange_weak_explicit	(available in "stdatomic.h" header)
-    atomic_exchange		(available in "stdatomic.h" header)
-    atomic_exchange_explicit	(available in "stdatomic.h" header)
-    atomic_fetch_add		(available in "stdatomic.h" header)
-    atomic_fetch_add_explicit	(available in "stdatomic.h" header)
-    atomic_fetch_and		(available in "stdatomic.h" header)
-    atomic_fetch_and_explicit	(available in "stdatomic.h" header)
-    atomic_fetch_or		(available in "stdatomic.h" header)
-    atomic_fetch_or_explicit	(available in "stdatomic.h" header)
-    atomic_fetch_sub		(available in "stdatomic.h" header)
-    atomic_fetch_sub_explicit	(available in "stdatomic.h" header)
-    atomic_fetch_xor		(available in "stdatomic.h" header)
-    atomic_fetch_xor_explicit	(available in "stdatomic.h" header)
-    atomic_flag_clear		(available in "stdatomic.h" header)
-    atomic_flag_clear_explicit	(available in "stdatomic.h" header)
-    atomic_flag_test_and_set	(available in "stdatomic.h" header)
-    atomic_flag_test_and_set_explicit	(available in "stdatomic.h" header)
-    atomic_init			(available in "stdatomic.h" header)
-    atomic_is_lock_free		(available in "stdatomic.h" header)
-    atomic_load			(available in "stdatomic.h" header)
-    atomic_load_explicit	(available in "stdatomic.h" header)
-    atomic_signal_fence		(available in "stdatomic.h" header)
-    atomic_store		(available in "stdatomic.h" header)
-    atomic_store_explicit	(available in "stdatomic.h" header)
-    atomic_thread_fence		(available in "stdatomic.h" header)
+    atomic_exchange/atomic_exchange_explicit	(available in "stdatomic.h" header)
+    atomic_fetch_add/atomic_fetch_add_explicit	(available in "stdatomic.h" header)
+    atomic_fetch_and/atomic_fetch_and_explicit	(available in "stdatomic.h" header)
+    atomic_fetch_or/atomic_fetch_or_explicit	(available in "stdatomic.h" header)
+    atomic_fetch_sub/atomic_fetch_sub_explicit	(available in "stdatomic.h" header)
+    atomic_fetch_xor/atomic_fetch_xor_explicit	(available in "stdatomic.h" header)
+    atomic_flag_clear/atomic_flag_clear_explicit	(available in "stdatomic.h" header)
+    atomic_flag_test_and_set/atomic_flag_test_and_set_explicit	(available in "stdatomic.h" header)
+    atomic_init					(available in "stdatomic.h" header)
+    atomic_is_lock_free				(available in "stdatomic.h" header)
+    atomic_load/atomic_load_explicit		(available in "stdatomic.h" header)
+    atomic_signal_fence/atomic_thread_fence	(available in "stdatomic.h" header)
+    atomic_store/atomic_store_explicit		(available in "stdatomic.h" header)
     basename			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
-    be16toh			(available in "endian.h" header)
-    be32toh			(available in "endian.h" header)
-    be64toh			(available in "endian.h" header)
+    be16toh/be32toh/be64toh	(available in "endian.h" header)
     bind
-    bind_textdomain_codeset	(available in external gettext "libintl" library)
-    bindtextdomain		(available in external gettext "libintl" library)
+    bindtextdomain/bind_textdomain_codeset/textdomain	(available in external gettext "libintl" library)
     bsearch
     btowc
-    c16rtomb			(ISO C11)
-    c32rtomb			(ISO C11)
-    cabs
-    cabsf
-    cabsl
-    cacos
-    cacosf
-    cacosl
-    cacosh
-    cacoshf
-    cacoshl
+    c16rtomb/c32rtomb		(ISO C11)
+    cabs/cabsf/cabsl
+    cacos/cacosf/cacosl
+    cacosh/cacoshf/cacoshl
     call_once			(ISO C11)
     calloc
-    carg
-    cargf
-    cargl
-    casin
-    casinf
-    casinl
-    casinh
-    casinhf
-    casinhl
-    catan
-    catanf
-    catanl
-    catanh
-    catanhf
-    catanhl
+    carg/cargf/cargl
+    casin/casinf/casinl
+    casinh/casinhf/casinhl
+    catan/catanf/catanl
+    catanh/catanhf/catanhl
     catclose
     catgets
     catopen
-    cbrt
-    cbrtf
-    cbrtl
-    ccos
-    ccosf
-    ccosl
-    ccosh
-    ccoshf
-    ccoshl
-    ceil
-    ceilf
-    ceill
-    cexp
-    cexpf
-    cexpl
-    cfgetispeed
-    cfgetospeed
-    cfsetispeed
-    cfsetospeed
+    cbrt/cbrtf/cbrtl
+    ccos/ccosf/ccosl
+    ccosh/ccoshf/ccoshl
+    ceil/ceilf/ceill
+    cexp/cexpf/cexpl
+    cfgetispeed/cfgetospeed
+    cfsetispeed/cfsetospeed
     chdir
-    chmod
-    chown
-    cimag
-    cimagf
-    cimagl
+    chmod/fchmodat
+    chown/fchownat
+    cimag/cimagf/cimagl
     clearerr
     clock
     clock_getcpuclockid
-    clock_getres
-    clock_gettime
+    clock_getres/clock_gettime/clock_settime	(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     clock_nanosleep		(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
-    clock_settime		(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
-    clog
-    clogf
-    clogl
+    clog/clogf/clogl
     close
     closedir
-    closelog
-    cnd_broadcast		(ISO C11)
-    cnd_destroy			(ISO C11)
-    cnd_init			(ISO C11)
-    cnd_signal			(ISO C11)
-    cnd_timedwait		(ISO C11)
-    cnd_wait			(ISO C11)
+    closelog/openlog/setlogmask/syslog
+    cnd_broadcast/cnd_signal	(ISO C11)
+    cnd_destroy/cnd_init	(ISO C11)
+    cnd_timedwait/cnd_wait	(ISO C11)
     confstr
-    conj
-    conjf
-    conjl
+    conj/conjf/conjl
     connect
-    copysign
-    copysignf
-    copysignl
-    cos
-    cosf
-    cosl
-    cosh
-    coshf
-    coshl
-    cpow
-    cpowf
-    cpowl
-    cproj
-    cprojf
-    cprojl
-    creal
-    crealf
-    creall
+    copysign/copysignf/copysignl
+    cos/cosf/cosl
+    cosh/coshf/coshl
+    cpow/cpowf/cpowl
+    cproj/cprojf/cprojl
+    creal/crealf/creall
     creat
     crypt			(available in external "crypt" library)
-    csin
-    csinf
-    csinl
-    csinh
-    csinhf
-    csinhl
-    csqrt
-    csqrtf
-    csqrtl
-    ctan
-    ctanf
-    ctanl
-    ctanh
-    ctanhf
-    ctanhl
+    csin/csinf/csinl
+    csinh/csinhf/csinhl
+    csqrt/csqrtf/csqrtl
+    ctan/ctanf/ctanl
+    ctanh/ctanhf/ctanhl
     ctermid
-    ctime
-    ctime_r
-    daylight
+    ctime/ctime_r
+    daylight/timezone/tzname/tzset
     dbm_clearerr		(available in external "libgdbm" library)
     dbm_close			(available in external "libgdbm" library)
     dbm_delete			(available in external "libgdbm" library)
@@ -237,9 +138,8 @@ ISO/IEC DIS 9945 Information technology
     dbm_nextkey			(available in external "libgdbm" library)
     dbm_open			(available in external "libgdbm" library)
     dbm_store			(available in external "libgdbm" library)
-    dcgettext			(available in external gettext "libintl" library)
-    dcngettext			(available in external gettext "libintl" library)
-    dgettext			(available in external gettext "libintl" library)
+    dcgettext/dgettext/gettext		(available in external gettext "libintl" library)
+    dcngettext/dngettext/ngettext	(available in external gettext "libintl" library)
     difftime
     dirfd
     dirname
@@ -249,216 +149,138 @@ ISO/IEC DIS 9945 Information technology
     dlerror
     dlopen
     dlsym
-    dngettext			(available in external gettext "libintl" library)
-    dprintf
-    drand48
-    dup
-    dup2
-    dup3
+    dprintf/fprintf/printf/snprintf/sprintf
+    drand48/erand48/jrand48/lcong48/lrand48/mrand48/nrand48/seed48/srand48
+    dup/dup2/dup3
     duplocale
     encrypt			(available in external "crypt" library)
-    endgrent
-    endhostent
-    endprotoent
-    endpwent
-    endservent
-    endutxent
+    endgrent/getgrent/setgrent
+    endhostent/sethostent
+    endprotoent/getprotobyname/getprotobynumber/getprotoent/setprotoent
+    endpwent/getpwent/setpwent
+    endservent/getservbyname/getservbyport/getservent/setservent
+    endutxent/getutxent/getutxid/getutxline/pututxline/setutxent
     environ
-    erand48
-    erf
-    erff
-    erfl
-    erfc
-    erfcf
-    erfcl
+    erf/erff/erfl
+    erfc/erfcf/erfcl
     errno
-    execl
-    execle
-    execlp
-    execv
-    execve
-    execvp
+    execl/execle/execlp
+    execv/execve/execvp
     exit
-    exp
-    expf
-    expl
-    exp2
-    exp2f
-    exp2l
-    expm1
-    expm1f
-    expm1l
-    fabs
-    fabsf
-    fabsl
-    faccessat
+    exp/expf/expl
+    exp2/exp2f/exp2l
+    expm1/expm1f/expm1l
+    fabs/fabsf/fabsl
     fchdir
     fchmod
-    fchmodat
     fchown
-    fchownat
     fclose
     fcntl			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     fdatasync
-    fdim
-    fdimf
-    fdiml
+    fdim/fdimf/fdiml
     fdopen
-    fdopendir
+    fdopendir/opendir
     feclearexcept
-    fegetenv
-    fegetexceptflag
-    fegetround
+    fegetenv/fesetenv
+    fegetexceptflag/fesetexceptflag
+    fegetround/fesetround
     feholdexcept
     feof
     feraiseexcept
     ferror
-    fesetenv
-    fesetexceptflag
-    fesetround
     fetestexcept
     feupdateenv
     fexecve
     fflush
-    ffs
-    ffsl
-    ffsll
+    ffs/ffsl/ffsll
     fgetc
     fgetpos
     fgets
     fgetwc
     fgetws
     fileno
-    flockfile
-    floor
-    floorf
-    floorl
-    fma
-    fmaf
-    fmal
-    fmax
-    fmaxf
-    fmaxl
+    flockfile/ftrylockfile/funlockfile
+    floor/floorf/floorl
+    fma/fmaf/fmal
+    fmax/fmaxf/fmaxl
     fmemopen
-    fmin
-    fminf
-    fminl
-    fmod
-    fmodf
-    fmodl
+    fmin/fminf/fminl
+    fmod/fmodf/fmodl
     fnmatch
     fopen
     fork
-    fpathconf
+    fpathconf/pathconf
     fpclassify			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
-    fprintf
     fputc
     fputs
     fputwc
     fputws
     fread
     free
-    freeaddrinfo
+    freeaddrinfo/getaddrinfo
     freelocale
     freopen
-    frexp
-    frexpf
-    frexpl
-    fscanf
-    fseek
-    fseeko
+    frexp/frexpf/frexpl
+    fscanf/scanf/sscanf
+    fseek/fseeko
     fsetpos
     fstat
-    fstatat
-    fstatvfs
+    fstatat/lstat/stat
+    fstatvfs/statvfs
     fsync
-    ftell
-    ftello
+    ftell/ftello
     ftok
     ftruncate
-    ftrylockfile
-    funlockfile
-    futimens
+    futimens/utimensat/utimes
     fwide
-    fwprintf
+    fwprintf/swprintf/wprintf
     fwrite
-    fwscanf
+    fwscanf/swscanf/wscanf
     gai_strerror
-    getaddrinfo
     getc
-    getc_unlocked
+    getc_unlocked/getchar_unlocked/putc_unlocked/putchar_unlocked
     getchar
-    getchar_unlocked
     getcwd
-    getdelim
+    getdelim/getline
     getegid
     getentropy			(Cygwin DLL)
-    getenv
+    getenv/secure_getenv
     geteuid
     getgid
-    getgrent
-    getgrgid
-    getgrgid_r
-    getgrnam
-    getgrnam_r
+    getgrgid/getgrgid_r
+    getgrnam/getgrnam_r
     getgroups
     gethostid
     gethostname
-    getline
     getlocalename_l		(Cygwin DLL)
-    getlogin
-    getlogin_r
+    getlogin/getlogin_r
     getnameinfo
-    getopt
+    getopt/optarg/opterr/optind/optopt
     getpeername
     getpgid
     getpgrp
     getpid
     getppid
-    getpriority
-    getprotobyname
-    getprotobynumber
-    getprotoent
-    getpwent
-    getpwnam
-    getpwnam_r
-    getpwuid
-    getpwuid_r
-    getrlimit			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
+    getpriority/setpriority	(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
+    getpwnam/getpwnam_r
+    getpwuid/getpwuid_r
+    getrlimit/setrlimit		(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     getrusage
-    getservbyname
-    getservbyport
-    getservent
     getsid
     getsockname
     getsockopt
     getsubopt
-    gettext			(available in external gettext "libintl" library)
     getuid
-    getutxent
-    getutxid
-    getutxline
     getwc
     getwchar
-    glob
-    globfree
-    gmtime
-    gmtime_r
+    glob/globfree
+    gmtime/gmtime_r
     grantpt
-    hcreate
-    hdestroy
-    hsearch
-    htobe16			(available in "endian.h" header)
-    htobe32			(available in "endian.h" header)
-    htobe64			(available in "endian.h" header)
-    htole16			(available in "endian.h" header)
-    htole32			(available in "endian.h" header)
-    htole64			(available in "endian.h" header)
-    htonl
-    htons
-    hypot
-    hypotf
-    hypotl
+    hcreate/hdestroy/hsearch
+    htobe16/htobe32/htobe64	(available in "endian.h" header)
+    htole16/htole32/htole64	(available in "endian.h" header)
+    htonl/htons
+    hypot/hypotf/hypotl
     iconv			(available in external "libiconv" library)
     iconv_close			(available in external "libiconv" library)
     iconv_open			(available in external "libiconv" library)
@@ -466,153 +288,83 @@ ISO/IEC DIS 9945 Information technology
     if_indextoname
     if_nameindex
     if_nametoindex
-    ilogb
-    ilogbf
-    ilogbl
+    ilogb/ilogbf/ilogbl
     imaxabs
     imaxdiv
-    in6addr_any			(Cygwin DLL)
-    in6addr_loopback		(Cygwin DLL)
-    inet_addr
-    inet_ntoa
-    inet_ntop
-    inet_pton
-    initstate
-    insque
-    isalnum
-    isalnum_l
-    isalpha
-    isalpha_l
+    in6addr_any/in6addr_loopback	(Cygwin DLL)
+    inet_addr/inet_ntoa
+    inet_ntop/inet_pton
+    initstate/random/setstate/srandom
+    insque/remque
+    isalnum/isalnum_l
+    isalpha/isalpha_l
     isatty
-    isblank
-    isblank_l
-    iscntrl
-    iscntrl_l
-    isdigit
-    isdigit_l
+    isblank/isblank_l
+    iscntrl/iscntrl_l
+    isdigit/isdigit_l
     isfinite			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
-    isgraph
-    isgraph_l
-    isgreater			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
-    isgreaterequal		(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
-    isinf			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
-    isless
-    islessequal			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
+    isgraph/isgraph_l
+    isgreater/isgreaterequal	(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
+    isless/islessequal		(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     islessgreater		(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
-    islower
-    islower_l
+    isinf			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
+    islower/islower_l
     isnan			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     isnormal			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
-    isprint
-    isprint_l
-    ispunct
-    ispunct_l
-    isspace
-    isspace_l
+    isprint/isprint_l
+    ispunct/ispunct_l
+    isspace/isspace_l
     isunordered			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
-    isupper
-    isupper_l
-    iswalnum
-    iswalnum_l
-    iswalpha
-    iswalpha_l
-    iswblank
-    iswblank_l
-    iswcntrl
-    iswcntrl_l
-    iswctype
-    iswctype_l
-    iswdigit
-    iswdigit_l
-    iswgraph
-    iswgraph_l
-    iswlower
-    iswlower_l
-    iswprint
-    iswprint_l
-    iswpunct
-    iswpunct_l
-    iswspace
-    iswspace_l
-    iswupper
-    iswupper_l
-    iswxdigit
-    iswxdigit_l
-    isxdigit
-    isxdigit_l
-    j0
-    j1
-    jn
-    jrand48
+    isupper/isupper_l
+    iswalnum/iswalnum_l
+    iswalpha/iswalpha_l
+    iswblank/iswblank_l
+    iswcntrl/iswcntrl_l
+    iswctype/iswctype_l
+    iswdigit/iswdigit_l
+    iswgraph/iswgraph_l
+    iswlower/iswlower_l
+    iswprint/iswprint_l
+    iswpunct/iswpunct_l
+    iswspace/iswspace_l
+    iswupper/iswupper_l
+    iswxdigit/iswxdigit_l
+    isxdigit/isxdigit_l
+    j0/j1/jn
     kill
     kill_dependency		(available in GCC "stdatomic.h" header)
     killpg
-    l64a
-    labs
+    labs/llabs
     lchown
-    lcong48
-    ldexp
-    ldexpf
-    ldexpl
-    ldiv
-    le16toh			(available in "endian.h" header)
-    le32toh			(available in "endian.h" header)
-    le64toh			(available in "endian.h" header)
-    lfind
-    lgamma
-    lgammaf
-    lgammal
-    link
-    linkat
+    ldexp/ldexpf/ldexpl
+    ldiv/lldiv
+    le16toh/le32toh/le64toh	(available in "endian.h" header)
+    lfind/lsearch
+    lgamma/lgammaf/lgammal/signgam
+    link/linkat
     lio_listio
     listen
-    llabs
-    lldiv
-    llrint
-    llrintf
-    llrintl
-    llround
-    llroundf
-    llroundl
+    llrint/llrintf/llrintl
+    llround/llroundf/llroundl
     localeconv
-    localtime
-    localtime_r
+    localtime/localtime_r
     lockf			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
-    log
-    logf
-    logl
-    log10
-    log10f
-    log10l
-    log1p
-    log1pf
-    log1pl
-    log2
-    log2f
-    log2l
-    logb
-    logbf
-    logbl
+    log/logf/logl
+    log10/log10f/log10l
+    log1p/log1pf/log1pl
+    log2/log2f/log2l
+    logb/logbf/logbl
     longjmp
-    lrand48
-    lrint
-    lrintf
-    lrintl
-    lround
-    lroundf
-    lroundl
-    lsearch
+    lrint/lrintf/lrintl
+    lround/lroundf/lroundl
     lseek
-    lstat
     malloc
     mblen
     mbrlen
-    mbrtoc16			(ISO C23 - available in "uchar.h" header)
-    mbrtoc32			(ISO C23 - available in "uchar.h" header)
+    mbrtoc16/mbrtoc32		(ISO C23 - available in "uchar.h" header)
     mbrtowc
     mbsinit
-    mbsnrtowcs
-    mbsrtowcs
+    mbsnrtowcs/mbsrtowcs
     mbstowcs
     mbtowc
     memccpy
@@ -622,85 +374,48 @@ ISO/IEC DIS 9945 Information technology
     memmem
     memmove
     memset
-    mkdir
-    mkdirat
-    mkdtemp
-    mkfifo
-    mkfifoat
-    mknod
-    mknodat
-    mkostemp
-    mkstemp
+    mkdir/mkdirat
+    mkfifo/mkfifoat
+    mknod/mknodat
+    mkdtemp/mkostemp/mkstemp
     mktime
-    mlock
+    mlock/munlock
     mmap
-    modf
-    modff
-    modfl
+    modf/modff/modfl
     mprotect
     mq_close
     mq_getattr
     mq_notify
     mq_open
-    mq_receive
-    mq_send
+    mq_receive/mq_timedreceive
+    mq_send/mq_timedsend
     mq_setattr
-    mq_timedreceive
-    mq_timedsend
     mq_unlink
-    mrand48
     msgctl			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     msgget			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     msgrcv			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     msgsnd			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     msync
-    mtx_destroy			(ISO C11)
-    mtx_init			(ISO C11)
-    mtx_lock			(ISO C11)
-    mtx_timedlock		(ISO C11)
-    mtx_trylock			(ISO C11)
-    mtx_unlock			(ISO C11)
-    munlock
+    mtx_destroy/mtx_init	(ISO C11)
+    mtx_lock/mtx_timedlock/mtx_trylock/mtx_unlock	(ISO C11)
     munmap
-    nan
-    nanf
-    nanl
+    nan/nanf/nanl
     nanosleep
-    nearbyint
-    nearbyintf
-    nearbyintl
+    nearbyint/nearbyintf/nearbyintl
     newlocale
-    nextafter
-    nextafterf
-    nextafterl
-    nexttoward
-    nexttowardf
-    nexttowardl
+    nextafter/nextafterf/nextafterl
+    nexttoward/nexttowardf/nexttowardl
     nftw
-    ngettext			(available in external gettext "libintl" library)
     nice			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
-    nl_langinfo
-    nl_langinfo_l
-    nrand48
-    ntohl
-    ntohs
-    open
-    open_memstream
-    open_wmemstream
-    openat
-    opendir
-    openlog
-    optarg
-    opterr
-    optind
-    optopt
-    pathconf
+    nl_langinfo/nl_langinfo_l
+    ntohl/ntohs
+    open/openat
+    open_memstream/open_wmemstream
     pause
     pclose
     perror
-    pipe
-    pipe2
-    poll
+    pipe/pipe2
+    poll/ppoll
     popen
     posix_fadvise
     posix_fallocate
@@ -708,87 +423,52 @@ ISO/IEC DIS 9945 Information technology
     posix_madvise
     posix_memalign
     posix_openpt
-    posix_spawn
+    posix_spawn/posix_spawnp
     posix_spawn_file_actions_addchdir	(available as posix_spawn_file_actions_addchdir_np)
-    posix_spawn_file_actions_addclose
+    posix_spawn_file_actions_addclose/posix_spawn_file_actions_addopen
     posix_spawn_file_actions_adddup2
     posix_spawn_file_actions_addfchdir	(available as posix_spawn_file_actions_addfchdir_np)
-    posix_spawn_file_actions_addopen
-    posix_spawn_file_actions_destroy
-    posix_spawn_file_actions_init
-    posix_spawnattr_destroy
-    posix_spawnattr_getflags
-    posix_spawnattr_getpgroup
-    posix_spawnattr_getschedparam
-    posix_spawnattr_getschedpolicy
-    posix_spawnattr_getsigdefault
-    posix_spawnattr_getsigmask
-    posix_spawnattr_init
-    posix_spawnattr_setflags
-    posix_spawnattr_setpgroup
-    posix_spawnattr_setschedparam
-    posix_spawnattr_setschedpolicy
-    posix_spawnattr_setsigdefault
-    posix_spawnattr_setsigmask
-    posix_spawnp
-    pow
-    powf
-    powl
-    ppoll
-    pread
-    printf
-    pselect
-    psiginfo
-    psignal
+    posix_spawn_file_actions_destroy/posix_spawn_file_actions_init
+    posix_spawnattr_destroy/posix_spawnattr_init
+    posix_spawnattr_getflags/posix_spawnattr_setflags
+    posix_spawnattr_getpgroup/posix_spawnattr_setpgroup
+    posix_spawnattr_getschedparam/posix_spawnattr_setschedparam
+    posix_spawnattr_getschedpolicy/posix_spawnattr_setschedpolicy
+    posix_spawnattr_getsigdefault/posix_spawnattr_setsigdefault
+    posix_spawnattr_getsigmask/posix_spawnattr_setsigmask
+    pow/powf/powl
+    pread/read
+    pselect/select
+    psiginfo/psignal
     pthread_atfork
-    pthread_attr_destroy
-    pthread_attr_getdetachstate
-    pthread_attr_getguardsize
-    pthread_attr_getinheritsched
-    pthread_attr_getschedparam
-    pthread_attr_getschedpolicy
-    pthread_attr_getscope
-    pthread_attr_getstack
-    pthread_attr_getstacksize
-    pthread_attr_init
-    pthread_attr_setdetachstate
-    pthread_attr_setguardsize
-    pthread_attr_setinheritsched
-    pthread_attr_setschedparam
-    pthread_attr_setschedpolicy
-    pthread_attr_setscope
-    pthread_attr_setstack
-    pthread_attr_setstacksize
-    pthread_barrier_destroy
-    pthread_barrier_init
+    pthread_attr_destroy/pthread_attr_init
+    pthread_attr_getdetachstate/pthread_attr_setdetachstate
+    pthread_attr_getguardsize/pthread_attr_setguardsize
+    pthread_attr_getinheritsched/pthread_attr_setinheritsched
+    pthread_attr_getschedparam/pthread_attr_setschedparam
+    pthread_attr_getschedpolicy/pthread_attr_setschedpolicy
+    pthread_attr_getscope/pthread_attr_setscope
+    pthread_attr_getstack/pthread_attr_setstack
+    pthread_attr_getstacksize/pthread_attr_setstacksize
+    pthread_barrier_destroy/pthread_barrier_init
     pthread_barrier_wait
-    pthread_barrierattr_destroy
-    pthread_barrierattr_getpshared
-    pthread_barrierattr_init
-    pthread_barrierattr_setpshared
+    pthread_barrierattr_destroy/pthread_barrierattr_init
+    pthread_barrierattr_getpshared/pthread_barrierattr_setpshared
     pthread_cancel
-    pthread_cleanup_pop		(available in "pthread.h" header)
-    pthread_cleanup_push	(available in "pthread.h" header)
-    pthread_cond_broadcast
-    pthread_cond_clockwait
-    pthread_cond_destroy
-    pthread_cond_init
-    pthread_cond_signal
-    pthread_cond_timedwait
-    pthread_cond_wait
-    pthread_condattr_destroy
-    pthread_condattr_getclock
-    pthread_condattr_getpshared
-    pthread_condattr_init
-    pthread_condattr_setclock
-    pthread_condattr_setpshared
+    pthread_cleanup_pop/pthread_cleanup_push	(available in "pthread.h" header)
+    pthread_cond_broadcast/pthread_cond_signal
+    pthread_cond_clockwait/pthread_cond_timedwait/pthread_cond_wait
+    pthread_cond_destroy/pthread_cond_init
+    pthread_condattr_destroy/pthread_condattr_init
+    pthread_condattr_getclock/pthread_condattr_setclock
+    pthread_condattr_getpshared/pthread_condattr_setpshared
     pthread_create
     pthread_detach
     pthread_equal
     pthread_exit
     pthread_getcpuclockid
-    pthread_getschedparam
-    pthread_getspecific
+    pthread_getschedparam/pthread_setschedparam
+    pthread_getspecific/pthread_setspecific
     pthread_join
     pthread_key_create
     pthread_key_delete
@@ -813,118 +493,69 @@ ISO/IEC DIS 9945 Information technology
     pthread_mutexattr_setpshared
     pthread_mutexattr_settype
     pthread_once
-    pthread_rwlock_clockrdlock
-    pthread_rwlock_clockwrlock
-    pthread_rwlock_destroy
-    pthread_rwlock_init
-    pthread_rwlock_rdlock
-    pthread_rwlock_timedrdlock
-    pthread_rwlock_timedwrlock
-    pthread_rwlock_tryrdlock
-    pthread_rwlock_trywrlock
+    pthread_rwlock_clockrdlock/pthread_rwlock_timedrdlock
+    pthread_rwlock_clockwrlock/pthread_rwlock_timedwrlock
+    pthread_rwlock_destroy/pthread_rwlock_init
+    pthread_rwlock_rdlock/pthread_rwlock_tryrdlock
+    pthread_rwlock_trywrlock/pthread_rwlock_wrlock
     pthread_rwlock_unlock
-    pthread_rwlock_wrlock
-    pthread_rwlockattr_destroy
-    pthread_rwlockattr_getpshared
-    pthread_rwlockattr_init
-    pthread_rwlockattr_setpshared
+    pthread_rwlockattr_destroy/pthread_rwlockattr_init
+    pthread_rwlockattr_getpshared/pthread_rwlockattr_setpshared
     pthread_self
-    pthread_setcancelstate
-    pthread_setcanceltype
-    pthread_setschedparam
+    pthread_setcancelstate/pthread_setcanceltype/pthread_testcancel
     pthread_setschedprio
-    pthread_setspecific
-    pthread_sigmask
-    pthread_spin_destroy
-    pthread_spin_init
-    pthread_spin_lock
-    pthread_spin_trylock
+    pthread_sigmask/sigprocmask
+    pthread_spin_destroy/pthread_spin_init
+    pthread_spin_lock/pthread_spin_trylock
     pthread_spin_unlock
-    pthread_testcancel
-    ptsname
-    ptsname_r
+    ptsname/ptsname_r
     putc
-    putc_unlocked
     putchar
-    putchar_unlocked
     putenv
     puts
-    pututxline
     putwc
     putwchar
-    pwrite
-    qsort
-    qsort_r			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
+    pwrite/write
+    qsort/qsort_r		(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     quick_exit			(ISO C11)
     raise
-    rand
-    random
-    read
-    readdir
-    readdir_r
-    readlink
-    readlinkat
+    rand/srand
+    readdir/readdir_r
+    readlink/readlinkat
     readv
-    realloc
-    reallocarray
+    realloc/reallocarray
     realpath
-    recv
-    recvfrom
+    recv/recvfrom
     recvmsg
-    regcomp
-    regerror
-    regexec
-    regfree
-    remainder
-    remainderf
-    remainderl			(ISO C99 - available in "math.h" header)
+    regcomp/regerror/regexec/regfree
+    remainder/remainderf/remainderl	(ISO C99 - available in "math.h" header)
     remove
-    remque
-    remquo
-    remquof
-    remquol
-    rename
-    renameat
+    remquo/remquof/remquol
+    rename/renameat
     rewind
     rewinddir
-    rint
-    rintf
-    rintl
+    rint/rintf/rintl
     rmdir
-    round
-    roundf
-    roundl
-    scalbln
-    scalblnf
-    scalblnl
-    scalbn
-    scalbnf
-    scalbnl
-    scandir
-    scanf
-    sched_get_priority_max
-    sched_get_priority_min
+    round/roundf/roundl
+    scalbln/scalblnf/scalblnl
+    scalbn/scalbnf/scalbnl
+    sched_get_priority_max/sched_get_priority_min
     sched_getparam
     sched_getscheduler
     sched_rr_get_interval
     sched_setparam		(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     sched_setscheduler		(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     sched_yield
-    secure_getenv
-    seed48
     seekdir
-    select
-    sem_clockwait
+    sem_clockwait/sem_timedwait
     sem_close
     sem_destroy
     sem_getvalue
     sem_init
     sem_open
     sem_post
-    sem_timedwait
-    sem_trywait
+    sem_trywait/sem_wait
     sem_unlink
-    sem_wait
     semctl			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     semget			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     semop			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
@@ -936,25 +567,15 @@ ISO/IEC DIS 9945 Information technology
     setenv
     seteuid
     setgid
-    setgrent
-    sethostent
     setjmp
     setkey			(available in external "crypt" library)
     setlocale
-    setlogmask
     setpgid
-    setpriority			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
-    setprotoent
-    setpwent
     setregid
     setreuid
-    setrlimit			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
-    setservent
     setsid
     setsockopt
-    setstate
     setuid
-    setutxent
     setvbuf
     shm_open
     shm_unlink
@@ -963,7 +584,7 @@ ISO/IEC DIS 9945 Information technology
     shmdt			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     shmget			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     shutdown
-    sig2str
+    sig2str/str2sig
     sigaction
     sigaddset
     sigaltstack
@@ -974,103 +595,55 @@ ISO/IEC DIS 9945 Information technology
     siglongjmp
     signal
     signbit			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
-    signgam
     sigpending
-    sigprocmask
     sigqueue
     sigsetjmp
     sigsuspend
-    sigtimedwait
+    sigtimedwait/sigwaitinfo
     sigwait
-    sigwaitinfo
-    sin
-    sinf
-    sinl
-    sinh
-    sinhf
-    sinhl
+    sin/sinf/sinl
+    sinh/sinhf/sinhl
     sleep
-    snprintf
     sockatmark
     socket
     socketpair
-    sprintf
-    sqrt
-    sqrtf
-    sqrtl
-    srand
-    srand48
-    srandom
-    sscanf
-    stat
-    statvfs
-    stderr
-    stdin
-    stdout
-    stpcpy
-    stpncpy
-    str2sig
-    strcasecmp
-    strcasecmp_l
+    sqrt/sqrtf/sqrtl
+    stderr/stdin/stdout
+    stpcpy/strcpy
+    stpncpy/strncpy
+    strcasecmp/strcasecmp_l/strncasecmp/strncasecmp_l
     strcat
     strchr
     strcmp
-    strcoll
-    strcoll_l
-    strcpy
+    strcoll/strcoll_l
     strcspn
-    strdup
-    strerror
-    strerror_l
-    strerror_r			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
-    strfmon
-    strfmon_l
-    strftime
-    strftime_l
-    strlcat
-    strlcpy
-    strlen
-    strncasecmp
-    strncasecmp_l
+    strdup/strndup
+    strerror/strerror_l/strerror_r	(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
+    strfmon/strfmon_l
+    strftime/strftime_l
+    strlcat/strlcpy
+    strlen/strnlen
     strncat
     strncmp
-    strncpy
-    strndup
-    strnlen
     strpbrk
     strptime
     strrchr
     strsignal
     strspn
     strstr
-    strtod
-    strtof
-    strtoimax
-    strtok
-    strtok_r
-    strtol
-    strtold
-    strtoll
-    strtoul
-    strtoull
-    strtoumax
-    strxfrm
-    strxfrm_l
+    strtod/strtof/strtold
+    strtoimax/strtoumax
+    strtok/strtok_r
+    strtol/strtoll
+    strtoul/strtoull
+    strxfrm/strxfrm_l
     swab
-    swprintf
-    swscanf
-    symlink
-    symlinkat
+    symlink/symlinkat
     sync
     sysconf
-    syslog
     system
-    tan
-    tanf
-    tanl
-    tanh
-    tanhf
-    tanhl
+    tan/tanf/tanl
+    tanh/tanhf/tanhl
     tcdrain
     tcflow
     tcflush
@@ -1080,13 +653,9 @@ ISO/IEC DIS 9945 Information technology
     tcsendbreak
     tcsetattr
     tcsetpgrp
-    tdelete
+    tdelete/tfind/tsearch/twalk
     telldir
-    textdomain			(available in external gettext "libintl" library)
-    tfind
-    tgamma
-    tgammaf
-    tgammal
+    tgamma/tgammaf/tgammal
     thrd_create			(ISO C11)
     thrd_current		(ISO C11)
     thrd_detach			(ISO C11)
@@ -1098,134 +667,77 @@ ISO/IEC DIS 9945 Information technology
     time
     timer_create		(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     timer_delete
-    timer_getoverrun
-    timer_gettime
-    timer_settime
+    timer_getoverrun/timer_gettime/timer_settime
     times
     timespec_get		(Cygwin DLL)
-    timezone
     tmpfile
     tmpnam
-    tolower
-    tolower_l
-    toupper
-    toupper_l
-    towctrans
-    towctrans_l
-    towlower
-    towlower_l
-    towupper
-    towupper_l
-    trunc
-    truncf
-    truncl
+    tolower/tolower_l
+    toupper/toupper_l
+    towctrans/towctrans_l
+    towlower/towlower_l
+    towupper/towupper_l
+    trunc/truncf/truncl
     truncate
-    tsearch
     tss_create			(ISO C11)
     tss_delete			(ISO C11)
-    tss_get			(ISO C11)
-    tss_set			(ISO C11)
-    ttyname
-    ttyname_r
-    twalk
-    tzname
-    tzset
+    tss_get/tss_set		(ISO C11)
+    ttyname/ttyname_r
     umask
     uname
     ungetc
     ungetwc
-    unlink
-    unlinkat
+    unlink/unlinkat
     unlockpt
     unsetenv
     uselocale
-    utimensat
-    utimes
-    va_arg
-    va_copy
-    va_end
-    va_start
-    vasprintf
-    vdprintf
-    vfprintf
-    vfscanf
-    vfwprintf
-    vfwscanf
-    vprintf
-    vscanf
-    vsnprintf
-    vsprintf
-    vsscanf
-    vswprintf
-    vswscanf
-    vwprintf
-    vwscanf
-    wait
-    waitpid
-    wcpcpy
-    wcpncpy
+    va_arg/va_copy/va_end/va_start
+    vasprintf/vdprintf/vfprintf/vprintf/vsnprintf/vsprintf
+    vfscanf/vscanf/vsscanf
+    vfwprintf/vswprintf/vwprintf
+    vfwscanf/vswscanf/vwscanf
+    wait/waitpid
+    wcpcpy/wcscpy
+    wcpncpy/wcsncpy
     wcrtomb
-    wcscasecmp
-    wcscasecmp_l
+    wcscasecmp/wcscasecmp_l/wcsncasecmp/wcsncasecmp_l
     wcscat
     wcschr
     wcscmp
-    wcscoll
-    wcscoll_l
-    wcscpy
+    wcscoll/wcscoll_l
     wcscspn
     wcsdup
     wcsftime
-    wcslcat
-    wcslcpy
-    wcslen
-    wcsncasecmp
-    wcsncasecmp_l
+    wcslcat/wcslcpy
+    wcslen/wcsnlen
     wcsncat
     wcsncmp
-    wcsncpy
-    wcsnlen
-    wcsnrtombs
+    wcsnrtombs/wcsrtombs
     wcspbrk
     wcsrchr
-    wcsrtombs
     wcsspn
     wcsstr
-    wcstod
-    wcstof
-    wcstoimax
+    wcstod/wcstof/wcstold
+    wcstoimax/wcstoumax
     wcstok
-    wcstol
-    wcstold
-    wcstoll
+    wcstol/wcstoll
     wcstombs
-    wcstoul
-    wcstoull
-    wcstoumax
+    wcstoul/wcstoull
     wcswidth
-    wcsxfrm
-    wcsxfrm_l
+    wcsxfrm/wcsxfrm_l
     wctob
     wctomb
-    wctrans
-    wctrans_l
-    wctype
-    wctype_l
+    wctrans/wctrans_l
+    wctype/wctype_l
     wcwidth
     wmemchr
     wmemcmp
     wmemcpy
     wmemmove
     wmemset
-    wordexp
-    wordfree
-    wprintf
-    write
+    wordexp/wordfree
     writev
-    wscanf
-    y0
-    y1
-    yn
+    y0/y1/yn
 </screen>
 
 </sect1>
@@ -1261,14 +773,10 @@ ISO/IEC DIS 9945 Information technology
     fflush_unlocked
     fileno_unlocked
     fgetc_unlocked
-    finite
-    finitef
-    finitel
+    finite/finitef/finitel
     fiprintf
     flock			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
-    fls
-    flsl
-    flsll
+    fls/flsl/flsll
     forkpty
     fpurge
     fputc_unlocked
@@ -1286,10 +794,8 @@ ISO/IEC DIS 9945 Information technology
     funopen
     futimes
     fwrite_unlocked
-    gamma
-    gamma_r
-    gammaf
-    gammaf_r
+    gamma/gamma_r
+    gammaf/gammaf_r
     getdtablesize
     getgrouplist
     getifaddrs
@@ -1389,9 +895,7 @@ ISO/IEC DIS 9945 Information technology
     basename			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     canonicalize_file_name
     clearenv
-    clog10
-    clog10f
-    clog10l
+    clog10/clog10f/clog10l
     close_range			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     crypt_r			(available in external "crypt" library)
     dremf
@@ -1405,9 +909,7 @@ ISO/IEC DIS 9945 Information technology
     error_at_line
     euidaccess
     execvpe
-    exp10
-    exp10f
-    exp10l
+    exp10/exp10f/exp10l
     fallocate			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     fcloseall
     fcloseall_r
@@ -1445,9 +947,7 @@ ISO/IEC DIS 9945 Information technology
     mempcpy
     memrchr
     mkostemps
-    pow10
-    pow10f
-    pow10l
+    pow10/pow10f/pow10l
     pthread_getaffinity_np
     pthread_getattr_np
     pthread_getname_np
@@ -1468,9 +968,7 @@ ISO/IEC DIS 9945 Information technology
     sched_setaffinity
     setxattr
     signalfd
-    sincos
-    sincosf
-    sincosl
+    sincos/sincosf/sincosl
     strchrnul
     strptime_l
     strtod_l
@@ -1528,15 +1026,13 @@ ISO/IEC DIS 9945 Information technology
     acltomode
     acltopbits
     acltotext
-    endmntent
+    endmntent/getmntent/setmntent
     facl
     fegetprec
     fesetprec
     futimesat
     getdomainname		(NIS)
-    getmntent
     memalign
-    setmntent
     xdr_array			(available in external "libtirpc" library)
     xdr_bool			(available in external "libtirpc" library)
     xdr_bytes			(available in external "libtirpc" library)
@@ -1547,12 +1043,8 @@ ISO/IEC DIS 9945 Information technology
     xdr_free			(available in external "libtirpc" library)
     xdr_hyper			(available in external "libtirpc" library)
     xdr_int			(available in external "libtirpc" library)
-    xdr_int16_t			(available in external "libtirpc" library)
-    xdr_int32_t			(available in external "libtirpc" library)
-    xdr_int64_t			(available in external "libtirpc" library)
-    xdr_int8_t			(available in external "libtirpc" library)
-    xdr_long			(available in external "libtirpc" library)
-    xdr_longlong_t		(available in external "libtirpc" library)
+    xdr_int16_t/xdr_int32_t/xdr_int64_t/xdr_int8_t	(available in external "libtirpc" library)
+    xdr_long/xdr_longlong_t	(available in external "libtirpc" library)
     xdr_netobj			(available in external "libtirpc" library)
     xdr_opaque			(available in external "libtirpc" library)
     xdr_pointer			(available in external "libtirpc" library)
@@ -1685,33 +1177,22 @@ ISO/IEC DIS 9945 Information technology
 
 <screen>
     _Fork			(not available in "(sys/)unistd.h" header)
-    dcgettext_l			(not available in external gettext "libintl" library)
-    dcngettext_l		(not available in external gettext "libintl" library)
-    dgettext_l			(not available in external gettext "libintl" library)
-    dngettext_l			(not available in external gettext "libintl" library)
-    endnetent
+    dcgettext_l/dgettext_l/gettext_l	(not available in external gettext "libintl" library)
+    dcngettext_l/dngettext_l/ngettext_l	(not available in external gettext "libintl" library)
+    endnetent/getnetbyaddr/getnetbyname/getnetent/setnetent
     fmtmsg
-    getdate
-    getdate_err
+    getdate/getdate_err
     gethostent
-    getnetbyaddr
-    getnetbyname
-    getnetent
     getresgid			(not available in "(sys/)unistd.h" header)
     getresuid			(not available in "(sys/)unistd.h" header)
-    gettext_l			(not available in external gettext "libintl" library)
-    mlockall
-    munlockall
-    ngettext_l			(not available in external gettext "libintl" library)
+    mlockall/munlockall
     posix_close			(not available in "(sys/)unistd.h" header)
     posix_devctl		(prototyped in cygwin-devel "devctl.h" header)
     posix_mem_offset
     posix_typed_mem_get_info	(not available in "(sys/)mman.h" header)
     posix_typed_mem_open	(not available in "(sys/)mman.h" header)
-    pthread_mutexattr_getrobust
-    pthread_mutexattr_setrobust
     pthread_mutex_consistent
-    setnetent
+    pthread_mutexattr_getrobust/pthread_mutexattr_setrobust
     setresgid			(not available in "(sys/)unistd.h" header)
     setresuid			(not available in "(sys/)unistd.h" header)
     tcgetwinsize		(not available in "(sys/)termios.h" header)
-- 
2.45.1

