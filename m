Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 89C5D3858D38; Thu,  5 Dec 2024 10:51:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 89C5D3858D38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1733395909;
	bh=woGY1ETnSTSg30XfP8cOCG4Wpp0evJ8Kf3jgaIcgitc=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=RRlzhkBH1JK5FEXD62jB1X533UN+9obu/AUJWDd2b10/EHrx9yFWLFoQDJXwasM7P
	 Z7MKzeLOXMXqh1Sya7wBjsKIUBTdYL1wmZwZKiwGQCCeX8gjkj792hahI6ypcoYKjC
	 4lGJLQPUrOsVmYO3igqJSr8HNC6FTSh1hqoIm5xQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 85CCFA80659; Thu,  5 Dec 2024 11:51:47 +0100 (CET)
Date: Thu, 5 Dec 2024 11:51:47 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: signal: Introduce a lock for the signal queue
Message-ID: <Z1GFwzDzoLA88AI6@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241205032548.29799-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241205032548.29799-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Dec  5 12:25, Takashi Yano wrote:
> Currently, the signal queue is touched by the thread sig as well as
> other threads that call sigaction_worker(). This potentially has
> a possibility to destroy the signal queue chain. A possible worst
> result may be a self-loop chain which causes infinite loop. With
> this patch, lock()/unlock() are introduce to avoid such a situation.
> 
> Fixes: 474048c26edf ("* sigproc.cc (pending_signals::add): Just index directly into signal array rather than treating the array as a heap.")
> Suggested-by: Corinna Vinschen <corinna@vinschen.de>
> Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/exceptions.cc            | 12 +++++------
>  winsup/cygwin/local_includes/sigproc.h |  2 +-
>  winsup/cygwin/signal.cc                |  4 ++--
>  winsup/cygwin/sigproc.cc               | 28 +++++++++++++++++++++-----
>  4 files changed, 32 insertions(+), 14 deletions(-)

LGTM, please push.


Thanks,
Corinna
