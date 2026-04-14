Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 03CF64BA2E07; Tue, 14 Apr 2026 08:28:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 03CF64BA2E07
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1776155288;
	bh=ldfCz4W4CaB76cCywBElnSHvShSM24QAF9NedjZFUL4=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=G7fWkywbN0sJ4xjr2nmVU5JPUl7h6BxpKbtGdCPm+SFO5SjSftYN1NmMLf+OSN2xG
	 OSeqvSdyMP2QtXyQjXk9wQkwS+ILVLKkBN+V/wYff/yIikXpZ2pL5bj31CFwuMLJNa
	 eS/3DIY1FWl/0Bt95BY4Ez2m+j+4Xv+LzFPVs3ZE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 1AB65A80897; Tue, 14 Apr 2026 10:28:06 +0200 (CEST)
Date: Tue, 14 Apr 2026 10:28:06 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Add missing DeleteProcThreadAttributeList()
 call
Message-ID: <ad36ltx5N8HtFQcb@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20260407103022.1380-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260407103022.1380-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Apr  7 19:30, Takashi Yano wrote:
> Currently, the cleanup path of setup_pseudoconsole() is missing
> DeleteProcThreadAttributeList() call, while microsoft's document
> requires that and the normal path has it.
> https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-initializeprocthreadattributelist
> 
> This patch adds DeleteProcThreadAttributeList() call to the cleanup
> path.
> 
> Fixes: bb4285206207 ("Cygwin: pty: Implement new pseudo console support.")
> Suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/fhandler/pty.cc | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> index e9191aaad..cdfb363c9 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -3730,7 +3730,7 @@ fhandler_pty_slave::setup_pseudoconsole ()
>  				      PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE,
>  				      hpcon, sizeof (hpcon), NULL, NULL))
>  
> -	goto cleanup_heap;
> +	goto cleanup_proc_thread_attr;
>  
>        hello = CreateEvent (&sec_none, true, false, NULL);
>        goodbye = CreateEvent (&sec_none, true, false, NULL);
> @@ -3899,6 +3899,8 @@ skip_close_hello:
>    CloseHandle (goodbye);
>    CloseHandle (hr);
>    CloseHandle (hw);
> +cleanup_proc_thread_attr:
> +  DeleteProcThreadAttributeList (si.lpAttributeList);
>  cleanup_heap:
>    HeapFree (GetProcessHeap (), 0, si.lpAttributeList);
>  cleanup_pseudo_console:
> -- 
> 2.51.0

LGTM


Thanks,
Corinna
