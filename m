Return-Path: <cygwin-patches-return-5048-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30399 invoked by alias); 12 Oct 2004 22:11:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30390 invoked from network); 12 Oct 2004 22:11:18 -0000
Message-ID: <n2m-g.ckhq8e.3vvvbef.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: Re: [Patch] cygcheck: warn about empty path-components
References: <20041005144649.GB30752@cygbert.vinschen.de> <n2m-g.ck0h06.3vvequf.1@buzzy-box.bavag> <20041006145805.GB29289@trixie.casa.cgf.cx> <n2m-g.ck2ctr.3vshr73.1@buzzy-box.bavag> <20041007021558.GL2722@trixie.casa.cgf.cx> <n2m-g.ck4jdl.3vsg21n.1@buzzy-box.bavag> <20041008001755.GK17593@trixie.casa.cgf.cx> <n2m-g.ck9k3i.3vvefmv.1@buzzy-box.bavag> <20041009231813.GD11984@trixie.casa.cgf.cx> <n2m-g.ckaqe1.3vva6e9.1@buzzy-box.bavag> <20041010171323.GD14377@trixie.casa.cgf.cx>
In-Reply-To: <20041010171323.GD14377@trixie.casa.cgf.cx>
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
To: cygwin-patches@cygwin.com
Date: Tue, 12 Oct 2004 22:11:00 -0000
X-SW-Source: 2004-q4/txt/msg00049.txt.bz2

Op Sun, 10 Oct 2004 13:13:23 -0400 schreef Christopher Faylor
in <20041010171323.GD14377@trixie.casa.cgf.cx>:
:  On Sun, Oct 10, 2004 at 08:36:38AM +0200, Bas van Gompel wrote:
: > Op Sat, 9 Oct 2004 19:18:13 -0400 schreef Christopher Faylor
: > So cygcheck will have the same problem...
:
:   Right, but cygcheck can rely on the fact that cygwin1.dll is around, at
:  least, if necessary.

The dll is/should be around after setup ran (in install-mode), as well.

:  I guess a goal could be to come up with a generic
:  library which did sanity checking and corrections on cygwin permissions.

Which would than have to be linked statically, or suffer from it's
own permission-problems...

: > How about doing it from a (postinstall-)script?
:
:   A post-install script doesn't help if someone copied all of their stuff
:  to a CD-ROM and then to a new system.

I didn't think that was a supported procedure. (IOW: YOWTWYWT)
A post-install script does have the advantage of being run from within
cygwin.

:  We really should improve setup, too, but I still think we need this in
:  two places.

Probably. It could also be done from _cygwin_dll_entry, or some such.

:  Maybe we could get by with just having a sanity shell script that could
:  be run but it still seems like it should be tied into cygcheck somehow.
:
:  Or, maybe we need a "cygfix"...

Or more options to cygcheck:

-F: try to fix. (implies -s)
-p: print commands to execute to try to fix. (implies -qs)
-q: suppress normal output.


L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
