Return-Path: <SRS0=CxYQ=HH=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.227.117])
	by sourceware.org (Postfix) with ESMTPS id D3C7B4BA79AE
	for <cygwin-patches@cygwin.com>; Tue, 15 Sep 2026 08:53:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D3C7B4BA79AE
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D3C7B4BA79AE
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.117
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789462412; cv=none;
	b=vgg6g1uVLtsXD7QFhKVnyc5J7ti0DyqmwDjYHgFtPDbhoR3T2VX2nTTBgEl9qjB471dAGfr9yZ+ygLqHiQk2GGBXPuQ2Kn0Pi7O/3b28OZy/WsHC+mZ1MShuoo7aQ+SeoZGCFMrHM01c2c+DN2QPjQTdIx0lVLSJi0MJAXOm2Y0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789462412; c=relaxed/simple;
	bh=DiL40UlxeEYs+L/OVXjABakJhkiKxPZw7xrv7kWJE90=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=ol4nqSXhHn4o+gGqdoE0kabVhOacamVZ7KVgixqq6VslxGn43EL/PT4z0+2iTL7EFVAhj3MEB3RqeS5UIjput6jszsUIwSE+g44ccBPRZi2FBrYkhpdt87dVua1m5OtdiZftk2Ap4MBBvNsDOL4onTw5GqSbmGgkpKqyiLH+NvU=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=S1yVmPSi
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D3C7B4BA79AE
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=S1yVmPSi
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260915085326060.KGHA.102121.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 15 Sep 2026 17:53:26 +0900
Date: Tue, 15 Sep 2026 17:53:26 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v16] Cygwin: console: Fix undesired mode change at exit
 of non-cygwin apps
Message-Id: <20260915175326.95369fe7bfc5f1f587e5456d@nifty.ne.jp>
In-Reply-To: <20260915075713.726-1-takashi.yano@nifty.ne.jp>
References: <20260915075713.726-1-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1789462406;
 bh=2nXU24emQ+3stAlKB+FSB77AmZGu40gEv3AlqQ00ynk=;
 h=Date:From:To:Subject:In-Reply-To;
 b=S1yVmPSiFiyrQsx3Kvbx1MpoPFQdAI46FRW01lSOJnttOxVmTzYFGcpDRLKRkRofzqgzSGUm
 ffoUSksAkl+RRlOfJIPk4qUia+Zyxo6DcgiIEAQJN+vYqzQHTRdYizCg/q4GFIeMdZjMcZCHYd
 B6cWgUao7AWcASwCZeOoCzUHh/kNiwRFm7IVBrGQjl6R4VFUGpU/uBnz6uvq5CCCNJugJAvnnI
 A8AVKR4rMD3E4j4VXMAGqnQr3SGNEJfF7CRUqsG+/mRI7Dd57V9uVM53bIvZBm7KmtO74jfFDY
 Bmueiv5v+7REv9SVMrvDaVNNf1nP1+6OA5xqj4jJGc9kJVbA==
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 15 Sep 2026 16:57:04 +0900
Takashi Yano wrote:
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> index be41bf3a2..5de74a6a6 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -443,6 +443,11 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
>  	  cygwait (40);
>  	  continue;
>  	}
> +      if (con.need_win32_input_mode_fix)
> +	{
> +	  cygwait (40);
> +	  continue;
> +	}
>  
>        acquire_attach_mutex (mutex_timeout);
>        GetNumberOfConsoleInputEvents (p->input_handle, &total_read);
> @@ -841,6 +846,8 @@ fhandler_console::setup ()
>        con.num_processed = 0;
>        con.curr_input_mode = tty::restore;
>        con.curr_output_mode = tty::restore;
> +      con.need_win32_input_mode_fix = false;
> +      con.is_processed_input = false;
>      }
>  }
>  
> @@ -877,6 +884,44 @@ fhandler_console::rabuflen ()
>  static DWORD prev_input_mode_backup;
>  static DWORD prev_output_mode_backup;
>  
> +/* Even under cons_mode_mutex, only need_win32_input_mode_fix can be
> +   modified by another thread. This function sets or clears the
> +   ENABLE_PROCESSED_INPUT flag to reflect the current value of
> +   need_win32_input_mode_fix. */
> +void
> +fhandler_console::fix_input_mode_if_necessary ()
> +{
> +  WaitForSingleObject (cons_mode_mutex, mutex_timeout);
> +  if (con.curr_con_mode != tty::cygwin)
             ^^^^^^^^^^^^^ curr_input_mode

> +    {
> +      ReleaseMutex (cons_mode_mutex);
> +      return;
> +    }
> +  bool need_processed_input =
> +    con.master_thread_suspended || con.disable_master_thread
> +    || con.need_win32_input_mode_fix;
> +  if (need_processed_input == con.is_processed_input)
> +    {
> +      ReleaseMutex (cons_mode_mutex);
> +      return;
> +    }
> +  WaitForSingleObject (input_mutex, mutex_timeout);
> +  acquire_attach_mutex (mutex_timeout);
> +  DWORD resume_pid = attach_console (con.owner);
> +  DWORD flags;
> +  GetConsoleMode (get_handle (), &flags);
> +  if (need_processed_input)
> +    flags |= ENABLE_PROCESSED_INPUT;
> +  else
> +    flags &= ~ENABLE_PROCESSED_INPUT;
> +  con.is_processed_input = need_processed_input;
> +  SetConsoleMode (get_handle (), flags);
> +  detach_console (resume_pid, con.owner);
> +  release_attach_mutex ();
> +  ReleaseMutex (input_mutex);
> +  ReleaseMutex (cons_mode_mutex);
> +}
> +
>  /* The function set_{in,out}put_mode() should be static so that they
>     can be called even after the fhandler_console instance is deleted. */
>  void

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
