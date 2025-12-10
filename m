Return-Path: <SRS0=1nHs=6Q=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e08.mail.nifty.com (mta-snd-e08.mail.nifty.com [106.153.226.40])
	by sourceware.org (Postfix) with ESMTPS id CA0324BA540C
	for <cygwin-patches@cygwin.com>; Wed, 10 Dec 2025 05:39:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CA0324BA540C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CA0324BA540C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765345156; cv=none;
	b=rj/YzDCeEZaUgIl3fyD15Y+JevY4kBA09lNgb962wKyQbXDmysQ2sZIlnZCadiyA5vBbDWl+8ottsix+m4iOYKG3i70pu2fEfS160JrvhdE3IMWhp0X1RjhlH2/r3N9Y/7GFiIIKWVhz3N6wO7vr9QxOux+t60jvw/mpEKbI5gs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765345156; c=relaxed/simple;
	bh=UqvVn1P3+X52CPKE2BuTLqyNTl04Mlylyj4pTsoGWRI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=n6w7x3DX7locObBDCjq8tBFxB/0ADnSamUI/iQphdW4k1reHbEN02/4LGcreFVbGVEJWgo+eWwF+zlNu9jGc5uhgew5uAyMWLrO1Qovra61C9ak5pU2oB1K7nn2WtE6ZO3JexpOyKhTJ4DCYd/FYvEUPXuwMvRUGRp3NfSuC7A8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CA0324BA540C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Dsbx9mSM
Received: from HP-Z230 by mta-snd-e08.mail.nifty.com with ESMTP
          id <20251210053913820.SRCK.106098.HP-Z230@nifty.com>;
          Wed, 10 Dec 2025 14:39:13 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: termios: Follow symlink in is_console_app()
Date: Wed, 10 Dec 2025 14:38:47 +0900
Message-ID: <20251210053907.857-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1765345153;
 bh=7a4gqylvV+eGgBCwb5VrLzlC5W+QVOvtw9JDYzPycF8=;
 h=From:To:Cc:Subject:Date;
 b=Dsbx9mSMgjRGkN2Uf2EWLsr2WXOVECQRCywf3m/SQrfyXytXFdkmkvEnYkpiZO6hdOQNLXmX
 t9nDMsJv9faBrGeo4H9mSFqjocFHJ224/gD1TrPNNy7X8epT92dV67tYb/DRrHeqxEG46xkwSj
 efILsnX08qJvauUvTao78HmJskuYYm6sTUO1J+4w1C9JihQ9e8xvkAo2oIdD421zqw/jrqSnhl
 IpxLOar3zI7XqjF+LIqB5nSzVzTTHUc3QTJfKN3XWGDn/gV7uUS4+19vd7sfv6VOw6i7oH4sl5
 7OrSlBoVA8C+KbOZ09DSOeQ/J/O5HPCgP6nZ17O262uhY5kA==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From cygwin 3.6.0, WSL cannot start by distribution name such as
debian.exe, which has '.exe' extention but actually is a symlink.
This is because is_console_app () returns false for that symlink.
This patch fixes the issue using PC_SYM_FOLLOW option in path_conv.

Fixes: a commit between cygwin 3.5.7 and 3.6.0
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/termios.cc | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
index 19d6220bc..1026b6969 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -704,8 +704,14 @@ fhandler_termios::fstat (struct stat *buf)
 static bool
 is_console_app (const WCHAR *filename)
 {
+  UNICODE_STRING upath;
+  RtlInitCountedUnicodeString (&upath, filename,
+			       wcslen (filename) * sizeof (WCHAR));
+  path_conv pc (&upath);
+  WCHAR *native_path = pc.get_nt_native_path ()->Buffer;
+
   HANDLE h;
-  h = CreateFileW (filename, GENERIC_READ, FILE_SHARE_READ,
+  h = CreateFileW (native_path, GENERIC_READ, FILE_SHARE_READ,
 		   NULL, OPEN_EXISTING, 0, NULL);
   char buf[1024];
   DWORD n;
-- 
2.51.0

