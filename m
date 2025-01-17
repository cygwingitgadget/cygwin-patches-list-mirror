Return-Path: <SRS0=IVSM=UJ=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	by sourceware.org (Postfix) with ESMTPS id 06B7E383FB92
	for <cygwin-patches@cygwin.com>; Fri, 17 Jan 2025 17:03:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 06B7E383FB92
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 06B7E383FB92
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737133425; cv=none;
	b=kPc00boNv2eUkA0nYeP/nweXSdrOmIgZQtOeqU5JZXfyvvGidHRmkIkbGYeqAlXythhk+ABEnx9tgWzRzDoHyxhJ07/4pzl/b2dpgivoV4theC09Mr2+/nf/E70EuVR6URJ+6wFYHQ2LzCh+zisbSgJDZQjcQ52OeHVju6VnoV4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737133425; c=relaxed/simple;
	bh=VLo08TsL1RkXXXudFkh2OYXn/rlC6HvMTyuq1rBJqpI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=s2hFi7wRQoyidjIXcyOJvZXpkCWBesVqo7h6uZpKn9iTICBzhPeJlXFoJ2kbOs4BnrQEPC5360TyKARtJyC/SQ+BbVi9SFNG1LEl6cBBcybqYkEHWh1njWjm/VwDd94FjDXQGLO+vJokY4Yjny5zhuj558/FbZuIOgGS6Im5Ra4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 06B7E383FB92
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=dxCInxX9
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 8746045773;
	Fri, 17 Jan 2025 17:03:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf17.hostedemail.com (Postfix) with ESMTPA id 0A5EF19;
	Fri, 17 Jan 2025 17:03:42 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com (Cygwin Patches)
Subject: [PATCH v7 4/5] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 move or remove dropped entries
Date: Fri, 17 Jan 2025 10:01:07 -0700
Message-ID: <7c1df0773801655e35abbfb28c4428df9b4854ee.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
References: <cover.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Organization: Systematic Software
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0A5EF19
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: ug8kd3ddjh4zhsyopxr84pbwxwom7bnk
X-Rspamd-Server: rspamout03
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX18HkLRLEStvlwJaAR3xG+nmrMReSt1v4lY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=he; bh=rrieXoHTYgHoLsifTOdbkLHcY4ky9YdUjYq4w3f9xAo=; b=dxCInxX9+Gv/2vAdOFDIGA5/yClAn/wsHoW0g0KzBBkIE2wFZK9fyNviWAB+Pz9XPyw9/s43w1d8wh/lhopsshDZmvEBrPCrSQxGFXv9pB5OF+ESuQ7u5BkHXNRdFM1VrNxWRI5DOe/4T2Z48EHW6rc1KSayIzqLhYRdxBfbltmUPiLo3di/icuE6qjBOYsR/qw7m0XJusua8jjZRDxo2J60n5On4oaqod310kgpyKhEctx8Tkoo1YWo/cM/cf8ZoKizUe3sMDqOlf7S3q0wRwdTHR77PlCYT9mpigpL7HfpHwPiDzTRGjcAvwDJ9C9DVvQ8JUWRzxlfdoo6MCf11A==
X-HE-Tag: 1737133422-88972
X-HE-Meta: U2FsdGVkX19CrM7gHeU2AwEALKEa7oC12pFwD4pPNCnlm9xYPDcArTuFYlB0oJah5IXa4zyhXlwh0pwoWGmMsF9DAFt+z+KrGI4YstT/jIepthoWOuOIj7u1vSDbi0ruodJVczW5TsaqWY/S0YzW4V75shHtHjMvHJmOE+wimrFzYEBqNL3QyotckgLnu/L8aZDSZbwpWOGplcS41uXP6ub001cLWHG9xnlWFMQZqk3XaFt5oUybxT7x6VgZJuztcBID8BOvrlm0bK3ctSRqWbHZ7kn//V4zYk3Hj1mLV1km23d0BgHY4sk+LO1+D7HaNqWi5nxrk34zHf/OZkpL0ImHDQhZ9Qz8LgPxgn/E3flERGz6JiyAmePxa9IGIO0coeNC5DLO32ytUH6+55s0uw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Move entries no longer in POSIX from the SUS/POSIX section to
Deprecated Interfaces section and mark with (SUSv4).
Remove entries no longer in POSIX from the NOT Implemented section.

Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 winsup/doc/posix.xml | 55 ++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 7e66cb8fc1c0..b0ef2bc37698 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -25,10 +25,6 @@ ISO/IEC DIS 9945 Information technology
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
@@ -73,7 +69,6 @@ ISO/IEC DIS 9945 Information technology
     atanl
     atexit
     atof
-    atoff
     atoi
     atol
     atoll
@@ -382,7 +377,6 @@ ISO/IEC DIS 9945 Information technology
     ftok
     ftruncate
     ftrylockfile
-    ftw
     funlockfile
     futimens
     fwide
@@ -397,7 +391,6 @@ ISO/IEC DIS 9945 Information technology
     getchar_unlocked
     getcwd
     getdelim
-    getdomainname
     getegid
     getentropy
     getenv
@@ -411,7 +404,6 @@ ISO/IEC DIS 9945 Information technology
     getgroups
     gethostid
     gethostname
-    getitimer			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     getline
     getlocalename_l
     getlogin
@@ -434,7 +426,6 @@ ISO/IEC DIS 9945 Information technology
     getpwuid_r
     getrlimit			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     getrusage
-    gets
     getservbyname
     getservbyport
     getservent
@@ -489,12 +480,10 @@ ISO/IEC DIS 9945 Information technology
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
@@ -798,7 +787,6 @@ ISO/IEC DIS 9945 Information technology
     pthread_detach
     pthread_equal
     pthread_exit
-    pthread_getconcurrency
     pthread_getcpuclockid
     pthread_getschedparam
     pthread_getspecific
@@ -844,7 +832,6 @@ ISO/IEC DIS 9945 Information technology
     pthread_self
     pthread_setcancelstate
     pthread_setcanceltype
-    pthread_setconcurrency
     pthread_setschedparam
     pthread_setschedprio
     pthread_setspecific
@@ -872,7 +859,6 @@ ISO/IEC DIS 9945 Information technology
     quick_exit
     raise
     rand
-    rand_r
     random
     read
     readdir
@@ -953,13 +939,11 @@ ISO/IEC DIS 9945 Information technology
     setgid
     setgrent
     sethostent
-    setitimer			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     setjmp
     setkey			(available in external "libcrypt" library)
     setlocale
     setlogmask
     setpgid
-    setpgrp
     setpriority			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     setprotoent
     setpwent
@@ -987,20 +971,14 @@ ISO/IEC DIS 9945 Information technology
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
@@ -1163,7 +1141,6 @@ ISO/IEC DIS 9945 Information technology
     unlockpt
     unsetenv
     uselocale
-    utime
     utimensat
     utimes
     va_arg
@@ -1560,6 +1537,7 @@ ISO/IEC DIS 9945 Information technology
     fegetprec
     fesetprec
     futimesat
+    getdomainname		(NIS)
     getmntent
     memalign
     setmntent
@@ -1625,9 +1603,14 @@ ISO/IEC DIS 9945 Information technology
 
 </sect1>
 
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
@@ -1638,12 +1621,16 @@ ISO/IEC DIS 9945 Information technology
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
@@ -1651,6 +1638,8 @@ ISO/IEC DIS 9945 Information technology
     getwd			(SUSv3)
     h_errno			(SUSv3)
     index			(SUSv3)
+    ioctl			(SUSv4)
+    isascii			(SUSv4)
     makecontext			(SUSv3)
     mallinfo			(SVID)
     mallopt			(SVID)
@@ -1659,24 +1648,37 @@ ISO/IEC DIS 9945 Information technology
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
     vfork			(SUSv3)		(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
 </screen>
@@ -1692,12 +1694,10 @@ ISO/IEC DIS 9945 Information technology
     dgettext_l			
     dngettext_l			
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
@@ -1718,7 +1718,6 @@ ISO/IEC DIS 9945 Information technology
     pthread_mutexattr_getrobust
     pthread_mutexattr_setrobust
     pthread_mutex_consistent
-    putmsg
     setnetent
     setresgid			
     setresuid			
-- 
2.45.1

