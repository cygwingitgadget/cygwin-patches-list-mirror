Return-Path: <cygwin-patches-return-6417-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29811 invoked by alias); 26 Feb 2009 16:05:46 -0000
Received: (qmail 29310 invoked by uid 22791); 26 Feb 2009 16:05:41 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 26 Feb 2009 16:05:36 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id E63DE6D418B; Thu, 26 Feb 2009 17:05:24 +0100 (CET)
Date: Thu, 26 Feb 2009 16:05:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] gethostbyname2
Message-ID: <20090226160524.GY18319@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0KFO009T9G34ZQ6E@vms173009.mailsrvcs.net> <08f301c99827$095c9a20$4e0410ac@wirelessworld.airvananet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08f301c99827$095c9a20$4e0410ac@wirelessworld.airvananet.com>
User-Agent: Mutt/1.5.19 (2009-02-20)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2009-q1/txt/msg00015.txt.bz2

On Feb 26 10:29, Pierre A. Humblet wrote:
> At 04:52 AM 2/26/2009, Corinna Vinschen wrote:
> | >On Feb 25 23:03, Pierre A. Humblet wrote:
> | > > I tried to compile Exim with IPv6 enabled and Cygwin 1.7, but it needs
> | > > gethostbyname2.
> | > > Here is an implementation of that function.
> | > > In attachment I am including the same patch as well as a short test function.
> | > >
> | >
> | >This is way cool!  I have this function on my TODO list for ages.
> | >
> | >But there's a problem.  You're using DnsQuery_A directly, but this
> | >function only exists since Win2K.  Would it be a big problem to rework
> | >the function to use the resolver functions instead?  They are part of
> | >Cygwin now anyway and that would abstract gethostbyname2 from the
> | >underlying OS capabilities.
> 
> I was afraid of that. Using res_query was my initial thought, but I realized that when using the
> Windows resolver I would undo in gethostbyname2 all the work done in minires.

I'm sorry, but I really don't understand what you mean.  How are you
undoing work in minires when using minires in gethostbyname2?!?  Why
isn't it just possible to call res_query from there?

> I am wondering if gethostbyname2 should not be moved out of  net.cc and integrated
> with minires. We could design shortcuts to use the most appropriate method.

I must be missing something serious here.  I'm puzzled why it matters
where gethostbyname2 is.  I was thinking of the resolver being basic
functionality.  The idea was to implement practically all subsequent
functions like gethostbyname, gethostbyaddr, getaddrinfo in terms of
resolver functions, as it is done in other libraries as well at one
point.  Why should applications be able to call res_query but not
Cygwin itself?

> I have read RFC 2133, section 6.1 . Do we want to implement having a
> RES_OPTIONS in the environment,  in  /etc/resolv.conf, or only by setting the
> appropriate flag in _res? What does Linux do?

Both.  But, if the general functionality (flag in _res) is present, we
can always add more functionality at some later point.  It's not a
pressing issue, I guess.

> I am still fighting one issue with Windows. On XP, when using the native gethostbyname
> I can resolve computers on my local net (through NetBIOS or such). But I can't get
> them with DnsQuery, except my own computer, despite what I think the doc says.
> Any insight?

I never used the DnsQuery functions myself.  There's a DnsQuery flag
called DNS_QUERY_NO_NETBT documented in MSDN, maybe there's something
switched off on your machine so that's the default?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
