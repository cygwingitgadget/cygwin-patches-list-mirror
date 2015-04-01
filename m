Return-Path: <cygwin-patches-return-8106-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 76307 invoked by alias); 1 Apr 2015 17:37:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 76295 invoked by uid 89); 1 Apr 2015 17:36:59 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.3 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2
X-HELO: out5-smtp.messagingengine.com
Received: from out5-smtp.messagingengine.com (HELO out5-smtp.messagingengine.com) (66.111.4.29) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Wed, 01 Apr 2015 17:36:58 +0000
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])	by mailout.nyi.internal (Postfix) with ESMTP id 4FB0020759	for <cygwin-patches@cygwin.com>; Wed,  1 Apr 2015 13:36:53 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])  by compute1.internal (MEProxy); Wed, 01 Apr 2015 13:36:56 -0400
Received: from [192.168.1.102] (unknown [31.51.205.126])	by mail.messagingengine.com (Postfix) with ESMTPA id 42824C00017	for <cygwin-patches@cygwin.com>; Wed,  1 Apr 2015 13:36:56 -0400 (EDT)
Message-ID: <551C2CB7.4@dronecode.org.uk>
Date: Wed, 01 Apr 2015 17:37:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/3] Provide ucontext to signal handlers
References: <1427894373-2576-1-git-send-email-jon.turney@dronecode.org.uk> <1427894373-2576-3-git-send-email-jon.turney@dronecode.org.uk> <20150401142219.GY13285@calimero.vinschen.de>
In-Reply-To: <20150401142219.GY13285@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2015-q2/txt/msg00007.txt.bz2

On 01/04/2015 15:22, Corinna Vinschen wrote:
> On Apr  1 14:19, Jon TURNEY wrote:
>> Add ucontext.h header, defining ucontext_t and mcontext_t types.
>>
>> Provide sigaction sighandlers with a ucontext_t parameter, containing stack and
>> context information.
>>
>> 	* include/sys/ucontext.h : New header.
>> 	* include/ucontext.h : Ditto.
>> 	* exceptions.cc (call_signal_handler): Provide ucontext_t
>> 	parameter to signal handler function.
>
> Patch is ok with a single change:  Please add a "FIXME?" comment to:
>
>    else
>      RtlCaptureContext();
>
> On second thought, calling RtlCaptureContext here is probably wrong.
>
> What we really need is the context of the thread when calling
> call_signal_handler I think.

I had the same thought, but this is going to be quite tricky to achieve.

This patch depends on the change to newlib to add stack_t, so I will 
wait for that to land before committing this patch.

> It would be better to call RtlCaptureContext
> before calling call_signal_handler.  But this requires a change in how
> call_signal_handler is called.
>
> We should discuss this at one point, I think.
