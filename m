Return-Path: <cygwin-patches-return-5640-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20306 invoked by alias); 4 Sep 2005 03:06:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20012 invoked by uid 22791); 4 Sep 2005 03:06:06 -0000
Received: from green.qinip.net (HELO green.qinip.net) (62.100.30.36)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Sun, 04 Sep 2005 03:06:06 +0000
Received: from buzzy-box (hmm-dca-ap03-d02-029.dial.freesurf.nl [62.100.1.29])
	by green.qinip.net (Postfix) with SMTP
	id 8D3AE44F5; Sun,  4 Sep 2005 05:06:00 +0200 (MET DST)
Message-ID: <n2m-g.dfddna.3vvbaub.1@buzzy-box.bavag>
From: "Buzz" <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: Re: [patch] Don't append extra NUL to registry-strings.
References: <20050829082119.GA24845@calimero.vinschen.de> <SERRANO4brJta07SaZ600000362@SERRANO.CAM.ARTIMI.COM>
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
User-Agent: slrn/0.9.8.1 (Win32) Hamster/2.0.7.0 KorrNews/4.2
To: cygwin-patches@cygwin.com
In-Reply-To: <SERRANO4brJta07SaZ600000362@SERRANO.CAM.ARTIMI.COM>
Date: Sun, 04 Sep 2005 03:06:00 -0000
X-SW-Source: 2005-q3/txt/msg00095.txt.bz2

Op Tue, 30 Aug 2005 11:33:16 +0100 schreef Dave Korn
in <SERRANO4brJta07SaZ600000362@SERRANO.CAM.ARTIMI.COM>:
:  ----Original Message----
: > From: Corinna Vinschen

[dropping NUL from strings returned by RegQueryValueEx]

: > trailing \0.  First, the \0 is part of the "file content" in a way.
:
:    To me this is the even more important reason.  Some registry strings do
:  include the trailing zero, some don't;

I don't see how this could be. The (MS) windows API-reference
(win32api.hlp) entry for RegQueryValueEx states (a.o.)

| REG_EXPAND_SZ	A null-terminated string that contains unexpanded
| references to environment variables (for example, "%PATH%"). It will
| be a Unicode or ANSI string depending on whether you use the Unicode
| or ANSI functions.
[...]
| REG_MULTI_SZ	An array of null-terminated strings, terminated by
| two null characters.
[..]
| REG_SZ	A null-terminated string. It will be a Unicode or ANSI string
| depending on whether you use the Unicode or ANSI functions.
[...]
| If the data has the REG_SZ, REG_MULTI_SZ or REG_EXPAND_SZ type, then
| lpData will also include the size of the terminating null character. 


:   cygwin shouldn't tamper with it.  And
:  it would seem _very_ wrong to me if by querying a value, and then using the
:  result returned to re-set the value, the value should change in length.

If/when writing to the registry becomes a fact, closing the file should
cause the terminating \0 to be added, IMO.

:    And since the patch unconditionally chops one off the size without
:  verifying whether or not the nul terminator is actually present, it would do
:  the wrong thing for some strings.

No. (See above.)


L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
