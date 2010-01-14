Return-Path: <cygwin-patches-return-6910-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30957 invoked by alias); 14 Jan 2010 13:18:07 -0000
Received: (qmail 30940 invoked by uid 22791); 14 Jan 2010 13:18:06 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 14 Jan 2010 13:17:54 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 405806D417D; Thu, 14 Jan 2010 14:17:44 +0100 (CET)
Date: Thu, 14 Jan 2010 13:18:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: dup3/O_CLOEXEC/F_DUPFD_CLOEXEC
Message-ID: <20100114131744.GA26286@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20100113212537.GB14511@calimero.vinschen.de>  <4B4E96D3.90300@byu.net>  <20100114114700.GC3428@calimero.vinschen.de>  <20100114115711.GD3428@calimero.vinschen.de>  <4B4F15FB.1050309@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B4F15FB.1050309@byu.net>
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
X-SW-Source: 2010-q1/txt/msg00026.txt.bz2

On Jan 14 06:02, Eric Blake wrote:
> According to Corinna Vinschen on 1/14/2010 4:57 AM:
> >> time to do that via the O_CLOEXEC flag.
> > 
> > Hang on, the file is closed anyway after the mmap call succeeded.
> > That's not true for sem_open and shm_open, though.
> 
> Well, on Linux, it looks like sem_open does not need to keep the fd open.
>  It all boils down to the question of any API that can hand a new fd back
> to the user should have the ability to protect said fd with O_CLOEXEC at
> creation time.
> 
> > 
> > However, what kind of cleanup did you mean?  There's no EINVAL specified
> > in POSIX for invalid open flags and invalid flags are already filtered
> > out before calling open.
> 
> In a multi-threaded app, any fd that is opened only temporarily, such as
> the one in mq_open, should be opened with O_CLOEXEC, so that no other
> thread can win a race and do a fork/exec inside the window when the
> temporary fd was open.  So even though mq_open does not leak an fd to the
> current process, it should pass O_CLOEXEC as part of its internal open()
> call in order to avoid leaking the fd to unrelated child processes.

Uh, ok, that makes sense.

I'll send a revised patch later today.  It will also include the pipe2
implementation.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
