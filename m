Return-Path: <cygwin-patches-return-6716-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18230 invoked by alias); 6 Oct 2009 15:45:36 -0000
Received: (qmail 18217 invoked by uid 22791); 6 Oct 2009 15:45:34 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 06 Oct 2009 15:45:29 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 296E26D5598; Tue,  6 Oct 2009 17:45:19 +0200 (CEST)
Date: Tue, 06 Oct 2009 15:45:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add wrappers for ExitProcess, TerminateProcess
Message-ID: <20091006154519.GA24301@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4ACA4323.5080103@cwilson.fastmail.fm> <20091005202722.GG12789@calimero.vinschen.de> <4ACA5BC7.6090908@cwilson.fastmail.fm> <20091006034229.GA12172@ednor.casa.cgf.cx> <4ACAC079.2020105@cwilson.fastmail.fm> <20091006074620.GA13712@calimero.vinschen.de> <4ACB56D5.4060606@cwilson.fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ACB56D5.4060606@cwilson.fastmail.fm>
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
X-SW-Source: 2009-q4/txt/msg00047.txt.bz2

On Oct  6 10:40, Charles Wilson wrote:
> 2009-10-05  Charles Wilson  <...>
> 
> 	Add cygwin wrapper for ExitProcess and TerminateProcess.
> 	* include/sys/cygwin.h: Declare new cygwin_getinfo_type
> 	CW_EXIT_PROCESS.
> 	* external.cc (exit_process): New function.
> 	(cygwin_internal): Handle CW_EXIT_PROCESS.
> 	* pinfo.h (pinfo::set_exit_code): New method.
> 	* pinfo.cc (pinfo::set_exit_code): New, refactored from...
> 	(pinfo::maybe_set_exit_code_from_windows): here. Call it.
> 	* exceptions.cc: Move global variable sigExeced...
> 	* globals.cc: here.
> 
> OK?

Looks good to me.  Let's wait for Chris, though.  I have just one question.

> +static void
> +exit_process (UINT status, BOOL useTerminateProcess)
> +{
> +  pid_t pid = getpid ();
> +  external_pinfo * ep = fillout_pinfo (pid, 1);
> +  DWORD dwpid = ep ? ep->dwProcessId : pid;
> +  pinfo p (pid, PID_MAP_RW);
> +  if ((dwpid == GetCurrentProcessId()) && (p->pid == ep->pid))
> +    p.set_exit_code ((DWORD)status);
> +  if (useTerminateProcess)
> +    TerminateProcess (GetCurrentProcess(), status);
> +  /* avoid 'else' clause to silence warning */
> +  ExitProcess (status);
> +}

Shouldn't exit_process be marked with attribute(noreturn) or is the
optimizing effect negligible?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
