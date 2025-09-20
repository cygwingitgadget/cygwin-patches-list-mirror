Return-Path: <SRS0=evLx=37=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 3000B3858C51
	for <cygwin-patches@cygwin.com>; Sat, 20 Sep 2025 18:30:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3000B3858C51
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3000B3858C51
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1758393027; cv=none;
	b=hNr6b5sO72Y64Vcmphe1tnnIfrkTOPxZd0eTwSIKvT+5aLhKHAwSm+iYX+TGUm6Yw8AqB0YHThFXH7CGEnplDRnGUnrbA9KWHAnRYJbf7TFKps6qycSNTJpUjsSLh50nndbeq7N+QDL6qvq4HsIfuJoq/hC8QhEZV+my+VlMwkk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1758393027; c=relaxed/simple;
	bh=BSZZ9OeOooXx4S8l6hk0NfptV2OVfos/4YE3hJrzZaI=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=RJxKqG8vbUx2OfS8DIGe3Hx/oHfNO9mpoBroP5iYLagoj2FtT01L83/5lVRnQyvDFjLd5G0vMzl9+ff1GN2NaqBAKM6GO11mn2sPBdFtcSQE8aTB085EXE6n92Jz/UEnn1b4WwsgQloCmw3a7tnAcVqsH9ockEVbuKmlZyVMd2E=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3000B3858C51
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=bSO+qD4/
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 4D97645D3F;
	Sat, 20 Sep 2025 14:30:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=PG7z4xGzgY4Zxx5NZE3QBLVkLBM=; b=bSO+q
	D4/jcAH2jbFjyyiCv7OxnLlmSH8baA8LTMogM2JYuB3d07u8OQ5pTXfYqqevqvez
	7l+UpAHRojR1mtLPE2th+3ADcWl2cD1TQbFyuZouB8J1ZyWDX7ganMnxHWlUb+Fa
	SzsZ2uDTKFsw8tMwL3Ts5NlWH15oMq4PIvY5Ps=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 36EC745D3A;
	Sat, 20 Sep 2025 14:30:26 -0400 (EDT)
Date: Sat, 20 Sep 2025 11:30:26 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Jon Turney <jon.turney@dronecode.org.uk>
cc: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>, 
    "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: math: Add AArch64 support for sqrt()
In-Reply-To: <040f4e8d-3fd8-4c61-b0bc-8a8d3683785f@dronecode.org.uk>
Message-ID: <8fd38ef1-c4f2-9892-8a4f-8a797cf6f633@jdrake.com>
References: <MA0P287MB308276F1ACA00942D9BEAE6D9F22A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM> <4335043f-7b4c-4147-65e6-de0199da413f@jdrake.com> <040f4e8d-3fd8-4c61-b0bc-8a8d3683785f@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 20 Sep 2025, Jon Turney wrote:

> On 13/08/2025 18:33, Jeremy Drake via Cygwin-patches wrote:
> > On Tue, 5 Aug 2025, Thirumalai Nagalingam wrote:
> >
> > > Hi all,
> > >
> > > This patch adds support for the `fsqrt` instruction on AArch64 platforms
> > > in the `__FLT_ABI(sqrt)` implementation.
> >
> > This looks OK as far as it goes, but I have a few thoughts.
> >
> > From the comments, it appears this code originally came from mingw-w64.
> > Their current version of this code has aarch64 implementations.  The
> > difference with this one is they have a version for float as well as
> > double.  The versions here seem to only be used for long double (which on
> > aarch64 is the same as double).
> >
> > Given that long double is the same as double on aarch64, might it make
> > sense to redirect/alias the long double names to the double
> > implementations in the def file (cygwin.din) on aarch64, rather than
> > providing two different implementations (one in newlib for double and one
> > in this cygwin/math directory for long double)?  It seems like that's
> > asking for subtle discrepancies between the implementations.  I'm not
> > seeing any obvious preprocesor-like operations in gendef (mingw-w64 uses
> > cpp to preprocess .def.in => .def files for arch-specific #ifdefs) so
> > maybe this would be more complicated.
>
> Sorry about the long delay looking into this.
>
> So, I was about to apply Thiru's v2 patch, since that all seems reasonable to
> me. But now I'm not so sure...
>
> I think that a good goal is to keep this file aligned with the mingw-w64
> version, if possible.
>
> If I'm understanding correctly, if we do that, this problem goes away, but at
> the cost that fsqrtd and fsqrtl are potentially different (although surely
> since it all boils down to a single instruction, that's never going to happen
> :) )?

Right.  Also, I expect whatever is done will need to be done with all the
rest of the long double functions in winsup/cygwin/math also.  I don't
know if sqrt was intended as an exemplar before moving forward with the
others, or if they really just had issues with this one.
