Return-Path: <SRS0=koVj=IF=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
	by sourceware.org (Postfix) with ESMTPS id 937174BA2E15
	for <cygwin-patches@cygwin.com>; Thu, 15 Oct 2026 07:45:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 937174BA2E15
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 937174BA2E15
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::334
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792050302; cv=none;
	b=SUdZuNx74JK6GJnbty1uLZ6KyRWBKEO+drJv/vXU6v7f5wR/1DK1YeJMigv7Xu3tzvzD0+pyqMDzhQWXBC0uaXLtEc76M4TUAWqdN0smXo5dUBdkfNHNwFgDDO6wGocOttS8E5Nn6Z/vDrqt2LncxrPN+R3h83bZuiUEBnqwOpo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792050302; c=relaxed/simple;
	bh=tO7zs57VKZyDuWQrRTSCOXC5M4NYVPKSXgLI1gTb+2s=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=oR9qlBj75EXRzgkcLXU9d+njPbzCFZPOnmDpYTe8bsPuLtScxEqtu0aB4moqUon3b52cl1id1qJMAaxkXKcJ/QIPB4/tm8F5p5Nq+gA2V8yTWET2h5nNulpwv+43wlQPgyYM256+ePmT/7ZRH7jSjW7T+dbXwGSNHrhTYmPZfHA=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s4Lasmak
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 937174BA2E15
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s4Lasmak
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-8241a56cd70so3240590a34.3
        for <cygwin-patches@cygwin.com>; Thu, 15 Oct 2026 00:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792050302; x=1792655102; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=r9RUthPQTsruu5ph1+9HEJh7P0zAGAo2zGlcl5HxgLs=;
        b=s4LasmakfAhzsrQTq0EL0p/i7hBtG8OoAifh4pNrDhgGDptGEOKAnRyd6W4DGHBity
         s8D5HnW61OwYxb7tpKExtVbGIE1gznbsXpUUEYTm/UMY4cSK375tdlXkSZAuWi+9UdVz
         +U+8tP5dyzUYoUf+YsfOkVcatdnyNnoTgjHnETKmdOuHVgFd7vx8njNUyZbZNpS+uvSG
         ca0wfmXRBNeblFQQyQH7RI2SV0Xw8yFYA5nH07jGxVsrfN4+NEjZdfL4JHafsAOAj79e
         a4x+/REk8WUrUVANNmmlNIyT9YxYgYIReHgEyq6cjtHSlEo6A3l/e54jYKixvkUWMA8N
         RuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792050302; x=1792655102;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r9RUthPQTsruu5ph1+9HEJh7P0zAGAo2zGlcl5HxgLs=;
        b=kOpr+B70Tm3zzZgl5nAP+V/YV3eIdUmVVkLCXRDcXks/ciDIFDJRS1swE8mlvV2TTJ
         eOJtv3fDU7JNCsNPFZV9+zrIE0IsEHKixv5IUB/hrALuKPYAGFXruRqvWkPQtIg7X6Ga
         9i4nMiSb+MhlUdbhhPXA59+mhaBNkhyKmyVdPTWJQj3rk0FFP+7VdKyfISrP9ovtAkik
         MG83fKUF8UnFiVsXHztduS4cWRqLBGh/+7n5TgfEwOU+yR+KA1GwlINvN1euZHXDOPDf
         xAs+mprlS4zHW7uIu9oEtKxOvjUirNbaWmQZRA4vTT/sh9mvyKOt6oov8yFzdLeDY4t/
         h4ig==
X-Gm-Message-State: AFq9FYKeFoxKDthm7KQmsssmqU01CZpa5ostMOf/IXM3LAEU20BFU+8j
	ayqqUPSy3UDZfFVRx7nHR1VbJr3mojdkJNTBDmN6kT/MDhvAznZebnIE9OvXFac4PBg=
X-Gm-Gg: AYBFou0UwCL0vIDbQeirEkjouS1pJowLzxn+mJnypa4gtF3hIufLFJG6cRZP8eWNAMj
	YiG2E0TWSFM638pyEsdqeROACZuJsW24oL12G125kXahP12KBRp+f49m3kzdvS38YCjCbCGBW+U
	D6dXXKcNKFJoyM3a3G1oLAlwTKn/Tbft4O4dio8TiMKlga4riPh4XCbjaDZBXgz3csCSi7BQi85
	BLXrIrJpWY+eAP7pNR6uB5DdQ6I8j3JKRr0VXNu2pBfl8+2XOlTPM5870GunGQz0Lt0LgaM3hWa
	LqfLZds7VeQm7jOFyFD55UlEdLG3Q1kREl5YvXVQVSsvTml3MTB1J6XP8Q/G3JMB0TGR76VPRjM
	tJdVR3jPOj5Rqfn4StXOjGb+roiPlX3uaX1BGWjnVzpagQSPrhRfq3Y9UHVyb/fVt56Z1/4Qd25
	tSmDVx6im7VdcxWKABJr3pFzxtIfRDWkXBwbIkfzUmbIgVyMcnBdOtyxH6YXQ2WToMzlg5VvuVR
	2jM5q8K21js4BY=
X-Received: by 2002:a05:6820:1a07:b0:6be:7782:5a61 with SMTP id 006d021491bc7-6ef0e7e2844mr13407992eaf.48.1792050301750;
        Thu, 15 Oct 2026 00:45:01 -0700 (PDT)
Received: from [127.0.0.1] ([52.176.123.176])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6fe33486f5dsm2000234eaf.14.2026.10.15.00.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 00:45:00 -0700 (PDT)
Message-Id: <pull.10.v2.cygwin.1792050298.gitgitgadget@gmail.com>
In-Reply-To: <pull.10.cygwin.1789302605264.gitgitgadget@gmail.com>
References: <pull.10.cygwin.1789302605264.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 Oct 2026 07:44:53 +0000
Subject: [PATCH v2 0/5] Cygwin: pty: preserve terminal replies after PTY adoption
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

Johannes Schindelin (5):
  Cygwin: pty: restore foreground input routing after exec
  Cygwin: testsuite: allow cygrun without the testing namespace
  Cygwin: testsuite: cover foreground PTY input recovery after exec
  Cygwin: pty: recover input for children of native programs
  Cygwin: testsuite: cover PTY input recovery with a native parent

 winsup/cygwin/fhandler/pty.cc                 |  51 +++--
 winsup/cygwin/local_includes/fhandler.h       |   2 +
 winsup/testsuite/.gitattributes               |   1 +
 winsup/testsuite/Makefile.am                  |  27 +++
 winsup/testsuite/cygrun.c                     |  12 +-
 winsup/testsuite/cygrun.sh                    |   7 +-
 winsup/testsuite/mingw/Makefile.am            |   5 +-
 winsup/testsuite/mingw/pty-native-input.c     |  89 ++++++++
 .../winsup.api/pty-background-native.c        | 197 ++++++++++++++++++
 9 files changed, 374 insertions(+), 17 deletions(-)
 create mode 100644 winsup/testsuite/.gitattributes
 create mode 100644 winsup/testsuite/mingw/pty-native-input.c
 create mode 100644 winsup/testsuite/winsup.api/pty-background-native.c


base-commit: 867eb7748e6e5a0e8430ce9f46af27b4b1e8f204
Published-As: https://github.com/cygwingitgadget/cygwin/releases/tag/pr-10%2Fdscho%2Ffix-vim-terminal-replies-v2
Fetch-It-Via: git fetch https://github.com/cygwingitgadget/cygwin pr-10/dscho/fix-vim-terminal-replies-v2
Pull-Request: https://github.com/cygwingitgadget/cygwin/pull/10

Range-diff vs v1:

 1:  a29a15748 < -:  --------- Cygwin: pty: preserve terminal replies after PTY adoption
 -:  --------- > 1:  7f0615fc8 Cygwin: pty: restore foreground input routing after exec
 -:  --------- > 2:  4f53a727d Cygwin: testsuite: allow cygrun without the testing namespace
 -:  --------- > 3:  92d13761f Cygwin: testsuite: cover foreground PTY input recovery after exec
 -:  --------- > 4:  f1a25a8e5 Cygwin: pty: recover input for children of native programs
 -:  --------- > 5:  5bbc7634a Cygwin: testsuite: cover PTY input recovery with a native parent

-- 
cygwingitgadget
