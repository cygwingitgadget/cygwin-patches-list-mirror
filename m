Return-Path: <cygwin-patches-return-5189-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28131 invoked by alias); 5 Dec 2004 07:35:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27891 invoked from network); 5 Dec 2004 07:35:23 -0000
Received: from unknown (HELO green.qinip.net) (62.100.30.36)
  by sourceware.org with SMTP; 5 Dec 2004 07:35:23 -0000
Received: from buzzy-box (hmm-dca-ap02-d11-120.dial.freesurf.nl [195.18.124.120])
	by green.qinip.net (Postfix) with SMTP
	id 5CCEC42B5; Sun,  5 Dec 2004 08:34:48 +0100 (MET)
Message-ID: <n2m-g.couh2d.3vsgd8l.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: Re: [Patch] fhandler.cc: Don't worry about SPC in __small_printf-format
References: <n2m-g.cou710.3vsjtgl.1@buzzy-box.bavag> <20041205053733.GA21703@trixie.casa.cgf.cx>
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
User-Agent: slrn/0.9.8.1 (Win32) Hamster/2.0.6.0 Korrnews/4.2
To: cygwin-patches@cygwin.com
In-Reply-To: <20041205053733.GA21703@trixie.casa.cgf.cx>
Date: Sun, 05 Dec 2004 07:35:00 -0000
X-SW-Source: 2004-q4/txt/msg00190.txt.bz2

Op Sun, 5 Dec 2004 00:37:33 -0500 schreef Christopher Faylor
in <20041205053733.GA21703@trixie.casa.cgf.cx>:
:  On Sun, Dec 05, 2004 at 05:44:24AM +0100, Bas van Gompel wrote:
: > 2004-12-05  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>
: >
: > 	* fhandler.cc (fhandler_base::read): Remove superfluous check in
: > 	__small_sprintf format for strace.
:
:   Ok.  Please checkin.

Thanks. Done.


L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
