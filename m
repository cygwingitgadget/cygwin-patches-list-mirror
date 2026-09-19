Return-Path: <SRS0=6u+c=HL=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 744D34BB24CF
	for <cygwin-patches@cygwin.com>; Sat, 19 Sep 2026 05:57:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 744D34BB24CF
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 744D34BB24CF
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789797436; cv=none;
	b=xnEhd+9/hUfyXMKtctZVvrlg22Spi7nHAcx5kgu8ctywNPX0RFsc7FKA9vSgFwZnpmk3y0Yf3+N9lTbiUXvgesWWljeMDR27PbY+puFK8VaB5Ag/Jfzg6ryW00xAJzpbMQW+Zf+uoNY7qbxbXGyzI6gCl0/9yzDyr3ySSnzrXBw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789797436; c=relaxed/simple;
	bh=KI+loXHNczhicFLAGbxR13evbyrYuGoEAES4xv6b0Tg=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=aan0IGeczj1T8uqCM1D4w18IZN77HaBLf/3JArlIrv+/ghEw4M/5+ggkqSC/4cNopAho4yJGsi1sbQwMfTacrGGeq/lCvVEDo/CRm4+lp+WoZr2qz8SmxkWsaD5YwNijVTrbDqs9YVknQtlKC0OcbEq77f0kgSlYsB7t17CQUjE=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=oTs+/LRP
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 744D34BB24CF
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=oTs+/LRP
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260919055712866.LZII.17441.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sat, 19 Sep 2026 14:57:12 +0900
Date: Sat, 19 Sep 2026 14:57:11 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: console: Abort setting disable_master_thread
 when no con.owner
Message-Id: <20260919145711.6ce024cc19f0b99cae6e0deb@nifty.ne.jp>
In-Reply-To: <f6e4cbb2-302e-910d-35f5-2a403d604322@gmx.de>
References: <20260917054209.7682-1-takashi.yano@nifty.ne.jp>
	<f6e4cbb2-302e-910d-35f5-2a403d604322@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1789797432;
 bh=ivtdNMhOJ4aIUCMA76wN57i0ImBJYtOWTTEsQwJnO5k=;
 h=Date:From:To:Subject:In-Reply-To;
 b=oTs+/LRP1qVfKXj26qVwaNqfyO1EFj0CHI0bSoD6ajybogz00yB6jNuksHlZO04SUViUce17
 RQv0wgfo1h0bG+gezf5qYfmlpTYRfs8MUynGtTB5I112SG1yR32Lkbt0QcP2MjskfPX4LcEA/+
 1MIxSLGDYXWADdxnl5eAXlqaDmiH/l1Joynd6SA6IdkYNE2pnBtS22ZbzESDNw/KODi25AkC+t
 cJtYmSrrrDHOh29QWUuAsIXIrHMT3ohw1K3UzkqXRcbhjaLOg7llCdIrtIDamteH6iE4YV9XKa
 W29TEmDXI3m/gMFmzhHj6lWTxtMWyhI9GomGeSK7T1YDseLw==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Fri, 18 Sep 2026 17:50:54 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Thu, 17 Sep 2026, Takashi Yano wrote:
> 
> > With the commit 733d5a953fa9 ("Cygwin: console: Ensure the master
> > thread runs only when it is supposed to"), the process which calls
> > set_disable_master_thread() hangs if the con.owner already exited,
> > because set_disable_master_thread() waits for cons_master_thread
> > accepting the status change and reflecting the current status to
> > master_thread_suspended. With this patch, set_disable_master_thread()
> > is aborted if the owner process no longer exists to avoid this
> > hang.
> > 
> > Addresses: https://cygwin.com/pipermail/cygwin/2026-September/260037.html
> > Fixes: 733d5a953fa9 ("Cygwin: console: Ensure the master thread runs only when it is supposed to")
> > Reported-by: Jay Libove Alzina <libove@felines.org>
> > Co-authored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > ---
> > v2: Treat the absence of the master thread the same as suspension.
> > v3: Handle the crash of owner process.
> 
> Thank you!
> 
> There's one more concern I have: An owner query failure does not
> necessarily mean the process exited, and observing exit is not a worker
> acknowledgement.
> 
> I think we need to allow an owner-exit escape only on observed exit or
> absence, with con.owner still matching the captured owner. We need to
> leave the acknowledgement untouched and preserve -1 as normal retirement,
> and log inconclusive query or wait failures once per newly observed
> failing owner and keep waiting.
> 
> More concretely, I am worried about this scenario: An old owner's absence
> can overwrite a replacement's acknowledgement. Non-owner cleanup A holds
> `cons_mode_mutex` and requests resume, while acknowledgement remains true.
> Process A captures a dead owner's PID or zero and selects the escape
> branch before reacquiring `input_mutex`. Meanwhile, process B can claim
> ownership in `open()` and start its worker before obtaining the mode
> mutex, as v17 deliberately permits. Process B's worker sees the retained
> false request and acknowledges resume. Process A then obtains the input
> lock but rechecks neither owner nor acknowledgement before writing true.
> The shared record now calls process B suspended despite its
> acknowledgement. Later mode decisions use that record when selecting
> `ENABLE_PROCESSED_INPUT`. Holding the mode mutex does not exclude the new
> startup path, and taking the input lock does not validate the earlier
> owner observation.

Sorry, I don't get your point. What do you mean by 'worker'? The
caller of set_disable_master_thread()?

(1)
I think it’s actually safer to mistakenly treat the owner as dead
when it’s still alive than to make the opposite mistake. Therefore
I use:
`if (owner == 0 || owner == (DWORD) -1 || !process_alive (owner))`
owner == 0: No master thread
owner == -1: The master thread is about to exit.
!process_alive (owner): Possibly, the owner process died.

(2)
Setting con.master_thread_suspended = true is necessary when the
master_thread is not respoiding, because Ctrl-C should work at
least even when the master_thread is not alive and the process
does not call process_input_message().
If master_thread_suspended is not set, the set_input_mode()
may clears ENABLE_PROCESSED_INPUT, so Ctrl-C does not work because
of absence of the master thread.

Your code seems to be trying to track the liveness of the current
master thread as accurately as possible, but I’m not sure that level
of accuracy is really necessary.

If we mistakenly wait for an acknowledgement, it can cause a hang.
But if we mistakenly don’t wait for an acknowledgement, what kind
of risks do you think that would introduce?

> A related concern: Retiring is not the same as retired. `close()` sets
> owner to `-1`, waits for the worker's completion event, then publishes
> zero. V3 treats that intermediate value as absence.
> 
> Another note: `process_alive()` also returns false when opening or
> querying a process fails. A failed query is not verified process exit.
> This distinction needs deliberate error handling, not an unconditional
> assertion that the worker no longer exists.
> 
> I'd like to offer this as a discussion starter:
> 
> -- snip --
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> index 16c3e5270a..39352ddda1 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -4950,16 +4950,40 @@ fhandler_console::set_disable_master_thread (bool x, fhandler_console *cons)
>    cons->acquire_input_mutex (mutex_timeout);
>    con.disable_master_thread = x;
>    cons->release_input_mutex ();
> +  DWORD reported_owner = 0;
>    while (con.master_thread_suspended != x)
> -    { /* Wait for the responce from the cons_master_thread. */
> +    {
>        DWORD owner = con.owner;
> -      if (owner == 0 || owner == (DWORD) -1 || !process_alive (owner))
> -	{ /* The process that runs cons_master_thread no longer exists. */
> -	  cons->acquire_input_mutex (mutex_timeout);
> -	  /* Treat the absence of the master_thread the same as suspension. */
> -	  con.master_thread_suspended = true;
> -	  cons->release_input_mutex ();
> -	  return; /* Abort */
> +      if (owner != (DWORD) -1)
> +	{
> +	  bool exited = owner == 0;
> +	  DWORD error = ERROR_SUCCESS;
> +	  if (owner)
> +	    {
> +	      HANDLE process = OpenProcess (SYNCHRONIZE, FALSE, owner);
> +	      if (process)
> +		{
> +		  DWORD res = WaitForSingleObject (process, 0);
> +		  if (res == WAIT_FAILED)
> +		    error = GetLastError ();
> +		  exited = res == WAIT_OBJECT_0;
> +		  CloseHandle (process);
> +		}
> +	      else
> +		{
> +		  error = GetLastError ();
> +		  exited = error == ERROR_INVALID_PARAMETER;
> +		}
> +	    }
> +	  /* Keep the request, but never invent a worker acknowledgement. */
> +	  if (exited && con.owner == owner)
> +	    return;
> +	  if (error && !exited && reported_owner != owner)
> +	    {
> +	      system_printf ("Cannot query console owner %u, error %u",
> +			     owner, error);
> +	      reported_owner = owner;
> +	    }
>  	}
>        Sleep (1);
>      }
> -- snap --
> 
> I haven't been able to fully wrap my head around these issues, and need to
> unwind this weekend. Hopefully you can turn this into a correct and
> complete fix.
> 
> Thank you,
> Johannes
> 
> > 
> >  winsup/cygwin/fhandler/console.cc | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> > index a877fce0b..0b9e205e6 100644
> > --- a/winsup/cygwin/fhandler/console.cc
> > +++ b/winsup/cygwin/fhandler/console.cc
> > @@ -5025,7 +5025,18 @@ fhandler_console::set_disable_master_thread (bool x, fhandler_console *cons)
> >    con.disable_master_thread = x;
> >    cons->release_input_mutex ();
> >    while (con.master_thread_suspended != x)
> > -    Sleep (1);
> > +    { /* Wait for the responce from the cons_master_thread. */
> > +      DWORD owner = con.owner;
> > +      if (owner == 0 || owner == (DWORD) -1 || !process_alive (owner))
> > +	{ /* The process that runs cons_master_thread no longer exists. */
> > +	  cons->acquire_input_mutex (mutex_timeout);
> > +	  /* Treat the absence of the master_thread the same as suspension. */
> > +	  con.master_thread_suspended = true;
> > +	  cons->release_input_mutex ();
> > +	  return; /* Abort */
> > +	}
> > +      Sleep (1);
> > +    }
> >  }
> >  
> >  int
> > -- 
> > 2.51.0
> > 
> > 


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
