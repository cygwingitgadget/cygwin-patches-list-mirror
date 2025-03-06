Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 495913858D26; Thu,  6 Mar 2025 11:12:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 495913858D26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1741259564;
	bh=ah6DR/Kn80FLUCnXl3OzALdLpSiwtI7IzbFgtx5Quc4=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=iuK32GUsxP2l2av6Y2MdYOw0Fp9mPQzceFC9D3TeFsSNmoh94waWJULQxP7VBst4y
	 E/LL1JYOwsnxlL1t9lv0raVOZ0v7MxSB74XceI35thgBQ7aBAGfMHC3KTORcnn//uJ
	 KTFMGekDkm5M50MxizsRpTlOpFkHhwAXMYAweuE0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id F26B9A804BD; Thu, 06 Mar 2025 12:12:41 +0100 (CET)
Date: Thu, 6 Mar 2025 12:12:41 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: signal: Add one more guard to stop signal
 handling on exit().
Message-ID: <Z8mDKd2vqPJX2BX5@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250306110243.1233681-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250306110243.1233681-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Mar  6 20:02, Takashi Yano wrote:
> The commit 3c1308ed890e adds a guard to stop signal handling on exit()
> in call_signal_handler(). However, the signal that is already queued
> but does not use signal handler may be going to process even with that
> patch.
> This patch add one more guard at the begining of sigpacket::process()
> to avoid that situation.
> 
> Fixes: 3c1308ed890e ("Cygwin: signal: Fix a problem that process hangs on exit")
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/exceptions.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
> index 759f89dca..a67529b19 100644
> --- a/winsup/cygwin/exceptions.cc
> +++ b/winsup/cygwin/exceptions.cc
> @@ -1457,7 +1457,7 @@ sigpacket::process ()
>  
>    /* Don't try to send signals if we're just starting up since signal masks
>       may not be available.  */
> -  if (!cygwin_finished_initializing)
> +  if (!cygwin_finished_initializing || ext_state > ES_EXIT_STARTING)
>      {
>        rc = -1;
>        goto done;
> -- 
> 2.45.1

Makes sense, please push.


Corinna
