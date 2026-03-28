Return-Path: <SRS0=/csx=B4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id 3186B4BA23D0
	for <cygwin-patches@cygwin.com>; Sat, 28 Mar 2026 10:15:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3186B4BA23D0
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3186B4BA23D0
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774692919; cv=none;
	b=fA2FN/Zo6lznCVUpdcRIm/m2R+xVyq4o5F0MJ2zppkc4720XwaaoZvuiSXMboxLmX2689HXBjh2Qnw1Kq1Y+xrSAKsJYh32FsAMy1jIay4ghiK87zju4Mpjmw4YOqk/yA0i4IsQcDKtRHUa+RX7R3Q0y1DzKH7sJiNKejiAtgxM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774692919; c=relaxed/simple;
	bh=eRVyZdsOt9ZCvlJJE7qT4kn6b/cwF5NGDwauRWJROtI=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=A3tYIRXdXvzqEm8ajuv2QYxUGSTaSv//vJl9eFi/F8h+2xmr6sA2C1CnuIfRdD+kmFNzodgTNDUy3nQsfBuKqpZJ9u9KryYzQ/Gl5ZrQJ0i9um3b3sytJtNPdTEuLZEMyw21WRyXG6mQHl28gP/nhLBFWfREK4J1F34fME1eeeo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3186B4BA23D0
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=jxS44Qzw
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260328101516015.OZMP.19957.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sat, 28 Mar 2026 19:15:16 +0900
Date: Sat, 28 Mar 2026 19:15:14 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v7 2/7] Cygwin: pty: Add workaround for handling of
 backspace when pcon enabled
Message-Id: <20260328191514.360fed717ef42a086bac019b@nifty.ne.jp>
In-Reply-To: <4ef32266-f86b-0555-62a8-16df5e879a24@gmx.de>
References: <20260321113613.9443-1-takashi.yano@nifty.ne.jp>
	<20260325130453.62246-1-takashi.yano@nifty.ne.jp>
	<20260325130453.62246-3-takashi.yano@nifty.ne.jp>
	<4ef32266-f86b-0555-62a8-16df5e879a24@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774692916;
 bh=bkt896mJA3ILMzcFHe/0YA8LhdyxRbEgvfKKU3NKkF4=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=jxS44QzwUsi0EMVokQ7BOw+SL1in5HMvD/Ibs/OJYnrgPtlNtLFBp+Aet+hBNYvd8EQeBGsC
 2EpZ18k2JoKQfxrQCa5CxAKa7MdbjHdQbQGd1HCvWM/wDP1ET3Ri5sPsTG01NFYi/z9PqHiva8
 VDzVyEtVnrK1aVUPdd1gMQF2x1KF75NLNgoJ0nH821giEiV+1OAl/Fwv8WgYbrx0nWi+zdAIG+
 0pOAEBZAR/QFlyGDGjIoCVCO+cPbGFWtSnpdlt7Zic2V1X2iuAbca7R8XsdvsMQFIS+FnX4R5Q
 u2cRpa1CzfxipjEk3o+Bgtv2A5Ao8JWSwm/QEi7F+oZISh3Q==
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

Thanks for reviewing!

On Fri, 27 Mar 2026 14:25:50 +0100 (CET)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> First, I want to acknowledge that this version is a significant
> improvement over the previous version that interleaved `WriteFile()` calls
> to the pipe with `WriteConsoleInput()` calls to a different handle, which
> was fundamentally racy. The v7 approach is much more robust: pre-convert
> 0x08 to 0x7F before writing to the pipe, knowing that conhost's buggy
> reverse path will convert it back. This is a legitimate work-around.
> 
> That said, I have a few comments, starting with the commit message:
> 
> On Wed, 25 Mar 2026, Takashi Yano wrote:
> 
> > In Windows 11, pseudo console has a weird behaviour that the Ctrl-H
> > is translated into Ctrl-Backspace (not Backspace). Similary, Backspace
> > (0x7f) is translated into Ctrl-H.
> 
> As I pointed out in
> 
>   https://inbox.sourceware.org/cygwin-patches/2f8628d2-b79a-95a6-480d-7508375958d5@gmx.de/
> 
> (where I also included a proper fix for the upstream bug, to be submitted
> pending testing), this should not be described vaguely as "a weird
> behaviour". The root cause is well understood: the reverse VT input path
> in conhost's `_DoControlCharacter()` maps the byte 0x08 to a
> Ctrl+Backspace key event (VK_BACK with LEFT_CTRL_PRESSED and character
> 0x7F). This was introduced in PR #3935 (Jan 2020) to make Ctrl+Backspace
> delete whole words. In September 2022, PR #13894 rewrote the forward path
> to properly implement DECBKM (Backarrow Key Mode), but the reverse path
> was never updated to match, breaking the roundtrip.
> 
> The commit message should say that, not "a weird behaviour".
> 
> > Due to this behaviour, inrec_eq() in cons_master_thread() fails to
> > compare backspace/Ctrl-H events in the input record sequence. This patch
> > is a workaround for the issue that replaces Ctrl-H with backspace
> > (0x7f), which will be translated into Ctrl-H in pseudo console.
> > 
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > ---
> >  winsup/cygwin/fhandler/console.cc | 12 ++++++-
> >  winsup/cygwin/fhandler/pty.cc     | 57 ++++++++++++++++++++++++++-----
> >  2 files changed, 60 insertions(+), 9 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> > index 2f59f8f24..9678775d1 100644
> > --- a/winsup/cygwin/fhandler/console.cc
> > +++ b/winsup/cygwin/fhandler/console.cc
> > @@ -318,6 +318,16 @@ inrec_eq (const INPUT_RECORD *a, const INPUT_RECORD *b, DWORD n)
> >  	     written event. Therefore they are ignored. */
> >  	  const KEY_EVENT_RECORD *ak = &a[i].Event.KeyEvent;
> >  	  const KEY_EVENT_RECORD *bk = &b[i].Event.KeyEvent;
> > +	  WCHAR c1 = ak->uChar.UnicodeChar;
> > +	  WCHAR c2 = bk->uChar.UnicodeChar;
> > +	  if (inside_pcon)
> > +	    {
> > +	      /* Workaround for pseudo console in Windows 11 */
> > +	      if (c1 == 8) /* Ctrl-H */
> > +		c1 = 127; /* Backspace */
> > +	      if (c2 == 8) /* Ctrl-H */
> > +		c2 = 127; /* Backspace */
> > +	    }
> 
> 
> This change in `inrec_eq()` makes sense as a companion to the
> pre-conversion: `transfer_input()` reads back INPUT_RECORDs that went
> through conhost's buggy reverse path, so the comparison needs to treat
> 0x08 and 0x7F as equivalent.
> 
> >  	  /* Fixup repeat count */
> >  	  WORD r1 = ak->wRepeatCount;
> >  	  WORD r2 = bk->wRepeatCount;
> > @@ -326,7 +336,7 @@ inrec_eq (const INPUT_RECORD *a, const INPUT_RECORD *b, DWORD n)
> >  	  if (r2 == 0)
> >  	    r2 = 1;
> >  	  if (ak->bKeyDown != bk->bKeyDown
> > -	      || ak->uChar.UnicodeChar != bk->uChar.UnicodeChar
> > +	      || c1 != c2
> >  	      || r1 != r2)
> >  	    return false;
> >  	}
> > diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> > index 371e67103..72a8ba140 100644
> > --- a/winsup/cygwin/fhandler/pty.cc
> > +++ b/winsup/cygwin/fhandler/pty.cc
> > @@ -2266,28 +2266,65 @@ fhandler_pty_master::write (const void *ptr, size_t len)
> >      { /* Reaches here when non-cygwin app is foreground and pseudo console
> >  	 is activated. */
> >        tmp_pathbuf tp;
> > -      char *buf = (char *) ptr;
> > +      char *buf = tp.c_get ();
> >        size_t nlen = len;
> >        if (get_ttyp ()->term_code_page != CP_UTF8)
> >  	{
> >  	  static mbstate_t mbp;
> > -	  buf = tp.c_get ();
> >  	  nlen = NT_MAX_PATH;
> >  	  convert_mb_str (CP_UTF8, buf, &nlen,
> >  			  get_ttyp ()->term_code_page, (const char *) ptr, len,
> >  			  &mbp);
> >  	}
> > +      else
> > +	memcpy (buf, ptr, nlen);
> > +
> > +      /* Retrieve console mode */
> > +      HANDLE h_pcon_in = get_ttyp ()->h_pcon_in;
> > +      DWORD cons_mode;
> > +      if (!nat_pipe_owner_self (get_ttyp ()->nat_pipe_owner_pid))
> > +	{
> > +	  HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
> > +					   get_ttyp ()->nat_pipe_owner_pid);
> > +	  DuplicateHandle (pcon_owner, h_pcon_in,
> > +			   GetCurrentProcess (), &h_pcon_in,
> > +			   0, FALSE, DUPLICATE_SAME_ACCESS);
> > +	  CloseHandle(pcon_owner);
> 
> 
> Two issues here.
> 
> First, a correctness issue: there is no NULL check on the `OpenProcess()`
> return value. If the owner process exited between reading
> `nat_pipe_owner_pid` from shared memory and calling `OpenProcess()`, then
> `pcon_owner` is NULL, `DuplicateHandle(NULL, ...)` will fail, `h_pcon_in`
> will have an undefined value, and `GetConsoleMode()` below will read
> garbage (or crash). This needs at minimum a NULL check on `pcon_owner`,
> with a fallback path.
> 
> Second, a performance concern: this entire sequence (`OpenProcess()` +
> `DuplicateHandle()` + `attach_console_temporarily()` + `GetConsoleMode()`
> + `resume_from_temporarily_attach()` + `CloseHandle()`) runs on _every_
> call to master::write() in the fast path, even when no 0x08 byte is
> present in the buffer. The console mode retrieval should either be moved
> inside the conversion loop (only executed when a 0x08 byte is actually
> encountered), or cached (although caching the value might run afoul of
> time of check vs time of use ("TOCTOU") issues).
> 
> > +	  DWORD resume_pid =
> > +	    attach_console_temporarily (get_ttyp()->nat_pipe_owner_pid);
> > +	  GetConsoleMode (h_pcon_in, &cons_mode);
> > +	  resume_from_temporarily_attach (resume_pid);
> > +	  CloseHandle (h_pcon_in);
> > +	}
> > +      else
> > +	GetConsoleMode (h_pcon_in, &cons_mode);
> >  
> > -      for (size_t i = 0; i < nlen; i++)
> > +      for (size_t i = 0, j = 0; i < nlen; i++)
> >  	{
> >  	  process_sig_state r = process_sigs (buf[i], get_ttyp (), this);
> > -	  if (r == done_with_debugger)
> > +	  if (r != done_with_debugger)
> >  	    {
> > -	      for (size_t j = i; j < nlen - 1; j++)
> > -		buf[j] = buf[j + 1];
> > -	      nlen--;
> > -	      i--;
> > +	      char c = buf[i];
> > +	      if (!(cons_mode & ENABLE_VIRTUAL_TERMINAL_INPUT))
> > +		/* Workaround for pseudo console in Windows 11 */
> > +		/* Undesired backspace conversion in pseudo console does
> > +		   not happen if ENABLE_VIRTUAL_TERMINAL_INPUT is set. */
> > +		switch (c)
> > +		  {
> > +		  case '\010': /* Ctrl-H */
> > +		    c = '\177'; /* Backspace */
> > +		    break;
> > +		  case '\177': /* Backspace */
> > +#if 0 /* Unfortunately, Ctrl-H will be translated into Ctrl-Backspace
> > +	 (not Backspace) */
> > +		    c = '\010'; /* Ctrl-H */
> > +#endif
> 
> 
> The `#if 0` dead code should either be removed entirely or replaced with
> a comment explaining _why_ the reverse mapping cannot work (and ideally
> referencing the conhost bug, so a future reader knows when it might
> become safe to revisit). Dead code guarded by `#if 0` without a tracking
> reference is confusing for future readers (which might very well be me).
> 
> > +		    break;
> > +		  }
> > +	      buf[j++] = c;
> >  	    }
> > +	  else
> > +	    nlen--;
> >  	}
> >  
> >        DWORD n;
> > @@ -4031,6 +4068,10 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
> >  	    if (r[i].EventType == KEY_EVENT && r[i].Event.KeyEvent.bKeyDown)
> >  	      {
> >  		DWORD ctrl_key_state = r[i].Event.KeyEvent.dwControlKeyState;
> > +		if (r[i].Event.KeyEvent.uChar.AsciiChar == '\010' /* Ctrl-H */
> > +		    && !(ctrl_key_state & ALT_PRESSED))
> > +		  /* Workaround for pseudo console in Windows 11 */
> > +		  r[i].Event.KeyEvent.uChar.AsciiChar = '\177'; /* Backspace */
> 
> This is the corresponding fix in `transfer_input()`: When reading
> INPUT_RECORDs back from the console buffer in `transfer_input()`, they
> have already been through conhost's buggy reverse path, so the 0x08 needs
> to be mapped back to 0x7F here too. Consistent with the pre-conversion in
> `master::write()`.
> 
> One open question that I already asked in
> 
>   https://inbox.sourceware.org/cygwin-patches/c4dc071d-fa7e-ed2e-0c14-3fddb5240f1c@gmx.de/
> 
> but have not yet received an answer to: how was this bug originally
> discovered/reproduced? I still do not know how to trigger the Backspace
> problem in a regular Windows Terminal running on OpenConsole.exe, and I
> need a concrete repro to test the upstream fix I prepared.

I encountered the issue that Ctrl-H on cmd.exe running in pseudo console
erases word (not char). This is because, Ctrl-H (0x08) is translated to
Ctrl-Backspace in conhost.exe which erases a word (in Windows 11).

But I do not see similar problem in Windows Terminal. In Windoes Terminal,
both Ctrl-H and Backspace are translated to 0x08. I'm not sure why.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
