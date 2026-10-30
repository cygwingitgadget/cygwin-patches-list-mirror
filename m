Return-Path: <SRS0=PQXH=IU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.227.117])
	by sourceware.org (Postfix) with ESMTPS id 89B9C4BA23C3
	for <cygwin-patches@cygwin.com>; Fri, 30 Oct 2026 14:12:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 89B9C4BA23C3
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 89B9C4BA23C3
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.117
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1793369539; cv=none;
	b=HhBpj+S1RC06ht9yUjcwvJDvy1qVbqheBZT4zXLFWiA2yiYpPUGMJNNBMT24F+2l4HuyDGoBu8vFma7e1wOIPqgIKncYQjiwO/Uw4GxLfzD1VCk6lasnknFj+tghB0Y22KZw6KlyVrwaytYA/FbTqY/RkeKyxgKyiSaE9nM+Qbo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1793369539; c=relaxed/simple;
	bh=5tYu/YiYtXwHhesDPdBJtFlM5JB5YB+/gZsDnpSbGoo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=HkA+RSm4HOqJqV0Ap/EuKO8SGkew81sJj6HE/KulJ6Od2JsBP8J6s8lvRIjssmh4LNsgltWyn8XpKmEIEy+9RRfGfn1aXhCBf1iKowuUciI5p7a1SeUHdNhA5NJXMC8QuKsgkBrJPQdO89XLL3YVfUeS5vXh+4lU77SASwTSTRI=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=cWCzzfci
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 89B9C4BA23C3
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=cWCzzfci
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20261030141216246.HYXW.102121.HP-Z230@nifty.com>;
          Fri, 30 Oct 2026 23:12:16 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 1/2] Cygwin: console: Set ENABLE_PROCESSED_INPUT only when ISIG is set
Date: Fri, 30 Oct 2026 23:11:48 +0900
Message-ID: <20261030141207.12021-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1793369536;
 bh=d/9lKNWqiP5kJSY0wzs5Y7T3wtOiGc6jR3bbZ4EgDL0=;
 h=From:To:Cc:Subject:Date;
 b=cWCzzfcikXaMh3bNmsV2RVdpyTG3G60x3NEJ85XWdAatqJR1Aia+FlN7gpnT1Yv/plB+knWZ
 ukpoCjNpdpoqzJ5ZVnH/MssJFTLDVOnYvYlT8ElKUNfC8ffZVuzpAfIF/ujSSQbGYRdi3Z9Eyb
 b715qGJZHQnf5VGwYTE1BrS/ngNYKOwGGuDV/XfbTaG/H4C8XRUWghvXbJtiYiguEZ5AV3Ttw8
 gXWP/NNB5QkWUaMwonl/zah2ErDvjliOOoKT2zPJq6Wb/EnGWb6GqxlEFU6rY10f8FFZZ4GGQj
 /mxllxnyHay3J6Ajwz3hUZB2DUNZt1qU8rTu7vlXuykRav+g==
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently, ENABLE_PROCESSED_INPUT flag is set in the situations
where cons_master_thread does not handle signal keys regardless
of the ISIG flag setting. However, this should be set only when
ISIG flag is set because Ctrl-C should not be handled if ISIG
flag is cleared.

Fixes: a3dd824af832 ("Cygwin: console: Fix undesired mode change at exit of non-cygwin apps")
Fixes: 746c8116dd4f ("Cygwin: console: Allow pasting very long text input.");
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/console.cc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 71a502c12..41489bd7c 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -902,6 +902,8 @@ fhandler_console::fix_input_mode_if_necessary ()
   bool need_processed_input =
     con.master_thread_suspended || con.disable_master_thread
     || con.need_win32_input_mode_fix || master_thread_unavailable (unit);
+  if (!(get_ttyp ()->ti.c_lflag & ISIG))
+    need_processed_input = false;
   if (need_processed_input == con.is_processed_input)
     {
       ReleaseMutex (cons_mode_mutex);
@@ -953,7 +955,7 @@ fhandler_console::set_input_mode (tty::cons_mode m, const termios *t,
       need_processed_input =
 	con.master_thread_suspended || con.disable_master_thread
 	|| con.need_win32_input_mode_fix || master_thread_unavailable (unit);
-      if (need_processed_input)
+      if (need_processed_input && (t->c_lflag & ISIG))
 	flags |= ENABLE_PROCESSED_INPUT;
       if (wincap.has_con_24bit_colors () && !con_is_legacy)
 	flags |= ENABLE_VIRTUAL_TERMINAL_INPUT;
-- 
2.51.0

