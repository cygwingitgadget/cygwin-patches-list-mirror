Return-Path: <SRS0=AW+g=CK=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1018.nifty.com (mta-snd01001.nifty.com [106.153.227.33])
	by sourceware.org (Postfix) with ESMTPS id B437C3858D35
	for <cygwin-patches@cygwin.com>; Thu, 22 Jun 2023 15:30:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B437C3858D35
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain by dmta1018.nifty.com with ESMTP
          id <20230622153023174.VYAB.25681.localhost.localdomain@nifty.com>;
          Fri, 23 Jun 2023 00:30:23 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	=?UTF-8?q?M=C3=BCmin=20A=20=2E?= <muminaydin06@gmail.com>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH] Cygwin: thread: Reset _my_tls.tid if it's pthread_null in init_mainthread().
Date: Fri, 23 Jun 2023 00:30:08 +0900
Message-Id: <20230622153008.392-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently, _my_tls.tid is set to pthread_null if pthread::self()
is called before pthread::init_mainthread(). As a result, pthread::
init_mainthread() does not set _my_tls.tid appropriately. Due to
this, pthread_join() fails in LDAP environment if the program is
the first program which loads cygwin1.dll.

https://cygwin.com/pipermail/cygwin/2023-June/253792.html

With this patch, _my_tls.tid is re-initialized in pthread::
init_mainthread() if it is pthread_null.

Reported-by: Mümin A. <muminaydin06@gmail.com>
Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/thread.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
index 5c1284a93..f614e01c4 100644
--- a/winsup/cygwin/thread.cc
+++ b/winsup/cygwin/thread.cc
@@ -364,7 +364,7 @@ void
 pthread::init_mainthread ()
 {
   pthread *thread = _my_tls.tid;
-  if (!thread)
+  if (!thread || thread == pthread_null::get_null_pthread ())
     {
       thread = new pthread ();
       if (!thread)
-- 
2.39.0

