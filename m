Return-Path: <SRS0=MN9U=YW=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.227.117])
	by sourceware.org (Postfix) with ESMTPS id 8C0D93858D26
	for <cygwin-patches@cygwin.com>; Sat,  7 Jun 2025 09:36:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8C0D93858D26
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8C0D93858D26
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.117
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1749289015; cv=none;
	b=aHJmVVAYC0u7KT8p4krJaBU+kvv+FB4xX9lVoF4xd3RJj9yiOQR5WVUjjYZSO14MzqKAvQ1D8Mgp8Kqjtd/dB5SSIhE/dtRtCX9+gDfiF4Vnz95kkowkgO0UvcUhFjaeshVzhjvR4ZMmh0sXGeYLNOLxck/ctNUx2/jdjerge3A=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1749289015; c=relaxed/simple;
	bh=9TnzbIumtC8zN8gbvVAl/2aiaQ0nm8ypefAF5/0ljAI=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=MdqRa2WPzgm0ZRRNa729FiWHGgw+lZlXvXyqohosUD9S8LjiLO/j3QWqpLiguy99JbIgerfdl4TLQmSEoHYjVKjmzt3k3ILSIt/mAZbhP4TEXbpYiNH895PvAAVSLJZntQr53Prn7FXxCHnhwTyR+WDPxIO4th9rh2ZlH8ldNNg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8C0D93858D26
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=GzNsrYx3
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20250607093652880.UHIE.50988.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sat, 7 Jun 2025 18:36:52 +0900
Date: Sat, 7 Jun 2025 18:36:52 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: signal: Set _cygtls::sigmask earlier
Message-Id: <20250607183652.839b25492ca2fe4ada2f8d2a@nifty.ne.jp>
In-Reply-To: <20250607182340.aa027342f23d7f9d0985b62c@nifty.ne.jp>
References: <20250531011630.1500-1-takashi.yano@nifty.ne.jp>
	<20250607182340.aa027342f23d7f9d0985b62c@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1749289012;
 bh=ArgqslEJw4hZ4UaMuzoWe6GyPT1XuXr4/Tb2zIiAk6A=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=GzNsrYx3LwjRJLFFW6qqnrxnOyzua79cluMhi75/fbaPZxy4cL9jrSUjZwy3XoKuUvx0MZ/5
 lMe+aSU2U9Edurl6iGVpBnVG7JLAtTU64cEeIK32zGc2SdAAcxtMuB6g0vPY/0Q8frPpuwBuLe
 aXMzKP0taMaXtnElPaMjpTTtTL+pgDbY2srubZB6DkM2Lt8RSpfNfdzJHWo5wCABeHtToibuE1
 owqcMQy34vd/pZRmMMuTSaVLxmL3PRCB37AUQIg3nUmPQP9OK+Eq3jSOCWwER77cz2EaTJ9cTg
 igQ/wu02pSDJ7vh6XvvazQzb50ujUqjnSCq122igoV+V3cfA==
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 7 Jun 2025 18:23:40 +0900
Takashi Yano <takashi.yano@nifty.ne.jp> wrote:

> On Sat, 31 May 2025 10:16:22 +0900
> Takashi Yano wrote:
> > Currently, _cygtls::sigmask is set in call_signal_handler(), but this
> > is too late to effectively prevent a masked signal from being armed. 
> > With this patch, sigmask is set in _cygtls::interrupt_setup() instead.
> > 
> > Fixes: 0d675c5d7f24 ("* exceptions.cc (interrupt_setup): Don't set signal mask here or races occur with main thread.  Set it in sigdelayed instead.")
> > Reviewed-by:
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >  winsup/cygwin/exceptions.cc | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
[...]
> 
> I'd withdraw this patch because this patch seems to cause a race
> issue as mensioned in the commit message of the commit 0d675c5d7f24.
> 
> Instead, I would like to propose another patch for the sema purpose.
> https://cygwin.com/pipermail/cygwin-patches/2025q2/013749.html

So, I have currently three signal patches waiting for review.
https://cygwin.com/pipermail/cygwin-patches/2025q2/013731.html
https://cygwin.com/pipermail/cygwin-patches/2025q2/013733.html
https://cygwin.com/pipermail/cygwin-patches/2025q2/013749.html

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
