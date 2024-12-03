Return-Path: <SRS0=ZTWV=S4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w03.mail.nifty.com (mta-snd-w03.mail.nifty.com [106.153.227.35])
	by sourceware.org (Postfix) with ESMTPS id A32603858D3C
	for <cygwin-patches@cygwin.com>; Tue,  3 Dec 2024 12:39:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A32603858D3C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A32603858D3C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.35
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733229576; cv=none;
	b=Kz/2Y7ZSwvNIg8Q26yqhXUZnhdKndsKUuMiDFOr+h2ZkPGQ/KMERtcWTWpE8jyy4nh/RPiWkUmEM/YFdIrMj+4Mqlje2gofMD/BgGb8aWkKWON1jT6OJnBvKwR5gQr/W7ST7ASED+MNQ5ev6HRsSJjTss7D8S9+kE+GbCcgTLyI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733229576; c=relaxed/simple;
	bh=e2kcH8Dwc6a0P08BPYtCpEel43z4tjuaCnjuSZpj6AE=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=uXqV8P1VADKuJvCPbcD9EWBPEcGjNWvqyD2prnycWKm7vJ/uiaPcg/1HAt5Jgb5VS+MNoHVo7RwnchTLMjGYxsZ0IjzL01i0XongYsdtAcSirEb0H6IAeQhcR2ThL+hjnAyCUjoHoJz4ZAclzg/jemON6rGehFWjio1LKzG2l8Q=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A32603858D3C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=blo9gpYr
Received: from HP-Z230 by mta-snd-w03.mail.nifty.com with ESMTP
          id <20241203123933913.DXZZ.115271.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 3 Dec 2024 21:39:33 +0900
Date: Tue, 3 Dec 2024 21:39:33 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 4/9] Cygwin: signal: Optimize the priority of the sig
 thread
Message-Id: <20241203213933.8a2c2d15027e63b887e7ed0b@nifty.ne.jp>
In-Reply-To: <Z03PtxZzigl-xvU0@calimero.vinschen.de>
References: <20241129120007.14516-1-takashi.yano@nifty.ne.jp>
	<Z03PtxZzigl-xvU0@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1733229574;
 bh=fGzccZKtQaYa5UbeTX2LKCLP2ZJypNI+KlVGDLEReHo=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=blo9gpYrns8gn7qEcWGVBgt3V+k2aP1tIcs9EfuaE/zbJV4P1GE8dYGW0L/ehALemRuD1x2L
 91ysicodKkjZUpY47mUA1BFLddUHSbcvCf4MFRBfJNl62qiIjKWKn/4zrLrY7LcDozFpnFPuYK
 BUoidsxgstEmgzKHlsgXXwo+/KQZev2iNRH4jjAeqbGTM/1ei1+lJ9YF8Y9gkWNtlsuNrJJKFt
 uss4B7Dje000psW5sOZaFMwAhe3TlguX+Wjw7EFjefEW1BnlTrKj20Ul/b40OcWiTGG5WtPlff
 eFmlzcvCobSIg8QGAquZuhSiqTJDj3vMnCTIqwNDlzLKLIvg==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 2 Dec 2024 16:18:15 +0100
Corinna Vinschen wrote:
> On Nov 29 20:59, Takashi Yano wrote:
> > Previously, the sig thread ran in THREAD_PRIORITY_HIGHEST priority.
> > This causes a critical delay in the signal handling in the main
> > thread if too many signals are received rapidly and the CPU is very
> > busy. In this case, most of the CPU time is allocated to the sig
> > thread, so the main thread cannot have a chance of handling signals.
> > With this patch, to avoid such a situation, the priority of the sig
> > thread is set to THREAD_PRIORITY_NORMAL priority. Furthermore, if
> > the signal is alerted to the main thread, but the main thread does
> > not handle it yet, to increase the chance of handling it in the main
> > thread, reduce the sig thread priority to THREAD_PRIORITY_LOWEST
> > priority temporarily before calling _cygtls::handle_SIGCONT().
> > 
> > Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
> > Fixes: 53ad6f1394aa ("(cygthread::cygthread): Use three only arguments for detached threads, and start the thread via QueueUserAPC/async_create.")
> > Reported-by: Christian Franke <Christian.Franke@t-online.de>
> > Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >  winsup/cygwin/exceptions.cc | 6 ++++++
> >  winsup/cygwin/sigproc.cc    | 1 +
> >  2 files changed, 7 insertions(+)
> > 
> > diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
> > index 0f8c21939..7fc644af1 100644
> > --- a/winsup/cygwin/exceptions.cc
> > +++ b/winsup/cygwin/exceptions.cc
> > @@ -978,6 +978,9 @@ sigpacket::setup_handler (void *handler, struct sigaction& siga, _cygtls *tls)
> >    CONTEXT cx;
> >    bool interrupted = false;
> >  
> > +  for (int i = 0; i < 100 && tls->current_sig; i++)
> > +    yield ();
> > +
> 
> Is that a piece of stray code left from testing, or is that actually
> part of the patch?  The commit message doesn't explain it...

Oops! Sorry, this is test code for another patch I tested now.
I'll submit v4 patch as well as another patch signal-related.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
