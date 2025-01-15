Return-Path: <SRS0=SYvf=UH=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	by sourceware.org (Postfix) with ESMTPS id D9DDE38515F8
	for <cygwin-patches@cygwin.com>; Wed, 15 Jan 2025 19:43:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D9DDE38515F8
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D9DDE38515F8
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.14
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736970224; cv=none;
	b=UtwQ9nV8UdR1G2iBTOjuqjTllmKTAJNj7h4+fcVdADBbY5D2xOw7zJB/034k6l2IWV+Gf8ROQr0VR2DS4YmtEZn0LJrQED5BzO2iwfiYg+aRxC3fW4+JA7D5eI22mcHQIEu7hVWX1qnS3UsEF2Z8Laug4G8tTueQOMO1IlqxdJw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736970224; c=relaxed/simple;
	bh=cCif3jgpUEDvduGSyY4mC93++t4Itxt5+D1M9qthB5o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=I5dQW6O9b5Ib3hQ4taHqIMy5c31PVkI/yrxYPMS7+yztl8jJFAtfv4TGRROYI9XRQ1F6loh5dOMfXSV7byHWatQbTweDGyAv0hiFZqDg1J8+2AvgnD5+7ETo85ZGZLwIaNP107t+cq1ZXH36vOmTqjrMEUHGMOlQDz9QaB147uQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D9DDE38515F8
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=PUGkNPv9
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 874F7429B2;
	Wed, 15 Jan 2025 19:43:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf07.hostedemail.com (Postfix) with ESMTPA id 15A9F2002D;
	Wed, 15 Jan 2025 19:43:37 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com (Cygwin Patches)
Subject: [PATCH v6 8/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 abbrev variants of base function
Date: Wed, 15 Jan 2025 12:39:25 -0700
Message-ID: <6c0f0ae8f09104e7980a4827f79041ccf45518ce.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
References: <cover.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Organization: Systematic Software
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 15A9F2002D
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: fahpjo38u9jx73ssm1gg8t1pabt8dcaz
X-Rspamd-Server: rspamout05
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX19s2jRCo3+GSwqGZxPSvnFd8cd8RzA/vKk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=he; bh=CAYWIMGlVqaeG+I99gDoybCQGKTnsA+plVrW93JBvME=; b=PUGkNPv9AHIeF63zWZcL4gsp576Xc/JffzBwp182D9IgLLNGNAKRWE0okCx2Mok1NTCxm+LwH9mJRkp1DqLTwRqdVqWNTK1vA3D9cr4IXo6V3aCvqYYKq66jyU6hV/ospkwZuTY75DYeXuD64okpDSkn3NJ3KAvsfbu5G0jCWxiN9O/VSJvX2U/UElWkC1e3HvKlYdLT8Wn0GcgXDtQYIEhPEtWG2rnhyzG5m/IwMqLpPw5LxrxQCYtEZHrbCEG7SHbCcd9VCSZpQKNqSm44FDAf0k2WMQEBvtfdcp8DL2Oyz6E90WVS3vVsDYCNq+3yrf1RWQ7uDjXwukNK3p1gBA==
X-HE-Tag: 1736970216-212258
X-HE-Meta: U2FsdGVkX1+SjqglCEfKjD8iHMbhcn+kGtv4/cPtJgG3NP9jgk1qtFWQ4bEEz/0qZTZcdbcb08ohmJm+qKYbN7ZNibeodxkN5jWD2gN/QF2lYAxacSLcZ6MeqQw5IK2KWUbxhL/5u9IhsJ+xZUZh7baHqgP1DYbQdjZSP0cqF4akymG29MzZBlA9WoWEXk4AVD3gZWUMpSgHSng3RjWjUWHNzsSHgcfD2EH1+RsNY2vmp6CTrWhi7TEqkgNsW9s3Q8OyXnupBJrr4j9m6ml/qJCE7zbJHFir+J1B1cNP0f21i/JZcFcL8CQzrP2jVw+kzsdwPeSs6Ks=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Abbreviate function variants on same line dropping base name.

Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 winsup/doc/posix.xml | 84 ++++++++++++++++++++++----------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index a9f293d0f19e..808a30089c79 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -42,9 +42,9 @@ ISO/IEC DIS 9945 Information technology
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
@@ -79,11 +79,11 @@ ISO/IEC DIS 9945 Information technology
     cacosh/cacoshf/cacoshl
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
@@ -111,21 +111,21 @@ ISO/IEC DIS 9945 Information technology
     cnd_destroy/cnd_init	(ISO C11)
     cnd_timedwait/cnd_wait	(ISO C11)
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
     ctime/ctime_r
     daylight/timezone/tzname/tzset
@@ -177,7 +177,7 @@ ISO/IEC DIS 9945 Information technology
     fclose
     fcntl			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     fdatasync
-    fdim/fdimf/fdiml
+    fdim/f/l
     fdopen
     fdopendir/opendir
     feclearexcept
@@ -204,8 +204,8 @@ ISO/IEC DIS 9945 Information technology
     fma/fmaf/fmal
     fmax/fmaxf/fmaxl
     fmemopen
-    fmin/fminf/fminl
-    fmod/fmodf/fmodl
+    fmin/f/l
+    fmod/f/l
     fnmatch
     fopen
     fork
@@ -288,7 +288,7 @@ ISO/IEC DIS 9945 Information technology
     if_indextoname
     if_nameindex
     if_nametoindex
-    ilogb/ilogbf/ilogbl
+    ilogb/f/l
     imaxabs
     imaxdiv
     in6addr_any/in6addr_loopback	(Cygwin DLL)
@@ -349,11 +349,11 @@ ISO/IEC DIS 9945 Information technology
     localeconv
     localtime/localtime_r
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
     lrint/lrintf/lrintl
     lround/lroundf/lroundl
@@ -381,7 +381,7 @@ ISO/IEC DIS 9945 Information technology
     mktime
     mlock/munlock
     mmap
-    modf/modff/modfl
+    modf/f/l
     mprotect
     mq_close
     mq_getattr
@@ -399,12 +399,12 @@ ISO/IEC DIS 9945 Information technology
     mtx_destroy/mtx_init	(ISO C11)
     mtx_lock/mtx_timedlock/mtx_trylock/mtx_unlock	(ISO C11)
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
     nice			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     nl_langinfo/nl_langinfo_l
@@ -534,7 +534,7 @@ ISO/IEC DIS 9945 Information technology
     rename/renameat
     rewind
     rewinddir
-    rint/rintf/rintl
+    rint/f/l
     rmdir
     round/roundf/roundl
     scalbln/scalblnf/scalblnl
@@ -642,8 +642,8 @@ ISO/IEC DIS 9945 Information technology
     sync
     sysconf
     system
-    tan/tanf/tanl
-    tanh/tanhf/tanhl
+    tan/f/l
+    tanh/f/l
     tcdrain
     tcflow
     tcflush
@@ -773,7 +773,7 @@ ISO/IEC DIS 9945 Information technology
     fflush_unlocked
     fileno_unlocked
     fgetc_unlocked
-    finite/finitef/finitel
+    finite/f/l
     fiprintf
     flock			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     fls/flsl/flsll
@@ -895,7 +895,7 @@ ISO/IEC DIS 9945 Information technology
     basename			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     canonicalize_file_name
     clearenv
-    clog10/clog10f/clog10l
+    clog10/f/l
     close_range			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     crypt_r			(available in external "crypt" library)
     dremf
@@ -909,7 +909,7 @@ ISO/IEC DIS 9945 Information technology
     error_at_line
     euidaccess
     execvpe
-    exp10/exp10f/exp10l
+    exp10/f/l
     fallocate			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     fcloseall
     fcloseall_r
@@ -947,7 +947,7 @@ ISO/IEC DIS 9945 Information technology
     mempcpy
     memrchr
     mkostemps
-    pow10/pow10f/pow10l
+    pow10/f/l
     pthread_getaffinity_np
     pthread_getattr_np
     pthread_getname_np
@@ -968,7 +968,7 @@ ISO/IEC DIS 9945 Information technology
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

