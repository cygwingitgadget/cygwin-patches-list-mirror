Return-Path: <cygwin-patches-return-3419-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8087 invoked by alias); 17 Jan 2003 19:22:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8044 invoked from network); 17 Jan 2003 19:22:21 -0000
Date: Fri, 17 Jan 2003 19:22:00 -0000
From: Jason Tishler <jason@tishler.net>
Subject: nanosleep() patch
To: Cygwin-Patches <cygwin-patches@cygwin.com>
Mail-followup-to: Cygwin-Patches <cygwin-patches@cygwin.com>
Message-id: <20030117192853.GA1164@tishler.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_AMWUX/tdy2dc77fhwMaMUA)"
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00068.txt.bz2


--Boundary_(ID_AMWUX/tdy2dc77fhwMaMUA)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-length: 497

Attached is a patch that implements nanosleep() by attempting to
reuse the current sleep() implementation which seems to provide the
necessary functionality.

I'm not sure if there is a better way to convey the fact that
sleep_worker() was interrupted than my current implementation.
Comments on this issue and the patch in general are welcome.

Thanks,
Jason

-- 
PGP/GPG Key: http://www.tishler.net/jason/pubkey.asc or key servers
Fingerprint: 7A73 1405 7F2B E669 C19D  8784 1AFD E4CC ECF4 8EF6

--Boundary_(ID_AMWUX/tdy2dc77fhwMaMUA)
Content-type: text/plain; charset=us-ascii; NAME=nanosleep.patch
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=nanosleep.patch
Content-length: 3848

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.74
diff -u -p -r1.74 cygwin.din
--- cygwin.din	17 Jan 2003 13:08:05 -0000	1.74
+++ cygwin.din	17 Jan 2003 18:43:15 -0000
@@ -597,6 +597,8 @@ nan
 _nan = nan
 nanf
 _nanf = nanf
+nanosleep
+_nanosleep = nanosleep
 nextafter
 _nextafter = nextafter
 nextafterf
Index: signal.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/signal.cc,v
retrieving revision 1.41
diff -u -p -r1.41 signal.cc
--- signal.cc	15 Jan 2003 10:21:23 -0000	1.41
+++ signal.cc	17 Jan 2003 18:43:15 -0000
@@ -66,37 +66,47 @@ signal (int sig, _sig_func_ptr func)
   return prev;
 }
 
-extern "C" unsigned int
-sleep (unsigned int seconds)
+static bool
+sleep_worker (DWORD req, DWORD& rem)
 {
   int rc;
   sig_dispatch_pending (0);
   sigframe thisframe (mainthread);
-  DWORD ms, start_time, end_time;
+  DWORD start_time, end_time;
+  bool res = false;
 
   pthread_testcancel ();
 
-  ms = seconds * 1000;
   start_time = GetTickCount ();
-  end_time = start_time + (seconds * 1000);
-  syscall_printf ("sleep (%d)", seconds);
+  end_time = start_time + req;
+  syscall_printf ("sleep_worker (%ld)", req);
 
-  rc = pthread::cancelable_wait (signal_arrived, ms);
+  rc = pthread::cancelable_wait (signal_arrived, req);
   DWORD now = GetTickCount ();
   if (rc == WAIT_TIMEOUT || now >= end_time)
-    ms = 0;
+    rem = 0;
   else
-    ms = end_time - now;
+    rem = end_time - now;
   if (WaitForSingleObject (signal_arrived, 0) == WAIT_OBJECT_0)
-    (void) thisframe.call_signal_handler ();
-
-  DWORD res = (ms + 500) / 1000;
-  syscall_printf ("%d = sleep (%d)", res, seconds);
+    {
+      (void) thisframe.call_signal_handler ();
+      res = true;
+    }
 
+  syscall_printf ("%d = sleep_worker (%ld, %ld)", res, req, rem);
   return res;
 }
 
 extern "C" unsigned int
+sleep (unsigned int seconds)
+{
+  DWORD req = seconds * 1000;
+  DWORD rem = 0;
+  sleep_worker (req, rem);
+  return (rem + 500) / 1000;
+}
+
+extern "C" unsigned int
 usleep (unsigned int useconds)
 {
   pthread_testcancel ();
@@ -105,6 +115,34 @@ usleep (unsigned int useconds)
   syscall_printf ("usleep (%d)", useconds);
   pthread::cancelable_wait (signal_arrived, (useconds + 500) / 1000);
   syscall_printf ("0 = usleep (%d)", useconds);
+  return 0;
+}
+
+extern "C" int
+nanosleep (const struct timespec *rqtp, struct timespec *rmtp)
+{
+  if (rqtp->tv_sec < 0 || rqtp->tv_nsec < 0 || rqtp->tv_nsec > 999999999)
+    {
+      set_errno (EINVAL);
+      return -1;
+    }
+
+  DWORD req = rqtp->tv_sec * 1000 + (rqtp->tv_nsec + 500000) / 1000000;
+  DWORD rem = 0;
+  bool signal = sleep_worker (req, rem);
+
+  if (rmtp)
+    {
+      rmtp->tv_sec = rem / 1000;
+      rmtp->tv_nsec = (rem % 1000) * 1000000;
+    }
+
+  if (signal)
+    {
+      set_errno (EINTR);
+      return -1;
+    }
+
   return 0;
 }
 
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.96
diff -u -p -r1.96 version.h
--- include/cygwin/version.h	17 Jan 2003 13:08:06 -0000	1.96
+++ include/cygwin/version.h	17 Jan 2003 18:43:15 -0000
@@ -169,12 +169,13 @@ details. */
        69: Export strtof
        70: Export asprintf, _asprintf_r, vasprintf, _vasprintf_r
        71: Export strerror_r
+       72: Export nanosleep
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 71
+#define CYGWIN_VERSION_API_MINOR 72
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible

--Boundary_(ID_AMWUX/tdy2dc77fhwMaMUA)
Content-type: text/plain; charset=us-ascii; NAME=nanosleep.ChangeLog
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=nanosleep.ChangeLog
Content-length: 291

2003-01-17  Jason Tishler  <jason@tishler.net>

	* cygwin.din: Export nanosleep().
	* signal.cc (sleep_worker): New function.
	(sleep): Move essential old functionality to sleep_worker().  Call
	sleep_worker().
	(nanosleep): New function.
	* include/cygwin/version.h: Bump DLL minor number.

--Boundary_(ID_AMWUX/tdy2dc77fhwMaMUA)--
