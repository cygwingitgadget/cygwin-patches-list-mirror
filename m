Return-Path: <cygwin-patches-return-5235-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10556 invoked by alias); 17 Dec 2004 08:46:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10473 invoked from network); 17 Dec 2004 08:46:31 -0000
Received: from unknown (HELO green.qinip.net) (62.100.30.36)
  by sourceware.org with SMTP; 17 Dec 2004 08:46:31 -0000
Received: from buzzy-box (hmm-dca-ap03-d06-042.dial.freesurf.nl [62.100.5.42])
	by green.qinip.net (Postfix) with SMTP
	id ACCD74472; Fri, 17 Dec 2004 09:46:13 +0100 (MET)
Message-ID: <n2m-g.cpu9so.3vvckrb.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: Re: [Patch] cygcheck: eprintf + display_error: Do /something/.
References: <n2m-g.cpt7kf.3vvb68n.1@buzzy-box.bavag> <20041217020205.GA26712@trixie.casa.cgf.cx> <n2m-g.cptl2c.3vvd6ov.1@buzzy-box.bavag> <20041217025607.GE26712@trixie.casa.cgf.cx> <n2m-g.cptncf.3vv6gv7.1@buzzy-box.bavag> <20041217061932.GH26712@trixie.casa.cgf.cx>
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
User-Agent: slrn/0.9.8.1 (Win32) Hamster/2.0.6.0 Korrnews/4.2
To: cygwin-patches@cygwin.com
In-Reply-To: <20041217061932.GH26712@trixie.casa.cgf.cx>
Date: Fri, 17 Dec 2004 08:46:00 -0000
X-SW-Source: 2004-q4/txt/msg00236.txt.bz2

Op Fri, 17 Dec 2004 01:19:32 -0500 schreef Christopher Faylor
in <20041217061932.GH26712@trixie.casa.cgf.cx>:
:  On Fri, Dec 17, 2004 at 04:33:10AM +0100, Bas van Gompel wrote:
[...]
: > 	* cygcheck.cc (eprintf): Flush stdout before, and stderr after output,
: > 	when stdout and stderr both don't refer to ttys.
: > 	(display_error): Use eprintf.
:
:   Ok.  I don't see any reason to check for ttyness, then.  If this is an issue
:  then lets just flush stdout prior to doing anything with stderr.  Flushing
:  stderr should always be a no-op.

It isn't (a no-op). (See the snippet in my previous mail.) Is this a
difference between cygwin and mingw, maybe?

:  Or, we could just make stdout always unbuffered.

That would force unbuffered output also when there is no error...

Following is the minimal patch which still works for me.


2004-12-17  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>

	* cygcheck.cc (eprintf): Flush stdout before, and stderr after output.
	(display_error): Use eprintf.


--- cygcheck.cc	18 Nov 2004 05:20:23 -0000	1.64
+++ cygcheck.cc	17 Dec 2004 08:38:06 -0000
@@ -9,6 +9,7 @@
    details. */
 
 #include <stdio.h>
+#include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
 #include <sys/time.h>
@@ -102,9 +103,15 @@ void
 eprintf (const char *format, ...)
 {
   va_list ap;
+
+  fflush (stdout);
+
   va_start (ap, format);
   vfprintf (stderr, format, ap);
   va_end (ap);
+
+  fflush (stderr);
+
 }
 
 /*
@@ -114,10 +121,10 @@ static int
 display_error (const char *name, bool show_error = true, bool print_failed = true)
 {
   if (show_error)
-    fprintf (stderr, "cygcheck: %s%s: %lu\n", name,
+    eprintf ("cygcheck: %s%s: %lu\n", name,
 	print_failed ? " failed" : "", GetLastError ());
   else
-    fprintf (stderr, "cygcheck: %s%s\n", name,
+    eprintf ("cygcheck: %s%s\n", name,
 	print_failed ? " failed" : "");
   return 1;
 }


L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
