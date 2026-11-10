Return-Path: <SRS0=iCST=I7=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
	by sourceware.org (Postfix) with ESMTPS id CD9B34BA2E0A
	for <cygwin-patches@cygwin.com>; Tue, 10 Nov 2026 09:55:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CD9B34BA2E0A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CD9B34BA2E0A
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::32b
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1794304549; cv=none;
	b=oMdNe/NG0DMz9DcsrxYfWW3i7pA2HsTm9TVnQN6NEOJX4vi5pG2U5ILdztOxpeJG6XIEjMA0pKszuw3G6adTs1NiODUxZUpSFXLb+pYi6VhNaYD/bwMjZuAAeRtKU4xv0XGijU6di153sFB8TaRJivP+D0SVmJdc0iI7RiPSQws=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1794304549; c=relaxed/simple;
	bh=QafWaRKVdj0BSSJV/XdkVFEdOQj5ZYcq1+V7Axh5YyU=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=uqn7parCQDr2E8pW3eejGqXmnIl52w8jmA1FW/AiJa2hXie1XkzBsGcKD9lyW6JHc9GAMXlH1zO6TItpXEYO9ESkHm/aDrfMkpfYh0+/KMOEZuTDqcGz+qwDRx0MRPu/fciSH6wK02X0rxnQaYzftS8j3ljObr4XKmUEtRHQ++A=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OHPK2Xzc
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CD9B34BA2E0A
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OHPK2Xzc
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-8253bc5a613so1021581a34.0
        for <cygwin-patches@cygwin.com>; Tue, 10 Nov 2026 01:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794304549; x=1794909349; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yb2HFo/3allm79IFP9U0kAYcUi/2sE0xpSuhwi4i8UA=;
        b=OHPK2Xzc0spofr7Cu9hEAMfhLZItYazOUD618XmlvEO3xUpoXNsmam3IQ4h0IILBiI
         QDJetXSh9ZRG+wnxk5lYyreb1CI4NpmbqUXdUTOprIyap1EZPMwf1nMsSHFOiaSCgETy
         xgFuOrHXGs2kV9UysHHhm1rmySVkAEOnW+SncB/U7rxvaeckUJTPhosiFdYYgY16zPzY
         2XLuJ6vT8X8rbA0Kq6OdDsxZelnsaZAq4VDUFDBBD8ju37G6CvFwhN1lDtEulqfrh4Cw
         ukt3u1nqRJ2Xfr9IemunMQnko7tNWM+QfyrpKMitlThAcN9FTbfrolSytHZtpU9qIJfO
         1BFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794304549; x=1794909349;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yb2HFo/3allm79IFP9U0kAYcUi/2sE0xpSuhwi4i8UA=;
        b=K3+6ScLDrvKf754S5/Eyvjsvm3xxRnuJoyoKpz8crF90j4UecpIPEt2ljujy7uu2d4
         tHarZgWOj7NPi0ET1vnl5QjLqcX0tW3DBYo3SLbvjv4pwm6un2BF2oApxaqmKN8oJAFz
         //75eQZVUJ1KwyAtH1F+qFypnSVkmjQCCKLwngC6+8+Y5ZndINfndMgGvP+QfR3quo4p
         R+6FPYq1dYvnXak5XiaVRdf6pZTLVA0Sqxy8Y5OundEFutL40y/8/9KSenWBssuMmoJt
         3SkjJ8y+F+Ih0lvnbyPbVcBjA1Yq5S8AamydLI8YuzMsL0WcIHbpNwxqQRtSKmdXlC7G
         wF3g==
X-Gm-Message-State: APuU4Z+0CiHODTL2f0JX9rDKYpovN/WaBpBi53Y8/Aze/fc//APLoz+n
	9Sp2tuoyFgdyHs+9KvX3CTeCoK6/ubkhcnLNiR6geI22+StkcfCVvrIno5RJBR9l
X-Gm-Gg: AYBFou3SuQ9rHaB+kfm4luR0apu2j+waNKbviZ0cHhRxGJEW3Sjpv2vMZk2XQiZzmQk
	lbJwqEuhDJRjbVsc2/Hq7WcnAFBXxU4OH5PjerN1PGND8KaSov3L+ZITPEw/Mz+pfGiF88s4uq7
	K10Obbt3ZCBY/ElIOsdTOKYc6PQTbuVZz1vB1M2/c+EqQUebXC5TUvlCt6osaobUQWkXrIXkrrH
	kYaVwJHnXQ1R02xn3GNQqNqfibxSbKZT3AR3/stDca7CqArSL2N2JqbI+cjHmsrvPzRBS4jQONj
	d303mzAFjTqFFsFPGJE95hvovCBsuH8VZSbg4JIsW3qdoIH3tnttFzkJUbe+hDCVlrGDi53cDrR
	/FHcj3XqmJEaMLWBX2OBnXyOaltlyMdKO74X8WfcUEGuRSQNThKroXZko+fOrlbPJhCvSDDoERH
	urC15ZbENv+PHO8qOFvtJTAWwCmWFfhUEaq6f3cjMI+pxfnsvc/XG35allhH2p4QgXc98alUkQK
	ivkYe/1W8pBxKXKgUPM2lq4rgLyVkf9M5/pakOvqZV2zI/858GTgR6eROf2gVjYoQ+4P3Go2vLW
	0TqVW96Sza/66WMG30YzlV8VhOnxKlU=
X-Received: by 2002:a05:6830:4128:b0:81a:9522:f007 with SMTP id 46e09a7af769-860dc7005c1mr1238928a34.5.1794304549099;
        Tue, 10 Nov 2026 01:55:49 -0800 (PST)
Received: from [127.0.0.1] ([20.80.79.197])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dcbfa976sm1588052a34.21.2026.11.10.01.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 01:55:47 -0800 (PST)
Message-Id: <pull.17.cygwin.1794304546251.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 09:55:46 +0000
Subject: [PATCH] Cygwin: make command-line quote removal overlap-safe
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>,
    Aswin Kalies Ramkumar Mangayarkarasi <aswin.kalies@multicorewareinc.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When calling `C:\cygwin\bin\bash.exe --login`, PowerShell quotes the
executable name in the Windows command line. The `build_argv()` function
needs to remove these quotes, shifting the remaining command-line in
place. Using the `strcpy()` function for this task violates its
non-overlap requirement and can corrupt both `argv[0]` and subsequent
arguments before the application sees them.

The x86_64 variant of the Cygwin runtime happens to mask this: its
generic `strcpy()` uses a forward byte-copy path for pointers one byte
apart.

The AArch64 SIMD implementation, however, can reread source bytes
already overwritten by the shift. The exact symptoms depend on copy
length and alignment. For example, running the command
`C:\cygwin\bin\bash.exe -l` happens to work, but using `--login` instead
of `-l` produces this strange error:

  /usr/bin/bah: --loginn: invalid option

as reported in
https://inbox.sourceware.org/cygwin-developers/4839a90e-6d47-4c8f-bddc-ecb948351b31@dronecode.org.uk/

Let's fix this by using `memmove()` instead, whose contract explicitly
allows for overlapping memory ranges to be specified.

Note: The third parameter of `memmove()` specifies the number of bytes,
which must include the trailing NUL byte. While it would be "more
correct" to write `strlen(p + 1) + 1` instead of `strlen(p)`, their
result is identical, and we opt for the simpler code here.

Assisted-by: GPT-6.1 Sol
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Cygwin: make command-line quote removal overlap-safe

Published-As: https://github.com/cygwingitgadget/cygwin/releases/tag/pr-17%2Fdscho%2Ffix-native-argv-quotes-v1
Fetch-It-Via: git fetch https://github.com/cygwingitgadget/cygwin pr-17/dscho/fix-native-argv-quotes-v1
Pull-Request: https://github.com/cygwingitgadget/cygwin/pull/17

 winsup/cygwin/dcrt0.cc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
index 7fe8f26ac..1c5e4cce8 100644
--- a/winsup/cygwin/dcrt0.cc
+++ b/winsup/cygwin/dcrt0.cc
@@ -162,9 +162,9 @@ quoted (char *cmd, int winshell)
   if (!winshell)
     {
       char *p;
-      strcpy (cmd, cmd + 1);
+      memmove (cmd, cmd + 1, strlen (cmd));
       if (*(p = strchrnul (cmd, quote)))
-	strcpy (p, p + 1);
+	memmove (p, p + 1, strlen (p));
       return p;
     }
 

base-commit: c8a9e47202a184d1a6c66ef6d01e9f5d345e9ebb
-- 
cygwingitgadget
