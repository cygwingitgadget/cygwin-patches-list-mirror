Return-Path: <cygwin-patches-return-5005-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19413 invoked by alias); 5 Oct 2004 01:49:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19404 invoked from network); 5 Oct 2004 01:49:23 -0000
Message-ID: <n2m-g.cjt3mt.3vvcq0n.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: [Patch] pinfo.cc: second CreatePipe, not first.
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
User-Agent: slrn/0.9.8.0pl1 (CYGWIN_95-4.0) Hamster/2.0.5.5
To: cygwin-patches@cygwin.com
X-Processed-By: Eudora 6.0.1.1, Hamster Classic 2.0.5.5, KorrNews 4.2
Date: Tue, 05 Oct 2004 01:49:00 -0000
X-SW-Source: 2004-q4/txt/msg00006.txt.bz2

Hi,

Looking over pinfo.cc, I saw that the debugging-output on
_pinfo::commune_send is awkward. This (trivial again, IMHO)
patch changes that.


Changelog-entry:

2004-10-05  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>

	* pinfo.cc (_pinfo::commune_send): Make debugging output less ambiguous.


--- src/winsup/cygwin/pinfo.cc	12 Sep 2004 03:47:56 -0000	1.120
+++ src/winsup/cygwin/pinfo.cc	4 Oct 2004 23:59:17 -0000
@@ -501,7 +501,7 @@ _pinfo::commune_send (DWORD code, ...)
     }
   if (!CreatePipe (&fromme, &tothem, &sec_all_nih, PIPEBUFSIZE))
     {
-      sigproc_printf ("first CreatePipe failed, %E");
+      sigproc_printf ("second CreatePipe failed, %E");
       __seterrno ();
       goto err;
     }

L8r,

Buzz.
(On this one there was little formatting to botch. :-) )

BTW: Is it as it should be that either PID_INITIALIZING or (both
PID_IN_USE *and* PID_ACTIVE) must be set for proc_can_be_signalled
(sigproc.cc) to return true? (Sorry if this is a stupid question, my
understanding of the signal-code is hazy at best, despite reading
``how-signals-work.txt'' and most of the source-code.)
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^r
