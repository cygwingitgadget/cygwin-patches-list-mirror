Return-Path: <SRS0=Vhwg=BK=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 29F964BA2E13
	for <cygwin-patches@cygwin.com>; Tue, 10 Mar 2026 08:56:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 29F964BA2E13
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 29F964BA2E13
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773133017; cv=none;
	b=CdGkbqUefOz77hjzjWF3ji1lTcZEwKIlir07nU9nDJS707MNzcCxt+RcX4oK2ZVUryAAXSJMqPn4yCYOSttIJq9Ng/YjN3uThLasLX8n2/d2/DXf/daNC33i0iL6LIi715TrVihTbRUT7v01Cxslgz06jbBtlAwrIdIUnM7SgoQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773133017; c=relaxed/simple;
	bh=FXMxm8gt510rbpC+kIBhaS2thKAS3KuY9Mhs6tt2+YI=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=IuR3nU59e5/g0vOyUyNB7TihuFwEzgiUAu2lN4U54K5EWy4y4pp4PsOACeSbHa69WZFnz4QCzBnj0086wMOQCpMR8L0YUgNkTFbOwYs3Q4oCVGCU19Xrk7xAn0I8s+8+X+5WCRVRpZD9UwI/YxEpyuTrHNhc7bxqQi3tmTAyT18=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 29F964BA2E13
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=aFkt2Wlv
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260310085654922.BASQ.36235.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 10 Mar 2026 17:56:54 +0900
Date: Tue, 10 Mar 2026 17:56:52 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/4] Fix out-of-order keystrokes
Message-Id: <20260310175652.a7c404ae59c02560956cfb59@nifty.ne.jp>
In-Reply-To: <22f45be0-3a22-f9c6-6d91-a7c2484621ef@gmx.de>
References: <pull.6.cygwin.1772461480.gitgitgadget@gmail.com>
	<20260303212405.25a2db7d786ac2db324e8f7a@nifty.ne.jp>
	<22f45be0-3a22-f9c6-6d91-a7c2484621ef@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773133015;
 bh=+sRrBZ3bMIaScLZ0ycHxkJfi2aNIdr7o9cMyZr1VFWU=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=aFkt2Wlv3FUAG+LZlVXyTmhtdolOcIJVsPFbTLovMJ9b8rb28fuYrlRnhlwn0J8ir+XjeXyv
 w0lHT1TUmA/u0sHTGVJN/xJc/kdyd48hFWS/58hsZ1kt9zEQ5bBbsq2+GwwBWZ2gbdtgYDlq9C
 hJMEjMYAw1TLW0bT2lXmZqwO6yGAF1lG8SPcE9t7Vw/CQ72uioToYMqu8Q/KJ5KZ31KegralnB
 OtWE4MGEieDrrQ8MWeMkiWHtTTlEJryup5hvwdLn1RwxwH6V8fLbE4baP5iadPvEe+MEmHlX/A
 NB0YfuCFD/Vf4uOo5rM3nWyjEdbdqt373881rk18DiA6WxZg==
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,POISEN_SPAM_PILL,POISEN_SPAM_PILL_1,POISEN_SPAM_PILL_3,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Fri, 6 Mar 2026 08:46:40 +0100 (CET)
Johannes Schindelin wrote:
> 
> Hi Takashi,
> 
> On Tue, 3 Mar 2026, Takashi Yano wrote:
> 
> > On Mon, 02 Mar 2026 14:24:36 +0000
> > "Johannes Schindelin wrote:
> > > A Git for Windows user reported that typing in a Bash session while a native
> > > Windows program is running (or has just exited) can produce scrambled input
> > > -- e.g. typing "git log" yields "igt olg":
> > > https://github.com/git-for-windows/git/issues/5632
> > > 
> > > I have been experiencing what I suspect is the same bug for a long time in
> > > my tmux sessions: after quitting a pager and immediately pressing cursor-up
> > > to recall the previous command, often followed by Escape+Backspace, the Bash
> > > session simply hangs. I suspect that the escape sequence bytes arrive out of
> > > order, and hence the sequence does not parse, and the terminal hangs. Quite
> > > frustrating, and it happens often enough to be a real productivity drain.
> > > 
> > > This bug report was therefore always on my mind, and gaining some good
> > > experience with AI-assisted coding at work finally gave me the push to
> > > investigate properly. I started by writing an AutoHotKey-based UI test (Git
> > > for Windows has a small suite of those; they are not included in this series
> > > because they are specific to our fork). Getting a reliable reproducer
> > > required quite a bit of back-and-forth as the bug is timing-sensitive and
> > > only manifests when pseudo console transitions happen while keystrokes are
> > > in flight.
> > > 
> > > The investigation itself was substantial. The total session spread over a
> > > week. To be transparent about the methodology: I used AI (Claude Opus) as an
> > > investigative tool throughout this process. I dictated context and direction
> > > via speech recognition, the AI searched the code, instrumented the code
> > > liberally, and dug into the PTY internals. Every decision about what to
> > > investigate, what to fix and how was mine, the AI merely executed my plans.
> > > I typed very little (leaving typing to Parakeet's speech recognition and to
> > > Claude Opus); the keystrokes are not mine, but the ideas are. For that
> > > reason I use "Assisted-by" rather than "Co-authored-by" trailers in the
> > > commits.
> > > 
> > > The root cause is what Opus labeled "pseudo console oscillation" (I called
> > > it "flickering" but agree that "oscillation" is a better term): each time a
> > > native program starts or exits, pcon_activated and pty_input_state change
> > > rapidly, and several code paths in master::write() react by calling
> > > transfer_input() to move data between the cyg and nat pipes. During
> > > oscillation, these transfers steal readline's buffered data from the cyg
> > > pipe, causing characters to arrive out of order.
> > > 
> > > My suspicion is that the originally reported bug is fixed entirely by the
> > > first patch (1/4). The remaining three address edge cases that the
> > > reproducer exposed through its more aggressive oscillation pattern. You
> > > might say that I over-deliver a bit, but that seems like a good thing in
> > > this instance.
> > > 
> > > I tested both with and without MSYS=disable_pcon to verify that the
> > > scenarios the removed code was originally intended to handle are still
> > > covered by setpgid_aux(). This is even automated in Git for Windows' fork
> > > via the AutoHotKey-based tests; for full details see
> > > https://github.com/git-for-windows/msys2-runtime/pull/124.
> > 
> > [...]
> > 
> > I tried to reproduce the issue, however I could not yet.
> > 
> > Is the issue reproducible in pcon_activated case?
> > Or disable_pcon case?
> > 
> > If you can reproduce the issue in cygwin, could you kindly please
> > let me know how to reproduce it?
> 
> It is admittedly difficult to reproduce. It took me a good 4 days to get
> to a reliable reproducer. And I failed to do this in manual mode, I had to
> employ the help of AutoHotKey to do it. The result can be seen here:
> https://github.com/dscho/msys2-runtime/blob/fix-jumbled-character-order/ui-tests/keystroke-order.ahk
> 
> Unfortunately, it is not quite stand-alone, it requires `powershell.exe`
> in the `PATH`, and
> https://github.com/dscho/msys2-runtime/blob/fix-jumbled-character-order/ui-tests/ui-test-library.ahk
> and
> https://github.com/dscho/msys2-runtime/blob/fix-jumbled-character-order/ui-tests/cpu-stress.ps1
> in the same directory. I just verified that it reproduces even with vanilla
> Cygwin, using the latest AutoHotKey version from
> https://github.com/AutoHotkey/AutoHotkey/releases/tag/v2.0.21. I ensured
> that Cygwin's `bin` directory is first in the `PATH` and then ran, from a
> PowerShell session:
> 
>   & "<path-to>\AutoHotkey64.exe" /force keystroke-order.ahk "$PWD\log.txt"
> 
> What this test does: It runs a small PowerShell script designed to add a
> bit of CPU load and then spawns a Cygwin process (`sleep 1`). While these
> are running, it then types _very_ rapidly four characters, then two
> backspaces, then repeats that quite a few times ("ABXY" then deleting
> "XY", then "CDXY", deleting "XY", etc). The number of characters was
> chosen high enough that this reproducer basically reproduces the issue on
> the first try. The "log.txt" file contains a detailed log including the
> verdict. In my latest test, for example, it shows:
> 
>   Iteration 1 of 20
>   MISMATCH in iteration 1!
>   Expected: ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789
>   Got:      ABCDEFGHIJKLMNOPQRXSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789
> 
> You will spot the "X" between "R" and "S", meaning that the backspace was
> not able to remove the "X" because it was routed to the wrong pipe, or
> after the "X" was already consumed.

Thanks for the reproducer. I finally could reproduce the issue!
Please let me take a look.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
