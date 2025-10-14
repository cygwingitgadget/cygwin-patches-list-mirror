Return-Path: <SRS0=Vyke=4X=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
	by sourceware.org (Postfix) with ESMTPS id D72B03858D35
	for <cygwin-patches@cygwin.com>; Tue, 14 Oct 2025 18:31:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D72B03858D35
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D72B03858D35
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::12a
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1760466696; cv=none;
	b=pI2IhD7LJYvvZaJ+RbH0HEtn2+B0Pd4OgpI4IQjGJlA7IQeVBvfKoufumy2VnYwiKtDw2XXc2y4vHeR+Z7izuNAooLLSvbwmO6ju/8gXJXDtQy182z7PFUJtaCqjlsDjABt/+PyoQt4r8bu0EIbz11qmJd6GQkVEaZ9O1R7/XNI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1760466696; c=relaxed/simple;
	bh=Gd/YHkvh+ZeRpk8BnTlGf5ysvQk8akggpPckLC03JMg=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=JJ6OEf7ogfapm5aZkzxtbf5dyCNqvydgCxhuCgI1qvl9t+7wUdb4surlFl9R8dnajcsZWnsS29I2ikGTzkpAtb86Mq3QkVuG+48m/wqiNth52dstUcF05Mx13G62LfUZMH2nZ2UhmgX8wvbub9jGOuYW4MEcz6fJKf3Xh2zd9Xg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D72B03858D35
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Soz9VRbN
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-4291359714eso48259455ab.1
        for <cygwin-patches@cygwin.com>; Tue, 14 Oct 2025 11:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760466695; x=1761071495; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILw2OnpfA6D/0gxh5luAb+3l5NtNPmnCnRBRdSMrTrc=;
        b=Soz9VRbNDMpj37OXiTi+q1RdizJxWQ+/CbU1Dveh8foryqIjd1wwwe/y7OjNPmnH7G
         TyJvjmd5ZcHv81WdX9iX77brLZMSxMTYBZAPp3GpibkdAZQgcjZsGZ/pSGvM9ETJKFmK
         dx/QTGYVVUQR8nBQcL9vS1otfEi8h34u0lUAM9row/in3sustyUnzG4fH+I9liyCpojD
         QCf/GutckPKzRjh+os8t4jgzPzW24nR0SvzfkEhLXZFxgprr3fFOmQqgkoDCeVJN/YG6
         +zr3wLx7Ur6kcPrbIphTp7i+ac3GLYJhs2jmJ4gR507abnd508r3t0Pe8mf7+JG1hTF8
         TAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760466695; x=1761071495;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILw2OnpfA6D/0gxh5luAb+3l5NtNPmnCnRBRdSMrTrc=;
        b=JZpsMfqYGMew5ZI2ChRWuZtrw70qW10I3vwGrFUmka1wv3UWGHIzhV06XKs4HsTVVL
         DEFTSbuukdYsS/3SDDytm6Cg1+QnAuuNX5X/KRwHsZJY3znmNQMXQVI5TTpyhiSnJEEa
         7zMgVeQy1Fm+Prb0kjEUGxu+UDBBOTwAzyqDCIZXpNjqTqo3AxqXPVE0/LF0rjOjbH0K
         sbEBsmUMbx91l07rQX9dH9xpuCWLvbbLR78Fss586UzHRsCrD53P6pvF6y2DPucm/hoy
         1bPhxuTnHkJTc2E0YQ1Vj6GakwVL1XIMHH2em+A04Dzxg80vt4+7WOQtIKP4vABIEjC1
         Jl1A==
X-Gm-Message-State: AOJu0YzKDuA9X4byQoplG9VfCTI+KS9eY7xlCnqCiNr/hIjYaDdqVfVv
	dn9qYEBxU+CNvO9Re0sTaBtfFHfXDL5r6cbUQFsSAxo8nad4N3b+TVTWmGmUS23CD/U=
X-Gm-Gg: ASbGncuyzqgFhWo2Wwva529Q7nuUQ72HFgZH281cxYSK+ULIuGzcCBXLvPiWS8AGvc1
	mBG1TUiderYhRA15icV0lS7ZXu5o+dES3qaduofaCmkNct2Bn+fvWNxNVwr+qLHM8bM7xT+/cKi
	JnpV23C2qq1XihEWjWBqU3o6f7dKJrteDl6eN1Q1G5jCR96tAT3eOFfo49VwLMJUgKZGSrGhkLs
	XTN3hEnfExp+qX9knt8G8H8fhp0bvE8UZC0er7lij/ffijxkegSLx/ZcZxZQGvzwq6Kc9MqAQ0N
	8X15GBQ9k+FFziQMuiFubLAZHCQH4pfbUXSuIocDDums5KAFO6PcHeuq9E6jgjKaunl6nZF4yj8
	pvik6YapuFMhSPbYdoYn3t6fQMTFQjwe4Nk4dR/zLng==
X-Google-Smtp-Source: AGHT+IGgL6UZ0zYuNkfSqcVDAfS06S9iKlnrSnIx6Ao1OhejT73nbDeMRvN0TtkpAPbt+NtF+hg2bg==
X-Received: by 2002:a05:6e02:4509:20b0:42f:9b79:f8cd with SMTP id e9e14a558f8ab-42f9b79fcebmr172680925ab.16.1760466680942;
        Tue, 14 Oct 2025 11:31:20 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.135.4])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430abd820dasm560795ab.37.2025.10.14.11.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 11:31:19 -0700 (PDT)
Message-Id: <pull.4.v2.cygwin.1760466678223.gitgitgadget@gmail.com>
In-Reply-To: <pull.4.cygwin.1760433371125.gitgitgadget@gmail.com>
References: <pull.4.cygwin.1760433371125.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Oct 2025 18:31:18 +0000
Subject: [PATCH v2] Mention the extremely useful small_printf() function
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This function came in real handy many, many times over the year whenever
I needed to debug any issues with the MSYS2/Cygwin runtime, first
instance was while debugging an issue that strace 'fixed'.

However, this function was not mentioned anywhere I looked, so it took
me a good while to find out about it. Let's improve on that situation by
mentioning it explicitly in the documentation about debugging the
runtime.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Mention the extremely useful small_printf() function
    
    I have been using this function many times for debugging over the years,
    and found that it was too hard to find originally.
    
    Changes since v1 (which did not make it to the list for technical
    reasons that should be resolved by now):
    
     * Extend the comment about to talk about slight deviations from the
       POSIX printf() function family.
     * Improve on the commit message which previously was too terse.

Published-As: https://github.com/cygwingitgadget/cygwin/releases/tag/pr-4%2Fdscho%2Fmention-small-printf-v2
Fetch-It-Via: git fetch https://github.com/cygwingitgadget/cygwin pr-4/dscho/mention-small-printf-v2
Pull-Request: https://github.com/cygwingitgadget/cygwin/pull/4

Range-diff vs v1:

 1:  cb48c880c ! 1:  f8199e1b5 Mention the extremely useful small_printf() function
     @@ Metadata
       ## Commit message ##
          Mention the extremely useful small_printf() function
      
     -    It came in real handy while debugging an issue that strace 'fixed'.
     +    This function came in real handy many, many times over the year whenever
     +    I needed to debug any issues with the MSYS2/Cygwin runtime, first
     +    instance was while debugging an issue that strace 'fixed'.
     +
     +    However, this function was not mentioned anywhere I looked, so it took
     +    me a good while to find out about it. Let's improve on that situation by
     +    mentioning it explicitly in the documentation about debugging the
     +    runtime.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ winsup/cygwin/DevDocs/how-to-debug-cygwin.txt: set CYGWIN_DEBUG=cat.exe:gdb.exe
      +   If you cannot use gdb, or if the program behaves differently using strace
      +   for whatever reason, you can still use the small_printf() function to
      +   output debugging messages directly to stderr.
     ++
     ++   This function accepts slightly different format placeholders than the
     ++   POSIX printf() function you're used to, for example `%W` instead of `%ls`
     ++   to print UTF-16 strings (provided via `wchar_t *` pointers). For full
     ++   details, see the first comment in `winsup/cygwin/smallprint.cc`.


 winsup/cygwin/DevDocs/how-to-debug-cygwin.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/winsup/cygwin/DevDocs/how-to-debug-cygwin.txt b/winsup/cygwin/DevDocs/how-to-debug-cygwin.txt
index 61e91c88d..4ac554acd 100644
--- a/winsup/cygwin/DevDocs/how-to-debug-cygwin.txt
+++ b/winsup/cygwin/DevDocs/how-to-debug-cygwin.txt
@@ -126,3 +126,14 @@ set CYGWIN_DEBUG=cat.exe:gdb.exe
    program will crash, probably in small_printf.  At that point, a 'bt'
    command should show you the offending call to strace_printf with the
    improper format string.
+
+9. Debug output without strace
+
+   If you cannot use gdb, or if the program behaves differently using strace
+   for whatever reason, you can still use the small_printf() function to
+   output debugging messages directly to stderr.
+
+   This function accepts slightly different format placeholders than the
+   POSIX printf() function you're used to, for example `%W` instead of `%ls`
+   to print UTF-16 strings (provided via `wchar_t *` pointers). For full
+   details, see the first comment in `winsup/cygwin/smallprint.cc`.

base-commit: 2ae6825d022ac4450cef168ce066d68810b3a6e2
-- 
cygwingitgadget
