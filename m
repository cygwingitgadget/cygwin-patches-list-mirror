Return-Path: <cygwin-patches-return-5032-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5369 invoked by alias); 7 Oct 2004 02:05:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5311 invoked from network); 7 Oct 2004 02:05:21 -0000
Message-ID: <n2m-g.ck2dco.3vshr73.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: Re: [Patch] cygcheck: warn about empty path-components
References: <n2m-g.cjth8v.3vsj9uv.1@buzzy-box.bavag> <20041005081629.GI6702@cygbert.vinschen.de> <Pine.CYG.4.58.0410050902580.5620@fordpc.vss.fsi.com> <20041005143458.GB13719@trixie.casa.cgf.cx> <20041005144649.GB30752@cygbert.vinschen.de> <n2m-g.ck0h06.3vvequf.1@buzzy-box.bavag> <20041006094939.GS6702@cygbert.vinschen.de>
In-Reply-To: <20041006094939.GS6702@cygbert.vinschen.de>
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
To: cygwin-patches@cygwin.com
Date: Thu, 07 Oct 2004 02:05:00 -0000
X-SW-Source: 2004-q4/txt/msg00033.txt.bz2

Op Wed, 6 Oct 2004 11:49:39 +0200 schreef Corinna Vinschen
in <20041006094939.GS6702@cygbert.vinschen.de>:
:  On Oct  6 10:49, Bas van Gompel wrote:
: > Op Tue, 5 Oct 2004 16:46:49 +0200 schreef Corinna Vinschen
: > in <20041005144649.GB30752@cygbert.vinschen.de>:
: >
: > [Empty path-components resolving to current dir.]

[...]

: > Are you applying the patch?
:
:  I did, but I'm wondering if a check for relative paths wouldn't be
:  more useful.

I'll see if I can whip up something (trivial) in the not too far future.
(If noone beats me to it.)

BTW: Applying this (empty path-components) patch apparently caused some
TABs to be replaced by 8 spaces, somehow...

L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
