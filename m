Return-Path: <SRS0=yxTJ=63=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id 18C3B4BA2E05
	for <cygwin-patches@cygwin.com>; Sun, 21 Dec 2025 10:20:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 18C3B4BA2E05
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 18C3B4BA2E05
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766312443; cv=none;
	b=V4PgSLz27MxxAtx7atkzbWjtdwjKP/17WV+l2uLL969XMekMWoeKnp93zZqUEiHl0nfcXSaY65tOOb50I+25MF80p2L3QnW40tGpaiyDvLdiXUysMIy16uKeyOPX4i/MfBowGR2pZZNpdFw2z87SbIJTd6fs1iD5DSMj/mT6CN0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766312443; c=relaxed/simple;
	bh=MeyRt/WZ9b7HufJiWJYjZCL8907fnKml6Cws8H2vLLA=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=WxvFtdvILdFtd4Mt12A4BqTS2shZefA+TLorUDzv93ev3Ytc45sKGcJY/JYipUCQZtX2bo7+6sVJtthlDDcF/Gsr1PdMk21i/OzKHtbL3qsSpTh9FzwkggBVYEcRK2xiXjjr3s4d32+f7sHbX+oIso8RDn06RAF1Vdvoprv1MR4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 18C3B4BA2E05
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=IccMrj5P
Received: from HP-Z230 by mta-snd-w09.mail.nifty.com with ESMTP
          id <20251221102040961.BDEY.116672.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 21 Dec 2025 19:20:40 +0900
Date: Sun, 21 Dec 2025 19:20:38 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/4] Cygwin: uinfo: correctly check and override
 primary group
Message-Id: <20251221192038.25aa53bf2575e30a79a8a505@nifty.ne.jp>
In-Reply-To: <20251218112308.1004395-2-corinna-cygwin@cygwin.com>
References: <20251218112308.1004395-1-corinna-cygwin@cygwin.com>
	<20251218112308.1004395-2-corinna-cygwin@cygwin.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1766312441;
 bh=Ro/Rlmye9fIXJMvvgRFx0UAbXuex1DAt1Z1s3hF2jAs=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=IccMrj5PBYpxf0d0gRoZRtfem1/QBFBl1Vyr/wqYVxN2oVgFJuJLSypUKW+1D9Zt3Mri8eLN
 tAJu3GZYCnpR+FI/v0kIe1OiOAHkNr9sjtYklnptOKPZSh67bLcHn5sg5+7Yjx1ZuHQUVt7y79
 A9Xni6vkzm7LcAk2YQK8L6Q20eabvazbXoUsDJo1o4pkK/Fx2FS8I0Yvlz11Sy1p/VWS6b1XoF
 0WhMp9hV9mI0f3rwml9kdSrHr6RR/kJhXCE4HErwxQjyjXgfgTMDNwpgg8ulFPc4WK2099xlbW
 X53CZ4ReQGWeYv+bfElP8rWe1vMfwkQgN3ljyDl8cgLytJWA==
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 18 Dec 2025 12:23:05 +0100
Corinna Vinschen wrote:
> From: Corinna Vinschen <corinna@vinschen.de>
> 
> Commit dc7b67316d01 ("Cygwin: uinfo: prefer token primary group")
> broke the code overriding the primary group in two different ways:
> 
> - It changed the way myself->gid was set before checking its value.
> 
>   Prior to dc7b67316d01, myself->gid was always set to the primary group
>   from the passwd entry (pw_gid).  With the patch, it was set to the
>   primary group from the Windows user token (token_gid) in the first
>   place.
> 
>   The following condition checking if pw_gid is different
>   from token_gid did so, by checking token_gid against myself->gid,
>   rather than against pw_gid.  After dc7b67316d01 this was always
>   false and the code block overriding the primary group in Cygwin and
>   the Windows user token with pw_gid was never called anymore.
> 
>   The solution is obvious: Do not check token_gid against myself->gid,
>   but against the desires primary GID value in pw_gid instead.
> 
> - The code block overriding the primary group simply assumed that
>   myself->gid was already set to pw_gid, but, as outlined above,
>   this was not true anymore after dc7b67316d01.
> 
>   This is a subtil error, because it leads to having the wrong primary
>   GID in `id' output, while the primary group SID in the user token was
>   correctly set.  But as soon as you run this under strace or GDB, the
>   problem disappears, because the second process tree under GDB or
>   strace takes over from the already changed user token.
> 
>   The solution is to override myself->gid with pw_gid once more, after
>   successfully changing the primary GID to pw_gid.
> 
> Fixes: dc7b67316d01 ("Cygwin: uinfo: prefer token primary group")
> Signed-off-by: Corinna Vinschen <corinna@vinschen.de>

Having an Addresses tag might be more helpful for readers of the
commit message.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
