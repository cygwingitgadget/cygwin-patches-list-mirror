Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 584F33858D1E; Mon,  3 Jul 2023 10:39:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 584F33858D1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1688380757;
	bh=V/ImHsjRMIFM2gNzgunGENfEy5iG3b6R5QgV2zHiiWk=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=ytid+nTAma9sDev6f3gOSdcLc2abuP3otw3juFMNAhYxr3cBNInBeyK++cm1MNdxs
	 vAEslYf0oElWWhfwAQTly7WhOC/QToEKmcG7WT59RhqyVUIFikHpVjOjUiiO93EUwg
	 Q47AzDM/Ume9JGbL6HUlrjYGMBsUm+2QHJkjPqIg=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 9562FA8162D; Mon,  3 Jul 2023 12:39:15 +0200 (CEST)
Date: Mon, 3 Jul 2023 12:39:15 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: thread: Reset _my_tls.tid if it's pthread_null
 in init_mainthread().
Message-ID: <ZKKlU2kjMudqsBTw@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230622153008.392-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230622153008.392-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Jun 23 00:30, Takashi Yano wrote:
> Currently, _my_tls.tid is set to pthread_null if pthread::self()
> is called before pthread::init_mainthread(). As a result, pthread::
> init_mainthread() does not set _my_tls.tid appropriately. Due to
> this, pthread_join() fails in LDAP environment if the program is
> the first program which loads cygwin1.dll.
> 
> https://cygwin.com/pipermail/cygwin/2023-June/253792.html
> 
> With this patch, _my_tls.tid is re-initialized in pthread::
> init_mainthread() if it is pthread_null.
> 
> Reported-by: Mümin A. <muminaydin06@gmail.com>
> Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/thread.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
> index 5c1284a93..f614e01c4 100644
> --- a/winsup/cygwin/thread.cc
> +++ b/winsup/cygwin/thread.cc
> @@ -364,7 +364,7 @@ void
>  pthread::init_mainthread ()
>  {
>    pthread *thread = _my_tls.tid;
> -  if (!thread)
> +  if (!thread || thread == pthread_null::get_null_pthread ())
>      {
>        thread = new pthread ();
>        if (!thread)
> -- 
> 2.39.0

LGTM.


Thanks,
Corinna
