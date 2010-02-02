Return-Path: <cygwin-patches-return-6945-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17463 invoked by alias); 2 Feb 2010 02:08:54 -0000
Received: (qmail 17395 invoked by uid 22791); 2 Feb 2010 02:08:52 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-58-83.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.58.83)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 02 Feb 2010 02:08:49 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 69C9513C0C7 	for <cygwin-patches@cygwin.com>; Mon,  1 Feb 2010 21:03:13 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 473BB2B35A; Mon,  1 Feb 2010 21:03:13 -0500 (EST)
Date: Tue, 02 Feb 2010 02:08:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: dlclose not calling destructors of static variables.
Message-ID: <20100202020313.GC31126@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20100129184514.GA9550@ednor.casa.cgf.cx>  <4B66BF2F.4060802@gmail.com>  <20100201162603.GB25374@ednor.casa.cgf.cx>  <4B6710CE.40300@gmail.com>  <20100201174611.GA26080@ednor.casa.cgf.cx>  <20100201175123.GB26080@ednor.casa.cgf.cx>  <4B672B74.4090808@gmail.com>  <4B6736C1.8030101@gmail.com>  <20100201215919.GA29662@ednor.casa.cgf.cx>  <4B675776.4020105@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B675776.4020105@gmail.com>
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
X-SW-Source: 2010-q1/txt/msg00061.txt.bz2

On Mon, Feb 01, 2010 at 10:36:38PM +0000, Dave Korn wrote:
>On 01/02/2010 21:59, Christopher Faylor wrote:
>>Since the testcase (obviously?) worked for me it seems like this is
>>pretty variable.  I'd like to understand why the
>>MEMORY_BASIC_INFORMATION method doesn't work before trying other
>>things.
>
>Hmm, well first off, looks like RegionSize is indeed relative to
>BaseAddress, not AllocationBase after all:

Yes, I got that from the report in the cygwin list.  The first thing I
did on seeing that was look up MSDN.

Looking at the memory layout in gdb and in linker scripts, it seems like
using data_end or bss_end should not be necessary.  Just checking from
AllocationBase -> BaseAddress.RegionSize should be adequate.

However, I think your other idea has more merit.  Inspecting the return
address, calling __cxa_atexit for registered dlls, and calling
__cxa_finalize when the dll is detaching seems to work pretty well.

I'm submitting the below but I have an accompanying newlib patch to go
with it which should address the locking concerns.

http://cygwin.com/ml/cygwin-cvs/2010-q1/msg00065.html

cgf
