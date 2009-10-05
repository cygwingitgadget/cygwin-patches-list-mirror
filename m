Return-Path: <cygwin-patches-return-6705-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1423 invoked by alias); 5 Oct 2009 20:27:39 -0000
Received: (qmail 1411 invoked by uid 22791); 5 Oct 2009 20:27:38 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 05 Oct 2009 20:27:33 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 0D9456D55B9; Mon,  5 Oct 2009 22:27:22 +0200 (CEST)
Date: Mon, 05 Oct 2009 20:27:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add wrappers for ExitProcess, TerminateProcess
Message-ID: <20091005202722.GG12789@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4ACA4323.5080103@cwilson.fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ACA4323.5080103@cwilson.fastmail.fm>
User-Agent: Mutt/1.5.17 (2007-11-01)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00036.txt.bz2

On Oct  5 15:04, Charles Wilson wrote:
> Normally, posix programs should call abort(), exit(), _exit(), kill() --
> or various pthread functions -- to terminate operation (either their
> own, or that of some other processes/thread).  However, there are two
> cases where the win32 ExitProcess and TerminateProcess functions might
> justifiably be called:
>   1) inside cygwin's own process startup/shutdown implementation
>   2) "Native" programs that use the w32api throughout, but are compiled
> using the cygwin compiler (e.g. without -mno-cygwin). [*]
> 
> However, the ExitProcess and TerminateProcess functions, when called
> directly, do not allow for the 'exit status' maintained by cygwin to be
> set. This can be a problem when such cygwin applications are exec'ed by
> other cygwin apps: cygwin's code for exec'ing children doesn't ever
> check the value of GetExitCodeProcess as set by these win32 functions,
> if the child application is also a cygwin app.
> 
> The attached patch address this problem, by providing two wrappers:
>   cygwin_terminate_process <--> TerminateProcess
>   cygwin_exit_process      <--> ExitProcess

I have some doubts that we really need such a functionality externally
available, outside of the limited scenario of something like
pseudo-reloc.  An API for those knowing what this is about is very
likely sufficient.  What about

   cygwin_internal (CW_TERMINATE_PROCESS);
   cygwin_internal (CW_EXIT_PROCESS);

No new entry point, no need to document it.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
