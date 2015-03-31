Return-Path: <cygwin-patches-return-8089-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 55703 invoked by alias); 31 Mar 2015 17:48:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 55685 invoked by uid 89); 31 Mar 2015 17:48:47 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.3 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2
X-HELO: out2-smtp.messagingengine.com
Received: from out2-smtp.messagingengine.com (HELO out2-smtp.messagingengine.com) (66.111.4.26) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Tue, 31 Mar 2015 17:48:46 +0000
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])	by mailout.nyi.internal (Postfix) with ESMTP id E06C720AC6	for <cygwin-patches@cygwin.com>; Tue, 31 Mar 2015 13:48:39 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])  by compute3.internal (MEProxy); Tue, 31 Mar 2015 13:48:43 -0400
Received: from [192.168.1.102] (unknown [31.51.205.126])	by mail.messagingengine.com (Postfix) with ESMTPA id C396AC0001C	for <cygwin-patches@cygwin.com>; Tue, 31 Mar 2015 13:48:42 -0400 (EDT)
Message-ID: <551ADDF6.1060608@dronecode.org.uk>
Date: Tue, 31 Mar 2015 17:48:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Rename struct ucontext to struct mcontext
References: <20150330102129.GH29875@calimero.vinschen.de> <1427736757-13884-1-git-send-email-jon.turney@dronecode.org.uk> <1427736757-13884-2-git-send-email-jon.turney@dronecode.org.uk> <20150330184735.GA12442@calimero.vinschen.de>
In-Reply-To: <20150330184735.GA12442@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2015-q1/txt/msg00044.txt.bz2

On 30/03/2015 19:47, Corinna Vinschen wrote:
> Just for the records what we talked about on IRC:
>
> On Mar 30 18:32, Jon TURNEY wrote:
>> @@ -45,7 +49,7 @@ struct _fpstate
>>     __uint32_t padding[24];
>>   };
>>
>> -struct ucontext
>> +struct mcontext
>
> __mcontext so as not to pollute the namespace.
>
>>     __uint64_t etr;
>>     __uint64_t efr;
>>     __uint8_t _internal;
>> -  __uint64_t oldmask;
>>   };
>
> Remove _internal, keep oldmask.  As a result, __mcontext is still
> basically equivalent to Linux' mcontext_t.  __mcontext can be
> taken from _my_tls.oldmask.

Thanks for your help with this.

You'll have to help me understand what the difference in meaning between 
ucontext_t.uc_sigmask and ucontext_t.uc_mcontext.oldmask is.

In the context of _cygtls::call_signal_handler() is _my_tls.oldmask 
correct and not this_oldmask?
