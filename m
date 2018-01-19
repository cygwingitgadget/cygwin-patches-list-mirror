Return-Path: <cygwin-patches-return-9007-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 50104 invoked by alias); 19 Jan 2018 06:38:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 50084 invoked by uid 89); 19 Jan 2018 06:38:11 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-26.4 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_NUMSUBJECT,SPF_HELO_PASS,T_RP_MATCHES_RCVD autolearn=ham version=3.3.2 spammy=2.10.0, Improved, para
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 19 Jan 2018 06:38:10 +0000
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 340251112	for <cygwin-patches@cygwin.com>; Fri, 19 Jan 2018 06:38:09 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-72.rdu2.redhat.com [10.10.120.72])	by smtp.corp.redhat.com (Postfix) with ESMTPS id BA97A60C8A	for <cygwin-patches@cygwin.com>; Fri, 19 Jan 2018 06:38:08 +0000 (UTC)
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 4/4] cygwin: update docs for 2.10.0
Date: Fri, 19 Jan 2018 06:38:00 -0000
Message-Id: <20180119063759.2464-1-yselkowi@redhat.com>
In-Reply-To: <20180119055837.13016-1-yselkowi@redhat.com>
References: <20180119055837.13016-1-yselkowi@redhat.com>
X-SW-Source: 2018-q1/txt/msg00015.txt.bz2

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
 winsup/cygwin/release/2.10.0 | 27 +++++++++++++++++++++++++++
 winsup/doc/new-features.xml  | 27 ++++++++++++++++++++++++++-
 winsup/doc/posix.xml         |  6 +++---
 3 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/release/2.10.0 b/winsup/cygwin/release/2.10.0
index 0c6b406a1..01953119a 100644
--- a/winsup/cygwin/release/2.10.0
+++ b/winsup/cygwin/release/2.10.0
@@ -7,12 +7,39 @@ What's new:
 
 - scanf now handles the %l[ conversion.
 
+- Improved hostprogs compatibility for cross-compiling the Linux kernel.
+New headers: <asm/bitsperlong.h>, <asm/posix_types.h>.
+
+- Built-in implementation of Stack Smashing Protection compiler feature.
+New APIs: __stack_chk_fail, __stack_chk_guard.
+
+- Built-in implementation of _FORTIFY_SOURCE guards for functions in 
+<stdio.h>, <stdlib.h>, <string.h>, <strings.h>, <unistd.h>, <wchar.h>,
+<sys/poll.h>, and <sys/socket.h>.
+New APIs:  __chk_fail, __gets_chk, __memcpy_chk, __memmove_chk, __mempcpy_chk,
+__memset_chk, __snprintf_chk, __sprintf_chk, __stpcpy_chk, __stpncpy_chk,
+__strcat_chk, __strcpy_chk, __strncat_chk, __strncpy_chk, __vsnprintf_chk,
+__vsprintf_chk.
+
+- Built-in implementation of POSIX.1-2001 message catalog support.
+New APIs: catclose, catgets, catopen.  New tool: gencat.
+
 - New APIs: sigtimedwait, wmempcpy.
 
 
 What changed:
 -------------
 
+- Standard headers no longer use macros to support K&R C.
+
+- confstr(3) and getconf(1) accept LFS_CFLAGS, LFS_LDFLAGS, etc.
+
+- The __always_inline and __nonnull macros in <sys/cdefs.h> are now
+compatible with glibc.
+
+- Feature Test Macros improvements in <fcntl.h>, <limits.h>, <netdb.h>,
+<strings.h>, and <unistd.h>.
+
 
 Bug Fixes
 ---------
diff --git a/winsup/doc/new-features.xml b/winsup/doc/new-features.xml
index b3d258862..55e45ceee 100644
--- a/winsup/doc/new-features.xml
+++ b/winsup/doc/new-features.xml
@@ -17,7 +17,32 @@ scanf/wscanf now handle the POSIX %m modifier.
 </para></listitem>
 
 <listitem><para>
-- scanf now handles the %l[ conversion.
+scanf now handles the %l[ conversion.
+</para></listitem>
+
+<listitem><para>
+Improved hostprogs compatibility for cross-compiling the Linux kernel.
+New headers: &lt;asm/bitsperlong.h&gt;, &lt;asm/posix_types.h&gt;.
+</para></listitem>
+
+<listitem><para>
+Built-in implementation of Stack Smashing Protection compiler feature.
+New APIs: __stack_chk_fail, __stack_chk_guard.
+</para></listitem>
+
+<listitem><para>
+Built-in implementation of _FORTIFY_SOURCE guards for functions in 
+&lt;stdio.h&gt;, &lt;stdlib.h&gt;, &lt;string.h&gt;, &lt;strings.h&gt;,
+&lt;unistd.h&gt;, &lt;wchar.h&gt;, &lt;sys/poll.h&gt;, and &lt;sys/socket.h&gt;.
+New APIs:  __chk_fail, __gets_chk, __memcpy_chk, __memmove_chk, __mempcpy_chk,
+__memset_chk, __snprintf_chk, __sprintf_chk, __stpcpy_chk, __stpncpy_chk,
+__strcat_chk, __strcpy_chk, __strncat_chk, __strncpy_chk, __vsnprintf_chk,
+__vsprintf_chk.
+</para></listitem>
+
+<listitem><para>
+Built-in implementation of POSIX.1-2001 message catalog support.
+New APIs: catclose, catgets, catopen.  New tool: gencat.
 </para></listitem>
 
 <listitem><para>
diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 2664159e1..8b4bab1b0 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -86,9 +86,9 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     catanhf
     catanhl
     catanl
-    catclose 			(available in external "catgets" library)
-    catgets  			(available in external "catgets" library)
-    catopen  			(available in external "catgets" library)
+    catclose
+    catgets
+    catopen
     cbrt
     cbrtf
     cbrtl
-- 
2.15.1
