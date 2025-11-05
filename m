Return-Path: <SRS0=k0+I=5N=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 00C9A3858D2A
	for <cygwin-patches@cygwin.com>; Wed,  5 Nov 2025 04:58:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 00C9A3858D2A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 00C9A3858D2A
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1762318727; cv=none;
	b=x6kFNVp38P1lXBBVVd9cFxKQgzN3VxkwRqOZ8OdxykMsNQ3hh2AZifIdqVzwBIyFgTnpp56NSIn/6R1O3cmsZg8EWsjODnTxaH5qMJFpVtXFM0GBT124b35umB1ipq5w+7vQWt8oPBXAGqLmbBdZfp1dgrCpKmNaVsDheQZ9omc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1762318727; c=relaxed/simple;
	bh=PZL8Ghp9YOc7eVaPFQaUGz/bnfJx5Z5UhgYU4uNkS4g=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=C0J+fhrW5DlV1JK75r3/6mksVfj28I5V+n4YSQirAfXmcrdOx30g2Qg8Ams4rSuVdjUXsxhB/vGf28Ae5y9ZPxdOOqUrf5piJgt8TL+7pQIl+J/wXujwrr6V0RGD7K6vhTazh5Pg+Cp2Da1+Fzh3n2EJXM7rjSPs40WH9svYviQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 00C9A3858D2A
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Fd8nAsfK
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20251105045843755.DHML.36235.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 5 Nov 2025 13:58:43 +0900
Date: Wed, 5 Nov 2025 13:58:42 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Fixes for dll_init.cc
Message-Id: <20251105135842.e9c501e7cce6ec6603acc124@nifty.ne.jp>
In-Reply-To: <20251028114853.11052-1-takashi.yano@nifty.ne.jp>
References: <20251028114853.11052-1-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1762318723;
 bh=fxIurnrfRtgDhxCCKKZon/goWaUqOx+2kgU7xz9DzJo=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=Fd8nAsfKARroGMqzuD7ayLzPJT5ZulpDPKq4KHtMn2QU+D1M4TFEUEWCNx/etjiW2YW59L6s
 05vMmhMjpQH2gv2R/NNZTtVVrh25vAtTHuPJ7U9STJqUmNTCHbvfsxT+g+Hk6d4Bg/pMPovYPI
 sS8/iad+ODaUx/qk5AHVJkpFvaX2pcImbaH7wtjNCG8atT1Wzin1U83ghta36F10Ecu62eY0j4
 zQ+Aj2Fiog3HyYdcy4ZVhZIK2ZC51mteXqX2vYxN+R57K1SMmTwd06qHn9jVrewUMRNwJaq2Sw
 wS7guE3KNjlTyNSceVzv/7RTWTQ4mly+/qjRskzsa/5uspcg==
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 28 Oct 2025 20:48:40 +0900
Takashi Yano wrote:
> Takashi Yano (2):
>   Cygwin: dll_init: Call __cxa_finalize() for DLL_LOAD even in
>     exit_state
>   Cygwin: dll_init: Don't call dll::init() twice for DLL_LOAD.
> 
>  winsup/cygwin/dll_init.cc | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> -- 
> 2.51.0
> 

Could anyone please review if these patches make sense?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
