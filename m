Return-Path: <SRS0=Vzu2=CG=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id B786C4BA2E05
	for <cygwin-patches@cygwin.com>; Tue,  7 Apr 2026 12:27:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B786C4BA2E05
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B786C4BA2E05
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1775564877; cv=none;
	b=C8OUL/w3xbBRrO24XX4gfBLIORkVPPHAXsZd25jo4Tonk1qdgLlrcTI59utULE5HVmeT6bM8HzuaFKncis7nUJmUWR2k9zshKpet/0LFu2fIW3CGlj5Y4zI3mFKmE+0/9B6lXrz3BinQx4Ty92p/M1ZGqB4GsBOR9xlONjOJlv8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1775564877; c=relaxed/simple;
	bh=c5aji2ZA++CQrlEWKgGEO6WQf7LGxaE/p6RCjsZWQ38=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=TGjPr45cF5c16/T+fxOeH8m9DJ84y61Fwek5tqqJDv6EdGJvofS3tBmbSGWQmP07Vme17YUg3djpeN6zLeIQ40oY4tsmqx+rPA0Njjg12Z46nP02cHhH1mMr0ZflfgimRgQyk2F+iIVpAbB4Xr8bqawTZKFI9QfrjN4rISwyleU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B786C4BA2E05
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Q1yl1Pap
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260407122749677.PPCF.14880.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 7 Apr 2026 21:27:49 +0900
Date: Tue, 7 Apr 2026 21:27:47 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v6 3/3] Cygwin: console: Fix master thread for
 OpenConsole.exe
Message-Id: <20260407212747.b84f2178e723c9645cd06799@nifty.ne.jp>
In-Reply-To: <fa6ac2e9-1eec-ffde-5fe8-17bc957f3528@gmx.de>
References: <20260312113923.1528-1-takashi.yano@nifty.ne.jp>
	<20260325131056.69116-1-takashi.yano@nifty.ne.jp>
	<20260325131056.69116-4-takashi.yano@nifty.ne.jp>
	<fa6ac2e9-1eec-ffde-5fe8-17bc957f3528@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1775564869;
 bh=CDvs68bu3a4sircN9duiVpX80uvsqKCSxQlJ/YhBe8M=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=Q1yl1PapM9VrcX9qznpCh8yrjfoizYSNI/YSKcQZCqcfxck3cMv+45QUek6i0OZKWK+MNh/4
 YoUhpB+BR3LZBf5KB61AjIfDnZBVmeeXS/Af8q4fNxtczeF4IlL3SM5AJ+mTKNqF30O86u8vQX
 3Qb4cZRx63Mnmfcso9riyshbTsVG8lmKrvQTCT7liKKnALujVWihKK8rrI2w237w1kQIjDD7H+
 N3CgZrJq7rNvY//ku2muyY2STwTi3eei/c+lHOvEZJCNZmeTEtB2mnGoeREcnL0N6f4AJd6ecQ
 QYefLWznGfdiIjdPbUjCoVnrc81lpuLeKaPtjY0zQCvH6oNw==
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

Thanks for revewing this patch.

On Mon, 6 Apr 2026 10:14:30 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> Thank you for the new patch. A few observations:
> 
> On Mon, 6 Apr 2026, Takashi Yano wrote:
> 
> > If the console is originating from a pseudo console, current master
> > thread code does not work as expected. This is because the pseudo
> > console does not keep all the event as is. All bKeyDown == 0 events
> > will be omitted from the input record written by WriteConsoleInput().
> >
> > [...]
> 
> The commit message describes this as general pseudo console behavior, but
> the code comment in `strip_inrec()` is more specific:
> 
> > diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> > index 1dd5dfa1d..1693a5be7 100644
> > --- a/winsup/cygwin/fhandler/console.cc
> > +++ b/winsup/cygwin/fhandler/console.cc
> > @@ -305,6 +305,23 @@ cons_master_thread (VOID *arg)
> >    return 0;
> >  }
> >  
> > +static inline DWORD
> > +strip_inrec (INPUT_RECORD *r, DWORD n)
> > +{
> > +  /* Pseudo console with OpenConsole.exe removes the events
> > +     whose bKeyDown is 0 as well as ones whose charcode is 0. */
> 
> And the patch title itself says "Fix master thread for OpenConsole.exe".
> 
> Can you help me understand: does legacy conhost.exe _also_ strip these
> events when used as a pseudo console host? If it does, the commit message
> is fine but the code comment should drop the "with OpenConsole.exe" part.
> If it does _not_, then guarding with `inside_pcon` is too broad: when the
> user sets `use_legacy_pcon` (introduced in patch 1/3 of this series),
> `strip_inrec()` would discard events on the Cygwin side that conhost.exe
> actually preserves in its input buffer. Those stripped records would then
> not be written back at lines 579-584, and the `inrec_eq()` comparison
> against the peeked buffer would also see a mismatch.

You are right. Legacy conhost.exe does not drop KeyUp events and
events without UnicodeChar for now.

I confirmed the behaviour more precisely using the following test code.
This program write "shift key ->'A' key down -> 'A' key up -> shift key up"
into input record and check key events in input record. In addition,
if argument of non zero is given, change the terminal mode to
ENABLE_VIRTUAL_TERMINAL_INPUT. Compile with mingw compiler.

#include <windows.h>
#include <stdio.h>

#define BUFSIZE 16
int main(int argc, char *argv[])
{
	INPUT_RECORD r[BUFSIZE];
	DWORD n;
	DWORD mode;
	HANDLE h = GetStdHandle(STD_INPUT_HANDLE);

	/* Set console mode */
	GetConsoleMode(h, &mode);
	if (argc >= 2 && atoi(argv[1]))
		SetConsoleMode(h, mode | ENABLE_VIRTUAL_TERMINAL_INPUT);
	/* Press shift */
	r[0].EventType = KEY_EVENT;
	r[0].Event.KeyEvent.bKeyDown = 1;
	r[0].Event.KeyEvent.uChar.AsciiChar = 0;
	r[0].Event.KeyEvent.wVirtualKeyCode = 16;
	r[0].Event.KeyEvent.wVirtualScanCode = 42;
	r[0].Event.KeyEvent.dwControlKeyState = SHIFT_PRESSED;
	r[0].Event.KeyEvent.wRepeatCount = 1;
	/* Press 'A' */
	r[1].EventType = KEY_EVENT;
	r[1].Event.KeyEvent.bKeyDown = 1;
	r[1].Event.KeyEvent.uChar.AsciiChar = 65;
	r[1].Event.KeyEvent.wVirtualKeyCode = 65;
	r[1].Event.KeyEvent.wVirtualScanCode = 30;
	r[1].Event.KeyEvent.dwControlKeyState = SHIFT_PRESSED;
	r[1].Event.KeyEvent.wRepeatCount = 1;
	/* Release 'A' */
	r[2].EventType = KEY_EVENT;
	r[2].Event.KeyEvent.bKeyDown = 0;
	r[2].Event.KeyEvent.uChar.AsciiChar = 65;
	r[2].Event.KeyEvent.wVirtualKeyCode = 65;
	r[2].Event.KeyEvent.wVirtualScanCode = 30;
	r[2].Event.KeyEvent.dwControlKeyState = SHIFT_PRESSED;
	r[2].Event.KeyEvent.wRepeatCount = 1;
	/* Press shift */
	r[3].EventType = KEY_EVENT;
	r[3].Event.KeyEvent.bKeyDown = 0;
	r[3].Event.KeyEvent.uChar.AsciiChar = 0;
	r[3].Event.KeyEvent.wVirtualKeyCode = 16;
	r[3].Event.KeyEvent.wVirtualScanCode = 42;
	r[3].Event.KeyEvent.dwControlKeyState = 0;
	r[3].Event.KeyEvent.wRepeatCount = 1;
	/* Write */
	WriteConsoleInput(h, r, 4, &n);
	/* Clear */
	n = 0;
	memset(r, 0, sizeof(r));
	/* Read */
	ReadConsoleInput(h, r, BUFSIZE, &n);
	for (int i=0; i<n; i++) {
		int c = r[i].Event.KeyEvent.uChar.AsciiChar;
		printf("%d: Key %c[%02x] (%3d,%3d) %3d %2d %1d\n", i,
			isprint(c) ? c : ' ', c,
			r[i].Event.KeyEvent.wVirtualKeyCode,
			r[i].Event.KeyEvent.wVirtualScanCode,
			r[i].Event.KeyEvent.dwControlKeyState,
			r[i].Event.KeyEvent.wRepeatCount,
			r[i].Event.KeyEvent.bKeyDown);
	}
	/* Restore console mode */
	SetConsoleMode(h, mode);
	return 0;
}

Real console:
$ a.exe
0: Key  [00] ( 16, 42)  16  1 1
1: Key A[41] ( 65, 30)  16  1 1
2: Key A[41] ( 65, 30)  16  1 0
3: Key  [00] ( 16, 42)   0  1 0
$ a.exe 1
0: Key  [00] ( 16, 42)  16  1 1
1: Key A[41] (  0,  0)   0  1 1
2: Key A[41] ( 65, 30)  16  1 0
3: Key  [00] ( 16, 42)   0  1 0

Legacy pseudo console:
$ a.exe
0: Key  [00] ( 16, 42)  16  1 1
1: Key A[41] ( 65, 30)  16  1 1
2: Key A[41] ( 65, 30)  16  1 0
3: Key  [00] ( 16, 42)   0  1 0
$ a.exe 1
0: Key  [00] ( 16, 42)  16  1 1
1: Key A[41] (  0,  0)   0  1 1
2: Key A[41] ( 65, 30)  16  1 0
3: Key  [00] ( 16, 42)   0  1 0

Pseudo console with OpenConsole.exe:
$ a.exe
0: Key  [00] ( 16, 42)  16  1 1
1: Key A[41] ( 65, 30)  16  1 1
2: Key A[41] ( 65, 30)  16  1 0
3: Key  [00] ( 16, 42)   0  1 0
$ a.exe 1
0: Key A[41] (  0,  0)   0  1 1

So, the legacy conhost.exe behaves as same as real console.
However:

> In that case, could the guard be tightened to `inside_pcon &&
> !use_legacy_pcon` (or a dedicated flag) so that stripping only happens
> when OpenConsole.exe is the actual host?

I’m concerned that conhost.exe in Windows 11 may start behaving the same
as OpenConsole.exe in the future.


> > +  DWORD j = 0;
> > +  for (DWORD i = 0; i < n; i++)
> > +    {
> > +      if (r[i].EventType != KEY_EVENT)
> > +	r[j++] = r[i];
> > +      else if (r[i].Event.KeyEvent.bKeyDown
> > +	       && r[i].Event.KeyEvent.uChar.UnicodeChar)
> > +	r[j++] = r[i];
> 
> Note: this strips not only key-up events (`bKeyDown == 0`) but also
> KEY_EVENTs where `UnicodeChar == 0`, which includes arrow keys and
> function keys. For signal processing that is harmless because the existing
> loop already skips exactly those events.
> 
> However, it means those events are permanently removed from
> `input_rec`/`input_tmp` before writeback, so any downstream code that
> reads raw INPUT_RECORDs from the console input buffer (e.g. via
> `ReadConsoleInput()`) will never see them.
> 
> Is that the intended behavior with OpenConsole.exe? I.e., does
> OpenConsole.exe _also_ strip those events when it processes
> `WriteConsoleInput()`, so the records would be lost regardless? If so, the
> commit message should say so explicitly (it currently only mentions
> `bKeyDown == 0` events, not the `UnicodeChar == 0` case). If not, we might
> be discarding more than necessary.

Further investigation shows:

With ENABLE_VIRTUAL_TERMINAL_INPUT:
(1) Sending "\033[A" to pusedo console:
       Got uChar.UnicodeChar 0x1b, 0x5b, 0x41
(2) Writing uChar.UnicodeChar 0x1b, 0x5b, 0x41 to console input:
       Got uChar.UnicodeChar 0x1b, 0x5b, 0x41
(3) Writing uChar.UnicodeChar = 0, wVirtualKeyCode = 38
       Got uChar.UnicodeChar 0x1b, 0x5b, 0x41

Without ENABLE_VIRTUAL_TERMINAL_INPUT:
(1) Sending "\033[A" to pusedo console:
       Got uChar.UnicodeChar = 0, wVirtualKeyCode = 38
(2) Writing uChar.UnicodeChar 0x1b, 0x5b, 0x41 to console input:
       Got uChar.UnicodeChar 0x1b, 0x5b, 0x41
(3) Writing uChar.UnicodeChar = 0, wVirtualKeyCode = 38
       Got uChar.UnicodeChar = 0, wVirtualKeyCode = 38

Therefore,

When ENABLE_VIRTUAL_TERMINAL_INPUT is set:
Up arrow key -> Sending "\033[A" to pusedo console ->
  Got uChar.UnicodeChar 0x1b, 0x5b, 0x41 ->
  Writing back uChar.UnicodeChar 0x1b, 0x5b, 0x41 ->
  Got uChar.UnicodeChar 0x1b, 0x5b, 0x41

When ENABLE_VIRTUAL_TERMINAL_INPUT is not set:
Up arrow key -> Sending "\033[A" to pusedo console ->
  Got uChar.UnicodeChar = 0, wVirtualKeyCode = 38
  Writing back uChar.UnicodeChar = 0, wVirtualKeyCode = 38
  Got uChar.UnicodeChar = 0, wVirtualKeyCode = 38

This means we have to maintain UnicodeChar == 0 and bKeyDown == 0
only when ENABLE_VIRTUAL_TERMINAL_INPUT is set.
When ENABLE_VIRTUAL_TERMINAL_INPUT is not set, all key events are
preserved.

Based on above investigation, I'd revise [PATCH v6 3/3].
Could you please review it?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
