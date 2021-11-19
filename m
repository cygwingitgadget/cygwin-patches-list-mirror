Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 by sourceware.org (Postfix) with ESMTPS id 738FB3857C60
 for <cygwin-patches@cygwin.com>; Fri, 19 Nov 2021 18:15:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 738FB3857C60
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from Express5800-S70 (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id 1AJIEr9r010789
 for <cygwin-patches@cygwin.com>; Sat, 20 Nov 2021 03:14:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 1AJIEr9r010789
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1637345693;
 bh=RFtC9Q+SULctojDk2HBfucnST1nCsIIc+1oG5tKvkbw=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=PVpl4HKe5cJN/VAN6u3zqRkURBdHdzmNapQFy0WdWQvtte06y6hhlbvdD2I/PgVXC
 jWU4dXmb/R+Y85o1f5Fo5dsop85jbkgnz+41yi+Ot8+8oveGXwVfn3RB83/jMS9CDv
 UPjAiocKsTg4308qpjZEYBcCsM4/6kbNdxZVg9JwBQo7vVXATDlgMVDtR/OZez7oIu
 JQfRYpBjyTthtIRIQTUMh8JZkSBZsE7jDnDQ2JnC/YHpkvBUcRRci8Hwa2XWZbTPjm
 yhzNvfGITjWH0MOaW4vJ2q0aojPCSTob4fcZldKcyVVhJUmcmb00jbX8LwGaV22FAn
 ltwcPFPMJSdTQ==
X-Nifty-SrcIP: [110.4.221.123]
Date: Sat, 20 Nov 2021 03:14:58 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: sigproc: Do not send signal to myself if exiting.
Message-Id: <20211120031458.fdbe94bd1a447dbd389cfd4c@nifty.ne.jp>
In-Reply-To: <YZfdYKyHPbMSZKVH@calimero.vinschen.de>
References: <20211119115043.356-1-takashi.yano@nifty.ne.jp>
 <YZfH6jj7AqbpSTn2@calimero.vinschen.de>
 <YZfIlfu+1Lw3OZIl@calimero.vinschen.de>
 <20211120021452.c72956bba50a03d33c43d454@nifty.ne.jp>
 <YZfdYKyHPbMSZKVH@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Fri, 19 Nov 2021 18:15:15 -0000

On Fri, 19 Nov 2021 18:22:40 +0100
Corinna Vinschen wrote:
> On Nov 20 02:14, Takashi Yano wrote:
> > On Fri, 19 Nov 2021 16:53:57 +0100
> > Corinna Vinschen wrote:
> > > On Nov 19 16:51, Corinna Vinschen wrote:
> > > > Isn't that already handled in wait_sig?  What's the difference here?
> > > 
> > > ...and where exactly is it waiting 60 secs?
> > 
> > If sending signal to myself with exit_state > ES_EXIT_STARGING,
> > wait_for_completion in sig_send() is set to true. Therefore,
> > sig_send() waits for pack.wakeup event for WSSC (60000 msec) here:
> > 
> >   /* No need to wait for signal completion unless this was a signal to
> >      this process.
> > 
> >      If it was a signal to this process, wait for a dispatched signal.
> >      Otherwise just wait for the wait_sig to signal that it has finished
> >      processing the signal.  */
> >   if (wait_for_completion)
> >     {
> >       sigproc_printf ("Waiting for pack.wakeup %p", pack.wakeup);
> >       rc = WaitForSingleObject (pack.wakeup, WSSC);
> >       ForceCloseHandle (pack.wakeup);
> >     }
> > 
> > However, thread wait_sig ignores the signal here:
> >       /* Don't process signals when we start exiting */
> >       if (exit_state > ES_EXIT_STARTING && pack.si.si_signo > 0)
> >         continue;
> > and does not call SetEvent (pack.wakeup).
> > 
> > As a result, sig_send() hangs for 60 secs.
> > 
> > With this patch, sig_send() does not send signal which will
> > be ignored in wait_sig().
> 
> Ah, ok, that makes sense.  Thanks for the explanation.  Please push.

Ah, this patch may cause race issue regarding exit_state.
I will submit another patch which overrides this patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
