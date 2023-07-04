Return-Path: <SRS0=VUiZ=CW=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1010.nifty.com (mta-snd01004.nifty.com [106.153.227.36])
	by sourceware.org (Postfix) with ESMTPS id 15D393858D35
	for <cygwin-patches@cygwin.com>; Tue,  4 Jul 2023 10:03:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 15D393858D35
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain by dmta1010.nifty.com with ESMTP
          id <20230704100355841.CFJT.19104.localhost.localdomain@nifty.com>;
          Tue, 4 Jul 2023 19:03:55 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Bruce Jerrick <bmj001@gmail.com>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v2] Cygwin: dtable: Delete old kludge code for /dev/tty.
Date: Tue,  4 Jul 2023 19:03:38 +0900
Message-Id: <20230704100338.255-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This old kludge code assigns fhandler_console for /dev/tty even
if the CTTY is not a console when stat() has been called. Due to
this, the problem reported in
https://cygwin.com/pipermail/cygwin/2023-June/253888.html
occurs after the commit 3721a756b0d8 ("Cygwin: console: Make the
console accessible from other terminals.").

This patch fixes the issue by dropping the old kludge code.

Though the exact reason why the kludge code was necessary is not
clear enough, this kluge code has no longer seemed to be necessary
after the commit 6ae28c22639d. This is because even when /dev/tty
is not opened, /dev/tty became able to be refered via last_tty_dev,
which was introduced by the commit 6ae28c22639d.

Fixes: 23771fa1f7028 ("dtable.cc (fh_alloc): Make different decisions
  when generating fhandler for not-opened devices. Add kludge to deal
  with opening /dev/tty.")
Reported-by: Bruce Jerrick <bmj001@gmail.com>
Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/dtable.cc | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
index 18e0f3097..9427e238e 100644
--- a/winsup/cygwin/dtable.cc
+++ b/winsup/cygwin/dtable.cc
@@ -598,12 +598,7 @@ fh_alloc (path_conv& pc)
 	  fh = cnew (fhandler_mqueue);
 	  break;
 	case FH_TTY:
-	  if (!pc.isopen ())
-	    {
-	      fhraw = cnew_no_ctor (fhandler_console, -1);
-	      debug_printf ("not called from open for /dev/tty");
-	    }
-	  else if (!CTTY_IS_VALID (myself->ctty) && last_tty_dev
+	  if (!CTTY_IS_VALID (myself->ctty) && last_tty_dev
 		   && !myself->set_ctty (fh_last_tty_dev, 0))
 	    debug_printf ("no /dev/tty assigned");
 	  else if (CTTY_IS_VALID (myself->ctty))
-- 
2.39.0

