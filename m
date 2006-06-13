Return-Path: <cygwin-patches-return-5895-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 301 invoked by alias); 13 Jun 2006 15:52:13 -0000
Received: (qmail 32759 invoked by uid 22791); 13 Jun 2006 15:52:12 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Tue, 13 Jun 2006 15:52:11 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id DBB92544001; Tue, 13 Jun 2006 17:52:08 +0200 (CEST)
Date: Tue, 13 Jun 2006 15:52:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Open sockets non-overlapped?
Message-ID: <20060613155208.GO16683@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <ba40711f0605190819h4dfc5870l18a1919149a4f2d9@mail.gmail.com> <01cf01c67b5c$d78bd130$a501a8c0@CAM.ARTIMI.COM> <20060612131046.GC2129@calimero.vinschen.de> <ba40711f0606121843n11ad2155g5fa37362e91c401e@mail.gmail.com> <ba40711f0606121959g2a1acf17g5e6963e811676f71@mail.gmail.com> <20060613083243.GC16683@calimero.vinschen.de> <ba40711f0606130411m5d56ecc0jae17571d7d192d44@mail.gmail.com> <ba40711f0606130847mba77fd5h84f329096fdbf847@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba40711f0606130847mba77fd5h84f329096fdbf847@mail.gmail.com>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00083.txt.bz2

On Jun 13 11:47, Lev Bishop wrote:
> On 6/13/06, Lev Bishop  wrote:
> >On 6/13/06, Corinna Vinschen wrote:
> >> On Jun 12 22:59, Lev Bishop wrote:
> >> > Ok. I just did setup sshd, and I do see those issues, or something
> >> > similar (pressing the return key doesn't seem to help with the
> >> > interactive logon for me). I wonder what sshd does that everything
> >> > else i was using doesn't do.
> >>
> >> Non-blocking sockets?  User context switching?
> >
> >Possibly. But my money right now is on fork()ing.
> 
> It seems it's hanging in fhandler_socket::close(), when the child
> process closes the listening socket.

Hanging?  Or looping endlessly with WSAEWOULDBLOCK?  Any change when not
setting the linger option, maybe?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
