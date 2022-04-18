Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id D895B3858D28
 for <cygwin-patches@cygwin.com>; Mon, 18 Apr 2022 11:50:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org D895B3858D28
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 23IBo55h020260;
 Mon, 18 Apr 2022 20:50:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 23IBo55h020260
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1650282614;
 bh=q2ORqI/Dg8K7FXat1sFTBi0wZbgdeAL8zGT1cq3CiQk=;
 h=From:To:Cc:Subject:Date:From;
 b=BmWAms1On1Q813TgOVnCsyMqvX7Q4IzwRlVaxjvSGrUkm5mpRccTkXj1Dkg2F6ban
 2zPJ429v9T7OgfcfywK25J64tEvNWnQTfLwdmDJoxoyy6ZO1qagzgbXWAVYLvvviuW
 HDbYwzOQuzwd1/DcJe99WRlrXXVtrFPFeCsaASxHurGx5NQzE/qIe9Gd81P2ZRIVC+
 V5CES9Q5q98N0fl/JttpctK5JWjkglaJ2xcr/vFbIM8xSIYumJVEFllL6Xm5IeQ1lP
 qbBoesDCIOVDtZ24iMZqiNQbdvNr+Evgb5wv+8YlZaatWc4qO4d4dfDUAYWSaIjs5h
 KYZE6FPn7dGCg==
X-Nifty-SrcIP: [119.150.44.95]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Fix deadlock caused by Ctrl-C in
 setup_pseudoconsole().
Date: Mon, 18 Apr 2022 20:49:58 +0900
Message-Id: <20220418114958.28630-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Mon, 18 Apr 2022 11:50:42 -0000

- If Ctrl-C is pressed just after setup_pseudoconsole() is called,
  mintty stops to respond a while when CPU load is high. This patch
  fixes the issue.

Addresses: https://cygwin.com/pipermail/cygwin/2022-April/251272.html
---
 winsup/cygwin/spawn.cc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 400457117..c9e1fb6d2 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -679,8 +679,12 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	  HANDLE h_stdin = handle (fileno_stdin, false);
 	  if (h_stdin == ptys_primary->get_handle_nat ())
 	    stdin_is_ptys = true;
+	  if (reset_sendsig)
+	    myself->sendsig = myself->exec_sendsig;
 	  ptys_primary->setup_for_non_cygwin_app (nopcon, envblock,
 						  stdin_is_ptys);
+	  if (reset_sendsig)
+	    myself->sendsig = NULL;
 	  ptys_primary->get_duplicated_handle_set (&ptys_handle_set);
 	  ptys_ttyp = (tty *) ptys_primary->tc ();
 	  ptys_need_cleanup = true;
-- 
2.35.1

