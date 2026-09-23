Return-Path: <SRS0=ANL/=HP=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id 2BD164BB1C25
	for <cygwin-patches@cygwin.com>; Wed, 23 Sep 2026 01:53:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2BD164BB1C25
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2BD164BB1C25
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790128413; cv=none;
	b=xqhtvYPSObEnv9V5K7Oox4zShvOu4FlHLHADllB9NreKv4ryE5xmTqzVk+EyBmjJGrZ+c/N69kLaUU2vzPVs8t0uxE2S3dtBtJjhEdawda1zoHZNjiHIDTVCP7cvoqsY8tsg0hIxfjt2i+kHi+8RUIIwoncLosTLrsnUkNV7rUc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790128413; c=relaxed/simple;
	bh=UzG6nGr3z0Efd7FdFmbPoaClLq14jydQOcMKM2MEfro=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=NtHg/LWpA0eYn3XWkR2RSjslaVOLgya3sKw/9IB0gqzkL5gb8EOrsYr84DpQa9tEIzMJsoB4asO47V7aYU/2/5C+/S6BNrbOFDo5UZI8pqvZKmpKSEiBHSCMl+z4tm9Hx29RZGTxaQhExM/MXTHc3FxVF+LCo9FCFNgR3MdRi3M=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=fXEsH8N0
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2BD164BB1C25
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=fXEsH8N0
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20260923015328151.HRLS.44671.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 23 Sep 2026 10:53:28 +0900
Date: Wed, 23 Sep 2026 10:53:26 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4] Cygwin: console: Abort setting disable_master_thread
 when no con.owner
Message-Id: <20260923105326.d57b0710f1519e32b9c5d496@nifty.ne.jp>
In-Reply-To: <cf05d989-d95b-4aff-b4d7-c9fbfcf8496b@gmx.de>
References: <20260919151641.57452-1-takashi.yano@nifty.ne.jp>
	<cf05d989-d95b-4aff-b4d7-c9fbfcf8496b@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1790128408;
 bh=h24gPksXFL1HpzATV/4BA7rBT+Bh4SuP7NjHZhYzNuE=;
 h=Date:From:To:Subject:In-Reply-To;
 b=fXEsH8N0LKE4zNUrHYcFBKSDmPBkeQvyiQEgGhGauxscRHH5ZcZOKmE3CjgY0vYg341Sf5xA
 JGW6PzId2lresN+PtAp5yYvt9VXli/yxVQHLR5XYKJVD6907G93xeT+BlU5DWNDurUwqkD8maW
 ZC/PVRlC8ZhoNJKUZarpvIHAGFciEZanPXXEo3Mqs8jkSATkaGYxuncxRX/vZIOs02Rtob2+T5
 Vlxcl8zdrgmzyyb4CaMXHiFeB5TdD06gkyAy87cfMx5cVx9lI96pkmY+sqdYwQy5uGJFcua/pU
 r5lYbvITEqzoxlvlQQiT6wqGRsSFGIs6EG9+Rs1qqjXGwakg==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Tue, 22 Sep 2026 18:44:02 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Sun, 20 Sep 2026, Takashi Yano wrote:
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
> > v4: Put my concept together based on Johannes's.
> 
> Thank you!
> 
> About what you said in the v3 thread:
> 
> > If we mistakenly wait for an acknowledgement, it can cause a hang.
> 
> You were right to point out that continuing to wait can hang. My proposed
> fixup does not solve that: if the process query keeps failing and no
> worker acknowledgement arrives, it logs an inconclusive result and keeps
> waiting, potentially indefinitely.
> 
> A failed query does not establish that the owner exited, though. If we
> want to stop waiting in that situation, I think we should report an
> explicit failure rather than silently treating the owner as dead. Since
> set_disable_master_thread() currently returns void, that would require
> changing both the function and its callers.
> 
> Could we discuss that choice separately from the fix for an observed owner
> exit? I think we need to decide whether to keep waiting or report a
> failure before changing that behavior. Avoiding the same diagnostic on
> every retry is a smaller change that we can make independently.

IMHO, we should not continue to wait response from master_thread
in error case. It is safer.

> About v4, I have a couple more things:
> 
> > 
> >  winsup/cygwin/fhandler/console.cc       | 40 +++++++++++++++++++++++--
> >  winsup/cygwin/local_includes/fhandler.h |  1 +
> >  2 files changed, 38 insertions(+), 3 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> > index 2d5382c0d..140837add 100644
> > --- a/winsup/cygwin/fhandler/console.cc
> > +++ b/winsup/cygwin/fhandler/console.cc
> > @@ -900,7 +900,7 @@ fhandler_console::fix_input_mode_if_necessary ()
> >      }
> >    bool need_processed_input =
> >      con.master_thread_suspended || con.disable_master_thread
> > -    || con.need_win32_input_mode_fix;
> > +    || con.need_win32_input_mode_fix || master_thread_exited (unit);
> >    if (need_processed_input == con.is_processed_input)
> >      {
> >        ReleaseMutex (cons_mode_mutex);
> > @@ -947,7 +947,7 @@ fhandler_console::set_input_mode (tty::cons_mode m, const termios *t,
> >        flags |= ENABLE_WINDOW_INPUT;
> >        con.is_processed_input =
> >  	con.master_thread_suspended || con.disable_master_thread
> > -	|| con.need_win32_input_mode_fix;
> > +	|| con.need_win32_input_mode_fix || master_thread_exited (unit);
> >        if (con.is_processed_input)
> >  	flags |= ENABLE_PROCESSED_INPUT;
> >        if (wincap.has_con_24bit_colors () && !con_is_legacy)
> > @@ -5011,6 +5011,36 @@ fhandler_console::need_console_handler ()
> >    return con.disable_master_thread || con.master_thread_suspended;
> 
> I am concerned that the Ctrl+C fallback might not reach signal delivery:
> When the owner dies with both request and acknowledgment false, v4 can
> enable `ENABLE_PROCESSED_INPUT`. Windows then delivers Ctrl+C as a control
> event rather than queued input. But `need_console_handler()` still checks
> only those two flags, so `ctrl_c_handler()` ignores the event, assuming
> the missing worker will handle it.
> 
> How about extending the condition like this:
> 
>     return con.disable_master_thread || con.master_thread_suspended
> 	|| (con.curr_input_mode == tty::cygwin
> 	    && con.is_processed_input);
>
> This would basically handle the case where we asked Windows to handle
> Ctrl+C, i.e. we want to accept Windows' notifications.

Good point!

What abount simply:
    reurn con.is_processed_input;
? ctrl_c_handler() should handle Ctrl-C when ENABLE_PROCESSED_INPUT
is really set, I think. For example, In
sleep 10 | ./winsleep 10
where winsleep is non-cygwin program, con.curr_input_mode is
tty::native. However sleep 10 needs console handler to be
stopped by Ctrl-C because master_thread is suspended.

> >  }
> >  
> > +bool
> > +fhandler_console::master_thread_exited (_minor_t unit)
> > +{
> > +  DWORD owner = con.owner;
> > +  if (owner == (DWORD) -1) /* About to exit, however still alive */
> > +    return false;
> > +  if (owner == 0)
> > +    return true;
> > +  bool exited = false;
> > +  DWORD error = ERROR_SUCCESS;
> > +  HANDLE process = OpenProcess (SYNCHRONIZE, FALSE, owner);
> > +  if (process)
> > +    {
> > +      DWORD res = WaitForSingleObject (process, 0);
> > +      if (res == WAIT_FAILED)
> > +	error = GetLastError ();
> > +      exited = (res == WAIT_OBJECT_0);
> > +      CloseHandle (process);
> > +    }
> > +  else
> > +    {
> > +      error = GetLastError ();
> > +      exited = (error = ERROR_INVALID_PARAMETER);
> 
> The first `=` is correct, but the second `=` needs to be a comparator:
> 
> 	exited = (error == ERROR_INVALID_PARAMETER);

Fixed the local commit. Thanks.

> > +    }
> > +  if (error && !exited)
> > +    system_printf ("Cannot query console owner %u, error %u", owner, error);
> > +
> > +  return exited;
> 
> Could we double-check that the owner hasn't changed here, via
> 
> 	return exited && con.owner == owner;

Rather, I think we should
  return (exited || error) && con.owner == owner;
This aborts waiting for a response from the master thread in the
error case, as long as the error does not stems from an owner PID
that is no longer valid. What do you think?

> That way, we reject a stale result if `con.owner` no longer matches the
> PID we queried. The owner can still change after the recheck, though, so
> this alone does not guarantee mode changes to be serialized.
> 
> I think with these changes, my concerns would be addressed. I'd leave the
> policy discussion for inconclusive queries to be continued independently
> instead of trying to settle it in this patch.
> 
> Ciao,
> Johannes

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
