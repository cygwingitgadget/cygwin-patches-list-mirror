Return-Path: <cygwin-patches-return-5081-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30565 invoked by alias); 26 Oct 2004 19:52:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30545 invoked from network); 26 Oct 2004 19:52:49 -0000
Message-ID: <n2m-g.cllkm1.3vvccd5.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: Re: [Patch] cygcheck: More complete helptext on drive-list.
References: <n2m-g.cl9oca.3vve76d.1@buzzy-box.bavag> <20041022000805.GF28112@trixie.casa.cgf.cx> <n2m-g.cl9v8k.3vv94fl.1@buzzy-box.bavag> <n2m-g.cla2a1.3vvcfu5.1@buzzy-box.bavag> <n2m-g.clektf.3vvfh6r.1@buzzy-box.bavag> <20041025155132.GA8428@coe.bosbc.com> <n2m-g.cljgae.3vvfvq3.1@buzzy-box.bavag> <20041025212807.GS27118@trixie.casa.cgf.cx>
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
User-Agent: slrn/0.9.8.1 (Win32) Hamster/2.0.6.0
To: cygwin-patches@cygwin.com
In-Reply-To: <20041025212807.GS27118@trixie.casa.cgf.cx>
Date: Tue, 26 Oct 2004 19:52:00 -0000
X-SW-Source: 2004-q4/txt/msg00082.txt.bz2

Op Mon, 25 Oct 2004 17:28:07 -0400 schreef Christopher Faylor
in <20041025212807.GS27118@trixie.casa.cgf.cx>:
:  On Mon, Oct 25, 2004 at 06:25:16PM +0200, Bas van Gompel wrote:
: > Op Mon, 25 Oct 2004 11:51:32 -0400 schreef Christopher Faylor

[Messed up ChangeLog-entry]

: > :   I fixed this and checked it in.  In general, you don't add ChangeLog entries
: > :  about the ChangeLog.
: >
: > Ok. (There are other instances...)
:
:   With the exception of the famous "subauth", the word "ChangeLog" does not show
:  up in any cygwin-specific ChangeLog that I can see.

You are of course correct.
The instances which fooled me into adding it are in w32api and cygwin-apps:

| w32api/ChangeLog:4225: * ChangeLog: Fix omission of name in recent entries.
| w32api/ChangeLog:4250: * ChangeLog: Fix typo in last entry.
| w32api/ChangeLog:4442: * ChangeLog: correct date in last entry.
| w32api/ChangeLog:4731: * ChangeLog: Fix typo in last entry.
| w32api/ChangeLog:8072: * ChangeLog started
| cygwin-apps/cygutils/ChangeLog:865:       * ChangeLog: fix tabs
| cygwin-apps/cygutils/ChangeLog:1682:      * ChangeLog: fix tabs
| cygwin-apps/setup/ChangeLog:258:  * ChangeLog: Fix broken line-wrapping throughout. Clarify that


L8r,

Buzz. (EOT|TITTTL?)
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
