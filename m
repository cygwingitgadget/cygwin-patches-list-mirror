Return-Path: <cygwin-patches-return-8783-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 44865 invoked by alias); 14 Jun 2017 15:45:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 35123 invoked by uid 89); 14 Jun 2017 15:45:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,SPF_HELO_PASS,T_RP_MATCHES_RCVD autolearn=ham version=3.3.2 spammy=
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 14 Jun 2017 15:45:18 +0000
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 129543345A4;	Wed, 14 Jun 2017 15:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 129543345A4
Authentication-Results: ext-mx05.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx05.extmail.prod.ext.phx2.redhat.com; spf=pass smtp.mailfrom=yselkowi@redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.redhat.com 129543345A4
Received: from localhost.localdomain (ovpn-120-133.rdu2.redhat.com [10.10.120.133])	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B2CB8ED34;	Wed, 14 Jun 2017 15:45:14 +0000 (UTC)
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Cc: newlib@sourceware.org
Subject: [PATCH] Export XSI sigpause
Date: Wed, 14 Jun 2017 15:45:00 -0000
Message-Id: <20170614154501.2508-1-yselkowi@redhat.com>
X-SW-Source: 2017-q2/txt/msg00054.txt.bz2

There are two common sigpause variants, both of which take an int argument.
If you request _XOPEN_SOURCE or _GNU_SOURCE, you get the System V version,
which removes the given signal from the process's signal mask; otherwise
you get the BSD version, which sets the process's signal mask to the given
value.

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
 newlib/libc/include/sys/signal.h       | 14 +++++++++++++-
 winsup/cygwin/common.din               |  1 +
 winsup/cygwin/include/cygwin/version.h |  3 ++-
 winsup/cygwin/signal.cc                | 12 ++++++++++++
 winsup/doc/posix.xml                   | 10 ++++++++--
 5 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/newlib/libc/include/sys/signal.h b/newlib/libc/include/sys/signal.h
index a56f18a1b..da064cd5f 100644
--- a/newlib/libc/include/sys/signal.h
+++ b/newlib/libc/include/sys/signal.h
@@ -200,7 +200,19 @@ int _EXFUN(sigwait, (const sigset_t *set, int *sig));
 #endif /* !__CYGWIN__ && !__rtems__ */
 #endif /* __POSIX_VISIBLE */
 
-#if __BSD_VISIBLE
+/* There are two common sigpause variants, both of which take an int argument.
+   If you request _XOPEN_SOURCE or _GNU_SOURCE, you get the System V version,
+   which removes the given signal from the process's signal mask; otherwise
+   you get the BSD version, which sets the process's signal mask to the given
+   value. */
+#if __XSI_VISIBLE && !defined(__INSIDE_CYGWIN__)
+# ifdef __GNUC__
+int _EXFUN(sigpause, (int)) __asm__ (__ASMNAME ("__xpg_sigpause"));
+# else
+int _EXFUN(__xpg_sigpause, (int));
+#  define sigpause __xpg_sigpause
+# endif
+#elif __BSD_VISIBLE
 int _EXFUN(sigpause, (int));
 #endif
 
diff --git a/winsup/cygwin/common.din b/winsup/cygwin/common.din
index 6620700c2..75fe05c1f 100644
--- a/winsup/cygwin/common.din
+++ b/winsup/cygwin/common.din
@@ -102,6 +102,7 @@ __wrap__ZdlPv NOSIGFE               # void operator delete(void *p) throw()
 __wrap__ZdlPvRKSt9nothrow_t NOSIGFE # void operator delete(void *p, const std::nothrow_t &nt) throw()
 __xdrrec_getrec SIGFE
 __xdrrec_setnonblock SIGFE
+__xpg_sigpause SIGFE
 __xpg_strerror_r SIGFE
 _exit SIGFE
 _feinitialise NOSIGFE
diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
index 7baca6158..c0254a8e0 100644
--- a/winsup/cygwin/include/cygwin/version.h
+++ b/winsup/cygwin/include/cygwin/version.h
@@ -475,12 +475,13 @@ details. */
   308: Export dladdr.
   309: Export getloadavg.
   310: Export reallocarray.
+  311: Export __xpg_sigpause.
 
   Note that we forgot to bump the api for ualarm, strtoll, strtoull,
   sigaltstack, sethostname. */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 310
+#define CYGWIN_VERSION_API_MINOR 311
 
 /* There is also a compatibity version number associated with the shared memory
    regions.  It is incremented when incompatible changes are made to the shared
diff --git a/winsup/cygwin/signal.cc b/winsup/cygwin/signal.cc
index f371a231b..fbd2b241e 100644
--- a/winsup/cygwin/signal.cc
+++ b/winsup/cygwin/signal.cc
@@ -524,6 +524,18 @@ sigpause (int signal_mask)
 }
 
 extern "C" int
+__xpg_sigpause (int sig)
+{
+  int res;
+  sigset_t signal_mask;
+  sigprocmask (0, NULL, &signal_mask);
+  sigdelset (&signal_mask, sig);
+  res = handle_sigsuspend (signal_mask);
+  syscall_printf ("%R = __xpg_sigpause(%y)", res, sig);
+  return res;
+}
+
+extern "C" int
 pause (void)
 {
   int res = handle_sigsuspend (_my_tls.sigmask);
diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 5c9f65637..ced7e383d 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -877,7 +877,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     signal
     signbit			(see chapter "Implementation Notes")
     signgam
-    sigpause
+    sigpause			(see chapter "Implementation Notes")
     sigpending
     sigprocmask
     sigqueue
@@ -925,7 +925,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     strdup
     strerror
     strerror_l
-    strerror_r
+    strerror_r			(see chapter "Implementation Notes")
     strfmon
     strfmon_l
     strftime
@@ -1668,6 +1668,12 @@ depending on whether _BSD_SOURCE or _GNU_SOURCE is defined when compiling.</para
 <para><function>basename</function> is available in both POSIX and GNU flavors,
 depending on whether libgen.h is included or not.</para>
 
+<para><function>sigpause</function> is available in both BSD and SysV/XSI
+flavors, depending on whether _XOPEN_SOURCE is defined when compiling.</para>
+
+<para><function>strerror_r</function> is available in both POSIX and GNU
+flavors, depending on whether _GNU_SOURCE is defined when compiling.</para>
+
 <para><function>dladdr</function> always sets the Dl_info members dli_sname and
 dli_saddr to NULL, indicating no symbol matching addr could be found.</para>
 
-- 
2.12.3
