Return-Path: <cygwin-patches-return-3445-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3696 invoked by alias); 21 Jan 2003 21:11:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3664 invoked from network); 21 Jan 2003 21:11:18 -0000
Date: Tue, 21 Jan 2003 21:11:00 -0000
From: Jason Tishler <jason@tishler.net>
Subject: Re: nanosleep() patch
In-reply-to: <20030121180525.GB15711@redhat.com>
To: cygwin-patches@cygwin.com
Mail-followup-to: cygwin-patches@cygwin.com
Message-id: <20030121211649.GA2060@tishler.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_7fanPgjJLr6FJNi389wEhg)"
User-Agent: Mutt/1.4i
References: <20030117192853.GA1164@tishler.net>
 <20030121155842.GS29236@cygbert.vinschen.de>
 <20030121160201.GA13579@redhat.com>
 <20030121161706.GU29236@cygbert.vinschen.de>
 <20030121180536.GC628@tishler.net> <20030121180525.GB15711@redhat.com>
X-SW-Source: 2003-q1/txt/msg00094.txt.bz2


--Boundary_(ID_7fanPgjJLr6FJNi389wEhg)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-length: 559

On Tue, Jan 21, 2003 at 01:05:25PM -0500, Christopher Faylor wrote:
> On Tue, Jan 21, 2003 at 01:05:36PM -0500, Jason Tishler wrote:
> >Regarding usleep(), I was afraid to change it to use nanosleep() (aka
> >sleep_worker()) because its implementation was different than sleep().
> 
> I think usleep's implementation was incorrect, actually.

See attached for my next version which addresses the above too.

Thanks,
Jason

-- 
PGP/GPG Key: http://www.tishler.net/jason/pubkey.asc or key servers
Fingerprint: 7A73 1405 7F2B E669 C19D  8784 1AFD E4CC ECF4 8EF6

--Boundary_(ID_7fanPgjJLr6FJNi389wEhg)
Content-type: text/plain; charset=us-ascii; NAME=nanosleep2.patch
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=nanosleep2.patch
Content-length: 3943

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.74
diff -u -p -r1.74 cygwin.din
--- cygwin.din	17 Jan 2003 13:08:05 -0000	1.74
+++ cygwin.din	21 Jan 2003 20:40:48 -0000
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
+++ signal.cc	21 Jan 2003 20:40:48 -0000
@@ -66,46 +66,63 @@ signal (int sig, _sig_func_ptr func)
   return prev;
 }
 
-extern "C" unsigned int
-sleep (unsigned int seconds)
+extern "C" int
+nanosleep (const struct timespec *rqtp, struct timespec *rmtp)
 {
-  int rc;
+  int res = 0;
   sig_dispatch_pending (0);
   sigframe thisframe (mainthread);
-  DWORD ms, start_time, end_time;
-
   pthread_testcancel ();
 
-  ms = seconds * 1000;
-  start_time = GetTickCount ();
-  end_time = start_time + (seconds * 1000);
-  syscall_printf ("sleep (%d)", seconds);
+  if (rqtp->tv_sec < 0 || rqtp->tv_nsec < 0 || rqtp->tv_nsec > 999999999)
+    {
+      set_errno (EINVAL);
+      return -1;
+    }
+
+  DWORD req = rqtp->tv_sec * 1000 + (rqtp->tv_nsec + 500000) / 1000000;
+  DWORD start_time = GetTickCount ();
+  DWORD end_time = start_time + req;
+  syscall_printf ("nanosleep (%ld)", req);
 
-  rc = pthread::cancelable_wait (signal_arrived, ms);
+  int rc = pthread::cancelable_wait (signal_arrived, req);
   DWORD now = GetTickCount ();
-  if (rc == WAIT_TIMEOUT || now >= end_time)
-    ms = 0;
-  else
-    ms = end_time - now;
+  DWORD rem = (rc == WAIT_TIMEOUT || now >= end_time) ? 0 : end_time - now;
   if (WaitForSingleObject (signal_arrived, 0) == WAIT_OBJECT_0)
-    (void) thisframe.call_signal_handler ();
-
-  DWORD res = (ms + 500) / 1000;
-  syscall_printf ("%d = sleep (%d)", res, seconds);
+    {
+      (void) thisframe.call_signal_handler ();
+      set_errno (EINTR);
+      res = -1;
+    }
+
+  if (rmtp)
+    {
+      rmtp->tv_sec = rem / 1000;
+      rmtp->tv_nsec = (rem % 1000) * 1000000;
+    }
 
+  syscall_printf ("%d = nanosleep (%ld, %ld)", res, req, rem);
   return res;
 }
 
 extern "C" unsigned int
-usleep (unsigned int useconds)
+sleep (unsigned int seconds)
 {
-  pthread_testcancel ();
+  struct timespec req, rem;
+  req.tv_sec = seconds;
+  req.tv_nsec = 0;
+  nanosleep (&req, &rem);
+  return rem.tv_sec + (rem.tv_nsec + 500000000) / 1000000000;
+}
 
-  sig_dispatch_pending (0);
-  syscall_printf ("usleep (%d)", useconds);
-  pthread::cancelable_wait (signal_arrived, (useconds + 500) / 1000);
-  syscall_printf ("0 = usleep (%d)", useconds);
-  return 0;
+extern "C" unsigned int
+usleep (unsigned int useconds)
+{
+  struct timespec req;
+  req.tv_sec = useconds / 1000000;
+  req.tv_nsec = (useconds % 1000000) * 1000;
+  int res = nanosleep (&req, 0);
+  return res;
 }
 
 extern "C" int
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.97
diff -u -p -r1.97 version.h
--- include/cygwin/version.h	21 Jan 2003 05:13:42 -0000	1.97
+++ include/cygwin/version.h	21 Jan 2003 20:40:48 -0000
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

--Boundary_(ID_7fanPgjJLr6FJNi389wEhg)
Content-type: text/plain; charset=us-ascii; NAME=nanosleep2.ChangeLog
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=nanosleep2.ChangeLog
Content-length: 299

2003-01-21  Jason Tishler  <jason@tishler.net>

	* cygwin.din: Export nanosleep().
	* signal.cc (nanosleep): New function.
	(sleep): Move old functionality to nanosleep().  Call nanosleep().
	(usleep): Remove old functionality.  Call nanosleep().
	* include/cygwin/version.h: Bump DLL minor number.

--Boundary_(ID_7fanPgjJLr6FJNi389wEhg)--
