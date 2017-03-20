Return-Path: <cygwin-patches-return-8720-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 61262 invoked by alias); 20 Mar 2017 15:04:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 61197 invoked by uid 89); 20 Mar 2017 15:04:37 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-26.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2 spammy=Hx-spam-relays-external:!192.168.1.102!, H*RU:!192.168.1.102!, H*r:ip*192.168.1.102, H*M:9e4a
X-HELO: out1-smtp.messagingengine.com
Received: from out1-smtp.messagingengine.com (HELO out1-smtp.messagingengine.com) (66.111.4.25) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 20 Mar 2017 15:04:36 +0000
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])	by mailout.nyi.internal (Postfix) with ESMTP id 81AF42081F	for <cygwin-patches@cygwin.com>; Mon, 20 Mar 2017 11:04:35 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])  by compute6.internal (MEProxy); Mon, 20 Mar 2017 11:04:35 -0400
X-ME-Sender: <xms:g-_PWDOOoWBwnkQR1yh4n_Zts3zz2fwRcvzyjzkjh7K6GTsaRIZPWw>
Received: from [192.168.1.102] (host86-141-128-75.range86-141.btcentralplus.com [86.141.128.75])	by mail.messagingengine.com (Postfix) with ESMTPA id 260C27E1DC	for <cygwin-patches@cygwin.com>; Mon, 20 Mar 2017 11:04:34 -0400 (EDT)
Subject: Re: [PATCH] Implement getloadavg()
To: cygwin-patches@cygwin.com
References: <20170317175032.26780-1-jon.turney@dronecode.org.uk> <20170320103715.GH16777@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <0a1b00e9-229d-a1b4-9e4a-15cc14601713@dronecode.org.uk>
Date: Mon, 20 Mar 2017 15:04:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170320103715.GH16777@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2017-q1/txt/msg00061.txt.bz2

On 20/03/2017 10:37, Corinna Vinschen wrote:
> Hi Jon,
>
> neat!  But...
>
> On Mar 17 17:50, Jon Turney wrote:
>> Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
>> ---
>>  winsup/cygwin/Makefile.in              |   5 +-
>>  winsup/cygwin/common.din               |   1 +
>>  winsup/cygwin/fhandler_proc.cc         |  10 ++-
>>  winsup/cygwin/include/cygwin/stdlib.h  |   4 +
>>  winsup/cygwin/include/cygwin/version.h |   3 +-
>>  winsup/cygwin/loadavg.cc               | 135 +++++++++++++++++++++++++++++++++
>>  winsup/doc/posix.xml                   |   1 +
>>  7 files changed, 154 insertions(+), 5 deletions(-)
>>  create mode 100644 winsup/cygwin/loadavg.cc
>>
>> diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
>> index c8652b0..5e719a6 100644
>> --- a/winsup/cygwin/Makefile.in
>> +++ b/winsup/cygwin/Makefile.in
>> @@ -147,7 +147,9 @@ EXTRA_OFILES:=
>>
>>  MALLOC_OFILES:=malloc.o
>>
>> -DLL_IMPORTS:=${shell $(CC) -print-file-name=w32api/libkernel32.a} ${shell $(CC) -print-file-name=w32api/libntdll.a}
>> +DLL_IMPORTS:=${shell $(CC) -print-file-name=w32api/libkernel32.a} \
>> +	${shell $(CC) -print-file-name=w32api/libntdll.a} \
>> +	${shell $(CC) -print-file-name=w32api/libpdh.a}
>
> No, that's not right.  Please add the new functions to autoload.cc and
> drop static linking to libpdh.a.

Ah, I see.  Ok.

>> +static double _loadavg[3] = { 0.0, 0.0, 0.0 };
>
> The load average is global, non-critical data.  So what about storing it
> in shared_info instead?  This way, only the first call of the first
> Cygwin process returns all zero.

Ok.

>> +static bool load_init (void)
>> +{
>> +  static bool tried = false;
>> +  static bool initialized = false;
>> +
>> +  if (!tried) {
>> +    tried = true;
>> +
>> +    if ((PdhOpenQueryA (NULL, 0, &query) == ERROR_SUCCESS) &&
>> +	(PdhAddEnglishCounterA (query, "\\Processor(_Total)\\% Processor Time",
>> +				0, &counter1) == ERROR_SUCCESS) &&
>> +	(PdhAddEnglishCounterA (query, "\\System\\Processor Queue Length",
>> +				0, &counter2) == ERROR_SUCCESS)) {
>> +      initialized = true;
>> +    } else {
>> +      debug_printf("loadavg PDH initialization failed\n");
>> +    }
>> +  }
>> +
>> +  return initialized;
>> +}
>
> How slow is that initialization?  Would it {make sense|hurt} to call it
> once in the initalization of Cygwin's shared mem in shared_info::initialize?

I don't think that's particularly heavyweight, and I didn't see anything 
to suggest that PDH query handles can be shared between processes, but 
I'll look into it.

> As for the declaration problem on x86, what about moving the declarations
> to the start of loadavg.cc, until we get a new w32api-headers package?

It's only one prototype, so that should be ok.
