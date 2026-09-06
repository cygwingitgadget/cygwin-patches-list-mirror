Return-Path: <SRS0=Jx4T=G6=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo001.btinternet.com (btprdrgo001.btinternet.com [65.20.50.131])
	by sourceware.org (Postfix) with ESMTP id 67B0B4BB3BF3
	for <cygwin-patches@cygwin.com>; Sun,  6 Sep 2026 22:00:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 67B0B4BB3BF3
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 67B0B4BB3BF3
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.131
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1788732035; cv=none;
	b=i+46rpWBsojweiCorR9bxpkVGxP6Eynow4NjSnBNncwZiBHaHfJWKGDpSKIbXIQNb03UZcraPXJStUyvavlfz++CeHmblS2eebPR49+sB2wjsKop9ywhEJl6xIUywVUqrSvSwXe+B6WZcW2dUL/QrZYD26NtT2AYYX+P+B/jFE0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1788732035; c=relaxed/simple;
	bh=SGxjxhnN0gb1drbMV6dzyFvQdrp+da/8uRaq+6RHCGE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To; b=FMLrE9+9oBT7Vm0vuqrffkgPVAbTNtQ4LQRv/fng9UbmLDCYou1OVqEfjfQymrHyz5rZAaUCg8kPh9Aqv59AFmAvU+6XZ3GYb/u8HmuYy48FJYnsRiV9w3MCiS4glSywtYmKJs2AB/ObRZPqlDI73v35VrFp7kMbZVA1ger0bn0=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 67B0B4BB3BF3
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A700E34064BB74E
X-Originating-IP: [62.56.66.111]
X-OWM-Source-IP: 62.56.66.111
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTEaxzV4E3oCdB2snsVosJTfNX+BayYBJirRn4vh7EFlLAjcGSMSpOiOq+i6iHWpJZvqAar6eXRS9v+lZNgFIKAyRBqWk0SQldlkK4AXVkeurdPFxnpuHOwjPmFkuFwbVyiQSwtLQrQxp/yRQ20m9kqtm51btTBlx3j1M/vGQB+799GYnkxpbCemzm/N4uM/pl3EhsOh4N7aOWJ2QtzjuT4O8HGEaEynKRwFycybMteAbU+YcqZJkKCQ0pRpgYY/pEufRfmyJkVD8/7HQ+ZL/T+evCsdh8zE5BNWvTOsX9PArpxImR4wN4N7W1WQP11RZ02dVxrQj6phyXmSbNT8yPYrO/oMhjIBHI75dA7xA7rSzWOWfm1dLFMU760P7pD30exxXqyUb7HC01lPVbZZ1GbEd7FHbKoNWBLxwHAYierULotRNr39Zf4Leq1jItcdVlM7mRTXyED29HQo5f2m2bkben4zVs4/hcMFB1IGx7VajYA4nhXNIE6pKSzlFDRztQ+7oPEG1C7grr0gLbSdSwRqA0DYd9dgHBjq/hn/2WoCySkeluOs1eLfm3+6i4qgg2LWFpkO9uajLVjkm93KNB4kRMujqqgNHpi9clmRv7+0YzbG2PBGST+kspHmUqurqMFg6VM7B8gx2NpU2rpbmCOAu7RU2hQ0sYoxr3U1JLODaw
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (62.56.66.111) by btprdrgo001.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A700E34064BB74E; Sun, 6 Sep 2026 23:00:29 +0100
Message-ID: <8ad1d40a-0842-47c4-bdb0-fa2278abcde1@dronecode.org.uk>
Date: Sun, 6 Sep 2026 23:00:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: gendef: add _sigfe_maybe for TLS initialization
References: <MA0P287MB3082181CE402F12F043C3A0B9FA9A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
 <6fd27001-6a1f-4d20-a621-e395b6b85762@dronecode.org.uk>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
To: Aswin Kalies Ramkumar Mangayarkarasi <aswin.kalies@multicorewareinc.com>,
 Chandru Kumaresan <chandru.kumaresan@multicorewareinc.com>
In-Reply-To: <6fd27001-6a1f-4d20-a621-e395b6b85762@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,BODY_8BITS,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This mail I sent to your colleague Thirumalai Nagalingam a few months 
ago was returned undeliverable.

Perhaps you could take a look at the question I raise?

On 20/06/2026 13:46, Jon Turney wrote:
> On 19/12/2025 17:30, Thirumalai Nagalingam wrote:
>> Hi all,
>>
>> Please find the attached patch which adds an ARM64 stub for the 
>> _sigfe_maybe routine
>> in the gendef script.
>>
>> Any feedback or nits are very welcome. The changes are documented with 
>> inline
>> comments intended to be self-explanatory. please let me know if any part
>> of this patch should be adjusted.
>>
>> Thanks for your time and review.
>>
>> Thanks & regards
>> Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
>>
>> In-lined patch:
>>
>> diff --git a/winsup/cygwin/scripts/gendef b/winsup/cygwin/scripts/gendef
>> index 1419704b8..52a5b77ca 100755
>> --- a/winsup/cygwin/scripts/gendef
>> +++ b/winsup/cygwin/scripts/gendef
>> @@ -367,8 +367,24 @@ EOF
>>          .include "tlsoffsets"
>>          .text
>>
>> -_sigfe_maybe:
>> -       .global _sigbe
>> +       .seh_proc _sigfe_maybe
>> +_sigfe_maybe:                                  # stack is aligned on 
>> entry!
>> +       .seh_endprologue
>> +       ldr     x10, [x18, #0x8]                // Load TEB pointer in 
>> x10
>> +       ldr     x11, =_cygtls.initialized       // Load relative 
>> offset of _cygtls.initialized
>> +       add     x11, x10, x11                   // compute absolute 
>> address and store in x11
>> +       cmp     sp, x11                         // Compare current 
>> stack pointer with TLS location
>> +       b.hs    0f                              // if sp >= tls, skip 
>> TLS logic
>> +       ldr     w12, [x11]                      // Load the value at 
>> _cygtls.initialized (32-bit)
>> +       movz    w13, #0xc763                    // Prepare magic 
>> value(0xc763173f) lower 16 bits
>> +       movk    w13, #0x173f, lsl #16           // Add upper 16 bits, 
>> full value now in w13
>> +       cmp     w12, w13                        // Compare loaded 
>> value with magic
>> +       b.ne    0f                              // If not equal, not 
>> initialized, skip TLS logic
> 
> Hmmm... while staring at this code, trying to refresh my memory of how 
> this it all works... this seems wrong.
> 
> Comparing this to the x86_64 version of sigfe_maybe, shouldn't the 
> branch here be to forward to label 1? Otherwise this function 
> effectively does nothing.
> 
> (Of course, this isn't very important since sigfe_maybe is only used by 
> cygwin_detach_dll())
> 
>> +       ret
>> +0:
>> +       ret
>> +       .seh_endproc
>> +
>>   _sigfe:
>>   _sigbe:
>>          .global sigdelayed
>> -- 
> 
> 
