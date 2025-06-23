Return-Path: <SRS0=2kyc=ZG=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w06.mail.nifty.com (mta-snd-w06.mail.nifty.com [106.153.227.38])
	by sourceware.org (Postfix) with ESMTPS id A9C3038505E6
	for <cygwin-patches@cygwin.com>; Mon, 23 Jun 2025 13:19:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A9C3038505E6
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A9C3038505E6
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750684752; cv=none;
	b=rm1wR+RUXRINE4exMLx2trx0ihEJpazykM1YqFOE1cN3lFESzxr+EhoZ3QrcrCe4yClMs153UWUr9X4HVxaXUo88BlnEDHXtzXrqmrnSKL74u3MJCoAMafcIZd+jIpv8x0siEePYW7fV60PVaSsQhHpxcV49NT1BffDuoz/dKyE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750684752; c=relaxed/simple;
	bh=3TzbsdAk57CSgDRYt0hJRI+jsgybzrHgDjBo0jQVzFQ=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=aXEbQgRv09XbaSHzXlDP/gSX6LZvDAy/QOG3XhmvSc6lUE65zxAjoOtESCdEj12Y3alLVANQzrTiLNcuOLUtnI/tG82pq3o9+OimE9AvyhhYF9ZJq/qdiBJi895xCdPqSYtjWfMg/P5+T3psDQn0Ymo6AzUfDQNeZexX3NfSYBo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A9C3038505E6
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Ls5FNA5B
Received: from HP-Z230 by mta-snd-w06.mail.nifty.com with ESMTP
          id <20250623131909746.OKCJ.86286.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 23 Jun 2025 22:19:09 +0900
Date: Mon, 23 Jun 2025 22:19:08 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] pipe: fix SSH hang (again)
Message-Id: <20250623221908.eb98440b375387e3bc68f295@nifty.ne.jp>
In-Reply-To: <c9b1313d5d8a690aae9788402ec5190a1f18ce75.1750679728.git.johannes.schindelin@gmx.de>
References: <c9b1313d5d8a690aae9788402ec5190a1f18ce75.1750679728.git.johannes.schindelin@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1750684749;
 bh=ssGLP29UBtaZ1PeUORha90LIuX9Uu6kRV3QVzlJXZY8=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=Ls5FNA5BYXUP5VbXm1rU4MfM3faP4VJsKTbwpx30nWClrx7SjE6oL5IrN5IgX30t4ev9+AFt
 lv+fTyuEML8yTjD44s8h+9YkD0Ww1siIsGtrQ08cLxcAz0uz1sR56qLJsYxpoE/kgIZuRZ0NQT
 Ohz0/y9XskB2xky3lMa4V1VMD4+B67SBFgWWRsTEJ+qzibNoZ9ZAQLGwpiYZC+Db4wCSHwgVFC
 fLknTra/A6M6/ltsMnj+d4XOi098yNkPfMHII8yZg6iYWHCyvNyA7XzZhRFWgUyMP2864RBZwp
 FZHAWV1DpaSXNhEHXCvr+V9Jc/p8EpkfFbN2/nFOULyTA3AA==
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 23 Jun 2025 14:09:49 +0200 (CEST)
Johannes Schindelin wrote:
> The recent changes in Cygwin's pipe logic are a gift that keeps on
> giving.
> 
> The recurring pattern is that bugs are fixed, but with many of these bug
> fixes, new bugs are produced, and we are stuck in this seemingly endless
> tunnel of fixing bugs caused by bug fixes.
> 
> In cbfaeba4f7 (Cygwin: pipe: Fix incorrect write length in raw_write(),
> 2024-11-06), for example, a segmentation fault was fixed. Which is good!
> However, a bug was introduced, where e.g. Git for Windows' `git clone`
> via SSH frequently hangs indefinitely for large-ish repositories, see
> https://github.com/git-for-windows/git/issues/5688.
> 
> That commit removed logic whereby in non-blocking mode, not only the
> chunk size, but also the overall count of bytes to write (`len`) was
> clamped to whatever is indicated as the `WriteQuotaAvailable`. Now only
> `chunk` is clamped to that, but `len` is left at its original number.
> However, the following `while` loop expects `len - chunk` (which is
> assigned to `len1`) not to be positive in non-blocking mode.
> 
> Let's reinstate that clamping logic and implicitly fix this SSH hang.
> 
> Fixes: cbfaeba4f7 (Cygwin: pipe: Fix incorrect write length in raw_write(), 2024-11-06)
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> Published-As: https://github.com/dscho/msys2-runtime/releases/tag/fix-ssh-hangs-reloaded-v1
> Fetch-It-Via: git fetch https://github.com/dscho/msys2-runtime fix-ssh-hangs-reloaded-v1
> 
> 	This commit message will like any love you can give it. For
> 	example, I do not _quite_ understand why the `while` loop skips
> 	large chunks of code unless `len1 > 0`, and what the exact idea
> 	was behind having that `while` loop even for non-blocking mode.
> 	Could anyone help me understand that `raw_write()` method? Is
> 	there any good reason why the non-blocking mode runs into a
> 	`while` loop? Is it supposed to be run only once in non-blocking
> 	mode, is _that_ the big secret that allows the code to be shared
> 	between blocking and non-blocking mode? If so, wouldn't it be much
> 	better to refactor out that logic and then have non-blocking mode
> 	take a short-cut, for clarity's sake and peace of readers' mind?
> 
> 	What I am quite confident is that this works around the problems.
> 
> 	I would have put more work into the commit message, if it weren't
> 	for two counter-acting points:
> 
> 	1. This seems to be a pretty bad regression by which many Git for
> 	   Windows users are affected. So I do feel quite the pressure to
> 	   get a fix out to those users.
> 
> 	2. Despite my pleas, the commit messages in the pipe-related
> 	   changes keep having too many gaps, still leave way too much
> 	   unclear for me to make any sense of them, and I have to admit
> 	   that I do not want to be the only person in that space to put
> 	   in a large effort to write stellar commit messages. Therefore I
> 	   left this here commit message in a state I consider "good
> 	   enough", even if I am more than willing to improve it should
> 	   someone enlighten me as to the questions I raised above.
> 
>  winsup/cygwin/fhandler/pipe.cc | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
> index e35d523bbc..13af7f2ae1 100644
> --- a/winsup/cygwin/fhandler/pipe.cc
> +++ b/winsup/cygwin/fhandler/pipe.cc
> @@ -542,6 +542,8 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
>  
>    if (len <= (size_t) avail)
>      chunk = len;
> +  else if (is_nonblocking ())
> +    chunk = len = avail;
>    else
>      chunk = avail;
>  
> 
> base-commit: 1186791e9f404644832023b8fa801227c2995ab7
> -- 
> 2.50.0.windows.1

Thanks for the patch.

This indeed fixes the issue. However, I have another idea to fix the issue.
Please see:
https://github.com/git-for-windows/git/issues/5682#issuecomment-2996285140

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
