Return-Path: <cygwin-patches-return-9040-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 73746 invoked by alias); 29 Mar 2018 05:31:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 72837 invoked by uid 89); 29 Mar 2018 05:31:23 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-23.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,KAM_NUMSUBJECT autolearn=ham version=3.3.2 spammy=listen, bump, UD:xml, Volume
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 29 Mar 2018 05:31:19 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id w2T5VHoj090412;	Wed, 28 Mar 2018 22:31:17 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 76-217-5-154.lightspeed.irvnca.sbcglobal.net(76.217.5.154), claiming to be "localhost.localdomain" via SMTP by m0.truegem.net, id smtpdI5XClB; Wed Mar 28 21:31:09 2018
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH] Posix asynchronous I/O support, part 1
Date: Thu, 29 Mar 2018 05:31:00 -0000
Message-Id: <20180329053050.6696-1-mark@maxrnd.com>
X-IsSubscribed: yes
X-SW-Source: 2018-q1/txt/msg00048.txt.bz2

---
 winsup/cygwin/Makefile.in              |  1 +
 winsup/cygwin/common.din               |  8 ++++++++
 winsup/cygwin/include/cygwin/version.h |  4 +++-
 winsup/cygwin/include/limits.h         | 12 ++++++------
 winsup/doc/posix.xml                   | 16 ++++++++--------
 5 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
index 32f8025cc..966460da8 100644
--- a/winsup/cygwin/Makefile.in
+++ b/winsup/cygwin/Makefile.in
@@ -249,6 +249,7 @@ MATH_OFILES:= \
 
 DLL_OFILES:= \
 	advapi32.o \
+	aio.o \
 	arc4random_stir.o \
 	assert.o \
 	autoload.o \
diff --git a/winsup/cygwin/common.din b/winsup/cygwin/common.din
index 6e8bf9185..77cf669f7 100644
--- a/winsup/cygwin/common.din
+++ b/winsup/cygwin/common.din
@@ -193,6 +193,13 @@ acosh NOSIGFE
 acoshf NOSIGFE
 acoshl NOSIGFE
 acosl NOSIGFE
+aio_cancel SIGFE
+aio_error SIGFE
+aio_fsync SIGFE
+aio_read SIGFE
+aio_return SIGFE
+aio_suspend SIGFE
+aio_write SIGFE
 alarm SIGFE
 aligned_alloc SIGFE
 alphasort NOSIGFE
@@ -840,6 +847,7 @@ lgammal_r NOSIGFE
 lgetxattr SIGFE
 link SIGFE
 linkat SIGFE
+lio_listio SIGFE
 listen = cygwin_listen SIGFE
 listxattr SIGFE
 llabs NOSIGFE
diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
index f08707eea..b46297a66 100644
--- a/winsup/cygwin/include/cygwin/version.h
+++ b/winsup/cygwin/include/cygwin/version.h
@@ -494,12 +494,14 @@ details. */
   323: scanf %l[ conversion.
   324: Export sigtimedwait.
   325: Export catclose, catgets, catopen.
+  326: Export aio_cancel, aio_error, aio_fsync, aio_read, aio_return,
+       aio_suspend, aio_write, lio_listio.
 
   Note that we forgot to bump the api for ualarm, strtoll, strtoull,
   sigaltstack, sethostname. */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 325
+#define CYGWIN_VERSION_API_MINOR 326
 
 /* There is also a compatibity version number associated with the shared memory
    regions.  It is incremented when incompatible changes are made to the shared
diff --git a/winsup/cygwin/include/limits.h b/winsup/cygwin/include/limits.h
index fe1b8b493..b52ca11f2 100644
--- a/winsup/cygwin/include/limits.h
+++ b/winsup/cygwin/include/limits.h
@@ -147,7 +147,7 @@ details. */
 
 /* Runtime Invariant Values */
 
-/* Please note that symbolic names shall be ommited, on specific
+/* Please note that symbolic names shall be omitted, on specific
    implementations where the corresponding value is equal to or greater
    than the stated minimum, but is unspecified.  This indetermination
    might depend on the amount of available memory space on a specific
@@ -155,17 +155,17 @@ details. */
    a specific instance shall be provided by the sysconf() function. */
 
 /* Maximum number of I/O operations in a single list I/O call supported by
-   the implementation.  Not yet implemented. */
-#undef AIO_LISTIO_MAX
+   the implementation. */
+#define AIO_LISTIO_MAX 32
 /* #define AIO_LISTIO_MAX >= _POSIX_AIO_LISTIO_MAX */
 
 /* Maximum number of outstanding asynchronous I/O operations supported by
-   the implementation.  Not yet implemented. */
-#undef AIO_MAX
+   the implementation. */
+#define AIO_MAX 8
 /*  #define AIO_MAX >= _POSIX_AIO_MAX */
 
 /* The maximum amount by which a process can decrease its asynchronous I/O
-   priority level from its own scheduling priority. */
+   priority level from its own scheduling priority. Not yet implemented. */
 #undef AIO_PRIO_DELTA_MAX
 /* #define AIO_PRIO_DELTA_MAX >= 0 */
 
diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 8b4bab1b0..18f143945 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -32,6 +32,13 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     acoshf
     acoshl
     acosl
+    aio_cancel
+    aio_error
+    aio_fsync
+    aio_read
+    aio_return
+    aio_suspend
+    aio_write
     alarm
     alphasort
     asctime
@@ -491,6 +498,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     lgammal
     link
     linkat
+    lio_listio
     listen
     llabs
     lldiv
@@ -1553,13 +1561,6 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
 <sect1 id="std-notimpl"><title>NOT implemented system interfaces from the Single Unix Specification, Volume 4:</title>
 
 <screen>
-    aio_cancel
-    aio_error
-    aio_fsync
-    aio_read
-    aio_return
-    aio_suspend
-    aio_write
     endnetent
     fattach
     fmtmsg
@@ -1572,7 +1573,6 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     getnetent
     getpmsg
     isastream
-    lio_listio
     mlockall
     munlockall
     posix_mem_offset
-- 
2.16.2
