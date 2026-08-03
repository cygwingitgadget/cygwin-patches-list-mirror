Return-Path: <SRS0=kup5=F4=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 7C0114BA79A0
	for <cygwin-patches@cygwin.com>; Mon,  3 Aug 2026 08:52:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7C0114BA79A0
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7C0114BA79A0
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1785747149; cv=none;
	b=jHuggmCRltOy1OYKZ16u4mhpKE+wY4tcXnaevoMUDVKS9+vaSZlu8Dvou4DxIraDZ91+/5wE92xJsI6Eonkc19ev3NGiR6/1NRvRvGCu5x5iyRFHyIAFBO1LSijuVYMt1D0Lu+No9R4dKx6WiUccxu8njkm5fkAGam7fMlkrQFM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1785747149; c=relaxed/simple;
	bh=t3//WWz8maNEUy4+/qPti4NnYXOSa/KbXPeGby04ABo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=uCIeUypxnMlEC1Lf5d4VdRt8S5sGuy6YCuRoquYLbfhjH/1GNphSAIWfQoya3mm4Xv/pkJjTliDB9uYy4yfyqivHz+2XNt2Az5hu+u/9dE689gRHqFPiloo1u/lqt3MNMEiMAI/n39Jb3u0nVqiUCmLYJvedS8av2XPia0t1yy4=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7C0114BA79A0
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 67396uDU090531
	for <cygwin-patches@cygwin.com>; Mon, 3 Aug 2026 02:06:56 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpd4WT4Y6; Mon Aug  3 02:06:55 2026
Message-ID: <0f65a017-2590-4d55-a4bc-05730da1f521@maxrnd.com>
Date: Mon, 3 Aug 2026 01:52:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: open: Add missing unlock on error
To: cygwin-patches@cygwin.com
References: <20260803032303.5382-1-takashi.yano@nifty.ne.jp>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <20260803032303.5382-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On 8/2/2026 8:22 PM, Takashi Yano wrote:
> the commit 524d75ff7398 ("Cygwin: open: Unlock fdtab before open_
> with_arch()") introduced a bug that fdtab lock was not unlocked
> when new fd cannot be allocated due to an error.
> 
> This patch adds missing unlock for fdtab lock on error.
> 
> Fixes: 524d75ff7398 ("Cygwin: open: Unlock fdtab before open_with_arch()")
> Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>   winsup/cygwin/syscalls.cc | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> index e3ba8c65c..8373482e9 100644
> --- a/winsup/cygwin/syscalls.cc
> +++ b/winsup/cygwin/syscalls.cc
> @@ -1554,7 +1554,10 @@ open (const char *unix_path, int flags, ...)
>         cygheap->fdtab.lock();
>         fd = cygheap->fdtab.find_unused_handle ();
>         if (fd < 0)
> -	__leave;		/* errno already set */
> +	{
> +	  cygheap->fdtab.unlock();
> +	  __leave;		/* errno already set */
> +	}
>         cygheap->fdtab[fd] = fh; /* tentative setting to mark as used */
>         cygheap->fdtab.unlock();
>   

This patch LGTM.  Apologies for not catching this in my review.
Thanks & Regards,

..mark
