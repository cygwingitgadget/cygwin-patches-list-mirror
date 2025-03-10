Return-Path: <SRS0=WQBm=V5=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:29])
	by sourceware.org (Postfix) with ESMTPS id A8D423858D20
	for <cygwin-patches@cygwin.com>; Mon, 10 Mar 2025 14:00:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A8D423858D20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A8D423858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:29
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1741615246; cv=none;
	b=FPNlFmnXDhRheqkkysV5nvmdXtLEMkSKWx1UIy9Q1oleQl1v3LYekDxZtVzRbwMkai+fLp99+BzntZVmTuhkbIxucjWG899SpJpchZFdtUoN7urflTbD2QINgSY7VpIPUqbPi5KAMghes6qlyjNrjmk5i6tVGsfYRsiONCIMy6U=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1741615246; c=relaxed/simple;
	bh=stAG8i8hoRkhYgeTYrLSy/PbHF1u9Nsq/SbYIi+WbI8=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=sCCqkRgVEavffOIdRv4EFcU6tP1HuWoaqVz1ja39fU/xTayvaQiknr3FEYSaob74JjLqVwgsF+7l0gBt/VcdqGO8VYWgsA9/Ms+F3s2fZUIqig834GPmdP/E4Uo4qpqZmRQIri2pSmXpcLs48rBtOfRaJoevN9KHP6wYUL+JuBc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A8D423858D20
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=UrlIrfWp
Received: from HP-Z230 by mta-snd-w09.mail.nifty.com with ESMTP
          id <20250310140043528.TAXW.98325.HP-Z230@nifty.com>;
          Mon, 10 Mar 2025 23:00:43 +0900
Date: Mon, 10 Mar 2025 23:00:43 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Yuyi Wang <Strawberry_Str@hotmail.com>
Subject: Re: [PATCH] Cygwin: signal: sigaction should ignore SIGKILL &
 SIGSTOP sliently
Message-Id: <20250310230043.90c4b18b05c7bf476c72106f@nifty.ne.jp>
In-Reply-To: <TYCPR01MB10926EE2486839280DCC3742CF8D42@TYCPR01MB10926.jpnprd01.prod.outlook.com>
References: <TYCPR01MB10926EE2486839280DCC3742CF8D42@TYCPR01MB10926.jpnprd01.prod.outlook.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1741615243;
 bh=+RaToOFFiYGT2iIX23Q8wuOUpKYp5clHzVfuwEN/U30=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=UrlIrfWp/MlSt3TYWWag//SaNwcmcDMSWVtJhijuWxrfRItVzknprlpVzIa2WwGZjrZGlF+H
 llCG0U+A1cQye8yeD5gPCNZSorPKx556gPwnXEP9yQynHux5YrHXvzHZuCYYEFwjspA7WWoLNQ
 2mx8VzTedLd/C0vK4rK2JQFGD/X9Ate1LmyUo0+/nMNRxJ4tm/Ei0ep4hl/PC2Tbwya6VRV6cD
 gEBbqVT2K4EyBTygdbj9iBzq32uk8rNz92fH0Oj/f9XKQgDSFmVux+QyFwPWvrU5goBfrqIwtD
 7Y1Gr1pz/SKNHCWa4F8iQhET6rb/RErUAphruBeCWKnUlQeg==
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,BODY_8BITS,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Yuyi,

On Sat, 8 Mar 2025 16:43:05 +0800
Yuyi Wang wrote:
> 
> The current behavior returns EINVAL on these 2 signals, which is
> different from the requirement of POSIX. In addition, it makes
> posix_spawn fail to set POSIX_SPAWN_SETSIGDEF. In
> newlib/libc/posix/posix_spawn.c:200, it tries to set for all signals
> including SIGKILL & SIGSTOP, and sigaction should not fail.
> ---
>   winsup/cygwin/signal.cc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/signal.cc b/winsup/cygwin/signal.cc
> index f8ba67e75..a964c3b29 100644
> --- a/winsup/cygwin/signal.cc
> +++ b/winsup/cygwin/signal.cc
> @@ -440,7 +440,7 @@ sigaction_worker (int sig, const struct sigaction 
> *newact,
>                     oa.sa_handler);
>             if (sig == SIGKILL || sig == SIGSTOP)
>           {
> -          set_errno (EINVAL);
> +          res = 0;
>             __leave;
>           }
>             struct sigaction na = *newact;
> -- 
> 2.48.0
> 

Thanks for the patch. However, Corinna and I do not think this is
the right thing. sigaction() returns EINVAL for SIGKILL/SIGSTOP
on Linux as well.

I disccussed with Corinna, and concluded the problem is in posix_spawn()
rather than sigaction(). posix_spawn() must not try to call sigaction()
on SIGKILL/SIGSTOP.

Would you like to create a patch for posix_spawn()? Or shall we do that?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
