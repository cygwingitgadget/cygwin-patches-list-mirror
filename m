Return-Path: <cygwin-patches-return-5076-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5835 invoked by alias); 23 Oct 2004 20:17:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5805 invoked from network); 23 Oct 2004 20:17:06 -0000
Message-ID: <n2m-g.clektf.3vvfh6r.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: Re: [Patch] cygcheck: More complete helptext on drive-list.
References: <n2m-g.cl9oca.3vve76d.1@buzzy-box.bavag> <20041022000805.GF28112@trixie.casa.cgf.cx> <n2m-g.cl9v8k.3vv94fl.1@buzzy-box.bavag> <n2m-g.cla2a1.3vvcfu5.1@buzzy-box.bavag>
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
User-Agent: slrn/0.9.8.1 (Win32) Hamster/2.0.6.0
To: cygwin-patches@cygwin.com
In-Reply-To: <n2m-g.cla2a1.3vvcfu5.1@buzzy-box.bavag>
Date: Sat, 23 Oct 2004 20:17:00 -0000
X-SW-Source: 2004-q4/txt/msg00077.txt.bz2

Op Fri, 22 Oct 2004 04:34:05 +0200 (MET DST) schreef Bas van Gompel
in <n2m-g.cla2a1.3vvcfu5.1@buzzy-box.bavag>:
[...]

:  D**n, the leading newline was lost...

...and I checked in CRLF's in the Changelog...

...Ain't I doing great. :(


ChangeLog-entry:

2004-10-23  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>

	* ChangeLog: Fix line-endings on previous entry.
	* cygcheck.cc (dump_sysinfo): Add leading newline before legend for
	drive-list.


--- cygcheck.cc	22 Oct 2004 01:29:10 -0000	1.55
+++ cygcheck.cc	23 Oct 2004 18:01:20 -0000
@@ -1160,7 +1160,7 @@ dump_sysinfo ()
   SetErrorMode (prev_mode);
   if (givehelp)
     {
-      puts (
+      puts ("\n"
 	  "fd = floppy,          hd = hard drive,       cd = CD-ROM\n"
 	  "net= Network Share,   ram= RAM drive,        unk= Unknown\n"
 	  "CP = Case Preserving, CS = Case Sensitive,   UN = Unicode\n"


L8r,

Buzz. (Can I check this in? I'll try not to let it happen again.)
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
