Return-Path: <cygwin-patches-return-8049-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10774 invoked by alias); 16 Jan 2015 17:33:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 10760 invoked by uid 89); 16 Jan 2015 17:33:22 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mail-wg0-f52.google.com
Received: from mail-wg0-f52.google.com (HELO mail-wg0-f52.google.com) (74.125.82.52) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-SHA encrypted) ESMTPS; Fri, 16 Jan 2015 17:33:21 +0000
Received: by mail-wg0-f52.google.com with SMTP id x12so21692050wgg.11        for <cygwin-patches@cygwin.com>; Fri, 16 Jan 2015 09:33:18 -0800 (PST)
X-Received: by 10.180.24.167 with SMTP id v7mr8582414wif.5.1421429597978;        Fri, 16 Jan 2015 09:33:17 -0800 (PST)
Received: from [192.168.2.108] (p5B29926E.dip0.t-ipconnect.de. [91.41.146.110])        by mx.google.com with ESMTPSA id w3sm6909980wjf.3.2015.01.16.09.33.16        for <cygwin-patches@cygwin.com>        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Fri, 16 Jan 2015 09:33:17 -0800 (PST)
Message-ID: <54B94B59.4050606@gmail.com>
Date: Fri, 16 Jan 2015 17:33:00 -0000
From: Marco Atzeri <marco.atzeri@gmail.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: tracing malloc/free call
References: <54B6EE1F.60705@gmail.com> <20150115093451.GB10242@calimero.vinschen.de> <54B91EFD.80302@gmail.com> <20150116154425.GG3122@calimero.vinschen.de> <20150116162203.GI3122@calimero.vinschen.de>
In-Reply-To: <20150116162203.GI3122@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2015-q1/txt/msg00004.txt.bz2

On 1/16/2015 5:22 PM, Corinna Vinschen wrote:
> On Jan 16 16:44, Corinna Vinschen wrote:
>> On Jan 16 15:23, Marco Atzeri wrote:
>>> Attached patch that allows tracking of original caller,
>>> for the 4 memory allocation calls.
>>
>> Thanks for the patch, but it won't work nicely either this way.  The
>> problem is that, in theory, the code has to differ between internal and
>> external callers.  Internal callers (that is, Cygwin functions itself)
>> don't hop into the function via _sigfe/_sigbe.  Thus the output for
>> internal callers of malloc/free is now wrong with your patch.

I missed that point. ;-)
First time I look at these inside details of cygwin

>> The solution for this problem would be a test which checks if the return
>> address is the _sigbe function and if so, returns *(_my_tls.stackptr-1),
>> otherwise __builtin_return_address(0).  However, the symbol _sigbe is
>> not exported since, so far, it was only used inside _sigfe.  This needs
>> a bit of tweaking.  I'll have a look.
>
> I applied a patch to print the right caller address.  I created a new
> macro caller_return_address() for reuse, should we have a desire to
> print the caller address in other parts of the code.
>
> I'm going to create a snapshot with this change.  Please give it
> a try.

It works like charm.
Much more easy to find misalignment between
malloc/calloc/realloc and free calls

> Thanks,
> Corinna
>
