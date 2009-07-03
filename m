Return-Path: <cygwin-patches-return-6551-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23859 invoked by alias); 3 Jul 2009 19:26:40 -0000
Received: (qmail 23846 invoked by uid 22791); 3 Jul 2009 19:26:39 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-98-110-183-121.bstnma.fios.verizon.net (HELO cgf.cx) (98.110.183.121)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 03 Jul 2009 19:26:33 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 381EE3B0008 	for <cygwin-patches@cygwin.com>; Fri,  3 Jul 2009 15:26:22 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id B43441A5661; Fri,  3 Jul 2009 15:26:21 -0400 (EDT)
Date: Fri, 03 Jul 2009 19:26:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: mkstemps
Message-ID: <20090703192620.GA2371@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4A46A3AB.2060604@byu.net>  <20090628103249.GX30864@calimero.vinschen.de>  <4A4DFA3E.2010909@byu.net>  <4A4DFAE4.3090008@byu.net>  <20090703130134.GB12258@calimero.vinschen.de>  <20090703151740.GA26910@ednor.casa.cgf.cx>  <4A4E59AE.60904@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A4E59AE.60904@byu.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00005.txt.bz2

On Fri, Jul 03, 2009 at 01:19:10PM -0600, Eric Blake wrote:
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>According to Christopher Faylor on 7/3/2009 9:17 AM:
>> Is there some reason why we're not just using the newlib version of all
>> of these functions?  I have stared at the code in mktemp.cc and the only
>> thing I see that seems to be Cygwin specific is the arc4random function.
>> Is the security that this provides the only reason not to use newlib?
>> 
>> That is probably a good enough reason right there but I was just
>> wondering.
>
>Well, before today, cygwin had mkdtemp but newlib didn't.  But you are
>correct that after today, the only substantial difference is getpid() vs.
>arc4random().  For mkstemp, this is not an issue.  But guess which one is
>more predictable, and thus makes for a less secure mktemp (even though we
>already have a compiler warning that mktemp is insecure)?
>
>Maybe it would be worth pushing the arc4random approach to newlib?

I'm not sure exactly how you'd do that.  Obviously you can use
/dev/random on linux.  For windows, you'd have to port windows-specific
functions to newlib.  I don't think there is any precedent for that.

Sounds like more work than it's worth.

Nevermind.

cgf
