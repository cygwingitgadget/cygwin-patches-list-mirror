Return-Path: <cygwin-patches-return-5031-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5308 invoked by alias); 7 Oct 2004 02:05:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5292 invoked from network); 7 Oct 2004 02:05:17 -0000
Message-ID: <n2m-g.ck2ctr.3vshr73.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: Re: [Patch] cygcheck: warn about empty path-components
References: <n2m-g.cjth8v.3vsj9uv.1@buzzy-box.bavag> <20041005081629.GI6702@cygbert.vinschen.de> <Pine.CYG.4.58.0410050902580.5620@fordpc.vss.fsi.com> <20041005143458.GB13719@trixie.casa.cgf.cx> <20041005144649.GB30752@cygbert.vinschen.de> <n2m-g.ck0h06.3vvequf.1@buzzy-box.bavag> <20041006145805.GB29289@trixie.casa.cgf.cx>
In-Reply-To: <20041006145805.GB29289@trixie.casa.cgf.cx>
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
To: cygwin-patches@cygwin.com
Date: Thu, 07 Oct 2004 02:05:00 -0000
X-SW-Source: 2004-q4/txt/msg00032.txt.bz2

Op Wed, 6 Oct 2004 10:58:05 -0400 schreef Christopher Faylor
in <20041006145805.GB29289@trixie.casa.cgf.cx>:
:  On Wed, Oct 06, 2004 at 10:49:09AM +0200, Bas van Gompel wrote:

[Empty path-components resolving to current dir.]

: > (Maybe the message could get a ``-v'' addition like: ``This will
: > resolve to the current directory when in cygwin''.)

s/-v/-h/. (I'm waiting for the other (trailing slash) patch to be
applied or rejected, before submitting this.)

:  I see that Corinna has checked this in but I really don't see the need
:  for a warning for a perfectly acceptable use of an empty PATH component.
:
:  Why are we bothering with this?

If I may attempt to answer this one... Many people may not know of
this usage, yet may have their windows path ending on a ';'.

L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
