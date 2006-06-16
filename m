Return-Path: <cygwin-patches-return-5898-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13718 invoked by alias); 16 Jun 2006 00:08:11 -0000
Received: (qmail 13677 invoked by uid 22791); 16 Jun 2006 00:08:11 -0000
X-Spam-Check-By: sourceware.org
Received: from py-out-1112.google.com (HELO py-out-1112.google.com) (64.233.166.183)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 16 Jun 2006 00:08:08 +0000
Received: by py-out-1112.google.com with SMTP id d80so423940pyd         for <cygwin-patches@cygwin.com>; Thu, 15 Jun 2006 17:08:07 -0700 (PDT)
Received: by 10.35.121.9 with SMTP id y9mr3800442pym;         Thu, 15 Jun 2006 17:08:07 -0700 (PDT)
Received: by 10.35.30.7 with HTTP; Thu, 15 Jun 2006 17:08:07 -0700 (PDT)
Message-ID: <ba40711f0606151708q32bd1045h883c7e20bb6983b6@mail.gmail.com>
Date: Fri, 16 Jun 2006 00:08:00 -0000
From: "Lev Bishop" <lev.bishop@gmail.com>
To: cygwin-patches@cygwin.com
Subject: Re: Open sockets non-overlapped?
In-Reply-To: <20060615164424.GA16683@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <ba40711f0605190819h4dfc5870l18a1919149a4f2d9@mail.gmail.com> 	 <20060612131046.GC2129@calimero.vinschen.de> 	 <ba40711f0606121843n11ad2155g5fa37362e91c401e@mail.gmail.com> 	 <ba40711f0606121959g2a1acf17g5e6963e811676f71@mail.gmail.com> 	 <20060613083243.GC16683@calimero.vinschen.de> 	 <ba40711f0606130411m5d56ecc0jae17571d7d192d44@mail.gmail.com> 	 <ba40711f0606130847mba77fd5h84f329096fdbf847@mail.gmail.com> 	 <20060613155208.GO16683@calimero.vinschen.de> 	 <ba40711f0606150907x9fb33efy463582520fa300f0@mail.gmail.com> 	 <20060615164424.GA16683@calimero.vinschen.de>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00086.txt.bz2

On 6/15/06, Corinna Vinschen wrote:
> On Jun 15 12:07, Lev Bishop wrote:

> > Just to spell it out: the problem shown in my testcase, is only
> > exibited with overlapped sockets. Non-overlapped don't have any
> > problem. Which is strange to me, since MSDN makes no mention of
> > situations where setsockopt() can block.
>
> Erm... I tested your testcase and I can reproduce the hang only when
> using NON-overlapped sockets  created with WSASocket(..., 0).
> It works fine with overlapped sockets created with select or
> WSASocket(..., WSA_FLAG_OVERLAPPED).  I assume the above is just a
> typo?

Yes, a typo, sorry about that.

L
