Return-Path: <SRS0=rS2O=VW=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id A73523858D21
	for <cygwin-patches@cygwin.com>; Mon,  3 Mar 2025 21:19:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A73523858D21
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A73523858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1741036785; cv=none;
	b=Zd+rU4EriaCCpETxAawNHchHkS3kWRqKUHnzk7LCJnGJnIISNLFY8P6/+uCd1xEbSqXWl5rhTnMQOJD/lc7PMabMvDlUF7qLM2CfZ0AJq4Qn4q7R++xgeqZw1CfToCRjQFFHoYRh2W989mEfFrBRIE75iBeN2y6FkKqJ0qnKJO8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1741036785; c=relaxed/simple;
	bh=I2PA6bj9dG2I8f/ZfctKh7/Dss5axdVe69Us3RE28g4=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=rKDNGX9yqBlwZk4iTPCYuJ0t2+s4UtXKsSokS63GWjvMm/L9xi/9Hyk6oItP9Yt7wS7Nc0SZmTUzZwo7k+AhJyW5aplxqigYmzktQr1MwhBhIN0kg2H9cDdrZxtL8PS+InZmEstOOklWdePdvtYOCjt9pFPPQhK0VJilqe5H2SI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A73523858D21
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=zEiq02xy
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 4E5CB45B2C;
	Mon,  3 Mar 2025 16:19:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=k27ei1xexdm5Yi9ocJ6fXsn+Bgg=; b=zEiq0
	2xyhog56z0bqWqpZ03gXRW/nG1X8XlXRfqUUPJnDwutPzKVoQgcmBfuUTj68QQIH
	QJAXPS6BrVIso5zXVrFlZWnh3+rNSyLNfBOq8IOkKzJxXSHdes3y5wsV6HIwFz0o
	e8qjat149bgosAvv7TPpmauWd2mPYyLY+QXctM=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 47BB645A49;
	Mon,  3 Mar 2025 16:19:45 -0500 (EST)
Date: Mon, 3 Mar 2025 13:19:45 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] Cygwin: Adjust CWD magic to accommodate for the latest
 Windows previews
In-Reply-To: <Z8WHsUDXsVhtOEzS@calimero.vinschen.de>
Message-ID: <576cd7fb-a579-4eda-19bf-1735a7a55bf0@jdrake.com>
References: <6449d894879e33af3e8a4791896d2026f7c3f8bd.1740865389.git.johannes.schindelin@gmx.de> <Z8WHsUDXsVhtOEzS@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 3 Mar 2025, Corinna Vinschen wrote:

> > diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
> > index 599809f941..49740ac465 100644
> > --- a/winsup/cygwin/path.cc
> > +++ b/winsup/cygwin/path.cc
> > @@ -4539,6 +4539,18 @@ find_fast_cwd_pointer ()
> >           %rcx for the subsequent RtlEnterCriticalSection call. */
> >        lock = (const uint8_t *) memmem ((const char *) use_cwd, 80,
> >                                         "\x48\x8d\x0d", 3);
> > +      if (lock)
> > +	{
> > +	  /* A recent Windows 11 Preview calls `lea rel(rip),%rcx' then
> > +	     a `mov` and a `movups` instruction, and only then
> > +	     `callq RtlEnterCriticalSection'.
> > +	     */
> > +	  if (memmem (lock + 7, 8, "\x4c\x89\x78\x10\x0f\x11\x40\xc8", 8))
>
> Is it really necessary to check for each and every byte between lea and
> callq?  I wonder if this can't be simpler by simply checking for the
> '\x48\x8d\x0d` needle and then, instead of just assuming a fixed
> call_rtl_offset, skip programatically to the next callq 0xe8 byte
> within the next 16 bytes or so?

I think looking for only a single byte might have too high a probability
of a false-positive match inside a multi-byte instruction.  As you said

> It needs a lot of knowledge of instructons and their respective length,
> to skip the uninteresting parts.
