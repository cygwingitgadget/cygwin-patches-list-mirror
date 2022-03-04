Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id E41C03858D39
 for <cygwin-patches@cygwin.com>; Fri,  4 Mar 2022 11:06:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org E41C03858D39
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 224B64YN017871;
 Fri, 4 Mar 2022 20:06:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 224B64YN017871
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1646391971;
 bh=6zkBFvavubOHydq0Q5zP4TNK3BbmqbNQtSqThWzETN4=;
 h=From:To:Cc:Subject:Date:From;
 b=gsIz3NPMZzK7JATp+N8fZtPA/y6Zjb9D1tuZ2z8xRGvymuA7m48xl1j/Qu5Cr+vBa
 PbCnKiUZsLv5b2YdPtzuayO3lKkV1wsqP25FoPwSFW+Hee53Cfl8t3VJWdYOk/Z21g
 gHy10N50fZigHfxld3igw7qWwgypKsOCWfND+WmmwTW0zjs4MypW7F41SWcCfHi6R3
 wgPHVySHEYe6djVNmsfNNdoPeG/EddHK26ep+AJtpj5FfynDV7t+riktYXMhgBb1GT
 YHGipmlF3OxFZZjcLh1roC9rpjHd0mDX03E27IvzJ23ivlp+pSgDT9gRzfOPS3eH7S
 MAu4kxQ2ErGow==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Treat both CR and NL as line feed in
 transfer_inpup().
Date: Fri,  4 Mar 2022 20:05:54 +0900
Message-Id: <20220304110556.2139-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
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
X-List-Received-Date: Fri, 04 Mar 2022 11:06:28 -0000

- To make read() work properly in canonical mode, writing to the pty
  pipe should be done line by line. However, only CR was treated as
  line separator previously in transfer_input(). This patch fixes
  the issue.
---
 winsup/cygwin/fhandler_tty.cc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 2f13e9990..76c5e2413 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -3938,9 +3938,11 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
 	    }
 	  /* Call WriteFile() line by line */
 	  char *p0 = ptr;
-	  char *p1 = ptr;
-	  while ((p1 = (char *) memchr (p0, '\r', len - (p0 - ptr))))
+	  char *p_cr, *p_nl;
+	  while ((p_cr = (char *) memchr (p0, '\r', len - (p0 - ptr)))
+		 || (p_nl = (char *) memchr (p0, '\n', len - (p0 - ptr))))
 	    {
+	      char *p1 = p_cr ? (p_nl ? min (p_cr, p_nl) : p_cr) : p_nl;
 	      *p1 = '\n';
 	      n = p1 - p0 + 1;
 	      if (n && WriteFile (to, p0, n, &n, NULL) && n)
-- 
2.35.1

