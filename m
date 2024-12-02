Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 4B9923858417; Mon,  2 Dec 2024 15:20:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4B9923858417
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1733152841;
	bh=1H/H4M3tStJUwz6GXwDfP/c8Q10OlbghnBjkQ1aW5/A=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=uXvJHpIy8E3NhBjC5A13HTwg7X6tFefBAqtaOAtt6eMhhOoHNewCj8WMyPhiB1/44
	 rpdYMYeG71a7knIgZxUPMTVBQ4L5Sal8R6vpcavGM/N/OCBX4d2K8crPXHe5nooJDe
	 OMUkekOBanBYRTjNxjTKZP/h67Vvy4ucaZRsfeGg=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 45EE7A80BC2; Mon,  2 Dec 2024 16:20:39 +0100 (CET)
Date: Mon, 2 Dec 2024 16:20:39 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 6/9] Cygwin: cygtls: Prompt system to switch tasks
 explicitly in lock()
Message-ID: <Z03QRzM62josjo37@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241129120007.14516-1-takashi.yano@nifty.ne.jp>
 <20241129120007.14516-2-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241129120007.14516-2-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Nov 29 20:59, Takashi Yano wrote:
> This patch calls Sleep(0) in the wait loop in lock() to increase the
> chance of being unlocked in other threads. The lock(), unlock() and
> locked() are moved from sigfe.s to cygtls.h so that allows inline
> expansion.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
> Fixes: 61522196c715 ("* Merge in cygwin-64bit-branch.")
> Reported-by: Christian Franke <Christian.Franke@t-online.de>
> Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/local_includes/cygtls.h | 17 ++++++++++---
>  winsup/cygwin/scripts/gendef          | 36 ---------------------------
>  2 files changed, 13 insertions(+), 40 deletions(-)
> 
> diff --git a/winsup/cygwin/local_includes/cygtls.h b/winsup/cygwin/local_includes/cygtls.h
> index e5a377d6b..57a0ec042 100644
> --- a/winsup/cygwin/local_includes/cygtls.h
> +++ b/winsup/cygwin/local_includes/cygtls.h
> @@ -197,7 +197,7 @@ public: /* Do NOT remove this public: line, it's a marker for gentls_offsets. */
>    int current_sig;
>    unsigned incyg;
>    unsigned spinning;
> -  unsigned stacklock;
> +  volatile unsigned stacklock;
>    __tlsstack_t *stackptr;
>    __tlsstack_t stack[TLS_STACK_SIZE];
>    unsigned initialized;
> @@ -225,9 +225,18 @@ public: /* Do NOT remove this public: line, it's a marker for gentls_offsets. */
>    int call_signal_handler ();
>    void remove_wq (DWORD);
>    void fixup_after_fork ();
> -  void lock ();
> -  void unlock ();
> -  bool locked ();
> +  void lock ()
> +  {
> +    while (InterlockedExchange (&stacklock, 1))
> +      {
> +#ifdef __x86_64__
> +	__asm__ ("pause");

At this point, add an #else / ##error unimplemented for this target

With this, the patch is GTG.  Just push it.


Thanks,
Corinna
