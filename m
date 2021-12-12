Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id CAA08385801D
 for <cygwin-patches@cygwin.com>; Sun, 12 Dec 2021 13:05:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org CAA08385801D
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 1BCD59Ui022149;
 Sun, 12 Dec 2021 22:05:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 1BCD59Ui022149
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1639314321;
 bh=fs6ahzQ24ubhDgPGbJIE9yuNqQ5KEjZNB4KRCOlkDPk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nfmNkdHqxVX0EO24FiSZ/G3g2Cm3JlB31RgPctGLu8ZYReOezL6t1mrjn4n40oNBI
 T1Gr1zpxhU792qMydOpaiAOYUNXYN/QxGK03o/1vpkl9kvttrfCwoKNxvDC/ZxZ6Yx
 Z4CCwaayz4t6YyLzqCKwCG3HXCVreWy8aTxKl2GEqDtyyEMtUCyqc6RcD0kNBs8XUb
 BrdZt5WIibHXyqC3dg/JwmFU1x9AE3Xq8SIk4/RBa/ZPcUzUZNvNwRSVkdbxjZcbcY
 PpcClhngDIbTsjQNgIjWfKdIsYQuhAirZAL36RUjpEOMj+Mxq5xNKnoGdyFAESLBzq
 GOTqusDAp8q5g==
X-Nifty-SrcIP: [110.4.221.123]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 3/3] Cygwin: console: Fix console mode of non-cygwin apps in
 background.
Date: Sun, 12 Dec 2021 22:05:01 +0900
Message-Id: <20211212130501.10091-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211212130501.10091-1-takashi.yano@nifty.ne.jp>
References: <20211212130501.10091-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sun, 12 Dec 2021 13:05:41 -0000

- If the non-cygwin app is started in the background in console, the
  console mode is broken for the app. This patch fixes the issue.
---
 winsup/cygwin/spawn.cc | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index e160fa3bb..465fb5fc3 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -631,11 +631,14 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 		      cons_ti = &((tty *)cons->tc ())->ti;
 		      cons_owner = cons->get_owner ();
 		    }
+		  tty::cons_mode conmode =
+		    (ctty_pgid && ctty_pgid == myself->pgid) ?
+		    tty::native : tty::restore;
 		  if (fd == 0)
-		    fhandler_console::set_input_mode (tty::native,
+		    fhandler_console::set_input_mode (conmode,
 					   cons_ti, cons->get_handle_set ());
 		  else if (fd == 1 || fd == 2)
-		    fhandler_console::set_output_mode (tty::native,
+		    fhandler_console::set_output_mode (conmode,
 					   cons_ti, cons->get_handle_set ());
 		}
 	    }
-- 
2.34.1

