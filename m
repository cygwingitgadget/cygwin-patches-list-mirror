Return-Path: <SRS0=Gzk2=FK=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:27])
	by sourceware.org (Postfix) with ESMTPS id DD7B14BA23F0
	for <cygwin-patches@cygwin.com>; Thu, 16 Jul 2026 07:39:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DD7B14BA23F0
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DD7B14BA23F0
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1784187542; cv=none;
	b=M+hC+yWyoB5slOhZC/eK+ZgVELHDgUqrsSAWEromWfpiIC4vyTHFKpdfFFdXCfOMyMB8yw5NYpXzhUi/yXTPve6kQ2DzJwXzvzxndtEeR/5Wapho4TdTmx1cwR2CNpvzgTK3ubGp8aWGLK7ZxigbuDM4/c765WbfOYUCoJIBkX8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784187542; c=relaxed/simple;
	bh=kxXRpnX34Wjl/ddGi0PZmNR8V9IboYffa6rLlcEE9Dg=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=uyT2MnF04zGlEmRzfcXcH26XGl/Wx5ceAh6wg6kNjOQujQomneTy7S3vRqQBtGDFGCwG9/yX3czXtmgL8VfyqI/bK3bxLKEiB8iXhpHdwmuVoLyVel8oDh/iQPUNZQOGTBcEkqPeu3TaSaYk1DHNQl6ExeplakRUNg9DLryrsSk=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=igrVIOfO
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DD7B14BA23F0
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=igrVIOfO
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260716073859390.ZEVP.18412.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 16 Jul 2026 16:38:59 +0900
Date: Thu, 16 Jul 2026 16:38:58 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Fix undesired mode change at exit of
 non-cygwin apps
Message-Id: <20260716163858.1a39f7332e04f84ca56ac8c3@nifty.ne.jp>
In-Reply-To: <20260716152400.dd5330c9cf1f046044e000eb@nifty.ne.jp>
References: <20260714055956.925-1-takashi.yano@nifty.ne.jp>
	<377e7867-e31c-64b6-038f-76e84046e2e5@gmx.de>
	<20260716152400.dd5330c9cf1f046044e000eb@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1784187539;
 bh=A9rd8qqUAqtjSKdfvIPFZIs0Ljh18Id1sClEsNH+PXQ=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=igrVIOfOAn8BF0aAzxFg420MC73sB05Tu2PJMdQoR4PZAjPgO4aDUD9PmZFQxEIh/4PLFoKi
 sit++689/Pfm65t1HHSEOLWzEdGqD0W2H5Bg/LBRNDZ5bD3v3U9WpJX+S8//RRpptbDcver6Rj
 xGT8dbMlMNveNiW24YdBPXURUJHCuZ44bNocxn7oKOLj4EmoZ6QcP+F1CkeU80jcZ60/VLd+4C
 4Le53Y2ltGKo56lEKXp17hjRzPPy5EdcI5t6acx2TW0yKjH7csqhjQ9KUhTfwetytvapQfMJpe
 9jb7263ysFeU8uHo7Ma657B9cXaPmcQ9SSMVtaYZ8fcr9H5g==
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 16 Jul 2026 15:24:00 +0900
Takashi Yano wrote:
> Hi Johannes,
> 
> Thanks for reviewing the patch thoroughly. I submitted v2 patch.

Please review v4 patch instead.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
