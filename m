Return-Path: <cygwin-patches-return-5042-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4901 invoked by alias); 10 Oct 2004 06:36:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4890 invoked from network); 10 Oct 2004 06:36:42 -0000
Message-ID: <n2m-g.ckaqe1.3vva6e9.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: Re: [Patch] cygcheck: warn about empty path-components
References: <Pine.CYG.4.58.0410050902580.5620@fordpc.vss.fsi.com> <20041005143458.GB13719@trixie.casa.cgf.cx> <20041005144649.GB30752@cygbert.vinschen.de> <n2m-g.ck0h06.3vvequf.1@buzzy-box.bavag> <20041006145805.GB29289@trixie.casa.cgf.cx> <n2m-g.ck2ctr.3vshr73.1@buzzy-box.bavag> <20041007021558.GL2722@trixie.casa.cgf.cx> <n2m-g.ck4jdl.3vsg21n.1@buzzy-box.bavag> <20041008001755.GK17593@trixie.casa.cgf.cx> <n2m-g.ck9k3i.3vvefmv.1@buzzy-box.bavag> <20041009231813.GD11984@trixie.casa.cgf.cx>
In-Reply-To: <20041009231813.GD11984@trixie.casa.cgf.cx>
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
To: cygwin-patches@cygwin.com
Date: Sun, 10 Oct 2004 06:36:00 -0000
X-SW-Source: 2004-q4/txt/msg00043.txt.bz2

Op Sat, 9 Oct 2004 19:18:13 -0400 schreef Christopher Faylor
in <20041009231813.GD11984@trixie.casa.cgf.cx>:
:  On Sun, Oct 10, 2004 at 12:41:20AM +0200, Bas van Gompel wrote:

[licensing/CA]

I'll be staying with the trivial patches until further notice...

Are CA-issues also on-topic for the licensing-ml?

: > (Would not corrections be misplaced in cygcheck?
: > Is ensuring correct permissions not something better handled in setup?)
:
:   It should probably done in both places.  It's easy enough to screw up
:  permissions after setup.exe has been run and it seems like it is hard
:  for setup to set permissions correctly since it is not a cygwin program.

So cygcheck will have the same problem...

How about doing it from a (postinstall-)script?

[ChangeLog-entry]

:  Checked in.  Thanks for the patch and special thanks for keeping the
:  dialog going about your patch.  Your persistence is appreciated.

Thank /you/. I was afraid you'd think I was a PITA!


L8r,

Buzz. :-)
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
