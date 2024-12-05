Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 1ED263858D20; Thu,  5 Dec 2024 15:31:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1ED263858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1733412686;
	bh=kQIiuUJoC0ZCXt4CNaqpFSvDTg3iz/kAatlNGJZ2E4c=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=pUTKtEVSzSNWJlcRUh8R1ybUbYDCyjNC1mmCyTRUURkNjud8npnnV1u2oH0zbDgml
	 My3deM+chO6Z1j1azoUiuxNmmhDo/R/LbwtI+QPyRGV8b7fNsRN4WXmgaLHYjWIjdz
	 I1qcOf2W98AnECspmyD5cPZ2k3kGrWTAxPliAVrU=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id CECF8A807A8; Thu,  5 Dec 2024 16:31:01 +0100 (CET)
Date: Thu, 5 Dec 2024 16:31:01 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: setjmp/longjmp: decrement incyg after signal
 handling
Message-ID: <Z1HHNScKCx_Tx8O9@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241204125447.316279-1-corinna-cygwin@cygwin.com>
 <20241205101422.ef6a17a0e3b8f313c1f76638@nifty.ne.jp>
 <Z1GFpWUYpJHKah23@calimero.vinschen.de>
 <20241205224033.a3dd8d46eba2d38083e43623@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241205224033.a3dd8d46eba2d38083e43623@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Dec  5 22:40, Takashi Yano wrote:
> Hi Corinna,
> 
> On Thu, 5 Dec 2024 11:51:17 +0100
> Corinna Vinschen wrote:
> > That was not the intention.  It was just something I found while looking
> > into the assembler code.  This looks like a long-standing bug, which,
> > if my description above is right, might result in threads missing
> > signals, too.  Or at least, signals being defered, because user-space
> > is running partially with the "iscyg" flag being set.
> > 
> > It would be nice if you could check this, too, to be sure I'm not
> > totally wrong here.
> 
> It looks almost good to me and your commit message sounds reasonable.
> One question.
> There are three incyg <- 0 lines in gendef that are outside of stacklock.
> Is that safe?

Hmmm. Let me check.  As a first guess I'd say yes, but...


Thanks,
Corinna
