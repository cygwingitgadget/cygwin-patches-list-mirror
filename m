Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id BA7A73868F56; Mon, 23 Jun 2025 15:40:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BA7A73868F56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750693237;
	bh=oXW2nVoS4zwgwiupS9lWtsv+ukcV+LMrHAqGMtcX+5E=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=qWliENr+wSZbhq1IF31dlLF0Yq1bPDlx4QFRsDBKjl5L0OwdfTfD4JrE8trqI42Z3
	 IBNkyn6Kkv0S4YAtasZfLJZr7p94D/zRSGeLce07446vmwspcBkPnHWA2sP4dJWwRi
	 JXD+Bdxdv2/HUSOtnuL+2ewvtn3nzdJ9T573QrCs=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 90281A80D72; Mon, 23 Jun 2025 17:40:34 +0200 (CEST)
Date: Mon, 23 Jun 2025 17:40:34 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: signal: Do not suspend myself and use VEH
Message-ID: <aFl1cpvv0-aTMB89@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250623115152.1844-1-takashi.yano@nifty.ne.jp>
 <aFlXBYX6L1xKOvOb@calimero.vinschen.de>
 <20250623232022.f74c6aa3d8838162675b308f@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250623232022.f74c6aa3d8838162675b308f@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Jun 23 23:20, Takashi Yano wrote:
> On Mon, 23 Jun 2025 15:30:45 +0200
> Corinna Vinschen wrote:
> > But there's another problem I don't get.  The VEH apparently
> > runs in the context of the single stepping thread (you're using
> > _my_tls in the VEH).  It sets in_exception_handler to true and then
> > goes into a busy loop before returning the exception flag.
> > 
> > But that means the following SuspendThread...
> > 
> > 
> > > +	  SuspendThread (*this);
> > 
> > ...will suspend the thread while in the VEH...
> > 
> > >  	  GetThreadContext (*this, cx);
> > >  	  suspend_on_exception = false;
> > 
> > ...because suspend_on_exception is true up to here.
> > 
> > How is that supposed to work?
> 
> Perhaps I don't fully understand your concern.
> 
> I intended to suspend the thread at the busy loop in the VEH.
> Then, branching to sigdelayed from there and return to the busy loop
> with suspend_on_exception flag of false.
> 
> What is your point?

I withdraw the question.  In fact, the long comment a couple of lines
earlier explains it.

Thanks,
Corinna
