Return-Path: <SRS0=n1w5=5R=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo012.btinternet.com (btprdrgo012.btinternet.com [65.20.50.237])
	by sourceware.org (Postfix) with ESMTP id B0C1F3858C54
	for <cygwin-patches@cygwin.com>; Sun,  9 Nov 2025 16:30:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B0C1F3858C54
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B0C1F3858C54
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.237
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1762705830; cv=none;
	b=JnbMO13zdspXVPeSj5gBNjMenRo4iHWowL+H0kkjf1cJ1kTwcntESMG0tw57+kvE+o10wGNUMx+pzGu41bubmA0mR6SO9o2BbkqFJLSEsQmIOeWMtdK11XbDrQhWMLs6OVZXSQWaRwY+KrtgOnpb0/eyXSIc6frD4TvQbih1YMQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1762705830; c=relaxed/simple;
	bh=2+tO7H9cMmbh16VR2ecBqkPq4wuh//MIJRYZPJhmAk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=bzse1y/wX9MYXwTYS16fPYCTWkMKA7PhauQ/HxfC086rxJDJHiH/9SXCIcL3RuK+0nrMntbO/5D9opPgqYAa5NO6w3PVpLAybXseiVTlDC+TVcJDKxAdctGlMtYpQLVT+I/ciND9EXdlsscup3i3yHDyDeVnsQqK2wJ0RemqEIk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B0C1F3858C54
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 68CA1EA8053F079B
X-Originating-IP: [81.158.20.254]
X-OWM-Source-IP: 81.158.20.254
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleehleduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepgfeghfdvvdeijeettdfgleetffetfedtuefgfeevhedthefgffelfeethfdvleffnecuffhomhgrihhnpegthihgfihinhdrtghomhenucfkphepkedurdduheekrddvtddrvdehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkedurdduheekrddvtddrvdehgedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekuddqudehkedqvddtqddvheegrdhrrghnghgvkeduqdduheekrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdtuddvpdhnsggprhgtphhtthhopedvpdhrtghpthht
	oheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehtrghkrghshhhirdihrghnohesnhhifhhthidrnhgvrdhjph
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (81.158.20.254) by btprdrgo012.btinternet.com (authenticated as jonturney@btinternet.com)
        id 68CA1EA8053F079B; Sun, 9 Nov 2025 16:30:25 +0000
Message-ID: <4d245a58-542e-45dd-8451-aae9b6cef62b@dronecode.org.uk>
Date: Sun, 9 Nov 2025 16:30:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Cygwin: dll_init: Call __cxa_finalize() for DLL_LOAD
 even in exit_state
To: Takashi Yano <takashi.yano@nifty.ne.jp>
References: <20251028114853.11052-1-takashi.yano@nifty.ne.jp>
 <20251028114853.11052-2-takashi.yano@nifty.ne.jp>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20251028114853.11052-2-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_W,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 28/10/2025 11:48, Takashi Yano wrote:
> If dlclose() for the first DLL is called in the destructor of another
> linked DLL, __cxa_finalize() should be called even in exit_state. This
> is because if the second destructor is called in exit_state, the first
> DLL will be unloaded by dlclose(). Therefore, if __cxa_finalize() is
> not called here, the destructor of the first DLL will be called in exit()
> even though the first DLL is already unloaded. This causes crash at
> exit().  In the case above, __cxa_finalize() should be called before
> unloading the first DLL even in exit_state.

I realize the situation is complex, but this is kind of hard to follow.

"first DLL" and "second DLL" doesn't really clarify the the relationship 
between them. I guess it's something like DLL A is dlopened, which links 
with DLL B? So that might be a better?


> Addresses: https://cygwin.com/pipermail/cygwin/2025-October/258877.html
> Fixes: c019a66c32f8 ("* dll_init.cc (dll_list::detach) ... Don't call __cxa_finalize in exiting case.")
> Reported-by: Thomas Huth <th.huth@posteo.eu>
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>   winsup/cygwin/dll_init.cc | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/dll_init.cc b/winsup/cygwin/dll_init.cc
> index 1369165c9..b6ab4ed11 100644
> --- a/winsup/cygwin/dll_init.cc
> +++ b/winsup/cygwin/dll_init.cc
> @@ -584,7 +584,8 @@ dll_list::detach (void *retaddr)
>   	  /* Ensure our exception handler is enabled for destructors */
>   	  exception protect;
>   	  /* Call finalize function if we are not already exiting */
> -	  if (!exit_state)
> +	  /* Loaded DLLs need finalize function even in the exiting state */


"We always call the finialize function for run-time loaded (dlopened) 
DLLs because..."


> +	  if (!exit_state || d->type == DLL_LOAD)
>   	    __cxa_finalize (d->handle);
>   	  d->run_dtors ();
>   	}


