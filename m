Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id D2DD83857C4E
 for <cygwin-patches@cygwin.com>; Sun, 13 Feb 2022 14:40:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org D2DD83857C4E
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 21DEdOvT000575;
 Sun, 13 Feb 2022 23:40:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 21DEdOvT000575
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1644763203;
 bh=Ra0QlISZkTGqXLOwxcjKKYtMglUEQymeBEdd0wkylHE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZeQvz5jpRMGEG/wEDG1Naa824upu8MZmTrpWafAQ+PcrwzQjMdwWQDaaO42ITtZLc
 Q365MEnyZ0vebKivLciPQJLAWQavP56olLv6W86Cz+15o9+cyl5wgye8lrg3E9+6rD
 MvzGq0PSwbv3HIg1Ch25zFi93RQfM5UKYbWCUaNH7vLHuvTA51WJDSvu7askwanYrZ
 tCqNx689oM20VvC/mtnb8uN7LZoUvBKXR8B/2cxRDrB5I1t84oO+LrmkJ+fwWQg3mq
 QXb0jlqDxrgz5m71spMmnXc6qa74PcWRqMT8bb7PKBdFam8pXst0zGGrCCbGi5Rr29
 h63Tc9YqKYSYA==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 8/8] Cygwin: console: Set console mode even if stdin/stdout is
 redirected.
Date: Sun, 13 Feb 2022 23:39:10 +0900
Message-Id: <20220213143910.1947-9-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220213143910.1947-1-takashi.yano@nifty.ne.jp>
References: <20220213143910.1947-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sun, 13 Feb 2022 14:40:21 -0000

- When non-cygwin app is started in console, console mode is set to
  tty::native. However, if stdin is redirected, current code does not
  set the input mode of the console. In this case, if the app opens
  "CONIN$", the console mode will not be appropriate for non-cygwin
  app. This patch fixes the issue.

Addresses:
https://github.com/GitCredentialManager/git-credential-manager/issues/576
---
 winsup/cygwin/spawn.cc | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 81dba5a94..a7e25cc20 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -627,23 +627,18 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	    }
 	  else if (fh && fh->get_major () == DEV_CONS_MAJOR)
 	    {
-	      fhandler_console *cons = (fhandler_console *) fh;
-	      if (!iscygwin ())
+	      if (!iscygwin () && cons_native == NULL)
 		{
-		  if (cons_native == NULL)
-		    {
-		      cons_native = cons;
-		      cons_ti = &((tty *)cons->tc ())->ti;
-		      cons_owner = cons->get_owner ();
-		    }
+		  fhandler_console *cons = (fhandler_console *) fh;
+		  cons_native = cons;
+		  cons_ti = &((tty *)cons->tc ())->ti;
+		  cons_owner = cons->get_owner ();
 		  tty::cons_mode conmode =
 		    (ctty_pgid && ctty_pgid == myself->pgid) ?
 		    tty::native : tty::restore;
-		  if (fd == 0)
-		    fhandler_console::set_input_mode (conmode,
+		  fhandler_console::set_input_mode (conmode,
 					   cons_ti, cons->get_handle_set ());
-		  else if (fd == 1 || fd == 2)
-		    fhandler_console::set_output_mode (conmode,
+		  fhandler_console::set_output_mode (conmode,
 					   cons_ti, cons->get_handle_set ());
 		}
 	    }
-- 
2.35.1

