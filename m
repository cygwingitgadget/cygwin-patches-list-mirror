Return-Path: <cygwin-patches-return-5190-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20154 invoked by alias); 6 Dec 2004 01:45:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20076 invoked from network); 6 Dec 2004 01:45:12 -0000
Received: from unknown (HELO green.qinip.net) (62.100.30.36)
  by sourceware.org with SMTP; 6 Dec 2004 01:45:12 -0000
Received: from buzzy-box (hmm-dca-ap02-d04-073.dial.freesurf.nl [195.18.77.73])
	by green.qinip.net (Postfix) with SMTP
	id 7F355445D; Mon,  6 Dec 2004 02:45:10 +0100 (MET)
Message-ID: <n2m-g.cp0gle.3vsh6i5.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: [Patch] fhandler.cc (pust_readahead): end-condition off.
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
User-Agent: slrn/0.9.8.1 (Win32) Hamster/2.0.6.0 Korrnews/4.2
To: cygwin-patches@cygwin.com
Date: Mon, 06 Dec 2004 01:45:00 -0000
X-SW-Source: 2004-q4/txt/msg00191.txt.bz2

Hi,

A real bugfix this time.

When fhandler_base::puts_readahead is given a (non -1) len-parameter,
in the current implementation, not len characters are stowed, but len
z-strings. This affects at least fhandler_pty_master::accept_input in
fhandler_tty.cc.

Following (trivial, I'd say) patch ought to fix it.


ChangeLog-entry:

2004-12-06 Bas van Gompel  <cygwin-patch@bavag.tmfweb.nl>

	* fhandler.cc (fhandler_base::puts_readahead): Fix end-condition.


--- src/winsup/cygwin-mmod/fhandler.cc	5 Dec 2004 07:28:27 -0000	1.209
+++ src/winsup/cygwin-mmod/fhandler.cc	6 Dec 2004 01:14:14 -0000
@@ -54,7 +54,7 @@ int
 fhandler_base::puts_readahead (const char *s, size_t len)
 {
   int success = 1;
-  while ((*s || (len != (size_t) -1 && len--))
+  while ((len == (size_t) -1 ? *s : len--)
 	 && (success = put_readahead (*s++) > 0))
     continue;
   return success;


L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
