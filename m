Return-Path: <cygwin-patches-return-5183-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15336 invoked by alias); 4 Dec 2004 23:01:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15179 invoked from network); 4 Dec 2004 23:01:05 -0000
Received: from unknown (HELO green.qinip.net) (62.100.30.36)
  by sourceware.org with SMTP; 4 Dec 2004 23:01:05 -0000
Received: from buzzy-box (hmm-dca-ap02-d12-009.dial.freesurf.nl [195.18.125.9])
	by green.qinip.net (Postfix) with SMTP
	id 403B14298; Sun,  5 Dec 2004 00:01:02 +0100 (MET)
Message-ID: <n2m-g.cotj39.3vvb3sh.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: [Patch] fhandler.cc: debug_printf when copied_chars is zero.
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
User-Agent: slrn/0.9.8.1 (Win32) Hamster/2.0.6.0 Korrnews/4.2
To: cygwin-patches@cygwin.com
Date: Sat, 04 Dec 2004 23:01:00 -0000
X-SW-Source: 2004-q4/txt/msg00184.txt.bz2

Hi,

While going over a strace I noticed some garbage in the (debug) output
when fhandler_base::read had read zero bytes. Following (trivial)
patch fixes that.


ChangeLog-entry:

2004-12-05  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>

	* fhandler.cc (fhandler_base::read): Don't debug_printf garbage when
	copied_chars is zero.


--- src/winsup/cygwin/fhandler.cc	20 Nov 2004 23:42:36 -0000	1.207
+++ src/winsup/cygwin/fhandler.cc	4 Dec 2004 22:04:38 -0000
@@ -758,6 +758,7 @@ fhandler_base::read (void *in_ptr, size_
 	  __small_sprintf (p, c >= 33 && c <= 127 ? " %c" : " %p", c);
 	  p += strlen (p);
 	}
+      *p = '\0';
       debug_printf ("read %d bytes (%s%s)", copied_chars, buf,
 		    copied_chars > 16 ? " ..." : "");
     }


L8r,

Buzz.

BTW: In how-vfork-works.txt, lines 31 and 32 end in CRLF.
BTW2: ansi.sgml has no linefeed at the end of the file.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
