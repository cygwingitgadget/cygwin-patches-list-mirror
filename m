Return-Path: <SRS0=TCz0=E7=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:25])
	by sourceware.org (Postfix) with ESMTPS id CDCF24BA2E07
	for <cygwin-patches@cygwin.com>; Sun,  5 Jul 2026 15:38:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CDCF24BA2E07
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CDCF24BA2E07
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783265929; cv=none;
	b=wH5/e9tKYGYylB6DaS6sdKZB0KGviyp4ruTu9WxfLq7/FgNFAorv5i1I0vj2QSn9SetJ+lwI9uXxBPOpxZIRtU5nNsVZA+QrCYtLafSLWr7Ez0HxiqWICDTZJONXsNWPUDREOEX6ByW9YK7GOmkaO2QsjD2es+gwwg7ni3QtVoY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783265929; c=relaxed/simple;
	bh=+Oc74f/dvmCIjLHCC2cW3ye77vHLH9nhzSNT2fLXWfM=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=At5X8uEK4p1j5TeQjdKPX/WzErCp3UmmS2qCl2on0q/mn7plLogZgi0MM3dNXl0Jqx7uFTq6M/wLUL1BEEBMJuSqEjUGvzk/s0P0IgdtFHdC2dNd7+lG19/c0kp765f/NBcfPpoXJb5PCzN2cP9PYahKnuZrHlf4f5CA4uWKBjg=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=DJ3STNfJ
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CDCF24BA2E07
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=DJ3STNfJ
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260705153846498.FRTS.117312.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 6 Jul 2026 00:38:46 +0900
Date: Mon, 6 Jul 2026 00:38:45 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Correct previous NOFLSH fix
Message-Id: <20260706003845.d75e5c40b0783e2197f20596@nifty.ne.jp>
In-Reply-To: <8a82def9-2d48-2d9f-3a37-e9429a961945@gmx.de>
References: <20260630041017.1006-1-takashi.yano@nifty.ne.jp>
	<8a82def9-2d48-2d9f-3a37-e9429a961945@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1783265926;
 bh=zZ1LxbeYbGxG/MHgUy4jptIYDfOpY0b1lDA+S2SmKCE=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=DJ3STNfJ+L2ElD+sFIK8bqGrtj7bRZ+ClPMqn12q3mgE65QkKBJS7WhJulUUfgnRRcvJWo9S
 A0PBk7B8qcPSU5sr9D7ppmuVzK6vTUofv/O6EzAkKUiQh6W8c/OeWerp6ar14TVUr895GU0H1H
 xS1n3NSfvZyiXoSM04B0uWJVwwMNAkQYMbyoHTSP6X9gJz+0MCTLUWRMpdDMul29Ymx6Pez3c+
 71rrri3QRrAzDjg9mj4KnBec0B00G0bh+1dzTKGTLR5jAFnbwotRzp1ky6VDu2ZpVmSA3p8bjC
 aYjLht2qCtN2yQPukeTleE15qZpFOX9UsyINWMxLtR7voIIQ==
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sun, 5 Jul 2026 10:05:31 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> Thank you for v2. It cleanly addresses the blocking `ReadConsoleInputW()`
> in `sigflush()` and the underflow in `discard_key_events()`, and moving
> the attach into the helper is the right cleanup. There is one concern I
> would like to talk through, though: the new unconditional `tcflush
> (TCIFLUSH)` in `process_sigs()`.
> 
> On Tue, 30 Jun 2026, Takashi Yano wrote:
> 
> > The previous fix for NOFLSH mode does not work as intended.
> > 
> > discard_key_events(), added in "Cygwin: console: Fix NOFLSH behaviour a
> > bit", loops on ReadConsoleInputW() until it has consumed the requested
> > number of records, but ReadConsoleInputW() blocks while the console
> > input buffer is empty. sigflush() calls it with a hard-coded count of
> > one and no guarantee that a record is actually queued: in the
> > master-thread path the signalling record has already been read out of
> > the buffer before sigflush() runs, so the call blocks until, and then
> > swallows, the user's next keystroke.
> > 
> > To avoid this, this patch does not discard input when process_sigs()
> > is called from cons_master_thread, where the value of `fh` is NULL,
> > because discarding will be done in cons_master_thread.
> > 
> > And because the ReadConsoleInputW() return value is unchecked, a failed
> > read leaves the count indeterminate, so "n -= n1" can underflow and spin.
> > Check return value of ReadConsoleInputW() and abort if it fails.
> > 
> > Moreover, discard_key_event(1) does not work as intended if the first
> > key event is not a bKeyDown event correspoding to the signalling key.
> > Use tcflush() instead(). Since the ey-strokes prior to the signalling
> > key are already in the readahead buffer, so tcflush() discards only
> > the signalling key.
> 
> Let's keep this sentence in mind, and continue the discussion below:
> 
> > The important point here is to discard input before
> > releasing input_mutex by release_input_mutex_if_necessary(), because,
> > if not, cons_master_thread starts to process key events before discarding
> > signalling key event because the thread can acquire input_mutex. This
> > causes the signalling key is processed twice.
> > 
> > One separate point: the `process_input_message()` caller wraps
> > `discard_key_events()` in `acquire_attach_mutex()` + `attach_console
> > (con.owner)`, but the `sigflush()` call site does not, so the
> > `ReadConsoleInputW()` there runs against whatever console the calling
> > process happens to be attached to. With the guard above the worst case
> > is a no-op when the calling process happens not to be attached, so
> > it would be more correct to move the attach into the helper itself.
> > 
> > Fixes: 66324edf64a9 ("Cygwin: console: Fix NOFLSH behaviour a bit")
> > Co-authored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by:
> > ---
> >  winsup/cygwin/fhandler/console.cc | 17 ++++++++---------
> >  winsup/cygwin/fhandler/termios.cc | 21 +++++++++++----------
> >  2 files changed, 19 insertions(+), 19 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> > index 730bb0b45..925db828c 100644
> > --- a/winsup/cygwin/fhandler/console.cc
> > +++ b/winsup/cygwin/fhandler/console.cc
> > @@ -1749,16 +1749,10 @@ out:
> >    DWORD discard_len = min (total_read, i + 1);
> >    /* If input is signalled, do not discard input here because
> >       tcflush() is already called from line_edit(). */
> > -  if (stat == input_signalled && !(ti->c_lflag & NOFLSH))
> > +  if (stat == input_signalled)
> >      discard_len = 0;
> >    if (discard_len && (len || stat != input_ok))
> > -    {
> > -      acquire_attach_mutex (mutex_timeout);
> > -      DWORD resume_pid = attach_console (con.owner);
> > -      discard_key_events (discard_len);
> > -      detach_console (resume_pid, con.owner);
> > -      release_attach_mutex ();
> > -    }
> > +    discard_key_events (discard_len);
> >    return stat;
> >  }
> >  
> > @@ -1768,13 +1762,18 @@ fhandler_console::discard_key_events (size_t n)
> >    DWORD discarded = 0;
> >    INPUT_RECORD input_rec[INREC_SIZE];
> >    DWORD n1 = min (INREC_SIZE, n);
> > +  acquire_attach_mutex (mutex_timeout);
> > +  DWORD resume_pid = attach_console (con.owner);
> >    while (n)
> >      {
> > -      ReadConsoleInputW (get_handle (), input_rec, n1, &n1);
> > +      if (!ReadConsoleInputW (get_handle (), input_rec, n1, &n1) || !n1)
> > +	break;
> >        n -= n1;
> >        discarded += n1;
> >        n1 = min (INREC_SIZE, n);
> >      }
> > +  detach_console (resume_pid, con.owner);
> > +  release_attach_mutex ();
> >    con.num_processed -= min (con.num_processed, discarded);
> >  }
> >  
> > diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
> > index 605258731..c59027093 100644
> > --- a/winsup/cygwin/fhandler/termios.cc
> > +++ b/winsup/cygwin/fhandler/termios.cc
> > @@ -444,10 +444,15 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
> >  	goto not_a_sig;
> >  
> >        termios_printf ("got interrupt %d, sending signal %d", c, sig);
> > -      if (!(ti.c_lflag & NOFLSH) && fh)
> > +      if (fh)
> >  	{
> > -	  fh->eat_readahead (-1);
> > -	  fh->discard_input ();
> > +	  if (!(ti.c_lflag & NOFLSH))
> > +	    {
> > +	      fh->eat_readahead (-1);
> > +	      fh->discard_input ();
> > +	    }
> > +	  if (fh->is_console ())
> > +	    fh->tcflush (TCIFLUSH);
> 
> That invariant holds for records `line_edit()` has already consumed from
> the console input buffer. It does not hold for records that were peeked
> in the same `PeekConsoleInputW()` batch but sit at indices after the
> signalling record, nor for records that arrive during the yield window
> before `process_input_message()` drains the batch. Both of those cases
> stay in the console input buffer and get dropped by the new `tcflush()`
> along with the signalling record.
> 
> Concretely: `process_input_message()` obtains records via
> `PeekConsoleInputW()` rather than consuming them, then walks
> `0..total_read-1`. If a signalling character (say `^C`) sits at index
> `i`, `line_edit()` has run for indices `0..i-1`, then `process_sigs()`
> on the signalling byte returns `signalled`, control jumps to `out`, and
> the new code sets `discard_len = 0`. All `total_read` records still sit
> in the console input buffer at the moment `process_sigs()` runs, and
> `fh->tcflush (TCIFLUSH)` (backed by `FlushConsoleInputBuffer()`) drops
> all of them, regardless of `NOFLSH`.
> 
> The yield window that makes this a normal-load hazard, rather than a
> corner case, is the backoff heuristic in `cons_master_thread()` with the
> explicit comment "read() seems to be called. Process special keys in
> `process_input_message ()`.". When it fires, `master_thread_suspended`
> is set to `true` and the master thread yields; type-ahead then
> accumulates in the console input buffer until `process_input_message()`
> picks it up.
> 
> Compare with the master thread's own signal handling in
> `cons_master_thread()` where `signalled` with `NOFLSH` set does
> `goto remove_record` and writes the surviving records back, preserving
> type-ahead. The new user-thread path, by contrast, flushes
> unconditionally, so the two paths disagree on `NOFLSH` semantics.
> 
> For completeness, there is also a narrower reachable state where
> `disable_master_thread=true` coexists with `curr_input_mode=cygwin`,
> entered via the win32-input-mode DEC private mode 9001 handler which
> flips `disable_master_thread` without touching `curr_input_mode`, so
> the guard in `fhandler_console::bg_check()` does not fire. Narrower
> than the type-ahead case, but worth flagging while we are here.

Thanks for pointing this out.

> Two ways I could see to resolve it, and I have no strong preference:
> 
> (a) Gate the new `tcflush (TCIFLUSH)` on `!(ti.c_lflag & NOFLSH)`,
> matching the `eat_readahead()` / `discard_input()` branch immediately
> above and the reshaped `sigflush()`.
> 
> (b) Replace `tcflush (TCIFLUSH)` with a targeted single-record consume
> via `ReadConsoleInputW()` (bounded and return-checked, in the shape of
> the rewritten `discard_key_events()`), so only the signalling record is
> dropped and `NOFLSH` type-ahead survives.
> 
> Does that reasoning make sense to you?

Yes, thanks.
I'd like to apply approach (b). Add n == 0 case in discard_key_events(),
which means discarding to the current position processed, and call it in
the process_sigs().

Please have a look v2 patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
