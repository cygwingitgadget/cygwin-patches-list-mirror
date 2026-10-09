Return-Path: <SRS0=9Csj=H7=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
	by sourceware.org (Postfix) with ESMTPS id A88394BA5435
	for <cygwin-patches@cygwin.com>; Fri,  9 Oct 2026 09:23:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A88394BA5435
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A88394BA5435
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:4860:4864:20::32
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1791537825; cv=none;
	b=YFCcPGTMDeuOADBnK7wILZfSIY0CSifhByvcxIBgc2d45YGwq3F7HyR2IitGaDGzvY5tGU7CpD1JH4quVQN+gtL6Pns1YRYaZI1Qe/yX9fuVaHylh3QQQgEBPvKWbQ6UKh5DnbfPbefIe2bGarcso77YvGjoxWyUofG1PtnKQCQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791537825; c=relaxed/simple;
	bh=IMnjzRy63N3m0CaxuCd3fX+15mOC17zS23PlD9e5Ve4=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=Y52zNq1yYIlNXunHTWVFprmw6ZWk8TUHZ/L2TdAQR7yWUiZOJ+JuL1I9Ww0MmYetVCiD/7gLi4hVpzdC4UjpyYXs5uIAbx2Ag6hzlbdhbBfGT29+lV7fxOYN0GFraddhdkW6PFg86JDGFi9m+Yb7zRgCawIH310v34nxuoqdKp4=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MhRVivnI
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A88394BA5435
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MhRVivnI
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-499f20c7054so2079814fac.0
        for <cygwin-patches@cygwin.com>; Fri, 09 Oct 2026 02:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791537823; x=1792142623; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+PNcOC32eNTOBGQAFWdcPUchSBA5KONc16oR/uNEgnE=;
        b=MhRVivnIeK7Tb/Eds9fRtu9tiNQjz4NRZMFJM+LCrFJ2YeC198RdcpLbppDxf9IvBu
         XsG3GiNgns1RXuwUlV9UHqfQ/W9+jdG0A4VSgHrXpMhWoFjgFjqJsKSs+eOREeXHdn6b
         EL/ujJn5jLd1LCcABAz0SUfAv3SeLl1aF7UxAvCqUehX5dxL7zD4tPYDVzRjORFh5c0j
         yJARiHO1m3xVVOARqDTYCJ4ZSI82o6Z8WcnsumZHwy4FUEFexQLzzhHkOwXoJf1OXpBq
         +Duy3UuJL4b7uB57IhXc4IZqLDjGJnsy+OGXrvBXj6pZEo3hrGKfePA+LKSyEk/AE1kZ
         cJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791537823; x=1792142623;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+PNcOC32eNTOBGQAFWdcPUchSBA5KONc16oR/uNEgnE=;
        b=Gg9aBzdM5bL2qAzMiIRqL/3VcswZFTaadsf5SxQgLt1CGDBG8ggm24pVVya1QY0QK1
         qnLs6n7w24BZRWUVj+tU386vOpLy6C/Gz3QaoaeorqiTfWjpYq1ttRErt5smCPRKUOWY
         T8XQmCnvC9aNnIYJILPVPKhYll89fylsnxSxVCt8bMERyq0ZwGFOgzfZ9CMmfoMCCBg4
         Arg8/o5zzFPWpxJOjrsg5Bi1bB27kroHFxaJheYDDr7EzgJi8dN/l5mSpnovrULUGrYp
         tuWLeIUL59QbZ+xFB/4pNGq64c0tcX37VvlsOiEbui7hO3QbEpsYiiVZ1lrTRYKh7GnV
         j6Og==
X-Gm-Message-State: AFuF++mPvI8vxdzIwdKSh/R2aDj6PwRcOxySf0mUa6Kz5BJrrTWiiE3x
	pP5KZEkWE8BP7uesGUh03mZgi4di15Dq5AkFVofLvRFOUSusUA6a5GTGDSONJg==
X-Gm-Gg: AYBFou0ZRL/T7bwTOmyn50kr4znCqI+oFW9CzfhTHxaaIHC07YpqeEdAaTsKp/AS0C7
	6+WdYe666OflUNT+cQ1fJ0DXpyH2hZQ7+HvhgDtFEzqoeWssD//tzoLI0S+d/nHF2WgGyufg7/P
	LYQNZUBtHwpt06ZVVFv19mmCIGsiUrj3g5wtsFxYin+xIK8uN43s2X6TaRxXQGUQM79hit2EQI9
	VJxKlcCA9vnqfLW92Uxdt+W5eyVBEitG34CX+Ykd7viOjSJhxj/IR7z/9fyNOyfslILb+epf4tq
	Ud0sqmjQVy7Nnl3+XoR7Vb9UDT71KsjBlUN9Ouwqc6VwKp+Ao5l3zog7WK52XqZyROhh6Lu2O1m
	9dJYHstutJbA//7buaXBjCJ32gecjV8Nvv7MsYLgmu29R2Auuhi3uV0pSDGgYzwhf1COCqQRqDv
	UUYcqH8YEHEoFbQjPcgqLUCfeF59dFJ/l3yPJTQRG/4/GS3cYAGru9h1IrCLcsmRL5+KNo2sYhG
	g==
X-Received: by 2002:a05:6808:198d:b0:4f3:890b:5fec with SMTP id 5614622812f47-50c541707f3mr1087375b6e.25.1791537823585;
        Fri, 09 Oct 2026 02:23:43 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.31.81])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c16755440sm1472873b6e.6.2026.10.09.02.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 02:23:42 -0700 (PDT)
Message-Id: <pull.13.cygwin.1791537820.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Oct 2026 09:23:38 +0000
Subject: [PATCH 0/2] Cygwin: console: Preserve saved modes with redirected stdio
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,POISEN_SPAM_PILL,POISEN_SPAM_PILL_1,POISEN_SPAM_PILL_3,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
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

Johannes Schindelin (2):
  Cygwin: console: Preserve saved modes with redirected stdio
  Cygwin: testsuite: cover console mode preservation with redirected
    stdio

 winsup/cygwin/fhandler/console.cc          |  5 +-
 winsup/testsuite/Makefile.am               |  1 +
 winsup/testsuite/winsup.api/console-mode.c | 66 ++++++++++++++++++++++
 3 files changed, 70 insertions(+), 2 deletions(-)
 create mode 100644 winsup/testsuite/winsup.api/console-mode.c


base-commit: 8f145421c964d58539f93d2615a338734772db2c
Published-As: https://github.com/cygwingitgadget/cygwin/releases/tag/pr-13%2Fdscho%2Fconsole-output-mode-disables-process-output-v1
Fetch-It-Via: git fetch https://github.com/cygwingitgadget/cygwin pr-13/dscho/console-output-mode-disables-process-output-v1
Pull-Request: https://github.com/cygwingitgadget/cygwin/pull/13
-- 
cygwingitgadget
