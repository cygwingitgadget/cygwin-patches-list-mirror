Return-Path: <SRS0=8byy=UD=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	by sourceware.org (Postfix) with ESMTPS id 695863857B90
	for <cygwin-patches@cygwin.com>; Sat, 11 Jan 2025 00:03:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 695863857B90
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 695863857B90
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736553794; cv=none;
	b=V7PC4Y7bKVSA4Ocq4exDU1jJ4DxS2131S/ZkcoV9oGGHUyaPz+hteJH+vJ5lyPgaeJRGUK/Bw+rvBR3bEesQYPfFDPBxlvA7dcdJyftFZgixY5+bodrb5LJ4yCiekr0ClR4B1G0p1UvcUs4v60Cfihvkhz2ZQpTzf2Oc30es4hM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736553794; c=relaxed/simple;
	bh=lGeQwg8koZ2+JVd/PyZFqpXIcFcMENZ3ZhWJxzEdeWI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=JOFjt4FU5Bbakg6JvHepVbVbAwG3Wzam1a8GhnafVbfhpiT08tnNbmSs9REUE4WgFP4JkqO+KgcOnEyKKcGKsgSp4laL0nKHACb8Qq4RYzTFGbeoHDYekGJOdNxylOwv/okHoaFxZDJtXfJZ5WyYN7YvcVM0j6GyeVed8R4Ngus=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 695863857B90
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=MTekag/h
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 0A929A0F55;
	Sat, 11 Jan 2025 00:03:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf09.hostedemail.com (Postfix) with ESMTPA id 9473920025;
	Sat, 11 Jan 2025 00:03:12 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH v5 1/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 TOG Issue 8 ISO 9945 move new
Date: Fri, 10 Jan 2025 17:01:02 -0700
Message-ID: <ce4fb1f0bb4390758b48d56bf635de71b5809b42.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Organization: Systematic Software
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Stat-Signature: 57rw4fftxgzsgn71cyocgsas1x17oi4c
X-Rspamd-Server: rspamout04
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,KAM_SHORT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: 9473920025
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1+K9R6V2ELFXRl0ygSByIpesohG9jt+q5c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=he; bh=eVQAXvSg0x9OwVIHdFfJMUYG0iOW0CubCGwfw6GgQVY=; b=MTekag/hNDyR3SSNLWd+IfZ0ZWDLavoYtBk+XPetMZ6yh9iJxZXxasFbCezibA4wcPz0H6HxqnQKeowWub0CZAHErcxD2YIRKe2ZF+Ici6ZRvnsznAAmcFQzeGO+rqVmIU2bIsDUn9MgUgKrfSdfxCLFAUiDmJ+Tn4JdlDKrtx5XVDy+2zAN+uQt20MITT8D1wobSiQ/FVPc+xJ1B/4bfZMrG65R93IBpKz5Njr+BcRIk8cI3jNXuzn/zvs6iP6MVpBTIrwKNqnAudwDzElUl8IkB7WtUb2krWVzbtLSq+sSFT1iZU0QAdI+6Ae4dayCs08uHB6ns16ONXD+YQHZVA==
X-HE-Tag: 1736553792-364817
X-HE-Meta: U2FsdGVkX18D+CsCvMO2LMG6YjM8pwElOHJmK9bxt1JRBMjwwEo7b+v684OuDxI3T0G1z3XoO5Axez6sm8GUlV7Fu3cdMa/+E+khTudsBZr/+x9p7QS5sgNU350v8A3aLhXbR/CMluZNDIfpsE1azHYPmZiutecWjydkje46M7v+Vws6bpd3yUbcC25Jnl3RlkOzPN9WFAPpGu5mVwK0EAGNpzmiQZZp37Z+H9WJh7lBSDjL4mU5hyJzeImsSgZBxa8QbbV/MCnM07vFcpXwwDVD9aQwPvN3DwlRUEIi2nQ3jxxRcCimVPI/QOxVOrxDVhFa5iSxb4a6WjH1CwtmNiAV6FNli/el32P7drSyd0crXdX6KfKWooVCyDjuK9e/vuZC4HsypfTrk6KfC545C5ULM+9sTz74Jy0gTtOOiLxqST4wk+NJ+DKwevIEmw/sexQ1k6thVLXM42EsEJGA+zMvH2/vIS6v9EaZrlU7bwz40Lp5J20Ov1ExakRMaS9h3XEkh4MiJ8mEKncmccgxq0zLjXlO8f5ux+vAVlHk/MtQKcWy57Dsmg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Update anchor id and description to current version, year, issue, etc.
Move new POSIX entries in other sections to the SUS/POSIX section.

Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 winsup/doc/posix.xml | 140 ++++++++++++++++++++++---------------------
 1 file changed, 73 insertions(+), 67 deletions(-)

diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 2782beb86547..1b893e9e19ae 100644
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
@@ -25,6 +31,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     abort
     abs
     accept
+    accept4
     access
     acos
     acosf
@@ -40,6 +47,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     aio_suspend
     aio_write
     alarm
+    aligned_alloc		(ISO C11)
     alphasort
     asctime
     asctime_r
@@ -49,6 +57,9 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     asinhf
     asinhl
     asinl
+    asprintf
+    assert			(SVID - available in "assert.h" header)
+    at_quick_exit		(ISO C11)
     atan
     atan2
     atan2f
@@ -68,6 +79,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     bind
     bsearch
     btowc
+    c16rtomb			(ISO C11)
+    c32rtomb			(ISO C11)
     cabs
     cabsf
     cabsl
@@ -77,6 +90,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     cacoshf
     cacoshl
     cacosl
+    call_once			(ISO C11)
     calloc
     carg
     cargf
@@ -134,6 +148,12 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
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
@@ -191,6 +211,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     dirfd
     dirname
     div
+    dladdr			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     dlclose
     dlerror
     dlopen
@@ -199,6 +220,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     drand48
     dup
     dup2
+    dup3
     duplocale
     encrypt			(available in external "crypt" library)
     endgrent
@@ -265,6 +287,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     fexecve
     fflush
     ffs
+    ffsl
+    ffsll
     fgetc
     fgetpos
     fgets
@@ -541,6 +565,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     malloc
     mblen
     mbrlen
+    mbrtoc16			(ISO C23 - available in "uchar.h" header)
+    mbrtoc32			(ISO C23 - available in "uchar.h" header)
     mbrtowc
     mbsinit
     mbsnrtowcs
@@ -551,6 +577,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     memchr
     memcmp
     memcpy
+    memmem
     memmove
     memset
     mkdir
@@ -560,6 +587,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     mkfifoat
     mknod
     mknodat
+    mkostemp
     mkstemp
     mktime
     mlock
@@ -584,6 +612,12 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
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
@@ -622,6 +656,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     pclose
     perror
     pipe
+    pipe2
     poll
     popen
     posix_fadvise
@@ -630,8 +665,10 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
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
@@ -653,6 +690,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     pow
     powf
     powl
+    ppoll
     pread
     printf
     pselect
@@ -686,6 +724,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     pthread_barrierattr_setpshared
     pthread_cancel
     pthread_cond_broadcast
+    pthread_cond_clockwait
     pthread_cond_destroy
     pthread_cond_init
     pthread_cond_signal
@@ -709,6 +748,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     pthread_key_create
     pthread_key_delete
     pthread_kill
+    pthread_mutex_clocklock
     pthread_mutex_destroy
     pthread_mutex_getprioceiling
     pthread_mutex_init
@@ -728,6 +768,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     pthread_mutexattr_setpshared
     pthread_mutexattr_settype
     pthread_once
+    pthread_rwlock_clockrdlock
+    pthread_rwlock_clockwrlock
     pthread_rwlock_destroy
     pthread_rwlock_init
     pthread_rwlock_rdlock
@@ -756,6 +798,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     pthread_spin_unlock
     pthread_testcancel
     ptsname
+    ptsname_r
     putc
     putc_unlocked
     putchar
@@ -767,6 +810,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     putwchar
     pwrite
     qsort
+    qsort_r			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
+    quick_exit			(ISO C11)
     raise
     rand
     rand_r
@@ -778,6 +823,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     readlinkat
     readv
     realloc
+    reallocarray
     realpath
     recv
     recvfrom
@@ -788,7 +834,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     regfree
     remainder
     remainderf
-    reminderl
+    remainderl			(ISO C99 - available in "math.h" header)
     remove
     remque
     remquo
@@ -821,9 +867,11 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
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
@@ -874,6 +922,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     shmdt			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     shmget			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     shutdown
+    sig2str
     sigaction
     sigaddset
     sigaltstack
@@ -925,6 +974,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     stdout
     stpcpy
     stpncpy
+    str2sig
     strcasecmp
     strcasecmp_l
     strcat
@@ -942,6 +992,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     strfmon_l
     strftime
     strftime_l
+    strlcat
+    strlcpy
     strlen
     strncasecmp
     strncasecmp_l
@@ -1000,6 +1052,14 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
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
@@ -1025,6 +1085,10 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
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
@@ -1046,6 +1110,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     va_copy
     va_end
     va_start
+    vasprintf
     vdprintf
     vfprintf
     vfscanf
@@ -1076,6 +1141,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     wcscspn
     wcsdup
     wcsftime
+    wcslcat
+    wcslcpy
     wcslen
     wcsncasecmp
     wcsncasecmp_l
@@ -1213,10 +1280,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
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
@@ -1249,8 +1314,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     setusershell
     statfs
     strcasestr
-    strlcat
-    strlcpy
     strsep
     timingsafe_bcmp
     timingsafe_memcmp
@@ -1266,8 +1329,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     wait4
     warn
     warnx
-    wcslcat
-    wcslcpy
 </screen>
 
 </sect1>
@@ -1276,7 +1337,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
 
 <screen>
     __mempcpy
-    accept4
     argz_add
     argz_add_sep
     argz_append
@@ -1290,7 +1350,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     argz_replace
     argz_stringify
     asnprintf
-    asprintf
     asprintf_r
     basename			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     canonicalize_file_name
@@ -1300,9 +1359,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     clog10l
     close_range			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     crypt_r			(available in external "crypt" library)
-    dladdr			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     dremf
-    dup3
     envz_add
     envz_entry
     envz_get
@@ -1322,8 +1379,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     fedisableexcept
     feenableexcept
     fegetexcept
-    ffsl
-    ffsll
     fgets_unlocked
     fgetwc_unlocked
     fgetws_unlocked
@@ -1352,35 +1407,23 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
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
@@ -1388,8 +1431,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     sched_getaffinity
     sched_getcpu
     sched_setaffinity
-    secure_getenv
-    sem_clockwait
     setxattr
     signalfd
     sincos
@@ -1416,7 +1457,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     updwtmpx
     utmpxname
     vasnprintf
-    vasprintf
     vasprintf_r
     versionsort
     wcsftime_l
@@ -1461,8 +1501,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
     getmntent
     memalign
     setmntent
-    sig2str
-    str2sig
     xdr_array			(available in external "libtirpc" library)
     xdr_bool			(available in external "libtirpc" library)
     xdr_bytes			(available in external "libtirpc" library)
@@ -1514,49 +1552,17 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
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

