Return-Path: <SRS0=SYvf=UH=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	by sourceware.org (Postfix) with ESMTPS id A3B0538515C4
	for <cygwin-patches@cygwin.com>; Wed, 15 Jan 2025 19:43:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A3B0538515C4
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A3B0538515C4
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736970212; cv=none;
	b=p8yKCBQi7TWZuvIBBRa7Vw2d94UC8aipCqcltd0H7g3iUZxTQ6NPwtTERndzVif5VyyOfp+5+4UFGnsNDvVA8bTNtJUzRdCTpXZWKfkgu+eDlvGzsIl5oH5gjCybvDUSm54UjPQTwVzfKUZ1alHTPGa3Bvd1vTMyp5Jv3aDf/Wo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736970212; c=relaxed/simple;
	bh=ER4aTD+gTbnhHEgpD5du9uPC1xWfa1fD+h8Vjehapmo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=YVT5nHsrYb5vIAEbpbPAMnJgxLQP4RmWBMK7vGFd2TdiJtnK9ZvdNlNhBP+CgKSRyPXaDsVKUi8Gjrs+8v5k13rQi8v0657c+xG2JY/AnI+hqTtUqOEn2KWV4DteufSex8oD5aLkL40yI3yTAO8DkgY4Cd21qaBVu7/1YpTSq8g=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A3B0538515C4
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=ZMWWhe/5
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 36657C01A8;
	Wed, 15 Jan 2025 19:43:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf07.hostedemail.com (Postfix) with ESMTPA id AC1FA20030;
	Wed, 15 Jan 2025 19:43:30 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com (Cygwin Patches)
Subject: [PATCH v6 4/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 move or remove dropped entries
Date: Wed, 15 Jan 2025 12:39:21 -0700
Message-ID: <6da73f73a786a556d4c7be93ed05bc50b268bb30.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
References: <cover.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Organization: Systematic Software
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AC1FA20030
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: topostz8mfnndxxyoerz8wrnz946hcoc
X-Rspamd-Server: rspamout05
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1/hfvj+tdy5EzRegnWBDkQPy9Z/OPD2Ayo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=he; bh=jUKtmU66IQk52ClI2EyeJy2r2PlV6rlVjX1CqiWwH9M=; b=ZMWWhe/5bSfu8dtLRA0VA/Hpc7W891GXT/Yn9C9m7HzW2s5hqoztr1sZ4z2P/u9lILqRES2yujXWfXcoQ5kHME+e6D7RZWFMlolFznjkjyTrFa3n6RBIaPv4tBKn8s/S6pheNHwD72k4SWaycgtoHziFkihSvou4IznNK93MuEEVraXHPY3M880fydw0zG1sTVE8YCyRoXp2GpUZ+kirdzFO8P2GK/hLPzPIrpcBYz8YDNG2MIzYX49fFJlWlKzPHrLXPC5u2HLtcSHgdhRxB8686cnJnqKNuZRE8x5szpTYHQDFleJ6xSFjeHFkQJZ12ibOzrkHZSznPCouwU0Q+w==
X-HE-Tag: 1736970210-57404
X-HE-Meta: U2FsdGVkX1/cD0DnF+6jLDxqpoWG7gBTieo2UXVpc3ahOFCsxzU7rB5jHSXnKPDMDpF3Hyb39n+cIyPWJhJTifMMdQq7ABAL++9RcHSWutBoPGtLxcMBAhvRqB599WsWpFuIvO2eNDy2aaCDr7fuBFnqXRjvhqv8i/hgp7USAJKA9NvMC6DQi03CaxcGW8IOzooTCcG1KZqS3hSzmahNzeK2H30721gq5w3DoQfN3OgPpfxhDM+t+7j9PbNOtqXOwlsMmOD508c5MR31qd68Z+s6h1++22O/62eEh1UT78lN0pW+WmkO7ekMjIOxpWs8/7hxUX3CBbsw4/P7tE5dJTJlHYY2+uzYdX8MTUxyia1z+BVEuMLmYxVrDHz+y1e0rRxMea9yxjYVfOqU85mwoQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Move entries no longer in POSIX from the SUS/POSIX section to
Deprecated Interfaces section and mark with (SUSv4).
Remove entries no longer in POSIX from the NOT Implemented section.

Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 winsup/doc/posix.xml | 64 +++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 33 deletions(-)

diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 89728e050bef..ac05f6972ee7 100644
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
     getentropy			(Cygwin DLL)
     getenv
@@ -411,7 +404,6 @@ ISO/IEC DIS 9945 Information technology
     getgroups
     gethostid
     gethostname
-    getitimer			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     getline
     getlocalename_l		(Cygwin DLL)
     getlogin
@@ -434,7 +426,6 @@ ISO/IEC DIS 9945 Information technology
     getpwuid_r
     getrlimit			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     getrusage
-    gets
     getservbyname
     getservbyport
     getservent
@@ -443,7 +434,6 @@ ISO/IEC DIS 9945 Information technology
     getsockopt
     getsubopt
     gettext			(available in external gettext "libintl" library)
-    gettimeofday
     getuid
     getutxent
     getutxid
@@ -489,12 +479,10 @@ ISO/IEC DIS 9945 Information technology
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
@@ -798,7 +786,6 @@ ISO/IEC DIS 9945 Information technology
     pthread_detach
     pthread_equal
     pthread_exit
-    pthread_getconcurrency
     pthread_getcpuclockid
     pthread_getschedparam
     pthread_getspecific
@@ -844,7 +831,6 @@ ISO/IEC DIS 9945 Information technology
     pthread_self
     pthread_setcancelstate
     pthread_setcanceltype
-    pthread_setconcurrency
     pthread_setschedparam
     pthread_setschedprio
     pthread_setspecific
@@ -872,7 +858,6 @@ ISO/IEC DIS 9945 Information technology
     quick_exit			(ISO C11)
     raise
     rand
-    rand_r
     random
     read
     readdir
@@ -953,13 +938,11 @@ ISO/IEC DIS 9945 Information technology
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
@@ -987,20 +970,14 @@ ISO/IEC DIS 9945 Information technology
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
@@ -1105,7 +1082,6 @@ ISO/IEC DIS 9945 Information technology
     tcsetpgrp
     tdelete
     telldir
-    tempnam
     textdomain			(available in external gettext "libintl" library)
     tfind
     tgamma
@@ -1163,7 +1139,6 @@ ISO/IEC DIS 9945 Information technology
     unlockpt
     unsetenv
     uselocale
-    utime
     utimensat
     utimes
     va_arg
@@ -1558,6 +1533,7 @@ ISO/IEC DIS 9945 Information technology
     fegetprec
     fesetprec
     futimesat
+    getdomainname		(NIS)
     getmntent
     memalign
     setmntent
@@ -1623,9 +1599,14 @@ ISO/IEC DIS 9945 Information technology
 
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
@@ -1636,12 +1617,16 @@ ISO/IEC DIS 9945 Information technology
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
@@ -1649,6 +1634,8 @@ ISO/IEC DIS 9945 Information technology
     getwd			(SUSv3)
     h_errno			(SUSv3)
     index			(SUSv3)
+    ioctl			(SUSv4)
+    isascii			(SUSv4)
     makecontext			(SUSv3)
     mallinfo			(SVID)
     mallopt			(SVID)
@@ -1657,24 +1644,37 @@ ISO/IEC DIS 9945 Information technology
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
@@ -1690,39 +1690,37 @@ ISO/IEC DIS 9945 Information technology
     dgettext_l			(not available in external gettext "libintl" library)
     dngettext_l			(not available in external gettext "libintl" library)
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
     getresgid			(not available in "(sys/)unistd.h" header)
     getresuid			(not available in "(sys/)unistd.h" header)
     gettext_l			(not available in external gettext "libintl" library)
+<<<<<<< HEAD
     isastream
+=======
+    kill_dependency		(not available in "stdatomic.h" header)
+>>>>>>> 5888275d7f48 (Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 move or remove dropped entries)
     mlockall
     munlockall
     ngettext_l			(not available in external gettext "libintl" library)
     posix_close			(not available in "(sys/)unistd.h" header)
     posix_devctl		(prototyped in cygwin-devel "devctl.h" header)
     posix_mem_offset
-    posix_trace[...]
     posix_typed_mem_get_info	(not available in "(sys/)mman.h" header)
     posix_typed_mem_open	(not available in "(sys/)mman.h" header)
     pthread_mutexattr_getrobust
     pthread_mutexattr_setrobust
     pthread_mutex_consistent
-    putmsg
     setnetent
     setresgid			(not available in "(sys/)unistd.h" header)
     setresuid			(not available in "(sys/)unistd.h" header)
     tcgetwinsize		(not available in "(sys/)termios.h" header)
     tcsetwinsize		(not available in "(sys/)termios.h" header)
-    ulimit
     waitid
 </screen>
 
-- 
2.45.1

