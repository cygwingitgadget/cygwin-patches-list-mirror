Return-Path: <cygwin-patches-return-8724-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 70665 invoked by alias); 21 Mar 2017 13:56:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 70641 invoked by uid 89); 21 Mar 2017 13:56:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-4.5 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2 spammy=Hx-languages-length:2170, HTo:U*cygwin-patches, documents, Hx-spam-relays-external:ESMTPA
X-HELO: out1-smtp.messagingengine.com
Received: from out1-smtp.messagingengine.com (HELO out1-smtp.messagingengine.com) (66.111.4.25) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 21 Mar 2017 13:56:29 +0000
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])	by mailout.nyi.internal (Postfix) with ESMTP id 3FACF20601	for <cygwin-patches@cygwin.com>; Tue, 21 Mar 2017 09:56:28 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])  by compute4.internal (MEProxy); Tue, 21 Mar 2017 09:56:28 -0400
X-ME-Sender: <xms:CzHRWFaX1BRaZ5KapUAlnxthGFuJ8eH_q7OEe8RKcXk8TMUGGzNnpg>
Received: from [192.168.1.102] (host86-141-128-75.range86-141.btcentralplus.com [86.141.128.75])	by mail.messagingengine.com (Postfix) with ESMTPA id 8C95B7E660	for <cygwin-patches@cygwin.com>; Tue, 21 Mar 2017 09:56:27 -0400 (EDT)
Subject: Re: [PATCH] Implement getloadavg()
To: cygwin-patches@cygwin.com
References: <20170317175032.26780-1-jon.turney@dronecode.org.uk> <20170320103715.GH16777@calimero.vinschen.de> <0a1b00e9-229d-a1b4-9e4a-15cc14601713@dronecode.org.uk> <20170320154016.GL16777@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <5e6356a7-71ca-f741-382b-95ea69686573@dronecode.org.uk>
Date: Tue, 21 Mar 2017 13:56:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170320154016.GL16777@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2017-q1/txt/msg00065.txt.bz2

On 20/03/2017 15:40, Corinna Vinschen wrote:
> On Mar 20 15:04, Jon Turney wrote:
>> On 20/03/2017 10:37, Corinna Vinschen wrote:
>>> On Mar 17 17:50, Jon Turney wrote:
>>> The load average is global, non-critical data.  So what about storing it
>>> in shared_info instead?  This way, only the first call of the first
>>> Cygwin process returns all zero.
>>
>> Ok.
>>
>>>> +static bool load_init (void)
>>>> +{
>>>> +  static bool tried = false;
>>>> +  static bool initialized = false;
>>>> +
>>>> +  if (!tried) {
>>>> +    tried = true;
>>>> +
>>>> +    if ((PdhOpenQueryA (NULL, 0, &query) == ERROR_SUCCESS) &&
>>>> +	(PdhAddEnglishCounterA (query, "\\Processor(_Total)\\% Processor Time",
>>>> +				0, &counter1) == ERROR_SUCCESS) &&
>>>> +	(PdhAddEnglishCounterA (query, "\\System\\Processor Queue Length",
>>>> +				0, &counter2) == ERROR_SUCCESS)) {
>>>> +      initialized = true;
>>>> +    } else {
>>>> +      debug_printf("loadavg PDH initialization failed\n");
>>>> +    }
>>>> +  }
>>>> +
>>>> +  return initialized;
>>>> +}
>>>
>>> How slow is that initialization?  Would it {make sense|hurt} to call it
>>> once in the initalization of Cygwin's shared mem in shared_info::initialize?
>>
>> I don't think that's particularly heavyweight, and I didn't see anything to
>> suggest that PDH query handles can be shared between processes, but I'll
>> look into it.
>
> Oh, right, that might pose a problem.

I can't find anything which documents these handles as shareable.

In practise, they seem to randomly stop working after a while after the 
process which created the handle exits, or something like that. :S

> But even then:
>
> The first process creating shared_info could call this and prime the values
> with a first call to getloadavg.  Each other process would have to init its

We cannot determine an initial value of load when shared_info is 
created, as the %CPU is not measured instantaneously, but over an 
interval.  This means that we can't have a load estimate until the 2nd 
time a process calls PdhCollectQueryData()

I've tweaked things slightly in v2 so the loadavg is initialized to the 
current load, rather than converging on it from 0.0.
