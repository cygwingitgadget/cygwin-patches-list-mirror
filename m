Return-Path: <SRS0=W9aS=UN=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id EFED23858D28
	for <cygwin-patches@cygwin.com>; Tue, 21 Jan 2025 21:20:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EFED23858D28
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EFED23858D28
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737494447; cv=none;
	b=RHNuvX04IJ6qt9CMDf2YPkfB9CLob7muu8RLbrGB8GSi+TO+PODesLAo7Rgw5nkw+xyFEmMN0LuXrNT+7DfuDMz6o5QZJDXy4DjFiJN7V6iZrVxucIeEYCci2DdeRm6Pq8EiJ6DmpHwIs4DiFD/F6mOCAqEpujbptXJlssiqGd4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737494447; c=relaxed/simple;
	bh=TQB+KlKU3g8qgPhQt1GUAUZ6uEyGcJpont5rou+/9V8=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=W2bEPcUx2u9r4OEWt+cVMdJcnlkLrsVaojpKmoGZkNsI8jlUiWWG0K+5+Bs+0kc878P5uCsZJSyqECMXkDGvTye+JDc3+3nYMIsEHHSgPmgD0Y4AiFT3UBe2pIuVHp6vik3H9wLFuT4HBMp4EYheQZmrKoX78QmGefjyTMw7oPY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EFED23858D28
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=LyWwfi/W
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 9737E45C77;
	Tue, 21 Jan 2025 16:20:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=uJa2P+VEv3h+JYWXy40J+wIMgFA=; b=LyWwf
	i/W8qnJMgmjRY1IUwpgIGUGC/zkQfoRz6+PmbZZuMR4VuIc/d15kXx0Bc1bfi9SU
	L62OovNFdkO2BAlb5J74OYuMP515ep4lGbBm1S+ULKNkuH6BCDLlY7Mm7pf39CYd
	sd0CWhZJ3mYOZHmvKl6ZJw/tOLEND/v8bBwcMI=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 8FB7445C72;
	Tue, 21 Jan 2025 16:20:46 -0500 (EST)
Date: Tue, 21 Jan 2025 13:20:46 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: signal: Avoid frequent TLS lock/unlock for
 SIGCONT processing
In-Reply-To: <20250120142316.3606760-1-takashi.yano@nifty.ne.jp>
Message-ID: <9223d8f6-bc85-a2cb-d1d3-9517041f0034@jdrake.com>
References: <20250120142316.3606760-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

dscho hooked me up with a workflow to run Git for Windows' test suite on
an msys2-runtime pull request's CI artifacts. With this patch and the
three you pushed (reverting the v2 patch we had applied already, and
applying the two from the cygwin-3_5-branch), the test suite no longer
hangs.


On Mon, 20 Jan 2025, Takashi Yano wrote:

> It seems that current _cygtls::handle_SIGCONT() code sometimes falls
> into a deadlock due to frequent TLS lock/unlock operation in the
> yield() loop. With this patch, the yield() in the wait loop is placed
> outside the TLS lock to avoid frequent TLS lock/unlock.
>
> Fixes: 9ae51bcc51a7 ("Cygwin: signal: Fix another deadlock between main and sig thread")
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/exceptions.cc           | 36 ++++++++++-----------------
>  winsup/cygwin/local_includes/cygtls.h |  4 +--
>  2 files changed, 15 insertions(+), 25 deletions(-)
>
> diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
> index 4dc4be278..f576c5ff2 100644
> --- a/winsup/cygwin/exceptions.cc
> +++ b/winsup/cygwin/exceptions.cc
> @@ -1420,7 +1420,7 @@ api_fatal_debug ()
>
>  /* Attempt to carefully handle SIGCONT when we are stopped. */
>  void
> -_cygtls::handle_SIGCONT (threadlist_t * &tl_entry)
> +_cygtls::handle_SIGCONT ()
>  {
>    if (NOTSTATE (myself, PID_STOPPED))
>      return;
> @@ -1431,23 +1431,17 @@ _cygtls::handle_SIGCONT (threadlist_t * &tl_entry)
>       Make sure that any pending signal is handled before trying to
>       send a new one.  Then make sure that SIGCONT has been recognized
>       before exiting the loop.  */
> -  bool sigsent = false;
> -  while (1)
> -    if (current_sig)	/* Assume that it's ok to just test sig outside of a
> -			   lock since setup_handler does it this way.  */
> -      {
> -	cygheap->unlock_tls (tl_entry);
> -	yield ();	/* Attempt to schedule another thread.  */
> -	tl_entry = cygheap->find_tls (_main_tls);
> -      }
> -    else if (sigsent)
> -      break;		/* SIGCONT has been recognized by other thread */
> -    else
> -      {
> -	current_sig = SIGCONT;
> -	set_signal_arrived (); /* alert sig_handle_tty_stop */
> -	sigsent = true;
> -      }
> +  while (current_sig)  /* Assume that it's ok to just test sig outside of a */
> +    yield ();          /* lock since setup_handler does it this way.  */
> +
> +  lock ();
> +  current_sig = SIGCONT;
> +  set_signal_arrived (); /* alert sig_handle_tty_stop */
> +  unlock ();
> +
> +  while (current_sig == SIGCONT)
> +    yield ();
> +
>    /* Clear pending stop signals */
>    sig_clear (SIGSTOP, false);
>    sig_clear (SIGTSTP, false);
> @@ -1479,11 +1473,7 @@ sigpacket::process ()
>    myself->rusage_self.ru_nsignals++;
>
>    if (si.si_signo == SIGCONT)
> -    {
> -      tl_entry = cygheap->find_tls (_main_tls);
> -      _main_tls->handle_SIGCONT (tl_entry);
> -      cygheap->unlock_tls (tl_entry);
> -    }
> +    _main_tls->handle_SIGCONT ();
>
>    /* SIGKILL is special.  It always goes through.  */
>    if (si.si_signo == SIGKILL)
> diff --git a/winsup/cygwin/local_includes/cygtls.h b/winsup/cygwin/local_includes/cygtls.h
> index 2d490646a..e0de712f4 100644
> --- a/winsup/cygwin/local_includes/cygtls.h
> +++ b/winsup/cygwin/local_includes/cygtls.h
> @@ -194,7 +194,7 @@ public: /* Do NOT remove this public: line, it's a marker for gentls_offsets. */
>    class cygthread *_ctinfo;
>    class san *andreas;
>    waitq wq;
> -  int current_sig;
> +  volatile int current_sig;
>    unsigned incyg;
>    volatile unsigned stacklock;
>    __tlsstack_t *stackptr;
> @@ -274,7 +274,7 @@ public: /* Do NOT remove this public: line, it's a marker for gentls_offsets. */
>    {
>      will_wait_for_signal = false;
>    }
> -  void handle_SIGCONT (threadlist_t * &);
> +  void handle_SIGCONT ();
>    static void cleanup_early(struct _reent *);
>  private:
>    void call2 (DWORD (*) (void *, void *), void *, void *);
>

-- 
Krogt, n. (chemical symbol: Kr):
	The metallic silver coating found on fast-food game cards.
		-- Rich Hall, "Sniglets"
