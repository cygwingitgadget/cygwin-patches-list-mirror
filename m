Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id F3A873858412
 for <cygwin-patches@cygwin.com>; Sun, 13 Feb 2022 14:40:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org F3A873858412
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 21DEdOvP000575;
 Sun, 13 Feb 2022 23:39:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 21DEdOvP000575
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1644763199;
 bh=fuEOQlOKMIL7O7MO6yBl08txHHPSQtVjNzTInXSq0E8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=izCKbCxEj0rCoiS3LBUNOzLfj1l/nGlH4rycc5I/9ixz+AeFdQ2KvllcjwSEzl0cR
 NqIqTMUY2tzJMT8XWvLXtdSWNcX8IB0kn3rTmjAJ/hd8+yI9reB8OmWjgqw2R3TuZv
 LlL+A0xVLj085vPVal5ZbHkk3hdlfGiVLL/qcvDuTO9BZihqzLrIntIceSOwHq1K15
 QYeTFtPSy38Nj2SGEf1RnrXct0UHJle6X/ZjHctzRAhVNNq2/9cLnX9DC8phKs79bW
 Ci+rB/TyWwSxEBQPeTgnkJha8ll1Brg9/RKXWcVMN3ue9LVYmGuage58IeHyJmD/VI
 SA5BRCqW3H29g==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 6/8] Cygwin: pty: Fix a bug in tty_min::segpgid().
Date: Sun, 13 Feb 2022 23:39:08 +0900
Message-Id: <20220213143910.1947-7-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220213143910.1947-1-takashi.yano@nifty.ne.jp>
References: <20220213143910.1947-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sun, 13 Feb 2022 14:40:15 -0000

- In tty_min::setpgid(), a pointer to fhandler instance is casted to
  fhandler_pty_slave and accessed even if terminal is not a pty slave.
  This patch fixes the issue.
---
 winsup/cygwin/tty.cc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index da75b8dd2..c0015aceb 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -309,7 +309,8 @@ tty_min::setpgid (int pid)
   fhandler_pty_slave *ptys = NULL;
   cygheap_fdenum cfd (false);
   while (cfd.next () >= 0 && ptys == NULL)
-    if (cfd->get_device () == getntty ())
+    if (cfd->get_device () == getntty ()
+	&& cfd->get_major () == DEV_PTYS_MAJOR)
       ptys = (fhandler_pty_slave *) (fhandler_base *) cfd;
 
   if (ptys)
-- 
2.35.1

