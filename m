Return-Path: <SRS0=/fae=G7=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:29])
	by sourceware.org (Postfix) with ESMTPS id D5FDA4BA7997
	for <cygwin-patches@cygwin.com>; Mon,  7 Sep 2026 00:17:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D5FDA4BA7997
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D5FDA4BA7997
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:29
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1788740271; cv=none;
	b=r2rBiwkv4z+QiZ1td4OuVO8siAOE7XEZ1qJv9cXy12fUimZEP+/dKyP3RWpjqxyBWhN4mbA1ZRDlhZg8fIsm1tCk7lN56C3i5sK9J12xGKELfohXZJA3xA1mhucvt0E7CUeLKd9vhDHVb6O42SYsS87DrXgGCxp9KRKbJ1QJR1s=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1788740271; c=relaxed/simple;
	bh=zXe8GMMXNjLQNdG6S7QtqgNIGjIl9jncmBn5cenG1M4=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=xwNR2KFvPN9BESLET1mK5Msv5PNg61sszIHpw2JNe9HsNzBU9ZlQIqIz1Pp9DxGag7Xz3IQA0x8jG+MfbE5hnVFHm2bTfxFOJ8BaIfskbLkkXRt9d+fMJ4r43KqwW5TSL2ustNpJjYMPLCFqi/1FnKNNWqovXojcusrfBzaUMDI=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=lMp81F3q
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D5FDA4BA7997
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=lMp81F3q
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20260907001748247.YGDR.60338.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 7 Sep 2026 09:17:48 +0900
Date: Mon, 7 Sep 2026 09:17:47 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: cygcheck: Fix unused-but-set-variable error
Message-Id: <20260907091747.01bd2b482ae88da51ae8caf7@nifty.ne.jp>
In-Reply-To: <20260906234452.1593-1-takashi.yano@nifty.ne.jp>
References: <20260906234452.1593-1-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1788740268;
 bh=fA9Gj8z8NfNjVBzbz6t30/92NYQS6zy/1Li4vy4mw70=;
 h=Date:From:To:Subject:In-Reply-To;
 b=lMp81F3q4+IasLkPoEqJNHhbh54W17gEkFQc9HETLTrjnJXw+o+Kmmh4H1QIJm09k4VhsGTi
 9lhTSk5Hcnps4K0X3/mIBVzTWhbky13b8RNq1DjPsp0TT1Ugqxasoja/nZMwag3QLO8Ix/GTkJ
 n1ZL/VrqsjOiCLiMB8n+nuxCB4PTb5JlertYrHm36kRx8E9OM7hM8N9IETK/ntLtbkX+t1zuwz
 lyegOiZhGJ5rUC4Bp5fQqLMg7k7EzmxKOMnY7OBskjlb/YNTJmQ1XV79gqcIQFQHwVEMCuRw1T
 c0jKC4aJPfaLvfFxdM9dq+ytIVRcGx8puGbuy0cH3aABcd6A==
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon,  7 Sep 2026 08:44:43 +0900
Takashi Yano wrote:
> Fixes: 1fd5e000ace5 ("import winsup-2000-02-17 snapshot");
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/utils/mingw/cygcheck.cc | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/winsup/utils/mingw/cygcheck.cc b/winsup/utils/mingw/cygcheck.cc
> index 89a08e560..934816939 100644
> --- a/winsup/utils/mingw/cygcheck.cc
> +++ b/winsup/utils/mingw/cygcheck.cc
> @@ -1707,7 +1707,6 @@ dump_sysinfo ()
>    else
>      {
>        char sep = strchr (s, ';') ? ';' : ':';
> -      int count_path_items = 0;
>        while (1)
>  	{
>  	  for (e = s; *e && *e != sep; e++);
> @@ -1715,7 +1714,6 @@ dump_sysinfo ()
>  	    printf ("\t%.*s\n", (int) (e - s), s);
>  	  else
>  	    puts ("\t.");
> -	  count_path_items++;
>  	  if (!*e)
>  	    break;
>  	  s = e + 1;
> -- 
> 2.51.0

Sorry, simply cherry-picking 54692d3ad6c0b0b360e13c47f23046788676554c
is enough.

I'd withdrow this patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
