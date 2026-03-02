Return-Path: <SRS0=T3ZE=BC=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-dl1-x1232.google.com (mail-dl1-x1232.google.com [IPv6:2607:f8b0:4864:20::1232])
	by sourceware.org (Postfix) with ESMTPS id 69DB54BA23CE
	for <cygwin-patches@cygwin.com>; Mon,  2 Mar 2026 14:24:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 69DB54BA23CE
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 69DB54BA23CE
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::1232
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772461489; cv=none;
	b=vNnAssLgYGKsnIHkR8E3z39zGHgk2SM7EpC0f42bHrpm22tTCIm8TnSfuJ2B6hlCQIfzv/g2X4Xa7V03o3Ip2OKnEPd1+xhWsOUJt5i+eT9M3uT0enScsUccsbdrrpy162tWJBMhviYrR205Znemfi48uU3cw9ciDbRxG/NaMi4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772461489; c=relaxed/simple;
	bh=STpiKZ529pk+XwTSWtNkxQDL5thKyA/UswNhnmMStRI=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=YZdxx4mVbPPyd3HM9EoUe4AONvEJXfwdgw3zeWb6gMbXHycDyKR0Zp/OOVovGB6JisCySNfOk/Ic4T0rIl8r7LqVYfxeMqEG5rs/aTkcFJ8Iuf4owAxGeqxTJir18zS2qKDAfc2+u8BzQm0FlOcPJXew9h4Eb/S2WT4ag7ibjC4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 69DB54BA23CE
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Dks08R1h
Received: by mail-dl1-x1232.google.com with SMTP id a92af1059eb24-126ea4b77adso5705258c88.1
        for <cygwin-patches@cygwin.com>; Mon, 02 Mar 2026 06:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772461488; x=1773066288; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aoxYsTNTRiH+8ki1442GV2sM4LnIhnsx+xKRenWrzmk=;
        b=Dks08R1hVP0hAqgW/i2zSJ4ddN47/Y8PZOyQl++kv0FfTMkYEDcB+ZVnW/boCjmkVl
         cqFdHvfShjqdbAgVOeeWlG+ZMeZVJJnHrF6JEBC0zjooLha/7brh60KkhEsc5e5gtHbw
         Pr/FLDOeKiouWnzx9nwWu8ON+lp8bcb8q6t6IJK3DnpyENu201Z2I0ix+P4tXtWXIqz5
         YeD3S8+qDQmhmSpXa7GTLzeunwkNrCGXd0yvnN9sn1c2mBxxvnIvtCYEYG7/hN3CciP2
         qTi49p5k0fOa+7q2nAkEy3cI94trVww2xLURbmGKiCZR91+LLXU3SaO2PvZHXAON61Oh
         ZqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772461488; x=1773066288;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aoxYsTNTRiH+8ki1442GV2sM4LnIhnsx+xKRenWrzmk=;
        b=SZGu9FnNxZRvnX6/pG1DeDXnvZ9vEESi4lL54oDIoPvcF4t0TuumvrmdzPSEQ58ADd
         QNWjDcy+AdhkmRcg4XKTnY3M2sehE5SB32jNF3YKlnKgrpx3X2G4FX66NIlfkNz7jW2K
         IfVb8b7oLtntO8dCH3qo6A/oDGjGNfng4JkpfPeJMFojaT6h0ptFULc8BV3SMhxc/8pL
         wQ+2FohC1SL12ibO4qj8uKMN0yY8MooADMGMcN3JYAB9mo2ZzR5aBpiyfFSTttY80UrZ
         opS4Qe1UyGD1qE2bHDyOpnlO7AyVqGJATHfrYU+d96Rl8gddZ2uO0x/501LMJD5JsGBi
         lozw==
X-Gm-Message-State: AOJu0YzubiEVX6uyBd3vOo6fwofLzQL3RyXNvdjguUc8K08D22uKdf7g
	Cb+cf/ze2c3PKPMgOGOPayuGzYTSLr+L+wadDuhaUqdFonjVpXRuao3850n+LLPE
X-Gm-Gg: ATEYQzyqkNFoP6xdAK+uOTAhOTllPoYah5F8UR8HnM3A/sL1Va3ZE0UOUfSV1omzC4U
	JSbZsrqa/RSVXmzR4BmbAcsZGdw5N8eaJuO1XxhCsG17cCUaE/nmIbzL2mSRDsFvOD8ONtk+aVA
	ImEz+A3AXbLWDlDWNh7Bmzb2MN03Mv1yCgDz8M4GHY3/1yR6HGJawVwmGi1kTXyIL2acbQoOykg
	0DTjKBWTZk5YbYBToSmOrRAo36L84vy2MS9x/k95WEEOjQz5F2HKrSokD/lj48cYpAMnZcpEOi/
	H54gBaX+yQc5taGMdsFJ4npveL42AE2IQ6vj+ZEtcymfPjoOwSi8sbqO9p0VHqcEnx4GCWE5aNq
	qPFYDKJhnNDVUSS5YKjydSqRq1yVfp45kMXl6ii/wxryW9niOxdTkNh6NnuXcaW/IkOwWhgGvY/
	k4djYC7d75Ow2PyOjr6/kUZFzW5w==
X-Received: by 2002:a05:7022:fa5:b0:11b:9386:a37d with SMTP id a92af1059eb24-1278fca68b4mr4795218c88.44.1772461487762;
        Mon, 02 Mar 2026 06:24:47 -0800 (PST)
Received: from [127.0.0.1] ([52.159.245.148])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be03fc6fcesm4841952eec.1.2026.03.02.06.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 06:24:47 -0800 (PST)
Message-Id: <62e2d1178e28aa525c73ce1fd8a5dd03c9931e9e.1772461480.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.6.cygwin.1772461480.gitgitgadget@gmail.com>
References: <pull.6.cygwin.1772461480.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Mar 2026 14:24:39 +0000
Subject: [PATCH 3/4] Cygwin: pty: Prevent premature pseudo console teardown
 that amplifies oscillation
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The two preceding commits removed transfer code paths that stole
readline's data during pseudo console oscillation.  This commit
addresses the oscillation itself: a guard function that tears down
active pseudo console sessions prematurely, causing more frequent
oscillation cycles and thus more opportunities for the remaining
(less harmful) timing issues to manifest.

The function reset_switch_to_nat_pipe() runs from bg_check() in the
slave process.  Its purpose is to clean up the nat pipe state when
no native process is using the pseudo console anymore.  Its guard
logic was:

  if (!nat_pipe_owner_self(pid) && process_alive(pid))
    return;   /* someone else owns it, don't reset */
  /* fall through to destructive cleanup: clear pty_input_state,
     nat_pipe_owner_pid, switch_to_nat_pipe, pcon_activated */

The nat_pipe_owner_pid is set to bash's own PID during
setup_for_non_cygwin_app() (because bash is the process that calls
exec() to launch the native program).  When bg_check() runs and
calls reset_switch_to_nat_pipe(), nat_pipe_owner_self() returns
true -- the first condition becomes false, the && short-circuits,
and the function falls through to the destructive cleanup.  It
clears pcon_activated, switch_to_nat_pipe, pty_input_state, and
nat_pipe_owner_pid -- even though the native process is still
alive and actively using the pseudo console.

This forced every subsequent code path to re-initialize the pseudo
console from scratch, creating exactly the rapid oscillation
described in the earlier commits.

Restructure the guard into two separate checks:

  if (process_alive(pid))
    {
      if (!nat_pipe_owner_self(pid))
        return;   /* someone else owns it */
      if (pcon_activated || switch_to_nat_pipe)
        return;   /* we own it, but session is still active */
    }
  /* fall through: owner died or session ended */

When a different process owns the nat pipe, the behavior is
unchanged.  When bash itself is the owner, the function now also
returns early if pcon_activated or switch_to_nat_pipe is still set.
Both flags are checked because during pseudo console handovers
between parent and child native processes, pcon_activated is
briefly false while switch_to_nat_pipe remains true.

The cleanup still runs when it should: when the owner process has
exited or when both flags indicate the session has truly ended.

Regression note: this change is strictly more conservative -- it
adds conditions that prevent cleanup, never removes them.  Every
scenario where the original code returned early still returns early.

Addresses: https://github.com/git-for-windows/git/issues/5632
Fixes: 919dea66d3ca ("Cygwin: pty: Fix a race issue in startup of pseudo console.")
Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 winsup/cygwin/fhandler/pty.cc | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 2450057c1..dd7ea9038 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -1171,12 +1171,23 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void)
   DWORD wait_ret = WaitForSingleObject (pipe_sw_mutex, mutex_timeout);
   if (wait_ret == WAIT_TIMEOUT)
     return;
-  if (!nat_pipe_owner_self (get_ttyp ()->nat_pipe_owner_pid)
-      && process_alive (get_ttyp ()->nat_pipe_owner_pid))
+  if (process_alive (get_ttyp ()->nat_pipe_owner_pid))
     {
-      /* There is a process which owns nat pipe. */
-      ReleaseMutex (pipe_sw_mutex);
-      return;
+      if (!nat_pipe_owner_self (get_ttyp ()->nat_pipe_owner_pid))
+	{
+	  /* There is a process which owns nat pipe. */
+	  ReleaseMutex (pipe_sw_mutex);
+	  return;
+	}
+      /* We are the nat pipe owner.  Don't reset while a native process
+	 is still using the nat pipe -- check both pcon_activated and
+	 switch_to_nat_pipe since the latter stays true during pcon
+	 handovers when pcon_activated is briefly false. */
+      if (get_ttyp ()->pcon_activated || get_ttyp ()->switch_to_nat_pipe)
+	{
+	  ReleaseMutex (pipe_sw_mutex);
+	  return;
+	}
     }
   /* Clean up nat pipe state */
   get_ttyp ()->pty_input_state = tty::to_cyg;
-- 
cygwingitgadget

