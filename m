Return-Path: <SRS0=qDft=7V=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e08.mail.nifty.com (mta-snd-e08.mail.nifty.com [106.153.226.40])
	by sourceware.org (Postfix) with ESMTPS id C84CE4BA2E2D
	for <cygwin-patches@cygwin.com>; Fri, 16 Jan 2026 11:09:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C84CE4BA2E2D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C84CE4BA2E2D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1768561754; cv=none;
	b=C0jHCI0iuVM6g32al2OuXaOw6NMBjOqtJUc2zQ+ctGvXC8NFGew3ZdxJOskRqnyyGRn6fjSfzVwL6pMub7AV2apK4ZL8GP1LcDHwGuhK6gkcn5ZgbPBtI8cGsBhmB/kqIIZjm/R7+oY66wO+YY7CRz8/ONS4oJAaGiUcmXpMlLY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1768561754; c=relaxed/simple;
	bh=+/GLcUz/XpgNPnwzMHMWeoUK2elt/R+TLwrBhJSvRLM=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=meOble1bZbO7V3OnHoxMnI6dUPpFQR7xvIk58iYSP2vvipAM+rMnqlREdoRHZLxqjIUwdpcvglSgI0gCOwCKujJhmpT8uDI+laBKZvv/xaEVjQP7lFnm6K/O9nVhHoSV8p+KL9HSNDAtuSdf0TcJVkDZ34U+llVJKWeO0BiWOwY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C84CE4BA2E2D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=IJvhyahD
Received: from HP-Z230 by mta-snd-e08.mail.nifty.com with ESMTP
          id <20260116110912066.JYKN.23755.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 16 Jan 2026 20:09:12 +0900
Date: Fri, 16 Jan 2026 20:09:09 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: c32rtomb: add missing check for invalid UNICODE
 character
Message-Id: <20260116200909.ebab69522f9e11445584e647@nifty.ne.jp>
In-Reply-To: <20260114223106.828985-1-corinna-cygwin@cygwin.com>
References: <20260114223106.828985-1-corinna-cygwin@cygwin.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1768561752;
 bh=pY/kbPVnCpeGm+0Lb4L2QHp3vK9urjlsX6thv/uTQSE=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=IJvhyahDYbPBUufJEflx0O4rmxLQfiiW+PRD7aKOMixxeUD3Yvlu7St7srPvx5/CmUEsmHXn
 Dwhmg2hEAauC3GqXlwE6PnM0jC59c/PafXEnvSLeVbpvmMVyb6R3rtr1Mh71worg9bXuaBhhxF
 t7UkZms54wdaetrXTgZ0hl6YGPscHiDxRsOvHlvQFCKTDmd8H3Xdwp8+ju26SQsb7UggN9QlDw
 X8VxPQQ+XryOviO7niuhbNPVP2Zf+TIEyZcgMYRTyU2BDMOaz5JwFUlVPoU3CjTmexFAEm0abT
 6WTc1Y/4SQ3vUDXuWy3oMKdL4n/SL0Uvy2M093lxWbs0d2VQ==
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 14 Jan 2026 23:31:06 +0100
Corinna Vinschen wrote:
> From: Corinna Vinschen <corinna@vinschen.de>
> 
> c32rtomb neglects to check the input character for being outside
> the valid UNICODE planes.  It happily converts the invalid character
> into a valid (but wrong) surrogate pair and carries on.
> 
> Add a check so characters beyond 0x10ffff are not converted anymore.
> Return -1 with errno set to EILSEQ instead.
> 
> Fixes: 4f258c55e87f ("Cygwin: Add ISO C11 functions c16rtomb, c32rtomb, mbrtoc16, mbrtoc32.")
> Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
> ---
>  winsup/cygwin/release/3.6.7 | 5 +++++
>  winsup/cygwin/strfuncs.cc   | 7 +++++++
>  2 files changed, 12 insertions(+)
>  create mode 100644 winsup/cygwin/release/3.6.7
> 
> diff --git a/winsup/cygwin/release/3.6.7 b/winsup/cygwin/release/3.6.7
> new file mode 100644
> index 000000000000..defe55ffe75e
> --- /dev/null
> +++ b/winsup/cygwin/release/3.6.7
> @@ -0,0 +1,5 @@
> +Fixes:
> +------
> +
> +- Guard c32rtomb against invalid input characters.
> +  Addresses a testsuite error in current gawk git master.
> diff --git a/winsup/cygwin/strfuncs.cc b/winsup/cygwin/strfuncs.cc
> index eb6576051d90..0cf41cefc8a2 100644
> --- a/winsup/cygwin/strfuncs.cc
> +++ b/winsup/cygwin/strfuncs.cc
> @@ -146,6 +146,13 @@ c32rtomb (char *s, char32_t wc, mbstate_t *ps)
>      if (wc <= 0xffff || !s)
>        return wcrtomb (s, (wchar_t) wc, ps);
>  
> +    /* Check for character outside valid UNICODE planes */
> +    if (wc > 0x10ffff)
> +      {
> +	_REENT_ERRNO(_REENT) = EILSEQ;
> +	return (size_t)(-1);
> +      }
> +
>      wchar_t wc_arr[2];
>      const wchar_t *wcp = wc_arr;
>  
> -- 
> 2.52.0

LGTM. What does this change address for?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
