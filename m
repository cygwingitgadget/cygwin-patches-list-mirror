Return-Path: <SRS0=Jx4T=G6=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo012.btinternet.com (btprdrgo012.btinternet.com [65.20.50.237])
	by sourceware.org (Postfix) with ESMTP id 23FF64BC7EEB
	for <cygwin-patches@cygwin.com>; Sun,  6 Sep 2026 20:53:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 23FF64BC7EEB
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 23FF64BC7EEB
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.237
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1788728031; cv=none;
	b=R8mBfQAsJWNs4UmDXXoeYcd78sTyxy9vtp3orfVAvvBakOjZn+TZ8xbJf9SIl3xoe0qDBsZzmuJnWTm4Th4rA1UEnRIzS5OlTvdlOIhDVnz5xnIpc+4GyMBX6DkNobREo4S4kbQDCwgQ8JeROcH/iB3Y0ojGg6VaJnbOXNTNan8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1788728031; c=relaxed/simple;
	bh=bq8Fmsb5YbDNyGBJu9iol9Gpld26SouZ5yfuntR7F6g=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=b4qCTrJFXqCt8O+TG5yFVGcIluRBO4TvHJb+JiS5+9r1R2KIV7JN7fhvbIVj4GPttPpuDTAZTXStOhlO7/hexkyeGNNojOYc4KhNjBc8WEOYoVzw0JuGZ0az4te+U8DvtUgW4QH8on9/NZNKtupDyXD7gB/t/9RLQICpAJYymoY=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 23FF64BC7EEB
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A7161CE06147F40
X-Originating-IP: [62.56.66.111]
X-OWM-Source-IP: 62.56.66.111
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTG1FWxU5La6SEAa3ruxB+WrlpKll52Xr/WhyJM5WfBnaEWtUrPJi1LxEZ07yFgI15GgjtEJxlMXYSVXjZoqpiVpWbVsamobVypYkGmX8GCtnxjbUZnxTsTX8ZbAdqmxk/dC3JUjxGfxVHcb1t8ipNe0ntClmq5AEYIwlRsY9TGW6MV6NdVvdKAmNAy533GbUcY3c+dhwqm0aoVO5bQbiFasmxzLOUq0kEBkzE9K4ojMVboeLotustbXVtYNkldmgAjmj1upvd21/56eHDIcetQf4JmuMpyIqzNsLwEYGoclEMQcboeLwMSJB8l4xwYtAuNSCH5bI4qNJXyU8CwWAoqyPY+2OhdP6fQOu9KjN01gpRBGpCBJ60G34ykHeg1oC4rU6pPPke458SehcnV+F4yDCCLB25b354AGpkNU923xyJ7Kv7WndAFmSEQKBv6BDO4fpISE7SjDuFfVulquf9sQCPNpHDCbNaSFIoD04b3N59ul9hRT+vT16DOYwq+BcZ5WTTyZ1iSvTxDFEgL63f++1jmuDIXgAxqqIffkXClke/wNz2TiaNpIKWK/9UKAj/PA4K3kuxZ7Z2UzaZNmJm5hFQMokcWlNjfAyeXTfOGrnM1d3ZgdkKXFJ3G4wpvv0ipMusv1l2G3leZLUflW70UQv4ww5wYJT88x8IVmyMKy0w
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (62.56.66.111) by btprdrgo012.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A7161CE06147F40; Sun, 6 Sep 2026 21:53:47 +0100
Message-ID: <00920009-6ca5-4b19-b61c-5b5e6ea8c608@dronecode.org.uk>
Date: Sun, 6 Sep 2026 21:53:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: autoload: fix ws2_32 chained init on AArch64
References: <PN0P287MB0295C357517BE127B601D99092F02@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com,
 Chandru Kumaresan <chandru.kumaresan@multicorewareinc.com>
In-Reply-To: <PN0P287MB0295C357517BE127B601D99092F02@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 07/07/2026 10:31, Chandru Kumaresan wrote:
> Hi everyone,
> 
> On AArch64, the autoload INIT_WRAPPER passes func_info* via x30 ("mov
> x0, x30").  This works for the first init stage (std_dll_init), reached
> by the trampoline's "blr".  It breaks for a chained second init, because
> dll_chain reaches it via "br x1" without updating x30.
> 
> ws2_32 is the only DLL with such a chain (std_dll_init -> wsock_init ->
> dll_func_load).  wsock_init received garbage in x0, so WSAStartup was
> never called; every ws2_32 call failed with WSANOTINITIALISED / EFAULT.
> 
> dll_chain also runs twice for ws2_32, pushing a 16-byte frame each time.
> wsock_init consumes its arg from x30, not the stack, so the first frame
> strands.  dll_func_load then restores caller-save registers from a
> shifted offset, corrupting the first call's arguments.
> 
> Fix: copy func_info into x30 in dll_chain before the tail-branch, and
> give AArch64 a dedicated _wsock_init wrapper that drops the stranded
> frame ("add sp, sp, #16") before chaining to dll_func_load.

The loss of generality here makes me slightly unhappy.

(Although, practically, it's extremely likely that we'll ever have to 
deal with another DLL having special initialization requirements like 
ws2_32 does)

But.. it seems like maybe this could be written without dll_chain as a 
tail call, which would also balance the stack, so something like:

push x0 and lr
move lr to x0
bl x1
pop x0 and lr
ret

idk, this code is a real maze and every time I look at it I have to 
spend an hour drawing diagrams. So I'm perfectly prepared to be told 
that won't work!

It seems like there must be a generic way to write this for aarch64, but 
maybe it looks so different from the existing implementation it's not 
worth the effort of finding it...

> ---
>   winsup/cygwin/autoload.cc | 28 ++++++++++++++++++++++++++--
>   1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/autoload.cc b/winsup/cygwin/autoload.cc
> index 7054511b6..8d0f2a59e 100644
> --- a/winsup/cygwin/autoload.cc
> +++ b/winsup/cygwin/autoload.cc
> @@ -302,6 +302,10 @@ dll_func_load:                                           \n\
>     .global    dll_chain                                   \n\
>   dll_chain:                                               \n\
>     stp        x0, xzr, [sp, #-16]! // x0 = func_info* (= ret.high); push for dll_func_load\n\
> +  mov        x30, x0              // also pass func_info in x30: a chained INIT_WRAPPER\n\
> +                                  // (e.g. _wsock_init) reads its arg from x30, but is\n\
> +                                  // reached here via 'br' which would otherwise leave\n\
> +                                  // x30 stale.  dll_func_load ignores x30 (reads [sp]).\n\
>     br         x1                   // x1 = dll->init (= ret.low); tail-call resolver\n\
>   ");
>   #else
> @@ -481,9 +485,29 @@ std_dll_init (struct func_info *func)
> 
>   /* Initialization function for winsock stuff. */
> 
> -#if defined(__x86_64__) || defined(__aarch64__)
> -/* See above comment preceeding std_dll_init. */
> +#if defined(__x86_64__)
> +/* See above comment preceding std_dll_init. */
>   INIT_WRAPPER (wsock_init)
> +#elif defined(__aarch64__)
> +__asm__("\n\
> +  .text                                                  \n\
> +  .p2align 2                                             \n\
> +  .seh_proc _wsock_init                                  \n\
> +_wsock_init:                                             \n\
> +  stp        x29, x30, [sp, #-16]!  // save fp/lr, open our 16-byte frame\n\
> +  .seh_save_fplr_x 16                                   \n\
> +  .seh_endprologue                                      \n\
> +  mov        x0, x30              // x0 = func_info  (the wsock_init() argument)\n\
> +  bl         wsock_init           // run WSAStartup; returns x0=func_info, x1=dll_func_load\n\
> +  ldp        x29, xzr, [sp], #16  // restore fp, discard saved lr, close our frame\n\
> +  add        sp, sp, #16          // drop the stranded dll_chain frame so the\n\
> +                                  // downstream dll_func_load sees exactly one\n\
> +                                  // dll_chain frame above the trampoline frame\n\
> +  adrp       x30, dll_chain       // x30 = &dll_chain ...\n\
> +  add        x30, x30, #:lo12:dll_chain  // ... so the 'ret' below tail-chains there\n\
> +  ret                             // -> dll_chain, which tail-calls x1 (dll_func_load)\n\
> +  .seh_endproc                                          \n\
> +");
>   #else
>   #error unimplemented for this target
>   #endif
> --
