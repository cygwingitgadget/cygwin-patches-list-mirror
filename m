Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 03AEB385843A; Wed,  6 Mar 2024 12:54:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 03AEB385843A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1709729669;
	bh=FLR5ACr6X9Zvco+hkmjAj16YVm7ZBJKmxpJCorgd1kQ=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=mFz3I5/sq8WZ9n/bpbew7AgFXQEq+A6J1KWDiVJuoOGr2XQw+RGXeBPL7dpI93sin
	 H05c/QFyZqV8ngvbo6r4ASEKDnhmHQ4woTr0oaepTU/QEP3eWuw7ljIe/2HMs/fXvN
	 RnjeE4vPHK6WdTyrnt3A/+H1UOuQ1fw/jhrPb7lI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 1C197A80DA3; Wed,  6 Mar 2024 13:54:27 +0100 (CET)
Date: Wed, 6 Mar 2024 13:54:27 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Give up to use query_hdl for non-cygwin
 apps.
Message-ID: <Zehng9EELCgrrnBA@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <87a5nfbnv7.fsf@Gerda.invalid>
 <20240303203641.09321b0a0713e8bdb90980b5@nifty.ne.jp>
 <ZeWjmEikjIUushtk@calimero.vinschen.de>
 <87edcqgfwc.fsf@>
 <ZeYG_11UfRTLzit1@calimero.vinschen.de>
 <20240305090648.6342d8f9cb8fd4ca64b47d38@nifty.ne.jp>
 <ZebwloVEzedGcBWj@calimero.vinschen.de>
 <20240305234753.b484e79322961aba9f8c9979@nifty.ne.jp>
 <ZedOO5gM1xApOb3A@calimero.vinschen.de>
 <20240306034223.4d02b898542324431341b2bb@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240306034223.4d02b898542324431341b2bb@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Mar  6 03:42, Takashi Yano wrote:
> On Tue, 5 Mar 2024 17:54:19 +0100
> Corinna Vinschen wrote:
> > On Mar  5 23:47, Takashi Yano wrote:
> > > On Tue, 5 Mar 2024 11:14:46 +0100
> > > Corinna Vinschen wrote:
> > > > This doesn't affect your patch, but while looking into this, what
> > > > strikes me as weird is that fhandler_pipe::temporary_query_hdl() calls
> > > > NtQueryObject() and assembles the pipe name via swscanf() every time it
> > > > is called.
> > > > 
> > > > Wouldn't it make sense to store the name in the fhandler's
> > > > path_conv::wide_path/uni_path at creation time instead?
> > > > The wide_path member is not used at all in pipes, ostensibly.
> > > 
> > > Is the patch attached as you intended?
> > 
> > Yes, but it looks like it misses a few potential simplifications:
> > [...]
> Thanks for advice. I have revised the patch.

Looks good, thanks!


Corinna
