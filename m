Return-Path: <SRS0=Yd2F=VN=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	by sourceware.org (Postfix) with ESMTPS id 8725C3858D26
	for <cygwin-patches@cygwin.com>; Sat, 22 Feb 2025 17:49:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8725C3858D26
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8725C3858D26
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1740246541; cv=none;
	b=lH7eRABiPlsqOSDaiJC5GB4sqlGFbx9BMsZXTAbNmXfMmHs65GetenmtMdusPfwejX50XGt3F/82132WgH2h/O+/BlKQcwHInoD27HyIRCiS+AcHLf3P+FBzBnBqUOm8ry7Fuq6EMIpEh5MBKLble90vk01TPkuvaKPEJ2cpRIM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1740246541; c=relaxed/simple;
	bh=tqMhIRjtfJVBbXuO29sry3KRK+rSdFdkg7CqxzKIcco=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=dD6o2ulq2utqwRSI2o+XsEghA9E9KsZ+79LtugjlsVBAPzp/pOIyLf4PlpkMhfI51cD1S0CIC0VNSI+8sOzWBjjcp8FA8hPniPXsFP7UjcewUQXRLCyopRp/1Yw9Vn9fS/sEwfxVi1lbKONi6WzJwZNm+zPB6nlpZ6SsIwp3uIQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8725C3858D26
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=OGK6dPT+
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 1F5A71CADE4;
	Sat, 22 Feb 2025 17:49:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf16.hostedemail.com (Postfix) with ESMTPA id 982092000E;
	Sat, 22 Feb 2025 17:48:59 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com (Cygwin Patches)
Subject: [PATCH v8 1/5] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 TOG Issue 8 ISO 9945 move new POSIX
Date: Sat, 22 Feb 2025 10:48:18 -0700
Message-ID: <7de1ca210faf5e1ab5d5cd1b6adc9b393eee4f8a.1740246116.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1740246116.git.Brian.Inglis@SystematicSW.ab.ca>
References: <cover.1740246116.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Organization: Systematic Software
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 982092000E
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,KAM_SHORT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: wokfssddiafxenkk1jxkmhs6rxowmgrn
X-Rspamd-Server: rspamout05
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX18AmIHUEUMBRGs4i4aIPnzVZxFEp6WIuvY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=he; bh=vZ+QAzSYuQDB4Ee9l3ZCbq/B6ZZAXoysMcoOYlZ+Y1E=; b=OGK6dPT+kkiOTZhHwJ0kFw+rxrPmEKtkCuE+1rMqg7twRuD/4xZDH/9Vx2IPC1pfQ3W+rNVKkGQd9b7BaC3+8NVxZqpCcHeK+rFH66T4jpCh0u5L0E6ZqNQBoF7SfrJecdMcVRnyePylDoDYbJeThgRNdC5U6LuQcnmV4aC5gZbOmr4iNwMJeiQOHgP59Rb8YHYjS6gWUSIUgKh16ZSmsko8AQrqMherh1jmKlsdSc5uZRqZrD0qHPNcP5MMFgIhVrbR744a/Rb93fgit1LoT5pHmmvJOGk5o11x9CdT2Evuf31V6miyrEJgmyzEPTjn3XNqgoLE4XigmXmekkIVcQ==
X-HE-Tag: 1740246539-409821
X-HE-Meta: U2FsdGVkX1/kn5NI5xoBtt46Cz5PJn9ZZ84ozhUmnsu2vfZgPsLrDqYhU2KlI7cNgJiqfoiTDvYzR6FSTr+0EL8teI2K1PlxpVGX9wz730gcg7WEcRQruSzvCx/Os7vNRXNfNozcaiBRiECubP01D/xRd+YoNXTqBpzTn/rWN/amLTU5semBzgtyNLkdnELWZc/1rjduA8+jhg+GTXZ+yHegFb68PeEVQeFw1HN/tj9T/BpMdxI6veHWuPTbgztsfRV/anI5FRCw8icOQiJ8dWRL2MtJJX3VZVqVk7fD1ritobgq2iI+/nZikMLQWOJgNTKQBaooXPAWV0rsZR7LV4r/P+BJGukH03NqsG5iAMlgQ4rtpS/2669WCXnJrYBHUjk+SeKVAV1Z7DtzDxno3ZzlneiGBA9dFsi6wGDa+7ki09NPrmW+keqNU/75SRMvzjc/1IMFzjVqi/alZ0Eiy8IzvUBIdy7EUFCoBMrXnWc=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Update anchor id and description to current version, year, issue, etc.
Move new POSIX entries in other sections to the SUS/POSIX section.

Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 winsup/doc/posix.xml | 136 ++++++++++++++++++++++---------------------
 1 file changed, 70 insertions(+), 66 deletions(-)

diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 26d4fcfa4938..7debfb5084b4 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -5,10 +5,15 @@
 <chapter id="compatibility" xmlns:xi="http://www.w3.org/2001/XInclude">
 <title>Compatibility</title>
 
-<sect1 id="std-susv4"><title>System interfaces compatible with the Single Unix Specification, Version 7:</title>
+<sect1 id="std-susv5"><title>System interfaces compatible with the Single UNIX® Specification Version 5:</title>
 
-<para>Note that the core of the Single Unix Specification, Version 7 is
-also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
+<para>Note that the core of the Single UNIX® Specification Version 5 is
+POSIX®.1-2024 also simultaneously IEEE Std 1003.1™-2024 Edition,
+The ®Open Group Base Specifications Issue 8
+(see https://pubs.opengroup.org/onlinepubs/9799919799/), and
+ISO®/IEC DIS 9945 Information technology
+- Portable Operating System Interface (POSIX®) base specifications
+- Issue 8.</para>
 
 <screen>
     FD_CLR
@@ -25,6 +30,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     abort
     abs
     accept
+    accept4
     access
     acos
     acosf
@@ -40,6 +46,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     aio_suspend
     aio_write
     alarm
+    aligned_alloc
     alphasort
     asctime
     asctime_r
@@ -49,6 +56,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     asinhf
     asinhl
     asinl
+    asprintf
+    at_quick_exit
     atan
     atan2
     atan2f
@@ -68,6 +77,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     bind
     bsearch
     btowc
+    c16rtomb
+    c32rtomb
     cabs
     cabsf
     cabsl
@@ -77,6 +88,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     cacoshf
     cacoshl
     cacosl
+    call_once
     calloc
     carg
     cargf
@@ -134,6 +146,12 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     close
     closedir
     closelog
+    cnd_broadcast
+    cnd_destroy
+    cnd_init
+    cnd_signal
+    cnd_timedwait
+    cnd_wait
     confstr
     conj
     conjf
@@ -191,6 +209,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     dirfd
     dirname
     div
+    dladdr			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     dlclose
     dlerror
     dlopen
@@ -199,6 +218,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     drand48
     dup
     dup2
+    dup3
     duplocale
     encrypt			(available in external "libcrypt" library)
     endgrent
@@ -265,6 +285,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     fexecve
     fflush
     ffs
+    ffsl
+    ffsll
     fgetc
     fgetpos
     fgets
@@ -541,6 +563,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     malloc
     mblen
     mbrlen
+    mbrtoc16
+    mbrtoc32
     mbrtowc
     mbsinit
     mbsnrtowcs
@@ -551,6 +575,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     memchr
     memcmp
     memcpy
+    memmem
     memmove
     memset
     mkdir
@@ -560,6 +585,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     mkfifoat
     mknod
     mknodat
+    mkostemp
     mkstemp
     mktime
     mlock
@@ -584,6 +610,12 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     msgrcv			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     msgsnd			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     msync
+    mtx_destroy
+    mtx_init
+    mtx_lock
+    mtx_timedlock
+    mtx_trylock
+    mtx_unlock
     munlock
     munmap
     nan
@@ -622,6 +654,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     pclose
     perror
     pipe
+    pipe2
     poll
     popen
     posix_fadvise
@@ -653,6 +686,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     pow
     powf
     powl
+    ppoll
     pread
     printf
     pselect
@@ -686,6 +720,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     pthread_barrierattr_setpshared
     pthread_cancel
     pthread_cond_broadcast
+    pthread_cond_clockwait
     pthread_cond_destroy
     pthread_cond_init
     pthread_cond_signal
@@ -709,6 +744,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     pthread_key_create
     pthread_key_delete
     pthread_kill
+    pthread_mutex_clocklock
     pthread_mutex_destroy
     pthread_mutex_getprioceiling
     pthread_mutex_init
@@ -728,6 +764,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     pthread_mutexattr_setpshared
     pthread_mutexattr_settype
     pthread_once
+    pthread_rwlock_clockrdlock
+    pthread_rwlock_clockwrlock
     pthread_rwlock_destroy
     pthread_rwlock_init
     pthread_rwlock_rdlock
@@ -756,6 +794,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     pthread_spin_unlock
     pthread_testcancel
     ptsname
+    ptsname_r
     putc
     putc_unlocked
     putchar
@@ -767,6 +806,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     putwchar
     pwrite
     qsort
+    qsort_r			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
+    quick_exit
     raise
     rand
     rand_r
@@ -778,6 +819,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     readlinkat
     readv
     realloc
+    reallocarray
     realpath
     recv
     recvfrom
@@ -788,7 +830,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     regfree
     remainder
     remainderf
-    reminderl
+    remainderl
     remove
     remque
     remquo
@@ -821,9 +863,11 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
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
@@ -874,6 +918,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     shmdt			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     shmget			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     shutdown
+    sig2str
     sigaction
     sigaddset
     sigaltstack
@@ -925,6 +970,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     stdout
     stpcpy
     stpncpy
+    str2sig
     strcasecmp
     strcasecmp_l
     strcat
@@ -942,6 +988,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     strfmon_l
     strftime
     strftime_l
+    strlcat
+    strlcpy
     strlen
     strncasecmp
     strncasecmp_l
@@ -1002,6 +1050,14 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     tgamma
     tgammaf
     tgammal
+    thrd_create
+    thrd_current
+    thrd_detach
+    thrd_equal
+    thrd_exit
+    thrd_join
+    thrd_sleep
+    thrd_yield
     time
     timer_create		(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     timer_delete
@@ -1027,6 +1083,10 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     truncf
     truncl
     tsearch
+    tss_create
+    tss_delete
+    tss_get
+    tss_set
     ttyname
     ttyname_r
     twalk
@@ -1048,6 +1108,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     va_copy
     va_end
     va_start
+    vasprintf
     vdprintf
     vfprintf
     vfscanf
@@ -1078,6 +1139,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     wcscspn
     wcsdup
     wcsftime
+    wcslcat
+    wcslcpy
     wcslen
     wcsncasecmp
     wcsncasecmp_l
@@ -1159,8 +1222,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     feof_unlocked
     ferror_unlocked
     fflush_unlocked
-    fileno_unlocked
     fgetc_unlocked
+    fileno_unlocked
     finite
     finitef
     finitel
@@ -1215,10 +1278,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
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
@@ -1251,8 +1312,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     setusershell
     statfs
     strcasestr
-    strlcat
-    strlcpy
     strsep
     timingsafe_bcmp
     timingsafe_memcmp
@@ -1268,8 +1327,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     wait4
     warn
     warnx
-    wcslcat
-    wcslcpy
 </screen>
 
 </sect1>
@@ -1278,7 +1335,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
 
 <screen>
     __mempcpy
-    accept4
     argz_add
     argz_add_sep
     argz_append
@@ -1292,7 +1348,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     argz_replace
     argz_stringify
     asnprintf
-    asprintf
     asprintf_r
     basename			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     canonicalize_file_name
@@ -1302,9 +1357,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     clog10l
     close_range			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     crypt_r			(available in external "libcrypt" library)
-    dladdr			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     dremf
-    dup3
     envz_add
     envz_entry
     envz_get
@@ -1324,8 +1377,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     fedisableexcept
     feenableexcept
     fegetexcept
-    ffsl
-    ffsll
     fgets_unlocked
     fgetwc_unlocked
     fgetws_unlocked
@@ -1354,35 +1405,25 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     llistxattr
     lremovexattr
     lsetxattr
-    memmem
     mempcpy
     memrchr
-    mkostemp
     mkostemps
-    pipe2
     posix_spawn_file_actions_addchdir_np
     posix_spawn_file_actions_addfchdir_np
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
@@ -1390,8 +1431,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     sched_getaffinity
     sched_getcpu
     sched_setaffinity
-    secure_getenv
-    sem_clockwait
     setxattr
     signalfd
     sincos
@@ -1418,7 +1457,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     updwtmpx
     utmpxname
     vasnprintf
-    vasprintf
     vasprintf_r
     versionsort
     wcsftime_l
@@ -1463,8 +1501,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     getmntent
     memalign
     setmntent
-    sig2str
-    str2sig
     xdr_array			(available in external "libtirpc" library)
     xdr_bool			(available in external "libtirpc" library)
     xdr_bytes			(available in external "libtirpc" library)
@@ -1516,49 +1552,17 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
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
 <sect1 id="std-deprec"><title>Other UNIX system interfaces, not in POSIX.1-2008 or deprecated:</title>
 
 <screen>
-- 
2.45.1

