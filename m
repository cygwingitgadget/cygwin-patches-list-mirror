Return-Path: <cygwin-patches-return-5061-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22954 invoked by alias); 15 Oct 2004 20:54:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22945 invoked from network); 15 Oct 2004 20:54:05 -0000
Message-ID: <n2m-g.ckpihh.3vsgh5n.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: Re: [Patch] testsuite and newlib's signal.h.
References: <n2m-g.ckmcqg.3vvbujf.1@buzzy-box.bavag> <20041014155559.GD22814@trixie.casa.cgf.cx>
In-Reply-To: <20041014155559.GD22814@trixie.casa.cgf.cx>
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
To: cygwin-patches@cygwin.com
Date: Fri, 15 Oct 2004 20:54:00 -0000
X-SW-Source: 2004-q4/txt/msg00062.txt.bz2

Op Thu, 14 Oct 2004 11:55:59 -0400 schreef Christopher Faylor
in <20041014155559.GD22814@trixie.casa.cgf.cx>:
:  On Thu, Oct 14, 2004 at 05:31:31PM +0200, Bas van Gompel wrote:
: > Another trivial patch, a bit kludgy...
: >
: > ATM the testsuite does not build, because
: > newlib/libc/include/sys/signal.h includes newlib/libc/include/signal.h.
:
:   This is a recent change to sys/signal.h and it is supposed to "just
:  work".  

I was aware of that.

:  If it isn't working then please report the problem to the newlib
:  mailing list.

I also noticed this change was instigated by you. As I'm not subscribed
to the newlib-list and have no idea of how to fix this, apart from
applying the patch, or undoing the newlib change, which I think is a
good thing in principle (the newlib change, not undoing it), I was
hoping you'd take action on this (or just apply the patch).

I'll subscribe the newlib-list, and --if you insist-- report there.


L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
