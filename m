Return-Path: <SRS0=+GNH=66=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo001.btinternet.com (btprdrgo001.btinternet.com [65.20.50.131])
	by sourceware.org (Postfix) with ESMTP id 5AB584BA2E04
	for <cygwin-patches@cygwin.com>; Wed, 24 Dec 2025 15:29:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5AB584BA2E04
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5AB584BA2E04
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.131
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766590172; cv=none;
	b=E+T4VUjvVMvDpVwfUJzCr8iIB18P279K8QLInWmuv6OmmVgQ47kFTQczAJfB1OAZRjh/gWsu3BBpxICAcCLgG/CYoXahyKb8LlejtOgB3gSNe1XTwQntMugabmgC9JFH5AT9lFhOpgLQX/5n7bKtJW1x6HKjC2+d645hVxWwmlA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766590172; c=relaxed/simple;
	bh=PTdi7bbTYQx9a2oHPacsM22Dk/s5WuN+XY8+CoK/YTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=WE3Lg21Tbs6sw2TNC4nM9BOt4YRaNB/fRYp+m/EcQs7Gumkj+00VFFwOpL642U+jgEgQoyOq2lWk5PMYZWVFtoNe88RUmNCo2zNfTLLzPfoOU/3Td0ApfXFIWv383Hu/2ggtHXOjgZZVC3maD5SwHcgB+WZaea4ek5qRy8QdYns=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5AB584BA2E04
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 693FF9DF00F1718D
X-Originating-IP: [86.143.185.36]
X-OWM-Source-IP: 86.143.185.36
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeifedtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeetudejffefvddtgeeuieevueevleefuedttdegjefgtdevtddtveetiefhudfhtdenucffohhmrghinheptgihghifihhnrdgtohhmpdhmihgtrhhoshhofhhtrdgtohhmnecukfhppeekiedrudegfedrudekhedrfeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudegfedrudekhedrfeeipdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddugeefqddukeehqdefiedrrhgrnhhgvgekiedqudegfedrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtuddpnhgspghr
	tghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepthgrkhgrshhhihdrhigrnhhosehnihhfthihrdhnvgdrjhhp
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.143.185.36) by btprdrgo001.btinternet.com (authenticated as jonturney@btinternet.com)
        id 693FF9DF00F1718D; Wed, 24 Dec 2025 15:29:25 +0000
Message-ID: <ea7ab90b-f7a6-4203-ad62-a66467b155f5@dronecode.org.uk>
Date: Wed, 24 Dec 2025 15:29:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: thread: Fix stack alignment for
 PTHREAD_CANCEL_ASYNCHRONOUS
To: Takashi Yano <takashi.yano@nifty.ne.jp>
References: <20251223184150.1415-1-takashi.yano@nifty.ne.jp>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20251223184150.1415-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 23/12/2025 18:41, Takashi Yano wrote:
> The test case winsup/testsuites/winsup.api/pthread/cancel2 fails
> on Windows 11 and Windows Server 2025, while it works on Windows 10
> and Windows Server 2022. PTHREAD_CANCEL_ASYNCHRONOUS is implemented

Awesome piece of detective work tracking this down! Well done!

> using [GS]etThreadContext() on the target thread and forcibly
> overrides instruction pointer to pthread::static_cancel_self().
> Previously, the stack pointer was not trimmed to 16-byte alignment,
> even though this is required by 64-bit Windows ABI. This appears to
> have been overlooked when cygwin first added x86_64 support.
> 
> This patch fixes this issue by aligning the stack pointer as well as
> the instruction pointer in the PTHREAD_CANCEL_ASYNCHRONOUS handling.

To restate the problem a bit more generally:

* PTHREAD_CANCEL_ASYNCHRONOUS is implemented by forcing the target 
thread's IP to pthread::static_cancel_self().

* static_cancel_self() may (will) call Windows API functions during 
thread shutdown. A misaligned stack will lead to unexpected exceptions.

* At the start of the function prologue the stack is expected to be at 
an offset of 8 from a 16-byte boundary (IP % 16 == 8), as the call 
instruction has just pushed the return IP onto the stack.

* Therefore, we must also adjust the stack pointer like that to ensure 
that stack alignment is correct at the end of the function prologue.

> Addresses: https://cygwin.com/pipermail/cygwin/2025-December/259117.html
> Fixes: 61522196c715 ("* Merge in cygwin-64bit-branch.")

Given all that, it's kind of surprising that this ever worked at all!

> Reported-by: Takashi Yano <takashi.yano@nity.ne.jp>
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nity.ne.jp>
> ---
>   winsup/cygwin/thread.cc | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
> index 86a00e76e..2270a248b 100644
> --- a/winsup/cygwin/thread.cc
> +++ b/winsup/cygwin/thread.cc
> @@ -630,6 +630,25 @@ pthread::cancel ()
>         threadlist_t *tl_entry = cygheap->find_tls (cygtls);
>         if (!cygtls->inside_kernel (&context))
>   	{
> +#if defined(__x86_64__)
> +	  /* Need to trim alignment of stack pointer.
> +	     https://learn.microsoft.com/en-us/cpp/build/stack-usage?view=msvc-170
> +	     states,
> +	       "The stack will always be maintained 16-byte aligned,
> +	        except within the prolog (for example, after the return
> +		address is pushed),",
> +	     that is, we need 16n + 8 byte alignment here. */

Maybe this should say something like "we don't fully emulate a call 
instruction, by pushing the current IP onto the stack. But we need to 
fake the SP adjustment that does, in order for SP to be correctly 
aligned at the end of the function prologue"?

Returning from pthread::static_cancel_self() mustn't happen because we 
haven't fully synthesized the call instruction by storing the return 
address on the stack (and maybe other things). This is memorialized by 
the no_return function attribute.

> +	  context._CX_stackPtr &= 0xfffffffffffffff8UL;
> +	  if ((context._CX_stackPtr & 8) == 0)
> +	    context._CX_stackPtr -= 8;
> +#elif defined(__aarch64__)
> +	  /* 16 bytes alignment required. Trim stack pointer just in case.
> +	  https://learn.microsoft.com/en-us/cpp/build/arm64-windows-abi-conventions?view=msvc-170
> +	  */
> +	  context._CX_stackPtr &= 0xfffffffffffffff0UL;

I kind of like (~0x0FUL) as it saves counting if that's the right number 
of 'F's :)

> +#else
> +#error unimplemented for this target
> +#endif
>   	  context._CX_instPtr = (ULONG_PTR) pthread::static_cancel_self;
>   	  SetThreadContext (win32_obj_id, &context);
>   	}


Some future work thoughts:

* It seems like the force_align_arg_pointer function attribute maybe 
instructs the compiler to do the appropriate re-alignment, but opinion 
seems mixed as to if it works correctly.

* I don't think there are any other, similar uses of SetThreadContext, 
but if there are, maybe they need similar treatment.

* As a thought experiment, I'm not sure what the potential for double 
frees or similar bad things happening, if the target thread is in the 
middle of exiting already. I think thread class has some guards against 
that kind of thing?

