Return-Path: <cygwin-patches-return-7538-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10279 invoked by alias); 4 Nov 2011 13:40:47 -0000
Received: (qmail 10263 invoked by uid 22791); 4 Nov 2011 13:40:47 -0000
X-SWARE-Spam-Status: No, hits=-2.2 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE
X-Spam-Check-By: sourceware.org
Received: from smtpout.karoo.kcom.com (HELO smtpout.karoo.kcom.com) (212.50.160.34)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 04 Nov 2011 13:40:33 +0000
Received: from 213-152-38-55.dsl.eclipse.net.uk (HELO [192.168.0.9]) ([213.152.38.55])  by smtpout.karoo.kcom.com with ESMTP; 04 Nov 2011 13:40:31 +0000
Message-ID: <4EB3EB50.4090400@dronecode.org.uk>
Date: Fri, 04 Nov 2011 13:40:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111101 Thunderbird/8.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Extend faq.using to discuss fork failures
References: <4E570031.4080800@cs.utoronto.ca> <20110830090020.GE30452@calimero.vinschen.de> <4E5CE899.4030605@cs.utoronto.ca> <4EB2C2CD.1080400@dronecode.org.uk> <20111103171748.GJ9159@calimero.vinschen.de>
In-Reply-To: <20111103171748.GJ9159@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-SW-Source: 2011-q4/txt/msg00028.txt.bz2

On 03/11/2011 17:17, Corinna Vinschen wrote:
> Thanks for doing that.  I looks good to me, with just one exception.
>
>> +<listitem>Address space layout randomization (ASLR). Starting with
>> +Vista, Windows implements ASLR, which means that thread stacks,
>> +heap, memory-mapped files, and statically-linked dlls are placed
>> +at different (random) locations in each process. This behaviour
>> +interferes with a proper<literal>fork</literal>, and if an
>> +unmovable object (process heap or system dll) ends up at the wrong
>> +location, Cygwin can do nothing to compensate (though it will
>> +retry a few times automatically). In a 64-bit system, marking
>> +executables as large address-ware and rebasing dlls to high
>> +addresses has been reported to help, as ASLR affects only the
>> +lower 2GB of address space.</listitem>
>
> Starting with "In a 64-bit system" it's getting a bit weird:
>
> - Starting with 4.5.3, gcc marks executables as large address aware
>    automatically, so this is going to be a lesser problem over time.  Is
>    it worth to mention this at all?  I suppose so, but the user should be
>    pointed to peflags to tests for this property first for the given
>    reason.
>
> - Starting with Cygwin 1.7.10, the high address area will be used for
>    the application heap on 64 bit systems and large address aware
>    executables.  Mmaps are located there, too.  This in turn leaves more
>    room for DLLs in the normal 2 Gigs memory area.  Therefore I would not
>    like to suggest rebasing DLLs into the high address area at all.  This
>    should only be done by people who know what they are doing.  Usually
>    there should be enough space in the lower 2 Gigs, especially when heap
>    and mmaps are out of the way, and given that the more recent rebaseall
>    will not create an arbitrary 64K hole between DLLs anymore when
>    rebasing.

I think it would be simplest just to drop the sentence starting "In a 64-bit 
system".
