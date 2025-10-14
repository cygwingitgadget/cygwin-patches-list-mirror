Return-Path: <SRS0=Vyke=4X=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by sourceware.org (Postfix) with ESMTPS id 1B20C3858D38
	for <cygwin-patches@cygwin.com>; Tue, 14 Oct 2025 09:16:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1B20C3858D38
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1B20C3858D38
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::42f
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1760433374; cv=none;
	b=CEUBUkiDS9+jKCOYv9Rv594UlbG3EfseFm51KS0PRyQOZMfcPiLlD6Gy5GbLJBfvCB43LrweVSOUP4A+gBddL/FmBJsnrCkQhQfX7mPJjX7OJcSYmgKCaSRzb7wl4JGrwM681SClzUvKw6anqpb0/LSwZ3ZRm4ZhwSfS6d2t1pQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1760433374; c=relaxed/simple;
	bh=iDR0uPu1PukVrQfQUAY3AH9hy2xebkpTk/M1TNfUk3c=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=IPJDuQ3UKw2BSTvtxhLSpFaZAQ1E/Nm50jaAQgCPGVSdDZprUtJIIufbBGZbH3dawfB2LXkzHZt9+YWPeG6VQjAztFeMQEnepDOl10B1UlCvWrYq9kwl1JCh3NJy3pY1D/G9ayhKnmW0oUVIfAMXs8XHnetjz1wpKX8IsdsbsdU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1B20C3858D38
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=lQ3UlnNg
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-78125ed4052so6000077b3a.0
        for <cygwin-patches@cygwin.com>; Tue, 14 Oct 2025 02:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760433373; x=1761038173; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o0jgDEotbhCzBrACYFGFGESe4RQ5aFqra2UsaGIG52c=;
        b=lQ3UlnNgHgp+7tOX5wHMCqW7aatFG24grTBxYzhwU9SbbEyo9fMwOkEIfO2UtNyFv2
         v3UZ2uzmR3khfvYPPEF9bG2JFlQYETAriZH1uZefmhU/IJ1+b6yYrI2Rs2wUD3a4HFCZ
         4XVjly+QTPJnHrTHvho0ZO2Fj4Uw9Vi32Zcpt6HvMDYJgwV58vyHj05AtO429i55R8Pe
         0vlIzPfVb0sXhzVv/NJdfThAcc67ERdGOPk4lKybfwbDWEvlLo5jL6cthdgEY1uB4MLB
         wimGUDHdsPyplcHl7huSJnhN+38i/GjuPb0NSzGMb2MmdYQtr1M/vvW4DUsn6pBlZo7u
         272w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760433373; x=1761038173;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o0jgDEotbhCzBrACYFGFGESe4RQ5aFqra2UsaGIG52c=;
        b=DJKw9LIClACFw4LCBOHg/QV5c4DAkFNETfhaRxlZAZum1OYy+4thRqVFGjpXxnOt8A
         o0Tp3F19EiOmX9NTeoQJ1Stl4zz2WoeE50BJJ5cl1HpiuVI8TG46iBsvlGhw1MQgYmLI
         mc7W1ul1jhT4ZrZ3XMnQ6P0xWWf+L0pJFKb0KApT9yG1wwj8OtLVo2jRjq/bJMIZbkUm
         kdAR1vwxs5aRiPJR6/V2zWS8ylMlSea7/KUocsRMW1WOGhA+V99ze2QySrffjVhlE/4f
         KfNncNva2MVeE2dz2ts5zcJBRsNHwEky6nTsGH4ab5vwRVSPQM9rzNkfyfvZknsXPeXV
         5Lgg==
X-Gm-Message-State: AOJu0YxaIVjx7jpmPgJ39bQRc4YiD+PtINtRe92Zd2Y7VqhFpy9jAMms
	VyRv1uRurY5QGfnUf1q4AP4TaPZA+aPDluExkp8hltJo17xP3Z/nMqEroL/KMw==
X-Gm-Gg: ASbGncvbHzouFJiOLQ/8TvYOFSFDjqOtUwrsW+SLlkK7hJiheIPC2iH/iuu3hR1fMZ7
	rHRieyrjgZ22pzgrleppW96+wJC/Qpi34xRhpvjaOOwp589cw2QNNrydMMZcJCnfugqtlI9/BRi
	zg9VCJtvM10Z4aShQbsEkdTTPCALIkdPdUx0fvtv7Sb++pRGtmLAVOjf8QbzERGJjmvbLeLGDmA
	o+n8zNtfjd6hKU/IvsyXPRRYyvnOS22trS5VRKQf4XtREHiQtHZDmt3aSxCNh/27S5U3VzmHvgn
	+70fmtmVxkxVsEO5zL0/VMJ0F9BJcnBpvVsWwZVwrw8SYIPFoV2AyCjoKu6cnZ5oGVPSZp2c8+T
	phXhKjB1ee315mYBdGjR/ma8c3sCSzoaJyXBdJHfldBFZ
X-Google-Smtp-Source: AGHT+IHazgHfkRxz9box6kRehS0xQ1vqK+7xxxk8bafg+cNIK4GwixDtsGj5jl+QLRTsnfiYLhbYZQ==
X-Received: by 2002:a05:6a00:2e13:b0:781:1771:c12c with SMTP id d2e1a72fcca58-7938269d8b7mr30651421b3a.0.1760433372623;
        Tue, 14 Oct 2025 02:16:12 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.136.163])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e135asm14441380b3a.56.2025.10.14.02.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 02:16:12 -0700 (PDT)
Message-Id: <pull.4.cygwin.1760433371125.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Oct 2025 09:16:11 +0000
Subject: [PATCH] Mention the extremely useful small_printf() function
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It came in real handy while debugging an issue that strace 'fixed'.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Mention the extremely useful small_printf() function
    
    I have been using this function many times for debugging over the years,
    and found that it was too hard to find originally.

Published-As: https://github.com/cygwingitgadget/cygwin/releases/tag/pr-4%2Fdscho%2Fmention-small-printf-v1
Fetch-It-Via: git fetch https://github.com/cygwingitgadget/cygwin pr-4/dscho/mention-small-printf-v1
Pull-Request: https://github.com/cygwingitgadget/cygwin/pull/4

 winsup/cygwin/DevDocs/how-to-debug-cygwin.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/winsup/cygwin/DevDocs/how-to-debug-cygwin.txt b/winsup/cygwin/DevDocs/how-to-debug-cygwin.txt
index 61e91c88d..953d37586 100644
--- a/winsup/cygwin/DevDocs/how-to-debug-cygwin.txt
+++ b/winsup/cygwin/DevDocs/how-to-debug-cygwin.txt
@@ -126,3 +126,9 @@ set CYGWIN_DEBUG=cat.exe:gdb.exe
    program will crash, probably in small_printf.  At that point, a 'bt'
    command should show you the offending call to strace_printf with the
    improper format string.
+
+9. Debug output without strace
+
+   If you cannot use gdb, or if the program behaves differently using strace
+   for whatever reason, you can still use the small_printf() function to
+   output debugging messages directly to stderr.

base-commit: 2ae6825d022ac4450cef168ce066d68810b3a6e2
-- 
cygwingitgadget
