Return-Path: <cygwin-patches-return-5147-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12895 invoked by alias); 20 Nov 2004 18:48:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12864 invoked from network); 20 Nov 2004 18:48:36 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 20 Nov 2004 18:48:36 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id AEEDA1B3E5; Sat, 20 Nov 2004 13:49:13 -0500 (EST)
Date: Sat, 20 Nov 2004 18:48:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
Message-ID: <20041120184913.GA2765@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20041116155640.GA22397@trixie.casa.cgf.cx> <3.0.5.32.20041111224857.00819b20@incoming.verizon.net> <3.0.5.32.20041111224857.00819b20@incoming.verizon.net> <3.0.5.32.20041111235225.00818340@incoming.verizon.net> <20041114051158.GG7554@trixie.casa.cgf.cx> <20041116054156.GA17214@trixie.casa.cgf.cx> <419A1F7B.8D59A9C9@phumblet.no-ip.org> <20041116155640.GA22397@trixie.casa.cgf.cx> <3.0.5.32.20041120125458.00821b80@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20041120125458.00821b80@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00148.txt.bz2

On Sat, Nov 20, 2004 at 12:54:58PM -0500, Pierre A. Humblet wrote:
>At 01:23 AM 11/20/2004 -0500, Christopher Faylor wrote:
>>On Tue, Nov 16, 2004 at 10:56:40AM -0500, Christopher Faylor wrote:
>>I've also added an 'exitcode' field to _pinfo so that a Cygwin process
>>will set the error code in a UNIX fashion based on whether it is exiting
>>due to a signal or with a normal exit().  Unfortunately, this means that
>>I don't know quite what to do with exit codes from Windows processes.
>>This is the last remaining problem before I check things in.  This
>>problem just occurred to me as I was typing in the ChangeLog and it may
>>be the one reason why you actually need to do the reparenting tango.
>
>For Windows process, why can't you keep doing what was done before
>            case WAIT_OBJECT_0:
>              sigproc_printf ("subprocess exited");
>              DWORD exitcode;
>              if (!GetExitCodeProcess (pi.hProcess, &exitcode))
>                exitcode = 1;
>
>and copy the Windows exit code to the exitcode field? Or did you remove the
>subproc_ready as well?

Yes, all of the reparenting logic is gone, including "subproc_ready"; at
least as far as exec is concerned.  hProcess doesn't exist in _pinfo
anymore.

I got the functionality back by essentially implementing reparenting in
a different way, but, now that I've done this, it seems that I don't
need the pipe anymore, even though it does make communication between a
parent and child convenient.  So, I still have some cogitating to do.

That's ok.  Sleep is overrated.

cgf
