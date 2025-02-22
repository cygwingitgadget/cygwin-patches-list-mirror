Return-Path: <SRS0=Yd2F=VN=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	by sourceware.org (Postfix) with ESMTPS id 4D6B63858D38
	for <cygwin-patches@cygwin.com>; Sat, 22 Feb 2025 17:49:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4D6B63858D38
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4D6B63858D38
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1740246546; cv=none;
	b=wih2Hzfp6Xl7ulhAAK1jB0z5bhwyLR/IGt85ai4Z+lhvZUnMFgm4iAdKuhTn+wLbO4GEo20YbPNZ3Vl6sIc2TV/FRZxCbCovLS0aDUE/Unm1NxBNqmZN+N8mzyE975C+mAgTY9gMAHSi+/DKW5cp7/bpGJL+R8dnX2NlSz2/mbQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1740246546; c=relaxed/simple;
	bh=29cmFVBN+gw1ePkT8ZgSA1Vkz0tPvyfHtI6EFSafGuo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=nfKLoE53g713n885Gdw5obd/mbMJiDBc04mz8mBLFdw6JjNiuDMYM/QBM+rV0mxecjiFyFTBHnpL2CetOzsxkDn4ElynuzD7fC0PiqSPAMmNTIP39g+kGXvoMRpn+9DndWnWsIiZpaT3SifMPw1kbfZqWIGyGIomz1vT0R9fOk0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4D6B63858D38
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=gGyaWUla
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id E49B8518BC;
	Sat, 22 Feb 2025 17:49:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf16.hostedemail.com (Postfix) with ESMTPA id 7539320020;
	Sat, 22 Feb 2025 17:49:04 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com (Cygwin Patches)
Subject: [PATCH v8 4/5] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 move or remove dropped entries
Date: Sat, 22 Feb 2025 10:48:21 -0700
Message-ID: <5feb25936c067c823d88087dd0767c958da22cf4.1740246116.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1740246116.git.Brian.Inglis@SystematicSW.ab.ca>
References: <cover.1740246116.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Organization: Systematic Software
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7539320020
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: agffyaeizyecugfm9ozi4oibiy1ipgey
X-Rspamd-Server: rspamout05
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX18idSp5J/ojBsketh2/4pFR9lbc2lu7e/8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=he; bh=2r1fcwvYAqCJiXtywmZO3mEa0gXoQCkDM5CWFRXdjIo=; b=gGyaWUlazdeRnfX056JAIsTozaonhf4b1BH8G4HsMjFfze4fuiso9Re8PJCq43tuv0+hGLJNRSM4hwpP9a4EITQeDE/DRpB5zDalXAA8Lzu3S/DUUXTZQZcrVus1A3zH1Y/gEHohQrVvNIGlvyhoQmCEOZ7n0MyKOnQEXm5KNLFwFCWwiry2HIX24HT5CEUwo/ld5EbIu4UAoVMkP13hca7tS9RUuogY574qhzu9s99+mVD/OuANb8bAqBuezo23u3OmnOqy9gz6FdEopcZCmSsXSWw5NKzW0wi/WlrLR25uxk2RnjMUSfdiMtJtNAYXyP7B8vo2qigtaHYkNXjJZw==
X-HE-Tag: 1740246544-407323
X-HE-Meta: U2FsdGVkX18pTbWSNffBn+Vr9elOokl9mGLRzPj4yZhE9DBbudndE7x00eRsRaU2c0GLxZR7Cvl31oDJ5Jl4xYABEUI4uDC1W2hnmEAnQf1YmKTtyqTqqYigz8wELBWQhSt9We9IT/4SxRc0IbKE8lS8/b3xgM6gmX+7h+k7k3rNzgCWpkQ2WToAdaFeeIxpBdsZjdHqyAvGD3fKsjyEdWGLEgETDRVtN87cvYTXshfQ7OzyVfxOINTcuk/0kRfKFFOMwWZorKpJG2j27k0R2OETyP1X6T1LdZ7pY5Gflhi2v/ztiijr/V07EmPwQz9ald+LK9RYVfoq2V84JrMdgQ9+6fISkxr7mvQOa/WDvvKX+9Z5nXGF2+HbE0kLKUO8IaHWnuhUcCzYrGEU77vSzA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Move entries no longer in POSIX from the SUS/POSIX section to
Deprecated Interfaces section and mark with (SUSv4).
Remove entries no longer in POSIX from the NOT Implemented section.

Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 winsup/doc/posix.xml | 70 ++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 39 deletions(-)

diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 20d73120f5d6..27c6593b2c44 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -25,10 +25,6 @@ ISO®/IEC DIS 9945 Information technology
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
@@ -73,7 +69,6 @@ ISO®/IEC DIS 9945 Information technology
     atanl
     atexit
     atof
-    atoff
     atoi
     atol
     atoll
@@ -382,7 +377,6 @@ ISO®/IEC DIS 9945 Information technology
     ftok
     ftruncate
     ftrylockfile
-    ftw
     funlockfile
     futimens
     fwide
@@ -397,7 +391,6 @@ ISO®/IEC DIS 9945 Information technology
     getchar_unlocked
     getcwd
     getdelim
-    getdomainname
     getegid
     getentropy
     getenv
@@ -411,7 +404,6 @@ ISO®/IEC DIS 9945 Information technology
     getgroups
     gethostid
     gethostname
-    getitimer			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     getline
     getlocalename_l
     getlogin
@@ -434,7 +426,6 @@ ISO®/IEC DIS 9945 Information technology
     getpwuid_r
     getrlimit			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     getrusage
-    gets
     getservbyname
     getservbyport
     getservent
@@ -443,7 +434,6 @@ ISO®/IEC DIS 9945 Information technology
     getsockopt
     getsubopt
     gettext			(available in external "libintl" library)
-    gettimeofday
     getuid
     getutxent
     getutxid
@@ -489,12 +479,10 @@ ISO®/IEC DIS 9945 Information technology
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
@@ -799,7 +787,6 @@ ISO®/IEC DIS 9945 Information technology
     pthread_detach
     pthread_equal
     pthread_exit
-    pthread_getconcurrency
     pthread_getcpuclockid
     pthread_getschedparam
     pthread_getspecific
@@ -845,7 +832,6 @@ ISO®/IEC DIS 9945 Information technology
     pthread_self
     pthread_setcancelstate
     pthread_setcanceltype
-    pthread_setconcurrency
     pthread_setschedparam
     pthread_setschedprio
     pthread_setspecific
@@ -873,7 +859,6 @@ ISO®/IEC DIS 9945 Information technology
     quick_exit
     raise
     rand
-    rand_r
     random
     read
     readdir
@@ -954,13 +939,11 @@ ISO®/IEC DIS 9945 Information technology
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
@@ -988,20 +971,14 @@ ISO®/IEC DIS 9945 Information technology
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
@@ -1108,7 +1085,6 @@ ISO®/IEC DIS 9945 Information technology
     tcsetwinsize
     tdelete
     telldir
-    tempnam
     textdomain			(available in external "libintl" library)
     tfind
     tgamma
@@ -1166,7 +1142,6 @@ ISO®/IEC DIS 9945 Information technology
     unlockpt
     unsetenv
     uselocale
-    utime
     utimensat
     utimes
     va_arg
@@ -1318,6 +1293,7 @@ ISO®/IEC DIS 9945 Information technology
     gamma_r
     gammaf
     gammaf_r
+    getdomainname
     getdtablesize
     getgrouplist
     getifaddrs
@@ -1488,10 +1464,10 @@ ISO®/IEC DIS 9945 Information technology
     pthread_tryjoin_np
     putwc_unlocked
     putwchar_unlocked
-    renameat2			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     quotactl
     rawmemchr
     removexattr
+    renameat2			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     scandirat
     sched_getaffinity
     sched_getcpu
@@ -1513,11 +1489,11 @@ ISO®/IEC DIS 9945 Information technology
     strverscmp
     sysinfo
     tdestroy
+    timegm
+    timelocal
     timerfd_create
     timerfd_gettime
     timerfd_settime
-    timegm
-    timelocal
     toascii_l
     updwtmpx
     utmpxname
@@ -1549,6 +1525,8 @@ ISO®/IEC DIS 9945 Information technology
     __fsetlocking
     __fwritable
     __fwriting
+    __xdrrec_getrec		(available in external "libtirpc" library)
+    __xdrrec_setnonblock	(available in external "libtirpc" library)
     acl
     aclcheck
     aclfrommode
@@ -1612,8 +1590,6 @@ ISO®/IEC DIS 9945 Information technology
     xdrrec_endofrecord		(available in external "libtirpc" library)
     xdrrec_eof			(available in external "libtirpc" library)
     xdrrec_skiprecord		(available in external "libtirpc" library)
-    __xdrrec_getrec		(available in external "libtirpc" library)
-    __xdrrec_setnonblock	(available in external "libtirpc" library)
     xdrstdio_create		(available in external "libtirpc" library)
 </screen>
 
@@ -1631,6 +1607,11 @@ ISO®/IEC DIS 9945 Information technology
 <sect1 id="std-deprec"><title>Other UNIX system interfaces, not in POSIX.1-2008 or deprecated:</title>
 
 <screen>
+    _longjmp			(SUSv4)
+    _setjmp			(SUSv4)
+    _tolower			(SUSv4)
+    _toupper			(SUSv4)
+    atoff			(AIX)
     bcmp			(POSIX.1-2001, SUSv3)
     bcopy			(SUSv3)
     bzero			(SUSv3)
@@ -1641,12 +1622,16 @@ ISO®/IEC DIS 9945 Information technology
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
@@ -1654,6 +1639,8 @@ ISO®/IEC DIS 9945 Information technology
     getwd			(SUSv3)
     h_errno			(SUSv3)
     index			(SUSv3)
+    ioctl			(SUSv4)
+    isascii			(SUSv4)
     makecontext			(SUSv3)
     mallinfo			(SVID)
     mallopt			(SVID)
@@ -1662,24 +1649,37 @@ ISO®/IEC DIS 9945 Information technology
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
@@ -1695,37 +1695,29 @@ ISO®/IEC DIS 9945 Information technology
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
-    getpmsg
     getresgid
     getresuid
     gettext_l
-    isastream
     mlockall
     munlockall
     ngettext_l
     posix_close
     posix_mem_offset
-    posix_trace[...]
-    posix_typed_[...]
     posix_typed_mem_get_info
     posix_typed_mem_open
     pthread_mutex_consistent
     pthread_mutexattr_getrobust
     pthread_mutexattr_setrobust
-    putmsg
     setnetent
     setresgid
     setresuid
-    ulimit
     waitid
 </screen>
 
-- 
2.45.1

