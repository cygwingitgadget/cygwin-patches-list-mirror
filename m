Return-Path: <SRS0=SMyN=27=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 36B2B3858019
	for <cygwin-patches@cygwin.com>; Tue, 19 Aug 2025 17:48:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 36B2B3858019
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 36B2B3858019
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1755625715; cv=none;
	b=PK+fNNx8AvEix7S9jURi2fzEFOZMLFc3QQHtLFj/HRLY0Z63OKLgtVUChBYkyBkgfQZvcQ4UAIpoKxnXZvRhAtMuQr/M2LUD+pA1W22+t+n86Q6teNL0S08UsV3+GuTg7td/AOp6EppHFYnZ583HH29dEQKJG4xlwb0I/msDzDE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1755625715; c=relaxed/simple;
	bh=TecWRhLTKzvujrOyLott5HWRIaH4Kf1ZL+tcfvfhU9s=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=wT3L+i2EdmCmxtQGsKrOs5zeesbknnk0GyHDxy5HnlOkGplIqc3F5d+wIAhKCT0HMpeG4EUZ3e9BtgRWa5AdpuCg3LVh1zw8uvEA+EptcQ4aZd0/46X06OQbyefZZxgob8jfjiY5/8McW20tH2H2sycOAp7dy8DrKlURTSIzjCM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 36B2B3858019
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=DP1xhOsE
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id E086845CF2;
	Tue, 19 Aug 2025 13:48:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=tRfvtuIInJPOEBCrRAtq9pv+Uy0=; b=DP1xh
	OsEhBDf6J10Ctu13dHnfqnkelapPguzPQ/HYkl7Zo4dgcD7UIuAjeVQ3I7i8yIsI
	zNErgw/JrtuDDAYSb4JH/jV9q1EpnEes9LqVkIjar+SUJioQ6acX6bXOWn8M7bWh
	utxXVYyQFSAK21FvrJm8Ht7YMa0CZBPy7FWnd4=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id C277945A25;
	Tue, 19 Aug 2025 13:48:34 -0400 (EDT)
Date: Tue, 19 Aug 2025 10:48:34 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fix finding overlaps from F_SETLKW.
In-Reply-To: <20250819215030.5a37ba3eb712022b04abbe0d@nifty.ne.jp>
Message-ID: <0ef5b8c8-f3bd-324d-5167-10d1c0309c32@jdrake.com>
References: <a8581a49-fe01-37a8-edb7-95ccccf66549@jdrake.com> <20250819215030.5a37ba3eb712022b04abbe0d@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 19 Aug 2025, Takashi Yano wrote:

> On Mon, 18 Aug 2025 16:30:48 -0700 (PDT)
> Jeremy Drake wrote:
> > -      bool self = (lf->lf_flags == lock->lf_flags)
> > +      bool self = ((lf->lf_flags & ~F_WAIT) == (lock->lf_flags & ~F_WAIT))
> >  		  && (lf->lf_id == lock->lf_id);
> >
> >        if (bsd_flock || ((type & SELF) && !self) || ((type & OTHERS) && self))
>
> The patch itself LGTM, however, I wonder why it is not necessary to compare
> also 'lf_type' here. Or is it enough to compare only 'lf_id' by any chance?

I don't know, I was only looking at the commit in question and debugging
to see how to un-regress the tests.  It wasn't looking at lf_type before
or after.  lf_flags contains whether it's posix, bsd flock, or now ofd
lock.  lf_type contains whether it's read lock, write lock, or unlocked.
lf_id contains the pid or a unique id.
