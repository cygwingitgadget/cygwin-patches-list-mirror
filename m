Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 6FC433858D28; Wed,  8 Jan 2025 15:48:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6FC433858D28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1736351323;
	bh=pfjdGm/dN3Gvim4It4zlwjSOgA+cRtfmtAzQdiC0Lss=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=Rm8nYWc8BBGtEEDZWas4oGEdx05BEoImy1zXS53xircoNLgBhrlcTQVqk2qlyLqBA
	 q4QXc5S3KlxVchk+IzfOxoM3zRz0ksXrxnfDiDJH5A0P1FXR8ynH2BrYkNDTqwoGAb
	 HKnwzQC5Py+4X1iBURMZ2ZBcpGWZ70ox3ukSxCig=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id CB6D8A805BC; Wed,  8 Jan 2025 16:48:41 +0100 (CET)
Date: Wed, 8 Jan 2025 16:48:41 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: signal: Do not handle signal when
 __SIGFLUSHFAST is sent
Message-ID: <Z36eWXU8Q__9fUhr@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241223013332.1269-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241223013332.1269-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Dec 23 10:33, Takashi Yano wrote:
> After the commit d243e51ef1d3, zsh sometimes hangs at startup. This
> occurs because SIGCHLD, which should trigger sigsuspend(), is handled
> in cygwait() that is used to wait for a wakeup event in sig_send(),
> even when __SIGFLUSHFAST is sent. Despite __SIGFLUSHFAST being
> required to return before handling the signal, this does not happen.
> With this patch, if the signal currently being sent is __SIGFLUSHFAST,
> do not handle the received signal and keep it asserted after the
> cygwait() for the wakeup event.  Apply the same logic to the cygwait()
> in the retrying loop for WriteFile() as well.

Does this patch fix Bruno's bash issue as well?


Thanks,
Corinna
