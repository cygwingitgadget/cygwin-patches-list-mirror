Return-Path: <cygwin-patches-return-5067-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5876 invoked by alias); 18 Oct 2004 05:13:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5867 invoked from network); 18 Oct 2004 05:13:23 -0000
Message-ID: <n2m-g.ckvk3d.3vvamo1.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: Re: [Patch] cygcheck: pretty_id misbehaving.
References: <n2m-g.ckm5nu.3vvc0mv.1@buzzy-box.bavag> <20041014173621.GG22814@trixie.casa.cgf.cx> <n2m-g.ckol7v.3vshjpb.1@buzzy-box.bavag> <20041015135904.GD29569@trixie.casa.cgf.cx> <n2m-g.ckprr1.3vvf2a7.1@buzzy-box.bavag> <20041017233423.GA8780@trixie.casa.cgf.cx> <n2m-g.ckvd9l.3vvapnt.1@buzzy-box.bavag> <20041018014629.GO29569@trixie.casa.cgf.cx>
In-Reply-To: <20041018014629.GO29569@trixie.casa.cgf.cx>
Reply-To: Buzz <ngs@bavag.tmfweb.nl>
Organisation: Ehm...
User-Agent: slrn/0.9.8.1 (Win32) Hamster/2.0.6.0
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Date: Mon, 18 Oct 2004 05:13:00 -0000
X-SW-Source: 2004-q4/txt/msg00068.txt.bz2

Op Sun, 17 Oct 2004 21:46:29 -0400 schreef Christopher Faylor
in <20041018014629.GO29569@trixie.casa.cgf.cx>:
:  On Mon, Oct 18, 2004 at 03:32:07AM +0200, Buzz wrote:

[...]

: > 	* Cygcheck.cc (pretty_id): Count ')' in ui_len and gui_len.
:
:   Thanks.  Checked in without change.

Thank you (for writing a better ChangeLog-entry as well).

Remaining items... (I missed these last time around.)


ChangeLog-entry:

2004-10-18  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>

	* cygcheck.cc (pretty_id): Don't let i become negative. Fix
	printf-format.


--- src/winsup/utils/cygcheck.cc	18 Oct 2004 01:44:55 -0000	1.52
+++ src/winsup/utils/cygcheck.cc	18 Oct 2004 04:47:24 -0000
@@ -836,11 +836,11 @@ pretty_id (const char *s, char *cygwin, 
 
   printf ("\nOutput from %s (%s)\n", id, s);
   int n = 80 / (int) ++sz;
-  int i = n ? n - 2 : 0;
+  int i = n > 2 ? n - 2 : 0;
   sz = -sz;
   for (char **g = groups; g <= ng; g++)
     if ((g != ng) && (++i < n))
-      printf ("%*s ", sz, *g);
+      printf ("%*s", sz, *g);
     else
       {
 	puts (*g);


L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
