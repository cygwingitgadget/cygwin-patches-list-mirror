Return-Path: <SRS0=mhjT=CS=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 68D9D4BA2E27
	for <cygwin-patches@cygwin.com>; Sun, 19 Apr 2026 01:41:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 68D9D4BA2E27
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 68D9D4BA2E27
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1776562918; cv=none;
	b=LBHHbFgod5yG+5CUELWoynPbyr+PIOo4Wn0ohHIc3nmWF4PfhGSQg8oHNRUr3M7EraP15Vr1ZnRcqdJ8yR6zFic9Uohu1QavqKYZs6WG8WmDancYOOfJ+L9Flwlel3HMtlc+93JDaWYZCGDgpLibnaEEipmjUxk5OofiaWFrEc0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1776562918; c=relaxed/simple;
	bh=MT8Od8zvVKCSzSYi2I7BMowCxzsB+TmPQtT71hY0JTk=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=fF3mDeoTnhLC9cjakMuFLtu1xAUHdnqy0U4v9e8d9943soT6OuXlXe2Xqti4u6Tsy9lueKL19ku4ZznnUsFNWHpRD0iUzwYSNgERvPaX3AoRbfKvXRUZq+teUlU/cHjHwz52hxcqFA6EpN6e1MQlsTjOWoqdhpWpclCKxGGYZ1Y=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 68D9D4BA2E27
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=qwBlvvpn
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260419014153452.TTRP.14880.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 19 Apr 2026 10:41:53 +0900
Date: Sun, 19 Apr 2026 10:41:52 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v6 3/3] Cygwin: console: Fix master thread for
 OpenConsole.exe
Message-Id: <20260419104152.6ac336f9504fd1e38bf5171c@nifty.ne.jp>
In-Reply-To: <5266689e-9b2b-3bab-6c5e-2678998e5558@gmx.de>
References: <20260312113923.1528-1-takashi.yano@nifty.ne.jp>
	<20260325131056.69116-1-takashi.yano@nifty.ne.jp>
	<20260325131056.69116-4-takashi.yano@nifty.ne.jp>
	<fa6ac2e9-1eec-ffde-5fe8-17bc957f3528@gmx.de>
	<20260407212747.b84f2178e723c9645cd06799@nifty.ne.jp>
	<5266689e-9b2b-3bab-6c5e-2678998e5558@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1776562913;
 bh=2/yveyhQHGEqlhNkO9V4UxRMaKk+OmdqpIzHlQzhmCY=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=qwBlvvpnkh6a1PwxyA5s26n40Rqr6xtIXVcGbb4YVn/JO8GLJSpVFfKy9j5kaft0Vnr4UzEz
 7toj04tpkQOClXqOhMfEcHMbU6bPsoR7tcUMaSzPZ6gM2xQzrAgaI1gcQ2XKlOW7V9pVEWfbpa
 aApd/pjtENscsrpkeIhAwh65FAJR/vjBZusQKDxJqoXZuDzzjICcUSHjuj5+9K3sdAsS89zapX
 96+AKb4dh+FDRRRQjQhfIG31J0w/flkJYDQ3Kij/0/aimiwxXcgDIJZmOZaUIxjs5oLdQppHLO
 kvufvhRTkjtyWGwAv3I1bxfOZzTd1X3vwHSbVzS+60gzUJag==
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

Thanks for reviewing and the highly valuable discussion!

On Sun, 19 Apr 2026 00:01:39 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> Thank you for v7. I verified that it addresses both concerns from my v6
> review: the guard is now correctly scoped to `inside_pcon && (mode &
> ENABLE_VIRTUAL_TERMINAL_INPUT)`, and the commit message explicitly covers
> the `UnicodeChar == 0` case.
> 
> On Sat, 18 Apr 2026, Takashi Yano wrote:
> 
> > On Mon, 6 Apr 2026 10:14:30 +0200 (CEST)
> > Johannes Schindelin wrote:
> > > Hi Takashi,
> > > 
> > > Thank you for the new patch. A few observations:
> > > 
> > > On Mon, 6 Apr 2026, Takashi Yano wrote:
> > > 
> > > > If the console is originating from a pseudo console, current master
> > > > thread code does not work as expected. This is because the pseudo
> > > > console does not keep all the event as is. All bKeyDown == 0 events
> > > > will be omitted from the input record written by WriteConsoleInput().
> > > >
> > > > [...]
> > > 
> > > The commit message describes this as general pseudo console behavior, but
> > > the code comment in `strip_inrec()` is more specific:
> > > 
> > > > diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> > > > index 1dd5dfa1d..1693a5be7 100644
> > > > --- a/winsup/cygwin/fhandler/console.cc
> > > > +++ b/winsup/cygwin/fhandler/console.cc
> > > > @@ -305,6 +305,23 @@ cons_master_thread (VOID *arg)
> > > >    return 0;
> > > >  }
> > > >  
> > > > +static inline DWORD
> > > > +strip_inrec (INPUT_RECORD *r, DWORD n)
> > > > +{
> > > > +  /* Pseudo console with OpenConsole.exe removes the events
> > > > +     whose bKeyDown is 0 as well as ones whose charcode is 0. */
> > > 
> > > And the patch title itself says "Fix master thread for
> > > OpenConsole.exe".
> > > 
> > > Can you help me understand: does legacy conhost.exe _also_ strip these
> > > events when used as a pseudo console host? If it does, the commit
> > > message is fine but the code comment should drop the "with
> > > OpenConsole.exe" part. If it does _not_, then guarding with
> > > `inside_pcon` is too broad: when the user sets `use_legacy_pcon`
> > > (introduced in patch 1/3 of this series), `strip_inrec()` would
> > > discard events on the Cygwin side that conhost.exe actually preserves
> > > in its input buffer. Those stripped records would then not be written
> > > back at lines 579-584, and the `inrec_eq()` comparison against the
> > > peeked buffer would also see a mismatch.
> > 
> > You are right. Legacy conhost.exe does not drop KeyUp events and
> > events without UnicodeChar for now.
> > 
> > I confirmed the behaviour more precisely using the following test code.
> > [...]
> > 
> > So, the legacy conhost.exe behaves as same as real console.
> 
> The empirical data is thorough and convincing. In particular, the
> side-by-side comparison across all three hosts (real console, legacy
> pseudo console, OpenConsole pseudo console) makes it clear that
> `strip_inrec()` is only needed when `ENABLE_VIRTUAL_TERMINAL_INPUT` is
> active.
> 
> > However:
> > 
> > > In that case, could the guard be tightened to `inside_pcon &&
> > > !use_legacy_pcon` (or a dedicated flag) so that stripping only happens
> > > when OpenConsole.exe is the actual host?
> > 
> > I’m concerned that conhost.exe in Windows 11 may start behaving the same
> > as OpenConsole.exe in the future.
> 
> That is sensible forward-looking reasoning. Guarding on the mode flag
> rather than on which console host is in use means we are prepared if
> legacy conhost converges toward OpenConsole behavior. I agree this is the
> right approach.
> 
> > [...]
> >
> > This means we have to maintain UnicodeChar == 0 and bKeyDown == 0
> > only when ENABLE_VIRTUAL_TERMINAL_INPUT is set.
> > When ENABLE_VIRTUAL_TERMINAL_INPUT is not set, all key events are
> > preserved.
> 
> Correct. And since `strip_inrec()` is now gated on the mode flag, it stays
> entirely out of the way in the common non-`ENABLE_VIRTUAL_TERMINAL_INPUT`
> case. The logic is clean.
> 
> Two typos in the code comment at the `WAIT_OBJECT_0` case (Corinna tends
> to care about these):
> 
> 	s/simlified/simplified/
> 
> 	s/whth/with/
> 
> One observation for posterity, not something to hold up the patch. Under
> legacy conhost with `ENABLE_VIRTUAL_TERMINAL_INPUT` enabled,
> `strip_inrec()` will discard key-up and `UnicodeChar == 0` events that
> conhost _does_ still deliver. Two code paths in `process_input_message()`
> consume those events:
> 
> Raw Win32 keyboard mode (`CSI?2000h`), which encodes `bKeyDown` into the
> escape sequence:
> https://github.com/cygwin/cygwin/blob/cygwin-3.6.7/winsup/cygwin/fhandler/console.cc#L1306-L1317
> 
> And Alt+Numpad composed character handling, which relies on the Alt key-up
> event:
> https://github.com/cygwin/cygwin/blob/cygwin-3.6.7/winsup/cygwin/fhandler/console.cc#L1320-L1323
> 
> Since `cons_master_thread()` writes back the already-stripped records,
> `process_input_message()` never sees those events. Under OpenConsole this
> is moot because the events are already absent from the input buffer. For
> legacy conhost with `ENABLE_VIRTUAL_TERMINAL_INPUT` it _is_ an observable
> behavioral change, but both scenarios are niche (I doubt that raw Win32
> keyboard mode is combined often with `ENABLE_VIRTUAL_TERMINAL_INPUT`, and
> Alt+Numpad input under a pseudo console is an unusual configuration to
> begin with). Just worth keeping in mind for a possible follow-up if
> someone reports a regression in either path.

Noted. Thanks.

> With the two typos fixed:
> 
>   Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Thank you!,
> Johannes

Pushed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
