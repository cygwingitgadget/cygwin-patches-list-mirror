Return-Path: <cygwin-patches-return-4613-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15702 invoked by alias); 22 Mar 2004 14:36:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15672 invoked from network); 22 Mar 2004 14:36:37 -0000
Message-ID: <405EF9F4.A97FF863@phumblet.no-ip.org>
Date: Mon, 22 Mar 2004 14:36:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: Pierre.Humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [Patch]: Win95
Content-Type: multipart/mixed;
 boundary="------------EAD86C07F681D9BA05336F16"
X-SW-Source: 2004-q1/txt/msg00103.txt.bz2

This is a multi-part message in MIME format.
--------------EAD86C07F681D9BA05336F16
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 287

This fixes gnuchess on Win95.
There is still a compiler warning, will look at it tonight.
Tested on ME, 95 and NT4.0

Pierre

2004-03-22  Pierre Humblet <pierre.humblet@ieee.org>

	* init.cc (munge_threadfunc): Handle all instances of search_for.
	(prime_threads): Test threadfunc_ix[0].
--------------EAD86C07F681D9BA05336F16
Content-Type: text/plain; charset=us-ascii;
 name="init.cc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="init.cc.diff"
Content-length: 2056

Index: init.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/init.cc,v
retrieving revision 1.31
diff -u -p -r1.31 init.cc
--- init.cc	24 Feb 2004 17:13:16 -0000	1.31
+++ init.cc	22 Mar 2004 13:15:56 -0000
@@ -17,7 +17,7 @@ details. */
 
 int NO_COPY dynamically_loaded;
 static char *search_for = (char *) cygthread::stub;
-unsigned threadfunc_ix __attribute__((section ("cygwin_dll_common"), shared)) = 0;
+unsigned threadfunc_ix[8] __attribute__((section ("cygwin_dll_common"), shared)) = {};
 DWORD tls_func;
 
 HANDLE sync_startup;
@@ -45,7 +45,7 @@ calibration_thread (VOID *arg)
 void
 prime_threads ()
 {
-  if (!threadfunc_ix)
+  if (!threadfunc_ix[0])
     {
       DWORD id;
       search_for = (char *) calibration_thread;
@@ -59,14 +59,15 @@ static void
 munge_threadfunc ()
 {
   char **ebp = (char **) __builtin_frame_address (0);
-  if (!threadfunc_ix)
+  int i;
+  if (!threadfunc_ix[0])
     {
-      for (char **peb = ebp; peb < (char **) _tlsbase; peb++)
+      char **top = (char **) _tlsbase;
+      for (char **peb = ebp, i = 0; peb < top && i < 7; peb++)
 	if (*peb == search_for)
-	  {
-	    threadfunc_ix = peb - ebp;
-	    goto foundit;
-	  }
+	  threadfunc_ix[i++] = peb - ebp;
+      if (threadfunc_ix[0])
+	goto foundit;
 #ifdef DEBUGGING_HARD
       system_printf ("non-fatal warning: unknown thread! search_for %p, cygthread::stub %p, calibration_thread %p, possible func offset %p",
 		     search_for, cygthread::stub, calibration_thread, ebp[137]);
@@ -76,12 +77,13 @@ munge_threadfunc ()
     }
 
 foundit:
-  char *threadfunc = ebp[threadfunc_ix];
+  char *threadfunc = ebp[threadfunc_ix[0]];
   if (threadfunc == (char *) calibration_thread)
     /* no need for the overhead */;
   else
     {
-      ebp[threadfunc_ix] = (char *) threadfunc_fe;
+      for (i = 0; threadfunc_ix[i]; i++)		
+	ebp[threadfunc_ix[i]] = (char *) threadfunc_fe;
       ((char **) _tlsbase)[OLDFUNC_OFFSET] = threadfunc;
       // TlsSetValue (tls_func, (void *) threadfunc);
     }

--------------EAD86C07F681D9BA05336F16--
