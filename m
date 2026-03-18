Return-Path: <SRS0=4rNz=BS=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id A1C674BCA43D
	for <cygwin-patches@cygwin.com>; Wed, 18 Mar 2026 11:20:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A1C674BCA43D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A1C674BCA43D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773832836; cv=none;
	b=iSnPiA7sOt7QOwZo1J5zce7+2yC9zDO7sXey782bJF3MSe7EmfmyUypPwvI+5ttFejt/l3yHVAeqCNyfm8/tr0QBt6VykNvW6t9cpEUkPV6V6Xbq/VI15agIb+yN3LybHFxdCyimIWg1Kj2j9bXLitVnVyanw4y1SB+F1zdLyFI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773832836; c=relaxed/simple;
	bh=vSHK3enQ7ykZ7osA8yJ086BUW79wkJr/NHjxM+HLCWg=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=Qk/2+RD/pk6gI6HhRPr0ys8SCk5qB/ZA2c0pobWA/rnL/x/BWyGgiT7kXZerah7f/1g+6tlSCGqkHqzGpzVY9BE8Hwd3h/UAvNw4Kd+OxIZWRCbvZSzSnzdTmdryJtPWEeTFd4yISFiDNHImJf4yAk1+vQFb06wHROzqDabKRFM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A1C674BCA43D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=rwBGLJXg
Received: from HP-Z230 by mta-snd-w09.mail.nifty.com with ESMTP
          id <20260318112033761.QYQW.116672.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 18 Mar 2026 20:20:33 +0900
Date: Wed, 18 Mar 2026 20:20:32 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/6] Cygwin: pty: Add workaround for handling of
 backspace when pcon enabled
Message-Id: <20260318202032.54cf28ea83d863082f1bb153@nifty.ne.jp>
In-Reply-To: <2f8628d2-b79a-95a6-480d-7508375958d5@gmx.de>
References: <22f45be0-3a22-f9c6-6d91-a7c2484621ef@gmx.de>
	<20260317122433.721-1-takashi.yano@nifty.ne.jp>
	<20260317122433.721-3-takashi.yano@nifty.ne.jp>
	<2f8628d2-b79a-95a6-480d-7508375958d5@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773832833;
 bh=N1EPSuzuRv09wNikE8O+YBh4YrC0ooM/IkvTeycjrQc=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=rwBGLJXgmI9fbacPfdAsTZGday/+3cJlyX+0WhIaRmoU0xLCYoK/BR4sRF+hrCJ16DuBnD7F
 0813lkdhj8T/zY/tz1zEhqK2u56NKER/SNma+vBFkco1RVfL56KfTQlGG2b0F2oj56/rm76pZL
 mdCGeOSnjFKV8/SDfIKnhzvrlIKKspt1yC+EIw6RODKpojdnaL91DUQNIfP+26aU15Qfm2/ljm
 ICXFzQVQq4/9O3q9L/d7RwOABoM7x244+UHGMf1+Hd4iwIdubLeBJq8FL/EsB1WFrhmo+VVNGc
 q0LNsh+Gg4q1phjQhPdi1eJkzFQXIkxOMpIdwPIEoRP2RIcg==
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Tue, 17 Mar 2026 16:28:28 +0100 (CET)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Tue, 17 Mar 2026, Takashi Yano wrote:
> 
> > In Windows 11, pseudo console has a weird behaviour that the Ctrl-H
> > is translated into Ctrl-Backspace (not Backspace). Similary, Backspace
> > (0x7f) is translated into Ctrl-H. Due to this behaviour, inrec_eq()
> > in cons_master_thread() fails to compare backspace/Ctrl-H events in
> > the input record sequence. This patch is a workaround for that issue
> > which pushes the Ctrl-H or Backspace as a ConsoleInput event instead
> > of sending char code to pseudo console.
> 
> As I have pointed out already in
> https://inbox.sourceware.org/cygwin-patches/724fc579-2984-9ec6-9c8e-69b334e966bb@gmx.de/
> in response to essentially the same patch, the logic introduced in this
> patch is simply too brittle to be considered a valid work-around.
> 
> In any case, there is no need to describe this vaguely as "a weird
> behavior", not when I spent considerable time to find out, as a way to
> allow us to say precisely what is going on and stop hand-waving about the
> root cause. To save you one click, I'll replicate the actual bug fix from
> https://github.com/dscho/terminal/commit/1b3d526428c86b9357275f11149d736f8928d64b
> here:
> 
> -- snip --
> From 1b3d526428c86b9357275f11149d736f8928d64b Mon Sep 17 00:00:00 2001
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Mon, 16 Mar 2026 08:30:17 +0100
> Subject: [PATCH] Fix 0x08 (Ctrl-H) being incorrectly decoded as Ctrl+Backspace
> 
> The reverse VT input path in _DoControlCharacter mapped the byte 0x08
> to a Ctrl+Backspace key event (VK_BACK with LEFT_CTRL_PRESSED and
> character 0x7F). This was introduced in PR #3935 (Jan 2020) to make
> Ctrl+Backspace delete whole words, which fixed issue #755. At that time,
> the forward path (TerminalInput) also sent 0x08 for Ctrl+Backspace, so
> the mapping was internally consistent, if a bit unusual.
> 
> In September 2022, PR #13894 rewrote the forward path to properly
> implement DECBKM (Backarrow Key Mode). Under the default DECBKM
> setting, TerminalInput now sends 0x08 for plain Backspace and 0x7F for
> Ctrl+Backspace. The reverse path was never updated to match, breaking
> the roundtrip: a Backspace keypress encodes to 0x08, which decodes back
> as Ctrl+Backspace.
> 
> The Cygwin project is working on using OpenConsole.exe for its ConPTY
> support, and a proposed patch series contains an ugly workaround for
> this bug that bypasses the normal input pipe and injects raw
> WriteConsoleInput events whenever 0x08 appears in the stream
> (https://inbox.sourceware.org/cygwin-patches/20260312113923.1528-4-takashi.yano@nifty.ne.jp/).
> Fixing the bug here avoids the need to accept that workaround.
> 
> The fix assigns VK_BACK directly and clears writeCtrl, following the
> same pattern as the existing L'\x1b' case. This avoids the VkKeyScanW
> roundtrip through _GenerateKeyFromChar, which was the root cause: it
> reverse-mapped 0x7F to Ctrl+Backspace (since that is the keyboard
> combination that produces 0x7F), and then writeCtrl added
> LEFT_CTRL_PRESSED back after modifierState was zeroed.
> 
> Note that the 0x7F handler (line 221) has the inverse problem: it maps
> 0x7F to plain Backspace, but the forward path now uses 0x7F for
> Ctrl+Backspace. That is a separate issue left for a follow-up.
> 
> Assisted-by: Claude Opus 4.6
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  src/terminal/parser/InputStateMachineEngine.cpp | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/src/terminal/parser/InputStateMachineEngine.cpp b/src/terminal/parser/InputStateMachineEngine.cpp
> index e0f663f3f..5fdf9ad1a 100644
> --- a/src/terminal/parser/InputStateMachineEngine.cpp
> +++ b/src/terminal/parser/InputStateMachineEngine.cpp
> @@ -177,10 +177,9 @@ bool InputStateMachineEngine::_DoControlCharacter(const wchar_t wch, const bool
>          switch (wch)
>          {
>          case L'\b':
> -            // Process Ctrl+Bksp to delete whole words
> -            actualChar = '\x7f';
> -            success = _GenerateKeyFromChar(actualChar, vkey, modifierState);
> -            modifierState = 0;
> +            vkey = VK_BACK;
> +            writeCtrl = false;
> +            success = true;
>              break;
>          case L'\r':
>              writeCtrl = false;
> -- snap --

Great!
I'm also noticed your commit:
https://github.com/dscho/terminal/commit/ddb7a3b411c040fb964e1eff3942c325afa1513b
Are you planning to open PR?

> Since `conhost.exe` is essentially "an LTS version of OpenConsole.exe" (my
> wording, for the official word see
> https://github.com/microsoft/terminal/discussions/12115#discussioncomment-1928563
> which explains how `conhost.exe` is built from the same source code as
> `OpenConsole.exe`), I can understand that you are now trying to use the
> same work-around also for `conhost.exe`.
> 
> However, the design of opening the process that owns the console just so
> that the Cygwin process can reopen the console handle with the same access
> for the purpose of sending raw keyboard events interleaved with the
> regular `WriteFile()` of the non-Backspace stuff to a _different_ handle
> is so prone to fail that I really believe it better not to take this
> patch. Its introduced logic assumes quite a bit about synchronization, for
> example, expecting the keyboard events to arrive at the right time, after
> the previous `WriteFile(to_slave_nat, ...)` managed to pipe regular
> characters through to the console. These assumptions might happen to be
> correct a lot of the time, but they _will_ be wrong too often, and as a
> consequence the Pseudo Consol support would end up buggier than before
> with this patch.
> 
> Besides, having two separate loops to handle ^H vs BS assumes that ^H and
> BS inputs cannot arrive together, during the same
> `fhandler_pty_master::write()` call, which I am fairly certain is
> incorrect. With the current design, if there is a BS toward the beginning
> of the input and ^H toward the end, the `while (bs_pos1)` loop will
> happily write out the `0x7f` byte as part of the `WriteFile (to_slave_nat,
> ...)` call, excluding the ^H characters of course. And _then_ the `while
> (bs_pos2)` loop will happily write all of the input buffer except for the
> `0x7f` bytes (but crucially, now including the `0x08` bytes corresponding
> to the ^H keystrokes) via the `WriteFile (to_slave_nat, ...)` call, i.e.
> it will write most of the payload _again_.

You are right. I was wrong. In most cases, master::write() is called
with len=1, so, I did not aware of it.

> This cannot be correct, and I am rather convinced that the idea behind the
> patch (interleaving `WriteFile()` calls to the pipe with sending raw
> keyboard events via `WriteConsoleInput()` to a _different_ handle) will
> _never_ be robust enough.

Then, only the thing we can do till fixing the issue upstream, is
writing all chars using WriteConsoleInput() instead of WriteFile()...

What do you think?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
