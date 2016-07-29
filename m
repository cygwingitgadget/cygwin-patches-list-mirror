Return-Path: <cygwin-patches-return-8610-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 129620 invoked by alias); 29 Jul 2016 13:17:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 129609 invoked by uid 89); 29 Jul 2016 13:17:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.1 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2 spammy=H*M:2476, H*M:2c1a, HTo:U*cygwin-patches, Hx-spam-relays-external:ESMTPA
X-HELO: out5-smtp.messagingengine.com
Received: from out5-smtp.messagingengine.com (HELO out5-smtp.messagingengine.com) (66.111.4.29) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Fri, 29 Jul 2016 13:17:27 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])	by mailout.nyi.internal (Postfix) with ESMTP id 5C15B2047A	for <cygwin-patches@cygwin.com>; Fri, 29 Jul 2016 09:17:25 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])  by compute5.internal (MEProxy); Fri, 29 Jul 2016 09:17:25 -0400
Received: from [192.168.1.102] (host86-179-112-245.range86-179.btcentralplus.com [86.179.112.245])	by mail.messagingengine.com (Postfix) with ESMTPA id D60D6CCDC7	for <cygwin-patches@cygwin.com>; Fri, 29 Jul 2016 09:17:24 -0400 (EDT)
Subject: Re: [PATCH 2/2] Send thread names to debugger
To: cygwin-patches@cygwin.com
References: <20160728114341.1728-1-jon.turney@dronecode.org.uk> <20160728114341.1728-3-jon.turney@dronecode.org.uk> <20160728193458.GB26311@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <226278ea-2c1a-2476-4a7a-324ae48d8e3b@dronecode.org.uk>
Date: Fri, 29 Jul 2016 13:17:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160728193458.GB26311@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2016-q3/txt/msg00018.txt.bz2

On 28/07/2016 20:34, Corinna Vinschen wrote:
> On Jul 28 12:43, Jon Turney wrote:
>> GDB with the patch from [1] can report and use these names.
>
> This is still WIP, right?

Yes, that's right.

>> --- a/winsup/cygwin/cygthread.cc
>> +++ b/winsup/cygwin/cygthread.cc
>> @@ -213,6 +213,8 @@ cygthread::create ()
>>  			    this, 0, &id);
>>        if (!htobe)
>>  	api_fatal ("CreateThread failed for %s - %p<%y>, %E", __name, h, id);
>> +      else
>> +	SetThreadName(GetThreadId(htobe), __name);
>                     ^^^         ^^^
>                    space?      space?
>
> Just wondering: Wouldn't it make sense to rename the internal threads
> so they either always start with "cyg_" or with double underscore or
> something like that to mark them as internal?  E.g.

Yeah, I wanted to do something like that.

But messing with the thread names may have other consequences (See 
fhandler_tty.cc:109), and I was a bit wary of introducing a malloc/free 
to into cygthread::create() to dynamically make the name with a "__" 
prepended
