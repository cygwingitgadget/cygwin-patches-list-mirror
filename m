Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-01.nifty.com (conuserg-01.nifty.com [210.131.2.68])
 by sourceware.org (Postfix) with ESMTPS id B4E44393FC2C
 for <cygwin-patches@cygwin.com>; Fri, 13 Mar 2020 03:07:14 +0000 (GMT)
Received: from localhost.localdomain
 (ntsitm194054.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.205.54]) (authenticated)
 by conuserg-01.nifty.com with ESMTP id 02D36pEG018687;
 Fri, 13 Mar 2020 12:06:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-01.nifty.com 02D36pEG018687
X-Nifty-SrcIP: [125.0.205.54]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Add FreeConsole to destructor of pty slave.
Date: Fri, 13 Mar 2020 12:06:49 +0900
Message-Id: <20200313030649.874-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-27.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, GIT_PATCH_1,
 GIT_PATCH_2, GIT_PATCH_3, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE,
 SPF_PASS autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin-patches mailing list <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <http://cygwin.com/pipermail/cygwin-patches/>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Fri, 13 Mar 2020 03:07:15 -0000

- When pseudo console is closed, all the processes attched to the
  pseudo console are terminated. This causes the problem reported
  in https://sourceware.org/pipermail/cygwin/2020-March/244046.html.
  This patch fixes the issue.
---
 winsup/cygwin/fhandler_tty.cc | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index b42e0aeb6..b2e725d5d 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -706,8 +706,15 @@ fhandler_pty_slave::fhandler_pty_slave (int unit)
 fhandler_pty_slave::~fhandler_pty_slave ()
 {
   if (!get_ttyp ())
-    /* Why comes here? Who clears _tc? */
-    return;
+    {
+      /* Why comes here? Who clears _tc? */
+      if (freeconsole_on_close)
+	{
+	  FreeConsole ();
+	  pcon_attached_to = -1;
+	}
+      return;
+    }
   if (get_pseudo_console ())
     {
       int used = 0;
-- 
2.21.0

