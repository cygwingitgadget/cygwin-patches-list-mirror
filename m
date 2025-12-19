Return-Path: <SRS0=15Wh=6Z=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id 97B0C4BA2E38
	for <cygwin-patches@cygwin.com>; Fri, 19 Dec 2025 02:27:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 97B0C4BA2E38
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 97B0C4BA2E38
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766111264; cv=none;
	b=wCOhSIj8/HzxU/3YtEqab48ye+gAxo3ygiSTG0jLKGYUvRYv5r/UoZ5SMrR5ZdDuJN16XAlDWv9oSE43u2zjkVqgFotuw40zoaxXvfFSczF++Ho79yra8tuDMDp5mPERFQRhWkiPwtnY74u2gpoiia865Hf4NHi8dEqeBOWh0fQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766111264; c=relaxed/simple;
	bh=QJM1ScATo6HZ0SOrRGEtTAjEn5f/XWHTSxmNZz9soPY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=UiredOTLA7dRIeNZa4nfU8fxe46INbCd4z8fuWcAAGO1XuBXsXHpwZeXFui1cOphBMG5wVlqwgw8B+8WEqSjp1Du3PPkAqT86n1Q5mREwbK7JZpoB4XjUesahRh0xE7YeSZ1GH8l+bWZxIL5csjdcMwmlC2ic455Z2kRrIKkei4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 97B0C4BA2E38
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ecobJesp
Received: from HP-Z230 by mta-snd-w09.mail.nifty.com with ESMTP
          id <20251219022741658.VHUP.116672.HP-Z230@nifty.com>;
          Fri, 19 Dec 2025 11:27:41 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v5 6/6] Cygwin: termios: Handle app execution alias in is_console_app()
Date: Fri, 19 Dec 2025 11:26:39 +0900
Message-ID: <20251219022650.2239-7-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251219022650.2239-1-takashi.yano@nifty.ne.jp>
References: <20251219022650.2239-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1766111261;
 bh=a0S5ubibg8thbNkxx7oFX6tV8j95ZJ3IlOVhYWe9bHs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ecobJesp3vGqHGjC/yKymcJTa9ruLuVvUAcSRKKKeFzPYchIv1iGldAIXS2xbQi26sw663JX
 OfXwZgj21it7HVlG3xK5/c5Ew7Gbe8zdvza0cUgNMsl0pwaqYqgzcWxDSv3+qfsZjEk5NdqCqT
 zJgxVED0oyljWhQ38JDP4AZ/TnCjdsBw4NMeh/aq1HwEEWwcW4IldosYCjHl0GVrY+QFYnUnXN
 xY3Xj484HzJ4+P/n0KmjhsA2B7T1bQVueU1gHYQ8LsM2zWLwYZHpW7lck6VX++/m7ZxAUf6zaI
 goX1zrGb/hP10atA1/k3ELObvY0GFThpiil1Q3ac3uJGsFXg==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Microsoft Store apps are run via app execution aliases, i.e. special
reparse points. Currently, spawn.cc does not resolve a reparse point
when retrieving the path of app after the commit f74dc93c6359, that
disabled to follow windows reparse point by adding PC_SYM_NOFOLLOW_REP
flag.

However, unlike proper reparse point, app execution aliases are not
resolved when trying to open the file via CreateFile(). As a result,
if the path, that is_console_app() received, is the reparse point
for an app execution alias, the func retuned false due to open-failure
because CreateFile() cannot open an app execution alias, while it can
open normal reparse point. If is_console_app() returns false, standard
handles for console app (such as WSL) would not be setup. This causes
that the console input cannot be transfered to the non-cygwin app.

This patch fixes the issue by locally converting the path once again
using option PC_SYM_FOLLOW (without PC_SYM_NOFOLLOW_REP), which is
used inside is_console_app() to resolve the reparse point, if the path
is an app execution alias.

Fixes: f74dc93c6359 ("fix native symlink spawn passing wrong arg0")
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/termios.cc | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
index 63b8f63fc..694a5c20f 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -711,6 +711,15 @@ is_console_app (path_conv &pc)
   wchar_t *e = wcsrchr (native_path, L'.');
   if (e && (wcscasecmp (e, L".bat") == 0 || wcscasecmp (e, L".cmd") == 0))
     return true;
+
+  if (pc.is_app_execution_alias ())
+    {
+      UNICODE_STRING upath;
+      RtlInitUnicodeString (&upath, native_path);
+      path_conv target (&upath, PC_SYM_FOLLOW);
+      target.get_wide_win32_path (native_path);
+    }
+
   HANDLE h;
   h = CreateFileW (native_path, GENERIC_READ, FILE_SHARE_READ,
 		   NULL, OPEN_EXISTING, 0, NULL);
-- 
2.51.0

