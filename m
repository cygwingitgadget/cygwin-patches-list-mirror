Return-Path: <cygwin-patches-return-6707-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5882 invoked by alias); 5 Oct 2009 20:39:32 -0000
Received: (qmail 5870 invoked by uid 22791); 5 Oct 2009 20:39:31 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-48-2.bstnma.east.verizon.net (HELO cgf.cx) (173.76.48.2)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 05 Oct 2009 20:39:26 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 114F33B0003 	for <cygwin-patches@cygwin.com>; Mon,  5 Oct 2009 16:39:17 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 0B4E12B352; Mon,  5 Oct 2009 16:39:17 -0400 (EDT)
Date: Mon, 05 Oct 2009 20:39:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add wrappers for ExitProcess, TerminateProcess
Message-ID: <20091005203916.GB9289@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4ACA4323.5080103@cwilson.fastmail.fm>  <20091005202722.GG12789@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091005202722.GG12789@calimero.vinschen.de>
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
X-SW-Source: 2009-q4/txt/msg00038.txt.bz2

On Mon, Oct 05, 2009 at 10:27:22PM +0200, Corinna Vinschen wrote:
>On Oct  5 15:04, Charles Wilson wrote:
>> Normally, posix programs should call abort(), exit(), _exit(), kill() --
>> or various pthread functions -- to terminate operation (either their
>> own, or that of some other processes/thread).  However, there are two
>> cases where the win32 ExitProcess and TerminateProcess functions might
>> justifiably be called:
>>   1) inside cygwin's own process startup/shutdown implementation
>>   2) "Native" programs that use the w32api throughout, but are compiled
>> using the cygwin compiler (e.g. without -mno-cygwin). [*]
>> 
>> However, the ExitProcess and TerminateProcess functions, when called
>> directly, do not allow for the 'exit status' maintained by cygwin to be
>> set. This can be a problem when such cygwin applications are exec'ed by
>> other cygwin apps: cygwin's code for exec'ing children doesn't ever
>> check the value of GetExitCodeProcess as set by these win32 functions,
>> if the child application is also a cygwin app.
>> 
>> The attached patch address this problem, by providing two wrappers:
>>   cygwin_terminate_process <--> TerminateProcess
>>   cygwin_exit_process      <--> ExitProcess
>
>I have some doubts that we really need such a functionality externally
>available, outside of the limited scenario of something like
>pseudo-reloc.  An API for those knowing what this is about is very
>likely sufficient.  What about
>
>   cygwin_internal (CW_TERMINATE_PROCESS);
>   cygwin_internal (CW_EXIT_PROCESS);
>
>No new entry point, no need to document it.

Big ditto, except obviously both of those need an extra exit code
argument.

cgf
