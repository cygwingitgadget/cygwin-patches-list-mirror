Return-Path: <SRS0=SFbU=3T=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [96.47.74.235])
	by sourceware.org (Postfix) with ESMTPS id 598B93839DAF
	for <cygwin-patches@cygwin.com>; Sat, 19 Nov 2022 21:38:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 598B93839DAF
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 45D9CCD31;
	Sat, 19 Nov 2022 16:38:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=VLM6zjkJd7SNYrvNHg9bBnS0NZg=; b=eUf5p
	dJM9B7xLGSablBoXVxgI6+OXRMU6An8qFhnJxueVcw8RNPcK+/u/2cHAhW3ZeWWE
	NiCUvi1hAf4JlRWTicokA3pq6n8U4Asuxa9ZsOtyG4Yg93iNf17FZIvioi0hTQjf
	AD/OmhprZHUa225gLD8tXggvpzeKx2I1EYmDrM=
Received: from mail231 (mail231 [96.47.74.235])
	(using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 34787CD2D;
	Sat, 19 Nov 2022 16:38:27 -0500 (EST)
Date: Sat, 19 Nov 2022 13:38:27 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
cc: cygwin-patches@cygwin.com, Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: Re: [PATCH] Cygwin: pty: Fix 'Bad address' error when running 'cmd.exe
 /c dir'
In-Reply-To: <s1268p66-18rs-9q3r-07oo-11o128pp06po@tzk.qr>
Message-ID: <alpine.BSO.2.21.2211191335030.30152@resin.csoft.net>
References: <20221022053420.1842-1-takashi.yano@nifty.ne.jp> <6EED0655-71E5-43B4-988D-B5935AED8EC0@gmx.de> <20221022151247.1b1cf1e3fc13d4c3dabc2191@nifty.ne.jp> <n4on0p20-970q-8693-7n50-4q22370s7rr5@tzk.qr> <Y1ZazH6objN99mSz@calimero.vinschen.de>
 <s1268p66-18rs-9q3r-07oo-11o128pp06po@tzk.qr>
User-Agent: Alpine 2.21 (BSO 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 18 Nov 2022, Johannes Schindelin wrote:

> Hi Corinna,
>
> On Mon, 24 Oct 2022, Corinna Vinschen wrote:
>
> > However, two points:
> >
> > - I'm wondering if the patch (both of yours) doesn't actually just cover
> >   a problem in child_info_spawn::worker().  Different runpath values,
> >   depending on the app path being "cmd" or "cmd.exe"?  That sounds like
> >   worker() is doing weird stuff.  And it does in line 400ff.
> >
> >   So, if the else branch of this code is apparently working fine for
> >   "cmd" per Takashi's observation in
> >   https://cygwin.com/pipermail/cygwin-patches/2022q4/012032.html, how
> >   much sense is in the if branch handling "command.com" and "cmd.exe"
> >   specially?  Wouldn't a better patch get rid of this extra if and
> >   the null_app_name variable instead?
>
> FWIW I would be in favor of getting rid of this special handling (unless
> it causes a regression). Given the recent experience, I expect Takashi to
> want to work on this without any interference from my side.


I was thinking maybe this check was intended to handle the, umm, "special"
quoting rules that "cmd /c" has (especially without "/s").  I don't know
why that would have anything to do with pcon though, so I may be totally
off the mark.
