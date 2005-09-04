Return-Path: <cygwin-patches-return-5639-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20021 invoked by alias); 4 Sep 2005 03:06:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19999 invoked by uid 22791); 4 Sep 2005 03:06:02 -0000
Received: from green.qinip.net (HELO green.qinip.net) (62.100.30.36)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Sun, 04 Sep 2005 03:06:02 +0000
Received: from buzzy-box (hmm-dca-ap03-d02-029.dial.freesurf.nl [62.100.1.29])
	by green.qinip.net (Postfix) with SMTP
	id 8EB27428D; Sun,  4 Sep 2005 05:05:57 +0200 (MET DST)
Message-ID: <n2m-g.dfdcb0.3vv82fr.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: Re: [patch] Don't append extra NUL to registry-strings.
References: <n2m-g.detf2n.3vv9c19.1@buzzy-box.bavag> <20050829082119.GA24845@calimero.vinschen.de>
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
User-Agent: slrn/0.9.8.1 (Win32) Hamster/2.0.7.0 KorrNews/4.2
To: cygwin-patches@cygwin.com
In-Reply-To: <20050829082119.GA24845@calimero.vinschen.de>
Date: Sun, 04 Sep 2005 03:06:00 -0000
X-SW-Source: 2005-q3/txt/msg00094.txt.bz2

Op Mon, 29 Aug 2005 10:21:19 +0200 schreef Corinna Vinschen
in <20050829082119.GA24845@calimero.vinschen.de>:
:  On Aug 28 22:49, Bas van Gompel wrote:
: > Hi,
: >
: > When RegQueryValueEx returns a string-type, the final NUL is included
: > in the returned size. I suggest dropping it.
:
:  I see what you're up to, but there would be two reasons not to drop the
:  trailing \0.  First, the \0 is part of the "file content" in a way.  

Don't file-systems have their own way of reporting ends (EOF)?

:  Second, it would break backward compatibility with applications using
:  /proc/registry.  This latter point concerns me a bit, though it can
:  naturally only affect Cygwin applications.

Hmmm... :( ... possibly the CYGWIN-environment-variable might have room
for something like ``registry:raw,data'' (default, for  now) to mean
``as is'', and other options might cause various levels of verbosity/
interpretation... (I know SHTDI, but would P be TC for such a thing?)


L8r,
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
