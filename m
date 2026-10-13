Return-Path: <SRS0=ii+b=ID=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 268DF4BA2E14
	for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2026 14:37:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 268DF4BA2E14
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 268DF4BA2E14
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1791902253; cv=none;
	b=YET/nKY8IwS84+CtTDDnSORjagE8nLShXswtRi2gh4i5Dsz5VQRXbP/B4UEVAEMLpvJ7GrsONsOnl60CRYBgn3/TQKQMZJJgvtxV82jXx22XnFEhejfzZuD1BHN5aI8Wk7gRHRKvBP/2tRWnx47op3M5ZPUd2zet0UMbHjHPDPs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791902253; c=relaxed/simple;
	bh=iI9DpheOG2RHp2YkzHJ/OLQAXxmsLAzCPmwU9zqn/bM=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=HR97n35ZApJG0BOue5O2uHUAD5c/anhfRQAIcgM25Skvg6SOG4ZHkM6gkbGyMRqee8DaBz/gbPzSTpzhN20S+/pUhe4pR19TuITiOiyadWkz5cw+lJ25vFdNu0IKdZAsuVep+rpQaGIMznl7uZvNJ4wIQkmKfZJ2Dhb1sYk3RqA=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=k074rQqG
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 268DF4BA2E14
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=k074rQqG
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20261013143731020.GLJT.117312.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2026 23:37:31 +0900
Date: Tue, 13 Oct 2026 23:37:28 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/2] Cygwin: console: Preserve saved modes with
 redirected stdio
Message-Id: <20261013233728.4857bdd673eb95cdef90fb87@nifty.ne.jp>
In-Reply-To: <pull.13.v2.cygwin.1791547975.gitgitgadget@gmail.com>
References: <pull.13.cygwin.1791537820.gitgitgadget@gmail.com>
	<pull.13.v2.cygwin.1791547975.gitgitgadget@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1791902251;
 bh=beM/DocuWG3cp+sESh2U16dyphJBMpvoeDJuRWBXF2Y=;
 h=Date:From:To:Subject:In-Reply-To;
 b=k074rQqG9iENHB+FdOsJodv1JaPaaTl8vQNYENPdPV+DmcSFCdb+RxB0lwIYzZBBlmgVPJRe
 bir+B6CYXZTNiBIjc4u6pPtoABpr/vLl+fBzkihZ3zYyYkfHiQkabH2bYFh8uAowMLULigGD1j
 L7y8X8KOUOcIM2JL/3IolSz43kSo+VVrBXAwdYnu++fb+wEelsf2bgHQk7vzYv5w68mlIRLFTX
 0JyXUsIDxhT9HAtqSaLO4XDoaoepi/vB/h5rPIoEcrqstgAs0OsD64KuPejm/meiJe24YIvTXi
 IuCk2ddloJ3BmNsimDdvmDEW+JW/3menkCIDHnD8AV5A2ECQ==
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,POISEN_SPAM_PILL,POISEN_SPAM_PILL_1,POISEN_SPAM_PILL_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

Thanks for the patch

On Fri, 09 Oct 2026 12:12:53 +0000
Johannes Schindelin wrote:
> An issue was reported in https://github.com/msys2/msys2-runtime/issues/379:
> console output mode drops to 0 (ENABLE_PROCESSED_OUTPUT off) after a native
> child process tree exits. The symptom can be verified in a Windows Terminal
> with this bash script (requires a non-Cygwin Python, in this instance it is
> using MSYS2's /ucrt64/bin/python3.exe):
> 
> #!/usr/bin/env bash
> set -e
> 
> script=$(mktemp)
> trap 'rm -f -- "$script"' EXIT
> cat > "$script" <<'PY'
> import subprocess
> subprocess.run(["pacman", "--version"], check=True, capture_output=True, text=True)
> print("line one")
> print("line two")
> PY
> 
> for run in 1 2; do
> 	/ucrt64/bin/python3 "$script"
> done
> 
> 
> With MinTTY, it works as expected, but with Windows Terminal, it prints
> this:
> 
> line one
> line two
> line one♪◙line two♪◙
> 
> 
> The culprit is this: When standard streams (such as stdout or stderr) are
> redirected away from the console while stdin remains a console handle,
> fhandler_console::open() skipped populating the process-local
> prev_output_mode_backup (or prev_input_mode_backup). Because these backup
> fields remained uninitialized (zero), subsequent console mode restoration
> upon process exit in close() transferred that zero backup into the shared
> con.prev_output_mode, which then got restored to the Windows console handle
> by the next process invocation, clearing flags such as
> ENABLE_PROCESSED_OUTPUT.
> 
> To resolve this, fhandler_console::open() now unconditionally populates
> prev_input_mode_backup and prev_output_mode_backup from con.prev_input_mode
> and con.prev_output_mode under cons_mode_mutex before checking whether
> standard handles are consoles.
> 
> A companion test case in winsup/testsuite/winsup.api/console-mode.c
> exercises child execution under redirected standard streams via cygrun and
> verifies that ENABLE_PROCESSED_OUTPUT is preserved across invocations.
> 
> Changes since v1:
> 
>  * While upstreaming from MSYS2, I missed that the cygrun environment
>    variable went away and I now have to use mingwtestdir to construct the
>    value, which is now fixed. (Sorry, I had missed that because GitHub seems
>    to have disabled Actions in https://github.com/cygwingitgadget/cygwin; I
>    re-enabled them.)
> 
> Johannes Schindelin (2):
>   Cygwin: console: Preserve saved modes with redirected stdio
>   Cygwin: testsuite: cover console mode preservation with redirected
>     stdio
> 
>  winsup/cygwin/fhandler/console.cc          |  5 +-
>  winsup/testsuite/Makefile.am               |  1 +
>  winsup/testsuite/winsup.api/console-mode.c | 69 ++++++++++++++++++++++
>  3 files changed, 73 insertions(+), 2 deletions(-)
>  create mode 100644 winsup/testsuite/winsup.api/console-mode.c
> 
> 
> base-commit: 8f145421c964d58539f93d2615a338734772db2c
> Published-As: https://github.com/cygwingitgadget/cygwin/releases/tag/pr-13%2Fdscho%2Fconsole-output-mode-disables-process-output-v2
> Fetch-It-Via: git fetch https://github.com/cygwingitgadget/cygwin pr-13/dscho/console-output-mode-disables-process-output-v2
> Pull-Request: https://github.com/cygwingitgadget/cygwin/pull/13
> 
> Range-diff vs v1:
> 
>  1:  9a4e55cd7 = 1:  9a4e55cd7 Cygwin: console: Preserve saved modes with redirected stdio
>  2:  a26e05414 ! 2:  b9c0afe80 Cygwin: testsuite: cover console mode preservation with redirected stdio
>      @@ winsup/testsuite/winsup.api/console-mode.c (new)
>       +  assert (close (fd) == 0);
>       +  snprintf (command, sizeof (command), "\"%s\" child", exe);
>       +  const char *arguments[] = { "cygrun", "-notimeout", command, NULL };
>      -+  assert (getenv ("cygrun"));
>      ++  const char *mingwtestdir = getenv ("mingwtestdir");
>      ++  assert (mingwtestdir);
>      ++  char cygrun[strlen (mingwtestdir) + sizeof ("/cygrun")];
>      ++  sprintf (cygrun, "%s/cygrun", mingwtestdir);
>       +  /* cygrun starts the child without Cygwin's spawn bookkeeping. */
>       +  for (int i = 0; i < 2; ++i)
>      -+    assert (spawnv (_P_WAIT, getenv ("cygrun"), arguments) == 0);
>      ++    assert (spawnv (_P_WAIT, cygrun, arguments) == 0);
>       +  assert (GetConsoleMode (output, &mode));
>       +  return !(mode & ENABLE_PROCESSED_OUTPUT);
>       +}
> 
> -- 
> cygwingitgadget

Both patches make sense to me. Applied.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
