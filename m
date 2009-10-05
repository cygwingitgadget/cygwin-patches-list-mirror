Return-Path: <cygwin-patches-return-6708-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9644 invoked by alias); 5 Oct 2009 20:49:21 -0000
Received: (qmail 9632 invoked by uid 22791); 5 Oct 2009 20:49:21 -0000
X-SWARE-Spam-Status: No, hits=-3.5 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out1.smtp.messagingengine.com (HELO out1.smtp.messagingengine.com) (66.111.4.25)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 05 Oct 2009 20:49:17 +0000
Received: from compute2.internal (compute2.internal [10.202.2.42]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id BB11A83882 	for <cygwin-patches@cygwin.com>; Mon,  5 Oct 2009 16:49:15 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])   by compute2.internal (MEProxy); Mon, 05 Oct 2009 16:49:15 -0400
Received: from [192.168.1.3] (user-0c6sbc4.cable.mindspring.com [24.110.45.132]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id 584B71F087; 	Mon,  5 Oct 2009 16:49:15 -0400 (EDT)
Message-ID: <4ACA5BC7.6090908@cwilson.fastmail.fm>
Date: Mon, 05 Oct 2009 20:49:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Add wrappers for ExitProcess, TerminateProcess
References: <4ACA4323.5080103@cwilson.fastmail.fm> <20091005202722.GG12789@calimero.vinschen.de>
In-Reply-To: <20091005202722.GG12789@calimero.vinschen.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00039.txt.bz2

Corinna Vinschen wrote:
> I have some doubts that we really need such a functionality externally
> available, outside of the limited scenario of something like
> pseudo-reloc.  An API for those knowing what this is about is very
> likely sufficient.  What about
> 
>    cygwin_internal (CW_TERMINATE_PROCESS);
>    cygwin_internal (CW_EXIT_PROCESS);


hmm...probably
     cygwin_internal (CW_TERMINATE_PROCESS, HANDLE, UINT)
     cygwin_internal (CW_EXIT_PROCESS, UINT)
right?


> No new entry point, no need to document it.

I have no objection.  Once I finished it and went back to write the
documentation and the email, I realized and documented that since you're
still skipping over a lot of the cygwin cleanup code:

Ordinarily, however, the ANSI abort() or the POSIX _exit() function
should be preferred over either TerminateProcess or
cygwin_terminate_process when used to terminate the current process.
Similarly, the POSIX kill() function should be used to terminate cygwin
processes other than the current one.

and

Ordinarily, however, the ANSI exit() function should be preferred over
either ExitProcess or cygwin_exit_process

If we do it as a cygwin_internal call, we can always expose it later if
we decide that doing so would be valuable -- but you can't go the other way.

I'll work on a re-revised version this evening.

--
Chuck
