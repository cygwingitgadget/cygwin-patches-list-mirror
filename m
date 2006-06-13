Return-Path: <cygwin-patches-return-5893-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12074 invoked by alias); 13 Jun 2006 15:13:06 -0000
Received: (qmail 12062 invoked by uid 22791); 13 Jun 2006 15:13:05 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Tue, 13 Jun 2006 15:13:01 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 0E143544001; Tue, 13 Jun 2006 17:12:59 +0200 (CEST)
Date: Tue, 13 Jun 2006 15:13:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Open sockets non-overlapped?
Message-ID: <20060613151258.GM16683@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <ba40711f0606130411m5d56ecc0jae17571d7d192d44@mail.gmail.com> <02e701c68edb$433beaa0$a501a8c0@CAM.ARTIMI.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02e701c68edb$433beaa0$a501a8c0@CAM.ARTIMI.COM>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00081.txt.bz2

On Jun 13 12:19, Dave Korn wrote:
> On 13 June 2006 12:12, Lev Bishop wrote:
> 
> > On 6/13/06, Corinna Vinschen wrote:
> >> On Jun 12 22:59, Lev Bishop wrote:
> >>> Ok. I just did setup sshd, and I do see those issues, or something
> >>> similar (pressing the return key doesn't seem to help with the
> >>> interactive logon for me). I wonder what sshd does that everything
> >>> else i was using doesn't do.
> >> 
> >> Non-blocking sockets?  User context switching?
> > 
> > Possibly. But my money right now is on fork()ing.
> > 
> > Lev
> 
> 
>   Have either of you tried CYGWIN=tty vs. CYGWIN=notty in testing this?

When logging in through sshd, the terminal settings are always tty on
the server side.  I'm logging in from a remote Linux machine, so I
don't even have the choice for the client side.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
