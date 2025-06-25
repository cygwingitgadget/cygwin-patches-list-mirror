Return-Path: <SRS0=5fL3=ZI=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.227.121])
	by sourceware.org (Postfix) with ESMTPS id D86D83857B90
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 10:58:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D86D83857B90
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D86D83857B90
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.121
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750849089; cv=none;
	b=LILmw6hDzPWUYLYh6mjOMiVGHBrUFUqEOc5w0Tn3kyGFLE3KnK48aOVaI0hGMpF4X9NFOjvR0eW+xAIX3VveYeaxpyu0OOXgvwyNaEBOUiWnZpJHFE3mBFNxarc8ixGBUiuO93YC0hd31POJ1jVhxQvyUdFvutJucAz+zsUWoOs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750849089; c=relaxed/simple;
	bh=02xtDQm6GI8MkZElONwhJrd385Ar9+dfB+NAnGJx2zQ=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=REVA1PZHDQYi/sQRWJd4qxY4+xABKoraQLsvEDaJSeMGy4AUhD095GXAtnn5wQRCTeyW8jX2klPhhI1MFfOnziLLxx5zTBBV18WuVw/ex74oJaUEpJTj2UwQsmQqU9Bia9HmCVvQB9BpsWTQ4N/BD3/n6Lz9eL3kkej3wWpv1v0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D86D83857B90
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=TG/mwUb7
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20250625105806934.ZDTQ.84842.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 19:58:06 +0900
Date: Wed, 25 Jun 2025 19:58:06 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: signal: Do not suspend myself and use VEH
Message-Id: <20250625195806.99522fb0d7b7f741760baf59@nifty.ne.jp>
In-Reply-To: <aFpbgHpjSYkgPGGI@calimero.vinschen.de>
References: <20250623205707.1387-1-takashi.yano@nifty.ne.jp>
	<aFpbgHpjSYkgPGGI@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1750849086;
 bh=6FWh7LwikA5OVwPM8IlBNl9W8oCzaQqrSpf2bfH/7OU=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=TG/mwUb7agQqHQOPKDuQRnaa++Jc/vEQScRmohJLTUQqKTuv1eBPWxDm9RoFaXabo3r2Fd3j
 t7NVLN2KPQvhW+6nSgoSMUR4qhe7Er+0OE/qE6d2OGhuKcCubBHemHCs40Qg0b3z5ZicrdjuGk
 Yrjt2x9DCfPoJKoNonU/uiVXSATkguGAO110S5/BT56AJRyaNFUZlVOkoVCBuVkarJmIePx7Du
 vVJqq36Oetd6nRwPG2ZSp4kofzhnL0hQ4kl8YyblQLALQB7R5JAkGnvXVtSTVHEnlpVdGIyYgf
 0iQksY1f9i5Rt8p9WL0VQEj85glRGCGiULlShTOiQep0rDfw==
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 24 Jun 2025 10:02:08 +0200
Corinna Vinschen wrote:
> Hi Takashi,
> 
> On Jun 24 05:56, Takashi Yano wrote:
> > After the commit f305ca916ad2, some stress-ng tests fail in arm64
> > windows. There seems to be two causes for this issue. One is that
> > calling SuspendThread(GetCurrentThread()) may suspend myself in
> > the kernel. Branching to sigdelayed in the kernel code does not
> > work as expected as the original _cygtls::interrup_now() intended.
> > The other cause is, single step exception sometimes does not trigger
> > exception::handle() for some reason. Therefore, register vectored
> > exception handler (VEH) and use it for single step exception instead.
> 
> Patch LGTM, except that we have to link against another DLL now.
> I searched for another way and it turns out there are equivalent
> Rtl functions RtlWaitOnAddress/RtlWakeAddressSingle in ntdll.dll.
> 
> I pasted my tweak to your patch below, hope that's ok with you.

Thanks!

I tested your tweaked patch, and it works as expected.
One thing I do not understand is, what is the last argument
of RtlWaitOnAddress()? Is there any document about that?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
