Return-Path: <cygwin-patches-return-6920-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10688 invoked by alias); 15 Jan 2010 15:42:20 -0000
Received: (qmail 10666 invoked by uid 22791); 15 Jan 2010 15:42:19 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 15 Jan 2010 15:42:14 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id DBA206D417D; Fri, 15 Jan 2010 16:42:03 +0100 (CET)
Date: Fri, 15 Jan 2010 15:42:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: dup3/O_CLOEXEC/F_DUPFD_CLOEXEC
Message-ID: <20100115154203.GA5885@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20100113212537.GB14511@calimero.vinschen.de>  <4B4E96D3.90300@byu.net>  <20100114114700.GC3428@calimero.vinschen.de>  <20100114115711.GD3428@calimero.vinschen.de>  <4B4F15FB.1050309@byu.net>  <20100114131744.GA26286@calimero.vinschen.de>  <0KW8000XUOMKUEK7@vms173003.mailsrvcs.net>  <20100114160953.GB26286@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100114160953.GB26286@calimero.vinschen.de>
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
X-SW-Source: 2010-q1/txt/msg00036.txt.bz2

On Jan 14 17:09, Corinna Vinschen wrote:
> On Jan 14 08:39, Pierre A. Humblet wrote:
> > At 08:17 AM 1/14/2010, Corinna Vinschen wrote:
> > >On Jan 14 06:02, Eric Blake wrote:
> > >> In a multi-threaded app, any fd that is opened only temporarily, such as
> > >> the one in mq_open, should be opened with O_CLOEXEC, so that no other
> > >> thread can win a race and do a fork/exec inside the window when the
> > >> temporary fd was open.  So even though mq_open does not leak an fd to the
> > >> current process, it should pass O_CLOEXEC as part of its internal open()
> > >> call in order to avoid leaking the fd to unrelated child processes.
> > >
> > >Uh, ok, that makes sense.
> > >
> > >I'll send a revised patch later today.  It will also include the pipe2
> > >implementation.
> > 
> > For the same reason we should also have SOCK_CLOEXEC, and
> > SOCK_NONBLOCK while we are at it. I would use them in minires.
> 
> Sure, but probably not yet, as far as my hack time is concerned.  But
> of course SHTDI, PTC, and all that.  I'd be glad for it, actually.

It was simpler than I anticipated.  I just applied a patch to implement
accept4, and SOCK_NONBLOCK as well as SOCK_CLOEXEC for socket,
socketpair and accept4.


HTH,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
