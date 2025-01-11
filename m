Return-Path: <SRS0=8byy=UD=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	by sourceware.org (Postfix) with ESMTPS id 1A4C53857BB3
	for <cygwin-patches@cygwin.com>; Sat, 11 Jan 2025 00:03:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1A4C53857BB3
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1A4C53857BB3
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736553805; cv=none;
	b=wcxDBJtHxW9ckMRQ6holSDgZrBvg3a1dWfoNCTFpL/yKoobiRsOB7t51IukuXuJhwFUfYuQ6sKSsOZaUqCHwGXS6Zh+DDJG9+CfdPkdxXnlp0HpbcT/W6DaY9/UFXLN/qsiSTus4BICqbPiBRooBK39EIoHU5fnXdEKHCJy6sG0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736553805; c=relaxed/simple;
	bh=QoX9PBRpIVsBLZH09XEDAN+kvLqkoTAeqb+WJTmMZcY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=ptA0ltfyRyKaTvAaS10uY069mY7uNrkh1iP4kl2Jnz+pJL8P9O45k75c9CLSuLJlRkR3rOAjY9RpvY68ws+PrUmMucWXrzok3VDIIjHIOsbd4c373P4NYacGWqMWrTiC4vKbIRp44hu4Gapf9je7QiAWQQNeytRury9MQaWSi3E=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1A4C53857BB3
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=kiN1AEoI
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id A9A2A1A0F6D;
	Sat, 11 Jan 2025 00:03:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf09.hostedemail.com (Postfix) with ESMTPA id 48EC720028;
	Sat, 11 Jan 2025 00:03:23 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH v5 8/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 abbrev variants of base function
Date: Fri, 10 Jan 2025 17:01:09 -0700
Message-ID: <6f43c54d894bc7b6e2a75596cf07d47ffb881d51.1736552566.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Organization: Systematic Software
Content-Transfer-Encoding: 8bit
X-Stat-Signature: ecogjrgn71gctiezmwqjjggfsbbsc7pq
X-Rspamd-Server: rspamout04
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: 48EC720028
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX18j54jthr5pA4iXa1nBeFLbxoiLSyfi+Ys=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=he; bh=xJuj7cAeXDMkrQcdvzM0VpDCvrzVMI+CiJL4Su2E7vo=; b=kiN1AEoIGWsG40ywSYg50520zzhgpmyPg9zHEHJ0uVmJJrXZ0EcWwJVe3nBgJQNKqhmSbSPWgW9v1f5SsVWL5cciJTHDMH+qwwlHiFCjxdQmO/AZvfYbXjGvEdlZYVf0rNa+aYRkpzey58VgoCVDsdJzNUZ5MRo7I1YtGq7Yl1PiPwwggav5elFi0gbargikBeYrkO/nak3iXY11qx2cxYzzj5mGq1rfBVBy7KBmXvhSPnLj00S1tVzvoHs0vVJvPcFp3ddfZ9WZQgiCQhD8zNr9A8SuufgCLIK7NgjZtgMhfZN3DuT77maRK1MLhl67nq8wjLlacJFjVYWaPumM2Q==
X-HE-Tag: 1736553803-177667
X-HE-Meta: U2FsdGVkX18jzhttkUmGGz8MaJXMhtO56SBtaKDFm+PM0imK7g2xPVD1sMKQUaGpjgaYKYQPqNel2ey/rNsdGMCcyCR8kk1tYIXVLTNCjTHbMnaV4QNjj0bchqMtkf7WeI8cvEksadA6c4rVQ2XD7itXYoK+Bm+Vf4KRraWOBhp1HPMIu0HXW5G/IrHljEGZynzutIIvi6WRtQEaBDwiU/XdICZS7AqRZgqkhKifQ4VD8TjSLwUyRZrD3hI1pVf3mqXzb+GxXEvXt0fOng9pOVuA+yPT4Bxby53EhT7+6Q/wswDW9SmqhODJ3thrcjsVjtj4JZ7QijY=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Abbreviate circular F/Ff/Fl and similar function variants to /f/l dropping base name.

Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 winsup/doc/posix.xml | 166 +++++++++++++++++++++----------------------
 1 file changed, 83 insertions(+), 83 deletions(-)

diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 64b25e7babb1..bbe7189cc5de 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -29,8 +29,8 @@ ISO/IEC DIS 9945 Information technology
     accept
     accept4
     access
-    acos/acosf/acosl
-    acosh/acoshf/acoshl
+    acos/f/l
+    acosh/f/l
     aio_cancel
     aio_error
     aio_fsync
@@ -43,14 +43,14 @@ ISO/IEC DIS 9945 Information technology
     alphasort
     asctime
     asctime_r
-    asin/asinf/asinl
-    asinh/asinhf/asinhl
+    asin/f/l
+    asinh/f/l
     asprintf
     assert			(SVID - available in "assert.h" header)
     at_quick_exit		(ISO C11)
-    atan/atanf/atanl
-    atan2/atan2f/atan2l
-    atanh/atanhf/atanhl
+    atan/f/l
+    atan2/f/l
+    atanh/f/l
     atexit
     atof
     atoi
@@ -95,24 +95,24 @@ ISO/IEC DIS 9945 Information technology
     btowc
     c16rtomb			(ISO C11)
     c32rtomb			(ISO C11)
-    cabs/cabsf/cabsl
-    cacos/cacosf/cacosl
-    cacosh/cacoshf/cacoshl
+    cabs/f/l
+    cacos/f/l
+    cacosh/f/l
     call_once			(ISO C11)
     calloc
-    carg/cargf/cargl
-    casin/casinf/casinl
-    casinh/casinhf/casinhl
-    catan/catanf/catanl
-    catanh/catanhf/catanhl
+    carg/f/l
+    casin/f/l
+    casinh/f/l
+    catan/f/l
+    catanh/f/l
     catclose
     catgets
     catopen
-    cbrt/cbrtf/cbrtl
-    ccos/ccosf/ccosl
-    ccosh/ccoshf/ccoshl
-    ceil/ceilf/ceill
-    cexp/cexpf/cexpl
+    cbrt/f/l
+    ccos/f/l
+    ccosh/f/l
+    ceil/f/l
+    cexp/f/l
     cfgetispeed
     cfgetospeed
     cfsetispeed
@@ -120,7 +120,7 @@ ISO/IEC DIS 9945 Information technology
     chdir
     chmod
     chown
-    cimag/cimagf/cimagl
+    cimag/f/l
     clearerr
     clock
     clock_getcpuclockid
@@ -128,7 +128,7 @@ ISO/IEC DIS 9945 Information technology
     clock_gettime
     clock_nanosleep		(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     clock_settime		(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
-    clog/clogf/clogl
+    clog/f/l
     close
     closedir
     closelog
@@ -139,21 +139,21 @@ ISO/IEC DIS 9945 Information technology
     cnd_timedwait		(ISO C11)
     cnd_wait			(ISO C11)
     confstr
-    conj/conjf/conjl
+    conj/f/l
     connect
-    copysign/copysignf/copysignl
-    cos/cosf/cosl
-    cosh/coshf/coshl
-    cpow/cpowf/cpowl
-    cproj/cprojf/cprojl
-    creal/crealf/creall
+    copysign/f/l
+    cos/f/l
+    cosh/f/l
+    cpow/f/l
+    cproj/f/l
+    creal/f/l
     creat
     crypt			(available in external "crypt" library)
-    csin/csinf/csinl
-    csinh/csinhf/csinhl
-    csqrt/csqrtf/csqrtl
-    ctan/ctanf/ctanl
-    ctanh/ctanhf/ctanhl
+    csin/f/l
+    csinh/f/l
+    csqrt/f/l
+    ctan/f/l
+    ctanh/f/l
     ctermid
     ctime
     ctime_r
@@ -195,8 +195,8 @@ ISO/IEC DIS 9945 Information technology
     endutxent
     environ
     erand48
-    erf/erff/erfl
-    erfc/erfcf/erfcl
+    erf/f/l
+    erfc/f/l
     errno
     execl
     execle
@@ -205,10 +205,10 @@ ISO/IEC DIS 9945 Information technology
     execve
     execvp
     exit
-    exp/expf/expl
-    exp2/exp2f/exp2l
-    expm1/expm1f/expm1l
-    fabs/fabsf/fabsl
+    exp/f/l
+    exp2/f/l
+    expm1/f/l
+    fabs/f/l
     faccessat
     fchdir
     fchmod
@@ -218,7 +218,7 @@ ISO/IEC DIS 9945 Information technology
     fclose
     fcntl			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     fdatasync
-    fdim/fdimf/fdiml
+    fdim/f/l
     fdopen
     fdopendir
     feclearexcept
@@ -246,12 +246,12 @@ ISO/IEC DIS 9945 Information technology
     fgetws
     fileno
     flockfile
-    floor/floorf/floorl
-    fma/fmaf/fmal
-    fmax/fmaxf/fmaxl
+    floor/f/l
+    fma/f/l
+    fmax/f/l
     fmemopen
-    fmin/fminf/fminl
-    fmod/fmodf/fmodl
+    fmin/f/l
+    fmod/f/l
     fnmatch
     fopen
     fork
@@ -267,7 +267,7 @@ ISO/IEC DIS 9945 Information technology
     freeaddrinfo
     freelocale
     freopen
-    frexp/frexpf/frexpl
+    frexp/f/l
     fscanf
     fseek
     fseeko
@@ -360,7 +360,7 @@ ISO/IEC DIS 9945 Information technology
     htole64			(available in "endian.h" header)
     htonl
     htons
-    hypot/hypotf/hypotl
+    hypot/f/l
     iconv			(available in external "libiconv" library)
     iconv_close			(available in external "libiconv" library)
     iconv_open			(available in external "libiconv" library)
@@ -368,7 +368,7 @@ ISO/IEC DIS 9945 Information technology
     if_indextoname
     if_nameindex
     if_nametoindex
-    ilogb/ilogbf/ilogbl
+    ilogb/f/l
     imaxabs
     imaxdiv
     in6addr_any			(din)
@@ -450,34 +450,34 @@ ISO/IEC DIS 9945 Information technology
     labs
     lchown
     lcong48
-    ldexp/ldexpf/ldexpl
+    ldexp/f/l
     ldiv
     le16toh			(available in "endian.h" header)
     le32toh			(available in "endian.h" header)
     le64toh			(available in "endian.h" header)
     lfind
-    lgamma/lgammaf/lgammal
+    lgamma/f/l
     link
     linkat
     lio_listio
     listen
     llabs
     lldiv
-    llrint/llrintf/llrintl
-    llround/llroundf/llroundl
+    llrint/f/l
+    llround/f/l
     localeconv
     localtime
     localtime_r
     lockf			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
-    log/logf/logl
-    log10/log10f/log10l
-    log1p/log1pf/log1pl
-    log2/log2f/log2l
-    logb/logbf/logbl
+    log/f/l
+    log10/f/l
+    log1p/f/l
+    log2/f/l
+    logb/f/l
     longjmp
     lrand48
-    lrint/lrintf/lrintl
-    lround/lroundf/lroundl
+    lrint/f/l
+    lround/f/l
     lsearch
     lseek
     lstat
@@ -511,7 +511,7 @@ ISO/IEC DIS 9945 Information technology
     mktime
     mlock
     mmap
-    modf/modff/modfl
+    modf/f/l
     mprotect
     mq_close
     mq_getattr
@@ -537,12 +537,12 @@ ISO/IEC DIS 9945 Information technology
     mtx_unlock			(ISO C11)
     munlock
     munmap
-    nan/nanf/nanl
+    nan/f/l
     nanosleep
-    nearbyint/nearbyintf/nearbyintl
+    nearbyint/f/l
     newlocale
-    nextafter/nextafterf/nextafterl
-    nexttoward/nexttowardf/nexttowardl
+    nextafter/f/l
+    nexttoward/f/l
     nftw
     ngettext			(available in external gettext "libintl" library)
     nice			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
@@ -598,7 +598,7 @@ ISO/IEC DIS 9945 Information technology
     posix_spawnattr_setsigdefault
     posix_spawnattr_setsigmask
     posix_spawnp
-    pow/powf/powl
+    pow/f/l
     ppoll
     pread
     printf
@@ -745,16 +745,16 @@ ISO/IEC DIS 9945 Information technology
     remainderl			(ISO C99 - available in "math.h" header)
     remove
     remque
-    remquo/remquof/remquol
+    remquo/f/l
     rename
     renameat
     rewind
     rewinddir
-    rint/rintf/rintl
+    rint/f/l
     rmdir
-    round/roundf/roundl
-    scalbln/scalblnf/scalblnl
-    scalbn/scalbnf/scalbnl
+    round/f/l
+    scalbln/f/l
+    scalbn/f/l
     scandir
     scanf
     sched_get_priority_max
@@ -838,15 +838,15 @@ ISO/IEC DIS 9945 Information technology
     sigtimedwait
     sigwait
     sigwaitinfo
-    sin/sinf/sinl
-    sinh/sinhf/sinhl
+    sin/f/l
+    sinh/f/l
     sleep
     snprintf
     sockatmark
     socket
     socketpair
     sprintf
-    sqrt/sqrtf/sqrtl
+    sqrt/f/l
     srand
     srand48
     srandom
@@ -914,8 +914,8 @@ ISO/IEC DIS 9945 Information technology
     sysconf
     syslog
     system
-    tan/tanf/tanl
-    tanh/tanhf/tanhl
+    tan/f/l
+    tanh/f/l
     tcdrain
     tcflow
     tcflush
@@ -929,7 +929,7 @@ ISO/IEC DIS 9945 Information technology
     telldir
     textdomain			(available in external gettext "libintl" library)
     tfind
-    tgamma/tgammaf/tgammal
+    tgamma/f/l
     thrd_create			(ISO C11)
     thrd_current		(ISO C11)
     thrd_detach			(ISO C11)
@@ -959,7 +959,7 @@ ISO/IEC DIS 9945 Information technology
     towlower_l
     towupper
     towupper_l
-    trunc/truncf/truncl
+    trunc/f/l
     truncate
     tsearch
     tss_create			(ISO C11)
@@ -1102,7 +1102,7 @@ ISO/IEC DIS 9945 Information technology
     fflush_unlocked
     fileno_unlocked
     fgetc_unlocked
-    finite/finitef/finitel
+    finite/f/l
     fiprintf
     flock			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     fls
@@ -1228,7 +1228,7 @@ ISO/IEC DIS 9945 Information technology
     basename			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     canonicalize_file_name
     clearenv
-    clog10/clog10f/clog10l
+    clog10/f/l
     close_range			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     crypt_r			(available in external "crypt" library)
     dremf
@@ -1242,7 +1242,7 @@ ISO/IEC DIS 9945 Information technology
     error_at_line
     euidaccess
     execvpe
-    exp10/exp10f/exp10l
+    exp10/f/l
     fallocate			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     fcloseall
     fcloseall_r
@@ -1280,7 +1280,7 @@ ISO/IEC DIS 9945 Information technology
     mempcpy
     memrchr
     mkostemps
-    pow10/pow10f/pow10l
+    pow10/f/l
     pthread_getaffinity_np
     pthread_getattr_np
     pthread_getname_np
@@ -1301,7 +1301,7 @@ ISO/IEC DIS 9945 Information technology
     sched_setaffinity
     setxattr
     signalfd
-    sincos/sincosf/sincosl
+    sincos/f/l
     strchrnul
     strptime_l
     strtod_l
-- 
2.45.1

