Return-Path: <SRS0=xgHh=BD=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [106.153.226.33])
	by sourceware.org (Postfix) with ESMTPS id 223244BAE7E5
	for <cygwin-patches@cygwin.com>; Tue,  3 Mar 2026 12:24:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 223244BAE7E5
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 223244BAE7E5
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772540651; cv=none;
	b=Y+zrXS6gPeN79egm1HXbgIr3s+R2P0WlJl7PlsInE5WXC+PGmyMmSsqJD6N/4kEXa2eHcFaZuc6y85gLzoRC6JD/Nl7R+iufzjADlLHavTmLVC/EFBhFkvrPbEdqf0IQVqFy2DmK1h44tqkj9OlhIwamItPIAkKj5JX04h64bOs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772540651; c=relaxed/simple;
	bh=+uQkY9Ayvw9D/OVtew3dCbXmdpPADESPKYAih2CVeYw=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=kOSP/O7OSrSz7hd6SildEBL2t2geh8mt0W4MZ/1mC3H5CZ7+wj4Tie+Jad3tPKPuuSmtcnNdPmgseo+u1wKXWNsQ1qwwvjzmtNDctPI6pkaiJOo+ois68RhBY3wA3tOUi5XxmVahOvEoJb8ssJ+NV0EGVMwe/BxlIcy6X88bndk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 223244BAE7E5
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Sd5uwBg+
Received: from HP-Z230 by mta-snd-e01.mail.nifty.com with ESMTP
          id <20260303122408303.CQPN.48098.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 3 Mar 2026 21:24:08 +0900
Date: Tue, 3 Mar 2026 21:24:05 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/4] Fix out-of-order keystrokes
Message-Id: <20260303212405.25a2db7d786ac2db324e8f7a@nifty.ne.jp>
In-Reply-To: <pull.6.cygwin.1772461480.gitgitgadget@gmail.com>
References: <pull.6.cygwin.1772461480.gitgitgadget@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1772540648;
 bh=nln6av6eyau0629BAZ/F094O34twkTC/iPtYOakct24=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=Sd5uwBg+6szMLX1tDJGXhCCvLDbjXBHQWMl8SYsTCm6vzBPL8jttxooTjd8ibfK/MMPbzhu6
 D2Nuv+W8QIx8HDDG5grgTCn5/7/ocYheSni3BCn0I/u7gVte/iOdmseBPba/VjgjkiAYM3D8uT
 jLU4Ic8hkGAIndapcNNe3C4ZqRr43U+c7VhURe44wwdKDMmsMRBqJAWm1vg6ZhMItkexgG70ic
 4BkT7hFQ+w4TbGBq4hO4VD3pYDSmU9Je4GA7EceXXDqjwMdk0Wke7m0VZE951wjsbZ1paPN8Zz
 HxKP4D6aGu2DvMG1QrPYKAVNL7FC2eAEVzXaZYC6X5oLqGFQ==
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Mon, 02 Mar 2026 14:24:36 +0000
"Johannes Schindelin wrote:
> A Git for Windows user reported that typing in a Bash session while a native
> Windows program is running (or has just exited) can produce scrambled input
> -- e.g. typing "git log" yields "igt olg":
> https://github.com/git-for-windows/git/issues/5632
> 
> I have been experiencing what I suspect is the same bug for a long time in
> my tmux sessions: after quitting a pager and immediately pressing cursor-up
> to recall the previous command, often followed by Escape+Backspace, the Bash
> session simply hangs. I suspect that the escape sequence bytes arrive out of
> order, and hence the sequence does not parse, and the terminal hangs. Quite
> frustrating, and it happens often enough to be a real productivity drain.
> 
> This bug report was therefore always on my mind, and gaining some good
> experience with AI-assisted coding at work finally gave me the push to
> investigate properly. I started by writing an AutoHotKey-based UI test (Git
> for Windows has a small suite of those; they are not included in this series
> because they are specific to our fork). Getting a reliable reproducer
> required quite a bit of back-and-forth as the bug is timing-sensitive and
> only manifests when pseudo console transitions happen while keystrokes are
> in flight.
> 
> The investigation itself was substantial. The total session spread over a
> week. To be transparent about the methodology: I used AI (Claude Opus) as an
> investigative tool throughout this process. I dictated context and direction
> via speech recognition, the AI searched the code, instrumented the code
> liberally, and dug into the PTY internals. Every decision about what to
> investigate, what to fix and how was mine, the AI merely executed my plans.
> I typed very little (leaving typing to Parakeet's speech recognition and to
> Claude Opus); the keystrokes are not mine, but the ideas are. For that
> reason I use "Assisted-by" rather than "Co-authored-by" trailers in the
> commits.
> 
> The root cause is what Opus labeled "pseudo console oscillation" (I called
> it "flickering" but agree that "oscillation" is a better term): each time a
> native program starts or exits, pcon_activated and pty_input_state change
> rapidly, and several code paths in master::write() react by calling
> transfer_input() to move data between the cyg and nat pipes. During
> oscillation, these transfers steal readline's buffered data from the cyg
> pipe, causing characters to arrive out of order.
> 
> My suspicion is that the originally reported bug is fixed entirely by the
> first patch (1/4). The remaining three address edge cases that the
> reproducer exposed through its more aggressive oscillation pattern. You
> might say that I over-deliver a bit, but that seems like a good thing in
> this instance.
> 
> I tested both with and without MSYS=disable_pcon to verify that the
> scenarios the removed code was originally intended to handle are still
> covered by setpgid_aux(). This is even automated in Git for Windows' fork
> via the AutoHotKey-based tests; for full details see
> https://github.com/git-for-windows/msys2-runtime/pull/124.
> 
> Johannes Schindelin (4):
>   Cygwin: pty: Fix jumbled keystrokes by removing the per-keystroke pipe
>     transfer
>   Cygwin: pty: Remove pcon_start readahead flush that displaces readline
>     data
>   Cygwin: pty: Prevent premature pseudo console teardown that amplifies
>     oscillation
>   Cygwin: pty: Guard accept_input routing and flush stale readahead in
>     fast path
> 
>  winsup/cygwin/fhandler/pty.cc | 62 ++++++++++++++++-------------------
>  1 file changed, 29 insertions(+), 33 deletions(-)
> 
> 
> base-commit: f04527cea30b0bb9634f96883cc71571bd3e524b
> Published-As: https://github.com/cygwingitgadget/cygwin/releases/tag/pr-6%2Fdscho%2Ffix-out-of-order-keystrokes-v1
> Fetch-It-Via: git fetch https://github.com/cygwingitgadget/cygwin pr-6/dscho/fix-out-of-order-keystrokes-v1
> Pull-Request: https://github.com/cygwingitgadget/cygwin/pull/6
> -- 
> cygwingitgadget

Thanks for the patch series and detailed explanations.

I tried to reproduce the issue, however I could not yet.

Is the issue reproducible in pcon_activated case?
Or disable_pcon case?

If you can reproduce the issue in cygwin, could you kindly please
let me know how to reproduce it? 

In addition, after applying these four patches, non-cygwin apps
lose its input. Please try cmd.exe in pcon_activated mode.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
