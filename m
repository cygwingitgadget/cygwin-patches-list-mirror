Return-Path: <SRS0=9Csj=H7=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by sourceware.org (Postfix) with ESMTPS id 2C1834BA5435
	for <cygwin-patches@cygwin.com>; Fri,  9 Oct 2026 12:12:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2C1834BA5435
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2C1834BA5435
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::536
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1791547978; cv=none;
	b=L0GUW4wdyE+ZIk7pRx2NDoDn2ZCBD6BojsNpI0B/HxlDBM2eRcTwAV1dzUDKou5xrFBKazTYIHnfp47D7DH/vO1B5zU+73M55rzSWwnhtuFfD6KmqZ6eaXU4X3tAFQ0vlREysbSLUonDn+RjqNzQDBz92jvxMWYkBghqgP+4gDc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791547978; c=relaxed/simple;
	bh=2eflQJgXhsiMMlzAtveRL08jxWWsmf1ORJ3K48SXNLE=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=FMHrks+a4q5gEvbkAPvoDLfLeP5gH+I7TlrEtcmqxy6F+z/sbT5uiK+xhJqQfgU02EGulS08g0vImffjIgHGCaQMtH4S4Pqyk8J3/0j3ixCQQspeJN2Frrzo2dMn8K3i6bZ6JzJ/f51hVMeOgzM9RD2bf6rub31ul+WEYKUhQpY=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SVzSTuTf
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2C1834BA5435
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SVzSTuTf
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-cc147d86bebso1120136a12.0
        for <cygwin-patches@cygwin.com>; Fri, 09 Oct 2026 05:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791547977; x=1792152777; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Rj8458djTpRjelNfylJXdyjuuQ9nDGsvxNIlS8JwJOA=;
        b=SVzSTuTfXeB423jmV+C4uBMRsy0ed1+qH8Dsgid1cHfiDue4qH4V0K1xfLX6nQLTE+
         JJ3npjtuzLW1j5CoXTrF5H8vR60dPNDeH1kJ8MwI/GJqnP7kS9UnTsyO4y2027C9Vv/o
         5yIBAlK6ewRzSMLj4YVGl5VlkippwQDtRV2FC0GFeHCTa0psxLuQmv6tp/IMnFM9vVLc
         MfagaEiP8n6NVFmu9p1ccriicw56ZAFvhEMuShFm25LzdUw3yRzxy0HdvbunfO5fHaGE
         0pMa665o5rj/T4IRQ4bFvOIe48cGkXc/V7aQeVUpg7+H+tBFhwAFzP9gM1qF6EYpjrcR
         konA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791547977; x=1792152777;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rj8458djTpRjelNfylJXdyjuuQ9nDGsvxNIlS8JwJOA=;
        b=ia4TZ/8Zjc7d6hHsEaKTq02HO38Y/JTWJy/o20IJ8DnA9HfKWL6pUF4wNBVFPKNCFG
         69WktuZrpKJNmH0ZlKqqR2NTePCTZp45xD6nhnK81CKJCFJuXcHVogPgdnPMJ2IUtwVS
         6iXCU5zYps9u36M0K4vYT2hFSXQbe3sHGth2R4UfeZjlO25j1PBFNO9UknyIgkhZ1x5u
         wgVVxEuTskGdFlePgdhTctuG27vfLBTYKU3eNkDXcFbqkHOqB/7Xa34N1nzPuIvf9Mo/
         qYlDtwTTd1p9Zdg8Ls9UUMgWn9JQ8zxRstk6ME5ReOSsUfrij8cu15KrtOhFpMBCne7t
         Kh0g==
X-Gm-Message-State: AFq9FYKWcUgUY01Fn/FS0SC3rlsbbKd/L4HcJVbYBp8VPNkVtZgKuiu8
	yKWdPcIgPS44TWpCezJyaQqDEsJhR6iYN/rokC5328Wx6EwxzK+ng2EJt6rymA==
X-Gm-Gg: AYBFou0CEKMO4VgswyYML1aLTJBS1cF19g+9bjyV5gnRT6IgfcrNJC0gqruiKgSutF0
	X8x5VVSodnT9xWG4dGUEzreqKfqU9u7k9PcXpAGhLonKwcZTfv2UBrf7Cmf/jzvYOz3UA4spE/B
	CmVDtZex1iFaFsgZdsW5SmfYhJL4ZLGAEUNNfRhjG8Iz8/tM8Xg5PBKMjgmtH4+umhZtFIuENUq
	yjCxwWzPcnApLUrzThp7jiQpnY1RsC/wzjzsufKzbqoXhNlS+nzUKF64fAZ5vw6VUtGko43KDh1
	Hae1n66ZrY1K4ogcy0gn4N7nJybxxmzT+Bt+3o3rICKpXYpR8Mt99D0KOsAMJ98yitoujSsP7Y+
	sRQAG/yXNTDAAMYsUxUnYPql+y4srVrhOtxLQIMSk3JE/i+XbaBz1Akj/lRCVbu1afI50gxQT+b
	Pd7eglBhEWWT5jJ+JZwrluurdFSx0iR5Jk2NZkB4Cccx+9R8h69+Zz8yb2rSLosFNzQUBmQbQ=
X-Received: by 2002:a17:90a:d604:b0:3a7:ed4d:afeb with SMTP id 98e67ed59e1d1-3ab3ab35683mr1094311a91.27.1791547976828;
        Fri, 09 Oct 2026 05:12:56 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.102.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3369530a91.4.2026.10.09.05.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 05:12:56 -0700 (PDT)
Message-Id: <pull.13.v2.cygwin.1791547975.gitgitgadget@gmail.com>
In-Reply-To: <pull.13.cygwin.1791537820.gitgitgadget@gmail.com>
References: <pull.13.cygwin.1791537820.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Oct 2026 12:12:53 +0000
Subject: [PATCH v2 0/2] Cygwin: console: Preserve saved modes with redirected stdio
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,POISEN_SPAM_PILL,POISEN_SPAM_PILL_1,POISEN_SPAM_PILL_3,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

An issue was reported in https://github.com/msys2/msys2-runtime/issues/379:
console output mode drops to 0 (ENABLE_PROCESSED_OUTPUT off) after a native
child process tree exits. The symptom can be verified in a Windows Terminal
with this bash script (requires a non-Cygwin Python, in this instance it is
using MSYS2's /ucrt64/bin/python3.exe):

#!/usr/bin/env bash
set -e

script=$(mktemp)
trap 'rm -f -- "$script"' EXIT
cat > "$script" <<'PY'
import subprocess
subprocess.run(["pacman", "--version"], check=True, capture_output=True, text=True)
print("line one")
print("line two")
PY

for run in 1 2; do
	/ucrt64/bin/python3 "$script"
done


With MinTTY, it works as expected, but with Windows Terminal, it prints
this:

line one
line two
line one♪◙line two♪◙


The culprit is this: When standard streams (such as stdout or stderr) are
redirected away from the console while stdin remains a console handle,
fhandler_console::open() skipped populating the process-local
prev_output_mode_backup (or prev_input_mode_backup). Because these backup
fields remained uninitialized (zero), subsequent console mode restoration
upon process exit in close() transferred that zero backup into the shared
con.prev_output_mode, which then got restored to the Windows console handle
by the next process invocation, clearing flags such as
ENABLE_PROCESSED_OUTPUT.

To resolve this, fhandler_console::open() now unconditionally populates
prev_input_mode_backup and prev_output_mode_backup from con.prev_input_mode
and con.prev_output_mode under cons_mode_mutex before checking whether
standard handles are consoles.

A companion test case in winsup/testsuite/winsup.api/console-mode.c
exercises child execution under redirected standard streams via cygrun and
verifies that ENABLE_PROCESSED_OUTPUT is preserved across invocations.

Changes since v1:

 * While upstreaming from MSYS2, I missed that the cygrun environment
   variable went away and I now have to use mingwtestdir to construct the
   value, which is now fixed. (Sorry, I had missed that because GitHub seems
   to have disabled Actions in https://github.com/cygwingitgadget/cygwin; I
   re-enabled them.)

Johannes Schindelin (2):
  Cygwin: console: Preserve saved modes with redirected stdio
  Cygwin: testsuite: cover console mode preservation with redirected
    stdio

 winsup/cygwin/fhandler/console.cc          |  5 +-
 winsup/testsuite/Makefile.am               |  1 +
 winsup/testsuite/winsup.api/console-mode.c | 69 ++++++++++++++++++++++
 3 files changed, 73 insertions(+), 2 deletions(-)
 create mode 100644 winsup/testsuite/winsup.api/console-mode.c


base-commit: 8f145421c964d58539f93d2615a338734772db2c
Published-As: https://github.com/cygwingitgadget/cygwin/releases/tag/pr-13%2Fdscho%2Fconsole-output-mode-disables-process-output-v2
Fetch-It-Via: git fetch https://github.com/cygwingitgadget/cygwin pr-13/dscho/console-output-mode-disables-process-output-v2
Pull-Request: https://github.com/cygwingitgadget/cygwin/pull/13

Range-diff vs v1:

 1:  9a4e55cd7 = 1:  9a4e55cd7 Cygwin: console: Preserve saved modes with redirected stdio
 2:  a26e05414 ! 2:  b9c0afe80 Cygwin: testsuite: cover console mode preservation with redirected stdio
     @@ winsup/testsuite/winsup.api/console-mode.c (new)
      +  assert (close (fd) == 0);
      +  snprintf (command, sizeof (command), "\"%s\" child", exe);
      +  const char *arguments[] = { "cygrun", "-notimeout", command, NULL };
     -+  assert (getenv ("cygrun"));
     ++  const char *mingwtestdir = getenv ("mingwtestdir");
     ++  assert (mingwtestdir);
     ++  char cygrun[strlen (mingwtestdir) + sizeof ("/cygrun")];
     ++  sprintf (cygrun, "%s/cygrun", mingwtestdir);
      +  /* cygrun starts the child without Cygwin's spawn bookkeeping. */
      +  for (int i = 0; i < 2; ++i)
     -+    assert (spawnv (_P_WAIT, getenv ("cygrun"), arguments) == 0);
     ++    assert (spawnv (_P_WAIT, cygrun, arguments) == 0);
      +  assert (GetConsoleMode (output, &mode));
      +  return !(mode & ENABLE_PROCESSED_OUTPUT);
      +}

-- 
cygwingitgadget
