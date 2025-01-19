Return-Path: <SRS0=Rx1S=UL=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.227.117])
	by sourceware.org (Postfix) with ESMTPS id 510B13858D21
	for <cygwin-patches@cygwin.com>; Sun, 19 Jan 2025 10:42:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 510B13858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 510B13858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.117
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737283330; cv=none;
	b=U9M/QOZrEy6INAM0hPB5M4EuYz9nfDDjo/UDx46+GS5OWppC7ajgds0S2RcP7tGn19fzs1rAeJ4uBvvTW3v6ciG/15pv34/I4qjwPWyb9nPDliGcRXA9l1wyLjV3WRCcj1dLRPxzgSgGXoPz7ltM+a6bfTPKx85P31SDUAwYKMo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737283330; c=relaxed/simple;
	bh=c2LiEivTWS4e5N5uEwuZr0KOTM0jXaZCbKvRwe5zsYo=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=vvAT9Jhre4RsWnRbtCp1C21l9Ch0JKqwpvifPzjIG+XOr1vCnN0bHMrcIVnp3rxA6P+xZTQnPG7b1irxvW/VkhScnSab1pYC52xbuFVilMgRknAzM+lmGbKDicvEbf4CNcr/xYsPRvIyhTuct2OP3iUsGRrCvRZoMU0Ft2hAESo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 510B13858D21
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=F5eez+SO
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20250119104206626.RUMI.81160.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 19 Jan 2025 19:42:06 +0900
Date: Sun, 19 Jan 2025 19:42:06 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: signal: Do not handle signal when
 __SIGFLUSHFAST is sent
Message-Id: <20250119194206.862aecab375cb03c7143c22e@nifty.ne.jp>
In-Reply-To: <20250119114958.82129e29fae9093f38dac53c@nifty.ne.jp>
References: <20241223013332.1269-1-takashi.yano@nifty.ne.jp>
	<Z36eWXU8Q__9fUhr@calimero.vinschen.de>
	<20250109105827.5cef1a8c1b27b13ab73746eb@nifty.ne.jp>
	<7aac0c64-e504-f26e-165e-cd1c0ed24d6c@jdrake.com>
	<20250117185241.34202389178435578f251727@nifty.ne.jp>
	<20250118204137.e719acb59d777ac3303a359f@nifty.ne.jp>
	<8bdee3d3-1200-b70d-5829-d0a081323562@jdrake.com>
	<20250119114958.82129e29fae9093f38dac53c@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1737283326;
 bh=bPeBqBd8tE0nQWsNY5BFEXPo+gyFcO0AACz429Vwfsg=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=F5eez+SOzfaQD0+7JaWVah6jdZNjlKpDTqAmeRIvvjQXSpTNBf+rjgIqmOwHf6GNri236qXk
 CepZHJxKPsF5tUvX7Wu60kwsNItu2kwgzIhixHcRSxGYMR7WE4d6resrcMe679CbANUeJA4pCt
 Tp3iHKFZuKJVmHJoc7UiTRRAaJwABIo6jlIwfAmQb1Zv/Udl0bCFbj0nMI4n0NpyrVhUVAk9O9
 332omhHs8qEusVhsdg32W07+tA/QWsEWic62xs9ykyntfFhNJosR5bQhntg9YIGPyCnkimRe3I
 cMMhtvrFV8XM1SP5cap2AL2h3UUFiLkZEMCvrSgUsNPgRm+Q==
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Sun, 19 Jan 2025 11:49:58 +0900
Takashi Yano wrote:
> On Sat, 18 Jan 2025 17:06:50 -0800 (PST)
> Jeremy Drake wrote:
> > On Sat, 18 Jan 2025, Takashi Yano wrote:
> > 
> > > While debugging this problem, I encountered another hang issue,
> > > which is fixed by:
> > > 0001-Cygwin-signal-Avoid-frequent-tls-lock-unlock-for-SIG.patch
> > 
> > I'm concerned about this patch.  There's a window where current_sig could
> > be changed after exiting the while, before the lock is acquired by
> > cygheap->find_tls (_main_tls);  Should current_sig be rechecked after the
> > lock is acquired to make sure that hasn't happened?  Also, does
> > current_sig need to be volatile, or is yield a sufficient fence for the
> > compiler to know other threads may have changed the value?
> 
> Thanks for pointing out this. You are right if othre threads may
> set current_sig to non-zero value. Current cygwin sets current_sig
> to non-zero only in 
> _cygtls::interrupt_setup()
> and
> _cygtls::handle_SIGCONT()
> both are called from sigpacket::process() as follows.
> 
> wait_sig()->
>  sigpacket::process() +-> sigpacket::setup_handler() -> _cygtls::interrupt_setup()
>                       \-> _cygtls::handle_SIGCONT()
> 
> wait_sig() is a thread which handle received signals, so other
> threads than wait_sig() thread do not set the current_sig to non-zero.
> That is, other threads set current_sig only to zero. Therefore,
> I think we don't have to guard checking current_sig value by lock.
> The only thing we shoud guard is the following case.
> 
> [wait_sig()]               [another thread]
> current_sig = SIGCONT;
>                            current_sig = 0;
> set_signal_arrived();
> 
> So, we should place current_sig = SIGCONT and set_signal_arrived()
> inside the lock.

I think the lock necessary here is _cygtls::lock(), isn't it?
Because the _cygtls::call_signal_handler() uses _cygtls::locl().
I'm asking you because you introduced the find_tls() lock first
in the commit:

commit 26158dc3e9c20fc0488944f0c3eefdc19255e7da
Author: Corinna Vinschen <corinna@vinschen.de>
Date:   Fri Nov 28 20:46:13 2014 +0000

            * cygheap.cc (init_cygheap::init_tls_list): Accommodate threadlist
            having a new type threadlist_t *.  Convert commented out code into an
            #if 0.  Create thread mutex.  Explain why.
            (init_cygheap::remove_tls): Drop timeout value.  Always wait infinitely
            for tls_sentry.  Return mutex HANDLE of just deleted threadlist entry.
            (init_cygheap::find_tls): New implementation taking tls pointer as
            search parameter.  Return threadlist_t *.
            (init_cygheap::find_tls): Return threadlist_t *.  Define ix as auto
            variable.  Drop exception handling since crash must be made impossible
            due to correct synchronization.  Return with locked mutex.
            * cygheap.h (struct threadlist_t): Define.
            (struct init_cygheap): Convert threadlist to threadlist_t type.
            (init_cygheap::remove_tls): Align declaration to above change.
            (init_cygheap::find_tls): Ditto.
            (init_cygheap::unlock_tls): Define.
            * cygtls.cc (_cygtls::remove): Unlock and close mutex when finishing.
            * exceptions.cc (sigpacket::process): Lock _cygtls area of thread before
            accessing it.
            * fhandler_termios.cc (fhandler_termios::bg_check): Ditto.
            * sigproc.cc (sig_send): Ditto.
            * thread.cc (pthread::exit): Ditto.  Add comment.
            (pthread::cancel): Ditto.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
