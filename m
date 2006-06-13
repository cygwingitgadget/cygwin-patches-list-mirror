Return-Path: <cygwin-patches-return-5894-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30459 invoked by alias); 13 Jun 2006 15:47:32 -0000
Received: (qmail 30447 invoked by uid 22791); 13 Jun 2006 15:47:32 -0000
X-Spam-Check-By: sourceware.org
Received: from py-out-1112.google.com (HELO py-out-1112.google.com) (64.233.166.181)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 13 Jun 2006 15:47:30 +0000
Received: by py-out-1112.google.com with SMTP id c31so1901539pyd         for <cygwin-patches@cygwin.com>; Tue, 13 Jun 2006 08:47:28 -0700 (PDT)
Received: by 10.35.60.16 with SMTP id n16mr1642125pyk;         Tue, 13 Jun 2006 08:47:28 -0700 (PDT)
Received: by 10.35.30.7 with HTTP; Tue, 13 Jun 2006 08:47:28 -0700 (PDT)
Message-ID: <ba40711f0606130847mba77fd5h84f329096fdbf847@mail.gmail.com>
Date: Tue, 13 Jun 2006 15:47:00 -0000
From: "Lev Bishop" <lev.bishop@gmail.com>
To: cygwin-patches@cygwin.com
Subject: Re: Open sockets non-overlapped?
In-Reply-To: <ba40711f0606130411m5d56ecc0jae17571d7d192d44@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <ba40711f0605190819h4dfc5870l18a1919149a4f2d9@mail.gmail.com> 	 <01cf01c67b5c$d78bd130$a501a8c0@CAM.ARTIMI.COM> 	 <20060612131046.GC2129@calimero.vinschen.de> 	 <ba40711f0606121843n11ad2155g5fa37362e91c401e@mail.gmail.com> 	 <ba40711f0606121959g2a1acf17g5e6963e811676f71@mail.gmail.com> 	 <20060613083243.GC16683@calimero.vinschen.de> 	 <ba40711f0606130411m5d56ecc0jae17571d7d192d44@mail.gmail.com>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00082.txt.bz2

On 6/13/06, Lev Bishop  wrote:
> On 6/13/06, Corinna Vinschen wrote:
> > On Jun 12 22:59, Lev Bishop wrote:
> > > Ok. I just did setup sshd, and I do see those issues, or something
> > > similar (pressing the return key doesn't seem to help with the
> > > interactive logon for me). I wonder what sshd does that everything
> > > else i was using doesn't do.
> >
> > Non-blocking sockets?  User context switching?
>
> Possibly. But my money right now is on fork()ing.

It seems it's hanging in fhandler_socket::close(), when the child
process closes the listening socket.

Lev
