Return-Path: <SRS0=0NVs=7N=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w06.mail.nifty.com (mta-snd-w06.mail.nifty.com [106.153.227.38])
	by sourceware.org (Postfix) with ESMTPS id 739154BA2E04
	for <cygwin-patches@cygwin.com>; Thu,  8 Jan 2026 08:39:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 739154BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 739154BA2E04
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1767861544; cv=none;
	b=JkrmNZpRxr2Khq8VM8HoQZsMgF/mChGjzDJobNF3yjwq0DsPV3xBZ363XBwWM1MkFkD38wMEcph02iJ4EPetVy4FYvAGb2xesRnNd+/Jkv+owuB1EM9AaxErC0qCF0exQb6nYLPaRoK7IBudatQ1MJCHalzeNRp5rFLP6Pb/LgI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1767861544; c=relaxed/simple;
	bh=2nAwr5IENjhiKm/wze4hwELVcg0BSSJQWvRy3hvEJ8g=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=sQ00lWViPE57fgJ2gEifezdUJDI4YyjSE6Oi3+bgS0x45hP2KH5m968RjGjtg9GXnPaWVImc3exz1cfQcs2TTnrTX6SEpgpKHhs/Ml+5HaFJhzzVBEYe6EfV+cOQ3qdzzniEFZd0BqFf9NRPzMuiBWyJTG2+m8RGJ9Dedqj3yR8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 739154BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=kRxtN+gU
Received: from HP-Z230 by mta-snd-w06.mail.nifty.com with ESMTP
          id <20260108083901607.ZSTJ.116286.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 8 Jan 2026 17:39:01 +0900
Date: Thu, 8 Jan 2026 17:38:59 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: flock: Do not lock fdtab in
 create_lock_in_parent()
Message-Id: <20260108173859.99627def511164a896d50cd8@nifty.ne.jp>
In-Reply-To: <20260108173511.d2033aa8a0fe7b4e879af7bf@nifty.ne.jp>
References: <20260108083031.1364-1-takashi.yano@nifty.ne.jp>
	<20260108173511.d2033aa8a0fe7b4e879af7bf@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1767861541;
 bh=5mr7nGSKUMAodkazRFgg15c1LEqIKHwjPy1R7AzOyF4=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=kRxtN+gU1BlWFWsgvebnqwmPCNPxaJ1dqnvWrLaHdOC82ry1ZBunqPHqlfniKk5SjgK1Ycj+
 G0nQVRcKlXRZqxxUipT78hwOUFRIwwhsdWJn9WxkJEtVUYw7SdKWgtynYEmoI4SybYDOVWYnso
 HsGnhmtVRMp4JWh/7IqxxZchs1kngTkk2E9gJNSsSgm3LeDaD/giNZe2CxYpnM/c7jrIQ8V904
 yAHGnl7t5GIBEgrUMCKHT2LFM6cqct3XfS3wbJPsiUorlb9jd2ZQnMjuB6M7Q8WAqBwAEgAjc1
 Lv92wnlYJ0E8Gdvyx/4dbk+tjFtY0FE/TuK92Ldg6IE91XqQ==
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 8 Jan 2026 17:35:11 +0900
Takashi Yano wrote:
> On Thu,  8 Jan 2026 17:30:22 +0900
> Takashi Yano wrote:
> > Addresses: https://cygwin.com/pipermail/cygwin/2025-December/259187.html
> > Fixes: df63bd490a52 ("* cygheap.h (cygheap_fdmanip): New class: simplifies locking and retrieval of fds from cygheap-
> >fdtab.")
> 
> I forgot to change Fixes: tab. Sorry.

Fixes: dbf576fd8614 ("(create_lock_in_parent): New thread function to create lockf_t structure in parent process.")

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
