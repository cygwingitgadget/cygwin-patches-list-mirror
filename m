Return-Path: <SRS0=gTvi=B3=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 8DF454BA2E11
	for <cygwin-patches@cygwin.com>; Fri, 27 Mar 2026 13:36:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8DF454BA2E11
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8DF454BA2E11
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774618600; cv=none;
	b=drVPShdAb7vyoLQb+5TfnPlMKDLL4QfPM0qKNm2/0slekw/oLQINFtSLIObhJURuWZuOJ2ABHOpZO9UZhruklCIK7AuhGEsfAaSgaBMD8EO3VpLXI6XqUC8Hnv5wKEXQMsjufKn6BLBo2I+vXeaQdUUxjyfMD0VPTDb0frUOdIY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774618600; c=relaxed/simple;
	bh=DOPx+4RbOB9V5p09qcDHoY9qfcZnRzycLGs67WBG4NY=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=LsuLyjRr9+Csg+XdN63o6hjHRm8waYzVwYznUJ/drhKjj8eyO8ULX0k+HR/MsGWAtNoDE+ZZ55LsC/WJWbw7jPbnohN48Wk/WXM766oWbpgay67LWmchVLe3+DIwDuNau7t5zLfouYn1h4Swz/omOjw5qGUD9ps/u/0CSXmgZBY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8DF454BA2E11
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=oR45XeRC
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260327133637505.OJFZ.36235.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 27 Mar 2026 22:36:37 +0900
Date: Fri, 27 Mar 2026 22:36:35 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v7 2/7] Cygwin: pty: Add workaround for handling of
 backspace when pcon enabled
Message-Id: <20260327223635.fa61aa2266ede114203bd457@nifty.ne.jp>
In-Reply-To: <20260325130453.62246-3-takashi.yano@nifty.ne.jp>
References: <20260321113613.9443-1-takashi.yano@nifty.ne.jp>
	<20260325130453.62246-1-takashi.yano@nifty.ne.jp>
	<20260325130453.62246-3-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774618597;
 bh=lrxXyBPHGom8/tok1Aobd595EwdGtoJ2GuosDL0Cbe0=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=oR45XeRCAWBw+m2URjJuUlDiW5B7ZRtV2/AHkI3wkHFp9MizRzkwbGfrUleSYOfFm7nWLD79
 DNhs435IEUpJ7M8xMaXEnEjhXsx3mgLs8pJPtbcjRgWfupx2wj1/DLHEtRtl6WsIXEO1iXzCKS
 xjDjX4oS+q+ehTYJK+KXxOQJtjLXyi56LKaAaEXM7mz7QmdvYYUHO73R9B7kKiGjMvH/A8Z0pY
 dWqYsXaZ3sbPgPHNC0Bg4ZMbjEm7vvfs11FjlyJ0NgWP/kTpjhoFxqEUu491SNOrGYz9WejFTX
 ySnlhoH2YihWaVlZUjYt3gG4htKLAFk5WVw+dAoWOVu2JSQA==
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 25 Mar 2026 22:04:08 +0900
Takashi Yano wrote:
> In Windows 11, pseudo console has a weird behaviour that the Ctrl-H
> is translated into Ctrl-Backspace (not Backspace). Similary, Backspace
> (0x7f) is translated into Ctrl-H. Due to this behaviour, inrec_eq()
> in cons_master_thread() fails to compare backspace/Ctrl-H events in
> the input record sequence. This patch is a workaround for the issue
> that replaces Ctrl-H with backspace (0x7f), which will be translated
> into Ctrl-H in pseudo console.
> 
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
>  winsup/cygwin/fhandler/console.cc | 12 ++++++-
>  winsup/cygwin/fhandler/pty.cc     | 57 ++++++++++++++++++++++++++-----
>  2 files changed, 60 insertions(+), 9 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> index 2f59f8f24..9678775d1 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -318,6 +318,16 @@ inrec_eq (const INPUT_RECORD *a, const INPUT_RECORD *b, DWORD n)
>  	     written event. Therefore they are ignored. */
>  	  const KEY_EVENT_RECORD *ak = &a[i].Event.KeyEvent;
>  	  const KEY_EVENT_RECORD *bk = &b[i].Event.KeyEvent;
> +	  WCHAR c1 = ak->uChar.UnicodeChar;
> +	  WCHAR c2 = bk->uChar.UnicodeChar;
> +	  if (inside_pcon)
> +	    {
> +	      /* Workaround for pseudo console in Windows 11 */
> +	      if (c1 == 8) /* Ctrl-H */
> +		c1 = 127; /* Backspace */
> +	      if (c2 == 8) /* Ctrl-H */
> +		c2 = 127; /* Backspace */
> +	    }
>  	  /* Fixup repeat count */
>  	  WORD r1 = ak->wRepeatCount;
>  	  WORD r2 = bk->wRepeatCount;
> @@ -326,7 +336,7 @@ inrec_eq (const INPUT_RECORD *a, const INPUT_RECORD *b, DWORD n)
>  	  if (r2 == 0)
>  	    r2 = 1;
>  	  if (ak->bKeyDown != bk->bKeyDown
> -	      || ak->uChar.UnicodeChar != bk->uChar.UnicodeChar
> +	      || c1 != c2
>  	      || r1 != r2)
>  	    return false;
>  	}
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> index 371e67103..72a8ba140 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -2266,28 +2266,65 @@ fhandler_pty_master::write (const void *ptr, size_t len)
>      { /* Reaches here when non-cygwin app is foreground and pseudo console
>  	 is activated. */
>        tmp_pathbuf tp;
> -      char *buf = (char *) ptr;
> +      char *buf = tp.c_get ();
>        size_t nlen = len;
>        if (get_ttyp ()->term_code_page != CP_UTF8)
>  	{
>  	  static mbstate_t mbp;
> -	  buf = tp.c_get ();
>  	  nlen = NT_MAX_PATH;
>  	  convert_mb_str (CP_UTF8, buf, &nlen,
>  			  get_ttyp ()->term_code_page, (const char *) ptr, len,
>  			  &mbp);
>  	}
> +      else
> +	memcpy (buf, ptr, nlen);
> +
> +      /* Retrieve console mode */
> +      HANDLE h_pcon_in = get_ttyp ()->h_pcon_in;
> +      DWORD cons_mode;
> +      if (!nat_pipe_owner_self (get_ttyp ()->nat_pipe_owner_pid))
> +	{
> +	  HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
> +					   get_ttyp ()->nat_pipe_owner_pid);
> +	  DuplicateHandle (pcon_owner, h_pcon_in,
> +			   GetCurrentProcess (), &h_pcon_in,
> +			   0, FALSE, DUPLICATE_SAME_ACCESS);
> +	  CloseHandle(pcon_owner);
> +	  DWORD resume_pid =
> +	    attach_console_temporarily (get_ttyp()->nat_pipe_owner_pid);
> +	  GetConsoleMode (h_pcon_in, &cons_mode);
> +	  resume_from_temporarily_attach (resume_pid);
> +	  CloseHandle (h_pcon_in);
> +	}
> +      else
> +	GetConsoleMode (h_pcon_in, &cons_mode);
>  
> -      for (size_t i = 0; i < nlen; i++)
> +      for (size_t i = 0, j = 0; i < nlen; i++)

This patch should fixed as follows:

-      for (size_t i = 0; i < nlen; i++)
+      len = nlen
+      for (size_t i = 0, j = 0; i < len; i++)

Sorry.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
