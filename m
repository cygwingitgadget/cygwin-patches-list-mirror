Return-Path: <SRS0=sWMC=7M=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo007.btinternet.com (btprdrgo007.btinternet.com [65.20.50.168])
	by sourceware.org (Postfix) with ESMTP id 09CF74BA2E04
	for <cygwin-patches@cygwin.com>; Wed,  7 Jan 2026 12:56:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 09CF74BA2E04
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 09CF74BA2E04
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.168
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1767790568; cv=none;
	b=fcpzbyJDN0m9FtS+UbaeYSx1za+JrqIR3/D3L9GlI9ZxrLIj1fFtx6XTnHR8dJVoeqg1l9ugAtE2CueXWVVi9Cd8akCZPglk/T/nXjfXCd13Qpkp1CJBvQacPQw9LowyNVI7Uwk14aceaZ8IhLGBGoG7NNfs223uEijjYEoGjao=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1767790568; c=relaxed/simple;
	bh=QjoM8F6FfrJnRFiTYu+1rQYpZAiEK59kOPOslAN1ebc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=DVjTZCdFGXv/2+F+Ac047ABpi3LpSgbCSyxEVwepV9Y+PnFb4v+gBEJAqgDGPmXLAkS86Qqms149PezubgiZz1WTOZfYCP1CxcaUlJhYSx4EYZm1PlYruv/svpWT4jZ7lj3q7IDxXuMJOp2cKjRTKkyFI2+AAysiY8VaUEdE9yM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 09CF74BA2E04
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 693FF8BE022FF87D
X-Originating-IP: [86.143.43.76]
X-OWM-Source-IP: 86.143.43.76
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdefudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepvedvkefgffetteeuhefgudeggfekveeljeduudehveeutdevjeefvedvvedvgfdvnecukfhppeekiedrudegfedrgeefrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkeeirddugeefrdegfedrjeeipdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddugeefqdegfedqjeeirdhrrghnghgvkeeiqddugeefrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdejpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihi
	nhdrtghomhdprhgtphhtthhopehthhhirhhumhgrlhgrihdrnhgrghgrlhhinhhgrghmsehmuhhlthhitghorhgvfigrrhgvihhntgdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.143.43.76) by btprdrgo007.btinternet.com (authenticated as jonturney@btinternet.com)
        id 693FF8BE022FF87D; Wed, 7 Jan 2026 12:56:02 +0000
Message-ID: <2b722c24-9ba6-42d7-b353-cc2294f3f9aa@dronecode.org.uk>
Date: Wed, 7 Jan 2026 12:56:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: _endian.h: Add AArch64 implementations for
 `ntohl` and `ntohs`
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
References: <PN3P287MB30775977BEB79B12B2F3BCEE9F86A@PN3P287MB3077.INDP287.PROD.OUTLOOK.COM>
 <aV5A5ENx-xQdpgzR@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <aV5A5ENx-xQdpgzR@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 07/01/2026 11:17, Corinna Vinschen wrote:
> Hi Thirumalai,
> 
> On Jan  5 12:40, Thirumalai Nagalingam wrote:
>> Hello Everyone,
>>
>> This patch adds AArch64-specific inline asm implementations of __ntohl()
>> and __ntohs() in `winsup/cygwin/include/machine/_endian.h`.
>>
>> For AArch64 targets, the patch uses the REV and REV16 instructions
>> to perform byte swapping, with explicit zero-extension for 16-bit
>> values to ensure correct register semantics.
>>
>> Comments and reviews are welcome.
>>
>> Thanks & regards
>> Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com<mailto:thirumalai.nagalingam@multicorewareinc.com>>
>>
>> In-lined patch:
>>
>> diff --git a/winsup/cygwin/include/machine/_endian.h b/winsup/cygwin/include/machine/_endian.h
>> index dbd4429b8..129cba66b 100644
>> --- a/winsup/cygwin/include/machine/_endian.h
>> +++ b/winsup/cygwin/include/machine/_endian.h
>> @@ -26,16 +26,26 @@ _ELIDABLE_INLINE __uint16_t __ntohs(__uint16_t);
>>   _ELIDABLE_INLINE __uint32_t
>>   __ntohl(__uint32_t _x)
>>   {
>> +#if defined(__x86_64__)
>>          __asm__("bswap %0" : "=r" (_x) : "0" (_x));
>> +#elif defined(__aarch64__)
>> +       __asm__("rev %w0, %w0" : "=r" (_x) : "0" (_x));
>> +#endif

For a bit of future proofing, maybe this should end with

#else
#error unknown architecture

rather than ploughing on to silently return the unmodified x?

(That's probably an observation which applies generally to aarch64 
patches :))


Also, to be hypercorrect (that is, I do not expect anyone to do anything 
about this): since big-endian ARM is a thing (although not for Windows) 
is there a more tightly scoped define we might use here?

