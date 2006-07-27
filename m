Return-Path: <cygwin-patches-return-5943-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29823 invoked by alias); 27 Jul 2006 00:20:03 -0000
Received: (qmail 29764 invoked by uid 22791); 27 Jul 2006 00:20:02 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-29.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.29)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 27 Jul 2006 00:20:00 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 1BCA313C0F1; Wed, 26 Jul 2006 20:19:59 -0400 (EDT)
Date: Thu, 27 Jul 2006 00:20:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: check_iovec cleanup
Message-ID: <20060727001959.GA9442@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0607261730550.2352@PC1163-8460-XP.flightsafety.com> <20060726232029.GB5680@trixie.casa.cgf.cx> <Pine.CYG.4.58.0607261823240.1740@PC1163-8460-XP.flightsafety.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0607261823240.1740@PC1163-8460-XP.flightsafety.com>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00038.txt.bz2

On Wed, Jul 26, 2006 at 07:15:43PM -0500, Brian Ford wrote:
>On Wed, 26 Jul 2006, Christopher Faylor wrote:
>
>> Thanks for the patch,
>
>Thanks for the review.
>
>> but I'm not convinced that this patch duplicates the functionality that
>> you eliminated from check_iovec.
>
>It doesn't exactly, but the part it doesn't didn't seem correct.  See
>below.
>
>> And, the dummytest is actually there for a reason.
>
>Ok, then what *is* the reason for checking only the last byte of each
>iovec buffer for read or write-ability?  Doesn't it need to check a byte
>on every system page to be complete (because buffers could start in or
>span across invalid/protected virtual addresses)?  Should an error be
>flagged if the readv wouldn't have actually accessed the invalid addresses
>(I'm not sure here)?
>
>After my patch, if the iovec buffer addresses are invalid, they will
>either be flagged as such by the underlying Windows system call, or they
>will trigger the fault handler installed above by all check_iovec callers
>if the cygwin DLL code tries to access them, no?

The "underlying Windows system call" can throw an uncaught exception.
That's why we check first.

The check is there for a reason.  When I first moved to the exception
handling method, I took all of the checking out of the iovec stuff.  I
had to put it back in because it didn't work without it.

cgf
