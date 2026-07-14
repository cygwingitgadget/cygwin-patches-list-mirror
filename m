Return-Path: <SRS0=ihPJ=FI=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 57E9D4BA2E10
	for <cygwin-patches@cygwin.com>; Tue, 14 Jul 2026 06:00:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 57E9D4BA2E10
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 57E9D4BA2E10
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1784008811; cv=none;
	b=Ye8OoEOeUe9z0AsKnkEgqlYvFS2qfKYiClVcRBEaexxb2dprf8OydwRPEwjt+Z4NZxSNqD4VNK2lSG8BdsJm32neVS3OAdtjPHUiqyP5gwWbNrIBbLqJ2Z33z6FJhuwPxquFDFXFtDHaQsVATby6murwQ/7qBJ7o3/xPxs13JiE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784008811; c=relaxed/simple;
	bh=65A0jsbFBGD2lFstcVEhb89GDn2gc5Yy0xmsgxQjIN8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=MZulZVn1hFg8asHHaDvFjOr7Zsu6Od2SOKLwXDM5kNv3uHlGyXUZXNkJ1Q26uNRETiu6nv1NYMemII6k5vMhXWr1tYX0a8gyq1xFO9mtLrSBOLqliaM9BvxKFV5z28/bPxRpV0ICT1018ChmaPP7UfnYHPANEtBuHTjZlsimvZA=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=FTvrC+sm
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 57E9D4BA2E10
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=FTvrC+sm
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260714060006549.BRRJ.17441.HP-Z230@nifty.com>;
          Tue, 14 Jul 2026 15:00:06 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Fix undesired mode change at exit of non-cygwin apps
Date: Tue, 14 Jul 2026 14:59:42 +0900
Message-ID: <20260714055956.925-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1784008806;
 bh=5ZR0ogB1euW6OJAzGvI8KZxOdx1/IxMeV/qAQijG814=;
 h=From:To:Cc:Subject:Date;
 b=FTvrC+smauT5g6bcOHF8vT9Hx9+Dggu3yDYD5KCxZL1EgKQl7ia9gpK0ZWG2Qq26o8i2RKjG
 cJq+K2ObpqrEvQrAc/X7R/M+BtFFYBMhZBKPrCraKvW/Yl//juqqfDdNfDbHsiFEIZ7CHg0X5H
 BarGSjF9ZOUfdKcp1nvJtYLrXsDOJxqRasM5+5UjFtcI7K7DMW2Djti4DKVBc34sz/JDCoAyim
 UWOfxwmB6DpTsTFXqvpvbhySsymcuI2UJyNOgT77z2RU0nudpfE5hg9tChVm9akdeUh9f7t9z5
 n/NlBtM86a46zoUKWZLXb+Ox/QQgn8J9vC0ZOjH1KTbgzgqA==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, if two non-cygwin apps are started and one of them
exits first, the other one loosed appropriate console mode, since
the first one restored it to tty::cygwin. This patch introduce a
counter `non_cygwin_cnt` that counts the number of non-cygwin apps
currently running, and restores console mode only when the last
non-cygwin app exits.

Fixes: 29d8a8300812 ("Cygwin: console: Rearrange set_(in|out)put_mode() calls.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/console.cc       | 4 ++++
 winsup/cygwin/local_includes/fhandler.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index d4c87f29f..474e169ea 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -841,6 +841,7 @@ fhandler_console::setup ()
       con.num_processed = 0;
       con.curr_input_mode = tty::restore;
       con.curr_output_mode = tty::restore;
+      con.non_cygwin_cnt = 0;
     }
 }
 
@@ -975,6 +976,7 @@ fhandler_console::setup_for_non_cygwin_app ()
      in background, tty settings of the shell is reflected
      to the console mode of the app. So, do not change the
      console mode. */
+  InterlockedIncrement (&con.non_cygwin_cnt);
   if (get_ttyp ()->getpgid () == myself->pgid)
     {
       set_disable_master_thread (true, this);
@@ -987,6 +989,8 @@ void
 fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
 {
   const _minor_t unit = p->unit;
+  if (InterlockedDecrement (&con.non_cygwin_cnt) != 0)
+    return;
   termios dummy = {0, };
   termios *ti = shared_console_info[unit] ?
     &(shared_console_info[unit]->tty_min_state.ti) : &dummy;
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index d11b3ec4f..eafb7c581 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2082,6 +2082,7 @@ class dev_console
   DWORD owner;
   bool is_legacy;
   bool orig_virtual_terminal_processing_mode;
+  LONG non_cygwin_cnt;
 
   WORD default_color, underline_color, dim_color;
 
-- 
2.51.0

