Return-Path: <SRS0=T8Jq=CP=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1009.nifty.com (mta-snd01012.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:2c])
	by sourceware.org (Postfix) with ESMTPS id 910113858D35
	for <cygwin-patches@cygwin.com>; Tue, 27 Jun 2023 13:28:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 910113858D35
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain by dmta1009.nifty.com with ESMTP
          id <20230627132843393.LZEZ.19111.localhost.localdomain@nifty.com>;
          Tue, 27 Jun 2023 22:28:43 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Bruce Jerrick <bmj001@gmail.com>
Subject: [PATCH] Cygwin: dtable: Delete old kludge code for /dev/tty.
Date: Tue, 27 Jun 2023 22:28:26 +0900
Message-Id: <20230627132826.9321-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This old kludge code assigns fhandler_console for /dev/tty even
if the CTTY is not a console when stat() has been called. Due to
this, the problem reported in
https://cygwin.com/pipermail/cygwin/2023-June/253888.html
occurs after the commit 3721a756b0d8 ("Cygwin: console: Make the
console accessible from other terminals.").

This patch fixes the issue by dropping the old kludge code.

Reported-by: Bruce Jerrick <bmj001@gmail.com>
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

