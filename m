Return-Path: <cygwin-patches-return-5154-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5805 invoked by alias); 21 Nov 2004 00:00:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5719 invoked from network); 21 Nov 2004 00:00:36 -0000
Received: from unknown (HELO green.qinip.net) (62.100.30.36)
  by sourceware.org with SMTP; 21 Nov 2004 00:00:36 -0000
Received: from buzzy-box (hmm-dca-ap02-d01-224.dial.freesurf.nl [195.18.74.224])
	by green.qinip.net (Postfix) with SMTP
	id 95DD643D2; Sun, 21 Nov 2004 01:00:31 +0100 (MET)
Message-ID: <n2m-g.cnlcot.3vve8j9.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: Re: [Patch] cygcheck: eprintf + display_error: Do more.
References: <n2m-g.cnhqes.3vv4uqn.1@buzzy-box.bavag> <20041118152206.GD10795@trixie.casa.cgf.cx>
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
User-Agent: slrn/0.9.8.1 (Win32) Hamster/2.0.6.0 Korrnews/4.2
To: cygwin-patches@cygwin.com
In-Reply-To: <20041118152206.GD10795@trixie.casa.cgf.cx>
Date: Sun, 21 Nov 2004 00:00:00 -0000
X-SW-Source: 2004-q4/txt/msg00155.txt.bz2

Op Thu, 18 Nov 2004 10:22:06 -0500 schreef Christopher Faylor
in <20041118152206.GD10795@trixie.casa.cgf.cx>:
:  On Thu, Nov 18, 2004 at 09:52:04AM +0100, Bas van Gompel wrote:
: > Hi,
: >
: > This patch enables eprintf. It also causes stdout and stderr to be
: > synchronzied (using fflush) when they refer to the same file-descriptor.
: >
: > Also, when stdout and stderr have a different number, and stdout is not
: > a tty, the error-message is copied to stdout, allowing it to be easily
: > captured in a cygcheck.out.
: >
: > (I'm aware that generally it is a bad idea to do things like this, but
: > cygcheck being what it is, I think this ought to be an exception.)
:
:   I think the generally bad idea is a bad idea for a reason.

It is. But, given the way people are instructed to use ``cygcheck -s -v
-r >cygcheck.out'', I thought there might be cause for an exception.

:  If we are going to redirect stuff like this, why not just forego the use
:  of stderr entirely and use stdout for all messages?

That is an option, One can however then no longer redirect stdout and
see just errors... (The warnings could also use eprintf. The fflushes
need to be in eprintf, then, though.)

:  Also, rather than explicitly flushing, why not just set setbuf (stdout, NULL)
:  setbuf (stderr, NULL) in main()?

That would not buffer output /ever/. My (non-working) suggestion was
to try and find out whether stdout and stderr are the same, and fflush
only when stderr was used, otherwise just buffer.
(Good catch, Benjamin. brainfart here.)

Maybe the tests could be ``isatty (fileno ((stdout)) && isatty (fileno
((stderr))'' for the fflushes, and ``!isatty (fileno ((stdout)) &&
isatty (fileno ((stderr))'' for duplicating the output.


ChangeLog-entry:

2004-11-19  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>

	* cygcheck.cc (eprintf): Print to stdout as well, when stdout is not
	a tty, but stderr is. Flush stdout before, and stderr after output,
	when stdout and stderr both refer to tty's.
	(display_error): Use eprintf.



--- src/winsup/utils/cygcheck.cc	2004-11-18 06:35:06.000000000 +0100
+++ src/winsup/utils/cygcheck.cc	2004-11-19 01:23:10.000000000 +0100
@@ -9,6 +9,7 @@
    details. */
 
 #include <stdio.h>
+#include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
 #include <sys/time.h>
@@ -102,9 +103,24 @@ void
 eprintf (const char *format, ...)
 {
   va_list ap;
+
+  if (isatty (fileno (stdout)) && isatty (fileno (stderr)))
+    fflush (stdout);
+
   va_start (ap, format);
   vfprintf (stderr, format, ap);
   va_end (ap);
+
+  if (isatty (fileno (stdout)) && isatty (fileno (stderr)))
+    fflush (stderr);
+
+  /* Don't lose this in reports when only redirecting stdout. */
+  if (!isatty (fileno (stdout)) && isatty (fileno (stderr)))
+    {
+      va_start (ap, format);
+      vfprintf (stdout, format, ap);
+      va_end (ap);
+    }
 }
 
 /*
@@ -114,10 +130,10 @@ static int
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
