Return-Path: <cygwin-patches-return-5138-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14976 invoked by alias); 18 Nov 2004 03:12:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14779 invoked from network); 18 Nov 2004 03:12:51 -0000
Received: from unknown (HELO green.qinip.net) (62.100.30.36)
  by sourceware.org with SMTP; 18 Nov 2004 03:12:51 -0000
Received: from buzzy-box (hmm-dca-ap02-d10-196.dial.freesurf.nl [195.18.87.196])
	by green.qinip.net (Postfix) with SMTP
	id D7BFD436A; Thu, 18 Nov 2004 04:12:45 +0100 (MET)
Message-ID: <n2m-g.cnh67l.3vv64o3.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: [Patch] cygcheck: New function: eprintf.
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
User-Agent: slrn/0.9.8.1 (Win32) Hamster/2.0.6.0 Korrnews/4.2
To: cygwin-patches@cygwin.com
Date: Thu, 18 Nov 2004 03:12:00 -0000
X-SW-Source: 2004-q4/txt/msg00139.txt.bz2

Hi,

Following patch probably does not make much sense "as is", but I
intend to flesh out this function in the near future. ``eprintf''
is intended to be called by display_error.

The patch takes this shape in order to keep things trivial (I hope).


ChangeLog-entry:

2004-11-18  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>

	* cygcheck.cc (eprintf): New function.


--- src/winsup/utils/cygcheck.cc	16 Nov 2004 05:16:59 -0000	1.63
+++ src/winsup/utils/cygcheck.cc	18 Nov 2004 02:09:40 -0000
@@ -98,6 +98,15 @@ static common_apps[] = {
 static int num_paths = 0, max_paths = 0;
 static char **paths = 0;
 
+void
+eprintf (const char *format, ...)
+{
+  va_list ap;
+  va_start (ap, format);
+  vfprintf (stderr, format, ap);
+  va_end (ap);
+}
+
 /*
  * display_error() is used to report failure modes
  */


L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
