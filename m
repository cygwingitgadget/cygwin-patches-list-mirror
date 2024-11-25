Return-Path: <SRS0=SJZz=SU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id 720BA3858D29
	for <cygwin-patches@cygwin.com>; Mon, 25 Nov 2024 13:15:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 720BA3858D29
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 720BA3858D29
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732540547; cv=none;
	b=VImlAUdl4gK08PgeyUKM4Y26zOvlJMIoDI6OQvG+B1wvweczDkt8e2yqNTGgetn3yKXxdnnA5L2n6WfRL6xFxXRyzCidu92ioKJ8E0QOOY9v5eZHQ8+VQ0AXcNwqYm8zvUp17hyCX6SwbLWOD5Of6sRXCNxUOXr26xr1hw3meLs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732540547; c=relaxed/simple;
	bh=SVOWo1YELeL2/vf98e9lf8M3RgKCKfVxdjApdwLHjj0=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=e8muko2i0G0jwISC5TnxmyAnqkhp3k6CCNVJfO9gatpjLHlNTYKBPeMQwfoD8g6bqOG7xbb3NHIvrh3cb6lFj0jn8jcn5M/+XmwzwPebknVItikZuMOTTkGe4LcCc7X8VOUK2L1Qg9WI5GKgNTcE+FoGYLAXStNZkgB+NnPj4ig=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 720BA3858D29
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=PsDiydLr
Received: from HP-Z230 by mta-snd-w09.mail.nifty.com with ESMTP
          id <20241125131544405.FSPL.107569.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 25 Nov 2024 22:15:44 +0900
Date: Mon, 25 Nov 2024 22:15:43 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/6] Cygwin: signal: Optimize the priority of the sig
 thread
Message-Id: <20241125221543.44cec7af64e02490b0e9ca9e@nifty.ne.jp>
In-Reply-To: <20241125121632.1822-5-takashi.yano@nifty.ne.jp>
References: <20241125121632.1822-1-takashi.yano@nifty.ne.jp>
	<20241125121632.1822-5-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1732540544;
 bh=JFPZfmcDye77rOf0aoxFDh4NbZFlHFJkpd3T+LTBQtA=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=PsDiydLrUv7nQrd0NdMOt1ZqcDWEz79a3s3QxX/vyfvh+z3Tp7DJFA5DT4H8MRsD1l9HSDBg
 LModfY8MQSM0oIY2pZ1Y5dV5iKE4JTsSX/Aerl3e1kkiwXzoKtmnwBFw/kakHatc2/ET73Wot6
 y8Av6pGVKQaYC+BTEq7mhPTZqt2yDAlvVo3r07hYZvc/aeQ6DJw0WpgJy+1e2fM7BcBQeCkKIO
 4XIvSVNbFtNpNNczmVtJdN5aEafsyVb3m+dzyRc6yhRnE3Xfv3T8lvFK6UUrmqK0Rz0ZissWlk
 DgIduCdxp/kK3juupJpvSbb/Vx65Uz/hR4su9eakUQ2qop3A==
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 25 Nov 2024 21:16:20 +0900
Takashi Yano wrote:
> Previously, sig thread ran in THREAD_PRIORITY_HIGHEST priority.
> This caused critical delay in signal handling in the main thread
> if the too many signales are received rapidly and CPU is very busy.
> I this case, most of CPU time is allocated to sig thread, so the
> main thread cannot have a chance to handle signals. With this patch,
> the sig thread priority is set to the same priority with main thread
> to avoid such situation. Furthermore, if the signal is alarted to
> the main thread, but main thread does not handle it yet, in order to
> increase the chance to handle it in the main thread, reduce the sig
> thread priority is to THREAD_PRIORITY_LOWEST temporarily.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
> Fixes: 53ad6f1394aa ("(cygthread::cygthread): Use three only arguments for detached threads, and start the thread via QueueUserAPC/async_create.")
> Reported-by: Christian Franke <Christian.Franke@t-online.de>
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/sigproc.cc | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> index 541f90cb7..75a5142fd 100644
> --- a/winsup/cygwin/sigproc.cc
> +++ b/winsup/cygwin/sigproc.cc
> @@ -1327,6 +1327,10 @@ wait_sig (VOID *)
>      {
>        DWORD nb;
>        sigpacket pack = {};
> +      /* Follow to the main thread priority */
> +      int prio = GetThreadPriority (OpenThread (THREAD_QUERY_INFORMATION,
> +						FALSE, _main_tls->thread_id));
> +      SetThreadPriority (GetCurrentThread (), prio);

Oops! I forgot to close thread handle. I will submit v2 patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
