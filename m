Return-Path: <SRS0=4rNz=BS=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id D44524BB58B4
	for <cygwin-patches@cygwin.com>; Wed, 18 Mar 2026 13:01:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D44524BB58B4
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D44524BB58B4
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773838879; cv=none;
	b=OslWYg6AYV59t7Lx3LkEMYZ2d3bfB3Lli8saPXnojxmWbFHjYG08M4KbwjWkoR5kRpZjA67AgOSgMNWgzm0mQe4KF5tIPEsgUOo+2hFOMZM9LMznmW3+bSuv12khWqRl3EMCb4Ai/Rf1FjqJMixSfGj4I8NZMloAvU0xPVd2PTQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773838879; c=relaxed/simple;
	bh=h/oofXvM4wsAhV4jjdRnAayh21Qzn2I3ePuwKrCFkJU=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=jCe7QId0g2xBvb7KdLHhc3xmZODgYF0Y28aVD6gUo8seHkQUW3Edh7lJ4KSt7cg6d8ZLE+nZRuPngTObo7P9VgtMgfmQJjKyIqHuUOeC6xYmK70l0wwtCy+cYvMnuy3BZkU8gjKiXwSiiaC4k/JrpgjLP+6xCDVhpR8KFhCM+CE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D44524BB58B4
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=q31N+eg5
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260318130116019.DTQI.36235.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 18 Mar 2026 22:01:16 +0900
Date: Wed, 18 Mar 2026 22:01:14 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/6] Cygwin: pty: Add workaround for handling of
 backspace when pcon enabled
Message-Id: <20260318220114.7ce48e354fdc4d3014b1b991@nifty.ne.jp>
In-Reply-To: <20260318202032.54cf28ea83d863082f1bb153@nifty.ne.jp>
References: <22f45be0-3a22-f9c6-6d91-a7c2484621ef@gmx.de>
	<20260317122433.721-1-takashi.yano@nifty.ne.jp>
	<20260317122433.721-3-takashi.yano@nifty.ne.jp>
	<2f8628d2-b79a-95a6-480d-7508375958d5@gmx.de>
	<20260318202032.54cf28ea83d863082f1bb153@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773838876;
 bh=hQN+wlq30WVRYQZsbf8+t36DC+N+VDOfwKNNfrugHws=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=q31N+eg5/RYOoTnx+wOPeV+kQozUJoUMVAhTYuKt4WfhW4ovFaAOx2fHBrxCLTHfeSIzTw1m
 T8wWxbMrS9yREGTUAqDsqpDIEyO8KJm62Zg8Sfjn+2w7m/SGMkwH0ogjz64QKFzoNt/wA1KNWi
 egMWYuvO6e/Pse60h3hKDDCgf1tBORQP7DLx5q7o6ERMhMKghOyBfhaFn23HTG0XPSlVn/sDKo
 rR3sD6NERIOqrfIvR3tV9Xs6X5ZUV3rc/SG24adFInT7oOWucW5DeBllVt4rkSuLDdS6VWlaIY
 Grk4RnMNRG8etXAfQAdEfWkQTeJ8M5wtLjSXratwEj9/hXJA==
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 18 Mar 2026 20:20:32 +0900
Takashi Yano wrote:
> Hi Johannes,
> 
> On Tue, 17 Mar 2026 16:28:28 +0100 (CET)
> Johannes Schindelin wrote:
> > This cannot be correct, and I am rather convinced that the idea behind the
> > patch (interleaving `WriteFile()` calls to the pipe with sending raw
> > keyboard events via `WriteConsoleInput()` to a _different_ handle) will
> > _never_ be robust enough.
> 
> Then, only the thing we can do till fixing the issue upstream, is
> writing all chars using WriteConsoleInput() instead of WriteFile()...
> 
> What do you think?

On second thought, replacing Ctrl-H with '\x7f' might be enough.
Please see PATCH 2/6 v2.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
