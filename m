Return-Path: <cygwin-patches-return-5187-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31556 invoked by alias); 5 Dec 2004 04:44:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31515 invoked from network); 5 Dec 2004 04:44:28 -0000
Received: from unknown (HELO green.qinip.net) (62.100.30.36)
  by sourceware.org with SMTP; 5 Dec 2004 04:44:28 -0000
Received: from buzzy-box (hmm-dca-ap02-d12-073.dial.freesurf.nl [195.18.125.73])
	by green.qinip.net (Postfix) with SMTP
	id 8D07E438C; Sun,  5 Dec 2004 05:44:24 +0100 (MET)
Message-ID: <n2m-g.cou710.3vsjtgl.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: [Patch] fhandler.cc: Don't worry about SPC in __small_printf-format
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
User-Agent: slrn/0.9.8.1 (Win32) Hamster/2.0.6.0 Korrnews/4.2
To: cygwin-patches@cygwin.com
Date: Sun, 05 Dec 2004 04:44:00 -0000
X-SW-Source: 2004-q4/txt/msg00188.txt.bz2

Hi,

Three lines up from the previous patch there is a check to decide which
format to use. This is not needed, an equivalent test is already done in
__small_vsprintf.

(Trivial) patch follows.


ChangeLog-entry:

2004-12-05  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>

	* fhandler.cc (fhandler_base::read): Remove superfluous check in
	__small_sprintf format for strace.


--- src/winsup/cygwin/fhandler.cc	5 Dec 2004 01:53:47 -0000	1.208
+++ src/winsup/cygwin/fhandler.cc	5 Dec 2004 04:13:08 -0000
@@ -754,8 +754,7 @@ fhandler_base::read (void *in_ptr, size_
       for (int i = 0; i < copied_chars && i < 16; ++i)
 	{
 	  unsigned char c = ((unsigned char *) ptr)[i];
-	  /* >= 33 so space prints in hex */
-	  __small_sprintf (p, c >= 33 && c <= 127 ? " %c" : " %p", c);
+	  __small_sprintf (p, " %c", c);
 	  p += strlen (p);
 	}
       *p = '\0';


L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
