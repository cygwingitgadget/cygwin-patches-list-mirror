Return-Path: <SRS0=ISKq=II=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com [IPv6:2607:f8b0:4864:20::1329])
	by sourceware.org (Postfix) with ESMTPS id 9B27C4BA23C0
	for <cygwin-patches@cygwin.com>; Sun, 18 Oct 2026 15:07:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9B27C4BA23C0
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9B27C4BA23C0
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::1329
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792336074; cv=none;
	b=QchNVD3YFyoLivQ3sU6+rl82qB2x6r/bxRT0KSNwUDpWKuJg47tHfewP3TEMf4l+E1qVopezwfqTbiebvyHkdfwYf7CS4ZYQz/6okReFTm1/gzVfrflFgtnaah9M5V5ewt+T13ye8Yiw7jLOzH2ogEMquzd4UoLHRlLxp8NX8gI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792336074; c=relaxed/simple;
	bh=7M6fj67VGiKfGxw/t/Mbt7jGRQ2dpgSzuDvQJ5pGrSk=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=xfIYWX1C2XrxCLl/Iirx8YB4wQa7k6x8UlxcFF0ZcedOyXjoXqGC8vWs7AJ9UtsmA+g6t/0+7beVcRLUDoFzw1JYzTRERt0rqWKNdLKPnfDU/Z80Wtnu79/nz47qFvy3wwXwLmi0j1pJkZPLNvgkv/Wf0jzX8Yo+h4syjnl7gSE=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HK00wOhG
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9B27C4BA23C0
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HK00wOhG
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-35ef6b49813so2564632eec.0
        for <cygwin-patches@cygwin.com>; Sun, 18 Oct 2026 08:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792336074; x=1792940874; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0AnJAMfbXPgy4loD6RnEoHclG07TrU/Eo4D/xiT3tt4=;
        b=HK00wOhGwTduyyTyxVhbAujtpAI06fseYkJTSCZcABiLjCg7GwohKwDOkzKAESSpy/
         LXZMUZ29hVKUlHtUo4OPhtUuhYySftb74HX/OMXRe3HZMSTeWprf7T4rPklzWtXgqL6L
         dBoN4iEc4mtRI8OMeOaUwKRn4ac6CvzNJTDs+lZQ+cw40lUu19FGXPJSgIyKxE6VK2Db
         vHDJ5jHkMxIyo7hOn0U6Vw5oUXPz0yqlWoyk0059RyOw19E6E6b1ItvaA0/20KnymlAL
         Hp32IB19DKTJAxgBJi68KUCEu+VmuFkbFL8bkma3tJT2ttUPPco8p5NdVp4CdRKyRGPv
         WpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792336074; x=1792940874;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0AnJAMfbXPgy4loD6RnEoHclG07TrU/Eo4D/xiT3tt4=;
        b=s8N62CWPg18argPbDGjHMoeMbZtqGiHSI2EnBTnj93mRmoiVBNkPNT4dXMc58o6pXt
         xwrgSnPI8pnS4U87V+IaazvMcUS38GPSMui1p4lzrZzw7kCDgfUFe4bMtKX7iuj4clQh
         fv9hw9J8Qzy0kJTCP6KLxOSVHer7UFgGCNeEOhPPtVIQPQV5ZA7SEk/1t5KDeglCkztc
         v2BvCdcgF6IVEehsst25Ax2Kl7Pxw2O/EmhrWiesRcjvJnV+UQ4DLs7G3tps1aOLCDww
         y3OnSVwgjdbUzFxsrT0ihkbON2dl5PzDymfqMd/hueiL4deOmgNs86OaiTFnG1hDTirY
         3tKA==
X-Gm-Message-State: AFq9FYKtaQl9rPRWzBfq7Bv908LjH8YmYnFUALvGOXW4EhPfsQ+D7ZZ6
	xH/FZBviaiLwIRyA5TBT8L06wOm3Gc12MHm9WNk/5gfBWg6kovSTghvjny2lmX32
X-Gm-Gg: AYBFou2RGgQyLYQ/4jrtOhgjjshvzVX9V0eqrE/p/fB9S5nHedT4iEZJIgek+VDStqA
	yMybuHInfv7+1U/SjRW9EkE2PHtwdJMr+2S7CP53nBIbS6esMNJlNjgcfukqs09xw3tXo9yPqiL
	EEsdjmRvoanzdraNMaoQiTQBKuRSVNSOzYiAwgFqhD/XeM6kSVC0e1bXhaVM9CBJbqj0PDk7yyQ
	zn6DP5I9Y6c9k+nxiF/6PkpjoN7/RnxxZ9MtcI7o5gfVudxAv6gYyNW3lQqwS9bSu/9oultQSCR
	iBMYHeUh99Tja2+wa9F+dVzOxZ38J3lL1hojJBaZlzNj+9hpkOW8Fz6A/pbHtiB0NweDnwMdSB5
	BURTF8ke2i8G5iJgFqFTvS25hMD1qriXtU6LZ+prb6lwBx4/DMLWEVY+1B5HFK1qH7BB4+R6cuW
	mQdZDBbuPLnFmnJRC9P4tvj2KccgMHc8iFD9GX9WQZDjphu41SsIxJdnuWNJXDFz6zXRgXnZrKc
	t5uQ9pk9ViF
X-Received: by 2002:a05:7301:430c:b0:358:8f02:e0ca with SMTP id 5a478bee46e88-361a1668b25mr7218197eec.9.1792336073606;
        Sun, 18 Oct 2026 08:07:53 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.203.60])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36081bafa7asm24204913eec.14.2026.10.18.08.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 08:07:53 -0700 (PDT)
Message-Id: <2b13ec62fc5b7ae4c3c9ede767c315f883ab3265.1792336066.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.10.v3.cygwin.1792336066.gitgitgadget@gmail.com>
References: <pull.10.v2.cygwin.1792050298.gitgitgadget@gmail.com>
	<pull.10.v3.cygwin.1792336066.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 18 Oct 2026 15:07:44 +0000
Subject: [PATCH v3 4/6] Cygwin: pty: recover input for children of native
 programs
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

A native Windows program can start a Cygwin child while PTY input is
still routed to the native console. The `exec()` handover does not
cover this case, yet a `vim.exe` started this way can enter raw mode
and query the terminal before its first read.

Therefore, let's recover input during the child's initialization too,
once the reopened stdin handle has been published. At that moment,
the handover can recognize it as standard input. Doing this in `init()`
is too early. If `stdin` and `stdout` share a PTY, initializing `stdout`
later can perform the handover `stdin` missed.

Note that we must be careful not to break the `disable_pcon` mode with
this new logic.

Addresses: https://github.com/git-for-windows/git/issues/6403
Suggested-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Assisted-by: GPT-6.1
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 winsup/cygwin/fhandler/pty.cc           | 7 +++++++
 winsup/cygwin/local_includes/fhandler.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index e05d7ba5b..7c78ac6d9 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -1078,6 +1078,13 @@ fhandler_pty_slave::init (HANDLE h, DWORD a, mode_t, int64_t dummy)
   return ret;
 }
 
+void
+fhandler_pty_slave::post_open_setup (int fd)
+{
+  if (fd == 0 && get_ttyp ()->pcon_activated)
+    fixup_input_state_for_cygwin_app ();
+}
+
 void
 fhandler_pty_slave::set_switch_to_nat_pipe (void)
 {
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index b69a358f6..b7341f277 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2473,6 +2473,7 @@ class fhandler_pty_slave: public fhandler_pty_common
 
   int open (int flags, mode_t mode = 0);
   bool open_setup (int flags);
+  void post_open_setup (int fd);
   ssize_t write (const void *ptr, size_t len);
   void read (void *ptr, size_t& len);
   int init (HANDLE, DWORD, mode_t, int64_t = 0);
-- 
cygwingitgadget

