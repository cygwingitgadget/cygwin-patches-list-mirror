Return-Path: <SRS0=ISKq=II=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com [IPv6:2607:f8b0:4864:20::1332])
	by sourceware.org (Postfix) with ESMTPS id 2C50C4BA2E16
	for <cygwin-patches@cygwin.com>; Sun, 18 Oct 2026 15:07:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2C50C4BA2E16
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2C50C4BA2E16
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::1332
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792336069; cv=none;
	b=W74Fyud6WWj/pt1IO8wauhTw523erjtOKZx8Ss6vXn6UiYwHRoTUPtZXS+jE/H6Fg7F2ywFuS7zbwwzc3s8Dzx7U3Q9JDJN5p0Jtetr7i8VGd546v0P3y2T2auUYwiiRukm2wW2Q9hsKLmDi7j3egvHwfF0el1q7jiVAk5IFmkk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792336069; c=relaxed/simple;
	bh=jP2VTfytxqcGmVXFh87FQOMM9fsAFDNNz/RAB6qbht0=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=blmYNSNqigQablkvz0M/mixgXbu5aeJ6aOE8092ncD9zqb4900XupaqkCue9zjPn2z3vA8tNscTWXWDmkUi8m6XLF6Ng4CN6jiOxIGwIcKX8k3mvgdpwi8+lIPpOHjSYm6EMzObV5fqOJXYft69t6NfPDb9qYe2CzN3kzP/xEqE=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hYeHyVDn
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2C50C4BA2E16
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hYeHyVDn
Received: by mail-dy1-x1332.google.com with SMTP id 5a478bee46e88-35f036b17easo2996834eec.1
        for <cygwin-patches@cygwin.com>; Sun, 18 Oct 2026 08:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792336068; x=1792940868; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pbDy+X/205p5Gb73o7jNO1EW0UzlB+kkh2GZ7nFGOi0=;
        b=hYeHyVDnTL3jynit6hwT0X4Sd7+1A99rRvme6uqGvut7ZQg5aZ3nuddWoVge0N7KGf
         xa2QZTRNiAZVBRorCVSJFdjyD7fIw4JUygi1n2OXeC+jvKod5ZA85sN/ksN5tQUn/+pX
         +ojjlX3LXZSawh4efREJlydRZ1Pw4Uf4jBhxv676x3TXf1z/kkjNDVOWab40j5MOuNZa
         kkJ4rAbov1LoNYCrs/PsMwKIU3S4NX2heaPBCVcLopW0bnTA+Ey0LRHZvit7KW7hcObs
         wZiMv25Yk0SaVdij0JSf8b3lU1WSAz005zu0nRkhKYnsTYO3jgcDQkZaieS8R4ECr6N9
         UW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792336068; x=1792940868;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pbDy+X/205p5Gb73o7jNO1EW0UzlB+kkh2GZ7nFGOi0=;
        b=WyNXEi+c+bi0mBykDlFcRcbFeOOzY5yfbZJ1okmuzj0KW60ufogiykIJ55EWX8hywV
         GRcTw3dSbATV6bow4zwdKKAJzAPFmwKgwXFR8cm3q6T5R0OOOCrKGWfIi2iiFJO+gqmG
         byaMyrW7cS5y3XkBrYJqG9GUb5COQLb6wy08BhNtPaQddO5AhWX9buI4X4mdjEELj/je
         V7iwkz2LOkabOGU/1FbdBu40ntYxTfOfDnNBWDAGL+kZODMFeMt39cqjEtZK2b7uXLkO
         nfVWi2FX8HU6ewTApjz/LsqwbdiKZM6EXKl5z3oa3zEOTL/t+EENYTap+iD5LiaISizt
         lg1g==
X-Gm-Message-State: AFq9FYKgn6a9GEDYQjbmY0Rhat1OX1/Htdc9TIKmW2FscCBKexLrGL0H
	gp6vEYmHOh0dynH8u5vAqMTnjfN/d63OgHGMtQ5j84ikBkUgUATP0ShegsC/TA==
X-Gm-Gg: AYBFou0c+2G4fn7wp2R14HCDYPBQiW837ZSh5+RF06TZNUXdIgMN2q+ZFVhwQgo7D2H
	KvQcwtO92rfxIm1dlmVHNRSXPdFPRf8c1a/NKrRLTqMG0ydfdtjRcLz/CCX081b4JvwA5SUCqjb
	OyIOCKRxmGDS5WToQFjj4ecT/fUurRnp1Rszqwr8xRymFh/GgFjSANr97NbJxPQ/g5Wq6hX99aj
	ouI3yB77wNBJua/7j77Nw2HRFv85sD4IvdNoxNfb79UHMYz2Tv/TFd0de5HFQBBbdiypiQxec7/
	nugnb3ue8gxnOkyoH3vob2Qn+U30V5VVTUAgNRJsGBcZXBHgKy4+l7jGEzc5yxn+gmwgaO42hmx
	zMm1g0e9E37G7jbAKzrEQyckHvZn1Wp8fQ/G3oeNv4cWyZwj9f5ovspa+n0h3F01+No7VuPCXDB
	9r9+y/NXfVDfcCPAAwHfgBYfdO+Hh2KRlZ5e/F7Gh87Xs1LO9GWDfHJ99frOM3kl4nd/606wr6Y
	A==
X-Received: by 2002:a05:701b:2902:b0:143:271a:3df2 with SMTP id a92af1059eb24-1851481eb23mr7240260c88.44.1792336067881;
        Sun, 18 Oct 2026 08:07:47 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.203.60])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831ba424a6sm21714418c88.17.2026.10.18.08.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 08:07:47 -0700 (PDT)
Message-Id: <pull.10.v3.cygwin.1792336066.gitgitgadget@gmail.com>
In-Reply-To: <pull.10.v2.cygwin.1792050298.gitgitgadget@gmail.com>
References: <pull.10.v2.cygwin.1792050298.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 18 Oct 2026 15:07:40 +0000
Subject: [PATCH v3 0/6] Cygwin: pty: preserve terminal replies after PTY adoption
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

MSYS Vim launched by native Git from Bash in MinTTY can delete the first
line, enter Insert mode or insert RGB text at startup. The problem is
incorrect PTY adoption, and the same problem applies to the Cygwin runtime
(but is less common because native Windows programs are not mixed with
Cygwin programs as ofte as with MSYS programs).

I merged v1 of this into Git for Windows v2.56.0, as it was somewhat
pressing.

This patch is based on cygwin-3_6-branch, but can be cherry-picked onto
master, too, with minor merge conflicts. I pushed the result to
https://github.com/dscho/cygwin/pull/new/fix-vim-terminal-replies-for-cygmaster.

Changes since v2:

 * Now handles disable_pcon correctly (adding a test case as proof).

Changes since v1:

 * Instead of changing input routing when the program changes terminal mode,
   v2 changes it already when the foreground Cygwin program starts through
   exec().
 * Added a test case that gets run as part of Cygwin's test suite.

Johannes Schindelin (6):
  Cygwin: pty: restore foreground input routing after exec
  Cygwin: testsuite: allow cygrun without the testing namespace
  Cygwin: testsuite: cover foreground PTY input recovery after exec
  Cygwin: pty: recover input for children of native programs
  Cygwin: testsuite: cover PTY input recovery with a native parent
  Cygwin: testsuite: cover queued native input with pcon disabled

 winsup/cygwin/fhandler/pty.cc                 |  52 +++-
 winsup/cygwin/local_includes/fhandler.h       |   2 +
 winsup/testsuite/.gitattributes               |   1 +
 winsup/testsuite/Makefile.am                  |  27 +++
 winsup/testsuite/cygrun.c                     |  12 +-
 winsup/testsuite/cygrun.sh                    |   7 +-
 winsup/testsuite/mingw/Makefile.am            |   5 +-
 winsup/testsuite/mingw/pty-native-input.c     | 171 ++++++++++++++
 .../winsup.api/pty-background-native.c        | 223 ++++++++++++++++++
 9 files changed, 483 insertions(+), 17 deletions(-)
 create mode 100644 winsup/testsuite/.gitattributes
 create mode 100644 winsup/testsuite/mingw/pty-native-input.c
 create mode 100644 winsup/testsuite/winsup.api/pty-background-native.c


base-commit: 867eb7748e6e5a0e8430ce9f46af27b4b1e8f204
Published-As: https://github.com/cygwingitgadget/cygwin/releases/tag/pr-10%2Fdscho%2Ffix-vim-terminal-replies-v3
Fetch-It-Via: git fetch https://github.com/cygwingitgadget/cygwin pr-10/dscho/fix-vim-terminal-replies-v3
Pull-Request: https://github.com/cygwingitgadget/cygwin/pull/10

Range-diff vs v2:

 1:  7f0615fc8 ! 1:  8a6255016 Cygwin: pty: restore foreground input routing after exec
     @@ Commit message
          The existing debugger-recovery handover can do this once the attachment
          mutex has been reopened.
      
     +    Note that this logic must be careful to keep the `disable_pcon` mode
     +    working as-is.
     +
          Addresses: https://github.com/git-for-windows/git/issues/6403
          Suggested-by: Takashi Yano <takashi.yano@nifty.ne.jp>
          Assisted-by: GPT-6.1 Sol
     @@ winsup/cygwin/fhandler/pty.cc: void
      -    fixup_after_fork (NULL);	/* No parent handle required. */
      +    {
      +      fixup_after_fork (NULL);	/* No parent handle required. */
     -+      fixup_input_state_for_cygwin_app ();
     ++      if (get_ttyp ()->pcon_activated)
     ++	fixup_input_state_for_cygwin_app ();
      +    }
       
         /* Hook Console API */
 2:  4f53a727d = 2:  ebf384575 Cygwin: testsuite: allow cygrun without the testing namespace
 3:  92d13761f = 3:  cceb823af Cygwin: testsuite: cover foreground PTY input recovery after exec
 4:  f1a25a8e5 ! 4:  2b13ec62f Cygwin: pty: recover input for children of native programs
     @@ Commit message
          is too early. If `stdin` and `stdout` share a PTY, initializing `stdout`
          later can perform the handover `stdin` missed.
      
     +    Note that we must be careful not to break the `disable_pcon` mode with
     +    this new logic.
     +
          Addresses: https://github.com/git-for-windows/git/issues/6403
          Suggested-by: Takashi Yano <takashi.yano@nifty.ne.jp>
          Assisted-by: GPT-6.1
     @@ winsup/cygwin/fhandler/pty.cc: fhandler_pty_slave::init (HANDLE h, DWORD a, mode
      +void
      +fhandler_pty_slave::post_open_setup (int fd)
      +{
     -+  if (fd == 0)
     ++  if (fd == 0 && get_ttyp ()->pcon_activated)
      +    fixup_input_state_for_cygwin_app ();
      +}
      +
 5:  5bbc7634a = 5:  cdd3d9ce9 Cygwin: testsuite: cover PTY input recovery with a native parent
 -:  --------- > 6:  4469693b5 Cygwin: testsuite: cover queued native input with pcon disabled

-- 
cygwingitgadget
