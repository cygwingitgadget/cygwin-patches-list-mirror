Return-Path: <SRS0=fAJn=I2=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id 2B7764BA2E0F
	for <cygwin-patches@cygwin.com>; Thu,  5 Nov 2026 23:01:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2B7764BA2E0F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2B7764BA2E0F
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1793919718; cv=none;
	b=giJAb4Iq6MZZ9VDykYRusn5DLQCHdZ7+B5CWaKQ8ZHiq+w0wbo5i3z8chwVM6r9Fo6sQhySRl54fP7PBi55FSklHOlkSjTbxtSw6QCYdykiPLo8STPEqyTRWnB+Q4fl+mPT1JyPIAqGK5Q1lMCIyvR+qnbDK1OLQ9JAxSd1n4gU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1793919718; c=relaxed/simple;
	bh=kvsPNXeNJFieUizvoyZ0vWNd/5RNYkl5b4hjEVGBvUg=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=oX/tj6GXXZbloC7O+RH+86yZJUPusk4InbfJWrogjqy4LSGeETABSWo7Dz/EiZf3Aaz8zJOdumYx9t+Un2GM2j7F3tFGtnrTAWf3elKM7eTmUo72icZiXKMrMfovbcTT9gXoxuvuCU5bGS+4oG4VQmVUHvXYYQZe6dagHeBwfGU=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=AHQ1j/ec
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2B7764BA2E0F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=AHQ1j/ec
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20261105230155214.JHWY.44671.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 6 Nov 2026 08:01:55 +0900
Date: Fri, 6 Nov 2026 08:01:53 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] tgid reported incorrectly in /proc/<pid>/status
Message-Id: <20261106080153.52221602569d48f817b98304@nifty.ne.jp>
In-Reply-To: <87o6c9h9vd.fsf@Gerda.invalid>
References: <87wlreyhxi.fsf@Gerda.invalid>
	<20261020133919.10b3f008d0f28349c776f8af@nifty.ne.jp>
	<87o6c9h9vd.fsf@Gerda.invalid>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1793919715;
 bh=joIU5fePz3xYJ504xzodfi7ySt6Ndjs+AzPH+k34+eg=;
 h=Date:From:To:Subject:In-Reply-To;
 b=AHQ1j/ecm6GU/RfEC1tZp5ApMM3GlGvMnPJE8jOzGzKV6aUJstmQyW8mzTeEG6wRbVZnIwkI
 tEGYYT/AiRZDjSatrabVrWD3TU9ylje//Ns71ZelmbbPdmbi6XiRuUJfhUV96FHS6szm9iBg2b
 vEjqR6Mfn+qUp8GxRtg/nmyfO7LDnCwAemSDYKtve7xZZI3Jm756eZQHfXnHMM9qi3wLLIC8TW
 IpiAuMeeALtIUc0fg+F3d5JYgeRlAB5yKFUPsVZ+lD7+sX89VhTsIsmI/M+j2h3VPhAj0QL2x8
 H/KZnjq8IZPpi0TH3q5Bdw2rswOOC64mL5ETupaPjb2YoHXw==
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 31 Oct 2026 21:51:18 +0100
ASSI wrote:
> Takashi Yano writes:
> >> +			  num_threads, /* should really be the number
> >> +					  of LWP in the same thread
> >> +					  group, not the number of NT
> >> +					  threads attached to this
> >> +					  process */
> >
> > What is the practical difference? The only thing I can come up
> > with is whether it includes Cygwin’s internal threads (such as
> > the signal thread) or not. Is that right?
> 
> The main difference is that LWP have their own PID and Cygwin pthreads
> have not.  Also on Linux, while it is possible that helper threads get
> injected into another applications thread group (e.g. via a library),
> that is done rarely and requires elevated privileges.  An application
> not expecting that (because it's not using any libraries that would do
> that on Linux) might do undesirable things with such threads once they
> become exposed.  This is a fundamental difference since Cygwin does some
> "kernel"-like things via these helper threads that would be completely
> off-limits on Linux (by running in kernel space rather than user-space).
> So in essence Cygwin currently mixes both "user-space" and
> "kernel-space" threads into the same threads group and I think that
> these would somehow need to be separated in order to get something that
> conforms to the Linux LWP ABI expectations as best as a user-space
> implementation allows.

Thanks for the explanation. The patch applied as is.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
