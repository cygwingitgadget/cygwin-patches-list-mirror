Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.139])
 by sourceware.org (Postfix) with ESMTPS id 1B8903843856
 for <cygwin-patches@cygwin.com>; Sat, 13 Feb 2021 01:06:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 1B8903843856
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net. ([24.64.172.44])
 by shaw.ca with ESMTP
 id AjNqlYn8MHmS3AjNrlDd6I; Fri, 12 Feb 2021 18:06:04 -0700
X-Authority-Analysis: v=2.4 cv=MaypB7zf c=1 sm=1 tr=0 ts=602725fc
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=r77TgQKjGQsHNAKrUKIA:9 a=4m2kRT5vEatfNvpwuq8A:9 a=QEXdDO2ut3YA:10
 a=ioQJsTg4OrVoz4WC9BQA:9 a=B2y7HmGcmWMA:10
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH] winsup/doc/posix.xml: add note for getrlimit, setrlimit,
 links to notes
Date: Fri, 12 Feb 2021 18:06:00 -0700
Message-Id: <20210213010600.30473-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.30.0
Reply-To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.30.0"
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfM9wBTgP5yDSFZ3uDzoZOBeC5+BNh61vP+nhQGA/j6hDRl6z6/JtiknwL+Kv5bWeTw8oywYRvWcsySPdVS7MIQqkztKzuKhJAdfxxo+nix7yLauIP7h7
 BDTquote+2DIaPHsxBIuR0nxxn37ZkuiwWkH1dIorNiPcfTxAUaytiSKqUcZAiDKmYHCEzP839iAkeqafyE8StgTh9Z9fWww1hm3faeTfLghAWpNT24MynNe
 SJaoOYPCjaEyQBAvZWAoqkq+LuynoGixZK1+3/GPuGk=
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NONE,
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
X-List-Received-Date: Sat, 13 Feb 2021 01:06:09 -0000

This is a multi-part message in MIME format.
--------------2.30.0
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


change notes to see "Implementation Notes" to links to std-notes.html;
links work in html docs but appear as text in info docs;
add link to std-notes.html to getrlimit, setrlimit;
add note to document limitations of getrlimit, setrlimit resources support
---
 winsup/doc/posix.xml | 101 ++++++++++++++++++++++++-------------------
 1 file changed, 57 insertions(+), 44 deletions(-)


--------------2.30.0
Content-Type: text/x-patch; name="0001-winsup-doc-posix.xml-add-note-for-getrlimit-setrlimi.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-winsup-doc-posix.xml-add-note-for-getrlimit-setrlimi.patch"

diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 0669d07de890..71f0373940a5 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -64,7 +64,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     atoi
     atol
     atoll
-    basename			(see chapter "Implementation Notes")
+    basename			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
     bind
     bsearch
     btowc
@@ -126,8 +126,8 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     clock_getcpuclockid
     clock_getres
     clock_gettime
-    clock_nanosleep		(see chapter "Implementation Notes")
-    clock_settime		(see chapter "Implementation Notes")
+    clock_nanosleep		<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
+    clock_settime		<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
     clog
     clogf
     clogl
@@ -242,7 +242,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     fchown
     fchownat
     fclose
-    fcntl			(see chapter "Implementation Notes")
+    fcntl			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
     fdatasync
     fdim
     fdimf
@@ -292,7 +292,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     fopen
     fork
     fpathconf
-    fpclassify			(see chapter "Implementation Notes")
+    fpclassify			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
     fprintf
     fputc
     fputs
@@ -347,7 +347,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     getgroups
     gethostid
     gethostname
-    getitimer			(see chapter "Implementation Notes")
+    getitimer			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
     getline
     getlogin
     getlogin_r
@@ -367,7 +367,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     getpwnam_r
     getpwuid
     getpwuid_r
-    getrlimit
+    getrlimit			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
     getrusage
     gets
     getservbyname
@@ -428,26 +428,26 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     iscntrl_l
     isdigit
     isdigit_l
-    isfinite			(see chapter "Implementation Notes")
+    isfinite			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
     isgraph
     isgraph_l
-    isgreater			(see chapter "Implementation Notes")
-    isgreaterequal		(see chapter "Implementation Notes")
-    isinf			(see chapter "Implementation Notes")
+    isgreater			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
+    isgreaterequal		<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
+    isinf			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
     isless
-    islessequal			(see chapter "Implementation Notes")
-    islessgreater		(see chapter "Implementation Notes")
+    islessequal			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
+    islessgreater		<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
     islower
     islower_l
-    isnan			(see chapter "Implementation Notes")
-    isnormal			(see chapter "Implementation Notes")
+    isnan			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
+    isnormal			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
     isprint
     isprint_l
     ispunct
     ispunct_l
     isspace
     isspace_l
-    isunordered			(see chapter "Implementation Notes")
+    isunordered			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
     isupper
     isupper_l
     iswalnum
@@ -511,7 +511,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     localeconv
     localtime
     localtime_r
-    lockf			(see chapter "Implementation Notes")
+    lockf			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
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
+    msgctl			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
+    msgget			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
+    msgrcv			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
+    msgsnd			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
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
+    semctl			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
+    semget			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
+    semop			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
     send
     sendmsg
     sendto
@@ -847,7 +847,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     setgid
     setgrent
     sethostent
-    setitimer			(see chapter "Implementation Notes")
+    setitimer			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
     setjmp
     setkey			(available in external "crypt" library)
     setlocale
@@ -859,7 +859,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     setpwent
     setregid
     setreuid
-    setrlimit
+    setrlimit			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
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
+    shmat			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
+    shmctl			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
+    shmdt			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
+    shmget			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
     shutdown
     sigaction
     sigaddset
@@ -886,9 +886,9 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     sigismember
     siglongjmp
     signal
-    signbit			(see chapter "Implementation Notes")
+    signbit			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
     signgam
-    sigpause			(see chapter "Implementation Notes")
+    sigpause			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
     sigpending
     sigprocmask
     sigqueue
@@ -937,7 +937,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     strdup
     strerror
     strerror_l
-    strerror_r			(see chapter "Implementation Notes")
+    strerror_r			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
     strfmon
     strfmon_l
     strftime
@@ -1001,7 +1001,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     tgammaf
     tgammal
     time
-    timer_create		(see chapter "Implementation Notes")
+    timer_create		<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
     timer_delete
     timer_getoverrun
     timer_gettime
@@ -1162,7 +1162,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     finitef
     finitel
     fiprintf
-    flock			(see chapter "Implementation Notes")
+    flock			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
     fls
     flsl
     flsll
@@ -1212,7 +1212,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     madvise
     mkstemps
     openpty
-    qsort_r			(see chapter "Implementation Notes")
+    qsort_r			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
     rcmd
     rcmd_af
     reallocarray
@@ -1257,7 +1257,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     valloc
     verr
     verrx
-    vhangup			(see chapter "Implementation Notes")
+    vhangup			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
     vsyslog
     vwarn
     vwarnx
@@ -1291,14 +1291,14 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     asnprintf
     asprintf
     asprintf_r
-    basename			(see chapter "Implementation Notes")
+    basename			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
     canonicalize_file_name
     clearenv
     clog10
     clog10f
     clog10l
     crypt_r			(available in external "crypt" library)
-    dladdr			(see chapter "Implementation Notes")
+    dladdr			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
     dremf
     dup3
     envz_add
@@ -1370,8 +1370,8 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     ptsname_r
     putwc_unlocked
     putwchar_unlocked
-    renameat2			(see chapter "Implementation Notes")
-    qsort_r			(see chapter "Implementation Notes")
+    renameat2			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
+    qsort_r			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
     quotactl
     rawmemchr
     removexattr
@@ -1545,8 +1545,8 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     bcmp			(POSIX.1-2001, SUSv3)
     bcopy			(SUSv3)
     bzero			(SUSv3)
-    chroot			(SUSv2) (see chapter "Implementation Notes")
-    clock_setres		(QNX, VxWorks) (see chapter "Implementation Notes")
+    chroot			(SUSv2)		<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
+    clock_setres		(QNX, VxWorks)	<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
     cuserid			(POSIX.1-1988, SUSv2)
     ecvt			(SUSv3)
     endutent			(XPG2)
@@ -1592,7 +1592,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     ualarm			(SUSv3)
     usleep			(SUSv3)
     utmpname			(XPG2)
-    vfork			(SUSv3) (see chapter "Implementation Notes")
+    vfork			(SUSv3)		<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>
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


