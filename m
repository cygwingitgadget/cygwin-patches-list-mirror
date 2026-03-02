Return-Path: <SRS0=T3ZE=BC=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-dy1-x132d.google.com (mail-dy1-x132d.google.com [IPv6:2607:f8b0:4864:20::132d])
	by sourceware.org (Postfix) with ESMTPS id E52604BA23FA
	for <cygwin-patches@cygwin.com>; Mon,  2 Mar 2026 14:24:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E52604BA23FA
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E52604BA23FA
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::132d
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772461491; cv=none;
	b=RDQXi6Gr/FKlhV7Dck/bc7KrfDEATY3Fjl5CnbCwhPLDDG1AHu222lKfbGA2pnO6t276gzoMde8TcRvbVcdvTEQ8fTeKMzg9yLgU4vIAmcTMQwnn1xpZrbEcvgfsz2SvDqzjRMaX2N9KpvqwnrOuPJpjEh7/y86OCYQpFIo2w5Y=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772461491; c=relaxed/simple;
	bh=LdCtMD4eMZN3YOGsaXQaRcll8XlC4suNWm0wHWuBZtg=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=mqc+E35rvsc9ZNQHVDjbm0eM8dyXspUBw2wQkOoYb9HGvxvjX/IKqVsMPKvgKzFN6a3ehetfAUXACG0N4VwmF32H4lyxUu/gQ7R54m+gX2l9vyCY8NL8dIs95V2kFuSf8UZ/vS2Gv1ilmpdIlzMzBWVNUEAlQN0OH1uHMNNrE8c=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E52604BA23FA
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bm4izk/J
Received: by mail-dy1-x132d.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso4183638eec.1
        for <cygwin-patches@cygwin.com>; Mon, 02 Mar 2026 06:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772461489; x=1773066289; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqoFCRFbephcexRHcpDemr525Ea70yB4WtMt/EafHsE=;
        b=bm4izk/J1o7kxFyZMFgusj0y9VXgYVhf4J8iHdUxuIDOk+p7r/zitHR4v74U7KQMmG
         9IWaoO9Tyi0Cw+hinxY8x2aQrGbJI9ikWgI/mkFnEiUwk5a7bvMvC4/waOSNSA3mP3+0
         +GuJvd0X56JCknEVToFB+krrimLPUoCfJPkud8eOYSzH2xC8bGvC0mFgT+Q9oosbB7s+
         G7yby0ONSDcA7rZ4QrAXqYah8G97r9DSjXOtorP9y3aAPakupFOPc503HOXMnjmlS5IV
         2NDX0SNZQQXyThLWrIep0t+1jo1qUPlXhW5dfhInWK+u+kMy9rzqlVfvoeSe+FjLcEW8
         TSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772461489; x=1773066289;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kqoFCRFbephcexRHcpDemr525Ea70yB4WtMt/EafHsE=;
        b=Sva3j+NB3ZAnDqa6eG+KJbGEGVPyYrxsYf3YmoYzU2lt5NF0kOu7kNaUL8nV9eHH8X
         OWh8/KC/rMigPT5CPmUidv1Z53K0NyXi7Vyx93BK9tl7kgg6/G6YgzBeUr+V1K/pCLVM
         ld0+RDKa+HivSI2/1QXpJqYLtg/Hyp0mKFcnooV9pfV6Xx+WwPvvdzqkDgSzwenxltV3
         /QCtl62OiYIn+zU4GsoeZBLZufvupKsPj2yS4csHZSiwXnPdLABwEoh8a1yurXX1HGbB
         bnhQbZAMNL8npVLAmFTN2aFLJRttV1QZ3YYrtAXLbrYFP19TzQGpJxKK+eUbhr9aPxMZ
         H1vQ==
X-Gm-Message-State: AOJu0YxMwa8qhwBqACGY4H3q7fSSqLrAtCRnCPPHiRsVef8cT/pZEWEj
	RI0Hn6DS3O8aH3cmYuimPfw2WvsNa9SboUJfo9diKCPswwgDP86H5ftyUGxkXg==
X-Gm-Gg: ATEYQzzw+su3Evr91OQkVR0EA20H6+u9DBmckc2Thmy5OaRisY8hi4Q9OwlROQPTQAy
	s6/2cPcWrwAo+XLtsL6J//sRh7u+fXTFbyWzVmAYf31Rv2MofEcHojBjo7pf36FD91+2rxstcO0
	KjrAHw+7e60S10owT/wLNe6ki/Ci4W5vKyEs/4xNA9CZPOFVXygK8J7c5Ru3Ks53dGyGlVTctlV
	jQem3tzzZ9F3CCQ5p5al7QOPdsNIXJhbfpscxaa1FoOb+XCcoUjUoln3+h0ruSyLzMKoh+4HOzv
	xOPMS+AbAc5pTMfOp2N84X9JmgNx/KOlfcCcmCyTEehO9yxBhqdp6aVh3BYfsiwydLfUp0LLBd/
	YImicW+P0bT0xXZvCBQ9erhSFZLCWaB/KWdwe+ozE5FUPBvESRQJ8fPRX6tWRhZA3DnhflgeiJ5
	Ig0LveJ6LJk8Wsgo/6zcevNPmxQw==
X-Received: by 2002:a05:7300:7313:b0:2be:ca4:e145 with SMTP id 5a478bee46e88-2be0ca4f264mr1754964eec.21.1772461489330;
        Mon, 02 Mar 2026 06:24:49 -0800 (PST)
Received: from [127.0.0.1] ([52.159.245.148])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bded67cce6sm7967830eec.6.2026.03.02.06.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 06:24:48 -0800 (PST)
Message-Id: <eba6e857a65bfab4e51a37b88d84829d8e65d5c7.1772461480.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.6.cygwin.1772461480.gitgitgadget@gmail.com>
References: <pull.6.cygwin.1772461480.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Mar 2026 14:24:40 +0000
Subject: [PATCH 4/4] Cygwin: pty: Guard accept_input routing and flush stale
 readahead in fast path
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This final commit in the series addresses two remaining edge cases
where characters can escape through unintended routing during pseudo
console oscillation.

Part 1: accept_input() routing guard
-------------------------------------

accept_input() writes data from the readahead buffer to one of the
two PTY input pipes.  Its routing condition was:

  if (to_be_read_from_nat_pipe()
      && pty_input_state == to_nat)
    write_to = to_slave_nat;   /* nat pipe */
  else
    write_to = to_slave;       /* cyg pipe */

A comment in the code documents the intention: "This code is reached
if non-cygwin app is foreground and pseudo console is NOT enabled."

But the condition does not actually check pcon_activated.  During
pseudo console oscillation, accept_input() can route data to the
nat pipe even while the pseudo console IS active.  When pcon is
active, input for native processes flows through conhost.exe, not
through direct pipe writes.  Routing data to the nat pipe via
accept_input() during pcon activation either duplicates what
conhost already delivers or displaces data that should have stayed
in the cyg pipe.

Add `&& !pcon_activated` to make the code match its own documented
invariant.

Part 2: readahead flush in the pcon+nat fast code path
------------------------------------------------------

The pcon+nat fast code path in master::write() handles the common
case where a native app is in the foreground with pcon active.  It
writes keystrokes directly to the nat pipe via WriteFile(), bypassing
line_edit() entirely.

If a previous call to master::write() went through line_edit()
(because pcon was momentarily inactive during oscillation),
line_edit() may have left data in the readahead buffer via
unget_readahead().  Without flushing this stale readahead, it
persists until the next line_edit() call, at which point
accept_input() emits it -- potentially after newer characters that
went through the fast code path, breaking chronological order.

Add an accept_input() call at the top of the pcon+nat fast code path
to flush any stale readahead before the current keystroke is written
via WriteFile().

Together with the three preceding commits, this eliminates the
character reordering reported in git-for-windows/git#5632.

Addresses: https://github.com/git-for-windows/git/issues/5632
Fixes: 3d46583d4fa8 ("Cygwin: pty: Update some comments in pty code.")
Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 winsup/cygwin/fhandler/pty.cc | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index dd7ea9038..fcff53d88 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -489,6 +489,7 @@ fhandler_pty_master::accept_input ()
   HANDLE write_to = get_output_handle ();
   tmp_pathbuf tp;
   if (to_be_read_from_nat_pipe ()
+      && !get_ttyp ()->pcon_activated
       && get_ttyp ()->pty_input_state == tty::to_nat)
     {
       /* This code is reached if non-cygwin app is foreground and
@@ -2208,8 +2209,18 @@ fhandler_pty_master::write (const void *ptr, size_t len)
   WaitForSingleObject (input_mutex, mutex_timeout);
   if (to_be_read_from_nat_pipe () && get_ttyp ()->pcon_activated
       && get_ttyp ()->pty_input_state == tty::to_nat)
-    { /* Reaches here when non-cygwin app is foreground and pseudo console
-	 is activated. */
+    {
+      /* Flush any stale readahead data from a prior line_edit call that
+	 ran while pty_input_state was temporarily to_cyg (e.g. during a
+	 setpgid_aux transition when a cygwin child of the native process
+	 started or exited).  Without this, the readahead contents would
+	 be stranded and emitted after the direct WriteFile below,
+	 breaking chronological order. */
+      if (get_readahead_valid ())
+	{
+	  accept_input ();
+	}
+
       tmp_pathbuf tp;
       char *buf = (char *) ptr;
       size_t nlen = len;
-- 
cygwingitgadget
