Return-Path: <SRS0=QiAG=JL=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1019.nifty.com (mta-snd01012.nifty.com [106.153.227.44])
	by sourceware.org (Postfix) with ESMTPS id 06ED83857C4B
	for <cygwin-patches@cygwin.com>; Fri,  2 Feb 2024 16:18:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 06ED83857C4B
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 06ED83857C4B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.44
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1706890730; cv=none;
	b=nZ86slg9trAyMDcgWAt0aQ00k+CHp9vDHcBEVA4UPqlsxYO+0l9GlHSxHUZFAC6LiPy6+qB8nPwbjhJvZXpAqJpTodaK2NAFzlDqPc1IFusf59hOIu/IWLHbCkh9KE68rHzjjLfp4F3BMCTuy1J0qob1ULtFhZzduorY4SFbRJk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1706890730; c=relaxed/simple;
	bh=tH52+9IDUgsWxlBkpEfX3iaGxfDtw4vutPjR7JkSu+c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Hld/JkWqrMK2Ci8dqFH2r4+3vJFXg8VMCipsggp0ECodzWP3vKRbGFiGprHxHE6Blnk9RRlBNWLh1WzfGzwi/KEHdhafxlYbNCXuzi9qQg+v71VNkrvyvF6uy8mYFTzVOHFcgxHOPPYwbciBErdR099NcaFKLvVnz+iFFbSXCLY=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by dmta1019.nifty.com with ESMTP
          id <20240202161844749.LQRW.96055.localhost.localdomain@nifty.com>;
          Sat, 3 Feb 2024 01:18:44 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Avoid slipping past disable_master_thread check.
Date: Sat,  3 Feb 2024 01:18:15 +0900
Message-ID: <20240202161827.1847-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If disable_master_thread flag is set between the code checking that
flag not be set and the code acquiring input_mutex, input record is
processed once after setting disable_master_thread flag. This patch
prevents that.

Fixes: d4aacd50e6cf ("Cygwin: console: Add missing input_mutex guard.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/console.cc | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 6a42b4949..1c8d383cd 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -420,6 +420,12 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 	}
 
       WaitForSingleObject (p->input_mutex, mutex_timeout);
+      /* Ensure accessing input recored is not disabled. */
+      if (con.disable_master_thread)
+	{
+	  ReleaseMutex (p->input_mutex);
+	  continue;
+	}
       total_read = 0;
       switch (cygwait (p->input_handle, (DWORD) 0))
 	{
@@ -4545,8 +4551,6 @@ fhandler_console::set_disable_master_thread (bool x, fhandler_console *cons)
 	return;
     }
   const _minor_t unit = cons->get_minor ();
-  if (con.disable_master_thread == x)
-    return;
   cons->acquire_input_mutex (mutex_timeout);
   con.disable_master_thread = x;
   cons->release_input_mutex ();
-- 
2.43.0

