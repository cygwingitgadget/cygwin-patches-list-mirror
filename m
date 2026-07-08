Return-Path: <SRS0=wCit=FC=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 328714BA5439
	for <cygwin-patches@cygwin.com>; Wed,  8 Jul 2026 04:51:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 328714BA5439
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 328714BA5439
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783486299; cv=none;
	b=gmKax0i3a0x2XNvNKpDAnvhhIxJNz00MrGFOgyOrHTlMpeVPNLjinDsVb/3Xjk8yfwvaq0hFHXgm1PcUkbTbJsx2MFWqWk61Qt6KqPBpFyXx7hIn1SkLmuMzYsSaH1BGOliLNUbW4WqLd4siMvIRexzPCq1dHsRoJQuB/WxSjlA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783486299; c=relaxed/simple;
	bh=qcNR1yRl4khN04+bmyW67CajravdUD+o1mWOu9dXPXY=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=M+xlPMAtkNWwH73hR3hLx0ao21R7NJ7Ddj9DQylIMqBrzm7u8pLKLji0ijjRz/HgAs6bWlwmqe3aegmvt2UhJGPwe3pp3b8DwePsvZnxYHQkBakKKGe0qWqoin+aIJFl8BH4Cp2gWkgIqTWbwRijErEpOdayJf3daNkJchi7hPc=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=bKXvlK+a
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 328714BA5439
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=bKXvlK+a
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260708045137541.OXTG.17441.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 8 Jul 2026 13:51:37 +0900
Date: Wed, 8 Jul 2026 13:51:36 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: pty: Do not transfer input to nat-pipe while
 masked
Message-Id: <20260708135136.60ba9ea633cdde3a77d0bda5@nifty.ne.jp>
In-Reply-To: <b5da6489-1222-5721-a361-2adb50830e2a@gmx.de>
References: <20260706032038.100981-1-takashi.yano@nifty.ne.jp>
	<b5da6489-1222-5721-a361-2adb50830e2a@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1783486297;
 bh=tp34+JXv0uMNrzkpzShqtzyedq5AemAYM6PMq/IQmKE=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=bKXvlK+aqfHes197Hs2Evd+/cE3hf4fmo3/2eABtja7phP6MP9XXS7owJQ6w0AajaFr9UaFb
 bZ8+B61uc3tuaTPgjhSQynXXegTt16C5GwSRUhUWD3UAmvi3/OsgnQZgbPO0F8YGLvbMFfrIhj
 HEsdNuuECMBFWOQmadLZg98IuiR2UOClXQs4sKVVL2YH2HnlW+MqzxVZ8YR//1J/YHmZm1KodM
 yO0yuU7S+Gs0Ua1UIzuEgUgy08dUeo8lddIG10f2Q4rAeTvKlp9Y59mMAIA3VeERrAbiEXtwT4
 QUDw22ZFbw/N+NAQUlW4Qg0H7eiGhbIxmVuw1P0M+L/jC5cg==
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Tue, 7 Jul 2026 12:44:01 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> Thank you for v3. Reverting the shared storage cleanly closes the
> cross-process HANDLE hazard, and wrapping the CreateEvent/CloseHandle
> block in acquire_attach_mutex/release_attach_mutex closes the
> OpenEvent-based TOCTOU I had flagged on v2. One substantive concern
> remains, around lock ordering.
> 
> On Mon, 6 Jul 2026, Takashi Yano wrote:
> 
> > On the command "cat | non-cygwin-app", `cat` sometimes fails to read
> > key input. This happens when `cat` starts to read input before `non-
> > cygwin-app` configures pseudo console. This is because pipe state is
> > switched to nat-pipe when pseudo console is configured.
> > 
> > This patch prevent the pipe state from changing to nat-pipe state if
> > some cygwin process is reading input from the cyg-pipe.
> > 
> > Fixes: f20641789427 ("Cygwin: pty: Reduce unecessary input transfer.")
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > ---
> > v2: Release all masks owned by myself on cleanup()
> > v3: Reverts the change that made num_reader and slave_reading shared
> > 
> >  winsup/cygwin/fhandler/pty.cc | 27 +++++++++++++++++++++++----
> >  1 file changed, 23 insertions(+), 4 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> > index ca85ae679..963f95801 100644
> > --- a/winsup/cygwin/fhandler/pty.cc
> > +++ b/winsup/cygwin/fhandler/pty.cc
> > @@ -1282,6 +1282,10 @@ fhandler_pty_slave::open_setup (int flags)
> >  void
> >  fhandler_pty_slave::cleanup ()
> >  {
> > +  fhandler_pty_slave *arch = (fhandler_pty_slave *) archetype ? : this;
> > +  while (arch->num_reader)
> > +    mask_switch_to_nat_pipe (false, false);
> > +
> >    if (get_ttyp ()->pcon_activated && get_ttyp ()->getpgid () == myself->pgid)
> >      req_fixup_pcon_state ();
> >  
> > @@ -1543,19 +1547,22 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
> >  void
> >  fhandler_pty_slave::mask_switch_to_nat_pipe (bool mask, bool xfer)
> >  {
> > +  acquire_attach_mutex (mutex_timeout);
> >    char name[MAX_PATH];
> >    shared_name (name, TTY_SLAVE_READING, get_minor ());
> >    HANDLE masked = OpenEvent (READ_CONTROL, FALSE, name);
> >    CloseHandle (masked);
> >  
> > +  fhandler_pty_slave *arch = (fhandler_pty_slave *) archetype ? : this;
> >    WaitForSingleObject (input_mutex, mutex_timeout);
> >    if (mask)
> >      {
> > -      if (InterlockedIncrement (&num_reader) == 1)
> > -	slave_reading = CreateEvent (&sec_none_nih, TRUE, FALSE, name);
> > +      if (InterlockedIncrement (&arch->num_reader) == 1)
> > +	arch->slave_reading = CreateEvent (&sec_none_nih, TRUE, FALSE, name);
> >      }
> > -  else if (InterlockedDecrement (&num_reader) == 0)
> > -    CloseHandle (slave_reading);
> > +  else if (InterlockedDecrement (&arch->num_reader) == 0)
> > +    CloseHandle (arch->slave_reading);
> > +  release_attach_mutex ();
> 
> The acquisition order here is attach_mutex first, then input_mutex.
> Elsewhere in pty.cc the established order is the opposite: input_mutex
> first, and attach_mutex only around the transfer_input call inside.
> See for example setpgid_aux and cleanup_for_non_cygwin_app, both of
> which do
> 
>         WaitForSingleObject (input_mutex, mutex_timeout);
>         ...
>         acquire_attach_mutex (mutex_timeout);
>         transfer_input (...);
>         release_attach_mutex ();
>         ...
>         ReleaseMutex (input_mutex);
> 
> and the same pattern appears at the open_setup path as well as two
> further sites in pty.cc.
> 
> Since attach_mutex is a per-process unnamed mutex, declared and lazily
> created at winsup/cygwin/fhandler/console.cc:1012-1015 in cygwin-3.6.9 as
> 
>         extern HANDLE attach_mutex;
>         if (!attach_mutex)
>           attach_mutex = CreateMutex (&sec_none_nih, FALSE, NULL);
> 
> this cannot deadlock across processes. It _can_ deadlock intra-process,
> though: thread T1 in mask_switch_to_nat_pipe holds attach_mutex and waits
> for input_mutex, while thread T2 in setpgid_aux (or any of the other
> input_mutex-then-attach_mutex sites) holds input_mutex and waits for
> attach_mutex. mutex_timeout is INFINITE on the normal paths (the 0-timeout
> variants only appear on the GDB paths), so the resulting hang would be
> hard rather than a graceful timeout. Threaded cygwin readers on a pty
> (python with threads, tmux, gdb driving an inferior) are the plausible
> triggers.
> 
> For the record, I had Claude check that no direct caller of
> mask_switch_to_nat_pipe already holds input_mutex when calling it (the
> read path even explicitly releases input_mutex before the
> mask_switch_to_nat_pipe (false, false) call); so the risk is entirely from
> a _concurrent_ thread in the same process, not from the caller itself.
> 
> Two possible shapes. The simplest is to swap the order inside
> mask_switch_to_nat_pipe so it matches the rest of the file: acquire
> input_mutex first, then attach_mutex around the CreateEvent/CloseHandle
> block, and release in reverse. The interlock against transfer_input's
> OpenEvent existence check should still hold, since transfer_input's
> callers already take input_mutex before attach_mutex. If instead the new
> order is required for some reason I am missing, it would be worth a
> comment near the acquire explaining why, plus an audit that no
> input_mutex-holding path can want attach_mutex from a concurrent thread.
> Does the reasoning make sense to you, and does the swap sound right?

OMG! Acquiring attach_mutex here is not correct. As I said in the previous
mail, transfer_input() is guarded by input_mutex by caller. (attach_mutex
is also acquired, important here is input_mutex.) I do not remember why
I made that mistake.

To be correct, we should extend the period protected by input_mutex in
mask_switch_to_nat_pipe().

Please have a look at v4 patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
