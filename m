Return-Path: <SRS0=Pspn=2F=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w04.mail.nifty.com (mta-snd-w04.mail.nifty.com [106.153.227.36])
	by sourceware.org (Postfix) with ESMTPS id DD94F3858C2F
	for <cygwin-patches@cygwin.com>; Thu, 24 Jul 2025 08:55:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DD94F3858C2F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DD94F3858C2F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753347313; cv=none;
	b=GC29gXMOGzqqMU+ylLnMqw2HgpmYdv10AUQ+Jcvqc40U05WwTLlv6fqNDK1L9GUcMktcZMCErmEsBMTCX7Vq3/YLzfUs2k3E3tmwMeaGCJnL92NYmGR2y0tnKw6tEGNzaRsZ7SiCEY0WB2ybnU33jGM0XjJgrIgTrWjFgayaP+E=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753347313; c=relaxed/simple;
	bh=CREJNBPYuoktDeHmd3YX368Lwyp2BkONBW6StYJU9Cc=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=Bdy+biEoaV19FC0VMpJJRPkeIneYVbD07ilpaDmNv31Dkk+cLjIeOorVTqzuey/AQo+pGhmgpfjnD5WjT9Uz/KEh2/d5SBUm5tEI0XNkveSD7pvpQniWtoKE0zoWyCz0QrFnuuwocqnMwvOmqIt7avSmoGwJGFu0bfcuz53GdPo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DD94F3858C2F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=MUzvyhJa
Received: from HP-Z230 by mta-snd-w04.mail.nifty.com with ESMTP
          id <20250724085511313.TRQV.37487.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 24 Jul 2025 17:55:11 +0900
Date: Thu, 24 Jul 2025 17:55:09 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: dtable: Fix handling of archetype fhandler in
 process_fd
Message-Id: <20250724175509.d89485624f8d8a09a3a47e2c@nifty.ne.jp>
In-Reply-To: <20250724083616.1084-1-takashi.yano@nifty.ne.jp>
References: <20250724083616.1084-1-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1753347311;
 bh=38M7NgeEtgkClHqc380i6gHtFnVeWWZCNIGVhftIhac=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=MUzvyhJa1Zw7B1IptjF812TfeEjq+PaHVxHcFPYYtBX/MQqnb90Ru8WQdmDqn8ZvgdCP+00R
 qV101oz3oxYARs12w4CjhtmaNSOOFrQNsbb9To2RFph9jXpsDj0lRQCLjb4S78g8KaXG0CPLfH
 XU92zYrLCeaVittB/d8W+X7/SFR71i9o1Uo6EAijFydxhw18EOunaoTMw97u/LSdUfksIeG1cn
 r2BWe3oDSKdcxfdXIWArTA3geBiHmtYJoa3Hfy3m3xoMFLKuMzJkK3NuxXSdMsLAKdmml+mXv5
 +OYav9kyoLuhVhvAtc3Gc14JSu3B0Kn0VBa/LaLe3o4rV7Xw==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 24 Jul 2025 17:36:07 +0900
Takashi Yano wrote:
> Previously, process_fd failed to correctly handle fhandlers using an
> archetype. This was due to the missing PATH_OPEN flag in path_conv,
> which caused build_fh_pc() to skip archetype initialization. The
> root cause was a bug where open() did not set the PATH_OPEN flag
> for fhandlers using an archetype.
> 
> This patch introduces a new method, path_conv::set_isopen(), to
> explicitly set the PATH_OPEN flag in path_flags when opening a
> fhandler that uses an archetype.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2025-May/258167.html
> Fixes: 92ddb7429065 ("(build_pc_pc): Use fh_alloc to create. Set name from fh->dev if appropriate. Generate an archetype or point to one here.")
> Reported-by: Christian Franke <Christian.Franke@t-online.de>
> Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/dtable.cc             | 4 ++++
>  winsup/cygwin/local_includes/path.h | 1 +
>  winsup/cygwin/release/3.6.5         | 3 +++
>  3 files changed, 8 insertions(+)
> 
> diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
> index f1832a169..6a99c99f9 100644
> --- a/winsup/cygwin/dtable.cc
> +++ b/winsup/cygwin/dtable.cc
> @@ -674,6 +674,8 @@ build_fh_pc (path_conv& pc)
>  		    fh->archetype->get_handle ());
>        if (!fh->get_name ())
>  	fh->set_name (fh->archetype->dev ().name ());
> +      if (pc.isopen ())
> +	fh->pc.set_isopen ();
>      }
>    else if (cygwin_finished_initializing && !pc.isopen ())
>      fh->set_name (pc);
> @@ -681,6 +683,8 @@ build_fh_pc (path_conv& pc)
>      {
>        if (!fh->get_name ())
>  	fh->set_name (fh->dev ().native ());
> +      if (pc.isopen ())
> +	fh->pc.set_isopen ();
>        fh->archetype = fh->clone ();
>        debug_printf ("created an archetype (%p) for %s(%d/%d)", fh->archetype, fh->get_name (), fh->dev ().get_major (), fh->dev ().get_minor ());
>        fh->archetype->archetype = NULL;
> diff --git a/winsup/cygwin/local_includes/path.h b/winsup/cygwin/local_includes/path.h
> index 1fd542c96..a9ce2c7e4 100644
> --- a/winsup/cygwin/local_includes/path.h
> +++ b/winsup/cygwin/local_includes/path.h
> @@ -244,6 +244,7 @@ class path_conv
>    int isopen () const {return path_flags & PATH_OPEN;}
>    int isctty_capable () const {return path_flags & PATH_CTTY;}
>    int follow_fd_symlink () const {return path_flags & PATH_RESOLVE_PROCFD;}
> +  void set_isopen () {path_flags |= PATH_OPEN;}
>    void set_cygexec (bool isset)
>    {
>      if (isset)

Wait. This does not fix console case.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
