Return-Path: <cygwin-patches-return-5141-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2544 invoked by alias); 18 Nov 2004 08:52:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2429 invoked from network); 18 Nov 2004 08:52:06 -0000
Received: from unknown (HELO green.qinip.net) (62.100.30.36)
  by sourceware.org with SMTP; 18 Nov 2004 08:52:06 -0000
Received: from buzzy-box (hmm-dca-ap03-d13-212.dial.freesurf.nl [62.100.12.212])
	by green.qinip.net (Postfix) with SMTP
	id 8FC184296; Thu, 18 Nov 2004 09:52:04 +0100 (MET)
Message-ID: <n2m-g.cnhqes.3vv4uqn.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: [Patch] cygcheck: eprintf + display_error: Do more.
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
User-Agent: slrn/0.9.8.1 (Win32) Hamster/2.0.6.0 Korrnews/4.2
To: cygwin-patches@cygwin.com
Date: Thu, 18 Nov 2004 08:52:00 -0000
X-SW-Source: 2004-q4/txt/msg00142.txt.bz2

Hi,

This patch enables eprintf. It also causes stdout and stderr to be
synchronzied (using fflush) when they refer to the same file-descriptor.

Also, when stdout and stderr have a different number, and stdout is not
a tty, the error-message is copied to stdout, allowing it to be easily
captured in a cygcheck.out.

(I'm aware that generally it is a bad idea to do things like this, but
cygcheck being what it is, I think this ought to be an exception.)


ChangeLog-entry:

2004-11-18  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>

	* cygcheck.cc (eprintf): Print to stdout as well, when stdout and
	stderr represent different file-descriptors and stdout is not a tty.
	(display_error): Use eprintf. Flush stdout before, and stderr after
	output, when stdout and stderr refer to the same file-descriptor.


--- src/winsup/utils/cygcheck.cc	2004-11-18 06:35:06.000000000 +0100
+++ src/winsup/utils/cygcheck.cc	2004-11-18 08:35:52.000000000 +0100
@@ -9,6 +9,7 @@
    details. */
 
 #include <stdio.h>
+#include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
 #include <sys/time.h>
@@ -105,6 +106,12 @@ eprintf (const char *format, ...)
   va_start (ap, format);
   vfprintf (stderr, format, ap);
   va_end (ap);
+  if (fileno (stdout) != fileno (stderr) && !isatty (fileno (stdout)))
+    {
+      va_start (ap, format);
+      vfprintf (stdout, format, ap);
+      va_end (ap);
+    }
 }
 
 /*
@@ -113,12 +120,16 @@ eprintf (const char *format, ...)
 static int
 display_error (const char *name, bool show_error = true, bool print_failed = true)
 {
+  if (fileno (stdout) == fileno (stderr))
+    fflush (stdout);
   if (show_error)
-    fprintf (stderr, "cygcheck: %s%s: %lu\n", name,
+    eprintf ("cygcheck: %s%s: %lu\n", name,
 	print_failed ? " failed" : "", GetLastError ());
   else
-    fprintf (stderr, "cygcheck: %s%s\n", name,
+    eprintf ("cygcheck: %s%s\n", name,
 	print_failed ? " failed" : "");
+  if (fileno (stdout) == fileno (stderr))
+    fflush (stderr);
   return 1;
 }
 


L8r,


Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
