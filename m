Return-Path: <SRS0=Rx1S=UL=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id 39F1D3858D28
	for <cygwin-patches@cygwin.com>; Sun, 19 Jan 2025 02:50:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 39F1D3858D28
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 39F1D3858D28
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737255004; cv=none;
	b=bNFYKcGbotCDIj5pnJR86p9Uvm+P1uOvcX35Nrxek2MaUoL6Tk5+sZs1w7404qL/oITTanbA491tcEb0uXCF3VKywTDLaO9qj22rHsFTVF4DPNiknHGfcmq8YucycmIf6TD3t9B7dIgrI9V+N1HrRqdRf+fYUtKVjxNtjIDS4BM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737255004; c=relaxed/simple;
	bh=7k01QJUJ0dTWF/+E7dirDdREn7FvEcq2IG858RfwRzE=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=LCqwtjJAbY0/p4Lk1cBcZ6kBIvx7nJYyTuR7YBQJz16FzSpaJVlx6YbrnNKIG6mvP0hizFPMQghcZOPaLWW7s9YratONnIzjBME0HTw9MTqUTqGdkGoGzH2qLcaeSiryKPz71CNqNPgVS5pt/IgWJ0f8rshXbWl5GqxTn+wuHOA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 39F1D3858D28
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=nK5TPexq
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20250119025000526.OVNZ.96847.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 19 Jan 2025 11:50:00 +0900
Date: Sun, 19 Jan 2025 11:49:58 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: signal: Do not handle signal when
 __SIGFLUSHFAST is sent
Message-Id: <20250119114958.82129e29fae9093f38dac53c@nifty.ne.jp>
In-Reply-To: <8bdee3d3-1200-b70d-5829-d0a081323562@jdrake.com>
References: <20241223013332.1269-1-takashi.yano@nifty.ne.jp>
	<Z36eWXU8Q__9fUhr@calimero.vinschen.de>
	<20250109105827.5cef1a8c1b27b13ab73746eb@nifty.ne.jp>
	<7aac0c64-e504-f26e-165e-cd1c0ed24d6c@jdrake.com>
	<20250117185241.34202389178435578f251727@nifty.ne.jp>
	<20250118204137.e719acb59d777ac3303a359f@nifty.ne.jp>
	<8bdee3d3-1200-b70d-5829-d0a081323562@jdrake.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1737255000;
 bh=oclz3IsLRDzveHflWPm250YU0l7FykIZR+61vfcuYoc=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=nK5TPexqv6owaEws17vSlNgKJhnHcghncPxTkM3XEQCJJIdRrHLCS3ngve0PsQSfVXcT56Mu
 /Y58rtJrcnWbCVdC07qFwrEfRzpRuAIhcZPZZ9++hnY3yJ5VsYPNd2Faq/6DLzC5r9S6zn3QE4
 SvgC8/nLpGJfnc0QQrO+gG06zXajflFLrBjG3wvjrqSUrz1IbvhTaV0PlDl1LSgLeSDF+wUiNC
 blb1qh1iC/swZ3Hmx7g/hXqNiB17jmd8m1iup4SUGxLqkhCGcHd34t58ytbJvM9Yd5VsLoCCRs
 u4tqRd0oMRq6boqzL9FXXcDFYy3jTB63JNRtnAFfPi23Ueeg==
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 18 Jan 2025 17:06:50 -0800 (PST)
Jeremy Drake wrote:
> On Sat, 18 Jan 2025, Takashi Yano wrote:
> 
> > While debugging this problem, I encountered another hang issue,
> > which is fixed by:
> > 0001-Cygwin-signal-Avoid-frequent-tls-lock-unlock-for-SIG.patch
> 
> I'm concerned about this patch.  There's a window where current_sig could
> be changed after exiting the while, before the lock is acquired by
> cygheap->find_tls (_main_tls);  Should current_sig be rechecked after the
> lock is acquired to make sure that hasn't happened?  Also, does
> current_sig need to be volatile, or is yield a sufficient fence for the
> compiler to know other threads may have changed the value?

Thanks for pointing out this. You are right if othre threads may
set current_sig to non-zero value. Current cygwin sets current_sig
to non-zero only in 
_cygtls::interrupt_setup()
and
_cygtls::handle_SIGCONT()
both are called from sigpacket::process() as follows.

wait_sig()->
 sigpacket::process() +-> sigpacket::setup_handler() -> _cygtls::interrupt_setup()
                      \-> _cygtls::handle_SIGCONT()

wait_sig() is a thread which handle received signals, so other
threads than wait_sig() thread do not set the current_sig to non-zero.
That is, other threads set current_sig only to zero. Therefore,
I think we don't have to guard checking current_sig value by lock.
The only thing we shoud guard is the following case.

[wait_sig()]               [another thread]
current_sig = SIGCONT;
                           current_sig = 0;
set_signal_arrived();

So, we should place current_sig = SIGCONT and set_signal_arrived()
inside the lock.

Am I overlooking something?

As for volatile, personally, I have never had any problems by
not marking variables that are accessed by multiple threads as
volatile. Do you have any example that causes problem due to
lack of volatile other than, say, hardware registers?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
