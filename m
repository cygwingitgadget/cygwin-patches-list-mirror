Return-Path: <cygwin-patches-return-5225-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29864 invoked by alias); 17 Dec 2004 02:52:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29825 invoked from network); 17 Dec 2004 02:51:59 -0000
Received: from unknown (HELO green.qinip.net) (62.100.30.36)
  by sourceware.org with SMTP; 17 Dec 2004 02:51:59 -0000
Received: from buzzy-box (hmm-dca-ap02-d11-224.dial.freesurf.nl [195.18.124.224])
	by green.qinip.net (Postfix) with SMTP
	id 6417B42E8; Fri, 17 Dec 2004 03:51:47 +0100 (MET)
Message-ID: <n2m-g.cptl2c.3vvd6ov.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: Re: [Patch] cygcheck: eprintf + display_error: Do /something/.
References: <n2m-g.cpt7kf.3vvb68n.1@buzzy-box.bavag> <20041217020205.GA26712@trixie.casa.cgf.cx>
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
User-Agent: slrn/0.9.8.1 (Win32) Hamster/2.0.6.0 Korrnews/4.2
To: cygwin-patches@cygwin.com
In-Reply-To: <20041217020205.GA26712@trixie.casa.cgf.cx>
Date: Fri, 17 Dec 2004 02:52:00 -0000
X-SW-Source: 2004-q4/txt/msg00226.txt.bz2

Op Thu, 16 Dec 2004 21:02:05 -0500 schreef Christopher Faylor
in <20041217020205.GA26712@trixie.casa.cgf.cx>:
:  On Fri, Dec 17, 2004 at 02:04:40AM +0100, Buzz wrote:
: > Here is another attempt at making eprintf a usable/used function in
: > cygcheck. It this time just flushes stdout and stderr before/after
: > output on stderr, when both (stdout and stderr) are ttys.

[...]

:  I'm still not sure what you're hoping to accomplish with this.  I haven't
:  seen any problems with flushing in cygcheck and I wouldn't expect any
:  since the flushing should be automatic if stdout is a "tty".

I seem to be making a mess here... The point is to have the error-messages
appear at about the appropriate point in the output, not bunched together
near the beginning or end. Here is another attempt. This time, do the
flushing when both are ttys or neither are.

(If you know of a simple test to find out if the two are identical,
that would be preferable. No test at all is also an option...)


ChangeLog-entry:

2004-12-17  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>

	* cygcheck.cc (eprintf): Flush stdout before, and stderr after output,
	when stdout and stderr both refer to tty's, or both don't.
	(display_error): Use eprintf.


--- src/winsup/utils/cygcheck.cc	18 Nov 2004 05:20:23 -0000	1.64
+++ src/winsup/utils/cygcheck.cc	17 Dec 2004 02:45:43 -0000
@@ -9,6 +9,7 @@
    details. */
 
 #include <stdio.h>
+#include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
 #include <sys/time.h>
@@ -102,9 +103,16 @@ void
 eprintf (const char *format, ...)
 {
   va_list ap;
+
+  if (isatty (fileno (stdout)) == isatty (fileno (stderr)))
+    fflush (stdout);
+
   va_start (ap, format);
   vfprintf (stderr, format, ap);
   va_end (ap);
+
+  if (isatty (fileno (stdout)) == isatty (fileno (stderr)))
+    fflush (stderr);
 }
 
 /*
@@ -114,10 +122,10 @@ static int
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
