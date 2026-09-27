Return-Path: <SRS0=6sOE=HT=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:27])
	by sourceware.org (Postfix) with ESMTPS id 079CF4BA23C4
	for <cygwin-patches@cygwin.com>; Sun, 27 Sep 2026 13:37:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 079CF4BA23C4
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 079CF4BA23C4
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790516258; cv=none;
	b=FoozbI7Gj6i0SG0lcIFJYnoiS6+3Q/A20rdce5bsmXwXKW4Z2hnuVdAK+GS1Jknxu9/S0L+I1bus5eNzJf0X40VVBd8gXWyAc8cfBdFLah1NOrKXNKmbjM+ZI7EJGeS4wYLEiuuxapiu0TCYhvNJg5MLfN9kX6sGUpPGE6fv4jE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790516258; c=relaxed/simple;
	bh=swBkj7WFl2O58QnyBL3p89CiPrIfvWMAAYM+U3GzG1o=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=TSy4tTla1uZsVOSHyXHntzNlxdNuObazkhCVh8Z7Fhatm/puA/itenOlPGrIMEfeW0eHGdEXw+Oy7zAZhaD6kXeCNI95QL18EQAI40ArR6k8lsuP86d2dm9Nnu8+ALW4zswD+BH4AH98T+TGPZnG2FsNxFYhDyvqMvLJrEBss3w=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=FR0Qy62K
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 079CF4BA23C4
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=FR0Qy62K
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260927133735369.HXCM.17441.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 27 Sep 2026 22:37:35 +0900
Date: Sun, 27 Sep 2026 22:37:32 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v6] Cygwin: console: Improve the performance of
 peek_console
Message-Id: <20260927223732.57fb4c8ae11260a3523738a9@nifty.ne.jp>
In-Reply-To: <20260927132627.1002-1-takashi.yano@nifty.ne.jp>
References: <20260927132627.1002-1-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1790516255;
 bh=U0UB7/rurfmORfO9FruXtDJzj4qcFlFfZKs7Q1Lz3Ko=;
 h=Date:From:To:Subject:In-Reply-To;
 b=FR0Qy62KopDkcDy/slAIcS2l8dzB9WYIsroiYEy9vSg+0ni1dz6O0pzrxDElvPfMQSDXWowt
 e8r7NLUmfffYRbgIybNMmkuyVwzARdRkZwqhcqW2FHkW7vUWRvWJRdspTv3pzoleryEIZgpenL
 rF/hI4QGNalw7dXlGnP0zTM6QtOsHRkBHVNCBQjd7xG0JrfO1rLvhnYHdR9yRYj7K6wPFGEX5U
 2j8fX+d4ZzjJcvoaMXemYHzDOW6ly5Q0cCgM4OglPifhfF7Nn0z8jJnXzmnLkcbCdpPIJUp9tv
 +gSe1G4zgjyN9Vh9jTQISMJef6WgXX4lrGVGUqAGAFFVhYLw==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sun, 27 Sep 2026 22:26:11 +0900
Takashi Yano wrote:
> Previously, peek_console() used PeekConsoleInput() to confirm whether
> the console input buffer has some input records. However, this need
> attaching to the console if the process does not attach to the console.
> To reduce that overhead, this patch uses WaitForSingleObject() with
> console input handle instead. WaitForSingleObject() works without
> attaching to the console, so this simplifies the peek_console()
> code.
> 
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
> v2: Do not remove PeekConsoleInputW() call.
> v3: Revert to v1 and check empty buffer in process_input_message()
> v4: Handle input_empty and input_error returned from process_input_message()
>     properly.
> v5: Set thread_errno rather than errno in peek_console().
> v6: Preserve errno/thread_errno as soon as the error occurs.
> 
>  winsup/cygwin/fhandler/console.cc       | 23 +++++++++++++++++
>  winsup/cygwin/local_includes/fhandler.h |  3 ++-
>  winsup/cygwin/select.cc                 | 33 ++++++++++++++++---------
>  3 files changed, 47 insertions(+), 12 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> index fe15f15fa..bf708ffc3 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -1432,6 +1432,24 @@ wait_retry:
>  	  if (global_sigs[get_ttyp ()->last_sig].sa_flags & SA_RESTART)
>  	    continue;
>  	  goto sig_exit;
> +	case input_empty:
> +	  /* Reaches here when the input buffer is empty even though
> +	     the input handle is signalled. */
> +	  release_input_mutex ();
> +	  if (is_nonblocking ())
> +	    {
> +	      if (copied_chars)
> +		{
> +		  fix_input_mode_if_necessary (); /* for win32_input_mode */
> +		  buflen = copied_chars;
> +		  return;
> +		}
> +	      set_sig_errno (EAGAIN);
> +	      buflen = (size_t) -1;
> +	      return;
> +	    }
> +	  cygwait (40);
> +	  continue;
>  	default:
>  	  /* Should not come here */
>  	  release_input_mutex ();
> @@ -1489,10 +1507,12 @@ fhandler_console::process_input_message (size_t len)
>    DWORD resume_pid = attach_console (con.owner);
>    BOOL r =
>      PeekConsoleInputW (get_handle (), input_rec, INREC_SIZE, &total_read);
> +  DWORD error = GetLastError ();
>    detach_console (resume_pid, con.owner);
>    release_attach_mutex ();
>    if (!r)
>      {
> +      __set_errno_from_win_error (error);
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
         __seterrno_from_win_error (error);

>        termios_printf ("PeekConsoleInput failed, %E");
>        return input_error;
>      }
> @@ -1504,6 +1524,9 @@ fhandler_console::process_input_message (size_t len)
>    if (::input_ready && (len == 0 || (get_ttyp ()->ti.c_lflag & ICANON)))
>      return input_ok;
>  
> +  if (total_read == 0)
> +    return input_empty;
> +
>    for (i = 0; i < total_read; i ++)
>      {
>        DWORD nread = 1;
> diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
> index a86da207b..65e326135 100644
> --- a/winsup/cygwin/local_includes/fhandler.h
> +++ b/winsup/cygwin/local_includes/fhandler.h
> @@ -2193,7 +2193,8 @@ public:
>      input_processing = 0,
>      input_ok = 1,
>      input_signalled = 2,
> -    input_winch = 3
> +    input_winch = 3,
> +    input_empty = 4,
>    };
>    typedef cons_handle_set_t handle_set_t;
>    HANDLE thread_sync_event;
> diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> index e0bd1726f..7c14800fd 100644
> --- a/winsup/cygwin/select.cc
> +++ b/winsup/cygwin/select.cc
> @@ -1149,8 +1149,6 @@ peek_console (select_record *me, bool)
>        return 1;
>      }
>  
> -  INPUT_RECORD irec;
> -  DWORD events_read;
>    HANDLE h;
>    set_handle_or_return_if_not_open (h, me);
>  
> @@ -1161,29 +1159,42 @@ peek_console (select_record *me, bool)
>        else
>  	{
>  	  fh->acquire_input_mutex (mutex_timeout);
> -	  acquire_attach_mutex (mutex_timeout);
> -	  DWORD resume_pid = fh->attach_console (fh->get_owner ());
> -	  BOOL r = PeekConsoleInputW (h, &irec, 1, &events_read);
> -	  fh->detach_console (resume_pid, fh->get_owner ());
> -	  release_attach_mutex ();
> -	  if (!r || !events_read)
> +	  if (WaitForSingleObject (h, 0) != WAIT_OBJECT_0)
>  	    {
>  	      fh->release_input_mutex ();
>  	      break;
>  	    }
>  	}
>        fhandler_console::input_states ret = fh->process_input_message (0);
> +      if (ret == fhandler_console::input_error)
> +	me->thread_errno = get_errno ();
>        fh->release_input_mutex ();
>        fh->fix_input_mode_if_necessary (); /* for win32_input_mode */
>  
> -      if (ret == fhandler_console::input_winch
> -	  && global_sigs[SIGWINCH].sa_handler != SIG_IGN
> -	  && global_sigs[SIGWINCH].sa_handler != SIG_DFL)
> +      switch (ret)
>  	{
> +	case fhandler_console::input_processing:
> +	case fhandler_console::input_ok:
> +	  break;
> +	case fhandler_console::input_winch:
> +	  if (global_sigs[SIGWINCH].sa_handler != SIG_IGN
> +	      && global_sigs[SIGWINCH].sa_handler != SIG_DFL)
> +	    {
> +	      set_sig_errno (EINTR);
> +	      return -1;
> +	    }
> +	  break;
> +	case fhandler_console::input_signalled:
>  	  set_sig_errno (EINTR);
>  	  return -1;
> +	case fhandler_console::input_error:
> +	  /* thread_errno is already set */
> +	  return -1;
> +	case fhandler_console::input_empty:
> +	  goto out;
>  	}
>      }
> +out:
>    if (fh->input_ready () || fh->get_cons_readahead_valid ())
>      return me->read_ready = true;
>  
> -- 
> 2.51.0
> 


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
