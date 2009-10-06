Return-Path: <cygwin-patches-return-6711-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30521 invoked by alias); 6 Oct 2009 03:42:43 -0000
Received: (qmail 30510 invoked by uid 22791); 6 Oct 2009 03:42:42 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-48-2.bstnma.east.verizon.net (HELO cgf.cx) (173.76.48.2)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 06 Oct 2009 03:42:39 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 4E85E3B0002 	for <cygwin-patches@cygwin.com>; Mon,  5 Oct 2009 23:42:29 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 304442B352; Mon,  5 Oct 2009 23:42:29 -0400 (EDT)
Date: Tue, 06 Oct 2009 03:42:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add wrappers for ExitProcess, TerminateProcess
Message-ID: <20091006034229.GA12172@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4ACA4323.5080103@cwilson.fastmail.fm>  <20091005202722.GG12789@calimero.vinschen.de>  <4ACA5BC7.6090908@cwilson.fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ACA5BC7.6090908@cwilson.fastmail.fm>
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
X-SW-Source: 2009-q4/txt/msg00042.txt.bz2

On Mon, Oct 05, 2009 at 04:49:11PM -0400, Charles Wilson wrote:
>Corinna Vinschen wrote:
>> I have some doubts that we really need such a functionality externally
>> available, outside of the limited scenario of something like
>> pseudo-reloc.  An API for those knowing what this is about is very
>> likely sufficient.  What about
>> 
>>    cygwin_internal (CW_TERMINATE_PROCESS);
>>    cygwin_internal (CW_EXIT_PROCESS);
>
>
>hmm...probably
>     cygwin_internal (CW_TERMINATE_PROCESS, HANDLE, UINT)
>     cygwin_internal (CW_EXIT_PROCESS, UINT)
>right?

Do we really have to provide the ability to kill some other process?
Maybe we really only need one call with two arguments - one which is the
exit value and one which indicates whether to exit with prejudice.

cygwin_internal (CW_EXIT_PROCESS, UINT, bool);

where the bool argument is true if we want to call TerminateProcess on
this process.

cgf
