Return-Path: <cygwin-patches-return-9117-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 52185 invoked by alias); 15 Jul 2018 08:20:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 52052 invoked by uid 89); 15 Jul 2018 08:20:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-23.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY autolearn=ham version=3.3.2 spammy=Single, ioctl, volume, aio
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 15 Jul 2018 08:20:52 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id w6F8KoQJ071068;	Sun, 15 Jul 2018 01:20:50 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 76-217-5-154.lightspeed.irvnca.sbcglobal.net(76.217.5.154), claiming to be "localhost.localdomain" via SMTP by m0.truegem.net, id smtpdUW99kg; Sun Jul 15 01:20:45 2018
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH v3 3/3] POSIX Asynchronous I/O support: other files
Date: Sun, 15 Jul 2018 08:20:00 -0000
Message-Id: <20180715082025.4920-4-mark@maxrnd.com>
In-Reply-To: <20180715082025.4920-1-mark@maxrnd.com>
References: <20180715082025.4920-1-mark@maxrnd.com>
X-IsSubscribed: yes
X-SW-Source: 2018-q3/txt/msg00013.txt.bz2

Updates to misc files to integrate AIO into the Cygwin source tree.
Much of it has to be done when adding any new syscalls.  There are
some updates to limits.h for AIO-specific limits.  And some doc mods.
---
 winsup/cygwin/Makefile.in              |  1 +
 winsup/cygwin/common.din               |  8 ++++++++
 winsup/cygwin/include/cygwin/version.h |  6 ++++--
 winsup/cygwin/include/limits.h         | 17 +++++++----------
 winsup/cygwin/sysconf.cc               |  6 +++---
 winsup/cygwin/thread.cc                |  4 ++--
 winsup/doc/new-features.xml            |  6 ++++++
 winsup/doc/posix.xml                   | 16 ++++++++--------
 winsup/utils/strace.cc                 |  2 +-
 9 files changed, 40 insertions(+), 26 deletions(-)

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
index 1e971cf92..e7ad14a05 100644
--- a/winsup/cygwin/common.din
+++ b/winsup/cygwin/common.din
@@ -193,6 +193,13 @@ acosh NOSIGFE
 acoshf NOSIGFE
 acoshl NOSIGFE
 acosl NOSIGFE
+aio_cancel SIGFE
+aio_error NOSIGFE
+aio_fsync SIGFE
+aio_read SIGFE
+aio_return NOSIGFE
+aio_suspend SIGFE
+aio_write SIGFE
 alarm SIGFE
 aligned_alloc SIGFE
 alphasort NOSIGFE
@@ -841,6 +848,7 @@ lgammal_r NOSIGFE
 lgetxattr SIGFE
 link SIGFE
 linkat SIGFE
+lio_listio SIGFE
 listen = cygwin_listen SIGFE
 listxattr SIGFE
 llabs NOSIGFE
diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
index b461fa9c7..5140dd19d 100644
--- a/winsup/cygwin/include/cygwin/version.h
+++ b/winsup/cygwin/include/cygwin/version.h
@@ -494,14 +494,16 @@ details. */
   323: scanf %l[ conversion.
   324: Export sigtimedwait.
   325: Export catclose, catgets, catopen.
-  326: Export clearenv
+  326: Export clearenv.
   327: Export pthread_tryjoin_np, pthread_timedjoin_np.
+  328: Export aio_cancel, aio_error, aio_fsync, aio_read, aio_return,
+       aio_suspend, aio_write, lio_listio.
 
   Note that we forgot to bump the api for ualarm, strtoll, strtoull,
   sigaltstack, sethostname. */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 327
+#define CYGWIN_VERSION_API_MINOR 328
 
 /* There is also a compatibity version number associated with the shared memory
    regions.  It is incremented when incompatible changes are made to the shared
diff --git a/winsup/cygwin/include/limits.h b/winsup/cygwin/include/limits.h
index fe1b8b493..3550c4fcb 100644
--- a/winsup/cygwin/include/limits.h
+++ b/winsup/cygwin/include/limits.h
@@ -147,7 +147,7 @@ details. */
 
 /* Runtime Invariant Values */
 
-/* Please note that symbolic names shall be ommited, on specific
+/* Please note that symbolic names shall be omitted, on specific
    implementations where the corresponding value is equal to or greater
    than the stated minimum, but is unspecified.  This indetermination
    might depend on the amount of available memory space on a specific
@@ -155,19 +155,16 @@ details. */
    a specific instance shall be provided by the sysconf() function. */
 
 /* Maximum number of I/O operations in a single list I/O call supported by
-   the implementation.  Not yet implemented. */
-#undef AIO_LISTIO_MAX
-/* #define AIO_LISTIO_MAX >= _POSIX_AIO_LISTIO_MAX */
+   the implementation. */
+#define AIO_LISTIO_MAX 32
 
 /* Maximum number of outstanding asynchronous I/O operations supported by
-   the implementation.  Not yet implemented. */
-#undef AIO_MAX
-/*  #define AIO_MAX >= _POSIX_AIO_MAX */
+   the implementation. */
+#define AIO_MAX 8
 
 /* The maximum amount by which a process can decrease its asynchronous I/O
-   priority level from its own scheduling priority. */
-#undef AIO_PRIO_DELTA_MAX
-/* #define AIO_PRIO_DELTA_MAX >= 0 */
+   priority level from its own scheduling priority. Not yet implemented. */
+#define AIO_PRIO_DELTA_MAX 0
 
 /* Maximum number of bytes in arguments and environment passed in an exec
    call.  32000 is the safe value used for Windows processes when called
diff --git a/winsup/cygwin/sysconf.cc b/winsup/cygwin/sysconf.cc
index 7680cfc90..ff98f57a3 100644
--- a/winsup/cygwin/sysconf.cc
+++ b/winsup/cygwin/sysconf.cc
@@ -541,9 +541,9 @@ static struct
   {cons, {c:_POSIX_SHARED_MEMORY_OBJECTS}},	/*  31, _SC_SHARED_MEMORY_OBJECTS */
   {cons, {c:_POSIX_SYNCHRONIZED_IO}},	/*  32, _SC_SYNCHRONIZED_IO */
   {cons, {c:_POSIX_TIMERS}},		/*  33, _SC_TIMERS */
-  {nsup, {c:0}},			/*  34, _SC_AIO_LISTIO_MAX */
-  {nsup, {c:0}},			/*  35, _SC_AIO_MAX */
-  {nsup, {c:0}},			/*  36, _SC_AIO_PRIO_DELTA_MAX */
+  {cons, {c:AIO_LISTIO_MAX}},		/*  34, _SC_AIO_LISTIO_MAX */
+  {cons, {c:AIO_MAX}},			/*  35, _SC_AIO_MAX */
+  {cons, {c:AIO_PRIO_DELTA_MAX}},	/*  36, _SC_AIO_PRIO_DELTA_MAX */
   {nsup, {c:0}},			/*  37, _SC_DELAYTIMER_MAX */
   {cons, {c:PTHREAD_KEYS_MAX}},		/*  38, _SC_THREAD_KEYS_MAX */
   {cons, {c:PTHREAD_STACK_MIN}},	/*  39, _SC_THREAD_STACK_MIN */
diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
index 2cbdcf561..0bddaf345 100644
--- a/winsup/cygwin/thread.cc
+++ b/winsup/cygwin/thread.cc
@@ -663,7 +663,7 @@ pthread::cancel ()
    Required cancellation points:
 
     * accept ()
-    o aio_suspend ()
+    * aio_suspend ()
     * clock_nanosleep ()
     * close ()
     * connect ()
@@ -839,7 +839,7 @@ pthread::cancel ()
       ioctl ()
       link ()
       linkat ()
-    o lio_listio ()
+    * lio_listio ()
       localtime ()
       localtime_r ()
     * lockf ()
diff --git a/winsup/doc/new-features.xml b/winsup/doc/new-features.xml
index beba5f2e0..873a579a2 100644
--- a/winsup/doc/new-features.xml
+++ b/winsup/doc/new-features.xml
@@ -20,6 +20,12 @@ SO_RCVTIMEO and SO_SNDTIMEO socket options are now honored.
 New API: clearenv, pthread_tryjoin_np, pthread_timedjoin_np.
 </para></listitem>
 
+<listitem><para>
+New APIs for POSIX Asynchronous I/O: aio_cancel, aio_error, aio_fsync,
+aio_read, aio_return, aio_suspend, aio_write, lio_listio.
+New Header: &lt;aio.h&gt;.
+</para></listitem>
+
 </itemizedlist>
 
 </sect2>
diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index c6c714bb9..9cb55ca56 100644
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
@@ -1556,13 +1564,6 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
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
@@ -1575,7 +1576,6 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     getnetent
     getpmsg
     isastream
-    lio_listio
     mlockall
     munlockall
     posix_mem_offset
diff --git a/winsup/utils/strace.cc b/winsup/utils/strace.cc
index ae62cdc5f..616fa7890 100644
--- a/winsup/utils/strace.cc
+++ b/winsup/utils/strace.cc
@@ -985,7 +985,7 @@ Trace system calls and signals\n\
     wm       0x000400 (_STRACE_WM)       Trace Windows msgs (enable _strace_wm).\n\
     sigp     0x000800 (_STRACE_SIGP)     Trace signal and process handling.\n\
     minimal  0x001000 (_STRACE_MINIMAL)  Very minimal strace output.\n\
-    pthread  0x002000 (_STRACE_PTHREAD)	Pthread calls.\n\
+    pthread  0x002000 (_STRACE_PTHREAD)	 Pthread calls.\n\
     exitdump 0x004000 (_STRACE_EXITDUMP) Dump strace cache on exit.\n\
     system   0x008000 (_STRACE_SYSTEM)   Serious error; goes to console and log.\n\
     nomutex  0x010000 (_STRACE_NOMUTEX)  Don't use mutex for synchronization.\n\
-- 
2.17.0
