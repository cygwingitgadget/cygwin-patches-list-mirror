Return-Path: <cygwin-patches-return-5637-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9433 invoked by alias); 29 Aug 2005 08:21:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9418 invoked by uid 22791); 29 Aug 2005 08:21:22 -0000
Received: from mail-n.franken.de (HELO ilsa.franken.de) (193.175.24.27)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 29 Aug 2005 08:21:22 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])
	by ilsa.franken.de (Postfix) with ESMTP id 96A0F245C8
	for <cygwin-patches@cygwin.com>; Mon, 29 Aug 2005 10:21:20 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])
	by aqua.hirmke.de (Postfix) with ESMTP id 0E26CD6502
	for <cygwin-patches@cygwin.com>; Mon, 29 Aug 2005 10:21:20 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D6D76544122; Mon, 29 Aug 2005 10:21:19 +0200 (CEST)
Date: Mon, 29 Aug 2005 08:21:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] Don't append extra NUL to registry-strings.
Message-ID: <20050829082119.GA24845@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <n2m-g.detf2n.3vv9c19.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.detf2n.3vv9c19.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q3/txt/msg00092.txt.bz2

On Aug 28 22:49, Bas van Gompel wrote:
> Hi,
> 
> When RegQueryValueEx returns a string-type, the final NUL is included
> in the returned size. I suggest dropping it.

I see what you're up to, but there would be two reasons not to drop the
trailing \0.  First, the \0 is part of the "file content" in a way.  
Second, it would break backward compatibility with applications using
/proc/registry.  This latter point concerns me a bit, though it can
naturally only affect Cygwin applications.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
