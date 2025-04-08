Return-Path: <SRS0=7wyj=W2=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e02.mail.nifty.com (mta-snd-e02.mail.nifty.com [106.153.227.178])
	by sourceware.org (Postfix) with ESMTPS id 67E3C3857037
	for <cygwin-patches@cygwin.com>; Tue,  8 Apr 2025 14:29:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 67E3C3857037
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 67E3C3857037
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.178
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1744122598; cv=none;
	b=NGWS89TR8o8kTV5WgbSAww01mLn+qpl8rA2HWEsFHpzUk2OwY8ug4tMfIYJxO9yYRd1yC56AdRm3YVK11RHeBWQWGXGnLlr2KO3+y6lMlborTQXQGHQQqFfJc6o/rgSeyVEP1nHW10aKN1kEWquTqbj6Y+U5GbtoLb+qCMRJ1Os=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1744122598; c=relaxed/simple;
	bh=5WmW8E/NxtpofZ87o/j1D25RP8LeWYE70hp/x7sbsTA=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=XAu2J2PbgBcp++J2N+KIiY6TUwLLuhOUhmiq3vQNddSmpr26ldXe4/zNflN0DTkFBifZT3cgHTXyprAnGyK2wPVAP7aWBcjs+lyoveivL1rv9z/v9TZH/TwhR5E14sYdDajXrXdPS8d4BuYpDgSjDMMee+fx+mgJT7nnZ7qvDnM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 67E3C3857037
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=gxQBfMuf
Received: from HP-Z230 by mta-snd-e02.mail.nifty.com with ESMTP
          id <20250408142954415.MBEF.120311.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 8 Apr 2025 23:29:54 +0900
Date: Tue, 8 Apr 2025 23:29:54 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: thread: Allow fast_mutex to be acquired
 multiple times.
Message-Id: <20250408232954.97a58219752b5dfcb2d33720@nifty.ne.jp>
In-Reply-To: <Z_UOEZilfKBff2rP@calimero.vinschen.de>
References: <20250324055340.975-1-takashi.yano@nifty.ne.jp>
	<Z-E6groYVnQAh-kj@calimero.vinschen.de>
	<20250324220522.fc26bee8c8cc50bae0ad742b@nifty.ne.jp>
	<Z-F7rKIQfY2aYHSD@calimero.vinschen.de>
	<20250326181404.847ecfadcad8977024580575@nifty.ne.jp>
	<Z-PJ_IvVeekUwYAA@calimero.vinschen.de>
	<20250404214943.5215476f96d46cf15587dd1b@nifty.ne.jp>
	<20250406195754.86176712205af9b956301697@nifty.ne.jp>
	<Z_T5HMWYU6nYsyTz@calimero.vinschen.de>
	<20250408193719.4f284c100be21957dc29cc03@nifty.ne.jp>
	<Z_UOEZilfKBff2rP@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1744122594;
 bh=GD/cQyon0fnYuJe0XREm8L6G/6m2lip+HSj5si2kGY4=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=gxQBfMufxgWfOiodf7hVWc/LhQIAP+CoCKwQ7IML/Z8d5SRfkDrcIa/abizZYuQfGwe1CmvO
 8tgcGdaTh2SWLsGHlwMKrsDpU6hTI6683ymmq3q15re/X3JI8MKQ/BoPFVSSfERBScZ6I6O8wJ
 1XeUqWXII9/0vqWC5remZxznHiVXfPKO7b1ps3/dh8Ngy/gstynOWsTUCVNEiHZCc2qYq6hfPL
 kmrYGoFbGUhCsWfyjFscJl9E8I0Y7vTOBvdGJ5qT51hXOupeYuH1ZSZOlpCbL6d9BMp26yRHBj
 V+WE+JndvePyYYd7ndaxo57NarIXaATtf4Nhcf+oXK+ih9Cw==
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 8 Apr 2025 13:52:49 +0200
Corinna Vinschen <corinna-cygwin@cygwin.com> wrote:
> On Apr  8 19:37, Takashi Yano wrote:
> > On Tue, 8 Apr 2025 12:23:24 +0200
> > Corinna Vinschen wrote:
> > > looks good, but...
> > > 
> > > On Apr  6 19:57, Takashi Yano wrote:
> > > > @@ -1685,7 +1700,15 @@ pthread_key::~pthread_key ()
> > > >     */
> > > >    if (magic != 0)
> > > >      {
> > > > -      keys.remove (this);
> > > > +      LONG64 seq = keys[key_idx].seq;
> > > > +      assert (pthread_key::keys_list::ready (seq)
> > > > +	      && InterlockedCompareExchange64 (&keys[key_idx].seq,
> > > > +					       seq + 1, seq) == seq);
> > > 
> > > ...do we really want to assert here?  Shouldn't this better just skip
> > > the rest of the function?
> > 
> > Sounds reasonable. Skipping before TlsFree (tls_index), right?
> 
> If seq is wrong, the code should just leave, I think, not touching
> anything.

Ok, thanks.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
