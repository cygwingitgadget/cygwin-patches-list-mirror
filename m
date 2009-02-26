Return-Path: <cygwin-patches-return-6415-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28348 invoked by alias); 26 Feb 2009 09:52:22 -0000
Received: (qmail 28338 invoked by uid 22791); 26 Feb 2009 09:52:22 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 26 Feb 2009 09:52:16 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 205EF6D418B; Thu, 26 Feb 2009 10:52:04 +0100 (CET)
Date: Thu, 26 Feb 2009 09:52:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] gethostbyname2
Message-ID: <20090226095204.GA6206@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0KFN00FS0N9EDVH2@vms173005.mailsrvcs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0KFN00FS0N9EDVH2@vms173005.mailsrvcs.net>
User-Agent: Mutt/1.5.19 (2009-02-20)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2009-q1/txt/msg00013.txt.bz2

On Feb 25 23:03, Pierre A. Humblet wrote:
> I tried to compile Exim with IPv6 enabled and Cygwin 1.7, but it needs 
> gethostbyname2.
> Here is an implementation of that function.
> In attachment I am including the same patch as well as a short test function.
>
> Pierre
>
>
>
> 2009-02-25  Pierre Humblet <Pierre.Humblet@ieee.org>
>
> 	* net.cc: Include windns.h.
> 	(gethostbyname2): New function.
> 	* cygwin.din: Export gethostbyname2.

This is way cool!  I have this function on my TODO list for ages.

But there's a problem.  You're using DnsQuery_A directly, but this
function only exists since Win2K.  Would it be a big problem to rework
the function to use the resolver functions instead?  They are part of
Cygwin now anyway and that would abstract gethostbyname2 from the
underlying OS capabilities.

The implications of having this function... for instance, we can
implement gethostbyname then in terms of gethostbyname2 and honor
the RES_USE_INET6 flag.  We could even drop relying on the Winsock
implementation of getaddrinfo/getnameinfo and use the Stevens
implementation exclusively.  Wow.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
