Return-Path: <SRS0=3SWy=EU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:27])
	by sourceware.org (Postfix) with ESMTPS id 528C74BA2E14
	for <cygwin-patches@cygwin.com>; Wed, 24 Jun 2026 13:14:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 528C74BA2E14
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 528C74BA2E14
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782306848; cv=none;
	b=KKL4httwg3905MGWzs350tKlD6I01yGH0lut2GqZNrcd+Hm5abSqcXJ1znhBSCuTVXWUlFLv2fRTAaLvpRMHbifWxZnwUehpZ5a7I4t3nztAecJmFT8anDTcOYYvFbI9NmaTXi9vwYGMb14tURumm+xS5Btc2tQlxC7Nmbp9ReY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782306848; c=relaxed/simple;
	bh=1rwspEXaZsmnG/NpbcnVdyN4QXuWdBXSUnhuVqDBcBI=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=Vd5mPZEXaxku6nibRHeEttGZnpdxy40q8VEsfTw3V+wpQmLD4WLqFb/BaHNFnBn9qBwdbGTj7gvqF12S4ql3NdAOjK4n/AF3QkV+ez3rG86uHJrsfa+u96/VwDX1cC9XvK5BPh2TZ+Rb1gOaot0RefVVWRyeLWKwPs0hktioo2k=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=lqamT2NA
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 528C74BA2E14
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=lqamT2NA
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260624131404572.FMSW.17441.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 24 Jun 2026 22:14:04 +0900
Date: Wed, 24 Jun 2026 22:14:02 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 3/3] Cygwin: pty: Fixup pty state after a cygwin app
 exits
Message-Id: <20260624221402.a87e17e91f0700755f353f8f@nifty.ne.jp>
In-Reply-To: <137d80a5-72fe-431a-95d5-67f00f058865@maxrnd.com>
References: <20260613140917.27155-1-takashi.yano@nifty.ne.jp>
	<20260613140917.27155-4-takashi.yano@nifty.ne.jp>
	<dd205968-3113-4010-b1b4-18d9e574ca97@maxrnd.com>
	<20260623223155.15a0159ca60f33284ad6699b@nifty.ne.jp>
	<137d80a5-72fe-431a-95d5-67f00f058865@maxrnd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1782306844;
 bh=9RU1So4h+FkYJakmMaRFLvtK4MvRlbraOSQk6g9fwXI=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=lqamT2NAcKA+Exuy0CTbaVKoD1juAGSkYx72z8TJn+kNi3NMUau04c+m5OgJLSlMm2f+j7wC
 pLKejlYI9NlkkqTtZzAkMPLVItVxlxBdAMU1VuhxNYohUTr6z6hgfh/cAppujm6QLzHdpJLPvO
 e9SiPCCr/A/laoCEvjbJDZ7+CFddnGYdcagtqFbfaItMTiuGob4TPB2+HpRnER+fI3GTPGgO/N
 S7alhI1pdWM420z4Nq08UJbiYl76bYYtkmHNpbQihJ14kFDHQBql3s+IMcKnLljV5s6eqz+KKm
 8oNSCaEIhudkbi5Bt5GAxf62Q63b3QyAtSzON5dFrYLH+r6w==
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The patch seriese pushed.
Thanks!

On Wed, 24 Jun 2026 00:17:57 -0700
Mark Geisert wrote:
> Hi Takashi,
> 
> All of your corrections and additions LGTM.  This one can be pushed.
> Thanks,
> 
> ..mark
> 
> On 6/23/2026 6:31 AM, Takashi Yano wrote:
> > Hi Mark,
> > 
> > Thanks for reviewing.
> > 
> > On Tue, 23 Jun 2026 01:07:16 -0700
> > Mark Geisert  wrote:
> >> Hi Takashi,
> >>
> >> On 6/13/2026 7:09 AM, Takashi Yano wrote:
> >>> Previously, the cygwin process on pty is always a child of another
> >>> cygwin app on pty. If a cygwin app is a child of non-cygwin app
> >>> in pseudo console, it was running on console originating from
> >>> pseudo console. Now, the child of a non-cygwin app on pseudo console
> >>> is running on pty, so, it is necessary to restore the pty state
> >>> to the state where the parent process is running. This patch
> >>> does the following fixup:
> >>>    1) Switch pipe mode to cyg-pipe to nat-pipe.
> >>                           ^^^^^^^^^^^^^^^^^^^^^^^ this can't be correct
> > 
> > Auch! "from cyg-pipe to nat-pipe"
> >>
> >>>    2) Notify the current cursor position to pseudo console
> >>>
> >>> These prevent the problems:
> >>>    1) Run 'cat' in cmd.exe and stop it by Ctrl-C. After that
> >>>       cmd.exe cannot receive key input.
> >>>    2) Run 'ps' in cmd.exe. The cursor position will not be
> >>>       maintained correctly after that.
> >>>
> >>> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> >>> Reviewed-by:
> >>> ---
> >>>    winsup/cygwin/fhandler/pty.cc           | 73 ++++++++++++++++++++++++-
> >>>    winsup/cygwin/local_includes/fhandler.h |  2 +
> >>>    winsup/cygwin/local_includes/tty.h      |  1 +
> >>>    3 files changed, 73 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> >>> index b3a8d57cc..f4473bb69 100644
> >>> --- a/winsup/cygwin/fhandler/pty.cc
> >>> +++ b/winsup/cygwin/fhandler/pty.cc
> >>> @@ -388,6 +388,52 @@ atexit_func (void)
> >>>        }
> >>>    }
> >>>    
> >>> +void
> >>> +fhandler_pty_slave::req_fixup_pcon_state (void)
> >>> +{
> >>> +  while (true)
> >>> +    {
> >>> +      WaitForSingleObject (input_mutex, mutex_timeout);
> >>> +      if (!get_ttyp ()->pcon_start_pid)
> >>> +	break;
> >>> +      /* Another request is on going. */
> >>> +      ReleaseMutex (input_mutex);
> >>> +      yield ();
> >>> +    }
> >>> +
> >>> +  DWORD n;
> >>> +  /* indicates that this "ESC[6n" is just for fixing-up corsor position */
> >>                                                              ^^^^^^ typo here
> > 
> > Fixed.
> > 
> >>> +  get_ttyp ()->req_fixup_pcon_cur_pos = true;
> >>> +  get_ttyp ()->req_xfer_input = true; /* indicates that this "ESC[6n"
> >>> +					 is just for transfer input */
> >>> +  get_ttyp ()->pcon_start = true;
> >>> +  get_ttyp ()->pcon_start_pid = myself->pid;
> >>> +  WriteFile (get_output_handle (), "\033[6n", 4, &n, NULL);
> >>> +  ReleaseMutex (input_mutex);
> >>> +  while (get_ttyp ()->pcon_start_pid)
> >>> +    /* wait for completion of fixing-up in master::write(). */
> >>> +    yield ();
> >>> +}
> >>> +
> >>> +void
> >>> +fhandler_pty_master::fixup_pcon_cursor_position (int x, int y)
> >>> +{
> >>> +  HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
> >>> +				   get_ttyp ()->nat_pipe_owner_pid);
> >>> +  HANDLE h_pcon_out = NULL;
> >>> +  DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_out,
> >>> +		   GetCurrentProcess (), &h_pcon_out,
> >>> +		   0, TRUE, DUPLICATE_SAME_ACCESS);
> >>> +  CloseHandle (pcon_owner);
> >>> +  DWORD target_pid = get_ttyp ()->nat_pipe_owner_pid;
> >>> +  DWORD resume_pid =
> >>> +    fhandler_pty_common::attach_console_temporarily (target_pid);
> >>> +  COORD cur_pos = {(SHORT) (x - 1), (SHORT) (y - 1)};
> >>> +  SetConsoleCursorPosition (h_pcon_out, cur_pos);
> >>> +  fhandler_pty_common::resume_from_temporarily_attach (resume_pid);
> >>> +  CloseHandle (h_pcon_out);
> >>> +}
> >>> +
> >>>    #define DEF_HOOK(name) static __typeof__ (name) *name##_Orig
> >>>    /* CreateProcess() is hooked for GDB etc. */
> >>>    DEF_HOOK (CreateProcessA);
> >>> @@ -1162,6 +1208,19 @@ err_no_msg:
> >>>    bool
> >>>    fhandler_pty_slave::open_setup (int flags)
> >>>    {
> >>> +  if (get_ttyp ()->pcon_activated)
> >>> +    {
> >>> +      HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
> >>> +				       get_ttyp ()->nat_pipe_owner_pid);
> >>> +      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
> >>> +		       GetCurrentProcess (), &get_handle_nat (),
> >>> +		       0, TRUE, DUPLICATE_SAME_ACCESS);
> >>> +      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_out,
> >>> +		       GetCurrentProcess (), &get_output_handle_nat (),
> >>> +		       0, TRUE, DUPLICATE_SAME_ACCESS);
> >>> +      CloseHandle (pcon_owner);
> >>> +    }
> >>> +
> >>>      set_flags ((flags & ~O_TEXT) | O_BINARY);
> >>>      myself->set_ctty (this, flags);
> >>>      report_tty_counts (this, "opened", "");
> >>> @@ -1171,6 +1230,9 @@ fhandler_pty_slave::open_setup (int flags)
> >>>    void
> >>>    fhandler_pty_slave::cleanup ()
> >>>    {
> >>> +  if (get_ttyp ()->pcon_activated && get_ttyp ()->getpgid () == myself->pgid)
> >>> +    req_fixup_pcon_state ();
> >>> +
> >>>      /* This used to always call fhandler_pty_common::close when we were execing
> >>>         but that caused multiple closes of the handles associated with this pty.
> >>>         Since close_all_files is not called until after the cygwin process has
> >>> @@ -2478,7 +2540,14 @@ fhandler_pty_master::write (const void *ptr, size_t len)
> >>>    	      /* req_xfer_input is true if "ESC[6n" was sent just for
> >>>    		 triggering transfer_input() in master. In this case,
> >>>    		 the response sequence should not be written. */
> >>
> >> The above comment describes the req_xfer case, but says nothing about
> >> the the req_fixup_pcon_cur_pos case now inserted before it.
> > 
> > I'll modify the comment above like:
> >        /* req_fixup_pcon_cur_pos is true if "ESC[6n" was sent
> >           for requesting cursor-position-fixup that is needed
> >           when a non-cygwin app executes a cygwin app and the
> >           cygwin app exits.
> >           req_xfer_input is true if "ESC[6n" was sent just for
> >           triggering transfer_input() in master. In this case,
> >           the response sequence should not be written. */
> > 
> > Does this look OK to you?
> 
> That's great!
> 
> ..mark


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
