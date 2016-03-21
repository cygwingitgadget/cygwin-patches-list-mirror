Return-Path: <cygwin-patches-return-8447-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 87746 invoked by alias); 21 Mar 2016 16:38:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 87735 invoked by uid 89); 21 Mar 2016 16:38:08 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RP_MATCHES_RCVD,SPF_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:846, questionable, business, H*F:D*se
X-HELO: mail.lysator.liu.se
Received: from mail.lysator.liu.se (HELO mail.lysator.liu.se) (130.236.254.3) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Mon, 21 Mar 2016 16:37:58 +0000
Received: from mail.lysator.liu.se (localhost [127.0.0.1])	by mail.lysator.liu.se (Postfix) with ESMTP id 78D5140014	for <cygwin-patches@cygwin.com>; Mon, 21 Mar 2016 17:37:54 +0100 (CET)
Received: from [192.168.0.96] (217-210-101-82-no95.business.telia.com [217.210.101.82])	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))	(No client certificate requested)	by mail.lysator.liu.se (Postfix) with ESMTPSA id 3030840013	for <cygwin-patches@cygwin.com>; Mon, 21 Mar 2016 17:37:54 +0100 (CET)
Message-ID: <56F02361.50905@lysator.liu.se>
Date: Mon, 21 Mar 2016 16:38:00 -0000
From: Peter Rosin <peda@lysator.liu.se>
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 05/11] A pointer to a pointer is nonnull.
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com> <1458409557-13156-5-git-send-email-pefoley2@pefoley.com> <20160320111558.GG25241@calimero.vinschen.de>
In-Reply-To: <20160320111558.GG25241@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00153.txt.bz2

On 2016-03-20 12:15, Corinna Vinschen wrote:
> On Mar 19 13:45, Peter Foley wrote:
>> GCC 6.0+ can assert that this argument is nonnull.
>> Remove the unnecessary check to fix a warning.
>>
>> winsup/cygwin/ChangeLog
>> malloc_wrapper.cc (posix_memalign): Remove always true nonnull check.
> 
> Eh, what?!?  How on earth can gcc assert memptr is always non-NULL?
> An application can call posix_memalign(NULL, 4096, 4096) just fine,
> can't it?  If so, *memptr = res crashes.

I think that passing NULL qualifies as undefined, in which case the
crash is ok, no?

I'm sure it will misbehave if you pass (void **)1 too. So, some might
argue that the business of special-casing NULL here is questionable.

Or is there some reason to protect the posix_memalign users from
themselves?

Cheers,
Peter
