Return-Path: <SRS0=8byy=UD=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	by sourceware.org (Postfix) with ESMTPS id 10B48385843B
	for <cygwin-patches@cygwin.com>; Sat, 11 Jan 2025 00:03:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 10B48385843B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 10B48385843B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736553799; cv=none;
	b=xs7wJ3k52cQZMhsal5/82lvRMgR0Yhpq3Xa6VrLfAMIYaDO45rmd4lWtIwXq5pX1JQla2SqdVCizz3/Ooz7ZYkC71JR4wgJButEKMH3xc41TeiKWvnmTEE/r2R+lHN1rqMouMZfAVen+aNhxSAiq/kOT0AaXlOtC0y1LPq8VWoQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736553799; c=relaxed/simple;
	bh=avD/ieBMPpSrzKKtklK3n7+1288M71TMO1Qm/OxUJM0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=c69hMl/Cg1oCIMUrrLXy7C+SjwleqrTYd7xDnjGo2USpyfak2PLS9Dzd87kCd/a5DFAT3g4im5Xz9c48jPn4+tTr1qSKKG+DhDQTwRwVoC0zFrC63zGXYmGxiUTxbnRTlhpZn78/OuhFmftGB8kYWJwqW1BhX7vsH8Bwm532GbQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 10B48385843B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=HRQ/z9FS
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 99072C0F80;
	Sat, 11 Jan 2025 00:03:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf09.hostedemail.com (Postfix) with ESMTPA id 3428320028;
	Sat, 11 Jan 2025 00:03:17 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH v5 4/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 move or remove dropped entries
Date: Fri, 10 Jan 2025 17:01:05 -0700
Message-ID: <5888275d7f48a4418cded1b292b8951506240073.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Organization: Systematic Software
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Stat-Signature: 3aw1ti3smfyu7rn9oo49bzr8urnbafaj
X-Rspamd-Server: rspamout04
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: 3428320028
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1/XPpIdMk+gt2agLD90vDPMNkqMrgeiRe0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=he; bh=JS1HZx7cFWVbfo2ptl89Ix+6bQIVHRjdoFiIB4cxd0E=; b=HRQ/z9FSi6mgk1KC7IoQaPhjXmBlqiNrEyCLcFgRxEO0fdtL+I2u7clTIdAIhYfcpNW3PYK6Y+Cx9AAwz2gKtSgh1NlkNfWT2D9Ee5tfROp1ry4zfz5Del6Yxj1P74BolH64s/Y41Ae3tSCjEnxshkXCAL/IMe41njs68dH+OZT5zo1WiXHOB/k/VFZhLoNgqA3WdZtOHIeIX95KKs29QpxLFOsEUyRZ0qYS1qcaP3oQhDUJXrImbN9lGTuXFv8GyAUqvhKi280s4+3h3uk+TJJMjRyDMki2ZYEVP/Wg5Nmp9RlAzudOt4fqBRZmeblC5aDBF+0bMGNhFCOwy15eVQ==
X-HE-Tag: 1736553797-42883
X-HE-Meta: U2FsdGVkX1+4OTgx+MdQb+Km0fm8m4/93LWP3vRlEmpM88CEdFYNj+bwGJzRk7BQ0iXQA9cCu9Q8HQ+cu1ui2PET6hR+KzRgwdaZTOPUBdpa80X5hqi4tdRSwuyRw1e+3dt2nfnYqX0Y7LbBBL4AuzO9hNHD0j3r40tsMcYw1Ioy0fQNclGTxSubG91GUxrYNOsli2nytY72WnscxY0ZstQRTpDNrij75gLR3I8s35B+DZmT+ADmPWWnpLDK9eN4HfwtGeAdXRkSWX38wE2YCZtjEzkNLDpreGJHlYFT9FbI7j2hZNDAPzgMql1XpRSETmeDDy9o7AZOrgaPq3LWhyT4aw6uIUactZl/RHtydY3teAx/S6Hi8qQhjJnPgn2NLZuaDr/ne1HEr57V73L+Ig==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Move entries no longer in POSIX from the SUS/POSIX section to
Deprecated Interfaces section and mark with (SUSv4).
Remove entries no longer in POSIX from the NOT Implemented section.

Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 winsup/doc/posix.xml | 61 ++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 34 deletions(-)

diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 2e14861802bf..9b74bcf5a79b 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -23,10 +23,6 @@ ISO/IEC DIS 9945 Information technology
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
@@ -71,7 +67,6 @@ ISO/IEC DIS 9945 Information technology
     atanl
     atexit
     atof
-    atoff
     atoi
     atol
     atoll
@@ -380,7 +375,6 @@ ISO/IEC DIS 9945 Information technology
     ftok
     ftruncate
     ftrylockfile
-    ftw
     funlockfile
     futimens
     fwide
@@ -395,7 +389,6 @@ ISO/IEC DIS 9945 Information technology
     getchar_unlocked
     getcwd
     getdelim
-    getdomainname
     getegid
     getentropy			(din)
     getenv
@@ -409,7 +402,6 @@ ISO/IEC DIS 9945 Information technology
     getgroups
     gethostid
     gethostname
-    getitimer			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     getline
     getlocalename_l		(din)
     getlogin
@@ -432,7 +424,6 @@ ISO/IEC DIS 9945 Information technology
     getpwuid_r
     getrlimit			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     getrusage
-    gets
     getservbyname
     getservbyport
     getservent
@@ -441,7 +432,6 @@ ISO/IEC DIS 9945 Information technology
     getsockopt
     getsubopt
     gettext			(available in external gettext "libintl" library)
-    gettimeofday
     getuid
     getutxent
     getutxid
@@ -487,12 +477,10 @@ ISO/IEC DIS 9945 Information technology
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
@@ -795,7 +783,6 @@ ISO/IEC DIS 9945 Information technology
     pthread_detach
     pthread_equal
     pthread_exit
-    pthread_getconcurrency
     pthread_getcpuclockid
     pthread_getschedparam
     pthread_getspecific
@@ -841,7 +828,6 @@ ISO/IEC DIS 9945 Information technology
     pthread_self
     pthread_setcancelstate
     pthread_setcanceltype
-    pthread_setconcurrency
     pthread_setschedparam
     pthread_setschedprio
     pthread_setspecific
@@ -869,7 +855,6 @@ ISO/IEC DIS 9945 Information technology
     quick_exit			(ISO C11)
     raise
     rand
-    rand_r
     random
     read
     readdir
@@ -950,13 +935,11 @@ ISO/IEC DIS 9945 Information technology
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
@@ -984,20 +967,14 @@ ISO/IEC DIS 9945 Information technology
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
@@ -1102,7 +1079,6 @@ ISO/IEC DIS 9945 Information technology
     tcsetpgrp
     tdelete
     telldir
-    tempnam
     textdomain			(available in external gettext "libintl" library)
     tfind
     tgamma
@@ -1160,7 +1136,6 @@ ISO/IEC DIS 9945 Information technology
     unlockpt
     unsetenv
     uselocale
-    utime
     utimensat
     utimes
     va_arg
@@ -1555,6 +1530,7 @@ ISO/IEC DIS 9945 Information technology
     fegetprec
     fesetprec
     futimesat
+    getdomainname		(NIS)
     getmntent
     memalign
     setmntent
@@ -1620,9 +1596,14 @@ ISO/IEC DIS 9945 Information technology
 
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
@@ -1633,12 +1614,16 @@ ISO/IEC DIS 9945 Information technology
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
@@ -1646,6 +1631,8 @@ ISO/IEC DIS 9945 Information technology
     getwd			(SUSv3)
     h_errno			(SUSv3)
     index			(SUSv3)
+    ioctl			(SUSv4)
+    isascii			(SUSv4)
     makecontext			(SUSv3)
     mallinfo			(SVID)
     mallopt			(SVID)
@@ -1654,24 +1641,37 @@ ISO/IEC DIS 9945 Information technology
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
@@ -1690,20 +1690,16 @@ ISO/IEC DIS 9945 Information technology
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
-    isastream
     kill_dependency		(not available in "stdatomic.h" header)
     mlockall
     munlockall
@@ -1711,19 +1707,16 @@ ISO/IEC DIS 9945 Information technology
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

