Return-Path: <SRS0=Hd43=ZH=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e10.mail.nifty.com (mta-snd-e10.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:2a])
	by sourceware.org (Postfix) with ESMTPS id 5D8B63858410
	for <cygwin-patches@cygwin.com>; Tue, 24 Jun 2025 23:53:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5D8B63858410
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5D8B63858410
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:2a
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750809202; cv=none;
	b=MzQlNXLlRiFgMsNBCKaDLssaS56xLxNwP2Y6Bn/VaT4GGGqiFHO+XccxoPVOko32ySGz+tdzRjG0x7kNc3S7JngYZAvspWoL6WpCaE7DC07ROrD4rssjv1fnnICfGbcUBltkm8VnptWjNfN6Xl912d/KEvuqHDCqh/Pe4PzMFyQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750809202; c=relaxed/simple;
	bh=aTK1eyAMmNCGbXCZFYztdgsBo+5BEDKV4jUv4XfEoRQ=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=bwrpspyK3qT801Ca0APwM4Uwfd4otCrcyMVCn3ZdF/YmE5bPyk/xvX2JhZPDmfy/zI5UnLDmMtL4y+Y/BheZPGC1kAkOfysOSKKOchAnUquB4JNTrbBFjBGRMzzsWntOWN7XB1QjdMxxB91U7aPsrSxKtOPwT7oPZ95JKD7u7pA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5D8B63858410
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=iS3gEwNc
Received: from HP-Z230 by mta-snd-e10.mail.nifty.com with ESMTP
          id <20250624235318100.BIJS.34837.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 08:53:18 +0900
Date: Wed, 25 Jun 2025 08:53:16 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] pipe: fix SSH hang (again)
Message-Id: <20250625085316.35e6dda457b6dce9792c824a@nifty.ne.jp>
In-Reply-To: <62e79c50daf4e3ae28db3ae1a3cf52460f0d8968.1750775114.git.johannes.schindelin@gmx.de>
References: <c9b1313d5d8a690aae9788402ec5190a1f18ce75.1750679728.git.johann>
	<62e79c50daf4e3ae28db3ae1a3cf52460f0d8968.1750775114.git.johannes.schindelin@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1750809198;
 bh=AYSb8pv8r+1aYT3uACcRQCLFm9hZ9xX/dBGvxVSNQYM=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=iS3gEwNcV0P9ai15xSvErMMeVMYlGAF5n2UVk1axYBl2GWAbMVVpaOm0jsG7fqOlQ4bNhWZg
 K3gJnVVbTyIx9fnbnMoEE46ZsjqRRHNfUpQoIpbY35f8Em5JrekCzH4/ir60sbDBA3pTJ95rWT
 DJUGdLLXxIcpDm8c2dNut5yNu50sTNW9veQ4qvKA3bPlphkmbDUS3jy2lsQY0Aa7XifMby/5Gs
 NzMVMw/xU26Zu7t/2sufxxKhanbk3LtecvFmmkZn0SGbLkK3JXcaDCkvJqZpDbyebxvwV1SFgH
 GdRiKe5RrNj4rQC/3ovhA/s4tQO3RUoVcw/5p3Qd7GxN2MJg==
X-Spam-Status: No, score=-12.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 24 Jun 2025 16:27:52 +0200 (CEST)
Johannes Schindelin wrote:
> When cbfaeba4f7 (Cygwin: pipe: Fix incorrect write length in
> raw_write(), 2024-11-06) fixed a bug where too-long writes could cause
> segmentation faults, it not only left out crucial details from the
> commit message, it also introduced a bug.
> 
> This manifests e.g. in the symptom where cloning large repositories in
> Git for Windows via SSH "freeze" at random stages, as has been reported
> in https://github.com/git-for-windows/git/issues/5688 and in
> https://github.com/git-for-windows/git/issues/5682.
> 
> The bug in question was to use `is_nonblocking ()` instead of
> `real_non_blocking_mode` in a newly introduced condition. If the commit
> message had filled in those details, it would most likely have been much
> easier to spot the bug before the patch was committed.
> 
> Granted, the patch _sort of_ moved this `is_nonblocking ()` condition
> from another place, which means that the bug was present before, even if
> it did not have the same detrimental symptom of hanging a clone of a
> large repository via SSH.
> 
> The _original_ bug was introduced in the equally under-explained
> 7ed9adb356 (Cygwin: pipe: Switch pipe mode to blocking mode by default,
> 2024-09-05).
> 
> What is ironic is that this here patch is the latest (and hopefully
> last) commit in a _long_ chain of bug fixes that fix bugs introduced by
> preceding bug fixes:
> 
> - 9e4d308cd5 (Cygwin: pipe: Adopt FILE_SYNCHRONOUS_IO_NONALERT flag for
>   read pipe., 2021-11-10) fixed a bug where Cygwin hung by mistake while
>   piping output from one .NET program as input to another .NET program
>   (potentially introduced by 365199090c (Cygwin: pipe: Avoid false EOF
>   while reading output of C# programs., 2021-11-07), which was itself a
>   bug fix). It introduced a bug that was fixed by...
> - fc691d0246 (Cygwin: pipe: Make sure to set read pipe non-blocking for
>   cygwin apps., 2024-03-11). Which introduced a bug that was purportedly
>   fixed by...
> - 7ed9adb356 (Cygwin: pipe: Switch pipe mode to blocking mode by
>   default, 2024-09-05). Which introduced a bug that was fixed by...
> - cbfaeba4f7 (Cygwin: pipe: Fix incorrect write length in raw_write(),
>   2024-11-06). Which introduced a bug that was fixed by... this here
>   patch.
> 
> There is not only the common thread here that each of these bug fixes
> introduced a new bug, but also the common thread of commit messages that
> leave the reader puzzled and the problem ― as well as the solution ―
> under-explained. It is quite likely that, had the time and care been
> spent to fully explain what is going on in the commit messages, this
> would quite likely have triggered a re-review of the diff by the author.
> In other words, writing a complete commit message could have increased
> the insight and understanding of the problem and thereby prevented this
> series of "fixes that introduce new bugs".
> 
> To avoid making the same mistake once again, here is my attempt at a
> thorough explanation of what's going on, what is the problem, what
> solutions were considered, and why the "winner" was chosen.
> 
> So let's start with an overview of the logic of the
> `fhandler_pipe_fifo::raw_write ()` method.
> 
> This method implements the fundamental logic behind writing to any pipe
> in Cygwin, whether it be blocking or not blocking, and takes as input
> two variables, `ptr` and `len`, pointing to the data to be written.
> 
> First, this method determines a couple of initial conditions (such as
> maybe waiting on a specific mutex, or determining whether the pipe had
> been closed already, or whether it is in blocking or in non-blocking
> mode). Then, this method determines how many bytes of data should be
> written in each attempt (assigned to the variable `chunk`).
> 
> The amount of bytes already written is tracked as `nbytes`. While this
> value is smaller than `len`, the central loop of this method is
> executed.
> 
> Counterintuitively, this loop is necessary even in non-blocking mode, to
> handle conditions like `STATUS_PENDING`.
> 
> Inside this loop body, a variety of conditions are handled, including
> some that break out of that loop before `nbytes >= len`, e.g. when the
> pipe is closed on the other end.
> 
> This loop body also contains special, complicated logic to handle the
> case where the pipe buffer is not large enough to handle the current
> `chunk`, trying to write even less bytes (this is guarded by the flag
> `short_write_once`).
> 
> Unfortunately, the recent re-design of that logic decided to always set
> the pipe to blocking (cf. the diff of ed9adb356 (Cygwin: pipe: Switch
> pipe mode to blocking mode by default, 2024-09-05)). The rationale for
> that decision was the desire to simplify the code, which came at the
> expense of working well together with pipes that were created outside of
> Cygwin and that are set to non-blocking mode.
> 
> To this end, the current implementation now _emulates_ non-blocking
> behavior while keeping the actual pipe in blocking mode. This requires
> knowing how much data can be written to the pipe without blocking at any
> given moment. Because by knowing that amount, even in blocking mode a
> write operation can be performed that does not block. This information
> is obtained via `NtQueryInformationFile(FilePipeLocalInformation)` and
> stored in the variable `avail`.
> 
> However, if for some reason it cannot be determined how much space is
> available in the pipe, this non-blocking mode emulation would not work.
> Therefore the pipe is set to genuine non-blocking mode in such cases,
> and only in such cases. This minimizes the time window (but does not
> eliminate it completely!) during which Cygwin does not work well
> together with non-Cygwin processes via pipes.
> 
> It also shows that the original desire to simplify the code can not be
> fulfilled using the current strategy, as there is now both code to
> emulate non-blocking mode as well as code that handles genuinely
> non-blocking mode.
> 
> This information whether non-blocking mode is merely emulated or
> genuinely enabled, is tracked by the Boolean variable
> `real_non_blocking_mode`.
> 
> At the beginning of the loop body, after determining how many bytes to
> write (stored in `len1`), the `NtWriteFile()` is called. Since the
> re-design to always use blocking mode (at least insofar possible), this
> `NtWriteFile()` call is guarded by a condition so that it is called only
> once in non-blocking mode.
> 
> Now, the logic for that is quite complex. First, `len1` is clamped to
> `chunk` in blocking mode, otherwise to however many bytes are left to
> write. Then, an _inner_ `while` loop runs as long as `len1` is greater
> than 0. Inside that loop, `NtWriteFile()` is called _unless_ we'd try to
> write more bytes than are available in emulated non-blocking mode.
> 
> It is the complex interplay between that clamping to `chunk` and the
> condition when `NtWriteFile()` is skipped that is at the heart of this
> bug.
> 
> But let's first see what happens in the case described above, where the
> (Cygwin) SSH process gets stuck writing to the (non-Cygwin) Git process.
> In the instances I observed, the big `while (nbytes < len)` loop is
> started with the following initial conditions: `len` is 2097152, `chunk`
> and `avail` are 1 and `real_non_blocking_mode` is 0.
> 
> When the outer loop is entered, `len1` is therefore also set to 2097152,
> and at the start of the inner loop the condition `len1 > avail` holds
> true. Therefore, the `NtWriteFile()` call is skipped already during the
> first iteration, we run into the code that tries a short write (setting
> `short_write_once` to 1), and ultimately fail and return from
> `raw_write()` with an error.
> 
> Since not a single byte was written, the caller will try again at some
> stage, failing again, over and over, and we're in an infinite loop.
> 
> The fix chosen in this here commit is to apply that clamping to `chunk`
> _also_ in the emulated non-blocking mode. This lets the `NtWriteFile()`
> call _not_ be skipped in non-emulated non-blocking mode, as was clearly
> the intention.
> 
> An alternative patch that would have also addressed the symptom would be
> to partially revert this hunk of cbfaeba4f7 (Cygwin: pipe: Fix incorrect
> write length in raw_write(), 2024-11-06):
> 
>          chunk = len;
>     -  else if (is_nonblocking ())
>     -    chunk = len = pipe_buf_size;
>        else
>          chunk = avail;
> 
> The logic changed such that `len` would no longer be clamped to the same
> value as `chunk` in non-blocking mode. Reinstating that clamp in
> non-blocking mode would also work around the issue, but it would be a
> bit more heavy-handed than the chosen fix.
> 
> Yet another potential fix that was suggested (in
> https://github.com/git-for-windows/git/issues/5688#issuecomment-2995952882)
> would be to modify the condition when `NtWriteFile()` is skipped so as
> to force it to _not_ be skipped when attempting a "short write", i.e.
> when `short_write_once != 0`. This fix would have worked around the bug
> successfully, but is fixing the bug at the wrong layer (even if it hints
> at the fact that the `short_write_once` logic is ill-prepared for
> non-blocking mode, but that's a topic for another patch).
> 
> Fixes: cbfaeba4f7 (Cygwin: pipe: Fix incorrect write length in raw_write(), 2024-11-06)
> Co-authored-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> Published-As: https://github.com/dscho/msys2-runtime/releases/tag/fix-ssh-hangs-reloaded-v2
> Fetch-It-Via: git fetch https://github.com/dscho/msys2-runtime fix-ssh-hangs-reloaded-v2
> 
> 	This iteration undoes my patch from the first iteration, accepts
> 	Takashi's proposed patch from
> 	https://github.com/git-for-windows/git/issues/5682#issuecomment-2996285140
> 	and adds six hours worth of commit message writing.
> 
> 	Contrary to my usual practice, I'll forgo the range-diff as both
> 	the patch and the commit message are complete rewrites.
> 
>  winsup/cygwin/fhandler/pipe.cc | 2 +-
>  winsup/cygwin/release/3.6.4    | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
> index e35d523bbc..83d05e5efb 100644
> --- a/winsup/cygwin/fhandler/pipe.cc
> +++ b/winsup/cygwin/fhandler/pipe.cc
> @@ -561,7 +561,7 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
>        ULONG len1;
>        DWORD waitret = WAIT_OBJECT_0;
>  
> -      if (left > chunk && !is_nonblocking ())
> +      if (left > chunk && !real_non_blocking_mode)
>  	len1 = chunk;
>        else
>  	len1 = (ULONG) left;
> diff --git a/winsup/cygwin/release/3.6.4 b/winsup/cygwin/release/3.6.4
> index c80a29ea4f..40b842be88 100644
> --- a/winsup/cygwin/release/3.6.4
> +++ b/winsup/cygwin/release/3.6.4
> @@ -9,3 +9,7 @@ Fixes:
>  
>  - Fix creating native symlinks to `..` (it used to target `../../<dir>`
>    instead).
> +
> +- Fix yet another issue with non-blocking pipes that could lead to
> +  dead-locks e.g. when writing large amounts of data to a non-Cygwin
> +  process.

Thanks!
I found the patch blocks non-blocking write in some condition.
I'd revise the patch as follows. Could you please test if the
following patch also solves the issue?

diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
index e35d523bb..3bb5dd436 100644
--- a/winsup/cygwin/fhandler/pipe.cc
+++ b/winsup/cygwin/fhandler/pipe.cc
@@ -561,7 +561,7 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
       ULONG len1;
       DWORD waitret = WAIT_OBJECT_0;
 
-      if (left > chunk && !is_nonblocking ())
+      if (left > chunk && !real_non_blocking_mode)
 	len1 = chunk;
       else
 	len1 = (ULONG) left;
@@ -700,7 +700,7 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
       else
 	__seterrno_from_nt_status (status);
 
-      if (nbytes_now == 0 || short_write_once
+      if (nbytes_now == 0 || short_write_once || is_nonblocking ()
 	  || status == STATUS_THREAD_SIGNALED)
 	break;
     }


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
