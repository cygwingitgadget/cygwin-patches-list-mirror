Return-Path: <SRS0=uzgK=FC=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout03.t-online.de (mailout03.t-online.de [194.25.134.81])
	by sourceware.org (Postfix) with ESMTPS id C16D24BA543C
	for <cygwin-patches@cygwin.com>; Wed,  8 Jul 2026 14:58:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C16D24BA543C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C16D24BA543C
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=194.25.134.81
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783522687; cv=none;
	b=jR+R82p7ZCKfF3nEjKx/RbXp0SXpZphN1ku0WF02Mvdp5Xeq6nap8ipts+iLVrFa+YUTYC++MuFNcfUfQ3cwhXr/6P0cojU3kMdCtyZ7ksw/mT9Kjh4FeyjSBzfHFAblK1+LKnRRgYz4HqgvBCLGHRvv94atWmn4WZziTjsEs08=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783522687; c=relaxed/simple;
	bh=4AawkRTBGWPQ0iH0tSm/ucOhJ0tzCAnyidqzBzBbrhA=;
	h=Subject:To:From:Message-ID:Date:MIME-Version:DKIM-Signature; b=BEyv/xxYWjwq3JRyCh84aEnBW5VnaDWScmwuPAcNf4DaWsZTmaLvqsOGFaOufSTejBTQUgQoerEemHbMQroScmdUu4BfDyypPcDHZlNc+spyj6PAwmGlNCuRndIOlhJtuPPTtNuWWOtL7BsSSRtmvzP9fA4mMN6aVVzcM3dJlZc=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=t-online.de header.i=Christian.Franke@t-online.de header.a=rsa-sha256 header.s=20260216 header.b=RNQjAD3X
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C16D24BA543C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=t-online.de header.i=Christian.Franke@t-online.de header.a=rsa-sha256 header.s=20260216 header.b=RNQjAD3X
Received: from fwd81.aul.t-online.de (fwd81.aul.t-online.de [10.223.144.107])
	by mailout03.t-online.de (Postfix) with SMTP id 1D47BE7D6
	for <cygwin-patches@cygwin.com>; Wed,  8 Jul 2026 16:58:03 +0200 (CEST)
Received: from [192.168.2.103] ([79.230.161.37]) by fwd81.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1whTis-1UWxM00; Wed, 8 Jul 2026 16:58:02 +0200
Subject: Re: [PATCH v2] Cygwin: Fix error return for madvise()
To: cygwin-patches@cygwin.com, cygwin-patches@cygwin.com
References: <https://cygwin.com/pipermail/cygwin-patches/2026q3/015163.html>
 <20260708080349.570-1-mark@maxrnd.com>
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <dbe2155d-198f-76a8-13ae-924001cdf1b1@t-online.de>
Date: Wed, 8 Jul 2026 16:58:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.23
MIME-Version: 1.0
In-Reply-To: <20260708080349.570-1-mark@maxrnd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1783522682-E6FFAFD4-107BB205/0/0 CLEAN NORMAL
X-TOI-MSGID: dad6da8e-2a51-42b3-ae5e-2b2fdd3112fe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-online.de;
	s=20260216; t=1783522682; i=Christian.Franke@t-online.de;
	bh=8DKKujuXVJe7KGX4MaQ75U9kBMMx52SPdZNEdAbMV9g=;
	h=Subject:To:References:From:Date:In-Reply-To;
	b=RNQjAD3XYsQeno9v7UdoXixtsbY1GMQqWz2AwVqnel+yy5Z9HCkN/DNfs1LuOjQvG
	 xPsU7QCzaZXJO/pcbBaBtj0+jV21DS2Qbx/zVUtYsavaS1hZSZkNbjyJFni9HM6UF4
	 lFEQ3HdP946pzjUHUkSHH5jbeyc78AxVJ711BmSiodVIckyY7peyy15K/kb2PWc7z7
	 YqepAItbth94qgg6n7QGIil4auLIuDY1Wzkg5Ufq4OWecrw8RI4ozqAnY66ukDoZzh
	 YK59D4KPZ2fEJc8k2lsI8WNjkS0/39GlWO+AML7EKQd08HJJUnc1hHBohnZQb1Kppx
	 y58NEs/xuLk1g==
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_PBL,SPF_HELO_NONE,SPF_PASS,TONLINE_FAKE_DKIM,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Mark Geisert wrote:
> Currently madvise() and posix_madvise() are wired together as one
> function: the latter.  But their error returns should be different.
> Make madvise a first-class export in cygwin.din.
>
> v2: Create madvise_worker() and have madvise() and posix_madvise()
>      call it, then handling their error returns compliant to POSIX.
>      Add a release note for 3.7.0.

LGTM, thanks!


> ...
> -extern "C" int
> -posix_madvise (void *addr, size_t len, int advice)
> +static int
> +madvise_worker (void *addr, size_t len, int advice)
>   {
>     int ret = 0;
>     /* Check parameters. */
> @@ -1514,6 +1514,26 @@ posix_madvise (void *addr, size_t len, int advice)
>         break;
>       }
>   out:
> +  return ret;
> +}

PS: The 'goto out' could now be replaced by 'return ref'.

-- 
Regards,
Christan

