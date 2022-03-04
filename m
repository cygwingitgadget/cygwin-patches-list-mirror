Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id 07BDD3857C5A
 for <cygwin-patches@cygwin.com>; Fri,  4 Mar 2022 13:33:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 07BDD3857C5A
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 224DX4oL017123;
 Fri, 4 Mar 2022 22:33:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 224DX4oL017123
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1646400795;
 bh=oXdLwHeXAvUKF/1yqWY3MlAzMISYSFb/nmGo7tzUTLk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VsE4aWLteDIJPSQLxAPREYLN3HlQgqS/iWBjS9ecK7tZVo4CVWQFtsRFxI9y60PW3
 pUdOpEL2fwYRhWl3dYEkHIhgkcZ6rLsZscGmunWdiUPmeubWPMZKc4XyMag+Pqt5jL
 NfJQaUxe4lvluTdGLXopXRiLS1fgPi+bvGVmK/dq5iXyZsPELAy5H2vrBLpjSju2Rk
 afzhKFUI0sQSf5+v9JGU2Rf6/y9dW4ifW7A7V03UXd0fE4U9wI9zVpwZQ19SGjZ28O
 Tt1Jdu16MEKkXb4uijtj+l4l+gCBuHySvY5EssSOyHb3Ph1sBhq9r7XJ+60a9GZSdD
 HS14MgNem65Pw==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Fix a possible race issue in initialization of
 pcon.
Date: Fri,  4 Mar 2022 22:32:57 +0900
Message-Id: <20220304133257.1204-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304133257.1204-1-takashi.yano@nifty.ne.jp>
References: <20220304133257.1204-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_PASS, TXREP,
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
X-List-Received-Date: Fri, 04 Mar 2022 13:33:32 -0000

- Currently, tty::pcon_start flag is cleared before transfer_input()
  in master::write(), however, the code in setup_pseudoconsole()
  waits for transfer_input() using tty::pcon_start. This possibly
  causes the race issue. The patch fixes this potential issue.
---
 winsup/cygwin/fhandler_tty.cc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index cba25ee84..3ed84709e 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -3215,7 +3215,8 @@ fhandler_pty_slave::setup_pseudoconsole ()
 	  get_ttyp ()->pcon_start_pid = myself->pid;
 	  WriteFile (get_output_handle (), "\033[6n", 4, &n, NULL);
 	  ReleaseMutex (input_mutex);
-	  while (get_ttyp ()->pcon_start)
+	  while (get_ttyp ()->pcon_start_pid)
+	    /* wait for completion of transfer_input() in master::write(). */
 	    Sleep (1);
 	}
       /* Attach to the pseudo console which already exits. */
-- 
2.35.1

