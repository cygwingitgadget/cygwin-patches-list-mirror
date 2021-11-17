Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id CA19C3858C27
 for <cygwin-patches@cygwin.com>; Wed, 17 Nov 2021 08:08:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org CA19C3858C27
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 1AH88PHH024689;
 Wed, 17 Nov 2021 17:08:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 1AH88PHH024689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1637136510;
 bh=0dNug70I8Fcy7gxBZqI1vfprQuVb4G8wMTGb5aYFxAQ=;
 h=From:To:Cc:Subject:Date:From;
 b=2HruPjxql09LhLPsh8Hhn5bkdr2pAzwBOCFeQtmIHvJaBsyRB4SB1scnjxjnctDUZ
 yofGScP3baEOYAEJnq9ruGBIfg48de2Z/xeU5poNnnC45hNdy723uL+Hgmykm8QyEY
 VfUARVTEG9aliRRw2tNkWisBm/GD9/bmmEC02e2pTb2dHmgd8GcHjBaanRjtyPk6s+
 9v6UZ8/ACcczedVNv43hEBDvhV33unlHGLhIzkAIBkIuoztZBFIH0FoShqFcs2Dz4E
 Och8I6mKPfQy5msTW2ZszJdNiEvaHfkRtX5I9XafZm/NoBNG2/qBSHsuc+JVPNMceA
 OEzXecaPG+Q0w==
X-Nifty-SrcIP: [110.4.221.123]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pipe: Suppress unnecessary set_pipe_non_blocking()
 call.
Date: Wed, 17 Nov 2021 17:08:27 +0900
Message-Id: <20211117080827.1800-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Wed, 17 Nov 2021 08:08:48 -0000

- Call set_pipe_non_blocking(false) only if the pipe will be really
  inherited to non-cygwin process.
---
 winsup/cygwin/spawn.cc | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 6b2026776..e160fa3bb 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -648,8 +648,9 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 
       if (!iscygwin ())
 	{
+	  int fd;
 	  cfd.rewind ();
-	  while (cfd.next () >= 0)
+	  while ((fd = cfd.next ()) >= 0)
 	    if (cfd->get_major () == DEV_PTYS_MAJOR)
 	      {
 		fhandler_pty_slave *ptys =
@@ -657,13 +658,15 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 		ptys->create_invisible_console ();
 		ptys->setup_locale ();
 	      }
-	    else if (cfd->get_dev () == FH_PIPEW)
+	    else if (cfd->get_dev () == FH_PIPEW
+		     && (fd == (in__stdout < 0 ? 1 : in__stdout) || fd == 2))
 	      {
 		fhandler_pipe *pipe = (fhandler_pipe *)(fhandler_base *) cfd;
 		pipe->close_query_handle ();
 		pipe->set_pipe_non_blocking (false);
 	      }
-	    else if (cfd->get_dev () == FH_PIPER)
+	    else if (cfd->get_dev () == FH_PIPER
+		     && fd == (in__stdin < 0 ? 0 : in__stdin))
 	      {
 		fhandler_pipe *pipe = (fhandler_pipe *)(fhandler_base *) cfd;
 		pipe->set_pipe_non_blocking (false);
-- 
2.33.0

