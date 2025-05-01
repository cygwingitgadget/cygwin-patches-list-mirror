Return-Path: <SRS0=Tnnj=XR=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w04.mail.nifty.com (mta-snd-w04.mail.nifty.com [106.153.227.36])
	by sourceware.org (Postfix) with ESMTPS id B934F385829B
	for <cygwin-patches@cygwin.com>; Thu,  1 May 2025 13:48:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B934F385829B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B934F385829B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746107282; cv=none;
	b=WyIw/hDZ8HqGjamiGlBYDYE3nxAdjRgNhZQomVlfcZkjYCiNuDLrpxhzfVP83jIu4/5BALOpREGCdhWzmGoVbR3oPxFHlb9nQrCycLgQk0iDVY4lawvRmNzpIrttCVwF8TzsAhTFAy3hwkOUTLb639dvE87yUxn3zk0pZxZzuHk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746107282; c=relaxed/simple;
	bh=hvRkDeaUqMEv0Se6tvyrCLrFmR3xC30xaL1ZQB1lORs=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=Ye2mYg8p2WDNeTwo7+K0PlBWHIvBZKwieajF4C8+IiKOzWoGjD6NgqFEWNB1heGjouePwvJhxRnvKo+PMp8txOgjlqvQreZEKiPvOkkxTI1IF/9/k43rCvDTL74Y7HlC17ZUtLip1WbCVPlhrIoJYsrjvXo6aJs49/jrP8RNFbM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B934F385829B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=qshqJ2Za
Received: from HP-Z230 by mta-snd-w04.mail.nifty.com with ESMTP
          id <20250501134758531.PWOS.52630.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 1 May 2025 22:47:58 +0900
Date: Thu, 1 May 2025 22:47:57 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: dladdr: use proper max size of dli_fname.
Message-Id: <20250501224757.4c9d689a3b2be9028f5e865f@nifty.ne.jp>
In-Reply-To: <b4ed3ebb-2fb3-4d95-1069-017bb381ad81@jdrake.com>
References: <b4ed3ebb-2fb3-4d95-1069-017bb381ad81@jdrake.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1746107278;
 bh=eXcYOM1zWCd41sq+XRND3HrEtLz5EUSaCW+qYjllwwA=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=qshqJ2ZaZVjm9xxQ0dr5l3MZwdxIPh5FaMUtje8PrdG/HITsWY59p70/x0EwVkJC/7sKBwNb
 kl7JAfRmP1PCP7ZzBghnlvU+pEW3IGlGCVnUWVJiN5hkOf/IYb+YMnoNzdX6DiIgQuL8Jd6Cvb
 IJVKa3hp7i9ywAhd7HMSZ8toWbOijsyMd7WAIE+slXt3jk0+FXFYYlRzCjksxu0ndkgulyArSo
 nVWt9JCio1+JYygdAoveh29aYg6KzPxSSBNdQQhZIjhFcQ2qmR1a8bd2oVCnDWkQD32ddOmP5u
 o0EUxXpscJ1vNyCB7fWIG8Re3GvWLLhG32Dl6iy/vDtMW5Ew==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 30 Apr 2025 12:45:56 -0700 (PDT)
Jeremy Drake wrote:
> The DL_info::dli_fname member is actually PATH_MAX bytes, so specify
> that (larger) size to cygwin_conv_path rather than MAX_PATH.
> 
> Also, use a tmp_pathbuf for the GetModuleFileNameW buffer, so that any
> buffer size limitation will definitely be due to the size of dli_fname,
> and add a static_assert of the size of dli_fname so we can be sure we're
> using the right size constant here.
> 
> Fixes: c8432a01c840 ("Implement dladdr() (partially)")
> Addresses: https://github.com/rust-lang/backtrace-rs/pull/704#issuecomment-2833782574
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> ---
>  winsup/cygwin/dlfcn.cc | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/winsup/cygwin/dlfcn.cc b/winsup/cygwin/dlfcn.cc
> index 10bd0ac1f4..9b6bb55b34 100644
> --- a/winsup/cygwin/dlfcn.cc
> +++ b/winsup/cygwin/dlfcn.cc
> @@ -421,14 +421,16 @@ dladdr (const void *addr, Dl_info *info)
>    /* Get the module filename.  This pathname may be in short-, long- or //?/
>       format, depending on how it was specified when loaded, but we assume this
>       is always an absolute pathname. */
> -  WCHAR fname[MAX_PATH];
> -  DWORD length = GetModuleFileNameW (hModule, fname, MAX_PATH);
> -  if ((length == 0) || (length == MAX_PATH))
> +  tmp_pathbuf tp;
> +  PWCHAR fname = tp.w_get ();
> +  DWORD length = GetModuleFileNameW (hModule, fname, NT_MAX_PATH);
> +  if ((length == 0) || (length == NT_MAX_PATH))
>      return 0;
> 
>    /* Convert to a cygwin pathname */
> +  static_assert (sizeof (info->dli_fname) == PATH_MAX);
>    ssize_t conv = cygwin_conv_path (CCP_WIN_W_TO_POSIX | CCP_ABSOLUTE, fname,
> -				   info->dli_fname, MAX_PATH);
> +				   info->dli_fname, PATH_MAX);
>    if (conv)
>      return 0;
> 
> -- 
> 2.49.0.windows.1
> 

Thanks for the patch. LGTM. Pushed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
