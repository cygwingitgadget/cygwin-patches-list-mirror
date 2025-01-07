Return-Path: <SRS0=xnp6=T7=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	by sourceware.org (Postfix) with ESMTPS id CC3C83858D28
	for <cygwin-patches@cygwin.com>; Tue,  7 Jan 2025 23:59:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CC3C83858D28
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CC3C83858D28
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.14
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736294354; cv=none;
	b=Eyp70CCPhzOAEufFPQUAc9SzLUIn19KPHo66FjuSS4xhh7C1gqgJDvD2d2/avASoTNtyYpuBpGO5QqfQasRSi/nUw0Js4Mcyg99oaV/uQ5bP037TcAo/u8V1iHSPj0y5gQr/71859x1biqbPH/RTGcnT3FFfKe7bSixaT4/xHfA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736294354; c=relaxed/simple;
	bh=q9nnp3uujVBz7g8hS/Msyr4eZuT8uY7NR45ODWIAmVE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=BNfqSHFrmuhIVQjZQBTBrbGOCFavOog2IGeKmLxRdYUsfmuFezg+pv0YGI6eZTR/eKgckxIJ2xeh0veEsxIwk/gGKTu0o3psY9gs13aQZnQiinJcZgQl48f2XIYUEV2sXS9Hl7CK6ix+IJqYGFZsv4XXhypZRk2q6x1uMrJxBJs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CC3C83858D28
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=mucI6Kxy
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 792D7A049A;
	Tue,  7 Jan 2025 23:59:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf08.hostedemail.com (Postfix) with ESMTPA id 042DE20025;
	Tue,  7 Jan 2025 23:59:12 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH v4] Cygwin: winsup/doc/posix.xml: update to SUS V5, POSIX 2024, TOG Base Specs Issue 8, ISO/IEC DIS 9945
Date: Tue,  7 Jan 2025 16:58:10 -0700
Message-ID: <8ad8cb0b4bca9415835cf5391933392d61d2bcdb.1736294236.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Organization: Systematic Software
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 042DE20025
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,KAM_NUMSUBJECT,KAM_SHORT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: 595773s7y7mj9nczg5fi88xh9kj1dw4h
X-Rspamd-Server: rspamout02
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX19V1p8tvxfSjfoRnhknDw7FQ5Ce2lowBMI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=from:to:subject:date:message-id:mime-version:content-type:content-transfer-encoding; s=he; bh=fop8XSvUj6ZOsGmTk4ZhyQ9YkthPW3o0LiTU8u5KN28=; b=mucI6KxyCuc/srtDz7K/yxCkotejsAx9VgM9bYvN4WiyTtpMIcu7E0b2ZXAPp277ZpH7j+SbNCjVbYXFCS8pg6OijZAGhI47U0XnAE3A1kWyX/Vp6IIZujYV3p3DO73g6ALYszQKtBK+EHaJ6cKkGaNpUlzkpDPt1CHvQ3mC9fXpWBK3Zl857s1bgmIG2MW51GFGpC3bfUyyqNdyZIWQ3+wtbpsUOmTdeDDt3vgyUnhIe6fCo3XFvO0VMws54AJFu/jZ+r6awlIupda/eXG4eMJo0Q0ajewGerRO0cZGhAIEqdCWooe3Alao1uTOnyZeEMtQEwizhqSmbv69SMZ9cA==
X-HE-Tag: 1736294352-897043
X-HE-Meta: U2FsdGVkX19xMFJ4W6Y4DpIrUsD/bb1daytCeNrhC8/vh7Z3cdssc/vCmrU9zyavHRrw3lMpihQkDSi7FluhBtnCKfGwxat6XBN3pkYtQPS3vSXhaYgqr6Je+FLsjuGamZXobmL0gUzMghmXA9PLqTpTLjvT0/h6iii4orfEU8BJUThR61RCSWaxTcspTIIOBZfPEZtDwqbMxgAwg09UYnzfM2J28NNDJP+i3ew9G5j++OAqzOxXAJk+Fp0MRcJWHwTWIrfkfKfz8HRxn5gqDrWTijnBrYRBpI7pDvknOwGMm5pZDsmJD3SaVS+pnZ3cilpS+5eKDht4nl91Oz5zI3vgp/hMWSyZmJWn9V9aas8GqafJQikRR83mHx5R/DNv7GHuPEX3pdxqrzDBBnGfnnZHPrXoIVivRXVk8BGrBkb7VIy69WKDEusf/3TN8/y30gtWhxMxpFat8qc2kp5MZeEuZ0rmhTxi0BgOh9VjMCvXvh4fIET1Fyi3/C9cyGFVrZ30dVn3xWa9fV2e2pjkXDHJr/NKNiK5GO2/oMPRN4CBLpE/DMespw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Update anchor id and description to current version, year, issue, etc.
Move new POSIX entries in other sections to the SUS/POSIX section.
Add new POSIX entries from din entries.
Add new entries with interfaces available in headers and packages.
Add those missing to Not Implemented section, with mentions of headers,
packages, etc.

Move dropped entries out of the SUS/POSIX section to Deprecated
Interfaces section and mark with (SUSv4).

Double checking found some functions in the wrong categories which have
been moved to the correct sections, and some functions out of order
which have been reordered.

Move circular TRIGl functions before hyperbolic TRIGh? entries to keep
each together: should we keep them on separate lines out of order, so we
can check if they exist, concatenate onto the same lines with slashes,
or just add the suffixes /f/l on to the base entry?

Merge multiple parenthesized notes into one separated by "-".)

Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 winsup/doc/posix.xml | 326 ++++++++++++++++++++++++++-----------------
 1 file changed, 201 insertions(+), 125 deletions(-)

diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 2782beb86547..78ec9403d738 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -5,10 +5,16 @@
 <chapter id="compatibility" xmlns:xi="http://www.w3.org/2001/XInclude">
 <title>Compatibility</title>
 
-<sect1 id="std-susv4"><title>System interfaces compatible with the Single Unix Specification, Version 7:</title>
+<sect1 id="std-susv5"><title>System interfaces compatible with the Single UNIX® Specification Version 5:</title>
 
-<para>Note that the core of the Single Unix Specification, Version 7 is
-also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
+<para>Note that the core of the Single UNIX® Specification Version 5 is
+POSIX®.1-2024 also simultaneously IEEE Std 1003.1™-2024 Edition,
+The Open Group Base Specifications Issue 8
+(see https://pubs.opengroup.org/onlinepubs/9799919799/), and 
+ISO/IEC DIS 9945 Information technology
+- Portable Operating System Interface (POSIX®) base specifications
+- Issue 8 (expected to replace ISO/IEC/IEEE 9945:2009 - Issue 7 in the coming months
+- see https://www.iso.org/standard/86539.html).</para>
 
 <screen>
     FD_CLR
@@ -17,21 +23,18 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     FD_ZERO
     _Exit
     _exit
-    _longjmp
-    _setjmp
-    _tolower
-    _toupper
     a64l
     abort
     abs
     accept
+    accept4
     access
     acos
     acosf
+    acosl
     acosh
     acoshf
     acoshl
-    acosl
     aio_cancel
     aio_error
     aio_fsync
@@ -40,59 +43,98 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     aio_suspend
     aio_write
     alarm
+    aligned_alloc		(ISO C11)
     alphasort
     asctime
     asctime_r
     asin
     asinf
+    asinl
     asinh
     asinhf
     asinhl
-    asinl
+    asprintf
+    assert			(SVID - available in "assert.h" header)
+    at_quick_exit		(ISO C11)
     atan
+    atanf
+    atanl
     atan2
     atan2f
     atan2l
-    atanf
     atanh
     atanhf
     atanhl
-    atanl
     atexit
     atof
-    atoff
     atoi
     atol
     atoll
+    atomic_compare_exchange_strong		(available in "stdatomic.h" header)
+    atomic_compare_exchange_strong_explicit	(available in "stdatomic.h" header)
+    atomic_compare_exchange_weak		(available in "stdatomic.h" header)
+    atomic_compare_exchange_weak_explicit	(available in "stdatomic.h" header)
+    atomic_exchange		(available in "stdatomic.h" header)
+    atomic_exchange_explicit	(available in "stdatomic.h" header)
+    atomic_fetch_add		(available in "stdatomic.h" header)
+    atomic_fetch_add_explicit	(available in "stdatomic.h" header)
+    atomic_fetch_and		(available in "stdatomic.h" header)
+    atomic_fetch_and_explicit	(available in "stdatomic.h" header)
+    atomic_fetch_or		(available in "stdatomic.h" header)
+    atomic_fetch_or_explicit	(available in "stdatomic.h" header)
+    atomic_fetch_sub		(available in "stdatomic.h" header)
+    atomic_fetch_sub_explicit	(available in "stdatomic.h" header)
+    atomic_fetch_xor		(available in "stdatomic.h" header)
+    atomic_fetch_xor_explicit	(available in "stdatomic.h" header)
+    atomic_flag_clear		(available in "stdatomic.h" header)
+    atomic_flag_clear_explicit	(available in "stdatomic.h" header)
+    atomic_flag_test_and_set	(available in "stdatomic.h" header)
+    atomic_flag_test_and_set_explicit	(available in "stdatomic.h" header)
+    atomic_init			(available in "stdatomic.h" header)
+    atomic_is_lock_free		(available in "stdatomic.h" header)
+    atomic_load			(available in "stdatomic.h" header)
+    atomic_load_explicit	(available in "stdatomic.h" header)
+    atomic_signal_fence		(available in "stdatomic.h" header)
+    atomic_store		(available in "stdatomic.h" header)
+    atomic_store_explicit	(available in "stdatomic.h" header)
+    atomic_thread_fence		(available in "stdatomic.h" header)
     basename			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
+    be16toh			(available in "endian.h" header)
+    be32toh			(available in "endian.h" header)
+    be64toh			(available in "endian.h" header)
     bind
+    bind_textdomain_codeset	(available in external gettext "libintl" library)
+    bindtextdomain		(available in external gettext "libintl" library)
     bsearch
     btowc
+    c16rtomb			(ISO C11)
+    c32rtomb			(ISO C11)
     cabs
     cabsf
     cabsl
     cacos
     cacosf
+    cacosl
     cacosh
     cacoshf
     cacoshl
-    cacosl
+    call_once			(ISO C11)
     calloc
     carg
     cargf
     cargl
     casin
     casinf
+    casinl
     casinh
     casinhf
     casinhl
-    casinl
     catan
     catanf
+    catanl
     catanh
     catanhf
     catanhl
-    catanl
     catclose
     catgets
     catopen
@@ -101,10 +143,10 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     cbrtl
     ccos
     ccosf
+    ccosl
     ccosh
     ccoshf
     ccoshl
-    ccosl
     ceil
     ceilf
     ceill
@@ -134,6 +176,12 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     close
     closedir
     closelog
+    cnd_broadcast		(ISO C11)
+    cnd_destroy			(ISO C11)
+    cnd_init			(ISO C11)
+    cnd_signal			(ISO C11)
+    cnd_timedwait		(ISO C11)
+    cnd_wait			(ISO C11)
     confstr
     conj
     conjf
@@ -161,19 +209,19 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     crypt			(available in external "crypt" library)
     csin
     csinf
+    csinl
     csinh
     csinhf
     csinhl
-    csinl
     csqrt
     csqrtf
     csqrtl
     ctan
     ctanf
+    ctanl
     ctanh
     ctanhf
     ctanhl
-    ctanl
     ctermid
     ctime
     ctime_r
@@ -187,18 +235,24 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     dbm_nextkey			(available in external "libgdbm" library)
     dbm_open			(available in external "libgdbm" library)
     dbm_store			(available in external "libgdbm" library)
+    dcgettext			(available in external gettext "libintl" library)
+    dcngettext			(available in external gettext "libintl" library)
+    dgettext			(available in external gettext "libintl" library)
     difftime
     dirfd
     dirname
     div
+    dladdr			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     dlclose
     dlerror
     dlopen
     dlsym
+    dngettext			(available in external gettext "libintl" library)
     dprintf
     drand48
     dup
     dup2
+    dup3
     duplocale
     encrypt			(available in external "crypt" library)
     endgrent
@@ -210,11 +264,11 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     environ
     erand48
     erf
+    erff
+    erfl
     erfc
     erfcf
     erfcl
-    erff
-    erfl
     errno
     execl
     execle
@@ -224,11 +278,11 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     execvp
     exit
     exp
+    expf
+    expl
     exp2
     exp2f
     exp2l
-    expf
-    expl
     expm1
     expm1f
     expm1l
@@ -265,6 +319,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     fexecve
     fflush
     ffs
+    ffsl
+    ffsll
     fgetc
     fgetpos
     fgets
@@ -319,7 +375,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     ftok
     ftruncate
     ftrylockfile
-    ftw
     funlockfile
     futimens
     fwide
@@ -334,8 +389,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     getchar_unlocked
     getcwd
     getdelim
-    getdomainname
     getegid
+    getentropy			(din)
     getenv
     geteuid
     getgid
@@ -347,8 +402,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     getgroups
     gethostid
     gethostname
-    getitimer			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     getline
+    getlocalename_l		(din)
     getlogin
     getlogin_r
     getnameinfo
@@ -369,7 +424,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     getpwuid_r
     getrlimit			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     getrusage
-    gets
     getservbyname
     getservbyport
     getservent
@@ -377,7 +431,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     getsockname
     getsockopt
     getsubopt
-    gettimeofday
+    gettext			(available in external gettext "libintl" library)
     getuid
     getutxent
     getutxid
@@ -392,6 +446,12 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     hcreate
     hdestroy
     hsearch
+    htobe16			(available in "endian.h" header)
+    htobe32			(available in "endian.h" header)
+    htobe64			(available in "endian.h" header)
+    htole16			(available in "endian.h" header)
+    htole32			(available in "endian.h" header)
+    htole64			(available in "endian.h" header)
     htonl
     htons
     hypot
@@ -409,18 +469,18 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     ilogbl
     imaxabs
     imaxdiv
+    in6addr_any			(din)
+    in6addr_loopback		(din)
     inet_addr
     inet_ntoa
     inet_ntop
     inet_pton
     initstate
     insque
-    ioctl
     isalnum
     isalnum_l
     isalpha
     isalpha_l
-    isascii
     isatty
     isblank
     isblank_l
@@ -492,6 +552,9 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     ldexpf
     ldexpl
     ldiv
+    le16toh			(available in "endian.h" header)
+    le32toh			(available in "endian.h" header)
+    le64toh			(available in "endian.h" header)
     lfind
     lgamma
     lgammaf
@@ -513,6 +576,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     localtime_r
     lockf			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     log
+    logf
+    logl
     log10
     log10f
     log10l
@@ -525,8 +590,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     logb
     logbf
     logbl
-    logf
-    logl
     longjmp
     lrand48
     lrint
@@ -541,6 +604,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     malloc
     mblen
     mbrlen
+    mbrtoc16			(ISO C23 - available in "uchar.h" header)
+    mbrtoc32			(ISO C23 - available in "uchar.h" header)
     mbrtowc
     mbsinit
     mbsnrtowcs
@@ -551,6 +616,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     memchr
     memcmp
     memcpy
+    memmem
     memmove
     memset
     mkdir
@@ -560,6 +626,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     mkfifoat
     mknod
     mknodat
+    mkostemp
     mkstemp
     mktime
     mlock
@@ -584,6 +651,12 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     msgrcv			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     msgsnd			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     msync
+    mtx_destroy			(ISO C11)
+    mtx_init			(ISO C11)
+    mtx_lock			(ISO C11)
+    mtx_timedlock		(ISO C11)
+    mtx_trylock			(ISO C11)
+    mtx_unlock			(ISO C11)
     munlock
     munmap
     nan
@@ -601,6 +674,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     nexttowardf
     nexttowardl
     nftw
+    ngettext			(available in external gettext "libintl" library)
     nice			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     nl_langinfo
     nl_langinfo_l
@@ -622,16 +696,20 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     pclose
     perror
     pipe
+    pipe2
     poll
     popen
     posix_fadvise
     posix_fallocate
+    posix_getdents		(din)
     posix_madvise
     posix_memalign
     posix_openpt
     posix_spawn
+    posix_spawn_file_actions_addchdir	(available as posix_spawn_file_actions_addchdir_np)
     posix_spawn_file_actions_addclose
     posix_spawn_file_actions_adddup2
+    posix_spawn_file_actions_addfchdir	(available as posix_spawn_file_actions_addfchdir_np)
     posix_spawn_file_actions_addopen
     posix_spawn_file_actions_destroy
     posix_spawn_file_actions_init
@@ -653,6 +731,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     pow
     powf
     powl
+    ppoll
     pread
     printf
     pselect
@@ -685,7 +764,10 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     pthread_barrierattr_init
     pthread_barrierattr_setpshared
     pthread_cancel
+    pthread_cleanup_pop		(available in "pthread.h" header)
+    pthread_cleanup_push	(available in "pthread.h" header)
     pthread_cond_broadcast
+    pthread_cond_clockwait
     pthread_cond_destroy
     pthread_cond_init
     pthread_cond_signal
@@ -701,7 +783,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     pthread_detach
     pthread_equal
     pthread_exit
-    pthread_getconcurrency
     pthread_getcpuclockid
     pthread_getschedparam
     pthread_getspecific
@@ -709,6 +790,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     pthread_key_create
     pthread_key_delete
     pthread_kill
+    pthread_mutex_clocklock
     pthread_mutex_destroy
     pthread_mutex_getprioceiling
     pthread_mutex_init
@@ -728,6 +810,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     pthread_mutexattr_setpshared
     pthread_mutexattr_settype
     pthread_once
+    pthread_rwlock_clockrdlock
+    pthread_rwlock_clockwrlock
     pthread_rwlock_destroy
     pthread_rwlock_init
     pthread_rwlock_rdlock
@@ -744,7 +828,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     pthread_self
     pthread_setcancelstate
     pthread_setcanceltype
-    pthread_setconcurrency
     pthread_setschedparam
     pthread_setschedprio
     pthread_setspecific
@@ -756,6 +839,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     pthread_spin_unlock
     pthread_testcancel
     ptsname
+    ptsname_r
     putc
     putc_unlocked
     putchar
@@ -767,9 +851,10 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     putwchar
     pwrite
     qsort
+    qsort_r			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
+    quick_exit			(ISO C11)
     raise
     rand
-    rand_r
     random
     read
     readdir
@@ -778,6 +863,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     readlinkat
     readv
     realloc
+    reallocarray
     realpath
     recv
     recvfrom
@@ -788,7 +874,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     regfree
     remainder
     remainderf
-    reminderl
+    remainderl			(ISO C99 - available in "math.h" header)
     remove
     remque
     remquo
@@ -821,9 +907,11 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     sched_setparam		(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     sched_setscheduler		(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     sched_yield
+    secure_getenv
     seed48
     seekdir
     select
+    sem_clockwait
     sem_close
     sem_destroy
     sem_getvalue
@@ -847,13 +935,11 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     setgid
     setgrent
     sethostent
-    setitimer			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     setjmp
     setkey			(available in external "crypt" library)
     setlocale
     setlogmask
     setpgid
-    setpgrp
     setpriority			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     setprotoent
     setpwent
@@ -874,26 +960,21 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     shmdt			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     shmget			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     shutdown
+    sig2str
     sigaction
     sigaddset
     sigaltstack
     sigdelset
     sigemptyset
     sigfillset
-    sighold
-    sigignore
-    siginterrupt
     sigismember
     siglongjmp
     signal
     signbit			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     signgam
-    sigpause			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     sigpending
     sigprocmask
     sigqueue
-    sigrelse
-    sigset
     sigsetjmp
     sigsuspend
     sigtimedwait
@@ -901,10 +982,10 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     sigwaitinfo
     sin
     sinf
+    sinl
     sinh
     sinhf
     sinhl
-    sinl
     sleep
     snprintf
     sockatmark
@@ -925,6 +1006,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     stdout
     stpcpy
     stpncpy
+    str2sig
     strcasecmp
     strcasecmp_l
     strcat
@@ -942,6 +1024,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     strfmon_l
     strftime
     strftime_l
+    strlcat
+    strlcpy
     strlen
     strncasecmp
     strncasecmp_l
@@ -980,10 +1064,10 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     system
     tan
     tanf
+    tanl
     tanh
     tanhf
     tanhl
-    tanl
     tcdrain
     tcflow
     tcflush
@@ -995,11 +1079,19 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     tcsetpgrp
     tdelete
     telldir
-    tempnam
+    textdomain			(available in external gettext "libintl" library)
     tfind
     tgamma
     tgammaf
     tgammal
+    thrd_create			(ISO C11)
+    thrd_current		(ISO C11)
+    thrd_detach			(ISO C11)
+    thrd_equal			(ISO C11)
+    thrd_exit			(ISO C11)
+    thrd_join			(ISO C11)
+    thrd_sleep			(ISO C11)
+    thrd_yield			(ISO C11)
     time
     timer_create		(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     timer_delete
@@ -1007,6 +1099,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     timer_gettime
     timer_settime
     times
+    timespec_get		(din)
     timezone
     tmpfile
     tmpnam
@@ -1021,10 +1114,14 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     towupper
     towupper_l
     trunc
-    truncate
     truncf
     truncl
+    truncate
     tsearch
+    tss_create			(ISO C11)
+    tss_delete			(ISO C11)
+    tss_get			(ISO C11)
+    tss_set			(ISO C11)
     ttyname
     ttyname_r
     twalk
@@ -1039,13 +1136,13 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     unlockpt
     unsetenv
     uselocale
-    utime
     utimensat
     utimes
     va_arg
     va_copy
     va_end
     va_start
+    vasprintf
     vdprintf
     vfprintf
     vfscanf
@@ -1076,6 +1173,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     wcscspn
     wcsdup
     wcsftime
+    wcslcat
+    wcslcpy
     wcslen
     wcsncasecmp
     wcsncasecmp_l
@@ -1213,10 +1312,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     madvise
     mkstemps
     openpty
-    qsort_r			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     rcmd
     rcmd_af
-    reallocarray
     reallocf
     res_close
     res_init
@@ -1249,8 +1346,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     setusershell
     statfs
     strcasestr
-    strlcat
-    strlcpy
     strsep
     timingsafe_bcmp
     timingsafe_memcmp
@@ -1266,8 +1361,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     wait4
     warn
     warnx
-    wcslcat
-    wcslcpy
 </screen>
 
 </sect1>
@@ -1276,7 +1369,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
 
 <screen>
     __mempcpy
-    accept4
     argz_add
     argz_add_sep
     argz_append
@@ -1290,7 +1382,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     argz_replace
     argz_stringify
     asnprintf
-    asprintf
     asprintf_r
     basename			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     canonicalize_file_name
@@ -1300,9 +1391,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     clog10l
     close_range			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     crypt_r			(available in external "crypt" library)
-    dladdr			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     dremf
-    dup3
     envz_add
     envz_entry
     envz_get
@@ -1322,8 +1411,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     fedisableexcept
     feenableexcept
     fegetexcept
-    ffsl
-    ffsll
     fgets_unlocked
     fgetwc_unlocked
     fgetws_unlocked
@@ -1352,35 +1439,23 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     llistxattr
     lremovexattr
     lsetxattr
-    memmem
     mempcpy
     memrchr
-    mkostemp
     mkostemps
-    pipe2
-    posix_spawn_file_actions_addchdir_np
-    posix_spawn_file_actions_addfchdir_np
     pow10
     pow10f
     pow10l
-    ppoll
-    pthread_cond_clockwait
     pthread_getaffinity_np
     pthread_getattr_np
     pthread_getname_np
-    pthread_mutex_clocklock
-    pthread_rwlock_clockrdlock
-    pthread_rwlock_clockwrlock
     pthread_setaffinity_np
     pthread_setname_np
     pthread_sigqueue
     pthread_timedjoin_np
     pthread_tryjoin_np
-    ptsname_r
     putwc_unlocked
     putwchar_unlocked
     renameat2			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
-    qsort_r			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     quotactl
     rawmemchr
     removexattr
@@ -1388,8 +1463,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     sched_getaffinity
     sched_getcpu
     sched_setaffinity
-    secure_getenv
-    sem_clockwait
     setxattr
     signalfd
     sincos
@@ -1416,7 +1489,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     updwtmpx
     utmpxname
     vasnprintf
-    vasprintf
     vasprintf_r
     versionsort
     wcsftime_l
@@ -1458,11 +1530,10 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     fegetprec
     fesetprec
     futimesat
+    getdomainname		(NIS)
     getmntent
     memalign
     setmntent
-    sig2str
-    str2sig
     xdr_array			(available in external "libtirpc" library)
     xdr_bool			(available in external "libtirpc" library)
     xdr_bytes			(available in external "libtirpc" library)
@@ -1514,68 +1585,45 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     xdrstdio_create		(available in external "libtirpc" library)
 </screen>
 
+</sect1>
+
 <sect1 id="std-iso"><title>System interfaces not in POSIX but compatible with ISO C requirements:</title>
 
 <screen>
-    aligned_alloc		(ISO C11)
-    at_quick_exit		(ISO C11)
-    c16rtomb			(ISO C11)
-    c32rtomb			(ISO C11)
     c8rtomb			(ISO C23)
-    call_once			(ISO C11)
-    cnd_broadcast		(ISO C11)
-    cnd_destroy			(ISO C11)
-    cnd_init			(ISO C11)
-    cnd_signal			(ISO C11)
-    cnd_timedwait		(ISO C11)
-    cnd_wait			(ISO C11)
-    mbrtoc16			(ISO C11)
-    mbrtoc32			(ISO C11)
     mbrtoc8			(ISO C23)
-    mtx_destroy			(ISO C11)
-    mtx_init			(ISO C11)
-    mtx_lock			(ISO C11)
-    mtx_timedlock		(ISO C11)
-    mtx_trylock			(ISO C11)
-    mtx_unlock			(ISO C11)
-    quick_exit			(ISO C11)
-    thrd_create			(ISO C11)
-    thrd_current		(ISO C11)
-    thrd_detach			(ISO C11)
-    thrd_equal			(ISO C11)
-    thrd_exit			(ISO C11)
-    thrd_join			(ISO C11)
-    thrd_sleep			(ISO C11)
-    thrd_yield			(ISO C11)
-    tss_create			(ISO C11)
-    tss_delete			(ISO C11)
-    tss_get			(ISO C11)
-    tss_set			(ISO C11)
 </screen>
 
 </sect1>
 
-</sect1>
-
-<sect1 id="std-deprec"><title>Other UNIX system interfaces, not in POSIX.1-2008 or deprecated:</title>
+<sect1 id="std-deprec"><title>Other UNIX® system interfaces, not in POSIX.1-2024, or deprecated:</title>
 
 <screen>
+    _longjmp			(SUSv4)
+    _setjmp			(SUSv4)
+    _tolower			(SUSv4)
+    _toupper			(SUSv4)
+    atoff			(AIX)
     bcmp			(POSIX.1-2001, SUSv3)
     bcopy			(SUSv3)
     bzero			(SUSv3)
-    chroot			(SUSv2)		(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
-    clock_setres		(QNX, VxWorks)	(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
+    chroot			(SUSv2 - see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
+    clock_setres		(QNX, VxWorks - see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     cuserid			(POSIX.1-1988, SUSv2)
     ecvt			(SUSv3)
     endutent			(XPG2)
     fcvt			(SUSv3)
     ftime			(SUSv3)
+    ftw				(SUSv4)
     gcvt			(SUSv3)
     getcontext			(SUSv3)
     gethostbyaddr		(SUSv3)
     gethostbyname		(SUSv3)
     gethostbyname2		(first defined in BIND 4.9.4)
+    getitimer			(SUSv4 - see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     getpass			(SUSv2)
+    gets			(SUSv4)
+    gettimeofday		(SUSv4)
     getutent			(XPG2)
     getutid			(XPG2)
     getutline			(XPG2)
@@ -1583,6 +1631,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     getwd			(SUSv3)
     h_errno			(SUSv3)
     index			(SUSv3)
+    ioctl			(SUSv4)
+    isascii			(SUSv4)
     makecontext			(SUSv3)
     mallinfo			(SVID)
     mallopt			(SVID)
@@ -1591,56 +1641,82 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     pthread_attr_getstackaddr	(SUSv3)
     pthread_attr_setstackaddr	(SUSv3)
     pthread_continue		(XPG2)
+    pthread_getconcurrency	(SUSv4)
     pthread_getsequence_np	(Tru64)
+    pthread_setconcurrency	(SUSv4)
     pthread_suspend		(XPG2)
     pthread_yield		(POSIX.1c drafts)
     pututline			(XPG2)
     putw			(SVID)
+    rand_r			(SUSv4)
     rindex			(SUSv3)
     scalb			(SUSv3)
     setcontext			(SUSv3)
+    setitimer			(SUSv4 - see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
+    setpgrp			(SUSv4)
     setutent			(XPG2)
+    sighold			(SUSv4)
+    sigignore			(SUSv4)
+    siginterrupt		(SUSv4)
+    sigpause			(SUSv4 - see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
+    sigrelse			(SUSv4)
+    sigset			(SUSv4)
     stime			(SVID)
     swapcontext			(SUSv3)
     sys_errlist			(BSD)
     sys_nerr			(BSD)
     sys_siglist			(BSD)
-    toascii			(SUSv3)
+    tempnam			(SUSv4)
+    toascii			(SUSv4)
     ttyslot			(SUSv2)
     ualarm			(SUSv3)
     usleep			(SUSv3)
+    utime			(SUSv4)
     utmpname			(XPG2)
-    vfork			(SUSv3)		(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
+    vfork			(SUSv3 - see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
 </screen>
 
 </sect1>
 
-<sect1 id="std-notimpl"><title>NOT implemented system interfaces from the Single Unix Specification, Volume 7:</title>
+<sect1 id="std-notimpl"><title>NOT implemented system interfaces from the Single UNIX® Specification Version 5:</title>
 
 <screen>
+    CMPLX			(not available in "complex.h" header)
+    CMPLXF			(not available in "complex.h" header)
+    CMPLXL			(not available in "complex.h" header)
+    _Fork			(not available in "(sys/)unistd.h" header)
+    dcgettext_l			(not available in external gettext "libintl" library)
+    dcngettext_l		(not available in external gettext "libintl" library)
+    dgettext_l			(not available in external gettext "libintl" library)
+    dngettext_l			(not available in external gettext "libintl" library)
     endnetent
-    fattach
     fmtmsg
     getdate
     getdate_err
     gethostent
-    getmsg
     getnetbyaddr
     getnetbyname
     getnetent
-    getpmsg
-    isastream
+    getresgid			(not available in "(sys/)unistd.h" header)
+    getresuid			(not available in "(sys/)unistd.h" header)
+    gettext_l			(not available in external gettext "libintl" library)
+    kill_dependency		(not available in "stdatomic.h" header)
     mlockall
     munlockall
+    ngettext_l			(not available in external gettext "libintl" library)
+    posix_close			(not available in "(sys/)unistd.h" header)
+    posix_devctl		(prototyped in cygwin-devel "devctl.h" header)
     posix_mem_offset
-    posix_trace[...]
-    posix_typed_[...]
+    posix_typed_mem_get_info	(not available in "(sys/)mman.h" header)
+    posix_typed_mem_open	(not available in "(sys/)mman.h" header)
     pthread_mutexattr_getrobust
     pthread_mutexattr_setrobust
     pthread_mutex_consistent
-    putmsg
     setnetent
-    ulimit
+    setresgid			(not available in "(sys/)unistd.h" header)
+    setresuid			(not available in "(sys/)unistd.h" header)
+    tcgetwinsize		(not available in "(sys/)termios.h" header)
+    tcsetwinsize		(not available in "(sys/)termios.h" header)
     waitid
 </screen>
 
-- 
2.45.1

