Return-Path: <SRS0=STBq=SO=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w04.mail.nifty.com (mta-snd-w04.mail.nifty.com [106.153.227.36])
	by sourceware.org (Postfix) with ESMTPS id 4A16F3858C33
	for <cygwin-patches@cygwin.com>; Tue, 19 Nov 2024 08:40:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4A16F3858C33
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4A16F3858C33
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732005602; cv=none;
	b=HMYgWvUJGsvy+0RE+U1yKzwfN6vlejXYlXwZ5kyIicFyLiEoiAcSKDsY78D97tzar85MXeRmddWAgJLQRIm9YOlMqwcitTnWu/00PyLsi0dlA3jayJQSaLZd+Rql7YpvboW2fmL5Ufgu6xBSX2ztnZWBf9xx9DveH7wIf17s/2I=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732005602; c=relaxed/simple;
	bh=A88iamnWKdYZ0MkhHNEuKULSuBAH2/qQcYxC8fSDF1Y=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=IvPNrgSfsRFwGKsxoR+c4wQmgO5Yj5MZhZewr0p4v4YmiS6RnnvhY1tvfskDu+zJA0tIkeR94zrlePcc4jJRf8LUU7LXlFmhR/SNkJ8cDuU5REjzxB58fwhn7y1kVog+LsNUQVXHhqIkX4Yw/Uezn6Dot8GfcyRbdTTrzgmaeZI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4A16F3858C33
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=RMqwKAyy
Received: from HP-Z230 by mta-snd-w04.mail.nifty.com with ESMTP
          id <20241119084000516.HMRR.61254.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 19 Nov 2024 17:40:00 +0900
Date: Tue, 19 Nov 2024 17:39:58 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: sigtimedwait: Fix segfault when timeout is used
Message-Id: <20241119173958.0a61fa297d39f31f8b1ad304@nifty.ne.jp>
In-Reply-To: <Zzten8QZMrpkvjZb@calimero.vinschen.de>
References: <20241117154829.1578-1-takashi.yano@nifty.ne.jp>
	<Zzten8QZMrpkvjZb@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1732005600;
 bh=kWbPdQzLo/kU4u/xbiyc7sQNMC8QJ7PLkjYYXv3tibQ=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=RMqwKAyynLNqFFMDKVXUlBBKoZ1gx0RG8FyYwkkoadqXU8H0KLAtcv/fp450EZ08583ZLhg2
 8dpYPMtNK9FDHaW1bxoS9V2QJ5QDbZwHBlg8O+1bT2DlFVcnCi3Gh+X1wvLgZrJTgIZAwSQZbN
 TMwORN9j37NkeYgUg8t6eLwFgqA8usgQP7dQ10ccD48MoEKZiEuXaX7842pYtaKaFxV8hXFZik
 dWMHnK2ga64H1o2NoC8U/evgvQjBclp/RzR5TZ/rSywZYIcPU+w/CgnhV2dCb77rXJQSM2XQ8t
 0YWtbJuET0mSPp0dCKEHmUT+5RtpzTDbDKO2jNtT/1u9uUdQ==
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 18 Nov 2024 16:34:55 +0100
Corinna Vinschen wrote:
> Hi Takashi,
> 
> thanks for looking into this problem.
> 
> On Nov 18 00:48, Takashi Yano wrote:
> > @@ -640,6 +641,16 @@ sigwait_common (const sigset_t *set, siginfo_t *info, PLARGE_INTEGER waittime)
> >  	    }
> >  	  break;
> >  	case WAIT_TIMEOUT:
> > +	  _my_tls.lock ();
> > +	  if (_my_tls.sigwait_mask == 0)
> > +	    {
> > +	      /* sigpacket::process() already started. */
> > +	      waittime = cw_infinite;
> 
> cw_infinite?  Shouldn't this situation lead to cygwait returning
> immediately with WAIT_SIGNALLED?  The theory would explain to me
> that the timeout doesn't matter in this case, but given that the
> actual, configured timeout already occured, wouldn't it be
> safer to set timeout to 0?  Just in case?

The signal will arrive very soon definitely, so I think cw_infinite
can be used, I think. However, handling it as if WAIT_SIGNALED is
returned sounds more reasonable, so I'll submit v2 patch.

Could you please have a look?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
