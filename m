Return-Path: <SRS0=ISKq=II=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-dy1-x1334.google.com (mail-dy1-x1334.google.com [IPv6:2607:f8b0:4864:20::1334])
	by sourceware.org (Postfix) with ESMTPS id 4E77E4BA2E20
	for <cygwin-patches@cygwin.com>; Sun, 18 Oct 2026 15:05:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4E77E4BA2E20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4E77E4BA2E20
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::1334
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792335908; cv=none;
	b=YOAesMj8tXLrI1q98TuB1L72fG7UQbTqAnqOtf8ggL23/exJQTamfeDsKcgbF2OElZ/bAtjDnrAGBOIyAVsMwY7Anx9hccIkLdKCMc43ZkaZ6kqF+0VXP1FvJuMiUzlIZS15ajLWx0ISDwof0eboVVNs4hk9OMYzgAFBGf7DEbM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792335908; c=relaxed/simple;
	bh=gtNXAQnsnVJ0CDPfblfW0ktMRkHzd0Pg80xLQF2yT2E=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=NrSjFH+Dn7GpUAOEDpHnND1VFiU3/eEa1sn6vodehjXfmoaAsPTQW436G1vvO+I7bKvZ01qYJfOIetnpExud6lxA99yY+JOjTCWgVxIDEICuOubwPA+XLwbF6POOX3Prlw6D09PzkWCOrs80LUguU34KWe9op9SjYJR64/FaVps=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mRpRSXeK
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4E77E4BA2E20
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mRpRSXeK
Received: by mail-dy1-x1334.google.com with SMTP id 5a478bee46e88-35ef6b49813so2562147eec.0
        for <cygwin-patches@cygwin.com>; Sun, 18 Oct 2026 08:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792335907; x=1792940707; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=opftE73ameGy4y+OFJ3lR9/Na0iUEI+/9i/uWIAINqk=;
        b=mRpRSXeKJr4Mjtz7qOCuXv22sQXDGfc4ZKtT2mozTa+uQI7W+SW+OUeDSyXFzO4ucy
         PLWgZVBuhb+eAys2h5rprPdI/szdekVEYNoMjx8LnJUGGI8oAlF5zBjYKf2OTzE2al/F
         kHpX+stPGURXrsKkTto+HD2Hk3rCHxp1fSnhzrMAUGNnGpP4jM6YMtoK1W5olhaOmukN
         Ptv7A++p0kjtBjnV9U68qWY0dOo79iqVbofiA892NtpxZHP3nrLAwywwQtZhwwvXuvIT
         FDeTvkCPg1CebwI9nYoBTOKen9Ed2pRfbGPDr1Sm0AZ0lPgDy6ZXJ0zuw+GGC+0Zvx/u
         aTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792335907; x=1792940707;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=opftE73ameGy4y+OFJ3lR9/Na0iUEI+/9i/uWIAINqk=;
        b=CaWHx/aYhM1Qghw1Q96xRwsLCgu1UF4LG0JzoBqYOJGFev0IvcB5G4oSEp/RM936zO
         74/OLQDdvwUyZXtAKdvgG6C7mUjnZDo5OdUrvJV5sMvuoA1P9DT8Kann1TtWvp7trbQd
         0M3qv09jYLb2ail9L+WUXsFfQ8XRi9Wp8MmrxesK6Fu2VTTwix4ku+XX/yKY97Vvx24F
         5oSbHZEYT6RfqTql+9jUJv88b52XNASM4Uc3HH+KN1JxHuM6L6xg1wXC8YYvPr5bJKsP
         FuDdlE7rw0R4OK9BIaFBZQk9LeGAxsGXcSGzsdCGi2UurreV1eq9+WqulT3isnQpOluZ
         Slww==
X-Gm-Message-State: AFq9FYJK1w8gWBCtDbcuJ1RLvXHU3gwLBgm5s48rYGoZO7Yxlqjp9g7i
	roY2XUeGvw0P4CeXBF9iVK/l5BxsElhb5byLqlkMJJ3Bij8jmGomqiKw8RhM2Q==
X-Gm-Gg: AYBFou0blSnnsd+OSyFSjfqeke0UcI/lvCLAPwCOYv90D9wQzGxuf0BCpH3FOhml4+u
	2Ng889gI8uPIEsa4GuJI96JgstY7EUHY8LtxvvawzrTPwF/xcpLO60uZuCLdPtwfdaJWbjZZgdH
	EgZvlDBk7P0xnT3BCwua29qfya/14Jux99AH0oKVvp0ox3ZYctnNNjfi6aMqsgg/Z2RKSkk2d/s
	K/4lGTrToPweAhul/dJ1kPH4OnmIvir54hqoR8LR5jew6gYzrK/l5pN2Y1hwiYvljCJ0dCbbIbS
	9e6pMbgwwIn8afactfQToyCUPEOGCTatSoz0xQy8QIxqrDmnEAtkphvJSLLICUIC98YMPFaXztL
	YmwGyAUMua06DcuVysrm3Bu0iaGvPHYKT/Pn9VepgLc142CToXCJR1GKyETEvZYv5qTH6n/g1hP
	+nCMEInBIvkzgucg/jjA0dZEfth6zH6lV5uLGioNMK/gfVCnPS3nQLkObBQwCs1Qg9F16GTOR7V
	i1IiTbXWOhs
X-Received: by 2002:a05:701b:4518:10b0:153:3c50:ab85 with SMTP id a92af1059eb24-18511ad80b2mr7582668c88.12.1792335906687;
        Sun, 18 Oct 2026 08:05:06 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.247.51])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-18314b16f57sm22229118c88.2.2026.10.18.08.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 08:05:05 -0700 (PDT)
Message-Id: <pull.10.v3.cygwin.1792335902.gitgitgadget@gmail.com>
In-Reply-To: <pull.10.v2.cygwin.1792050298.gitgitgadget@gmail.com>
References: <pull.10.v2.cygwin.1792050298.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 18 Oct 2026 15:04:56 +0000
Subject: [PATCH v3 0/6] Cygwin: pty: preserve terminal replies after PTY adoption
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

MSYS Vim launched by native Git from Bash in MinTTY can delete the first
line, enter Insert mode or insert RGB text at startup. The problem is
incorrect PTY adoption, and the same problem applies to the Cygwin runtime
(but is less common because native Windows programs are not mixed with
Cygwin programs as ofte as with MSYS programs).

I merged v1 of this into Git for Windows v2.56.0, as it was somewhat
pressing.

This patch is based on cygwin-3_6-branch, but is easily cherry-picked onto
master, too.

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
