Return-Path: <cygwin-patches-return-5897-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19173 invoked by alias); 15 Jun 2006 16:44:29 -0000
Received: (qmail 19161 invoked by uid 22791); 15 Jun 2006 16:44:29 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Thu, 15 Jun 2006 16:44:27 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id D000E544001; Thu, 15 Jun 2006 18:44:24 +0200 (CEST)
Date: Thu, 15 Jun 2006 16:44:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Open sockets non-overlapped?
Message-ID: <20060615164424.GA16683@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <ba40711f0605190819h4dfc5870l18a1919149a4f2d9@mail.gmail.com> <01cf01c67b5c$d78bd130$a501a8c0@CAM.ARTIMI.COM> <20060612131046.GC2129@calimero.vinschen.de> <ba40711f0606121843n11ad2155g5fa37362e91c401e@mail.gmail.com> <ba40711f0606121959g2a1acf17g5e6963e811676f71@mail.gmail.com> <20060613083243.GC16683@calimero.vinschen.de> <ba40711f0606130411m5d56ecc0jae17571d7d192d44@mail.gmail.com> <ba40711f0606130847mba77fd5h84f329096fdbf847@mail.gmail.com> <20060613155208.GO16683@calimero.vinschen.de> <ba40711f0606150907x9fb33efy463582520fa300f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba40711f0606150907x9fb33efy463582520fa300f0@mail.gmail.com>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00085.txt.bz2

On Jun 15 12:07, Lev Bishop wrote:
> Actually, it's very strange. It gets stuck on the setsockopt() in
> fhandler_socket::close(). There's a race with the parent (which is why
> it didn't happen under strace or sshd -d), but if the parent gets
> round to doing its select() before the child does the close(), then
> the setsockopt() does not return until after the select() returns. I
> attach a short testcase which reliably demonstrates the problem for
> me. It doesn't use privilege separation or non-blocking sockets, so
> that is not the problem. I haven't investigated whether it's something
> to do with the way the socket is duplicated into the child
> (WSADuplicateSocket() versus DuplicateHandle(), and such).
> 
> Just to spell it out: the problem shown in my testcase, is only
> exibited with overlapped sockets. Non-overlapped don't have any
> problem. Which is strange to me, since MSDN makes no mention of
> situations where setsockopt() can block.

Erm... I tested your testcase and I can reproduce the hang only when
using NON-overlapped sockets  created with WSASocket(..., 0).
It works fine with overlapped sockets created with select or
WSASocket(..., WSA_FLAG_OVERLAPPED).  I assume the above is just a
typo?

> I think that's as far as I'm going to go with persuing this issue. If
> I need native programs to use sockets, then I'll pipe them through
> socat.

ACK.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
