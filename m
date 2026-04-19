Return-Path: <SRS0=mhjT=CS=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 272A44BA2E27
	for <cygwin-patches@cygwin.com>; Sun, 19 Apr 2026 01:44:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 272A44BA2E27
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 272A44BA2E27
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1776563063; cv=none;
	b=iydD1h0JlBadjoR53o1P+Uge2z9jX+syQSzRQGklt+xXKEJltBMZ9PQb+RITK/0vE0hL3spOyTUbYsAjFEB1pYPxbMMQu/PN6Ir0EukiuMvr3vpiqP4TtQoTNY+fqhv8mFOTcI1oNgaYj/qwlypSR6eMSLjDhuheSWMjXNRMiBw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1776563063; c=relaxed/simple;
	bh=VV5r0Y9R8Us3eE+XRRjjMZO8MhtmCK1hWv95bZkag54=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=uZFtWbt+i7w9JhnbiT8PyWH4lb37qvTrwh5yxC6+k+JsB4E4ggPNhGfqAZ4s83xz9UeolQcJ88OsJ/t+u6wpDScddtf5fCEedikkVReKf6Ozavcjo8ZkAs7oQQKVX0sgFqym//396unXwQlEPoLqriKw5ye9kV3Tee+6OwiGn2E=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 272A44BA2E27
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=p+vIvURK
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260419014421121.UNKS.36235.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 19 Apr 2026 10:44:21 +0900
Date: Sun, 19 Apr 2026 10:44:19 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: select: Set errno when peek() returns -1
Message-Id: <20260419104419.c881d5b1582922341c624cb2@nifty.ne.jp>
In-Reply-To: <20260417194531.993-1-takashi.yano@nifty.ne.jp>
References: <20260417194531.993-1-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1776563061;
 bh=QTraEP7zFGB5+uXVq3jtGcj91xut9Sf0f6VTW30pscY=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=p+vIvURKRzztv0KOAn68r39/sVGmhdzfWq90K4MIjPFx0QbtGLnaYCeOlEt2Bx6sbXKT9Yox
 NJt5+QanlXGAqAu0VSTaQldJWyf8z5LaB4FPgUr13GnfszGAHW6Jcamfac/DZvbE2fJf7kqn3a
 vk6l5gVYclwdw0yryiZerZNE+dX7PZml47UzSUfW2QAW0AMQ0dK7ciwvxIY8M3QP/VtlNhEaM7
 5wLsL9u5VIf19cNgHiYIktz+RdrZmGgqJ3WXfRl0Gb++b49f3xrt/lz5A4XF0zDIifYbZ97D+o
 AgtQHCLPsIljBoYh4GdDRb4ByLJOOR7yb8om8kmgewbfei8Q==
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 18 Apr 2026 04:45:22 +0900
Takashi Yano wrote:
> Currently, poll() sometimes returns -1 with errno == 0 if the fd is
> not opened. This is due to lack of setting errno when peek() fails.
> This patch ensure to set errno to thread_errno if peek() returns
> NULL.

Not NULL, but negative. Sorry.

> 
> Addresses: https://cygwin.com/pipermail/cygwin/2026-April/259602.html
> Fixes: 8382778cdb57 ("Cygwin: console: fix select() behaviour")
> Reported-by: Nahor <nahor.j+cygwin@gmail.com>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/select.cc | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
