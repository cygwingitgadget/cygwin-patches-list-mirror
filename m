Return-Path: <cygwin-patches-return-5034-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30005 invoked by alias); 7 Oct 2004 23:42:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29985 invoked from network); 7 Oct 2004 23:42:09 -0000
Message-ID: <n2m-g.ck4jdl.3vsg21n.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: Re: [Patch] cygcheck: warn about empty path-components
References: <n2m-g.cjth8v.3vsj9uv.1@buzzy-box.bavag> <20041005081629.GI6702@cygbert.vinschen.de> <Pine.CYG.4.58.0410050902580.5620@fordpc.vss.fsi.com> <20041005143458.GB13719@trixie.casa.cgf.cx> <20041005144649.GB30752@cygbert.vinschen.de> <n2m-g.ck0h06.3vvequf.1@buzzy-box.bavag> <20041006145805.GB29289@trixie.casa.cgf.cx> <n2m-g.ck2ctr.3vshr73.1@buzzy-box.bavag> <20041007021558.GL2722@trixie.casa.cgf.cx>
In-Reply-To: <20041007021558.GL2722@trixie.casa.cgf.cx>
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
To: cygwin-patches@cygwin.com
Date: Thu, 07 Oct 2004 23:42:00 -0000
X-SW-Source: 2004-q4/txt/msg00035.txt.bz2

Op Wed, 6 Oct 2004 22:15:58 -0400 schreef Christopher Faylor
in <20041007021558.GL2722@trixie.casa.cgf.cx>:
:  On Thu, Oct 07, 2004 at 04:05:14AM +0200, Bas van Gompel wrote:

[...]

: > s/-v/-h/. (I'm waiting for the other (trailing slash) patch to be
: > applied or rejected, before submitting this.)
:
:   I missed the part about the warning before but I *really* don't think we
:  need to warn the user about standard UNIX behavior in cygcheck.  That is
:  really not what's for.

It's for diagnosing problems with the cygwin-environment, isn't it?
The (to be) warned about condition is on the edge of windows and cygwin.
No windows or UNIX utility is going to warn about it.

[...]

: > :  Why are we bothering with this?
: >
: > If I may attempt to answer this one... Many people may not know of
: > this usage, yet may have their windows path ending on a ';'.
:
:   I'm sure the same thing is true on UNIX and yet it has survived for
:  years without a unicheck program informing people of this fact.

There are no windows paths in UNIX, and there is no unicheck program
for any purpose. Does this mean cygcheck should be removed?

What are you planning to do? Will you revert this patch, reject the
next patch and leave things as they are, or consider it when it's
submitted?

L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
