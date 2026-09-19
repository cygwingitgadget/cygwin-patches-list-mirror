Return-Path: <SRS0=6u+c=HL=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id C5E5C4BB1C05
	for <cygwin-patches@cygwin.com>; Sat, 19 Sep 2026 00:49:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C5E5C4BB1C05
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C5E5C4BB1C05
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789778962; cv=none;
	b=a2hXIiiszD6Ixg5fOUxZjoO5AsfmfxP4MKTOABXVREklzAiSACpkDDCXbtedjVebAvNM4J8S7R6EILx/um+NsXVZlyaWyfkhZWXlOwKSHz5av+2efUE5cXZyDeTmaO5qXZlaBt2xLcGpiPziSpHaH28v+GMMswH57Gwz00WH8Fg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789778962; c=relaxed/simple;
	bh=J9D92uVTTI6Gls974GGI94sHGp+2uK6Y/lZeG2x1S3s=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=K3Gaq15LLdsxX5i1DNE5N5QyjhafsNT0fpm9zimc8nMIqLctnuN1OgKrhucSyU1/JvmjFXH9o8I6IjQyK2cLUraXxsZrTWRcNVtQ3TXrDV9we6UZsawfKLJWltMbujhaA3X57ASCbXflTpZklmkdfL7YPZf1tmU/JXaJJur2x4I=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=iQzS66ZQ
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C5E5C4BB1C05
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=iQzS66ZQ
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260919004920055.WLR.102121.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sat, 19 Sep 2026 09:49:20 +0900
Date: Sat, 19 Sep 2026 09:49:18 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v17] Cygwin: console: Fix undesired mode change at exit
 of non-cygwin apps
Message-Id: <20260919094918.322186639aa511571f0aec91@nifty.ne.jp>
In-Reply-To: <19f79ca4-ff3b-6ac7-ceee-b93ff98ebb38@gmx.de>
References: <20260917054034.7668-1-takashi.yano@nifty.ne.jp>
	<19f79ca4-ff3b-6ac7-ceee-b93ff98ebb38@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1789778960;
 bh=dFM0eRNo+8DlCeGcB4RtWuxsvgYAWSQf7mCWT0RCkHY=;
 h=Date:From:To:Subject:In-Reply-To;
 b=iQzS66ZQiIF0iUhjj5Ezz1x/TjMnRJqoiuFHAcmMOxJdCFSc+/jezUNarerFoBxjp2RtPg/N
 P3uCwpTW2SdivUpxi8xAJAkPSe16Cgc1ZUfa8MkvoEaqLGWegPdAN4fneErQFeCWtTU66WTIu8
 fdb+m347ZCAF4J9IW8Fk86yDA7FeaXQFR9De8uKuvLHmm7QX9AzNbhxISsug8xhi9pViEp5URB
 j3nDomNgDwiBbZRpXXxMlVpnFTfW0vhTmjmKNpKy6zqT9qJObQA4FxNVeMlOau/6MceEBclMNl
 +j2+ORrw5wtDdq7gnU7cXLTa/L+NV7OMHTHhHeY8lhiBxJ8g==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

Thanks for the suggestion.

On Fri, 18 Sep 2026 17:26:38 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Thu, 17 Sep 2026, Takashi Yano wrote:
> 
> > Previously, if two non-cygwin apps are started and one of them
> > exits first, the other one lost appropriate console mode, since
> > the first one restored it to tty::cygwin. This patch counts the
> > active console process whose pgid is pgid of the tty and if the
> > result is zero (means the last non-cygwin foreground process),
> > restore console mode. To avoid race issue between apps modifying
> > console mode simultaneously, this patch also introduce a mutex
> > named `cons_mode_mutex`.
> > 
> > Known limitation:
> > In the case of non-overlayed spawn, there still exists a small
> > window in which another non-cygwin process may restore tty::cygwin
> > mode even though new non-cygwin app is about to start.
> > 
> > In addition:
> > Avoid the cleanup/startup deadlock: cleanup can hold `cons_mode_mutex`
> > while waiting for a console master that a new owner cannot start until
> > acquiring that mutex. Startup must precede the mode-mutex wait without
> > changing the handshake or mode serialization.
> > 
> > Fixes: 48285aa36c2c ("Cygwin: console: Fix handling of Ctrl-S in Win7.")
> > Co-authored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > ---
> > v2: Stop counting up/down the counter by itself.
> >     Use num_active_non_cygwin_apps() instead.
> > v3: Guard setup_for_non_cygwin_app() by cons_mode_mutex as well.
> > v4: Guard all mode changes in console by cons_mode_mutex.
> > v5: Fix the issue of mutex acquisition order.
> >     Fix the race window around the process creation.
> >     Improve latency of checking existence of non-cygwin apps.
> >     Handle errors in checking existence of non-cygwin apps.
> > v6: Match the conditions for incrementing and decrementing the counter.
> > v7: Decrement the counter only if it was incremented by myself.
> > v8: Symlify the conditions for incrementing and decrementing the counter
> >     a bit.
> > v9: Minimize the argument of set_non_cygwin_app_setup_ongoing().
> > v10: Set process_state before calling spawn_worker::setup() rather than
> >      using the counter. In addition, resume non-cygwin app before
> > 	 modifying process table. These make things much simpler.
> >      Narrowing the period of acquiring input_mutex in peek_console()
> >      in select.cc.
> > v11: Release output_mutex before calling bg_check() in ioctl().
> >      Suppress unecessary console-mode change attempts.
> > v12: Change handling of disabling master thread in the case of win32
> >      input mode.
> >      Wait for console attaching only when the spawned app is a console
> >      app. In addition, a timeout is introduced to this wait loop for
> >      safety.
> > v13: Do not perform cleanup for non-cygwin apps on the error in
> >      active_non_cygwin_apps_exist().
> >      Handle WAIT_ABANDONED in CSI?9001h/l handling.
> >      Fix ABBA deadlock about echo code path.
> >      Set need_win32_input_mode_fix before set_disable_master_thread()
> >      in CSI?9001h/l handling.
> >      Setting and checking for need_win32_input_mode_fix inside the
> >      input_mutex.
> >      Fix the problem that the flag need_win32_input_mode_fix is set,
> >      but disable_master_thread does not set if another thread holds
> >      cons_mode_mutex.
> > v14: Re-design echo code path. (Introduce raw_write() for doecho())
> >      Re-design the handling of need_win32_input_mode_fix from scratch.
> > v15: Fix possible deadlock with input_mutex regarding doecho()
> > v16: Avoid to overwrite ENABLE_PROCESS_INPUT in tty::native mode.
> >      Call fix_input_mode_if_necessary in TIMEOUT case as well.
> > v17: Three more fixes suggested by Johannes:
> >        (1) Create master thread before the console mode change in
> >            open().
> >        (2) Call fix_input_mode_if_necessary() in the canonical mode
> >            loop in read().
> >        (3) Ack for disable_master_thread = false when
> >            need_win32_input_mode_fix is true.
> 
> Thank you for those changes!
> 
> I still see one concern, though:
> 
> A resize can still bypass a mode change recorded during echo. In canonical
> mode, echo can pass `ESC[?9001h` through `line_edit()`, `doecho()` and
> `raw_write()` to the output parser, setting the protocol flag without
> completing a line. If the same input batch then encounters a window-size
> event, the processor reports `input_winch`, not `input_processing`. With a
> `SIGWINCH` handler that returns without console I/O, `read()` releases
> input protection and returns or retries without reconciliation.
> `peek_console()` likewise has a handled-`SIGWINCH` return before its
> fixup. The Windows input setting can remain unreconciled until another
> console operation. This is an inherited signal-path gap, not the old
> canonical retry defect or an observed v17 hang.
> 
> I'd like to suggest these two fixup! hunks to be squashed in:
> 
> -- snip --
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> index 9ebf65611c..16c3e5270a 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -1369,6 +1369,7 @@ fhandler_console::read (void *pv, size_t& buflen)
>  	case input_signalled: /* signalled */
>  	case input_winch:
>  	  release_input_mutex ();
> +	  fix_input_mode_if_necessary (); /* for win32_input_mode */
>  	  if (global_sigs[get_ttyp ()->last_sig].sa_flags & SA_RESTART)
>  	    continue;
>  	  goto sig_exit;
> @@ -1390,14 +1391,14 @@ fhandler_console::read (void *pv, size_t& buflen)
>      input_ready = false;
>    release_input_mutex ();
>  
> +  fix_input_mode_if_necessary (); /* for win32_input_mode */
> +
>    if (buflen > copied_chars && !(get_ttyp ()->ti.c_lflag & ICANON)
>        && copied_chars < get_ttyp ()->ti.c_cc[VMIN])
>      goto read_more;
>  
>  #undef buf
>  
> -  fix_input_mode_if_necessary (); /* for win32_input_mode */
> -
>    buflen = copied_chars;
>    return;
>  
> -- snap --
> 
> and
> 
> -- snip --
> diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> index 33417169b8..d47991f21c 100644
> --- a/winsup/cygwin/select.cc
> +++ b/winsup/cygwin/select.cc
> @@ -1172,17 +1172,17 @@ peek_console (select_record *me, bool)
>  	      break;
>  	    }
>  	}
> -      if (fhandler_console::input_winch == fh->process_input_message (0)
> +      int ret = fh->process_input_message (0);
> +      fh->release_input_mutex ();
> +      fh->fix_input_mode_if_necessary (); /* for win32_input_mode */
> +
> +      if (fhandler_console::input_winch == ret
>  	  && global_sigs[SIGWINCH].sa_handler != SIG_IGN
>  	  && global_sigs[SIGWINCH].sa_handler != SIG_DFL)
>  	{
>  	  set_sig_errno (EINTR);
> -	  fh->release_input_mutex ();
>  	  return -1;
>  	}
> -      fh->release_input_mutex ();
> -
> -      fh->fix_input_mode_if_necessary (); /* for win32_input_mode */
>      }
>    if (fh->input_ready || fh->get_cons_readahead_valid ())
>      return me->read_ready = true;
> -- snap --
> 
> What do you think?

Sounds reasonable. I've included these fixes into v18 patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
