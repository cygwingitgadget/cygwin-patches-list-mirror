Return-Path: <SRS0=FWTa=4P=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
	by sourceware.org (Postfix) with ESMTPS id 9945E3858D29
	for <cygwin-patches@cygwin.com>; Mon,  6 Oct 2025 21:15:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9945E3858D29
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9945E3858D29
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::d2b
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1759785323; cv=none;
	b=gGJyB3OEX0LIbWBIBtUV0o+RUSzOQ961HV8BdJFaNOi6WEBe6gAVpg4jqQuBGpxUdOscddNaizLCmO+1OWgT4j5KovmaQ/mtU/U8BSjBuYyjUNdV2AAtbVAgsKy5lKHpo05vv9hZZvNTgNX8hnbE4vewz1EQTqsh5vrrWjiuMPc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1759785323; c=relaxed/simple;
	bh=7qfRSdKIIP7c5SZSKuxH4fyeOTMkQYKtLSFiQwOCAik=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=aUgR1z19JN8U2A4BiNpbubywl59eTYKkAl4gjXVXLSft3NQ4rrb36irsRMOVNzGM1WzbsJIcMnMLX812VGFCddPWMgHr61pnOc4S2Eboog8fxPueopeIFDXIreGmGiW1bL95jf5irGEqo5uR62jA9Ud+vxVu/L6YDODRj1n9kMU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9945E3858D29
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=AyHXSt/x
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-88703c873d5so190494039f.3
        for <cygwin-patches@cygwin.com>; Mon, 06 Oct 2025 14:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759785322; x=1760390122; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sGR3OFC/Bb+nWqiAOW03kNQyuf363t3EtjeQtfIllNs=;
        b=AyHXSt/xdx5JkWxZ5mGuzatsKRIq2b2eKNI287X63ty1JtsY6gCbuVKMXxN1Po6+0Y
         RbZbGo2KH15zs/Nlp2qzIcqUOtufUQ4IxfVaidlivvNjg5yXOh00tryeyLKmsJkGIl8D
         qqSYXM9msiqZNjaJdneigjFUfnnzjdGx9JJhIppFubU5aHXKaRlBFnlwUNX7GxR8fhCF
         VClJ9p40PV8d9cXkhJb86h9a8AJ6Cj2AHSQRympU6HCnD1eSJ3UgDKzxueL24TClfWFv
         UINCL3xUxSPpWkh9Viqkdy+T7ZEjlQ1HoG5TxkjX16T477LMSGtauRGn5ulpA8NTj05q
         PoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759785322; x=1760390122;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sGR3OFC/Bb+nWqiAOW03kNQyuf363t3EtjeQtfIllNs=;
        b=TKS1dSi+C8LYNRgqt1OXtlccNGcBhup3HIPKPtK5SWd0qBr521pp2syODNAht3mdlg
         B2z/MYm/qMji0IR9dfpee7qNPnvP7gv9FRjExYVM0GTQw4v36FU44rVWLO/61cTEL/P6
         75cKHMHF4d9P+sifat3m1BlzAUTALBNY974lQlq5CGTCh31S++l9lS/cI8cxg2OkX0FZ
         4R3tf0dYDS9TQGE2yiWJ4Hk+9WByk2bdDaIchIWfLHeX4eYbPWdw+nLXWMWG2ZbQYszr
         QbxU9axwhBPLAs15HIGERVRcVNDRf+usvg7Dchrujxq5D8rQvkGdLtTU+bYYkjjv4nCI
         hHPQ==
X-Gm-Message-State: AOJu0Yzry/ejJrCJE7A/sXTryCZr/Wv+FyfqCssO6ecPK5DCQ+BXlpTp
	Ak9LANZoLIpyFTUaAGlgqVZRiAvY+V8t+Tjg+kbCCUDziObjHDD5OuZ4JbYid6MC
X-Gm-Gg: ASbGncure3MKPmt4SZR66DyYlblBDRUwpx3RuPWBhz9bX7VPESyh/qf5XHYrGGC2gj8
	mJjb5JWdG5e7ynlTlxcTI96sdpB9lHKjWJj/ghgcbSYo80s01VL3oc4Z7FaP1kPhgINdFn0HcSE
	gOCxqPBkrURCp/XeB1cFJ3sGkrrpJUxujUdNUnQDZklNWwWCZfftYJ+0XmW6ppF7BoTgqOl/lkD
	msBLQnhHAW2ZIXuHdURl3lhggiMGnu/6LEKIY7Y2Gzj2g0RqkUdopoAHE8sc51TRs31Em8gsClg
	26PladxSkd4iRPDJW1udM3LKloTLzIbDj6uzGl9dpfpavQBryVeZ5ArTReKnLwSnKNEhVcE838+
	pWD5dPa5r5BOceL6Oa6NL+OcnlLwpABE/tOI7hM7UpIgeCreisx73PViHdGiT
X-Google-Smtp-Source: AGHT+IFLto9rg3bU6aFDi1b+HF4HWmX6oawIS6jztBtNE6p593plpGCdCyStXuMctLrnkuFReMcDIQ==
X-Received: by 2002:a05:6602:2c10:b0:935:4720:6452 with SMTP id ca18e2360f4ac-93b9697bab3mr1870510839f.8.1759785322248;
        Mon, 06 Oct 2025 14:15:22 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.114])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93a88961d74sm522843839f.22.2025.10.06.14.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 14:15:21 -0700 (PDT)
Message-Id: <pull.3.cygwin.1759785320084.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Oct 2025 21:15:20 +0000
Subject: [PATCH] Cygwin: symlink_native: allow linking to `.` again
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

In 827743ab76 (Cygwin: symlink_native: allow linking to `..`,
2025-06-20), I fixed linking to `..` (which had inadvertently
targeted an incorrect location prior to that fix), but inadvertently
broke linking to `.` (which would now try to pass the empty string as
`lpTargetFileName` to `CreateSymbolicLinkW()`, failing with an
`ERROR_INVALID_REPARSE_DATA` which would be surfaced as "Permission
denied").

Let's fix this by special-casing an empty string as path as referring to
the current directory.

Note: It is unclear to me why the `winsymlinks:nativestrict` code path
even tries to simplify the symbolic link's target path (e.g. turn an
absolute path into a relative one). As long as it refers to a regular
Win32 file or directory, I would think that even something like
`././c` should have only the slashes converted, not the path
simplified (i.e. `.\.\c` instead of `c`). But that's a larger
discussion, and I would like to have the bug worked around swiftly.

Fixes: 827743ab76 (Cygwin: symlink_native: allow linking to `..`, 2025-06-20)
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Cygwin: symlink_native: allow linking to . again
    
    This fixes a regression I introduced in 827743ab76 (Cygwin:
    symlink_native: allow linking to .., 2025-06-20). It is not necessarily
    a complete fix per se, but more a band-aid for the time being.

Published-As: https://github.com/cygwingitgadget/cygwin/releases/tag/pr-3%2Fdscho%2Ffix-symlink-dot-cygwin-v1
Fetch-It-Via: git fetch https://github.com/cygwingitgadget/cygwin pr-3/dscho/fix-symlink-dot-cygwin-v1
Pull-Request: https://github.com/cygwingitgadget/cygwin/pull/3

 winsup/cygwin/path.cc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index ed0839893..8aff97acb 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -1895,7 +1895,10 @@ symlink_native (const char *oldpath, path_conv &win32_newpath)
 	    e_old = wcpcpy (e_old, L"..\\"), num--;
 	  if (num > 0)
 	    e_old = wcpcpy (e_old, L"..");
-	  wcpcpy (e_old, c_old);
+	  if (e_old == final_oldpath->Buffer && c_old[0] == L'\0')
+	    wcpcpy (e_old, L".");
+	  else
+	    wcpcpy (e_old, c_old);
 	}
     }
   /* If the symlink target doesn't exist, don't create native symlink.

base-commit: de2dccc8ecd00e6244ac10f28d7fd50123e8fc4b
-- 
cygwingitgadget
