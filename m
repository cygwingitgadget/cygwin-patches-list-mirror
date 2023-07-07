Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 785723853D07; Fri,  7 Jul 2023 09:34:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 785723853D07
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1688722459;
	bh=HFeR407YZ3pT2YcsRtYrtvgDp9+Gpw3WGi8vCLHB4zo=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=MDdbCCaZBcP/mVMl8jKTrgx0jRdh3SlToPQIx0YEFmxYO7SRmmfPBS1Y7r1dKbOZW
	 RtbyW7BkE9Zq6e+u/afPNNR9y87mfiIO8ukvRpcw/XfNBc7xMLvEjVp0YLA96rhdFG
	 9Y6zJhMH6DryHKtvWAB5D0K1pc2VuQMDBwxbaCo8=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A384BA80BDA; Fri,  7 Jul 2023 11:34:17 +0200 (CEST)
Date: Fri, 7 Jul 2023 11:34:17 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: dtable: Delete old kludge code for /dev/tty.
Message-ID: <ZKfcGQgQmUfb7gH5@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230704100338.255-1-takashi.yano@nifty.ne.jp>
 <ZKQualiRASkQFC8N@calimero.vinschen.de>
 <20230707123005.493ee21ae5ad31500af6415c@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230707123005.493ee21ae5ad31500af6415c@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Jul  7 12:30, Takashi Yano wrote:
> Hi Corinna,
> 
> On Tue, 4 Jul 2023 16:36:26 +0200
> Corinna Vinschen wrote:
> > On Jul  4 19:03, Takashi Yano wrote:
> > > This old kludge code assigns fhandler_console for /dev/tty even
> > > if the CTTY is not a console when stat() has been called. Due to
> > > this, the problem reported in
> > > https://cygwin.com/pipermail/cygwin/2023-June/253888.html
> > > occurs after the commit 3721a756b0d8 ("Cygwin: console: Make the
> > > console accessible from other terminals.").
> > > 
> > > This patch fixes the issue by dropping the old kludge code.
> > > 
> > > Though the exact reason why the kludge code was necessary is not
> > > clear enough, this kluge code has no longer seemed to be necessary
> >                                 ^^^^^^^^^^^^^^^^^^^^
> > I'm not a native speaker myself, but
> > 
> > 				no longer seems
> > 
> > might be better here.
> > 
> > Anyway, this is GTG.
> 
> I think I understand correctly the concept of cnew_no_ctor macro in
> dtable.cc now. cnew_no_ctor calls fhandler_console(void *) instead of
> fhandler_console(fh_devices) to omits initialization of instance for
> stat() call. This might make stat() slightly faster.
> 
> Based on this understanding, I would like to withdraw the previous
> patch, and propose new patch series.
> 
> Could you please review the patch seriese?

Great, will do!


Thanks,
Corinna
