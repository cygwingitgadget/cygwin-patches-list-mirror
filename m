Return-Path: <cygwin-patches-return-5641-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20588 invoked by alias); 5 Sep 2005 10:03:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20573 invoked by uid 22791); 5 Sep 2005 10:03:08 -0000
Received: from mail-n.franken.de (HELO ilsa.franken.de) (193.175.24.27)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 05 Sep 2005 10:03:08 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])
	by ilsa.franken.de (Postfix) with ESMTP id 59950245CE
	for <cygwin-patches@cygwin.com>; Mon,  5 Sep 2005 12:03:06 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])
	by aqua.hirmke.de (Postfix) with ESMTP id 95EC8D6502
	for <cygwin-patches@cygwin.com>; Mon,  5 Sep 2005 12:03:05 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 4A048544122; Mon,  5 Sep 2005 12:03:05 +0200 (CEST)
Date: Mon, 05 Sep 2005 10:03:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] Don't append extra NUL to registry-strings.
Message-ID: <20050905100305.GA24044@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <n2m-g.detf2n.3vv9c19.1@buzzy-box.bavag> <20050829082119.GA24845@calimero.vinschen.de> <n2m-g.dfdcb0.3vv82fr.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.dfdcb0.3vv82fr.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q3/txt/msg00096.txt.bz2

On Sep  4 05:05, Bas van Gompel wrote:
> Op Mon, 29 Aug 2005 10:21:19 +0200 schreef Corinna Vinschen
> in <20050829082119.GA24845@calimero.vinschen.de>:
> :  On Aug 28 22:49, Bas van Gompel wrote:
> : > Hi,
> : >
> : > When RegQueryValueEx returns a string-type, the final NUL is included
> : > in the returned size. I suggest dropping it.
> :
> :  I see what you're up to, but there would be two reasons not to drop the
> :  trailing \0.  First, the \0 is part of the "file content" in a way.  
> 
> Don't file-systems have their own way of reporting ends (EOF)?

Er... that doesn't matter, does it?  What we have here is a virtual file
system which allows access to the "file" content of registry keys.  The
_SZ keys contain what the type name suggests, zero-terminated strings.
The trailing \0 is part of the "file" content as defined by MS.  There's
no gain in just removing it without notice.

> :  Second, it would break backward compatibility with applications using
> :  /proc/registry.  This latter point concerns me a bit, though it can
> :  naturally only affect Cygwin applications.
> 
> Hmmm... :( ... possibly the CYGWIN-environment-variable might have room
> for something like ``registry:raw,data'' (default, for  now) to mean
> ``as is'', and other options might cause various levels of verbosity/
> interpretation... (I know SHTDI, but would P be TC for such a thing?)

That sounds like a lot of trouble for... what exactly?  What are you
trying to accomplish which can't be handled by a simple filter, say,
tr(1)?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
