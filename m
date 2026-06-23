Return-Path: <SRS0=oHIC=ET=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id DAD434BA5434
	for <cygwin-patches@cygwin.com>; Tue, 23 Jun 2026 13:31:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DAD434BA5434
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DAD434BA5434
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782221521; cv=none;
	b=WYRIYha/wjuPEaNCfTDY5ldQ99XNGPJcUIag1KYVek4PyZDOnOdWuNKLwQAKo9V22mYThccNEXt8/eowf8SERE1nvLpIOAd+PImFy8T+8fhe4kcCkFC8rjtOBwYf38CwTkRQqTLZl3d81MPyc9gpCg+RC956PM4AeEfHkPSkQ5k=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782221521; c=relaxed/simple;
	bh=DmlAlKGeNTjzGpiJ7HUQmouEpLvcqjXYC+btehEDsl4=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=KNQ+N05FTLgCWof1AIcSyd7cH2kPo/hPk4RkS/djw765EK7RYW63kDgwiCJHMHOKwZ0y5fdwYwxzwgZLN6ie1u1Xy15xeKZfHhFb/hmzHn7Qy1vzWIJ6dcnuFwEiGbs0Vgoh2hBYVKLuRO7UMLFi6CsutlUj3S9NRFyc9vMWQ84=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=AGT0DReg
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DAD434BA5434
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=AGT0DReg
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20260623133156979.VLWP.44671.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 23 Jun 2026 22:31:56 +0900
Date: Tue, 23 Jun 2026 22:31:55 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 3/3] Cygwin: pty: Fixup pty state after a cygwin app
 exits
Message-Id: <20260623223155.15a0159ca60f33284ad6699b@nifty.ne.jp>
In-Reply-To: <dd205968-3113-4010-b1b4-18d9e574ca97@maxrnd.com>
References: <20260613140917.27155-1-takashi.yano@nifty.ne.jp>
	<20260613140917.27155-4-takashi.yano@nifty.ne.jp>
	<dd205968-3113-4010-b1b4-18d9e574ca97@maxrnd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1782221517;
 bh=z74W+FfbHYlenRzDOMXSFt2xvB0681ZS0VmgeXXQ0M8=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=AGT0DRegv3OQHnNXwXEmMm0GHbg7keUtsGdSI9KvoI9x3dZ8yNrMn1MOKulC0Biabf6ZD1bK
 ktreGLc5gJcHLdBmfm8gFC1ma4V0V1dtJ31SbxZEQXP06Id2k9fwEUkuYx6yuZsKzovYiCRmqW
 CFM4DnXOHdBhPdXMcVRMeN5yIJtt3rskUjzxgG8SgS4yZY3vVeAMZks6rzubORWJEAhGx25zD1
 EzEmd70ry6YTBXpdaYejm5YSnp7WxpdZ87998SqBoVbCf2tfHoVvuv56AvKT18TPU+RWA2I5Rq
 buuQK5dVuc27BQWWrqP/4scFp86KubAwIXHDrHP9h2S7gT8A==
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

Thanks for reviewing.

On Tue, 23 Jun 2026 01:07:16 -0700
Mark Geisert  wrote:
> Hi Takashi,
> 
> On 6/13/2026 7:09 AM, Takashi Yano wrote:
> > Previously, the cygwin process on pty is always a child of another
> > cygwin app on pty. If a cygwin app is a child of non-cygwin app
> > in pseudo console, it was running on console originating from
> > pseudo console. Now, the child of a non-cygwin app on pseudo console
> > is running on pty, so, it is necessary to restore the pty state
> > to the state where the parent process is running. This patch
> > does the following fixup:
> >   1) Switch pipe mode to cyg-pipe to nat-pipe.
>                          ^^^^^^^^^^^^^^^^^^^^^^^ this can't be correct

Auch! "from cyg-pipe to nat-pipe"
> 
> >   2) Notify the current cursor position to pseudo console
> > 
> > These prevent the problems:
> >   1) Run 'cat' in cmd.exe and stop it by Ctrl-C. After that
> >      cmd.exe cannot receive key input.
> >   2) Run 'ps' in cmd.exe. The cursor position will not be
> >      maintained correctly after that.
> > 
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by:
> > ---
> >   winsup/cygwin/fhandler/pty.cc           | 73 ++++++++++++++++++++++++-
> >   winsup/cygwin/local_includes/fhandler.h |  2 +
> >   winsup/cygwin/local_includes/tty.h      |  1 +
> >   3 files changed, 73 insertions(+), 3 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> > index b3a8d57cc..f4473bb69 100644
> > --- a/winsup/cygwin/fhandler/pty.cc
> > +++ b/winsup/cygwin/fhandler/pty.cc
> > @@ -388,6 +388,52 @@ atexit_func (void)
> >       }
> >   }
> >   
> > +void
> > +fhandler_pty_slave::req_fixup_pcon_state (void)
> > +{
> > +  while (true)
> > +    {
> > +      WaitForSingleObject (input_mutex, mutex_timeout);
> > +      if (!get_ttyp ()->pcon_start_pid)
> > +	break;
> > +      /* Another request is on going. */
> > +      ReleaseMutex (input_mutex);
> > +      yield ();
> > +    }
> > +
> > +  DWORD n;
> > +  /* indicates that this "ESC[6n" is just for fixing-up corsor position */
>                                                             ^^^^^^ typo here

Fixed.

> > +  get_ttyp ()->req_fixup_pcon_cur_pos = true;
> > +  get_ttyp ()->req_xfer_input = true; /* indicates that this "ESC[6n"
> > +					 is just for transfer input */
> > +  get_ttyp ()->pcon_start = true;
> > +  get_ttyp ()->pcon_start_pid = myself->pid;
> > +  WriteFile (get_output_handle (), "\033[6n", 4, &n, NULL);
> > +  ReleaseMutex (input_mutex);
> > +  while (get_ttyp ()->pcon_start_pid)
> > +    /* wait for completion of fixing-up in master::write(). */
> > +    yield ();
> > +}
> > +
> > +void
> > +fhandler_pty_master::fixup_pcon_cursor_position (int x, int y)
> > +{
> > +  HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
> > +				   get_ttyp ()->nat_pipe_owner_pid);
> > +  HANDLE h_pcon_out = NULL;
> > +  DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_out,
> > +		   GetCurrentProcess (), &h_pcon_out,
> > +		   0, TRUE, DUPLICATE_SAME_ACCESS);
> > +  CloseHandle (pcon_owner);
> > +  DWORD target_pid = get_ttyp ()->nat_pipe_owner_pid;
> > +  DWORD resume_pid =
> > +    fhandler_pty_common::attach_console_temporarily (target_pid);
> > +  COORD cur_pos = {(SHORT) (x - 1), (SHORT) (y - 1)};
> > +  SetConsoleCursorPosition (h_pcon_out, cur_pos);
> > +  fhandler_pty_common::resume_from_temporarily_attach (resume_pid);
> > +  CloseHandle (h_pcon_out);
> > +}
> > +
> >   #define DEF_HOOK(name) static __typeof__ (name) *name##_Orig
> >   /* CreateProcess() is hooked for GDB etc. */
> >   DEF_HOOK (CreateProcessA);
> > @@ -1162,6 +1208,19 @@ err_no_msg:
> >   bool
> >   fhandler_pty_slave::open_setup (int flags)
> >   {
> > +  if (get_ttyp ()->pcon_activated)
> > +    {
> > +      HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
> > +				       get_ttyp ()->nat_pipe_owner_pid);
> > +      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
> > +		       GetCurrentProcess (), &get_handle_nat (),
> > +		       0, TRUE, DUPLICATE_SAME_ACCESS);
> > +      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_out,
> > +		       GetCurrentProcess (), &get_output_handle_nat (),
> > +		       0, TRUE, DUPLICATE_SAME_ACCESS);
> > +      CloseHandle (pcon_owner);
> > +    }
> > +
> >     set_flags ((flags & ~O_TEXT) | O_BINARY);
> >     myself->set_ctty (this, flags);
> >     report_tty_counts (this, "opened", "");
> > @@ -1171,6 +1230,9 @@ fhandler_pty_slave::open_setup (int flags)
> >   void
> >   fhandler_pty_slave::cleanup ()
> >   {
> > +  if (get_ttyp ()->pcon_activated && get_ttyp ()->getpgid () == myself->pgid)
> > +    req_fixup_pcon_state ();
> > +
> >     /* This used to always call fhandler_pty_common::close when we were execing
> >        but that caused multiple closes of the handles associated with this pty.
> >        Since close_all_files is not called until after the cygwin process has
> > @@ -2478,7 +2540,14 @@ fhandler_pty_master::write (const void *ptr, size_t len)
> >   	      /* req_xfer_input is true if "ESC[6n" was sent just for
> >   		 triggering transfer_input() in master. In this case,
> >   		 the response sequence should not be written. */
> 
> The above comment describes the req_xfer case, but says nothing about 
> the the req_fixup_pcon_cur_pos case now inserted before it.

I'll modify the comment above like:
      /* req_fixup_pcon_cur_pos is true if "ESC[6n" was sent
         for requesting cursor-position-fixup that is needed
         when a non-cygwin app executes a cygwin app and the
         cygwin app exits.
         req_xfer_input is true if "ESC[6n" was sent just for
         triggering transfer_input() in master. In this case,
         the response sequence should not be written. */

Does this look OK to you?

> > -	      if (!get_ttyp ()->req_xfer_input)
> > +	      if (get_ttyp ()->req_fixup_pcon_cur_pos)
> > +		{
> > +		  int x, y;
> > +		  sscanf (wpbuf, "\033[%d;%dR", &y, &x);
> > +		  fixup_pcon_cursor_position (x, y);
> > +		  get_ttyp ()->req_fixup_pcon_cur_pos = false;
> > +		}
> > +	      else if (!get_ttyp ()->req_xfer_input)
> >   		WriteFile (to_slave_nat, wpbuf, ixput, &n, NULL);
> >   	      ixput = 0;
> >   	      state = 0;
> > @@ -4100,8 +4169,6 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
> >   	  ttyp->pcon_activated = false;
> >   	  ttyp->switch_to_nat_pipe = false;
> >   	  ttyp->nat_pipe_owner_pid = 0;
> > -	  ttyp->pcon_start = false;
> > -	  ttyp->pcon_start_pid = 0;
> >   	}
> >         if (ttyp->pcon_handle_ready_event)
> >   	{
> > diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
> > index 322592bf1..2fa30cbce 100644
> > --- a/winsup/cygwin/local_includes/fhandler.h
> > +++ b/winsup/cygwin/local_includes/fhandler.h
> > @@ -2533,6 +2533,7 @@ class fhandler_pty_slave: public fhandler_pty_common
> >     void setpgid_aux (pid_t pid);
> >     static void release_ownership_of_nat_pipe (tty *ttyp, fhandler_termios *fh);
> >     void replace_nat_handles (HANDLE new_input, HANDLE new_output);
> > +  void req_fixup_pcon_state (void);
> >   };
> >   
> >   #define __ptsname(buf, unit) __small_sprintf ((buf), "/dev/pty%d", (unit))
> > @@ -2639,6 +2640,7 @@ public:
> >     void get_master_fwd_thread_param (master_fwd_thread_param_t *p);
> >     bool need_send_ctrl_c_event ();
> >     void apply_line_edit_to_transferred_input ();
> > +  void fixup_pcon_cursor_position (int x, int y);
> >   };
> >   
> >   class fhandler_dev_null: public fhandler_base
> > diff --git a/winsup/cygwin/local_includes/tty.h b/winsup/cygwin/local_includes/tty.h
> > index 507f7772e..c5102eb81 100644
> > --- a/winsup/cygwin/local_includes/tty.h
> > +++ b/winsup/cygwin/local_includes/tty.h
> > @@ -145,6 +145,7 @@ private:
> >     xfer_dir pty_input_state;
> >     bool discard_input;
> >     bool stop_fwd_thread;
> > +  bool req_fixup_pcon_cur_pos;
> >   
> >   public:
> >     HANDLE from_master_nat () const { return _from_master_nat; }
> 
> Otherwise all LGTM.  Let me know what you think about my comments.


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
