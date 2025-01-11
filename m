Return-Path: <SRS0=8byy=UD=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	by sourceware.org (Postfix) with ESMTPS id 496853857810
	for <cygwin-patches@cygwin.com>; Sat, 11 Jan 2025 00:03:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 496853857810
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 496853857810
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.10
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736553823; cv=none;
	b=MFJFvcyYvOw2mxYRpDU6fuZCHSo92ZmMIh4YuEslCWQn0eCZQYbw5leCAB/2i21ORo2nXDOgQqnH5LenpOag3n68WYGgbJTbUAgFLd27vAzzhYUKE8/gsPKiJvWYJ+EoIviWZDC74udT0B6wXjVMWKQW1SbXAz5O1R+iut3DRyk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736553823; c=relaxed/simple;
	bh=uTLlXYK3IYGTgh8/dAdpHbGXNYDLBMxj3+ecVeNowJo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=d/lAVNmtEpRM31Ld/JrNzdPUidsHoGdyGeOxRun/4BPXcgSh7WG+fRto974KaDqwklmMtHm0qHXjFH8OKv9Atb/BSD2OEtWSkRTtUpXt7f6rE1M/TdNT+famtD11wa9TMh47BDaG4eyn0008+Rtuc/ZyMdaF4sr9w3PGCbMWTrc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 496853857810
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=i42/5aCQ
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 272AD1C7F81;
	Sat, 11 Jan 2025 00:03:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf09.hostedemail.com (Postfix) with ESMTPA id ADD302003B;
	Sat, 11 Jan 2025 00:03:21 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH v5 7/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 merge function variants on one line
Date: Fri, 10 Jan 2025 17:01:08 -0700
Message-ID: <39517f2a7fdd36a043c2029e0a24e16e8e7f3bee.1736552566.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Organization: Systematic Software
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Stat-Signature: z9dmt93ae8pqpz61g5wso8bt4c943697
X-Rspamd-Server: rspamout04
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: ADD302003B
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1+g8HAY52X8GsBDsVfYKTTDEttZ7ThQlmU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=he; bh=Rhn1hrADY2tXao34wMLZAIkRTU+WQ1KgwqCKNNT/5KA=; b=i42/5aCQkJaedRjPL2vo5YHdir3wDpbus/t1T/KUolgEXX+nS2+NEB7eGiiTv1Sr4wmtowQ8IY/0DftBjypQnXWFWmKPJw/cKqKZM7onaoIHpuQ+mxD3tbDShgkV+1mdwj5PMdzRUrL+xV5lOCVFx1zZ4ilXLcVVn/QVcgdrVeiUSh5x5O7w3fc7JOsEqLQ+QDGufRCxzprS0JodbI2WjDRzy5ZjS31y7lX0gRcy1BOQBHoMzJ6B2qV8y1j4omkk27qSOobi0cVwrKf462Zc5vnMR+/tRaads5HJfDubZqtC5/Fsgf3Ih+QENbnwlekPWm4eTFxOFpj8OZDkymsbCQ==
X-HE-Tag: 1736553801-979366
X-HE-Meta: U2FsdGVkX19CJF64vjWVBaSyF5JlsMdzQ4WUi+ZgBH3Qs/doT04hXTAIvT/5K9Rl5cVHxx6dG9ZzPxcFX7CnYStb6cVMjg75CD9F6X9rS6TJrcFZJ4akrE9BYCwwyJPUEJ63pdK3pc253DE4rO0kmCDs9kMt9p43pq7sOnnbvPZGggQOmApUaWw/7sRPRQTEl23amk3TtiNhowKSabmSQtNCDzUfCwA4RPEhPG1nwmmC+n4hJmC4pe91yQztMHJqhEx8ZBu5AmiXO0nZ+ix+9uCChvNVEDNEYAr2gYv6TwUO5SVblQswkET9JUOlUEOKd+UlCjDa4URyJa5fGM10pYbOxka4M0ViO1V+6XKFoHt/XcO7DeeFgUZ85s/ScMKVqrCpQN8CiheYSmM1nFgoXQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Move circular F/Ff/Fl and similar functions to put
base entries and -f -l variants on the same line.

Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 winsup/doc/posix.xml | 336 +++++++++++--------------------------------
 1 file changed, 84 insertions(+), 252 deletions(-)

diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 2ec7016e4308..64b25e7babb1 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -29,12 +29,8 @@ ISO/IEC DIS 9945 Information technology
     accept
     accept4
     access
-    acos
-    acosf
-    acosl
-    acosh
-    acoshf
-    acoshl
+    acos/acosf/acosl
+    acosh/acoshf/acoshl
     aio_cancel
     aio_error
     aio_fsync
@@ -47,24 +43,14 @@ ISO/IEC DIS 9945 Information technology
     alphasort
     asctime
     asctime_r
-    asin
-    asinf
-    asinl
-    asinh
-    asinhf
-    asinhl
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
@@ -109,50 +95,24 @@ ISO/IEC DIS 9945 Information technology
     btowc
     c16rtomb			(ISO C11)
     c32rtomb			(ISO C11)
-    cabs
-    cabsf
-    cabsl
-    cacos
-    cacosf
-    cacosl
-    cacosh
-    cacoshf
-    cacoshl
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
+    cbrt/cbrtf/cbrtl
+    ccos/ccosf/ccosl
+    ccosh/ccoshf/ccoshl
+    ceil/ceilf/ceill
+    cexp/cexpf/cexpl
     cfgetispeed
     cfgetospeed
     cfsetispeed
@@ -160,9 +120,7 @@ ISO/IEC DIS 9945 Information technology
     chdir
     chmod
     chown
-    cimag
-    cimagf
-    cimagl
+    cimag/cimagf/cimagl
     clearerr
     clock
     clock_getcpuclockid
@@ -170,9 +128,7 @@ ISO/IEC DIS 9945 Information technology
     clock_gettime
     clock_nanosleep		(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     clock_settime		(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
-    clog
-    clogf
-    clogl
+    clog/clogf/clogl
     close
     closedir
     closelog
@@ -183,45 +139,21 @@ ISO/IEC DIS 9945 Information technology
     cnd_timedwait		(ISO C11)
     cnd_wait			(ISO C11)
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
     ctime
     ctime_r
@@ -263,12 +195,8 @@ ISO/IEC DIS 9945 Information technology
     endutxent
     environ
     erand48
-    erf
-    erff
-    erfl
-    erfc
-    erfcf
-    erfcl
+    erf/erff/erfl
+    erfc/erfcf/erfcl
     errno
     execl
     execle
@@ -277,18 +205,10 @@ ISO/IEC DIS 9945 Information technology
     execve
     execvp
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
+    exp/expf/expl
+    exp2/exp2f/exp2l
+    expm1/expm1f/expm1l
+    fabs/fabsf/fabsl
     faccessat
     fchdir
     fchmod
@@ -298,9 +218,7 @@ ISO/IEC DIS 9945 Information technology
     fclose
     fcntl			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     fdatasync
-    fdim
-    fdimf
-    fdiml
+    fdim/fdimf/fdiml
     fdopen
     fdopendir
     feclearexcept
@@ -328,22 +246,12 @@ ISO/IEC DIS 9945 Information technology
     fgetws
     fileno
     flockfile
-    floor
-    floorf
-    floorl
-    fma
-    fmaf
-    fmal
-    fmax
-    fmaxf
-    fmaxl
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
@@ -359,9 +267,7 @@ ISO/IEC DIS 9945 Information technology
     freeaddrinfo
     freelocale
     freopen
-    frexp
-    frexpf
-    frexpl
+    frexp/frexpf/frexpl
     fscanf
     fseek
     fseeko
@@ -454,9 +360,7 @@ ISO/IEC DIS 9945 Information technology
     htole64			(available in "endian.h" header)
     htonl
     htons
-    hypot
-    hypotf
-    hypotl
+    hypot/hypotf/hypotl
     iconv			(available in external "libiconv" library)
     iconv_close			(available in external "libiconv" library)
     iconv_open			(available in external "libiconv" library)
@@ -464,9 +368,7 @@ ISO/IEC DIS 9945 Information technology
     if_indextoname
     if_nameindex
     if_nametoindex
-    ilogb
-    ilogbf
-    ilogbl
+    ilogb/ilogbf/ilogbl
     imaxabs
     imaxdiv
     in6addr_any			(din)
@@ -548,56 +450,34 @@ ISO/IEC DIS 9945 Information technology
     labs
     lchown
     lcong48
-    ldexp
-    ldexpf
-    ldexpl
+    ldexp/ldexpf/ldexpl
     ldiv
     le16toh			(available in "endian.h" header)
     le32toh			(available in "endian.h" header)
     le64toh			(available in "endian.h" header)
     lfind
-    lgamma
-    lgammaf
-    lgammal
+    lgamma/lgammaf/lgammal
     link
     linkat
     lio_listio
     listen
     llabs
     lldiv
-    llrint
-    llrintf
-    llrintl
-    llround
-    llroundf
-    llroundl
+    llrint/llrintf/llrintl
+    llround/llroundf/llroundl
     localeconv
     localtime
     localtime_r
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
     lrand48
-    lrint
-    lrintf
-    lrintl
-    lround
-    lroundf
-    lroundl
+    lrint/lrintf/lrintl
+    lround/lroundf/lroundl
     lsearch
     lseek
     lstat
@@ -631,9 +511,7 @@ ISO/IEC DIS 9945 Information technology
     mktime
     mlock
     mmap
-    modf
-    modff
-    modfl
+    modf/modff/modfl
     mprotect
     mq_close
     mq_getattr
@@ -659,20 +537,12 @@ ISO/IEC DIS 9945 Information technology
     mtx_unlock			(ISO C11)
     munlock
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
     ngettext			(available in external gettext "libintl" library)
     nice			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
@@ -728,9 +598,7 @@ ISO/IEC DIS 9945 Information technology
     posix_spawnattr_setsigdefault
     posix_spawnattr_setsigmask
     posix_spawnp
-    pow
-    powf
-    powl
+    pow/powf/powl
     ppoll
     pread
     printf
@@ -877,26 +745,16 @@ ISO/IEC DIS 9945 Information technology
     remainderl			(ISO C99 - available in "math.h" header)
     remove
     remque
-    remquo
-    remquof
-    remquol
+    remquo/remquof/remquol
     rename
     renameat
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
+    round/roundf/roundl
+    scalbln/scalblnf/scalblnl
+    scalbn/scalbnf/scalbnl
     scandir
     scanf
     sched_get_priority_max
@@ -980,21 +838,15 @@ ISO/IEC DIS 9945 Information technology
     sigtimedwait
     sigwait
     sigwaitinfo
-    sin
-    sinf
-    sinl
-    sinh
-    sinhf
-    sinhl
+    sin/sinf/sinl
+    sinh/sinhf/sinhl
     sleep
     snprintf
     sockatmark
     socket
     socketpair
     sprintf
-    sqrt
-    sqrtf
-    sqrtl
+    sqrt/sqrtf/sqrtl
     srand
     srand48
     srandom
@@ -1062,12 +914,8 @@ ISO/IEC DIS 9945 Information technology
     sysconf
     syslog
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
@@ -1081,9 +929,7 @@ ISO/IEC DIS 9945 Information technology
     telldir
     textdomain			(available in external gettext "libintl" library)
     tfind
-    tgamma
-    tgammaf
-    tgammal
+    tgamma/tgammaf/tgammal
     thrd_create			(ISO C11)
     thrd_current		(ISO C11)
     thrd_detach			(ISO C11)
@@ -1113,9 +959,7 @@ ISO/IEC DIS 9945 Information technology
     towlower_l
     towupper
     towupper_l
-    trunc
-    truncf
-    truncl
+    trunc/truncf/truncl
     truncate
     tsearch
     tss_create			(ISO C11)
@@ -1258,9 +1102,7 @@ ISO/IEC DIS 9945 Information technology
     fflush_unlocked
     fileno_unlocked
     fgetc_unlocked
-    finite
-    finitef
-    finitel
+    finite/finitef/finitel
     fiprintf
     flock			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     fls
@@ -1386,9 +1228,7 @@ ISO/IEC DIS 9945 Information technology
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
@@ -1402,9 +1242,7 @@ ISO/IEC DIS 9945 Information technology
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
@@ -1442,9 +1280,7 @@ ISO/IEC DIS 9945 Information technology
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
@@ -1465,9 +1301,7 @@ ISO/IEC DIS 9945 Information technology
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
@@ -1681,9 +1515,7 @@ ISO/IEC DIS 9945 Information technology
 <sect1 id="std-notimpl"><title>NOT implemented system interfaces from the Single UNIX® Specification Version 5:</title>
 
 <screen>
-    CMPLX			(not available in "complex.h" header)
-    CMPLXF			(not available in "complex.h" header)
-    CMPLXL			(not available in "complex.h" header)
+    CMPLX/CMPLXF/CMPLXL		(not available in "complex.h" header)
     _Fork			(not available in "(sys/)unistd.h" header)
     dcgettext_l			(not available in external gettext "libintl" library)
     dcngettext_l		(not available in external gettext "libintl" library)
-- 
2.45.1

