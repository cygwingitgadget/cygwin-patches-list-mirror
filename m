Return-Path: <cygwin-patches-return-5020-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9479 invoked by alias); 6 Oct 2004 08:49:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9469 invoked from network); 6 Oct 2004 08:49:37 -0000
Message-ID: <n2m-g.ck0h06.3vvequf.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: Re: [Patch] cygcheck: warn about empty path-components
References: <n2m-g.cjth8v.3vsj9uv.1@buzzy-box.bavag> <20041005081629.GI6702@cygbert.vinschen.de> <Pine.CYG.4.58.0410050902580.5620@fordpc.vss.fsi.com> <20041005143458.GB13719@trixie.casa.cgf.cx> <20041005144649.GB30752@cygbert.vinschen.de>
In-Reply-To: <20041005144649.GB30752@cygbert.vinschen.de>
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
User-Agent: slrn/0.9.8.0pl1 (CYGWIN_95-4.0) Hamster/2.0.6.0
To: cygwin-patches@cygwin.com
Date: Wed, 06 Oct 2004 08:49:00 -0000
X-SW-Source: 2004-q4/txt/msg00021.txt.bz2

Op Tue, 5 Oct 2004 16:46:49 +0200 schreef Corinna Vinschen
in <20041005144649.GB30752@cygbert.vinschen.de>:

[Empty path-components resolving to current dir.]

:  Oh, interesting.  I never even thought about using an empty path.

Nor I. Thw described behaviour makes the warning even more useful (when
cygcheck is run from a command/cmd prompt).

Are you applying the patch?

(Maybe the message could get a ``-v'' addition like: ``This will
resolve to the current directory when in cygwin''.)

L8r,
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^r
