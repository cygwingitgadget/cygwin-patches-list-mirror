Return-Path: <cygwin-patches-return-5114-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14936 invoked by alias); 11 Nov 2004 00:19:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14721 invoked from network); 11 Nov 2004 00:18:46 -0000
Received: from unknown (HELO green.qinip.net) (62.100.30.36)
  by sourceware.org with SMTP; 11 Nov 2004 00:18:46 -0000
Received: from buzzy-box (hmm-dca-ap02-d06-068.dial.freesurf.nl [195.18.79.68])
	by green.qinip.net (Postfix) with SMTP
	id 96270424D; Thu, 11 Nov 2004 01:18:43 +0100 (MET)
Message-ID: <n2m-g.cmu9aj.3vvcqe5.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: [Patch] cygcheck: Make keyeprint more versatile.
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
User-Agent: slrn/0.9.8.1 (Win32) Hamster/2.0.6.0 Korrnews/4.2
To: cygwin-patches@cygwin.com
Date: Thu, 11 Nov 2004 00:19:00 -0000
X-SW-Source: 2004-q4/txt/msg00115.txt.bz2

Hi,

Another (trivial, I hope) patch.

It will add some optional parameters to keyeprint, so errormessages
can be made more appropriate. When the options are not supplied, output
will remain as is.


ChangeLog-entry:

2004-11-11  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>

	* cygcheck.cc (keyeprint): New optional parameters: show_error and
	print_failed.


--- src/winsup/utils/cygcheck.cc	31 Oct 2004 18:46:31 -0000	1.59
+++ src/winsup/utils/cygcheck.cc	10 Nov 2004 21:11:26 -0000
@@ -102,9 +102,14 @@ static char **paths = 0;
  * keyeprint() is used to report failure modes
  */
 static int
-keyeprint (const char *name)
+keyeprint (const char *name, bool show_error = true, bool print_failed = true)
 {
-  fprintf (stderr, "cygcheck: %s failed: %lu\n", name, GetLastError ());
+  if (show_error)
+    fprintf (stderr, "cygcheck: %s%s: %lu\n", name,
+	print_failed ? " failed" : "", GetLastError ());
+  else
+    fprintf (stderr, "cygcheck: %s%s\n", name,
+	print_failed ? " failed" : "");
   return 1;
 }
 


L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
