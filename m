Return-Path: <SRS0=ZTWV=S4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [106.153.227.113])
	by sourceware.org (Postfix) with ESMTPS id 8D8F53858D26
	for <cygwin-patches@cygwin.com>; Tue,  3 Dec 2024 14:45:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8D8F53858D26
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8D8F53858D26
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.113
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733237120; cv=none;
	b=wm8MPKOTl/6Y7U20vn3OPs3KhZujsCI7FlkoSunS4XtrxSFAf2wHdA4aLCjr+pmSIFSTffqonC38Nezr1i12MTO3k3B39/+NsLQr4QAizTMaF9A15InOT3rWZ7SDq2YfFEIIV3hrMn8+werJzZW2U8wlOveSYkvAElfm0qu5Rcw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733237120; c=relaxed/simple;
	bh=wUncOCoXZcNY7HeidqlTc8Nruxt6GnON19qq3tYbsrw=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=PvvDBypgpQ/y9LW0EeCqskuTpWTs2nVZuNSxdg+KJNIhs9L4HydB8bjk/sP33qLJTfqFLgPgMeB3ZsyJoz3zKu+anVBmeXtZXaUXxWJQFL27JfSN+u8Wn4CbQp798qtCJlG+c8yHAD0ekpBaaNh1GuW73i+4cGZq7w9c3bPsbf8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8D8F53858D26
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=DFaSsZkR
Received: from HP-Z230 by mta-snd-e01.mail.nifty.com with ESMTP
          id <20241203144517769.DTCA.87244.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 3 Dec 2024 23:45:17 +0900
Date: Tue, 3 Dec 2024 23:45:16 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 3/9] Cygwin: signal: Remove queue entry from the
 queue chain when cleared
Message-Id: <20241203234516.2c276bd32d63ce680a47dfa7@nifty.ne.jp>
In-Reply-To: <Z08YqWmqVDEz_DDF@calimero.vinschen.de>
References: <20241203140203.8351-1-takashi.yano@nifty.ne.jp>
	<20241203140203.8351-3-takashi.yano@nifty.ne.jp>
	<Z08YqWmqVDEz_DDF@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1733237117;
 bh=d6DKtnbbnjTFUM1mwd9NIaJC3C/fWY459M0BfU72rCE=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=DFaSsZkR1WosgRXGB1rCE2X8viBm8bEpY0CDhO+AgfmPoGtvtBqoQl4upXRO1CKe+V65jVN2
 BqsMxWgMPz/7Dliwai4Tw7IFv1R/4zPwsekJXBQzEuD4Z9QEg11P2454JRiQ/Ps57kIh0YydNe
 i0T2dFBANSiXsTgE0E/PkyB6aBLp5m2+XmB+QPKi+c9DyRYsgKRAuxgWiXZiin4Ke5sI5Xdrzg
 zxEW1qqsNU6M9eqfGDDAsngGPVYwjauOPoCRuCN7J3hucJBQSV8pgyu9lzlE3r1MC8NSZOCQZS
 vyKs/C8HgC9StjFEjEgzFuy6t91ip1W6vEOhFpLyW2dgWzFA==
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 3 Dec 2024 15:41:45 +0100
Corinna Vinschen wrote:
> On Dec  3 23:01, Takashi Yano wrote:
> > The queue is cleaned up by removing the entries having si_signo == 0
> > while processing the queued signals, however, sigpacket::process() may
> > set si_signo in the queue to 0 of the entry already processed but not
> > succeed by calling sig_clear(). This patch ensures the sig_clear()
> > to remove the entry from the queue chain. For this purpose, the pointer
> > prev has been added to the sigpacket. This is to handle the following
> > case appropriately.
> > 
> > Consider the queued signal chain of:
> > A->B->C->D
> > without pointer prev. Assume that the pointer 'q' and 'qnext' point to
> > C, and process() is processing C. If B is cleared in process(), A->next
> > should be set to to C in sigpacket::clear().
> > 
> > Then, if process() for C succeeds, C should be removed from the queue,
> > so A->next should be set to D. However, we cannot do that because we do
> > not have the pointer to A in the while loop in wait_sig().
> > 
> > With the pointer prev, we can easily access A and C in sigpacket::clear()
> > as well as A and D in the while loop in wait_sig() using the pointer prev
> > and next without pursuing the chain.
> 
> Sounds good.  The concurrency problem is still open, right?

Yes. Please wait a while.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
