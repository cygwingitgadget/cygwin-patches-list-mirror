Return-Path: <cygwin-patches-return-7542-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 477 invoked by alias); 5 Nov 2011 18:31:01 -0000
Received: (qmail 462 invoked by uid 22791); 5 Nov 2011 18:31:01 -0000
X-SWARE-Spam-Status: No, hits=-1.6 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,TW_CG,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm19.access.bullet.mail.mud.yahoo.com (HELO nm19.access.bullet.mail.mud.yahoo.com) (66.94.237.220)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Sat, 05 Nov 2011 18:30:47 +0000
Received: from [66.94.237.127] by nm19.access.bullet.mail.mud.yahoo.com with NNFMP; 05 Nov 2011 18:30:46 -0000
Received: from [66.94.237.97] by tm2.access.bullet.mail.mud.yahoo.com with NNFMP; 05 Nov 2011 18:30:46 -0000
Received: from [127.0.0.1] by omp1002.access.mail.mud.yahoo.com with NNFMP; 05 Nov 2011 18:30:46 -0000
Received: (qmail 46248 invoked from network); 5 Nov 2011 18:30:46 -0000
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from cgf.cx (cgf@98.110.183.46 with login)        by smtp103.vzn.mail.bf1.yahoo.com with SMTP; 05 Nov 2011 11:30:45 -0700 PDT
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id A6BA913C0D3	for <cygwin-patches@cygwin.com>; Sat,  5 Nov 2011 14:30:44 -0400 (EDT)
Date: Sat, 05 Nov 2011 18:31:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Prevent restart of crashing non-Cygwin exe
Message-ID: <20111105183044.GA27130@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4E037D68.6090907@t-online.de> <20110624075743.GR3437@calimero.vinschen.de> <4EB19FBB.5060800@t-online.de> <20111103120720.GF9159@calimero.vinschen.de> <20111103213455.GA4709@ednor.casa.cgf.cx> <4EB56BA9.6010803@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4EB56BA9.6010803@t-online.de>
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
X-SW-Source: 2011-q4/txt/msg00032.txt.bz2

On Sat, Nov 05, 2011 at 06:00:25PM +0100, Christian Franke wrote:
>Christopher Faylor wrote:
>> On Thu, Nov 03, 2011 at 01:07:20PM +0100, Corinna Vinschen wrote:
>>> On Nov  2 20:53, Christian Franke wrote:
>>>> On Jun 24, Corinna Vinschen wrote:
>>>>> Hi Christian,
>>>>>
>>>>> On Jun 23 19:52, Christian Franke wrote:
>>>>>> If a non-Cygwin .exe started from a Cygwin shell window segfaults,
>>>>>> Cygwin restarts the .exe 5 times.
>>>>>> [...l]
>>>>>> 	* sigproc.cc (child_info::sync): Add exit_code to debug
>>>>>> 	message.
>>>>>> 	(child_info::proc_retry): Don't retry on unknown exit_code
>>>>>> 	from non-cygwin programs.
>>>>> This looks ok to me, but cgf should have a say here.  He's on vacation
>>>>> for another week, though.
>>>>>
>>>> Problem can still be reproduced with current CVS.  Patch is still
>>>> valid.
>>> Sorry, I forgot about this patch entirely.  Chris, is that patch ok
>>> with you as well?
>> No, it isn't.  Sorry for not stating this earlier.  The problem that
>> this code was intended to solve was actually a transient exit codes from
>> a non-Cygwin process which began with 0xc...
>>
>> I don't believe that I ever saw STATUS_ACCESS_VIOLATION in any of my
>> testing though so adding that earlier in the switch would fix this
>> particular problem.  I'll do that.
>
>Works as expected with testcase from my first mail:
>
>$ i686-w64-mingw32-gcc -o crash-w crash.c
>
>$ ./crash-w
>Hello,
>
>
>A drawback is that non-Cygwin programs crash silently.

Thanks for the patch but I chose to do this in a different way.  I've
checked in a change which should accomplish the task of having bash
report the correct error message while allowing easy future extension.

cgf
