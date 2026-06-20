Return-Path: <SRS0=JR7i=EQ=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo003.btinternet.com (btprdrgo003.btinternet.com [65.20.50.240])
	by sourceware.org (Postfix) with ESMTP id A9F074BB1C11
	for <cygwin-patches@cygwin.com>; Sat, 20 Jun 2026 12:46:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A9F074BB1C11
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A9F074BB1C11
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.240
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1781959581; cv=none;
	b=PLfAlANx+rUMkh4Q0V7WYVgSo12jMoqFq1yM08s+WgfPqM15wQ+st2UDHaXqPDXCtlo5eKBZIK6Bhv3vD8pviWgJt8T7m537qck2oNnOCMdlrMKfyd5ozq7JVawucCNZAYvf6NIirU0nkGzL2wEqNlNRbyDRBocdRy9nlxzfuAQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1781959581; c=relaxed/simple;
	bh=EDAFU6CIL8UMzPujp0K16LBQ9hCgxntSEIEmdLBcRNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=vshCZVPQR7a0SihZsb/frCbJ40oDsoUJ9J0rC4KXDY1X+FbR3xc7u8pK2JUQRKjkeKu7yzwAu3ItWrXvNfx8PICofMn8H7W94A3NLylsrHOA7LyI9wC2NYxXqDMRbmXaAQWkAX0qBqRJJP6ukSnaGuLHMQjsZMyvEGfoKa5f68s=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A9F074BB1C11
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A02527803372E65
X-Originating-IP: [62.56.66.111]
X-OWM-Source-IP: 62.56.66.111
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTGJw6sYFaMS3LAll2X9IzS5J4Q70BvrnQltVRcU8PG9XmdKtvrsWk3oBRdWq4dlHDsvQpHtwsCqdQcVz+nw5ruTiQS0o3QVEI3FvR7BQbX2U0J5HvduUpcjmuSTYzmSvWWeRhuXpzgRC4vkJJDqrL5G5QEoy4w3nqWeM+FBsrjdulDjFEIsnJ5PE+UxzGXzcHDQqvY/3WPFbcmwTWUErMHYa0XhUB/GcBXt3399wc2n936wA46vWxC2Yu/xHBRiGaj7Qvgv2qkP0UzlX6l4o9FQUJ5Onxzqqf8vzku1hu+e0/tCKbVzUjLL7i5hRGAURgQJcVwTGOoGXTyAozZdqzHzcfAfBlHySqlRwNWMRd+GG/3YBA8vcrxlQ9lL5QCsJWO425K8ygbkFqb886ue2VDbmZrLP8A58zVT0yP2REg3AwkJpsioR9zW/7485HXmE6dDaubdtJNJr+ZUdD+SsHWU3S6I1LV2SIQha93PaH9ZegjwBKvfe5R3Y1KwJO47wLdK/hb5EAxxS1j7dmsKLlHy5ZPtsBhxD4VmZnNL1l8199PtnCQRaHrI1QZOpEKq7Boz2WzH/Mo+/rtzYe8Czk1815eAOs7LRHdgsABOJBdwIlaD3vppcDJXID3/ovFgZszljuzAxKZALv1oY5Tja/LXGF8J4rkXfA09rQ3EMKDtqg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (62.56.66.111) by btprdrgo003.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A02527803372E65; Sat, 20 Jun 2026 13:46:14 +0100
Message-ID: <6fd27001-6a1f-4d20-a621-e395b6b85762@dronecode.org.uk>
Date: Sat, 20 Jun 2026 13:46:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: gendef: add _sigfe_maybe for TLS initialization
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
References: <MA0P287MB3082181CE402F12F043C3A0B9FA9A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <MA0P287MB3082181CE402F12F043C3A0B9FA9A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 19/12/2025 17:30, Thirumalai Nagalingam wrote:
> Hi all,
> 
> Please find the attached patch which adds an ARM64 stub for the _sigfe_maybe routine
> in the gendef script.
> 
> Any feedback or nits are very welcome. The changes are documented with inline
> comments intended to be self-explanatory. please let me know if any part
> of this patch should be adjusted.
> 
> Thanks for your time and review.
> 
> Thanks & regards
> Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
> 
> In-lined patch:
> 
> diff --git a/winsup/cygwin/scripts/gendef b/winsup/cygwin/scripts/gendef
> index 1419704b8..52a5b77ca 100755
> --- a/winsup/cygwin/scripts/gendef
> +++ b/winsup/cygwin/scripts/gendef
> @@ -367,8 +367,24 @@ EOF
>          .include "tlsoffsets"
>          .text
> 
> -_sigfe_maybe:
> -       .global _sigbe
> +       .seh_proc _sigfe_maybe
> +_sigfe_maybe:                                  # stack is aligned on entry!
> +       .seh_endprologue
> +       ldr     x10, [x18, #0x8]                // Load TEB pointer in x10
> +       ldr     x11, =_cygtls.initialized       // Load relative offset of _cygtls.initialized
> +       add     x11, x10, x11                   // compute absolute address and store in x11
> +       cmp     sp, x11                         // Compare current stack pointer with TLS location
> +       b.hs    0f                              // if sp >= tls, skip TLS logic
> +       ldr     w12, [x11]                      // Load the value at _cygtls.initialized (32-bit)
> +       movz    w13, #0xc763                    // Prepare magic value(0xc763173f) lower 16 bits
> +       movk    w13, #0x173f, lsl #16           // Add upper 16 bits, full value now in w13
> +       cmp     w12, w13                        // Compare loaded value with magic
> +       b.ne    0f                              // If not equal, not initialized, skip TLS logic

Hmmm... while staring at this code, trying to refresh my memory of how 
this it all works... this seems wrong.

Comparing this to the x86_64 version of sigfe_maybe, shouldn't the 
branch here be to forward to label 1? Otherwise this function 
effectively does nothing.

(Of course, this isn't very important since sigfe_maybe is only used by 
cygwin_detach_dll())

> +       ret
> +0:
> +       ret
> +       .seh_endproc
> +
>   _sigfe:
>   _sigbe:
>          .global sigdelayed
> --

