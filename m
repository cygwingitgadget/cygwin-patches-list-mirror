Return-Path: <cygwin-patches-return-5231-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29424 invoked by alias); 17 Dec 2004 03:33:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29399 invoked from network); 17 Dec 2004 03:33:12 -0000
Received: from unknown (HELO green.qinip.net) (62.100.30.36)
  by sourceware.org with SMTP; 17 Dec 2004 03:33:12 -0000
Received: from buzzy-box (hmm-dca-ap02-d01-103.dial.freesurf.nl [195.18.74.103])
	by green.qinip.net (Postfix) with SMTP
	id 438584477; Fri, 17 Dec 2004 04:33:10 +0100 (MET)
Message-ID: <n2m-g.cptncf.3vv6gv7.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: Re: [Patch] cygcheck: eprintf + display_error: Do /something/.
References: <n2m-g.cpt7kf.3vvb68n.1@buzzy-box.bavag> <20041217020205.GA26712@trixie.casa.cgf.cx> <n2m-g.cptl2c.3vvd6ov.1@buzzy-box.bavag> <20041217025607.GE26712@trixie.casa.cgf.cx>
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
User-Agent: slrn/0.9.8.1 (Win32) Hamster/2.0.6.0 Korrnews/4.2
To: cygwin-patches@cygwin.com
In-Reply-To: <20041217025607.GE26712@trixie.casa.cgf.cx>
Date: Fri, 17 Dec 2004 03:33:00 -0000
X-SW-Source: 2004-q4/txt/msg00232.txt.bz2

Op Thu, 16 Dec 2004 21:56:07 -0500 schreef Christopher Faylor
in <20041217025607.GE26712@trixie.casa.cgf.cx>:
:  On Fri, Dec 17, 2004 at 03:51:47AM +0100, Bas van Gompel wrote:

[...]

: > I seem to be making a mess here... The point is to have the error-messages
: > appear at about the appropriate point in the output, not bunched together
: > near the beginning or end. Here is another attempt. This time, do the
: > flushing when both are ttys or neither are.
:
:   I still don't see the point.  There is no need to do explicit flushes if
:  both stdout and stderr are ttys.  In the case of stdout the flush should
:  occur every time there's a newline.  In the case of stderr, the flush
:  should happen after every write.

So, the test can exclude the case where both are ttys. (Did I say I was
making a mess?) Here is a sample of ``cygcheck -s -v -r >cygcheck.out
2>&1'', when some (network) drives can not be read:


...
zip                     2.3-6
zlib                    1.2.2-1
zsh                     4.2.0-2
Use -h to see help about each section
cygcheck: dump_sysinfo: GetVolumeInformation() failed: 5
cygcheck: dump_sysinfo: GetVolumeInformation() failed: 5


Another version of the ChangeLog-entry/patch:

2004-12-17  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>

	* cygcheck.cc (eprintf): Flush stdout before, and stderr after output,
	when stdout and stderr both don't refer to ttys.
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
+  if (!isatty (fileno (stdout)) && !isatty (fileno (stderr)))
+    fflush (stdout);
+
   va_start (ap, format);
   vfprintf (stderr, format, ap);
   va_end (ap);
+
+  if (!isatty (fileno (stdout)) && !isatty (fileno (stderr)))
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
