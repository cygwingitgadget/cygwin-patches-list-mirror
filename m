Return-Path: <cygwin-patches-return-5194-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30261 invoked by alias); 12 Dec 2004 02:22:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30228 invoked from network); 12 Dec 2004 02:22:45 -0000
Received: from unknown (HELO green.qinip.net) (62.100.30.36)
  by sourceware.org with SMTP; 12 Dec 2004 02:22:45 -0000
Received: from buzzy-box (hmm-dca-ap03-d04-188.dial.freesurf.nl [62.100.3.188])
	by green.qinip.net (Postfix) with SMTP
	id CC93E42E8; Sun, 12 Dec 2004 03:22:28 +0100 (MET)
Message-ID: <n2m-g.cpgdf0.3vvbhfd.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: Re: [Patch] fhandler.cc (pust_readahead): end-condition off.
References: <n2m-g.cp0gle.3vsh6i5.1@buzzy-box.bavag> <20041211085319.GA13243@cygbert.vinschen.de>
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
User-Agent: slrn/0.9.8.1 (Win32) Hamster/2.0.6.0 Korrnews/4.2
To: cygwin-patches@cygwin.com
In-Reply-To: <20041211085319.GA13243@cygbert.vinschen.de>
Date: Sun, 12 Dec 2004 02:22:00 -0000
X-SW-Source: 2004-q4/txt/msg00195.txt.bz2

Op Sat, 11 Dec 2004 09:53:19 +0100 schreef Corinna Vinschen
in <20041211085319.GA13243@cygbert.vinschen.de>:
:  On Dec  6 02:45, Bas van Gompel wrote:
[...]
: > 	* fhandler.cc (fhandler_base::puts_readahead): Fix end-condition.
:  Yes, that looks better.  I'd say the patch is correct.  Please apply.

Thanks, Done.


L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
