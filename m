Return-Path: <SRS0=WEyG=JR=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by sourceware.org (Postfix) with ESMTPS id BE48E4B0A6DD
	for <cygwin-patches@cygwin.com>; Sat, 28 Nov 2026 07:04:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BE48E4B0A6DD
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BE48E4B0A6DD
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::102b
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1795849465; cv=none;
	b=SQQB1fI398MUSosXZnv4VFDXqlBiZwdQuo983FIT9cHYenCLjdaDCZIOtn+NR8ltQ4BtH9jAY3uY2Kv5vQBnRV01TKSymPs03nBxSGdYVWHuCFggH/o39gUcY07ClX2Y9Cig4HVLhgb0BU8XaYgid89T1wfBJxgBY6Ayl+4Ef8o=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1795849465; c=relaxed/simple;
	bh=uF6VzourlESP+eWSiJsSXYCzynGb30zf6osDCSSomyw=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=kOQ0iCBddBYZKiD7fdURL3C1HQGx7mZvSiS3hN11PjpR6ykV6jfUkS6wlH2iKh9tOoRfM2AHTYYM5CLy9jjn94X5ph7R2H59HGqiptHCW+C4Wj2KSz6Wxt/t8ceejO7jTfTfSWTasdXPnPCjY5vyAl6i6CRQoGpUgO1RtB6Rv/8=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xX/s5OWy
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BE48E4B0A6DD
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xX/s5OWy
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-3b41e5a1719so3615350a91.3
        for <cygwin-patches@cygwin.com>; Fri, 27 Nov 2026 23:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795849465; x=1796454265; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DLIvuuhpcX8vadwycsTGVYCLa/5owerX7/GZKmWr6Cw=;
        b=xX/s5OWyluvx+mjmwWLgqoFhxo39nvzIDRJgBlS3zDJfcJlRM8Q3IzwIo3MRYfLjnI
         KbRSlutyaqbsSIbzK+OHczgBZSwy0TgMCWI3S9ySPJZ0JNpfvATB7OgHJYMEJggFHTsJ
         KiXInbRQDSUQF/oBjYbc2Nt9TZDpAgoQEvR62DFrEu6MGb0JsSsGt5GtJZnsjiXSpKg7
         0lNyxUvuHyvrhLBjsfewAIt4V9f4IDcgv2/4HPfgBsiEBtf83WlPXBgXfT6W6L773znZ
         Nms+lwK7jw9zHrJ1sBvV8oQjpptlWckQeIFgSwA954dIebTh5xLb/CHSNlNg8aEQXXSN
         BCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795849465; x=1796454265;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DLIvuuhpcX8vadwycsTGVYCLa/5owerX7/GZKmWr6Cw=;
        b=1r9d2xwi/cozJNXWECaca0vau/jFPrtAqw0aOb7T4QZEKDOacfjBQymQ3VqvUazvjv
         7k2OwY2iyN0iuaedx85nVxm61ilSBUMscbjS2KeoxrPlpe85yegnMa/JkAUVSqF7lmbk
         jaQqZS/27zetM13fhDyHyZTVqccW/DYCLZT6H44RxZfULc+do3QLtILmKcTDeT3/K24r
         NFq8cbUsV7iEkP802rZNl/8aGiD1F+MOp1rqa2KtrLITN+SyKKW/aO5b/py9xE0ZIxn7
         pbUo0YxXISE1ETwqkcrPMp8q3hfhenq4luDRX5IQmF6Hzw4VTrHFkdV21QjIiTrA6BXW
         qwOg==
X-Gm-Message-State: APuU4Z+OSgKQ0EPoYk8/zacQYrQj8SnW9JUxgnT1cjr+BWTi+VqxZq7D
	sJTY8WRPD44ulQBNPM+vrGm91beqzaYaLKut1LZT2/bpjoTaFz6SVd3K/A7EnK55
X-Gm-Gg: AZFdTZeMvkIF5U5P3OfFlq4lD0WXjjNQbJ8Br8P1UXfJBTh3IgR5obSpQDI+ir/mQBw
	/mPqk8OqKcS1va4bEaWfkRuESaxnxfUqD3QHpqgwrp6JHMQgbNPBZrPGVauglura3EGsRqtd2ak
	U0e/eYTB+bScnUmmIFJpBjrSXWvV0LMmQ6dV4/1VVNPq6A0AHlaclQsDH2FYUUXc/JUr7xWL91N
	Eg4Pafs9IZWNR8y30DutagQwG5ehmRK1R33vwM6/lO9Ebhnahde+o9j3oOpPy0b0DrdnujHZr+q
	roi3ZHEBO+wavFr9hyr+eXoV0rr9tIFTCXQthQ4L7KFwPimIkNheSPxAWao9lHkJTXR2qa+PA/g
	10TBxqjmYPZYFlxJaPcntnc3wsdPXLsPFRMRfX7DJBMJD2YqLpFKed6q/ZZlO+cHhIFpmmv+A69
	KVgzkPFR2/rPKofs8qvDXO+mu192NW2NnXjj3YHgi37P/ME+jsoZ+bRKB9Wq0dkuaAmiev8Of17
	oqKZEdtIZPQ0wZ3/Uh2bAeO0nD8MfduGCkcDKR7PO+1KVyvpWGsaHEPUZ847ob49W5vGAuQCx71
	YKCX7mAw9aORH7o5IOdFl9nAEODQbpVC
X-Received: by 2002:a17:90b:3d4d:b0:3b4:7cf:5e5b with SMTP id 98e67ed59e1d1-3b41c93e808mr23182331a91.31.1795849464610;
        Fri, 27 Nov 2026 23:04:24 -0800 (PST)
Received: from [127.0.0.1] ([128.85.44.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41aab4729sm41389094a91.0.2026.11.27.23.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 23:04:24 -0800 (PST)
Message-Id: <pull.19.cygwin.1795849462.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 28 Nov 2026 07:04:20 +0000
Subject: [PATCH 0/2] Cygwin: fork: preserve FIFO client handles across fork
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This fixes hangs and failures that can occur when another process opens a
FIFO for writing at just the wrong moment during child process creation.

It was contributed to the MSYS2 project by David Declerck to fix for the
reported FIFO/fork regression
[https://github.com/msys2/msys2-runtime/pull/402], and I added a regression
test.

These patches are based on the Cygwin 3.6 branch.

David Declerck (1):
  Cygwin: fork: lock FIFO client handler lists until the child copied
    them

Johannes Schindelin (1):
  Cygwin: testsuite: cover FIFO handle loss across fork

 winsup/cygwin/dtable.cc                 |  19 ++
 winsup/cygwin/fork.cc                   |  12 +
 winsup/cygwin/local_includes/dtable.h   |   1 +
 winsup/cygwin/local_includes/fhandler.h |   6 +
 winsup/testsuite/Makefile.am            |   1 +
 winsup/testsuite/winsup.api/fifo-fork.c | 294 ++++++++++++++++++++++++
 6 files changed, 333 insertions(+)
 create mode 100644 winsup/testsuite/winsup.api/fifo-fork.c


base-commit: 1244d32dad414e42fe3930991c913e20eb927d72
Published-As: https://github.com/cygwingitgadget/cygwin/releases/tag/pr-19%2Fdscho%2Ffifo-fork-lock-regression-v1
Fetch-It-Via: git fetch https://github.com/cygwingitgadget/cygwin pr-19/dscho/fifo-fork-lock-regression-v1
Pull-Request: https://github.com/cygwingitgadget/cygwin/pull/19
-- 
cygwingitgadget
