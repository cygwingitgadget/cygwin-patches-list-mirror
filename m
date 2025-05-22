Return-Path: <SRS0=RhAN=YG=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w06.mail.nifty.com (mta-snd-w06.mail.nifty.com [106.153.227.38])
	by sourceware.org (Postfix) with ESMTPS id 44D633857B9E
	for <cygwin-patches@cygwin.com>; Thu, 22 May 2025 19:46:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 44D633857B9E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 44D633857B9E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1747943201; cv=none;
	b=W2nH3cKuCQAbPXAabUxCINtcM8VGU//SFw8bBtBfb+SmtD0EoRsIH39QC7DrXi/NtuynJqCW7bnZ0YuUstuyK+XxuJ+NKUJSivSGGG/2zxvo49kEept2EooN8RTGd9Leh/gFYd3QtOnfrG2zvPVWLds4KyylstBsyawdvSZSbp0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1747943201; c=relaxed/simple;
	bh=0yezNGUXvlfBbb1ryXBlroLrRzO646/4UgKxfTIOpDI=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=pXv2X2VArdzWyKWS1685YL6Vrm+2UPOXcH3eOfFVuq2oe+kMgIg79Ln3SpOcKb0oQt0mQMHZraBSWgL5Bsl43OiE91EPwhtV0rRiS7UxO5aBPP34htKBM95EUS23BWlmmyqAUW4NSBOiQut5sSlotmfq1UTLXYTRapUlWpTZSUo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 44D633857B9E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Qh7v2SlV
Received: from HP-Z230 by mta-snd-w06.mail.nifty.com with ESMTP
          id <20250522194638007.IMWR.86286.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 23 May 2025 04:46:38 +0900
Date: Fri, 23 May 2025 04:46:36 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: dll_init: use size_t instead of DWORD for size
Message-Id: <20250523044636.0e1aa3327c0501875bcf9068@nifty.ne.jp>
In-Reply-To: <61ee55a2-9aed-187b-a748-a3c653255177@jdrake.com>
References: <61ee55a2-9aed-187b-a748-a3c653255177@jdrake.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1747943198;
 bh=5sOZfFh0QSUWDF+J9giOMkALWyAG3z3mpQS011Dg8WA=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=Qh7v2SlVBMOXYhthBpvw1qu8oK9/eGn6/VG1879qhQQOx4DV1V6OqE1GeU7LdAi2au1vZITo
 iFbhlfC6u9ZyyroMP4v5hXikZ4QC9c6EmytVno4FhMtmm3b0FK4EhODoaNecMX4YKCq8q7mxXb
 jgAFedQxboLy0hGcJNG21Vw3ZAw9/Wul1rQv4p8B4qxJ+LGR46b45wpwdx4hswIoJeMrEHXEQr
 dVo7Ksnh+VxomuNGwqgodzDClgL8I6SdO5cqXQQNYbfenN3ixoPUyC/KBjv+YIy3BM/jaWEdle
 I4Jyr+dEK542U3fqzduoqmSTf0xix3TihLvsRItWYJMBjhFg==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 22 May 2025 10:11:58 -0700 (PDT)
Jeremy Drake wrote:
> The RegionSize member of the MEMORY_BASIC_INFORMATION struct is of type
> SIZE_T, and it may be larger than will fit in a DWORD (I observed
> 0x200000000).  This resulted in an error due to trying to reserve 0
> bytes from VirtualAlloc.
> 
> Fixes: 8d777a13fcf4 ("* dll_init.cc (reserve_at, release_at): New functions.")
> Addresses: https://cygwin.com/pipermail/cygwin/2025-May/258154.html
> Reported-by: Yuyi Wang <Strawberry_Str@hotmail.com>
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> ---
>  winsup/cygwin/dll_init.cc   | 2 +-
>  winsup/cygwin/release/3.6.2 | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/dll_init.cc b/winsup/cygwin/dll_init.cc
> index b8f38b56de..e5953ca9f6 100644
> --- a/winsup/cygwin/dll_init.cc
> +++ b/winsup/cygwin/dll_init.cc
> @@ -633,7 +633,7 @@ dll_list::track_self ()
>  static PVOID
>  reserve_at (PCWCHAR name, PVOID here, PVOID dll_base, DWORD dll_size)
>  {
> -  DWORD size;
> +  size_t size;
>    MEMORY_BASIC_INFORMATION mb;
> 
>    if (!VirtualQuery (here, &mb, sizeof (mb)))
> diff --git a/winsup/cygwin/release/3.6.2 b/winsup/cygwin/release/3.6.2
> index 3b1944d99f..16a4fee156 100644
> --- a/winsup/cygwin/release/3.6.2
> +++ b/winsup/cygwin/release/3.6.2
> @@ -28,3 +28,6 @@ Fixes:
> 
>  - Fix infinite exception loop on segmentation fault when strace-ing
>    Addresses: https://cygwin.com/pipermail/cygwin/2025-May/258144.html
> +
> +- Fix size truncation in dll_init reserve_at function.
> +  Addresses: https://cygwin.com/pipermail/cygwin/2025-May/258154.html
> -- 
> 2.49.0.windows.1
> 

Nice cache!
Question is: Isn't it better to declare size as SIZE_T rather
than size_t because the 2nd arg (size) of VirtualAlloc() is
declared as SIZE_T?

Other than that LGTM. If you think size_t is better, please push
as is.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
