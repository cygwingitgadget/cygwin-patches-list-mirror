Return-Path: <SRS0=T3ZE=BC=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com [IPv6:2607:f8b0:4864:20::1336])
	by sourceware.org (Postfix) with ESMTPS id 6DB8E4BA2E0A
	for <cygwin-patches@cygwin.com>; Mon,  2 Mar 2026 14:24:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6DB8E4BA2E0A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6DB8E4BA2E0A
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::1336
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772461484; cv=none;
	b=aUV1R7GvchcHP+5Mk15RPD3HmD6NJlUdxAeytUFFisUQ3CW9BNUrekKFlTDlYKcK1BV99dUAzIK8MI+rWuWLbnpKnY7KQplObAkVsURg99f1R23spphcKhIv//kX0CLEZR+p4kwC4IQ1bGGTEEZ1rCpMCaXfmvU1C5XVhrC4GpI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772461484; c=relaxed/simple;
	bh=ZFYKXQeF1k5fUjKIUa8MNn2qaOFng65U6FJ09Nex4V8=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=q5GDo8NyS0aEY9QIdVJbVa66KtpMfruaIQsBVa0/fXSxSK92bKC+Utw/2jenjxvbRbbIy6uHi0Baqrz7J2iLS4Sf22cSERDmEyX3G4OjVR6nWtyee/qV2in/lGg1CHHZO3lazH8l+53hTY9KS8Kf+m+353Alugs3eU9Hy037Fck=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6DB8E4BA2E0A
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dNOWlZnO
Received: by mail-dy1-x1336.google.com with SMTP id 5a478bee46e88-2be06c02f66so2886707eec.1
        for <cygwin-patches@cygwin.com>; Mon, 02 Mar 2026 06:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772461483; x=1773066283; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Acp0kjUeLznmMeUc8uSZAtoEcmbxajqs/ygtTV2Ea+E=;
        b=dNOWlZnO5+SmQ6JePQrLppL1h+uY2EBN94xzzP34BCCf4gkoU38NovpYgTkIznLC4j
         6DjgmydoKtJMStK3FI2WHO4Tx1yCeIrzuT+uZyKH9nshL5uY4c0TZ7mX0QHGLMf2uc6i
         sVIeCyrzdXEfhzdcX5stg93s6Gl8KzmhbLdZqvk05CqlMxcreIaYSyLazA3nw4RW3R6t
         SOiUjlT/g7BIMSZyzJvqjStyfllaBdEciJgIh/OkF0dS3BvyHZ5sdoxFmXK8q8szEygZ
         qik62em5LWTc44gH/yIBJ0TbEVJdrjdUllbp4RmMqxA6qITfwmjieXGsIIU7iEdKTPkS
         sozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772461483; x=1773066283;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Acp0kjUeLznmMeUc8uSZAtoEcmbxajqs/ygtTV2Ea+E=;
        b=dbeJFZF/Q4XRZa1S87NBGU8dvpL8Wt8kyS9ta9MfoJ/PGiZvR+gw4qWbcM+P4gvWnU
         4EREzikXZYeBD/6Cdm3N6Dh7IdtgPn2LUHGxWw1BjO2+sE+MCuukuWtTeQTi18aI4rF7
         9u/xieKGwunBA/l7FacS9dZpRW8TVmx3UxFs7wkrAEp0Bwb+ZzbORpDNB3MwLvndBGKT
         PucfucIqlNnU7Sm+3gvZPn1orSa1J46r0WsKtWXkAZrZ7CUXnP8NNilKwkYoYu/o+Zgg
         0YpvejnpFvpesQcDvowTGqAM8Lw5E9mRkqsKJMrHJ72ylWWtKjLCHuBtupenIpY8Rqdg
         7NNg==
X-Gm-Message-State: AOJu0YwwelHPFv07efP2xMjXWA6uiG8vKNydrnKIOYpTPd1ZKdP08BQW
	ENmqziNhtyL48yS1YhEaBVQwvXv2T240yL7QZrINdNRon3lD//RhxQuRV08gkg==
X-Gm-Gg: ATEYQzydG7KMo4iTh2x1tSzS1T/OPOC69PSpZht4KWscUV31MG4Wwq1GxBzcPzo4GC8
	pa4MzmSjP2tqYcNjRTOKTM9ZYYuJJH2MqhuLY924jVF69SrjH8LEsFEvKdHWNStaEKl6ZMDUI7S
	jVwIfthvrF7FPCZ1HkOIEqrH1Ez3eS7uYOkjbhetMMBj1vur97SWnCLcafvU8+cpMsmnekFCmca
	B7Jxcs4uCgB2yL9eWdgdKXyLmC0p1QjgUZMwgWXzy8kHqlF4Ui6aKAlx3Ppgft0GOIMKBirqCfL
	OAHPOpEw0dNC0KhcruYaYpjgk0/C4Fd0X+j7dnDdpMoHbdSj3+tCn12UneD/ck7tkvji1+TU8ea
	hvhYSVnv522gtIC1xwRADaqTXER9K4Maa+lzRPepWvQsyQjtAvNkmC+GJ4GdCPeAbsdjd03OH+l
	gzINFBtwn0l5TSPGv5C09IsE/hBQ==
X-Received: by 2002:a05:7300:72d0:b0:2b9:dde1:33e0 with SMTP id 5a478bee46e88-2bde1c0f805mr5274135eec.2.1772461482638;
        Mon, 02 Mar 2026 06:24:42 -0800 (PST)
Received: from [127.0.0.1] ([52.159.245.148])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdfa2684fesm5553349eec.23.2026.03.02.06.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 06:24:41 -0800 (PST)
Message-Id: <pull.6.cygwin.1772461480.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Mar 2026 14:24:36 +0000
Subject: [PATCH 0/4] Fix out-of-order keystrokes
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

A Git for Windows user reported that typing in a Bash session while a native
Windows program is running (or has just exited) can produce scrambled input
-- e.g. typing "git log" yields "igt olg":
https://github.com/git-for-windows/git/issues/5632

I have been experiencing what I suspect is the same bug for a long time in
my tmux sessions: after quitting a pager and immediately pressing cursor-up
to recall the previous command, often followed by Escape+Backspace, the Bash
session simply hangs. I suspect that the escape sequence bytes arrive out of
order, and hence the sequence does not parse, and the terminal hangs. Quite
frustrating, and it happens often enough to be a real productivity drain.

This bug report was therefore always on my mind, and gaining some good
experience with AI-assisted coding at work finally gave me the push to
investigate properly. I started by writing an AutoHotKey-based UI test (Git
for Windows has a small suite of those; they are not included in this series
because they are specific to our fork). Getting a reliable reproducer
required quite a bit of back-and-forth as the bug is timing-sensitive and
only manifests when pseudo console transitions happen while keystrokes are
in flight.

The investigation itself was substantial. The total session spread over a
week. To be transparent about the methodology: I used AI (Claude Opus) as an
investigative tool throughout this process. I dictated context and direction
via speech recognition, the AI searched the code, instrumented the code
liberally, and dug into the PTY internals. Every decision about what to
investigate, what to fix and how was mine, the AI merely executed my plans.
I typed very little (leaving typing to Parakeet's speech recognition and to
Claude Opus); the keystrokes are not mine, but the ideas are. For that
reason I use "Assisted-by" rather than "Co-authored-by" trailers in the
commits.

The root cause is what Opus labeled "pseudo console oscillation" (I called
it "flickering" but agree that "oscillation" is a better term): each time a
native program starts or exits, pcon_activated and pty_input_state change
rapidly, and several code paths in master::write() react by calling
transfer_input() to move data between the cyg and nat pipes. During
oscillation, these transfers steal readline's buffered data from the cyg
pipe, causing characters to arrive out of order.

My suspicion is that the originally reported bug is fixed entirely by the
first patch (1/4). The remaining three address edge cases that the
reproducer exposed through its more aggressive oscillation pattern. You
might say that I over-deliver a bit, but that seems like a good thing in
this instance.

I tested both with and without MSYS=disable_pcon to verify that the
scenarios the removed code was originally intended to handle are still
covered by setpgid_aux(). This is even automated in Git for Windows' fork
via the AutoHotKey-based tests; for full details see
https://github.com/git-for-windows/msys2-runtime/pull/124.

Johannes Schindelin (4):
  Cygwin: pty: Fix jumbled keystrokes by removing the per-keystroke pipe
    transfer
  Cygwin: pty: Remove pcon_start readahead flush that displaces readline
    data
  Cygwin: pty: Prevent premature pseudo console teardown that amplifies
    oscillation
  Cygwin: pty: Guard accept_input routing and flush stale readahead in
    fast path

 winsup/cygwin/fhandler/pty.cc | 62 ++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 33 deletions(-)


base-commit: f04527cea30b0bb9634f96883cc71571bd3e524b
Published-As: https://github.com/cygwingitgadget/cygwin/releases/tag/pr-6%2Fdscho%2Ffix-out-of-order-keystrokes-v1
Fetch-It-Via: git fetch https://github.com/cygwingitgadget/cygwin pr-6/dscho/fix-out-of-order-keystrokes-v1
Pull-Request: https://github.com/cygwingitgadget/cygwin/pull/6
-- 
cygwingitgadget
