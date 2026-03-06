Return-Path: <SRS0=waNz=BG=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:25])
	by sourceware.org (Postfix) with ESMTPS id 369ED4BA2E0E
	for <cygwin-patches@cygwin.com>; Fri,  6 Mar 2026 00:50:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 369ED4BA2E0E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 369ED4BA2E0E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772758248; cv=none;
	b=A1YdkJPb6Qk2fuGOnKAz3VFgOKR13utkhwmZu+V6IZkOl/gcACAUFUIbJzCn9rZeVDfKsicMNlXHsvsEr70rWGIxglhwH/76I7bOvrz8+Yz9R1QDCTxTUWGcFziB4Weq2jKZ8DQ2sPOXSesAsCEevLIPW5afrHTtX2Ebd7le4Es=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772758248; c=relaxed/simple;
	bh=ankeT97fuAGuMGf8i3qmBzV6msAkv9DBCegwF4ANy/M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=E8xfUOBZaEa185Mc5JhEMH3e8w9hrNHTlrBBwD89i6lA/F9jy6otbdgZQVT28CWDjKFF1o+YDW5akEX800pcW7sSeW/8O/8elwyhjN/mQ2NT7PtmC0eAHhRNjnfEzcptV97NAJNKZumWBm4+oT7p09VkrZEG1/PYNCaGjCsb4MU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 369ED4BA2E0E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=L1PoNfKf
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260306005045114.DLMI.36235.HP-Z230@nifty.com>;
          Fri, 6 Mar 2026 09:50:45 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] Cygwin: pty: Fix nat pipe hand-over when pcon is disabled
Date: Fri,  6 Mar 2026 09:50:29 +0900
Message-ID: <20260306005037.1934-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1772758245;
 bh=Aiup017WIZXpqHltsuw3zopKP74Prb7Dz947g0uEg3Y=;
 h=From:To:Cc:Subject:Date;
 b=L1PoNfKf2zAJeFSZA9KpCZL37neQDbeRYrO9Y8CSzsAyAjdwl5dp+3y7zxlY+X78WkVEuzwc
 IenZZmJbxdXKhDB29OXFp6u3Vo0G/7/M3gMkT0/Wl09y9TeFUDoyEXXcuixRhcoRC8e04HJYy+
 uvKrFWR/n43jWdFo5XcNme9Ql6uk6CgvvYFmtq8yj2KKQd2gYFf47hSVeqQAdKSlw+RbUBkhtk
 PHYfdrvBpulaeVUdF93ZggyHhdvBUvJmF4SanQXyoF7WKNGk7ec/M96LABWdrGyKBiL6X5A+SF
 yr2p64IVDYUx2UJgGhzzduyD0DWOAI38BYvcV4RZQFEQulxw==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The nat pipe ownership hand-over mechanism relies on the console
process list - the set of processes attached to a console, enumerable
via `GetConsoleProcessList()`. For non-cygwin process in pcon_activated
case, this list contains all processes attached to the pseudo console.
Otherwise, it contains all processes attached to the invisible console.

04f386e9af (Cygwin: console: Inherit pcon hand over from parent pty,
2024-10-31) added a last-resort fallback in `get_winpid_to_hand_over()`
that hands nat pipe ownership to any process in the console process
list, including Cygwin processes. This fallback is needed when a
Cygwin process on the pseudo console (that might be exec'ed from non-
cygwin process) must take over management of an active pseudo console
after the original owner exits.

When the pseudo console is disabled, this fallback incorrectly finds a
Cygwin process (such as the shell) and assigns it nat pipe ownership,
because both the original nat pipe owner and the shell are assosiated
with the same invisible console. Since there is no console for that
process to manage, ownership never gets released, input stays stuck on
the nat pipe.

Only the third (last-resort) call in the cascade needs guarding: the
first two calls filter for native (non-Cygwin) processes via the `nat`
parameter, and handing ownership to another native process is fine
regardless of pcon state. It is only the fallback to Cygwin processes
that is dangerous without an active pseudo console.

Guard the fallback with a `pcon_activated` check, since handing nat
pipe ownership to a Cygwin process only makes sense when there is an
active pseudo console for it to manage.

Fixes: 04f386e9af99 ("Cygwin: console: Inherit pcon hand over from parent pty")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 winsup/cygwin/fhandler/pty.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 2da46f8d9..06122def7 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -3593,7 +3593,7 @@ fhandler_pty_slave::get_winpid_to_hand_over (tty *ttyp,
       if (!switch_to)
 	switch_to = get_console_process_id (current_pid,
 					    false, true, false, true);
-      if (!switch_to)
+      if (!switch_to && ttyp->pcon_activated)
 	switch_to = get_console_process_id (current_pid,
 					    false, false, false, false);
     }
-- 
2.51.0

