Return-Path: <SRS0=p9wN=Y3=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	by sourceware.org (Postfix) with ESMTPS id 7426F381F5CE
	for <cygwin-patches@cygwin.com>; Thu, 12 Jun 2025 20:32:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7426F381F5CE
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7426F381F5CE
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1749760320; cv=none;
	b=Dr0m0Rk7Dm394zt4xEZHGHRzMYhEXhmR3MGdSVMICsijSEhR2ekyZxnkQEpspRAdj+qPtAuqVrIazkjY7wLr8jbxg19lZ0XiMYAMSfJ4RXnLmrG8hfgPNBkHzzuCG3Js6xfOp0z0RwxWQY88feD7L1YS3NtnesVWYscdTff5nn8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1749760320; c=relaxed/simple;
	bh=DrncbM6hdgaS13Sz67vkTg+wWzGCe05YnoeGT2yXygo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=BAlek9JfGVZ1eXUv3VaCqsSjKyiXqV+yiSl6yVTDz0BKgxR/Iu6wlLPZhcqO8cb/+vFz/IDRCJPupKlyolFg4d+eByyKpjnNDZMhIeenG/T2bcJ3lhRLaek8kYLWcetehURiswmZQIA6y4zpaFsjkFoCjY5p4/FrSgaiwUk+p8A=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7426F381F5CE
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=jkaUqEzf
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 23EA816010C
	for <cygwin-patches@cygwin.com>; Thu, 12 Jun 2025 20:32:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf07.hostedemail.com (Postfix) with ESMTPA id B3FE32002E
	for <cygwin-patches@cygwin.com>; Thu, 12 Jun 2025 20:31:58 +0000 (UTC)
Message-ID: <c03e5943-d622-4381-8ce1-c85f1ffa3c69@SystematicSW.ab.ca>
Date: Thu, 12 Jun 2025 14:31:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: implement spinlock pause for AArch64
To: cygwin-patches@cygwin.com
References: <DB9PR83MB09237758F38BC0ACB9AAB51B9274A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Content-Language: en-CA
Organization: Systematic Software
In-Reply-To: <DB9PR83MB09237758F38BC0ACB9AAB51B9274A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B3FE32002E
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: 5hdfkmm9yb6bpuh47sbex8o3wmwwfauj
X-Rspamd-Server: rspamout06
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1/1wuI1iEYWEpNBC/7Jm8M1zXThUa5U08k=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=fDAfOilhjA5gM3co9XCqHTJxwiVEXSc3xwXHNwL9P70=; b=jkaUqEzfOvEJVCXtwzvBRys9HRS/w6rBeV4x3X31bVTmda03Ui2wTMV+gfnzaETFePwHlHGeTKMZS+MmP33TAwFsgMegcHMBQPPC+j/HKJMfmdZ1cHC505Hpf2IVr09AYQUXJ9RvyXYZsp7pembQUJJ+id/VKqfTikUjKCh7tHJUPS7uCnCFHT3gz8wWs2xXW3qmF2Bz0C7eAGJ/EgMkvvIyy7Nc/P+9Hcicek+9OPrOftBTKPelZWy2CHgor+viNCSMXmqdBX75FwIs+D6Y/4AbeREXsDpqIaoD/iHbHiqx4ne3VrhDTqivE380o2QnDSUfaZTEKsikd8DVzEIjUA==
X-HE-Tag: 1749760318-122703
X-HE-Meta: U2FsdGVkX19XQ9oXZ2CgAEgTCizvWuX5ovvUZ71HrpixRiB+BHPgRbNjJkoxTaSQZL3NGK6VykLg/6ygG5jnUzwQKZZGOaYQ2KqJXymUi7Hed8QLAsUnehd4fFnhHs9oDkNNRz2wlVlVoiS1om7PqcL/5fAGU6l6NSKfC2vDoZi+9Ut9b11yjCAp0nXFOwXGkGvxdckUchScU7Rc1lxNoK/lWCHC5WI4T380wnoj+UEOtwiaTHJHDF2RYCZSJbQo7lQJUIYXhEfeRfMc+9qw5IDkfQhpYebto6WXiRc93DKIeLwHbaOCFNW/7YK1Zc7IbREOMMklLehvnhMZLft1zcEHz+Ov1P1n+YxIfQdEkyVwRo9wMido3Hvw2xrseYC5tWQaigXT0kzNxhKs+/Mff8XxT2L8X+PYBxYpnTB1Lf8TFf99TyPUh/k1CZ2WqPTDen6biURJ7n2r9+MxXvQSDntweIiGUTYO
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Rust apparently uses yield on arm32, and isb (instruction sync barrier) on 
aarch64, as yield is effectively a NOP (although it could be implemented to free 
up pipeline slots, SMT switch, or signal), while isb (with optional sy operand) 
is more like pause on x86_64:

	https://stackoverflow.com/a/70811680

https://developer.arm.com/documentation/dui0473/m/arm-and-thumb-instructions/yield

https://developer.arm.com/documentation/ddi0596/2021-06/Base-Instructions/ISB--Instruction-Synchronization-Barrier-

https://www.intel.com/content/www/us/en/develop/documentation/cpp-compiler-developer-guide-and-reference/top/compiler-reference/intrinsics/intrinsics-for-sse2/miscellaneous-functions-and-intrinsics/pause-intrinsic.html

On 2025-06-12 07:17, Radek Barton via Cygwin-patches wrote:
> This patch implements pause for spin locks at two places in the codebase: winsup/cygwin/local_includes/cygtls.h and winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc.
> ---
>  From 0f82052a8c60811f784bbc76f6df1e0d9a971947 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Radek=20Barto=C5=88?= <radek.barton@microsoft.com>
> Date: Thu, 5 Jun 2025 12:41:37 +0200
> Subject: [PATCH] Cygwin: implement spinlock pause for AArch64
> 
> ---
>   winsup/cygwin/local_includes/cygtls.h | 4 +++-
>   winsup/cygwin/thread.cc               | 4 ++++
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/local_includes/cygtls.h b/winsup/cygwin/local_includes/cygtls.h
> index 4698352ae..74ff92971 100644
> --- a/winsup/cygwin/local_includes/cygtls.h
> +++ b/winsup/cygwin/local_includes/cygtls.h
> @@ -242,8 +242,10 @@ public: /* Do NOT remove this public: line, it's a marker for gentls_offsets. */
>     {
>       while (InterlockedExchange (&stacklock, 1))
>         {
> -#ifdef __x86_64__
> +#if defined(__x86_64__)
>   	__asm__ ("pause");
> +#elif defined(__aarch64__)
> +	__asm__ ("yield");
>   #else
>   #error unimplemented for this target
>   #endif
> diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
> index fea6079b8..a504e13b5 100644
> --- a/winsup/cygwin/thread.cc
> +++ b/winsup/cygwin/thread.cc
> @@ -1968,7 +1968,11 @@ pthread_spinlock::lock ()
>         else if (spins < FAST_SPINS_LIMIT)
>           {
>             ++spins;
> +#if defined(__x86_64__)
>             __asm__ volatile ("pause":::);
> +#elif defined(__aarch64__)
> +          __asm__ volatile ("yield":::);
> +#endif
>           }
>         else
>   	{


-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
