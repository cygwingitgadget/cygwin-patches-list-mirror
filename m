Return-Path: <SRS0=5cOX=E2=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo002.btinternet.com (btprdrgo002.btinternet.com [65.20.50.146])
	by sourceware.org (Postfix) with ESMTP id DA3BA4BA5435
	for <cygwin-patches@cygwin.com>; Tue, 30 Jun 2026 19:32:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DA3BA4BA5435
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DA3BA4BA5435
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.146
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782847962; cv=none;
	b=Us60Yozm+H5XeRpzY8IMXr2m1pIdfkjGtDLgaX2VnrFNS42olCVMn3WoQiV6ZR2jMmaathyskNlkYLdLbpMLR/43ly7Te+b+dNEKG+AYKeQT/ygJfwMggmMR5grPx2t58DIUF8+mCTquPstAUNAwHJKx9Gcer5oBuAMmEZSSjOs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782847962; c=relaxed/simple;
	bh=Fr/G++F8zRwY8U8u58jX5pPk0Eo3SpGq5KksoglO17o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To; b=W/DEDyy6O2oFOZAyAVPewRifom0TwLGsCI7DPL/iSZaqq89lf5LxVJjV9RkmiK8fry4hDUqmP5tHk+8hNG9w8iVzGhW3rPI1quJfeT5EM1b9lHAaI6FUTymQ6iPbVenlF+rxGcNpMEEW3VsbIXtxfdFVfyorLBvcVjuxO753fz4=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DA3BA4BA5435
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A08C1FD03A0FBBE
X-Originating-IP: [62.56.66.111]
X-OWM-Source-IP: 62.56.66.111
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTGrCyqohC3dAp5PSqYgmR66YcnXYBVlztOyHy2FviObcKb95vnBTBRG9FNhzu0kJLtwAodb+ZdKIf14TIn98XxBvdnSlMJ/HkIuk73FhJpNt+nOkrZVIi8gUMzZrcqO43n2+fj/guz3eXEDTVx4eghc3QpIUYQiMMG+kMMcghdC62evIwQOV5/rq41uIQiz3aTsSgYwzIInVGyKU6G8Oan+vbE6/f8GUV1pjsp+4xsPkS9cUXfL8wKMwlMThKq7aczd39GnuL9tQnt/1xVDb+8A2epPuy2I0a0vUzlAmytxgjSz/GKqav7sq6N6YloqUOs2wd15RlbfsAn3KPgsoeNZeAtDRH5+najh9/woz1ZJIKo/eK5pABI3nmW5eS2Fcun+SqWsthFynGEoT8v/wWtybbODDMtevYPzz4+FeGVh/2E4oB0at0McAazrviViI6ldLiyEB2WSfUAjn93h32tJxKy/YofGxmznnFxMHYJ660PaPWG88x/qHZXbN+v9cskv9OPJCy/1a/mukOBPklzyXkmA/btbG1AEFYTOW5zdTgHBU7imASmRjhWHwSxfUdGjtpqvDciO0UGnqnsAdopalNVU1kx5LY4PY39ZF8He9oflyGhOw9dQiGkUkVaWkpejBpIcrtt9FP320bWRItr6caeINvuQ+CUwFbouq/DiGQ
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (62.56.66.111) by btprdrgo002.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A08C1FD03A0FBBE; Tue, 30 Jun 2026 20:32:35 +0100
Message-ID: <02acdda1-92a7-4167-a99e-07b76933dd15@dronecode.org.uk>
Date: Tue, 30 Jun 2026 20:32:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jon Turney <jon.turney@dronecode.org.uk>
Subject: Re: [PATCH V2] Cygwin: gendef: Implement _sigfe function for TLS
 handling on AArch64
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
Cc: cygwin-patches@cygwin.com
References: <MA0P287MB3082B91F52855CCC343FEEF99FA9A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
 <MA0P287MB30828B5A7845AF3B4776382B9F8DA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Content-Language: en-GB
In-Reply-To: <MA0P287MB30828B5A7845AF3B4776382B9F8DA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 16/01/2026 17:41, Thirumalai Nagalingam wrote:
> Hi,
> 
> No additional changes in this version.
> This V2 patch was regenerated on top of `cygwin/main` and applies cleanly as-is, without any additional dependencies.
> 
> Thanks,
> Thirumalai Nagalingam
> 
> In-lined Patch:
> 
> diff --git a/winsup/cygwin/scripts/gendef b/winsup/cygwin/scripts/gendef
> index 32ceb3578..ab57739fa 100755
> --- a/winsup/cygwin/scripts/gendef
> +++ b/winsup/cygwin/scripts/gendef
> @@ -385,7 +385,44 @@ _sigfe_maybe:                                      # stack is aligned on entry!
>          ret
>          .seh_endproc
> 
> +    .seh_proc _sigfe
>   _sigfe:
> +    .seh_endprologue
> +    ldr     x10, [x18, #0x8]           // Load TLS base into x10
> +    mov     w9, #1                     // constant value for lock acquisition
> +0:  ldr     x11, =_cygtls.stacklock    // Load offset of stacklock
> +    add     x12, x10, x11              // Compute final address of stacklock
> +    ldaxr   w13, [x12]                 // Load current stacklock value atomically
> +    stlxr   w14, w9, [x12]             // Attempt to store 1 to stacklock atomically
> +    cbnz    w14, 0b                    // Retry if atomic store failed
> +    cbz     w13, 1f                    // If lock was free, proceed
> +    yield
> +    b       0b                         // Retry acquiring the lock
> +1:
> +    ldr     x11, =_cygtls.incyg        // Load offset of incyg
> +    add     x12, x10, x11              // Compute final address of incyg
> +    ldr     w9, [x12]                  // Load current incyg value
> +    add     w9, w9, #1                 // Increment incyg
> +    str     w9, [x12]                  // Store updated incyg value
> +    mov     x9, #8                     // Set stack frame size increment (8 bytes)
> +2:  ldr     x11, =_cygtls.stackptr     // Load offset of stack pointer
> +    add     x12, x10, x11              // Compute final address of stack pointer
> +    ldaxr   x13, [x12]                 // Atomically load current stack pointer
> +    add     x14, x13, x9               // Compute new stack pointer value
> +    stlxr   w15, x14, [x12]            // Attempt to update stack pointer atomically
> +    cbnz    w15, 2b                    // Retry if atomic update failed

I'm wondering if this is an over-literal conversion of the x86_64 
implementation.

That does use '[lock] xchgq', but I'm guessing that's not because the 
change on the sigstack needs to be atomic (because nothing else should 
be manipulating the sigstack while cygtls.stacklock is held?), but 
because a memory barrier is needed here (since writing to the sigstack 
needs to be complete before stacklock is released)? Or maybe it's just 
more concise to use xchg there?

This atomic operation also seems to be replicated into sigbe.

> +    str     x30, [x13]                 // Save LR(return address) on stack
> +    adr     x11, _sigbe                // Load address of _sigbe
> +    mov     x30, x11                   // Set LR = _sigbe
> +    ldr     x11, =_cygtls.stacklock    // Load offset of stacklock TLS variable
> +    add     x12, x10, x11              // Compute final address of stacklock
> +    ldr     w9, [x12]                  // Load current stacklock value
> +    sub     w9, w9, #1                 // Decrement stacklock to release lock
> +    stlr    w9, [x12]                  // Store stacklock value (release lock)
> +    ldr     x9, [sp], #16              // Pop real func address from stack
> +    br      x9                         // Branch to real function
> +    .seh_endproc
> +
