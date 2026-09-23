Return-Path: <SRS0=ANL/=HP=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id 18E6C4BB3BC2
	for <cygwin-patches@cygwin.com>; Wed, 23 Sep 2026 22:33:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 18E6C4BB3BC2
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 18E6C4BB3BC2
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790202785; cv=none;
	b=ar+mHzwAp6R/y+MchZhmgaTu5/rc1pq4Clv4Nv8//0SvtkkHmtJ+5P1wUcjbZE0ryZ6+Gz6U9zZg6kqWXffNhAcHoZykVK0vgkXs/zlF2Gb2GauQYmeopB+o0Wv2OVK9ahCSCvRlEiBb9vsLBVwIg/61xFxjhTotI4K4sEztXWw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790202785; c=relaxed/simple;
	bh=z/PoFxaMFilMWl0XHTL/1JKu21SdSxo13YAQVST/XOU=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=DcYnKieyn+S/B970Q0Hai5bWnf7geNXWMzVHDYfw2pBXSHTaRu9rVMfSCqL48fMfVJFefDdTHmWgaZRBDM14XwGSWGdaay6bKj5Z3SiV3V524d3IN19Xll9RLFbkL6RKnhyTIewY5kwXfFA2+vyHB2RoT5q0/aUOjHw/KJKD/E8=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=queXn7iK
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 18E6C4BB3BC2
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=queXn7iK
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20260923223303331.VDDT.44671.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 24 Sep 2026 07:33:03 +0900
Date: Thu, 24 Sep 2026 07:33:02 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4] Cygwin: console: Abort setting disable_master_thread
 when no con.owner
Message-Id: <20260924073302.c5340268bc3f9c1c9024af0c@nifty.ne.jp>
In-Reply-To: <9fbe8256-2235-0fda-eb05-014d8d5ec84d@gmx.de>
References: <20260919151641.57452-1-takashi.yano@nifty.ne.jp>
	<cf05d989-d95b-4aff-b4d7-c9fbfcf8496b@gmx.de>
	<20260923105326.d57b0710f1519e32b9c5d496@nifty.ne.jp>
	<9fbe8256-2235-0fda-eb05-014d8d5ec84d@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1790202783;
 bh=90PPv7NDndAMjePpWZyIcEmSJIiHeIxYIz75ESQfHV0=;
 h=Date:From:To:Subject:In-Reply-To;
 b=queXn7iKDqdfmWD/SW2/Oe5Fnd6fehleLxqGDU/Er3V+SO4hu/K6J4+biA+dfsyTcN1j4eDg
 eubzvhVQusD8lgeeNVCOdUiVl6Xe2xAH2kIuKVss/UQcIqrQmpY+hCqRWrR3IJJkM1jkEQEOX4
 cx+XQ4caaUaqHmoVBWnbz7K6UWecg2X+Wn0mPaNZclCQlhGpfVY3nEUF6n+E8adcgpc0zkeG3q
 a6sfRW0lPuAUvu3+ZOD/Xb7ccuAvZiTyBZhpYZ9YSynVA3kRGluV0DJ9YxFXMgFX2lwCuJ4b9w
 oy+thZRwMaU8e7zL5QjarGtHYH1TqISYOSDPOxh3MyrauSdA==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Wed, 23 Sep 2026 12:58:52 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Wed, 23 Sep 2026, Takashi Yano wrote:
> 
> > On Tue, 22 Sep 2026 18:44:02 +0200 (CEST)
> > Johannes Schindelin wrote:
> > > 
> > > On Sun, 20 Sep 2026, Takashi Yano wrote:
> > > 
> > > > With the commit 733d5a953fa9 ("Cygwin: console: Ensure the master
> > > > thread runs only when it is supposed to"), the process which calls
> > > > set_disable_master_thread() hangs if the con.owner already exited,
> > > > because set_disable_master_thread() waits for cons_master_thread
> > > > accepting the status change and reflecting the current status to
> > > > master_thread_suspended. With this patch, set_disable_master_thread()
> > > > is aborted if the owner process no longer exists to avoid this
> > > > hang.
> > > > 
> > > > Addresses: https://cygwin.com/pipermail/cygwin/2026-September/260037.html
> > > > Fixes: 733d5a953fa9 ("Cygwin: console: Ensure the master thread runs only when it is supposed to")
> > > > Reported-by: Jay Libove Alzina <libove@felines.org>
> > > > Co-authored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > > > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > > > Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > > > ---
> > > > v2: Treat the absence of the master thread the same as suspension.
> > > > v3: Handle the crash of owner process.
> > > > v4: Put my concept together based on Johannes's.
> > > 
> > > Thank you!
> > > 
> > > About what you said in the v3 thread:
> > > 
> > > > If we mistakenly wait for an acknowledgement, it can cause a hang.
> > > 
> > > You were right to point out that continuing to wait can hang. My proposed
> > > fixup does not solve that: if the process query keeps failing and no
> > > worker acknowledgement arrives, it logs an inconclusive result and keeps
> > > waiting, potentially indefinitely.
> > > 
> > > A failed query does not establish that the owner exited, though. If we
> > > want to stop waiting in that situation, I think we should report an
> > > explicit failure rather than silently treating the owner as dead. Since
> > > set_disable_master_thread() currently returns void, that would require
> > > changing both the function and its callers.
> > > 
> > > Could we discuss that choice separately from the fix for an observed owner
> > > exit? I think we need to decide whether to keep waiting or report a
> > > failure before changing that behavior. Avoiding the same diagnostic on
> > > every retry is a smaller change that we can make independently.
> > 
> > IMHO, we should not continue to wait response from master_thread
> > in error case. It is safer.
> 
> In a practical sense, yes, it is safer. A query error does not prove that
> the master thread exited. Nevertheless, continuing to wait for an
> acknowledgement that may never arrive is less safe than entering the
> existing processed-input fallback.
> 
> In my original approach to this problem, I was convinced that a transient
> query error needs to be handled differently, but in practice it will be
> simpler and more robust to stop waiting.
> 
> > > About v4, I have a couple more things:
> > > 
> > > > 
> > > >  winsup/cygwin/fhandler/console.cc       | 40 +++++++++++++++++++++++--
> > > >  winsup/cygwin/local_includes/fhandler.h |  1 +
> > > >  2 files changed, 38 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> > > > index 2d5382c0d..140837add 100644
> > > > --- a/winsup/cygwin/fhandler/console.cc
> > > > +++ b/winsup/cygwin/fhandler/console.cc
> > > > @@ -900,7 +900,7 @@ fhandler_console::fix_input_mode_if_necessary ()
> > > >      }
> > > >    bool need_processed_input =
> > > >      con.master_thread_suspended || con.disable_master_thread
> > > > -    || con.need_win32_input_mode_fix;
> > > > +    || con.need_win32_input_mode_fix || master_thread_exited (unit);
> > > >    if (need_processed_input == con.is_processed_input)
> > > >      {
> > > >        ReleaseMutex (cons_mode_mutex);
> > > > @@ -947,7 +947,7 @@ fhandler_console::set_input_mode (tty::cons_mode m, const termios *t,
> > > >        flags |= ENABLE_WINDOW_INPUT;
> > > >        con.is_processed_input =
> > > >  	con.master_thread_suspended || con.disable_master_thread
> > > > -	|| con.need_win32_input_mode_fix;
> > > > +	|| con.need_win32_input_mode_fix || master_thread_exited (unit);
> > > >        if (con.is_processed_input)
> > > >  	flags |= ENABLE_PROCESSED_INPUT;
> > > >        if (wincap.has_con_24bit_colors () && !con_is_legacy)
> > > > @@ -5011,6 +5011,36 @@ fhandler_console::need_console_handler ()
> > > >    return con.disable_master_thread || con.master_thread_suspended;
> > > 
> > > I am concerned that the Ctrl+C fallback might not reach signal delivery:
> > > When the owner dies with both request and acknowledgment false, v4 can
> > > enable `ENABLE_PROCESSED_INPUT`. Windows then delivers Ctrl+C as a control
> > > event rather than queued input. But `need_console_handler()` still checks
> > > only those two flags, so `ctrl_c_handler()` ignores the event, assuming
> > > the missing worker will handle it.
> > > 
> > > How about extending the condition like this:
> > > 
> > >     return con.disable_master_thread || con.master_thread_suspended
> > > 	|| (con.curr_input_mode == tty::cygwin
> > > 	    && con.is_processed_input);
> > >
> > > This would basically handle the case where we asked Windows to handle
> > > Ctrl+C, i.e. we want to accept Windows' notifications.
> > 
> > Good point!
> > 
> > What abount simply:
> >     reurn con.is_processed_input;
> > ?
> 
> Great idea! This is clean: When Windows consumes Ctrl+C instead of queuing
> it, Cygwin’s console handler must accept the resulting control event.
> 
> However, `is_processed_input` is currently not _quite_ reliable enough:
> 
> - It is a plain `bool`; Might need to be turned into a `volatile bool`?
> - In `fix_input_mode_if_necessary()`, it is set before `SetConsoleMode()`,
>   in `setup_input_mode()` it is set _after_, and neither checks whether
>   `GetConsoleMode()` or `SetConsoleMode()` succeeded.
> 
> I think the safest invariant to settle on would be: Whenever Windows might
> have `ENABLE_PROCESSED_INPUT` set, `con.is_processed_input` must be true.
> What do you think?

I agree. So, they should be like:

ENABLE_PROCESSED_INPUT:    ________/~~~~~~~~~~~~~~~~\________
con.is_processed_input:    ______/~~~~~~~~~~~~~~~~~~~~\______

> Hardening the code to set `is_processed_input` more consistently is the
> only remaining concern about this patch that I have; If you agree with
> this idea, I think it would make for a good follow-up patch.

The idea above is quite simple, so I modified the v4 patch so that
con.is_processed_input is asserted when ever ENABLE_PROCESSED_INPUT
is set like the figure above. Please check v5 patch.

> > ctrl_c_handler() should handle Ctrl-C when ENABLE_PROCESSED_INPUT
> > is really set, I think. For example, In
> > sleep 10 | ./winsleep 10
> > where winsleep is non-cygwin program, con.curr_input_mode is
> > tty::native. However sleep 10 needs console handler to be
> > stopped by Ctrl-C because master_thread is suspended.
> > 
> > > >  }
> > > >  
> > > > +bool
> > > > +fhandler_console::master_thread_exited (_minor_t unit)
> > > > +{
> > > > +  DWORD owner = con.owner;
> > > > +  if (owner == (DWORD) -1) /* About to exit, however still alive */
> > > > +    return false;
> > > > +  if (owner == 0)
> > > > +    return true;
> > > > +  bool exited = false;
> > > > +  DWORD error = ERROR_SUCCESS;
> > > > +  HANDLE process = OpenProcess (SYNCHRONIZE, FALSE, owner);
> > > > +  if (process)
> > > > +    {
> > > > +      DWORD res = WaitForSingleObject (process, 0);
> > > > +      if (res == WAIT_FAILED)
> > > > +	error = GetLastError ();
> > > > +      exited = (res == WAIT_OBJECT_0);
> > > > +      CloseHandle (process);
> > > > +    }
> > > > +  else
> > > > +    {
> > > > +      error = GetLastError ();
> > > > +      exited = (error = ERROR_INVALID_PARAMETER);
> > > 
> > > The first `=` is correct, but the second `=` needs to be a comparator:
> > > 
> > > 	exited = (error == ERROR_INVALID_PARAMETER);
> > 
> > Fixed the local commit. Thanks.
> > 
> > > > +    }
> > > > +  if (error && !exited)
> > > > +    system_printf ("Cannot query console owner %u, error %u", owner, error);
> > > > +
> > > > +  return exited;
> > > 
> > > Could we double-check that the owner hasn't changed here, via
> > > 
> > > 	return exited && con.owner == owner;
> > 
> > Rather, I think we should
> >   return (exited || error) && con.owner == owner;
> > This aborts waiting for a response from the master thread in the
> > error case, as long as the error does not stems from an owner PID
> > that is no longer valid. What do you think?
> 
> Sure, this makes sense. The condition is true if the current worker is
> unavailable or cannot safely be waited for. It's not, as I thought, "the
> process exited".
> 
> At some stage it might make sense to rename `master_thread_exited()` to
> `master_thread_unavailable()` to reflect that?

Yeah, I'd change the function name in v5.

> And of course, persistent errors querying the state would produce repeated
> diagnostic messages. That's probably okay.

In normal case, con.owner == owner is true, so the function returns
true on error. Then the wait loop will be aborted. the diagnostic
message shows only once, I think.

> tl;dr I think with your proposed changes, this patch is good to go, with a
> potential hardening of `is_processed_input` as a follow-up.
> 
> Ciao,
> Johannes

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
