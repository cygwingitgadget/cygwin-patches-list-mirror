Return-Path: <SRS0=zJ3/=XZ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e10.mail.nifty.com (mta-snd-e10.mail.nifty.com [106.153.226.42])
	by sourceware.org (Postfix) with ESMTPS id 72E423858D38
	for <cygwin-patches@cygwin.com>; Fri,  9 May 2025 22:23:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 72E423858D38
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 72E423858D38
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746829392; cv=none;
	b=v1dUx1TvILNjc/442WgoO9IZ6/jFLgk8oh+MUUGh75p4rni2R5423cJ1YrPBndQ5HPUiEXVA1oN8F1XX9Va1+mwCR8my/DeGBoXtMo2m3o+8/xHmWqhQZoqRiEGXAg9Nrp0jzTIOFhDfFiJKksrviT9JX6C7fDu2gEY46uOldvo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746829392; c=relaxed/simple;
	bh=CpofSA0IIBpnOWfqsI6nntDcxqeZyVa3ucij3vhtwiA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=sfLaIJ5DpROrf7qq4Mngp06aJuh9BDx1LKwo0W8MU6ozRiL11kpiXXX1ceMnHKMLlftFLtqxAd3tcD07VYtI7iZv0mSABxEoexpr78ccmMIF8Wp0JfevKYkhbhUFYpcWmTUrmMm0Vaw4anfXDYutUsqnLpwTti21IsoCvxNmMos=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 72E423858D38
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ZUq5Q4ll
Received: from localhost.localdomain by mta-snd-e10.mail.nifty.com
          with ESMTP
          id <20250509222308858.FZJO.34837.localhost.localdomain@nifty.com>;
          Sat, 10 May 2025 07:23:08 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Fix the console mode for background non-cygwin app
Date: Sat, 10 May 2025 07:22:43 +0900
Message-ID: <20250509222254.441-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1746829388;
 bh=51VA1PghpBLH3HnTeYVae9NFCysVIG9EUXMfOlf0Jlo=;
 h=From:To:Cc:Subject:Date;
 b=ZUq5Q4llW5VdMSsggT5540RxzL5Zo3L0oXosg6faJZjd97ocfRe6CS6Y0iH2+COq4/Kh6srm
 Y2O7clwIZKiNqKuHwKBgIFsAkd5J8fcR8yaJgUwLbrKr0pKMWAuaFk7Phohq2IFXUyXYfN/N/2
 iSTz4+ai36LEIGSV87BcgYOXrFiaM0QL67o1tzgReQjIZ68dowmcICxszOdkFs1EJrtq/koTin
 ka69bIYwlIPq/auQ3+9WyefStLqwU8Fx2J6d60hX/E8C0Ztc7h98DwredFwr1s/P16StWpj421
 c8JaZgggqXNrN0PGOJlAP3o0pwe7jYgu147JxCU1/ept8Dsg==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In the commit 0bfd91d57863, the behaviour of the tty::restore was
changed so that the console mode is set to the previouslly stored
console mode. Therefore, the console mode for the background non-
cygwin app should not be set to tty::restore anymore in setup_for_
non_cygwin_app(). This should have been fixed in that commit.
This patch belatedly fixes it.

Fixes: 0bfd91d57863 ("Cygwin: console: tty::restore really restores the previous mode")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/console.cc | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 16352d04d..5a55d122e 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -905,13 +905,14 @@ fhandler_console::setup_for_non_cygwin_app ()
   /* Setting-up console mode for non-cygwin app. */
   /* If conmode is set to tty::native for non-cygwin apps
      in background, tty settings of the shell is reflected
-     to the console mode of the app. So, use tty::restore
-     for background process instead. */
-  tty::cons_mode conmode =
-    (get_ttyp ()->getpgid ()== myself->pgid) ? tty::native : tty::restore;
-  set_input_mode (conmode, &tc ()->ti, get_handle_set ());
-  set_output_mode (conmode, &tc ()->ti, get_handle_set ());
-  set_disable_master_thread (true, this);
+     to the console mode of the app. So, do not change the
+     console mode. */
+  if (get_ttyp ()->getpgid () == myself->pgid)
+    {
+      set_input_mode (tty::native, &tc ()->ti, get_handle_set ());
+      set_output_mode (tty::native, &tc ()->ti, get_handle_set ());
+      set_disable_master_thread (true, this);
+    }
 }
 
 void
-- 
2.45.1

