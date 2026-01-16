Return-Path: <SRS0=qDft=7V=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e04.mail.nifty.com (mta-snd-e04.mail.nifty.com [106.153.226.36])
	by sourceware.org (Postfix) with ESMTPS id 0D0A34BA2E1D
	for <cygwin-patches@cygwin.com>; Fri, 16 Jan 2026 11:09:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0D0A34BA2E1D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0D0A34BA2E1D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1768561798; cv=none;
	b=BrgnBMqLAtGCUF3eIxQRo8joOFYqGSJ60LVHfZAlK3+hTjvRqjANXiGRGbQFKnyY1RGNpLFn0zFNkS9TU76c/IaKjVCA7dTmua9xcIjW6GAW/xgnAbf4MJFQGYBvpMN12OjdK0BrSc8qiEKmLecFQpkT2DoKRLfMeSlb6NijbOo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1768561798; c=relaxed/simple;
	bh=GY1q9+k7LC3IhKicBK1RW4LZhyKHbbJR4hAZwyx8VZs=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=uf2lWSZ1ZHMLqBsaFSIfz6gQZzdPPZ30aSL4IrxoH57x8Uxhc7r76fyssKqYDTzze08uIeIBpCGy+uTWRyPqToqauja9bkN6c85IoRjWpHn7s7+ehWkla5uSNrxemhKBnQMaY0wvxtRdgh1rRkkHP0CMUljPlzBLPAzrJMtjt78=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0D0A34BA2E1D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Kn1yuMRV
Received: from HP-Z230 by mta-snd-e04.mail.nifty.com with ESMTP
          id <20260116110956152.MZHG.90539.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 16 Jan 2026 20:09:56 +0900
Date: Fri, 16 Jan 2026 20:09:53 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: internal_getlogin: always call
 internal_getgroups
Message-Id: <20260116200953.821639ca3c0a48fc63880c03@nifty.ne.jp>
In-Reply-To: <20260116110153.1021016-1-corinna-cygwin@cygwin.com>
References: <20260116110153.1021016-1-corinna-cygwin@cygwin.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1768561796;
 bh=OwyNQzwQ4VqC+MWdohVeOMoCrijBLlZjIj6SHi2yJCQ=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=Kn1yuMRVKeQM0cl8cLNSOUt7IcxWIMFcjwxJV3tmh5Es78UcsTPAi5g+U88ydMPwJVB0bE/U
 ZahFrEkURExlH4TbIKBSdZ9T5wgeBfgC368w3nEeTc0KLYFPHIbGUE77ZeIox17Dbcn8NM4JjC
 /BvT6wWJArobxz8AK9qa/K4LsPRs4yAg0LB44y0TyrneemsKNRqKcCHzAEIrO99wv/V5DBSa6I
 7SlrECLWLpW1moSuYuoPOyV1+hZ4cNrh5v/zjcNDMpuBQ3p4OafAaId/inD4T/InDIjE4jsFFO
 jMhc7fNANAAUjToHJX1oTluFhx0GKeKv4mW4q96N1zv/0dvA==
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 16 Jan 2026 12:01:53 +0100
Corinna Vinschen wrote:
> From: Corinna Vinschen <corinna@vinschen.de>
> 
> Commit 29b7313d2225 ("* cygheap.h (enum cygheap_pwdgrp::cache_t):
> Remove.") changed an initial conditional to skip calling
> internal_getgroups() if we're running with cygserver account caching
> in place.  This breaks changing the primary group.
> 
> Unfortunately the commit message doesn't explain why the change was
> made.
> 
> Just calling internal_getgroups() all the time fixes this behaviour.
> 
> Fixes: 29b7313d2225 ("* cygheap.h (enum cygheap_pwdgrp::cache_t): Remove.")
> Addresses: https://cygwin.com/pipermail/cygwin/2026-January/259250.html
> Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
> ---
>  winsup/cygwin/release/3.6.7 | 4 ++++
>  winsup/cygwin/uinfo.cc      | 3 +--
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/release/3.6.7 b/winsup/cygwin/release/3.6.7
> index defe55ffe75e..050f6008084e 100644
> --- a/winsup/cygwin/release/3.6.7
> +++ b/winsup/cygwin/release/3.6.7
> @@ -3,3 +3,7 @@ Fixes:
>  
>  - Guard c32rtomb against invalid input characters.
>    Addresses a testsuite error in current gawk git master.
> +
> +- Allow changing primary group even when running with cygserver account
> +  caching.
> +  Addresses: https://cygwin.com/pipermail/cygwin/2026-January/259250.html
> diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
> index 1eb52f14578c..73e61cbffc82 100644
> --- a/winsup/cygwin/uinfo.cc
> +++ b/winsup/cygwin/uinfo.cc
> @@ -153,8 +153,7 @@ internal_getlogin (cygheap_user &user)
>       and the primary group in the token. */
>    pwd = internal_getpwsid (user.sid (), &cldap);
>    pgrp = internal_getgrsid (user.groups.pgsid, &cldap);
> -  if (!cygheap->pg.nss_cygserver_caching ())
> -    internal_getgroups (0, NULL, &cldap);
> +  internal_getgroups (0, NULL, &cldap);
>    if (!pwd)
>      debug_printf ("user not found in passwd DB");
>    else
> -- 
> 2.52.0

LGTM.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
