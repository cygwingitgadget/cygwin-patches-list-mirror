Return-Path: <cygwin-patches-return-5118-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8552 invoked by alias); 11 Nov 2004 02:17:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8535 invoked from network); 11 Nov 2004 02:17:27 -0000
Received: from unknown (HELO green.qinip.net) (62.100.30.36)
  by sourceware.org with SMTP; 11 Nov 2004 02:17:27 -0000
Received: from buzzy-box (hmm-dca-ap03-d13-105.dial.freesurf.nl [62.100.12.105])
	by green.qinip.net (Postfix) with SMTP
	id 57F41430D; Thu, 11 Nov 2004 03:17:19 +0100 (MET)
Message-ID: <n2m-g.cmulm7.3vv9c9d.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: Re: [Patch] cygcheck: Make keyeprint more versatile.
References: <n2m-g.cmu9aj.3vvcqe5.1@buzzy-box.bavag> <20041111003551.GA6196@trixie.casa.cgf.cx> <n2m-g.cmuj3k.3vv9c9d.1@buzzy-box.bavag> <20041111015736.GA6876@trixie.casa.cgf.cx>
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
User-Agent: slrn/0.9.8.1 (Win32) Hamster/2.0.6.0 Korrnews/4.2
To: cygwin-patches@cygwin.com
In-Reply-To: <20041111015736.GA6876@trixie.casa.cgf.cx>
Date: Thu, 11 Nov 2004 02:17:00 -0000
X-SW-Source: 2004-q4/txt/msg00119.txt.bz2

Op Wed, 10 Nov 2004 20:57:36 -0500 schreef Christopher Faylor
in <20041111015736.GA6876@trixie.casa.cgf.cx>:
:  On Thu, Nov 11, 2004 at 02:49:35AM +0100, Bas van Gompel wrote:
: > Op Wed, 10 Nov 2004 19:35:51 -0500 schreef Christopher Faylor
: >> Have I mentioned that I don't like the name 'keyeprint'?  It seems like
: >> an odd name to me.
: >
: > Well, why don't you change it to something sensible, then?
: > May I suggest:
: >
: > sed -i -e 's/keyeprint/display_error/' src/winsup/utils/cygcheck.cc
:
:   I've renamed this to display_error, as per your suggestion, and added
:  an abbreviated ChangeLog, giving you the credit.
:
:  Thanks.

T/U/VM.


L8r,
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
