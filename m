Return-Path: <cygwin-patches-return-5275-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13933 invoked by alias); 23 Dec 2004 16:48:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13885 invoked from network); 23 Dec 2004 16:48:35 -0000
Received: from unknown (HELO green.qinip.net) (62.100.30.36)
  by sourceware.org with SMTP; 23 Dec 2004 16:48:35 -0000
Received: from buzzy-box (hmm-dca-ap02-d06-127.dial.freesurf.nl [195.18.79.127])
	by green.qinip.net (Postfix) with SMTP
	id 3D52F43FC; Thu, 23 Dec 2004 17:48:33 +0100 (MET)
Message-ID: <n2m-g.cqeuff.3vvb86h.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: Re: [Patch] cygcheck: eprintf + display_error: Do /something/.
References: <n2m-g.cpt7kf.3vvb68n.1@buzzy-box.bavag> <20041217020205.GA26712@trixie.casa.cgf.cx> <n2m-g.cptl2c.3vvd6ov.1@buzzy-box.bavag> <20041217025607.GE26712@trixie.casa.cgf.cx> <n2m-g.cptncf.3vv6gv7.1@buzzy-box.bavag> <20041217061932.GH26712@trixie.casa.cgf.cx> <n2m-g.cpu9so.3vvckrb.1@buzzy-box.bavag> <20041217094301.GG9277@cygbert.vinschen.de> <n2m-g.cpvkqo.3vvegs9.1@buzzy-box.bavag> <20041220103216.GM9277@cygbert.vinschen.de>
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
User-Agent: slrn/0.9.8.1 (Win32) Hamster/2.0.6.0 Korrnews/4.2
To: cygwin-patches@cygwin.com
In-Reply-To: <20041220103216.GM9277@cygbert.vinschen.de>
Date: Thu, 23 Dec 2004 16:48:00 -0000
X-SW-Source: 2004-q4/txt/msg00276.txt.bz2

Op Mon, 20 Dec 2004 11:32:16 +0100 schreef Corinna Vinschen
in <20041220103216.GM9277@cygbert.vinschen.de>:
:  On Dec 17 21:59, Bas van Gompel wrote:
: > Op Fri, 17 Dec 2004 10:43:01 +0100 schreef Corinna Vinschen
: > :  Hmm, if stderr is not unbuffered in mingw, then that should be fixed
: > :  in mingw, shouldn't it?
: >
: > I guess so...
: >
: > I'll try and look into this, if noone else does.

Danny does not seem inclined to apply my patch...

I'll try once more.

: > What about the patch? It shouldn't hurt, and the flush of stderr can
: > be removed, once this has been fixed in mingw.
:
:  I'd rather see a fix than a workaround, if that's possible.  You know
:  that the typical lifetime of a workaround is a multiple of the lifetime
:  of the actual problem ;-)

True.

Here is a version which will work as expected iff the mingw-patch
gets accepted.


2004-12-23  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>

	* cygcheck.cc (eprintf): Flush stdout before output.
	(display_error): Use eprintf.


--- src/winsup/utils/cygcheck.cc	18 Nov 2004 05:20:23 -0000	1.64
+++ src/winsup/utils/cygcheck.cc	22 Dec 2004 06:30:07 -0000
@@ -102,6 +102,9 @@ void
 eprintf (const char *format, ...)
 {
   va_list ap;
+
+  fflush (stdout);
+
   va_start (ap, format);
   vfprintf (stderr, format, ap);
   va_end (ap);
@@ -114,10 +118,10 @@ static int
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
