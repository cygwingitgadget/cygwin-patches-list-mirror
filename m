Return-Path: <cygwin-patches-return-6420-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1121 invoked by alias); 26 Feb 2009 18:04:10 -0000
Received: (qmail 978 invoked by uid 22791); 26 Feb 2009 18:04:07 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 26 Feb 2009 18:03:54 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 2917A6D418B; Thu, 26 Feb 2009 19:03:43 +0100 (CET)
Date: Thu, 26 Feb 2009 18:04:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] gethostbyname2
Message-ID: <20090226180343.GA18319@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0KFO009T9G34ZQ6E@vms173009.mailsrvcs.net> <08f301c99827$095c9a20$4e0410ac@wirelessworld.airvananet.com> <20090226160524.GY18319@calimero.vinschen.de> <091301c9983b$5e9debb0$4e0410ac@wirelessworld.airvananet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <091301c9983b$5e9debb0$4e0410ac@wirelessworld.airvananet.com>
User-Agent: Mutt/1.5.19 (2009-02-20)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2009-q1/txt/msg00018.txt.bz2

On Feb 26 12:55, Pierre A. Humblet wrote:
> From: "Corinna Vinschen"
> | I'm sorry, but I really don't understand what you mean.  How are you
> | undoing work in minires when using minires in gethostbyname2?!?  Why
> | isn't it just possible to call res_query from there?
> 
> It is possible of course. But the sequence would be the following
> 1) External DNS server sends compressed records to Windows resolver
> 2) Windows resolver uncompresses the records and puts them in nice structures
> 3) Minires takes the nice structures and recompresses them to wire format
> 4) Gethostbyname2 uncompresses them into nice structures
>     then 5) calls dup_ent,  which copies them in the tls.locals
> I would like to streamline the process:
> - With Windows resolver: 1, 2, 5  (that's the current patch, ~20% of  which is
>          cut&pasted from minires and could be restructured to use a common function)
> - Without: Straight fom wire format records to the tls.locals memory block
>                  Or: have a routine 2a) in minires that replaces 2. Then it would be 1, 2a, 5.

Uh, I see.  Well, you could change the minires code so that there is an
internal interface which can be used from net.cc or, FWIW, any other
part of Cygwin to optimize the above process.  If you really think
it's necessary to move gethostbyname2 to the minires sources, go for it.
However, in the long run I think it's better to keep gethostbyname2 in
net.cc and to have an optimized internal resolver interface for this
kind of call.

> | I never used the DnsQuery functions myself.  There's a DnsQuery flag
> | called DNS_QUERY_NO_NETBT documented in MSDN, maybe there's something
> | switched off on your machine so that's the default?
> 
> Perhaps. But where is it or how does the native gethostbyname turn it on?

Did you search on the net?  I have honestly no idea why this happens and
I would have to do the same, sorry.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
