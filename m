Return-Path: <SRS0=MN9U=YW=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.227.181])
	by sourceware.org (Postfix) with ESMTPS id EE9AB3858D26
	for <cygwin-patches@cygwin.com>; Sat,  7 Jun 2025 09:23:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EE9AB3858D26
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EE9AB3858D26
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.181
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1749288223; cv=none;
	b=FYZuI2UZ1ZP2Bz7JMI9V9mwd+QC58YjwsYfH77sgvI6emz/XETD6KUKfkYOBAiXe99c4ox1mk9mRCADW3NYA5jRercsElzemZ9P5aQg/AxEOnkihebe9jWDWkS/GUPHnE7uzQ3x3AuUlxqxDFAwj4ho+5TEBZzZXBV/jaGJyD04=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1749288223; c=relaxed/simple;
	bh=ZV6gsfLWtz0XdNC/6HS+t30iZz2A0Eszo9Nih/cemfA=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=L36t0iSQRHSV4AQtyxiunXiN+chy1NEsE7rt0EAJBfPChPo//NyU/D0Yz2UMjoM8Qvb0vlZTyTOy0UtZ3Uo8scWQP82Ya2u6CDwxzn+cUCX12VDp9uHWHiKOni4a7urSfAvpVbhCWuoHsa1gCF0FVXC/mqrqHnP7d2oXAs4N0Zk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EE9AB3858D26
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=W5r3+HBn
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20250607092341302.ZXZI.36235.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sat, 7 Jun 2025 18:23:41 +0900
Date: Sat, 7 Jun 2025 18:23:40 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: signal: Set _cygtls::sigmask earlier
Message-Id: <20250607182340.aa027342f23d7f9d0985b62c@nifty.ne.jp>
In-Reply-To: <20250531011630.1500-1-takashi.yano@nifty.ne.jp>
References: <20250531011630.1500-1-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1749288221;
 bh=d5Ed6R4mVgd+Z/GfbWVxLEbnn1fbUSf/28eDmmicSaI=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=W5r3+HBnXYrN2nZ43lyXQGyNgQQPpJkc4ZunAoFp4kiUp/pv4ghVHKYv27i+HKNg9j501cp0
 G6oBUZxgkuj5fVXqb7EM+nE0yAafFkEEHMcFanOBiOVRu6DU8lIFJoPgkMrJCzErXTNj68rjCS
 eYoDpNZqILiiQETcZO9Zqfziuhw0EtxoIW5eITb9C2hyjZY41HvP6HqV3K3kZ6fZgDTNdmgX7L
 +K659P4o+SA6sN/x59IrCfH5hgHf4QLar0d3FuXkOXW1cjesns2elxAyhYl+xFRoqinMQUVCLQ
 ZmeCgHf7/rQl4tul1bYl20FSEEku/6q6cglL6des5TfyeMYA==
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 31 May 2025 10:16:22 +0900
Takashi Yano wrote:
> Currently, _cygtls::sigmask is set in call_signal_handler(), but this
> is too late to effectively prevent a masked signal from being armed. 
> With this patch, sigmask is set in _cygtls::interrupt_setup() instead.
> 
> Fixes: 0d675c5d7f24 ("* exceptions.cc (interrupt_setup): Don't set signal mask here or races occur with main thread.  Set it in sigdelayed instead.")
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/exceptions.cc | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
> index bcc7fe6f8..688297d76 100644
> --- a/winsup/cygwin/exceptions.cc
> +++ b/winsup/cygwin/exceptions.cc
> @@ -980,7 +980,8 @@ void
>  _cygtls::interrupt_setup (siginfo_t& si, void *handler, struct sigaction& siga)
>  {
>    push ((__tlsstack_t) sigdelayed);
> -  deltamask = siga.sa_mask & ~SIG_NONMASKABLE;
> +  oldmask = sigmask;
> +  sigmask = (sigmask | siga.sa_mask) & ~SIG_NONMASKABLE;
>    sa_flags = siga.sa_flags;
>    func = (void (*) (int, siginfo_t *, void *)) handler;
>    if (siga.sa_flags & SA_RESETHAND)
> @@ -1721,7 +1722,7 @@ _cygtls::call_signal_handler ()
>        debug_only_printf ("dealing with signal %d", current_sig);
>        this_sa_flags = sa_flags;
>  
> -      sigset_t this_oldmask = set_process_mask_delta ();
> +      sigset_t this_oldmask = _my_tls.oldmask;
>  
>        if (infodata.si_code == SI_TIMER)
>  	{
> -- 
> 2.45.1

I'd withdraw this patch because this patch seems to cause a race
issue as mensioned in the commit message of the commit 0d675c5d7f24.

Instead, I would like to propose another patch for the sema purpose.
https://cygwin.com/pipermail/cygwin-patches/2025q2/013749.html

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
