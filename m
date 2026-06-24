Return-Path: <SRS0=3SWy=EU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 991114BA2E23
	for <cygwin-patches@cygwin.com>; Wed, 24 Jun 2026 12:33:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 991114BA2E23
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 991114BA2E23
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782304421; cv=none;
	b=l0mrg3oDpOv5VtDn+laF0EHrTFAEsUUZw7OrJT0KAwfDry6+yAmaReYQ7JZ7SWBVeTEye7jVYJg61nQYJwdHjmK0gmBLzSo/Zo3/vRQVSdufAFpEAE/MvtuQ1VKniUYkj5TnlARfVoRIRMzxoY75A7yiJsBMPzjg94Rtn/8H7q0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782304421; c=relaxed/simple;
	bh=VhnEopN99NaubsyQhIRgBt8HzXGRTHab1QMvhW9r8oc=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=qcDDe5j9VIBJ0vW7uroFv0OQrgXgZLhKRlK0/7X4ZCTTsRss7TNx2kzt2PfyCOURSc4a85Aj0oaaG6+f0XBFnf0va4b3Prp6jZg5rLXGBUay4uJ1C9hfUS3pspYZ2aKGKfxeL10t3OZFB/9G/PvEN+btD7x5Mlk7n5xTnbL8duU=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=D3dcPF7X
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 991114BA2E23
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=D3dcPF7X
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260624123338027.EYNY.17441.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 24 Jun 2026 21:33:38 +0900
Date: Wed, 24 Jun 2026 21:33:35 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Treat CR/NL in accept_input() the same as
 in transfer_input()
Message-Id: <20260624213335.13c39ff28ab344e5b9442835@nifty.ne.jp>
In-Reply-To: <69c93160-c59a-4403-908a-56971df01ca2@maxrnd.com>
References: <20260612124728.38921-1-takashi.yano@nifty.ne.jp>
	<e24b66b2-4518-4fff-8b05-1fb349a1b491@maxrnd.com>
	<20260623220407.824a42b50f122e2cd31fe462@nifty.ne.jp>
	<69c93160-c59a-4403-908a-56971df01ca2@maxrnd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1782304418;
 bh=cmtWFkCzXLELRqwDUVDrDyE3sdaSGo0ZlxcW/HeWttk=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=D3dcPF7XeK0db+Yto9MBRkB/6m8WEyFf00CaDZ0jvHkJKVMH2jFCWX9MLFZMytNOd6twpFvm
 4GpsWXuXzB2ENqXeAdEAeJXTiGSbla79g3Esr2InTSW1fGFTHXQwPKHu0K9S2MhC6VHl3XYITY
 gXL396StzLdulAJ3hS97+QOCefVwHpJgjz1bgz369X3vrGmv12qnI9rJu4Yu/Ck25sG7JJkLWP
 JKVyM3/owy9iytmpSSERRytvsrttvaLvbiufYX97L2Rtww775o6JVa4xGGlNdAiOLt0jBRPUx4
 8JfFb5nTYA+9QhMB3BtgkZ9GgUZZNEiHWjUAvl/Dwp/j44Og==
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Thanks! Pushed.

On Wed, 24 Jun 2026 00:14:19 -0700
Mark Geisert wrote:
> Hi Takashi,
> 
> On 6/23/2026 6:04 AM, Takashi Yano wrote:
> > Hi Mark,
> > 
> > Thanks for reviewing!
> > 
> > On Tue, 23 Jun 2026 00:41:11 -0700
> > Mark Geisert wrote:
> >> Hi Takashi,
> >>
> >> On 6/12/2026 5:47 AM, Takashi Yano wrote:
> >>> In transfer_input(), CR and NL in the data transferred to nat-pipe
> >>> is treated as follows:
> >>>     1) If pseudo console is activated, convert NL to CR.
> >>>     2) If pseudo console is disabled, convert CR to NL.
> >>> This conversion is necessary to ensure non-cygwin apps can handle
> >>> CR/NL as expected. Therefor, CR and NL should be treated as the
> >>> same way in accept_input() if the data is sent to nat-pipe.
> >>
> >> The above block is fine.
> >>
> >>> Usually, when pseudo console is activated, the input data for non-
> >>> cygwin app is not treated by accept_input. However, accept_input()
> >>> handle the input data in pseudo console enabled mode, only in a
> >>> very short duration when pseudo console is about to setup, because
> >>> master::write() calls line_edit() in the pcon_start mode. If pseudo
> >>> console is disabled, accept_input() handles them, however usually
> >>> ICRNL flag is set, so line_edit() do this conversion. However, if
> >>> this flag is not set, the conversion added by this patch is needed
> >>> as well.
> >>
> >> This block I'm having a bit of trouble to follow.  Can you possibly
> >> reword to describe it in more orderly fashion?
> > 
> > What about:
> >    In the previous implementation, problems rarely occurred because
> >    accept_input() normally does not handle input for non-cygwin apps
> >    when the pseudo console is active. Under typical conditions, such
> >    input is snet to pseudo console directly by WriteFile(), so
>                ^^^^
> >    accept_input() is not involved and no onversion issues arise.
>                                             ^^^^^^^^^
> > 
> >    There is, however, a brief period during pseudo console initialization
> >    in which accept_input *does* handle the input. This happens because
> >    master::write() invokes line_edit() while in pcons_start mode. During
> >    this short window, the input is processed in pseudo-console-enabled
> >    mode, and the usual conversion behaviour may not apply.
> > 
> >    When the pseudo console is disabled, accept_input() always handles
> >    the input, and in most cases the ICRNL flag is set by shell, so
> >    line_edit() performs the CR->NL conversion. But if the flag is not
> >    set, this conversion does not occur. Therefore, the additional
> >    conversion introduced by this patch is required to ensure consistent
> >    behaviour in both cases.
> 
> Much better!  Please fix the minor typos indicated and it will LGTM.
> OK to push.
> 
> ..mark


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
