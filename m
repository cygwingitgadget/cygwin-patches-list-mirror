Return-Path: <cygwin-patches-return-5074-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18354 invoked by alias); 22 Oct 2004 02:34:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18345 invoked from network); 22 Oct 2004 02:34:08 -0000
Message-ID: <n2m-g.cla2a1.3vvcfu5.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: Re: [Patch] cygcheck: More complete helptext on drive-list.
References: <n2m-g.cl9oca.3vve76d.1@buzzy-box.bavag> <20041022000805.GF28112@trixie.casa.cgf.cx> <n2m-g.cl9v8k.3vv94fl.1@buzzy-box.bavag>
In-Reply-To: <n2m-g.cl9v8k.3vv94fl.1@buzzy-box.bavag>
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
To: cygwin-patches@cygwin.com
Date: Fri, 22 Oct 2004 02:34:00 -0000
X-SW-Source: 2004-q4/txt/msg00075.txt.bz2

Op Fri, 22 Oct 2004 03:40:52 +0200 (MET DST) schreef Bas van Gompel
in <n2m-g.cl9v8k.3vv94fl.1@buzzy-box.bavag>:
:  Op Thu, 21 Oct 2004 20:08:05 -0400 schreef Christopher Faylor
:  in <20041022000805.GF28112@trixie.casa.cgf.cx>:
::  On Fri, Oct 22, 2004 at 01:52:46AM +0200, Bas van Gompel wrote:
[...]
:: > 	* cygcheck.cc (dump_sysinfo): In legend for drive-list: Add ``ram'' and
:: > 	``unk''; Use single puts; Add leading newline; Line up equal-signs.
::
::   Check in, please but change the above semicolons to periods please.
:
: Done, thanks.


D**n, the leading newline was lost...


ChangeLog-entry:

2004-10-22  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>

	* cygcheck.cc (dump_sysinfo): Add leading newline before legend for
	drive-list.


--- cygcheck.cc.orig	2004-10-22 04:22:24.895923200 +0200
+++ cygcheck.cc	2004-10-22 04:09:28.779923200 +0200
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

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
