Return-Path: <cygwin-patches-return-5240-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13426 invoked by alias); 17 Dec 2004 21:00:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13353 invoked from network); 17 Dec 2004 21:00:35 -0000
Received: from unknown (HELO green.qinip.net) (62.100.30.36)
  by sourceware.org with SMTP; 17 Dec 2004 21:00:35 -0000
Received: from buzzy-box (hmm-dca-ap02-d05-015.dial.freesurf.nl [195.18.78.15])
	by green.qinip.net (Postfix) with SMTP
	id 33AD344B2; Fri, 17 Dec 2004 21:59:57 +0100 (MET)
Message-ID: <n2m-g.cpvkqo.3vvegs9.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: Re: [Patch] cygcheck: eprintf + display_error: Do /something/.
References: <n2m-g.cpt7kf.3vvb68n.1@buzzy-box.bavag> <20041217020205.GA26712@trixie.casa.cgf.cx> <n2m-g.cptl2c.3vvd6ov.1@buzzy-box.bavag> <20041217025607.GE26712@trixie.casa.cgf.cx> <n2m-g.cptncf.3vv6gv7.1@buzzy-box.bavag> <20041217061932.GH26712@trixie.casa.cgf.cx> <n2m-g.cpu9so.3vvckrb.1@buzzy-box.bavag> <20041217094301.GG9277@cygbert.vinschen.de>
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
User-Agent: slrn/0.9.8.1 (Win32) Hamster/2.0.6.0 Korrnews/4.2
To: cygwin-patches@cygwin.com
In-Reply-To: <20041217094301.GG9277@cygbert.vinschen.de>
Date: Fri, 17 Dec 2004 21:00:00 -0000
X-SW-Source: 2004-q4/txt/msg00241.txt.bz2

Op Fri, 17 Dec 2004 10:43:01 +0100 schreef Corinna Vinschen
in <20041217094301.GG9277@cygbert.vinschen.de>:
:  On Dec 17 09:46, Bas van Gompel wrote:
: > Op Fri, 17 Dec 2004 01:19:32 -0500 schreef Christopher Faylor
: > in <20041217061932.GH26712@trixie.casa.cgf.cx>:
[...]
: > :   Ok.  I don't see any reason to check for ttyness, then.  If this is an issue
: > :  then lets just flush stdout prior to doing anything with stderr.  Flushing
: > :  stderr should always be a no-op.
: >
: > It isn't (a no-op). (See the snippet in my previous mail.) Is this a
: > difference between cygwin and mingw, maybe?
:
:  Hmm, if stderr is not unbuffered in mingw, then that should be fixed
:  in mingw, shouldn't it?

I guess so...

I'll try and look into this, if noone else does.

What about the patch? It shouldn't hurt, and the flush of stderr can
be removed, once this has been fixed in mingw.


L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
