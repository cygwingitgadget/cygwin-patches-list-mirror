Return-Path: <cygwin-patches-return-6938-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19790 invoked by alias); 1 Feb 2010 21:59:36 -0000
Received: (qmail 19778 invoked by uid 22791); 1 Feb 2010 21:59:35 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-58-83.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.58.83)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 01 Feb 2010 21:59:29 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 24E4F13C0C7 	for <cygwin-patches@cygwin.com>; Mon,  1 Feb 2010 16:59:20 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 1AFC22B35A; Mon,  1 Feb 2010 16:59:20 -0500 (EST)
Date: Mon, 01 Feb 2010 21:59:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: dlclose not calling destructors of static variables.
Message-ID: <20100201215919.GA29662@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B62DDE6.5070106@gmail.com>  <4B62F118.8010305@gmail.com>  <20100129184514.GA9550@ednor.casa.cgf.cx>  <4B66BF2F.4060802@gmail.com>  <20100201162603.GB25374@ednor.casa.cgf.cx>  <4B6710CE.40300@gmail.com>  <20100201174611.GA26080@ednor.casa.cgf.cx>  <20100201175123.GB26080@ednor.casa.cgf.cx>  <4B672B74.4090808@gmail.com>  <4B6736C1.8030101@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B6736C1.8030101@gmail.com>
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
X-SW-Source: 2010-q1/txt/msg00054.txt.bz2

On Mon, Feb 01, 2010 at 08:17:05PM +0000, Dave Korn wrote:
>On 01/02/2010 19:28, Dave Korn wrote:
>> On 01/02/2010 17:51, Christopher Faylor wrote:
>>> On Mon, Feb 01, 2010 at 12:46:11PM -0500, Christopher Faylor wrote:
>> 
>>>>> Cribbing from the gdb source code, it looks like they use BaseAddrees + 
>>>>> 0x1000 for the start point and then call GetModuleInformation to workout 
>>>>> the size of the module.
>>>> Yeah, duh.  "they" == "me".  I should have checked gdb for this since I've
>>>> already done this research once before.
>>>>
>>>> If you do find that this works, then I think this may fall into the
>>>> realm of a non-trivial patch so it may be best to just tell me what
>>>> you've found rather than provide a patch - unless you want to go through
>>>> the approval process with Red Hat.
>>>>
>>>> Or, you can just wait for me to adapt what's in gdb to cygwin.  I can do
>>>> tonight when I get back to a windows system.
>>> Btw, it isn't entirely clear that GetModuleInformation will work with
>>> older versions of Windows NT so this may not be a complete solution.  We
>>> do use GetModuleInformation in Cygwin but it is not in anything as
>>> crucial as this.
>> 
>>   Can't we use the info in the dll struct?  It has pointers to the data and
>> bss section, we could take the max out of them and the data in the M_B_I
>> struct.  (Tell you what, I'll try it.)
>
>  Yep, that makes the original testcase work for me.  How about it?

Since the testcase (obviously?) worked for me it seems like this is pretty
variable.  I'd like to understand why the MEMORY_BASIC_INFORMATION method
doesn't work before trying other things.

cgf
