Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id F1249385DC1F
 for <cygwin-patches@cygwin.com>; Sun, 17 May 2020 02:33:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org F1249385DC1F
Received: from localhost.localdomain (v040007.dynamic.ppp.asahi-net.or.jp
 [124.155.40.7]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 04H2XNOG030395;
 Sun, 17 May 2020 11:33:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 04H2XNOG030395
X-Nifty-SrcIP: [124.155.40.7]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Call FreeConsole() only if attached to current
 pty.
Date: Sun, 17 May 2020 11:34:04 +0900
Message-Id: <20200517023404.240-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sun, 17 May 2020 02:33:48 -0000

- After commit 071b8e0cbd4be33449c12bb0d58f514ed8ef893c, the problem
  reported in https://cygwin.com/pipermail/cygwin/2020-May/244873.html
  occurs. This is due to freeing console device accidentally rather
  than pseudo console. This patch makes sure to call FreeConsole()
  only if the process is attached to the pseudo console of the current
  pty.
---
 winsup/cygwin/fhandler_tty.cc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 8547ec7c4..467784255 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -708,7 +708,7 @@ fhandler_pty_slave::~fhandler_pty_slave ()
   if (!get_ttyp ())
     {
       /* Why comes here? Who clears _tc? */
-      if (freeconsole_on_close)
+      if (freeconsole_on_close && get_minor () == pcon_attached_to)
 	{
 	  FreeConsole ();
 	  pcon_attached_to = -1;
@@ -739,7 +739,7 @@ fhandler_pty_slave::~fhandler_pty_slave ()
       if (used == 0)
 	{
 	  init_console_handler (false);
-	  if (freeconsole_on_close)
+	  if (freeconsole_on_close && get_minor () == pcon_attached_to)
 	    {
 	      FreeConsole ();
 	      pcon_attached_to = -1;
@@ -3006,7 +3006,7 @@ fhandler_pty_slave::fixup_after_exec ()
       if (used == 1 /* About to close this tty */)
 	{
 	  init_console_handler (false);
-	  if (freeconsole_on_close)
+	  if (freeconsole_on_close && get_minor () == pcon_attached_to)
 	    {
 	      FreeConsole ();
 	      pcon_attached_to = -1;
-- 
2.21.0

