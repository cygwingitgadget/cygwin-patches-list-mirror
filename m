Return-Path: <SRS0=SYvf=UH=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	by sourceware.org (Postfix) with ESMTPS id DE36938515E7
	for <cygwin-patches@cygwin.com>; Wed, 15 Jan 2025 19:43:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DE36938515E7
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DE36938515E7
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.10
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736970208; cv=none;
	b=gHWESWyjE3dh5Y6vaAn4T2BERX2QPgRHV/EQnuQAFoAPmlsMYi2FIlSYyfj/cwB+95b5zmfJosB3ugNx0v8DNou4FCFjr+ad5NGPJ7ja0wBRqTu54qvfvues5HBV+Hs/wXXj4e/dfXfURXTsBET2LqToS2l455Sy0TPuIt1cY/g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736970208; c=relaxed/simple;
	bh=LQMcAyKF57HvXtU0nwF9ZrA2BK2RHuWm+30qKywgsgE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=O/WD1jqtvvWv5RnpJoNNJRWgAEiKBib571dkSFqk33I6UswGyVJmlCP5D6AOsc28RIF18GzIWqJoDkLnYczFA6aftXSxK8vCjjq/4owzET9DVNHZdx+e7E7sbL+3qjEEH5sCYXe+vtzzpt8NhR1bPtgO6Yht6GsSemrfG0fv4uU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DE36938515E7
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=cGzERERr
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 6C8CD1A01E5;
	Wed, 15 Jan 2025 19:43:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf07.hostedemail.com (Postfix) with ESMTPA id D24642002C;
	Wed, 15 Jan 2025 19:43:25 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com (Cygwin Patches)
Subject: [PATCH v6 1/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 move new entries
Date: Wed, 15 Jan 2025 12:39:18 -0700
Message-ID: <0b9a9708e62ca8a77a5efbbc18543d77b73704b0.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
References: <cover.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Organization: Systematic Software
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D24642002C
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,KAM_SHORT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: uc4y9qxdaikwz6a7kiombokj7i54kenc
X-Rspamd-Server: rspamout05
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX19bma+1V3f5EPsm2+Pu3JzjhK/A2KQ3N7I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=he; bh=I+Lfj0Dn7M5Awill/tJl6GV/1gs8nPmo/uwAjnAPjh0=; b=cGzERERr5ud+CXbnNRoCK1AJDZ8wMil6RMoNPWF3+iXPqpG8B+xWML4q/MbMOYv41b9//dGTjto6mSCw/cnHV/8MNbhRMkZNKcikt8soy7TFqxtkO6By3Ym0JFq+jQawnPGkwOcbZDqnuPmzbkUuXjlZ3Y9CDK1RC6BMWc4d9YdDcg0tAKwYOu3Puhfvduf1Dvar5RGNGhwyD0gBUyY5bI9cRtNj+U1NBVUy674VmgKcYOzfLz8TGsoWGhPH5tEryw5pQTEyeuaDfUQ79V1dhHDRGXAOzYhriLWcyKg5xiM+SG0AKDcsdioP8UnqY4qE0IR5JAQGopQ//InLbiHWfQ==
X-HE-Tag: 1736970205-508583
X-HE-Meta: U2FsdGVkX19iAmrdc/AZTzaK0hhVDdzzsowxzrio3mgNfAf5M+6a1gpmhhtWmhUGTwfLlbcAVlkQ3ZXtHjEGaHu/Q5lAqJp65UroFRHKz6VyUVLA2qG6wFnqy4eH8eFpAW0W0LnOFEpZypIxLBysDugtCeFMM7SqNvWkkqTund7sZOrXdU5swAuUjBAfx+O76B7sBMEcaBwV540hToJZjIiBsDftq1SMRnsYeZusPZk2y5SlC9BxMaZQ9Ufag1UgYhqzdOY6m4zhhtzef0AtCKjRBLpd/+P2K4P7eamXQVQ2lFw73UVmkNqkc4HZ9dvPY6ExPNgf2rJdXGtW60UJTR3CanO5ZKN375XRVVrQ0uZU60zQaCV7lhsymwwSske5lnlHYvPVqmVIFxFgXHNUzEHbWr64RmeT2raaIDGyeaBTNp4Q946IKWxTRGn/ac5sEN88hSfXva9mZ3cYAUxI4IiG89oexnYgk0lS1tfvdiA=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Update anchor id and description to current version, year, issue, etc.
Move new POSIX entries in other sections to the SUS/POSIX section.

Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 winsup/doc/posix.xml | 139 ++++++++++++++++++++++---------------------
 1 file changed, 72 insertions(+), 67 deletions(-)

diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 2782beb86547..949333b0c36c 100644
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
+The Open Group Base Specifications Issue 8
+(see https://pubs.opengroup.org/onlinepubs/9799919799/), and
+ISO/IEC DIS 9945 Information technology
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
+    aligned_alloc		(ISO C11)
     alphasort
     asctime
     asctime_r
@@ -49,6 +56,9 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     asinhf
     asinhl
     asinl
+    asprintf
+    assert			(SVID - available in "assert.h" header)
+    at_quick_exit		(ISO C11)
     atan
     atan2
     atan2f
@@ -68,6 +78,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     bind
     bsearch
     btowc
+    c16rtomb			(ISO C11)
+    c32rtomb			(ISO C11)
     cabs
     cabsf
     cabsl
@@ -77,6 +89,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     cacoshf
     cacoshl
     cacosl
+    call_once			(ISO C11)
     calloc
     carg
     cargf
@@ -134,6 +147,12 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
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
@@ -191,6 +210,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     dirfd
     dirname
     div
+    dladdr			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     dlclose
     dlerror
     dlopen
@@ -199,6 +219,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     drand48
     dup
     dup2
+    dup3
     duplocale
     encrypt			(available in external "crypt" library)
     endgrent
@@ -265,6 +286,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     fexecve
     fflush
     ffs
+    ffsl
+    ffsll
     fgetc
     fgetpos
     fgets
@@ -541,6 +564,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     malloc
     mblen
     mbrlen
+    mbrtoc16			(ISO C23 - available in "uchar.h" header)
+    mbrtoc32			(ISO C23 - available in "uchar.h" header)
     mbrtowc
     mbsinit
     mbsnrtowcs
@@ -551,6 +576,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     memchr
     memcmp
     memcpy
+    memmem
     memmove
     memset
     mkdir
@@ -560,6 +586,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     mkfifoat
     mknod
     mknodat
+    mkostemp
     mkstemp
     mktime
     mlock
@@ -584,6 +611,12 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
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
@@ -622,6 +655,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     pclose
     perror
     pipe
+    pipe2
     poll
     popen
     posix_fadvise
@@ -630,8 +664,10 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
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
@@ -653,6 +689,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     pow
     powf
     powl
+    ppoll
     pread
     printf
     pselect
@@ -686,6 +723,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     pthread_barrierattr_setpshared
     pthread_cancel
     pthread_cond_broadcast
+    pthread_cond_clockwait
     pthread_cond_destroy
     pthread_cond_init
     pthread_cond_signal
@@ -709,6 +747,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     pthread_key_create
     pthread_key_delete
     pthread_kill
+    pthread_mutex_clocklock
     pthread_mutex_destroy
     pthread_mutex_getprioceiling
     pthread_mutex_init
@@ -728,6 +767,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     pthread_mutexattr_setpshared
     pthread_mutexattr_settype
     pthread_once
+    pthread_rwlock_clockrdlock
+    pthread_rwlock_clockwrlock
     pthread_rwlock_destroy
     pthread_rwlock_init
     pthread_rwlock_rdlock
@@ -756,6 +797,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     pthread_spin_unlock
     pthread_testcancel
     ptsname
+    ptsname_r
     putc
     putc_unlocked
     putchar
@@ -767,6 +809,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     putwchar
     pwrite
     qsort
+    qsort_r			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
+    quick_exit			(ISO C11)
     raise
     rand
     rand_r
@@ -778,6 +822,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     readlinkat
     readv
     realloc
+    reallocarray
     realpath
     recv
     recvfrom
@@ -788,7 +833,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     regfree
     remainder
     remainderf
-    reminderl
+    remainderl			(ISO C99 - available in "math.h" header)
     remove
     remque
     remquo
@@ -821,9 +866,11 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
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
@@ -874,6 +921,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     shmdt			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     shmget			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     shutdown
+    sig2str
     sigaction
     sigaddset
     sigaltstack
@@ -925,6 +973,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     stdout
     stpcpy
     stpncpy
+    str2sig
     strcasecmp
     strcasecmp_l
     strcat
@@ -942,6 +991,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     strfmon_l
     strftime
     strftime_l
+    strlcat
+    strlcpy
     strlen
     strncasecmp
     strncasecmp_l
@@ -1000,6 +1051,14 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
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
@@ -1025,6 +1084,10 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     truncf
     truncl
     tsearch
+    tss_create			(ISO C11)
+    tss_delete			(ISO C11)
+    tss_get			(ISO C11)
+    tss_set			(ISO C11)
     ttyname
     ttyname_r
     twalk
@@ -1046,6 +1109,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     va_copy
     va_end
     va_start
+    vasprintf
     vdprintf
     vfprintf
     vfscanf
@@ -1076,6 +1140,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     wcscspn
     wcsdup
     wcsftime
+    wcslcat
+    wcslcpy
     wcslen
     wcsncasecmp
     wcsncasecmp_l
@@ -1213,10 +1279,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
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
@@ -1249,8 +1313,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     setusershell
     statfs
     strcasestr
-    strlcat
-    strlcpy
     strsep
     timingsafe_bcmp
     timingsafe_memcmp
@@ -1266,8 +1328,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     wait4
     warn
     warnx
-    wcslcat
-    wcslcpy
 </screen>
 
 </sect1>
@@ -1276,7 +1336,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
 
 <screen>
     __mempcpy
-    accept4
     argz_add
     argz_add_sep
     argz_append
@@ -1290,7 +1349,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     argz_replace
     argz_stringify
     asnprintf
-    asprintf
     asprintf_r
     basename			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     canonicalize_file_name
@@ -1300,9 +1358,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     clog10l
     close_range			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     crypt_r			(available in external "crypt" library)
-    dladdr			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     dremf
-    dup3
     envz_add
     envz_entry
     envz_get
@@ -1322,8 +1378,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     fedisableexcept
     feenableexcept
     fegetexcept
-    ffsl
-    ffsll
     fgets_unlocked
     fgetwc_unlocked
     fgetws_unlocked
@@ -1352,35 +1406,23 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
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
@@ -1388,8 +1430,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     sched_getaffinity
     sched_getcpu
     sched_setaffinity
-    secure_getenv
-    sem_clockwait
     setxattr
     signalfd
     sincos
@@ -1416,7 +1456,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     updwtmpx
     utmpxname
     vasnprintf
-    vasprintf
     vasprintf_r
     versionsort
     wcsftime_l
@@ -1461,8 +1500,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     getmntent
     memalign
     setmntent
-    sig2str
-    str2sig
     xdr_array			(available in external "libtirpc" library)
     xdr_bool			(available in external "libtirpc" library)
     xdr_bytes			(available in external "libtirpc" library)
@@ -1514,49 +1551,17 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
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

