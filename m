Return-Path: <SRS0=C3e4=6V=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	by sourceware.org (Postfix) with ESMTPS id B47E44BA2E21
	for <cygwin-patches@cygwin.com>; Mon, 15 Dec 2025 17:06:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B47E44BA2E21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B47E44BA2E21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765818400; cv=none;
	b=onqKfZLRVPInUDeiZ0An0sBgaMa7BCruuoH7SAXmaFBZmPWCzXrmxjfyplqGClPC5+cmwWNiK5YPks+7RQCbZ2VVd0II9uwG47GbIuESnSgORz6Iwwv/fmd84P1X9GpdmKlhN00PAgVpjX/b3H5pK5jQ1a34xChz5mq3/OsmKkk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765818400; c=relaxed/simple;
	bh=5eIqaYz5UgDVwxuEAb9EuRcNea/Cdr2I2MyPVw6dnVg=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=TroEyRMdPINScBnSKjVSEXkitV7iFF8vtUuS1hE7kpySpDPihVrEqtyqYudfUrOUE7PMfHyK53wnbN7NMycPX03+TavXcBoZVY0MQr97ewcGRPHcsga9GiwxQehPvJ+1FXwR8SR7rqFzp1+KCnNbs0a1motifAKkLyBiXOPYwuA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B47E44BA2E21
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=KoZUDtxi
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34c7d0c5ddaso790308a91.0
        for <cygwin-patches@cygwin.com>; Mon, 15 Dec 2025 09:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765818399; x=1766423199; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDUpyDIvp8HOPbDSojBmqTMRuzhCEgpJbRhAb/ZQ3dU=;
        b=KoZUDtxiFF0AvnmhnbqOnspwsxjIIvQv4WK5RIgtD0wzI7nC0L/8A0eS35Ni2OVHRh
         ksK2C1laHUYH0X9tVjV2FAab2m1D1mwm+DwIgmkjTLtGCArmOcWZpk7LxnQ7Q/i0SckM
         3+Vfwg97q9pPqcwxAO7+ke7sTLTYqxAGPQ5xFGYv/vsVbBAImTLP7sNzNgk8WHSDFsCW
         72g9pK/o5AdQICFhmICZImySPcnHQilcVI5tlMJVp3YqPhhjf18SoSDFEQbVHVWwttYn
         s4eXHbK0msX/IifH5cfMgq2BMqgRUoghQ7WQe4wnQyxQoBPj6rBW621ObhQQ7x20xd48
         oZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765818399; x=1766423199;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qDUpyDIvp8HOPbDSojBmqTMRuzhCEgpJbRhAb/ZQ3dU=;
        b=Bf2qJqVInb+R9GyTMpfEnKKpGFrFmJ4KknwldLX22Mu07eDVmWcggFl8Qd0Vip7kDe
         QRu8B/UMnC302RWmjq1a/34zSDILEeLByuAQp/mbQGmhNlbb95HTYBxYvcACkj77s6Nk
         85WCtfASDTSOxRIV62cy8xDqDBI22NX7aACDru+QEE+EVVPf1vK79Pf1HEIjxsKaj0Wx
         dMKqC64R6J9AWxCqJf+zyt/DfDpCc9CuvczhGBslpWqMfvzWksQVUYqpnJnyS6WPHF0e
         DSaVuStUapLx4oee0uG37r5YX5I3/BopmY6acY3SjiWGfhGNG6sa+b2VX6X7b+eEBsaz
         X4ng==
X-Gm-Message-State: AOJu0YxTYV0Gu+G9eKvsRm7P8i+gXYwFRPBrd+41Sqq683gTTUI9aBgJ
	nVoQg3XU00lEO7y0YtjYlcvG9E+bRz0vfZkaDgo9If+uMCfxTMCwJmr3xXHkww==
X-Gm-Gg: AY/fxX48cImw0nkSO48KWnxfXriDJt2D+AgbrL9XN/j3c49aEY5q+7yDM4UHqsI/4xr
	cm15DiqdrnQUfSL+mIham12OJaoLx7DzKGptB816kEr9vn49oFxzcPVAqsDYOCaSbdNMFOSHG1U
	f+6S3oJ3czUlcB/KLnPlJDv8eTzkS68hCycaUtkSli3UQsRgV2o1AWnPG88TkclxaV8IxD2mk+n
	iVPOxKR/PkabI18Ou0osuM7Ms3znm2MzFaookipE50ZshYJOotAn5UOSQHyTtQedJKZaFBV9n8B
	9noIKELjYWAgud1O8X8b8J40vwKKh8jRFs/KC+S4gYXme17Ia7ddvTrE8Pyej3y+OmbeaflpyWQ
	L1DjlwDKeA6FxViyaUTlaK6v8xq3NHgikSQpSp7rLIB4frOtVCGz6t6s8gRHo2Q3UR7ZYIJ9l7/
	z47P1c06oJwnk=
X-Google-Smtp-Source: AGHT+IEFza11kRDz+dbioT6C5td6r5yIgcPDq09DmYVKLsFAUL6RNmWwaPkNExYdC1xG73sxaL9Rzg==
X-Received: by 2002:a17:90b:2683:b0:34c:2f40:c662 with SMTP id 98e67ed59e1d1-34c2f40c94cmr8602097a91.14.1765818399224;
        Mon, 15 Dec 2025 09:06:39 -0800 (PST)
Received: from [127.0.0.1] ([52.225.25.58])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe2c1664sm9468189a91.17.2025.12.15.09.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 09:06:38 -0800 (PST)
Message-Id: <8e9732407ff389b2bcf978b79d8308e0471980fe.1765818395.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.5.v2.cygwin.1765818395.gitgitgadget@gmail.com>
References: <pull.5.cygwin.1765809440.gitgitgadget@gmail.com>
	<pull.5.v2.cygwin.1765818395.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 15 Dec 2025 17:06:34 +0000
Subject: [PATCH v2 2/3] Cygwin: is_console_app(): deal with the `.bat`/`.cmd`
 file extensions first
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Cody Tapscott <cody@tapscott.me>,
    Corinna Vinschen <corinna-cygwin@cygwin.com>,
    Takashi Yano <takashi.yano@nifty.ne.jp>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-13.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This function contains special handling of these file extensions,
treating them as console applications always, even if the first 1024
bytes do not contain a PE header with the console bits set.

However, Batch and Command files are never expected to have such a
header, therefore opening them and reading their first bytes is a waste
of time.

Let's honor the best practice to deal with easy conditions that allow
early returns first.

Fixed: bb4285206207 (Cygwin: pty: Implement new pseudo console suppot., 2020-08-19)
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 winsup/cygwin/fhandler/termios.cc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
index 808d0d435..5505bf416 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -704,6 +704,9 @@ fhandler_termios::fstat (struct stat *buf)
 static bool
 is_console_app (const WCHAR *filename)
 {
+  wchar_t *e = wcsrchr (filename, L'.');
+  if (e && (wcscasecmp (e, L".bat") == 0 || wcscasecmp (e, L".cmd") == 0))
+    return true;
   HANDLE h;
   h = CreateFileW (filename, GENERIC_READ, FILE_SHARE_READ,
 		   NULL, OPEN_EXISTING, 0, NULL);
@@ -720,9 +723,6 @@ is_console_app (const WCHAR *filename)
   IMAGE_NT_HEADERS32 *p = (IMAGE_NT_HEADERS32 *) memmem (buf, n, "PE\0\0", 4);
   if (p && (char *) &p->OptionalHeader.DllCharacteristics <= buf + n)
     return p->OptionalHeader.Subsystem == IMAGE_SUBSYSTEM_WINDOWS_CUI;
-  wchar_t *e = wcsrchr (filename, L'.');
-  if (e && (wcscasecmp (e, L".bat") == 0 || wcscasecmp (e, L".cmd") == 0))
-    return true;
   return false;
 }
 
-- 
cygwingitgadget

