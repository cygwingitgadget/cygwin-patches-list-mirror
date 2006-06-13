Return-Path: <cygwin-patches-return-5889-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6654 invoked by alias); 13 Jun 2006 08:21:54 -0000
Received: (qmail 6637 invoked by uid 22791); 13 Jun 2006 08:21:53 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Tue, 13 Jun 2006 08:21:50 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id AB885544008; Tue, 13 Jun 2006 10:21:47 +0200 (CEST)
Date: Tue, 13 Jun 2006 08:21:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Open sockets non-overlapped?
Message-ID: <20060613082147.GB16683@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <ba40711f0605190819h4dfc5870l18a1919149a4f2d9@mail.gmail.com> <01cf01c67b5c$d78bd130$a501a8c0@CAM.ARTIMI.COM> <20060612131046.GC2129@calimero.vinschen.de> <ba40711f0606121843n11ad2155g5fa37362e91c401e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba40711f0606121843n11ad2155g5fa37362e91c401e@mail.gmail.com>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00077.txt.bz2

On Jun 12 21:43, Lev Bishop wrote:
> It doesn't make it any less useful to native processes _as a socket
> handle_ but it does make a difference when the native processes use it
> _as a file handle_. As you know, the semantics of WriteFile() et al
> change completely depending on whether they get an overlapped handle
> or not (eg the LPOVERLAPPED parameter either _must_ be null or _must
> not_ be null [...]

Uh, yes, right.  I can see the potential benefit.  Is the behaviour
of ReadFile/WriteFile with overlapping sockets the same?  Did you try
to write a native testcase (not cygwin) to test this and find out
what happens when no Cygwin is involved at all?  This might give us
some interesting clews.

> Hmph. It works for me. Must be some difference in our configurations,
> windows versions, etc. I note that msdn warns that using socket
> handles as file handles is an optional feature and not all providers
> support it. I guess the provider must be both a Winsock provider and
> also a file-system driver in order to make this work. Maybe you have
> some LSPs on your machine or something?

XP SP2 w/ official updates, plus SFU NFS and a bluetooth stack.

Standard AF_INET sockets should usually work, though.  There's nothing
but standard file/socket types involved in this example.  After all,
I'm running `cmd /c dir' on my NTFS home dir and the AF_INET socket
provider is Microsoft's own.  Maybe I'm naive, but I would assume that
this problem would only happen with 3PPs.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
