Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 2519C3858D35; Tue,  4 Jul 2023 14:36:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2519C3858D35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1688481388;
	bh=78f7lliiCk2Li7FKLa0I1P1cyglVPKhzCeF2fjSCnvM=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=ybRyvOjddWf+z6vU/b3J5Zc7HyGnPYyHxisyHLIKLp+KoM5iGRKaNbju0+G4BLIJt
	 c6vH/jO63mVZ/3Vl+TZ0J9KtU1jscz+Q6w59f6+e5ZazNPH5KHauqwpq75WUIfKNms
	 2LKVxtZcON5IErP5+xRPejh9TmC5XdyrjMQ3vfYA=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 6B52FA80F7A; Tue,  4 Jul 2023 16:36:26 +0200 (CEST)
Date: Tue, 4 Jul 2023 16:36:26 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: dtable: Delete old kludge code for /dev/tty.
Message-ID: <ZKQualiRASkQFC8N@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230704100338.255-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230704100338.255-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Jul  4 19:03, Takashi Yano wrote:
> This old kludge code assigns fhandler_console for /dev/tty even
> if the CTTY is not a console when stat() has been called. Due to
> this, the problem reported in
> https://cygwin.com/pipermail/cygwin/2023-June/253888.html
> occurs after the commit 3721a756b0d8 ("Cygwin: console: Make the
> console accessible from other terminals.").
> 
> This patch fixes the issue by dropping the old kludge code.
> 
> Though the exact reason why the kludge code was necessary is not
> clear enough, this kluge code has no longer seemed to be necessary
                                ^^^^^^^^^^^^^^^^^^^^
I'm not a native speaker myself, but

				no longer seems

might be better here.

Anyway, this is GTG.


Thanks,
Corinna
