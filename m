Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 612233858D26; Tue,  3 Dec 2024 14:41:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 612233858D26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1733236907;
	bh=rM0fzdaq2DcBsEknJEMO21faPO1JzhC9Vi3eJDW+UnU=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=UCBmDFoEHjmSp+HP/fnh+lI67ArvGCSkb1AMvfKob68sLhqgRTC8Y2Xv+n9AW7H5m
	 FPvqhGhLRB7HwaoCBWsEwZzvQF9+45im3KXgTPNg2utBI7npn9Ie8GrQ0QbOFFsQYJ
	 Y3ZuNkABJaIR6qaY8AnMpKoyFUlQUwCQOAuBMYKo=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 5B37BA8056F; Tue,  3 Dec 2024 15:41:45 +0100 (CET)
Date: Tue, 3 Dec 2024 15:41:45 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 3/9] Cygwin: signal: Remove queue entry from the queue
 chain when cleared
Message-ID: <Z08YqWmqVDEz_DDF@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241203140203.8351-1-takashi.yano@nifty.ne.jp>
 <20241203140203.8351-3-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241203140203.8351-3-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Dec  3 23:01, Takashi Yano wrote:
> The queue is cleaned up by removing the entries having si_signo == 0
> while processing the queued signals, however, sigpacket::process() may
> set si_signo in the queue to 0 of the entry already processed but not
> succeed by calling sig_clear(). This patch ensures the sig_clear()
> to remove the entry from the queue chain. For this purpose, the pointer
> prev has been added to the sigpacket. This is to handle the following
> case appropriately.
> 
> Consider the queued signal chain of:
> A->B->C->D
> without pointer prev. Assume that the pointer 'q' and 'qnext' point to
> C, and process() is processing C. If B is cleared in process(), A->next
> should be set to to C in sigpacket::clear().
> 
> Then, if process() for C succeeds, C should be removed from the queue,
> so A->next should be set to D. However, we cannot do that because we do
> not have the pointer to A in the while loop in wait_sig().
> 
> With the pointer prev, we can easily access A and C in sigpacket::clear()
> as well as A and D in the while loop in wait_sig() using the pointer prev
> and next without pursuing the chain.

Sounds good.  The concurrency problem is still open, right?

Thanks,
Corinna
