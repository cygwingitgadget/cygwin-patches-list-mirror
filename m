Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id 1F6E43851C3E
 for <cygwin-patches@cygwin.com>; Sun, 17 May 2020 02:34:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 1F6E43851C3E
Received: from localhost.localdomain (v040007.dynamic.ppp.asahi-net.or.jp
 [124.155.40.7]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 04H2Y3Ov013716;
 Sun, 17 May 2020 11:34:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 04H2Y3Ov013716
X-Nifty-SrcIP: [124.155.40.7]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: termios: Set ECHOE, ECHOK,
 ECHOCTL and ECHOKE by default.
Date: Sun, 17 May 2020 11:34:44 +0900
Message-Id: <20200517023444.286-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sun, 17 May 2020 02:34:27 -0000

- Backspace key does not work correctly in linux session opend by
  ssh from cygwin console if the shell is bash. This is due to lack
  of these flags.

  Addresses: https://cygwin.com/pipermail/cygwin/2020-May/244837.html.
---
 winsup/cygwin/fhandler_termios.cc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_termios.cc
index b6759b0a7..b03478b87 100644
--- a/winsup/cygwin/fhandler_termios.cc
+++ b/winsup/cygwin/fhandler_termios.cc
@@ -33,7 +33,8 @@ fhandler_termios::tcinit (bool is_pty_master)
       tc ()->ti.c_iflag = BRKINT | ICRNL | IXON | IUTF8;
       tc ()->ti.c_oflag = OPOST | ONLCR;
       tc ()->ti.c_cflag = B38400 | CS8 | CREAD;
-      tc ()->ti.c_lflag = ISIG | ICANON | ECHO | IEXTEN;
+      tc ()->ti.c_lflag = ISIG | ICANON | ECHO | IEXTEN
+	| ECHOE | ECHOK | ECHOCTL | ECHOKE;
 
       tc ()->ti.c_cc[VDISCARD]	= CFLUSH;
       tc ()->ti.c_cc[VEOL]	= CEOL;
-- 
2.21.0

