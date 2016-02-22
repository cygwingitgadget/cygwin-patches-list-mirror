Return-Path: <cygwin-patches-return-8350-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 125926 invoked by alias); 22 Feb 2016 16:14:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 125907 invoked by uid 89); 22 Feb 2016 16:14:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.1 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, Hx-spam-relays-external:ESMTPA
X-HELO: out4-smtp.messagingengine.com
Received: from out4-smtp.messagingengine.com (HELO out4-smtp.messagingengine.com) (66.111.4.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Mon, 22 Feb 2016 16:14:54 +0000
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])	by mailout.nyi.internal (Postfix) with ESMTP id B6CEA20BD9	for <cygwin-patches@cygwin.com>; Mon, 22 Feb 2016 11:14:52 -0500 (EST)
Received: from frontend2 ([10.202.2.161])  by compute4.internal (MEProxy); Mon, 22 Feb 2016 11:14:52 -0500
Received: from [192.168.1.102] (host86-184-210-93.range86-184.btcentralplus.com [86.184.210.93])	by mail.messagingengine.com (Postfix) with ESMTPA id 597EC6800F3	for <cygwin-patches@cygwin.com>; Mon, 22 Feb 2016 11:14:52 -0500 (EST)
Subject: Re: [PATCH] gprof profiling of multi-threaded Cygwin programs, ver 2
To: cygwin-patches@cygwin.com
References: <56C820D8.4010203@maxrnd.com> <56CAF4A3.5060806@dronecode.org.uk> <20160222142502.GA26624@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <56CB33F1.4070805@dronecode.org.uk>
Date: Mon, 22 Feb 2016 16:14:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20160222142502.GA26624@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2016-q1/txt/msg00056.txt.bz2

On 22/02/2016 14:25, Corinna Vinschen wrote:
> On Feb 22 11:44, Jon Turney wrote:
>> Thanks for this.  A few comments inline.
>> [...]
>> On 20/02/2016 08:16, Mark Geisert wrote:
>>> +      // record profiling samples for other pthreads, if any
>>> +      cygwin_internal (CW_CYGHEAP_PROFTHR_ALL, profthr_byhandle);
>>> +
>>
>> Hmm.. so why isn't this written as cygheap_profthr_all (profthr_byhandle) ?
>
> I asked for it:
> https://cygwin.com/ml/cygwin-patches/2016-q1/msg00028.html

Ok.  I guess I don't understand why it's exported at all in that version 
of the patch.
