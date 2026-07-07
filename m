Return-Path: <SRS0=jPxW=FB=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e10.mail.nifty.com (mta-snd-e10.mail.nifty.com [106.153.226.42])
	by sourceware.org (Postfix) with ESMTPS id 6E8614BA2E0E
	for <cygwin-patches@cygwin.com>; Tue,  7 Jul 2026 00:45:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6E8614BA2E0E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6E8614BA2E0E
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783385155; cv=none;
	b=N/EckJLcHAILCCXhkh2aRupBGUdu0CS4UXn4tCcO0nUIEJ+BvHtcpKkTffnR4/DWxr0ZF7N3eJhjhh3CSD58LpNck+SNXbf4QwtTO1ibRUcITxn90zk50opQzXMSx/crIArwxgHul9HIh5cFFuJg9pVwSGQOcSL9RpLWowudT98=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783385155; c=relaxed/simple;
	bh=0Oma514RJun6Rz0H9JJ0MtdKvo7jW4LRtwEMQZcgqDM=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=yD/s+E5orQJQbkHD8PCDdupELjE4c/tB2tsHmL5Ahh7Hur1dOztjoTmrC1tmcKumsUhtKl1nNmKHwVOR17rVSxC9pFJ/NQ5+4iyWMxN1E4rRhNbpP5obxHdYveRvD+B9mlwj6dHDhpfMMZ03rVmkcXEf7tcQV1M82bTRqymro4k=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Rb4rMXlG
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6E8614BA2E0E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Rb4rMXlG
Received: from HP-Z230 by mta-snd-e10.mail.nifty.com with ESMTP
          id <20260707004552559.PHDR.3198.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 7 Jul 2026 09:45:52 +0900
Date: Tue, 7 Jul 2026 09:45:51 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Fix error return for madvise()
Message-Id: <20260707094551.c89e6c61a79c534f6c385d5a@nifty.ne.jp>
In-Reply-To: <20260706234758.89659-1-mark@maxrnd.com>
References: <20260706234758.89659-1-mark@maxrnd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1783385152;
 bh=E3YsVqm5OxBJOAJhIsTuwntmqOudqq6rzzn5Ea587rw=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=Rb4rMXlGdZN/PvVwOIjLb4HZJnE1PYNAh1UYgpRX3nPcUuDOa9Bq4dZF5+i2VuV0xAU0Nz49
 oF3sBZsEDF5ug1MMMy5cpCevA9cADK7pEWCZd5AA/Aov5nKTkoyRijQCdnINtb0Bw8q2pCl9pJ
 LkVql3uLiIsAFj/cEoTTSABIMOygOJKtY0keC+PhbBUK1LWCr8kDURMZ3tCMpAPZAJVGSkkrxY
 1yAJlH5ImrEZDzGSjDUs/yyz3Lw9ilwqcTADgo9jp9JeItl8KpwQb3I6tRR5J7ID59dw86XJTG
 /O2ah9ST33WwWAxPGf+izauhOUdg/LdZhxS5xgWiz6/QdwAQ==
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

On Mon,  6 Jul 2026 16:47:43 -0700
Mark Geisert wrote:
> Currently madvise() and posix_madvise() are wired together as one
> function: the latter.  But their error returns should be different.
> Make madvise a first-class export in cygwin.din; code a new madvise()
> that calls posix_madvise() and massages any error return.
> 
> Reported-by: Christian Franke <Christian.Franke@t-online.de>
> Addresses: https://cygwin.com/pipermail/cygwin/2026-July/259872.html
> Signed-off-by: Mark Geisert <mark@maxrnd.com>
> Fixes: 61522196c715 (* Merge in cygwin-64bit-branch.)
> 
> ---
>  winsup/cygwin/cygwin.din               |  2 +-
>  winsup/cygwin/include/cygwin/version.h |  3 ++-
>  winsup/cygwin/mm/mmap.cc               | 12 ++++++++++++
>  3 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/cygwin.din b/winsup/cygwin/cygwin.din
> index 2e53bc819..937eacdaf 100644
> --- a/winsup/cygwin/cygwin.din
> +++ b/winsup/cygwin/cygwin.din
> @@ -951,7 +951,7 @@ lseek SIGFE
>  lsetxattr SIGFE
>  lstat SIGFE
>  lutimes SIGFE
> -madvise = posix_madvise SIGFE
> +madvise SIGFE
>  makecontext NOSIGFE
>  mallinfo SIGFE
>  malloc SIGFE
> diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
> index 71ac5282b..fc838e23e 100644
> --- a/winsup/cygwin/include/cygwin/version.h
> +++ b/winsup/cygwin/include/cygwin/version.h
> @@ -502,12 +502,13 @@ details. */
>    360: Add RLIMIT_NPROC.
>    361: Export _Fork.
>    362: Export C23 stdbit functions.
> +  363: Export madvise separately from posix_madvise.
>  
>    Note that we forgot to bump the api for ualarm, strtoll, strtoull,
>    sigaltstack, sethostname. */
>  
>  #define CYGWIN_VERSION_API_MAJOR 0
> -#define CYGWIN_VERSION_API_MINOR 362
> +#define CYGWIN_VERSION_API_MINOR 363
>  
>  /* There is also a compatibity version number associated with the shared memory
>     regions.  It is incremented when incompatible changes are made to the shared

I don't think we should change CYGWIN_VERSION_API_MINOR value
because the API itself is not changed. This patch fixes a bug
in madvice() implementation.

> diff --git a/winsup/cygwin/mm/mmap.cc b/winsup/cygwin/mm/mmap.cc
> index 1416e4ddc..93db9e474 100644
> --- a/winsup/cygwin/mm/mmap.cc
> +++ b/winsup/cygwin/mm/mmap.cc
> @@ -1422,6 +1422,18 @@ munlock (const void *addr, size_t len)
>    return ret;
>  }
>  
> +extern "C" int
> +madvise (void *addr, size_t len, int advice)
> +{
> +  int ret = posix_madvise (addr, len, advice);
> +  if (ret > 0)
> +    {
> +      set_errno (ret);
> +      ret = -1;
> +    }
> +  return ret;
> +}
> +
>  extern "C" int
>  posix_madvise (void *addr, size_t len, int advice)
>  {
> -- 
> 2.51.0
> 

Patch itself LGTM. Thanks!

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
