Return-Path: <SRS0=5dpU=SW=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id B3B973858C41
	for <cygwin-patches@cygwin.com>; Wed, 27 Nov 2024 22:04:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B3B973858C41
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B3B973858C41
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732745040; cv=none;
	b=FwOAT84qRv7qtm6rcMrWeLmBKUfJcUY7YFuW7531iyy93TOygI8NfDD1MGtixr5PwaXwEtSg48clPtpheXRj1yxVcNCsUC86m5lo0SPEPNQEOBs+hMBIhiXOJNyDF+Ez8YEAYSyc9jjjpXRtrVECTP4f1td1SH7N+Vfmtd2cAng=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732745040; c=relaxed/simple;
	bh=2IAvMUCQjRxFHQzMpE5K7KPpVPcsyzuhsX93x4CuLI8=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=ewqT/BbqiZ/+p0DdQ+p5Gt6N/zw+vHi4UYzKTnjsRIv6tIONlnZIjdtcfcSof0u7YjXyvJjyNL6RNQTHmLALexk4QELUxYEJB5VZU41ZnPKF/51hXOmisX0YufttZUp+ldGoiyE5HVTn0fwfSNsHgEiQ1lxCktXkB7v5JGOtDjs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B3B973858C41
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=v0lHenvR
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 5943A45C8D
	for <cygwin-patches@cygwin.com>; Wed, 27 Nov 2024 17:04:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=Hs5GqY9w+ZVXoQqpVqdDRgVSh4U=; b=v0lHe
	nvR5uparpRBrxwMAXpOipYbKoNGnTPDUH6wvWjDhh48J/JEr+N4V/TtjopdToiTL
	+XvXf6MykxtEXz9DhH/pn7ZfAK+mMAkwWMm+cIwSNgFi6j18wybTNcjOjPiAGCbE
	6iQMF5p/196eCt/wXiNnzUrJzqBWSItmJPzpMY=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 53F0545C8A
	for <cygwin-patches@cygwin.com>; Wed, 27 Nov 2024 17:04:00 -0500 (EST)
Date: Wed, 27 Nov 2024 14:04:00 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: finding fast_cwd_pointer on ARM64
In-Reply-To: <Z0c50yOraHdefcmw@calimero.vinschen.de>
Message-ID: <ee47c1e8-13c0-73cc-b479-62d20c9874cd@jdrake.com>
References: <9d0630f7-e8d6-b4f6-116b-1df6095877c3@jdrake.com> <Z0XOOW365ff53K6B@calimero.vinschen.de> <59f580ca-bded-6d45-c624-fd1ca13bd744@jdrake.com> <ec73a729-57e8-11f7-78be-ab78bde6c0a6@jdrake.com> <Z0c50yOraHdefcmw@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,KAM_NUMSUBJECT,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

> > > On Tue, 26 Nov 2024, Corinna Vinschen wrote:
> > >
> > > > Btw...
> > > >
> > > > We're doing this because nobody being able to debug ARM64 assembler came
> > > > up with a piece of code checking the ntdll assembler code to find the
> > > > address of the fast_cwd_pointer on ARM64.
> > > >
> > > > You seem to have the knowledge and the means to do that, Jeremy.
> > > >
> > > > Any fun tracking this down?

I decided to hack together a bit of an ugly proof-of-concept.  No error
checking or validating that it's finding the right instructions, but it
does work for native arm64, x86_64, and i686 on windows 10 22h2 (not
x86_64 of course) and windows 11 23h2.  It doesn't work on 32-bit arm, but
I'm sure nobody cares ;)

https://gist.github.com/jeremyd2019/aa167df0a0ae422fa6ebaea5b60c80c9


