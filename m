Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-no.shaw.ca (smtp-out-no.shaw.ca [64.59.134.9])
 by sourceware.org (Postfix) with ESMTPS id 80D493857C4E
 for <cygwin-patches@cygwin.com>; Mon, 15 Feb 2021 22:35:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 80D493857C4E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net. ([24.64.172.44])
 by shaw.ca with ESMTP
 id BmT0lFATo2SWTBmT1lv11G; Mon, 15 Feb 2021 15:35:44 -0700
X-Authority-Analysis: v=2.4 cv=fdJod2cF c=1 sm=1 tr=0 ts=602af740
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=r77TgQKjGQsHNAKrUKIA:9 a=GGbs7QDsRHf33fvN9iIA:9 a=QEXdDO2ut3YA:10
 a=ioQJsTg4OrVoz4WC9BQA:9 a=B2y7HmGcmWMA:10
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin.patches@cygwin.com,
	cygwin-patches@cygwin.com
Subject: [PATCH v2] winsup/doc/posix.xml: add note for getrlimit, setrlimit,
 xrefs to notes
Date: Mon, 15 Feb 2021 15:35:39 -0700
Message-Id: <20210215223540.18256-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.30.0
Reply-To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.30.0"
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfAYLV+QpB+oTRyyNHkXm2S7iCWyR2EkQTAF5R/Qe7QC/6sJbVolO723Epa4T13Az3zoXLT1shIUJ6X1RnTY4BzxX6bXIzTwZVXlsu2dJZD/h+d0IjdKF
 cxfcfqHzxv1SSyuqklzkMjDAbtHWsUzoPTZEeKBbVPoKxgxeh7nF8Oti6YSrsuWGHow1fTgev37w4D6S6SBHgEKQYD87iOAQV456UhXOU4liVi4KxmhT+Twe
 XHsF4rCNxABdE0OHFY+Bn2UcsuI0vcTx1ZzygibzVKzmEKAdemzoIBTSRvTYPagwHZIi1x3AHd2vKguzNnVofA==
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NONE,
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
X-List-Received-Date: Mon, 15 Feb 2021 22:35:47 -0000

This is a multi-part message in MIME format.
--------------2.30.0
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


change notes to see "Implementation Notes" to xref to std-notes;
add xref to std-notes to getrlimit, setrlimit;
add note to document limitations of getrlimit, setrlimit resources support
---
 winsup/doc/posix.xml | 101 ++++++++++++++++++++++++-------------------
 1 file changed, 57 insertions(+), 44 deletions(-)


--------------2.30.0
Content-Type: text/x-patch; name="0001-winsup-doc-posix.xml-add-note-for-getrlimit-setrlimit.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-winsup-doc-posix.xml-add-note-for-getrlimit-setrlimit.patch"

diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 0669d07de890..360ee703f3dd 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -64,7 +64,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     atoi
     atol
     atoll
-    basename			(see chapter "Implementation Notes")
+    basename			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
     bind
     bsearch
     btowc
@@ -126,8 +126,8 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     clock_getcpuclockid
     clock_getres
     clock_gettime
-    clock_nanosleep		(see chapter "Implementation Notes")
-    clock_settime		(see chapter "Implementation Notes")
+    clock_nanosleep		<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
+    clock_settime		<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
     clog
     clogf
     clogl
@@ -242,7 +242,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     fchown
     fchownat
     fclose
-    fcntl			(see chapter "Implementation Notes")
+    fcntl			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
     fdatasync
     fdim
     fdimf
@@ -292,7 +292,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     fopen
     fork
     fpathconf
-    fpclassify			(see chapter "Implementation Notes")
+    fpclassify			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
     fprintf
     fputc
     fputs
@@ -347,7 +347,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     getgroups
     gethostid
     gethostname
-    getitimer			(see chapter "Implementation Notes")
+    getitimer			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
     getline
     getlogin
     getlogin_r
@@ -367,7 +367,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     getpwnam_r
     getpwuid
     getpwuid_r
-    getrlimit
+    getrlimit			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
     getrusage
     gets
     getservbyname
@@ -428,26 +428,26 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     iscntrl_l
     isdigit
     isdigit_l
-    isfinite			(see chapter "Implementation Notes")
+    isfinite			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
     isgraph
     isgraph_l
-    isgreater			(see chapter "Implementation Notes")
-    isgreaterequal		(see chapter "Implementation Notes")
-    isinf			(see chapter "Implementation Notes")
+    isgreater			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
+    isgreaterequal		<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
+    isinf			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
     isless
-    islessequal			(see chapter "Implementation Notes")
-    islessgreater		(see chapter "Implementation Notes")
+    islessequal			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
+    islessgreater		<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
     islower
     islower_l
-    isnan			(see chapter "Implementation Notes")
-    isnormal			(see chapter "Implementation Notes")
+    isnan			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
+    isnormal			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
     isprint
     isprint_l
     ispunct
     ispunct_l
     isspace
     isspace_l
-    isunordered			(see chapter "Implementation Notes")
+    isunordered			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
     isupper
     isupper_l
     iswalnum
@@ -511,7 +511,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     localeconv
     localtime
     localtime_r
-    lockf			(see chapter "Implementation Notes")
+    lockf			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
     log
     log10
     log10f
@@ -579,10 +579,10 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     mq_timedsend
     mq_unlink
     mrand48
-    msgctl			(see chapter "Implementation Notes")
-    msgget			(see chapter "Implementation Notes")
-    msgrcv			(see chapter "Implementation Notes")
-    msgsnd			(see chapter "Implementation Notes")
+    msgctl			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
+    msgget			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
+    msgrcv			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
+    msgsnd			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
     msync
     munlock
     munmap
@@ -834,9 +834,9 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     sem_trywait
     sem_unlink
     sem_wait
-    semctl			(see chapter "Implementation Notes")
-    semget			(see chapter "Implementation Notes")
-    semop			(see chapter "Implementation Notes")
+    semctl			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
+    semget			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
+    semop			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
     send
     sendmsg
     sendto
@@ -847,7 +847,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     setgid
     setgrent
     sethostent
-    setitimer			(see chapter "Implementation Notes")
+    setitimer			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
     setjmp
     setkey			(available in external "crypt" library)
     setlocale
@@ -859,7 +859,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     setpwent
     setregid
     setreuid
-    setrlimit
+    setrlimit			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
     setservent
     setsid
     setsockopt
@@ -869,10 +869,10 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     setvbuf
     shm_open
     shm_unlink
-    shmat			(see chapter "Implementation Notes")
-    shmctl			(see chapter "Implementation Notes")
-    shmdt			(see chapter "Implementation Notes")
-    shmget			(see chapter "Implementation Notes")
+    shmat			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
+    shmctl			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
+    shmdt			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
+    shmget			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
     shutdown
     sigaction
     sigaddset
@@ -886,9 +886,9 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     sigismember
     siglongjmp
     signal
-    signbit			(see chapter "Implementation Notes")
+    signbit			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
     signgam
-    sigpause			(see chapter "Implementation Notes")
+    sigpause			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
     sigpending
     sigprocmask
     sigqueue
@@ -937,7 +937,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     strdup
     strerror
     strerror_l
-    strerror_r			(see chapter "Implementation Notes")
+    strerror_r			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
     strfmon
     strfmon_l
     strftime
@@ -1001,7 +1001,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     tgammaf
     tgammal
     time
-    timer_create		(see chapter "Implementation Notes")
+    timer_create		<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
     timer_delete
     timer_getoverrun
     timer_gettime
@@ -1162,7 +1162,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     finitef
     finitel
     fiprintf
-    flock			(see chapter "Implementation Notes")
+    flock			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
     fls
     flsl
     flsll
@@ -1212,7 +1212,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     madvise
     mkstemps
     openpty
-    qsort_r			(see chapter "Implementation Notes")
+    qsort_r			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
     rcmd
     rcmd_af
     reallocarray
@@ -1257,7 +1257,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     valloc
     verr
     verrx
-    vhangup			(see chapter "Implementation Notes")
+    vhangup			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
     vsyslog
     vwarn
     vwarnx
@@ -1291,14 +1291,14 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     asnprintf
     asprintf
     asprintf_r
-    basename			(see chapter "Implementation Notes")
+    basename			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
     canonicalize_file_name
     clearenv
     clog10
     clog10f
     clog10l
     crypt_r			(available in external "crypt" library)
-    dladdr			(see chapter "Implementation Notes")
+    dladdr			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
     dremf
     dup3
     envz_add
@@ -1370,8 +1370,8 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     ptsname_r
     putwc_unlocked
     putwchar_unlocked
-    renameat2			(see chapter "Implementation Notes")
-    qsort_r			(see chapter "Implementation Notes")
+    renameat2			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
+    qsort_r			<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
     quotactl
     rawmemchr
     removexattr
@@ -1545,8 +1545,8 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     bcmp			(POSIX.1-2001, SUSv3)
     bcopy			(SUSv3)
     bzero			(SUSv3)
-    chroot			(SUSv2) (see chapter "Implementation Notes")
-    clock_setres		(QNX, VxWorks) (see chapter "Implementation Notes")
+    chroot			(SUSv2)		<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
+    clock_setres		(QNX, VxWorks)	<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
     cuserid			(POSIX.1-1988, SUSv2)
     ecvt			(SUSv3)
     endutent			(XPG2)
@@ -1592,7 +1592,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     ualarm			(SUSv3)
     usleep			(SUSv3)
     utmpname			(XPG2)
-    vfork			(SUSv3) (see chapter "Implementation Notes")
+    vfork			(SUSv3)		<xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
 </screen>
 
 </sect1>
@@ -1727,6 +1727,19 @@ flavors, depending on whether _GNU_SOURCE is defined when compiling.</para>
 <para><function>dladdr</function> always sets the Dl_info members dli_sname and
 dli_saddr to NULL, indicating no symbol matching addr could be found.</para>
 
+<para><function>getrlimit</function> resources RLIMIT_AS, RLIMIT_CPU,
+RLIMIT_FSIZE, RLIMIT_DATA always return rlim_cur and rlim_max as RLIM_INFINITY,
+so <function>setrlimit</function> returns -1 and sets EINVAL if they are
+lowered, or returns 0 if unchanged.
+<function>getrlimit</function> resource RLIMIT_NOFILE always returns rlim_cur
+and rlim_max as OPEN_MAX; <function>setrlimit</function> returns 0 sets EINVAL
+if rlim_cur > rlim_max, does not change the value if it is RLIM_INFINITY,
+otherwise returns the result from <function>setdtablesize</function>.
+<function>getrlimit</function>/<function>setrlimit</function> resources
+RLIMIT_CORE and RLIMIT_STACK return the current values and set the requested
+values.
+All other resource arguments return -1 and set EINVAL.</para>
+
 </sect1>
 
 </chapter>

--------------2.30.0--


