Return-Path: <SRS0=Y/LP=ZH=gmx.de=johannes.schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id B7E2D385EC14
	for <cygwin-patches@cygwin.com>; Tue, 24 Jun 2025 14:27:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B7E2D385EC14
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B7E2D385EC14
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750775276; cv=none;
	b=m2+Kj+EER8yhZawIwQmGfQYz5BLXNyiQHtVlkzsKOiYdFa9QfHDDXoBzMr6C9hTPcwKsFnCiM/uptf6sl/tjrP5cs6uZzMkaUgeNiBN3n9P1JvoqVkUrzYWzLe3CLij/azGyVxzbRAvCWZri27CGb7i8E7uZkhfSumj14lYvqqw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750775276; c=relaxed/simple;
	bh=Sbc4eUH2h2z9M6aACDfEMmgXQoJPH/oVpxSXDrrm/kA=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=cy8IKuWZZMUvbKe7vKSeASCCp2OTuCqh4Shah13a9kJO+N7JcypJoJYNuDKmM2LZhLV7SuNinRdlxEEi42GnS7n2oGLfZUre0GGHbYPqgKy415EO1N2mdAIg+hxl70aA49CYD9Yq9kHMc1jPOuJSFRCpHFj9zvCucnZSil6TrY8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B7E2D385EC14
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=gRyVFo4e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1750775274; x=1751380074;
	i=johannes.schindelin@gmx.de;
	bh=yRe9gmJOBSRtIXoGpSUs0z9kmVUgTin/Xmjk7h6CZOQ=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gRyVFo4ecJ4Cqx/nIBqG1svB608orDYmgla9PBpBRU3v8W392OfFD5YFfw5cJJCB
	 /P13RU5VbX76facOMoKgT3i9Umv8I82xztFT2OAX+RfM9utKgjjBOu/E7MzuAUtRp
	 BOROuU6wwOtAYGSGMYUtOKBEnVE8YrAQSrdnkjjuAPbB/z/Qz3/9VpL5j91fZQadp
	 KJBkmkFYHopDG/m4kl7pUNsW9IWz/D/blL+EdSiY77g9UmFWOZLFPVlOQP7DvE9S1
	 Yk6fgqfjcGFkEqXc9ivjJmaSciKAxP2mbCE7JhurR7BQkfOwdYZtYt5JcwgYpr3YR
	 RrX28VaCaiy7HVZYwA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.6]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4JmN-1uULbn1kkj-0039Vw for
 <cygwin-patches@cygwin.com>; Tue, 24 Jun 2025 16:27:54 +0200
Date: Tue, 24 Jun 2025 16:27:52 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2] pipe: fix SSH hang (again)
In-Reply-To: <c9b1313d5d8a690aae9788402ec5190a1f18ce75.1750679728.git.johann>
Message-ID: <62e79c50daf4e3ae28db3ae1a3cf52460f0d8968.1750775114.git.johannes.schindelin@gmx.de>
References: <c9b1313d5d8a690aae9788402ec5190a1f18ce75.1750679728.git.johann>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-52365794-1750775274=:124"
X-Provags-ID: V03:K1:g49v2l9PklN95Lc0I0qPC+JmFjyQ/zLpbvgYMHBW/J+Zt+Xl/58
 0D0pByWWTZWCKrE2wbpxuLU7WvZNL2gKeBfHVWnMur/dYSrEZm02QW+tw4QSFqEwmw2NO5P
 2P+uLyzhXTvETsMmoOMzqYYo9AOMaLpUszaLWrgepZ8NY1GwtRqeomx8xiIdkGSs69FC+T2
 55T5kJeeqARpw+QK3kR+Q==
UI-OutboundReport: notjunk:1;M01:P0:9P2bK+LyHcc=;o/iU2eWFv5GqMarlNctClTyX019
 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
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_ABUSEAT,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-52365794-1750775274=:124
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

When cbfaeba4f7 (Cygwin: pipe: Fix incorrect write length in
raw_write(), 2024-11-06) fixed a bug where too-long writes could cause
segmentation faults, it not only left out crucial details from the
commit message, it also introduced a bug.

This manifests e.g. in the symptom where cloning large repositories in
Git for Windows via SSH "freeze" at random stages, as has been reported
in https://github.com/git-for-windows/git/issues/5688 and in
https://github.com/git-for-windows/git/issues/5682.

The bug in question was to use `is_nonblocking ()` instead of
`real_non_blocking_mode` in a newly introduced condition. If the commit
message had filled in those details, it would most likely have been much
easier to spot the bug before the patch was committed.

Granted, the patch _sort of_ moved this `is_nonblocking ()` condition
from another place, which means that the bug was present before, even if
it did not have the same detrimental symptom of hanging a clone of a
large repository via SSH.

The _original_ bug was introduced in the equally under-explained
7ed9adb356 (Cygwin: pipe: Switch pipe mode to blocking mode by default,
2024-09-05).

What is ironic is that this here patch is the latest (and hopefully
last) commit in a _long_ chain of bug fixes that fix bugs introduced by
preceding bug fixes:

- 9e4d308cd5 (Cygwin: pipe: Adopt FILE_SYNCHRONOUS_IO_NONALERT flag for
  read pipe., 2021-11-10) fixed a bug where Cygwin hung by mistake while
  piping output from one .NET program as input to another .NET program
  (potentially introduced by 365199090c (Cygwin: pipe: Avoid false EOF
  while reading output of C# programs., 2021-11-07), which was itself a
  bug fix). It introduced a bug that was fixed by...
- fc691d0246 (Cygwin: pipe: Make sure to set read pipe non-blocking for
  cygwin apps., 2024-03-11). Which introduced a bug that was purportedly
  fixed by...
- 7ed9adb356 (Cygwin: pipe: Switch pipe mode to blocking mode by
  default, 2024-09-05). Which introduced a bug that was fixed by...
- cbfaeba4f7 (Cygwin: pipe: Fix incorrect write length in raw_write(),
  2024-11-06). Which introduced a bug that was fixed by... this here
  patch.

There is not only the common thread here that each of these bug fixes
introduced a new bug, but also the common thread of commit messages that
leave the reader puzzled and the problem =E2=80=94 as well as the solution=
 =E2=80=94
under-explained. It is quite likely that, had the time and care been
spent to fully explain what is going on in the commit messages, this
would quite likely have triggered a re-review of the diff by the author.
In other words, writing a complete commit message could have increased
the insight and understanding of the problem and thereby prevented this
series of "fixes that introduce new bugs".

To avoid making the same mistake once again, here is my attempt at a
thorough explanation of what's going on, what is the problem, what
solutions were considered, and why the "winner" was chosen.

So let's start with an overview of the logic of the
`fhandler_pipe_fifo::raw_write ()` method.

This method implements the fundamental logic behind writing to any pipe
in Cygwin, whether it be blocking or not blocking, and takes as input
two variables, `ptr` and `len`, pointing to the data to be written.

First, this method determines a couple of initial conditions (such as
maybe waiting on a specific mutex, or determining whether the pipe had
been closed already, or whether it is in blocking or in non-blocking
mode). Then, this method determines how many bytes of data should be
written in each attempt (assigned to the variable `chunk`).

The amount of bytes already written is tracked as `nbytes`. While this
value is smaller than `len`, the central loop of this method is
executed.

Counterintuitively, this loop is necessary even in non-blocking mode, to
handle conditions like `STATUS_PENDING`.

Inside this loop body, a variety of conditions are handled, including
some that break out of that loop before `nbytes >=3D len`, e.g. when the
pipe is closed on the other end.

This loop body also contains special, complicated logic to handle the
case where the pipe buffer is not large enough to handle the current
`chunk`, trying to write even less bytes (this is guarded by the flag
`short_write_once`).

Unfortunately, the recent re-design of that logic decided to always set
the pipe to blocking (cf. the diff of ed9adb356 (Cygwin: pipe: Switch
pipe mode to blocking mode by default, 2024-09-05)). The rationale for
that decision was the desire to simplify the code, which came at the
expense of working well together with pipes that were created outside of
Cygwin and that are set to non-blocking mode.

To this end, the current implementation now _emulates_ non-blocking
behavior while keeping the actual pipe in blocking mode. This requires
knowing how much data can be written to the pipe without blocking at any
given moment. Because by knowing that amount, even in blocking mode a
write operation can be performed that does not block. This information
is obtained via `NtQueryInformationFile(FilePipeLocalInformation)` and
stored in the variable `avail`.

However, if for some reason it cannot be determined how much space is
available in the pipe, this non-blocking mode emulation would not work.
Therefore the pipe is set to genuine non-blocking mode in such cases,
and only in such cases. This minimizes the time window (but does not
eliminate it completely!) during which Cygwin does not work well
together with non-Cygwin processes via pipes.

It also shows that the original desire to simplify the code can not be
fulfilled using the current strategy, as there is now both code to
emulate non-blocking mode as well as code that handles genuinely
non-blocking mode.

This information whether non-blocking mode is merely emulated or
genuinely enabled, is tracked by the Boolean variable
`real_non_blocking_mode`.

At the beginning of the loop body, after determining how many bytes to
write (stored in `len1`), the `NtWriteFile()` is called. Since the
re-design to always use blocking mode (at least insofar possible), this
`NtWriteFile()` call is guarded by a condition so that it is called only
once in non-blocking mode.

Now, the logic for that is quite complex. First, `len1` is clamped to
`chunk` in blocking mode, otherwise to however many bytes are left to
write. Then, an _inner_ `while` loop runs as long as `len1` is greater
than 0. Inside that loop, `NtWriteFile()` is called _unless_ we'd try to
write more bytes than are available in emulated non-blocking mode.

It is the complex interplay between that clamping to `chunk` and the
condition when `NtWriteFile()` is skipped that is at the heart of this
bug.

But let's first see what happens in the case described above, where the
(Cygwin) SSH process gets stuck writing to the (non-Cygwin) Git process.
In the instances I observed, the big `while (nbytes < len)` loop is
started with the following initial conditions: `len` is 2097152, `chunk`
and `avail` are 1 and `real_non_blocking_mode` is 0.

When the outer loop is entered, `len1` is therefore also set to 2097152,
and at the start of the inner loop the condition `len1 > avail` holds
true. Therefore, the `NtWriteFile()` call is skipped already during the
first iteration, we run into the code that tries a short write (setting
`short_write_once` to 1), and ultimately fail and return from
`raw_write()` with an error.

Since not a single byte was written, the caller will try again at some
stage, failing again, over and over, and we're in an infinite loop.

The fix chosen in this here commit is to apply that clamping to `chunk`
_also_ in the emulated non-blocking mode. This lets the `NtWriteFile()`
call _not_ be skipped in non-emulated non-blocking mode, as was clearly
the intention.

An alternative patch that would have also addressed the symptom would be
to partially revert this hunk of cbfaeba4f7 (Cygwin: pipe: Fix incorrect
write length in raw_write(), 2024-11-06):

         chunk =3D len;
    -  else if (is_nonblocking ())
    -    chunk =3D len =3D pipe_buf_size;
       else
         chunk =3D avail;

The logic changed such that `len` would no longer be clamped to the same
value as `chunk` in non-blocking mode. Reinstating that clamp in
non-blocking mode would also work around the issue, but it would be a
bit more heavy-handed than the chosen fix.

Yet another potential fix that was suggested (in
https://github.com/git-for-windows/git/issues/5688#issuecomment-2995952882=
)
would be to modify the condition when `NtWriteFile()` is skipped so as
to force it to _not_ be skipped when attempting a "short write", i.e.
when `short_write_once !=3D 0`. This fix would have worked around the bug
successfully, but is fixing the bug at the wrong layer (even if it hints
at the fact that the `short_write_once` logic is ill-prepared for
non-blocking mode, but that's a topic for another patch).

Fixes: cbfaeba4f7 (Cygwin: pipe: Fix incorrect write length in raw_write()=
, 2024-11-06)
Co-authored-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
Published-As: https://github.com/dscho/msys2-runtime/releases/tag/fix-ssh-=
hangs-reloaded-v2
Fetch-It-Via: git fetch https://github.com/dscho/msys2-runtime fix-ssh-han=
gs-reloaded-v2

	This iteration undoes my patch from the first iteration, accepts
	Takashi's proposed patch from
	https://github.com/git-for-windows/git/issues/5682#issuecomment-299628514=
0
	and adds six hours worth of commit message writing.

	Contrary to my usual practice, I'll forgo the range-diff as both
	the patch and the commit message are complete rewrites.

 winsup/cygwin/fhandler/pipe.cc | 2 +-
 winsup/cygwin/release/3.6.4    | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.=
cc
index e35d523bbc..83d05e5efb 100644
=2D-- a/winsup/cygwin/fhandler/pipe.cc
+++ b/winsup/cygwin/fhandler/pipe.cc
@@ -561,7 +561,7 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t=
 len)
       ULONG len1;
       DWORD waitret =3D WAIT_OBJECT_0;
=20
-      if (left > chunk && !is_nonblocking ())
+      if (left > chunk && !real_non_blocking_mode)
 	len1 =3D chunk;
       else
 	len1 =3D (ULONG) left;
diff --git a/winsup/cygwin/release/3.6.4 b/winsup/cygwin/release/3.6.4
index c80a29ea4f..40b842be88 100644
=2D-- a/winsup/cygwin/release/3.6.4
+++ b/winsup/cygwin/release/3.6.4
@@ -9,3 +9,7 @@ Fixes:
=20
 - Fix creating native symlinks to `..` (it used to target `../../<dir>`
   instead).
+
+- Fix yet another issue with non-blocking pipes that could lead to
+  dead-locks e.g. when writing large amounts of data to a non-Cygwin
+  process.

--8323328-52365794-1750775274=:124--
