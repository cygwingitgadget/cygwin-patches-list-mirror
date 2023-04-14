Return-Path: <SRS0=xQVb=AF=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
	by sourceware.org (Postfix) with ESMTPS id C7EB33858D20
	for <cygwin-patches@cygwin.com>; Fri, 14 Apr 2023 03:30:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C7EB33858D20
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (aj135041.dynamic.ppp.asahi-net.or.jp [220.150.135.41]) (authenticated)
	by conuserg-11.nifty.com with ESMTP id 33E3TaT9020568;
	Fri, 14 Apr 2023 12:29:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 33E3TaT9020568
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1681442983;
	bh=mSnL2u86T+M+DbpUNbqnbhsfSH5x7vt3Q6KibNduQl4=;
	h=From:To:Cc:Subject:Date:From;
	b=QcEjZUsF6sX45PmFpjtKBMNLB3b6VaE3SBZN6Nr14y20x8U7jmz2oI2w2NCtpwHUR
	 gtZVOn3W74sbrlyiLsjm2xUUcKs86TNpKFZdViNMHBmYzh5SO/qJTjo2J5//1TYfb8
	 K3/mE5Cj4L+R9Vt0koSVU0YXsoUjd8KuY3rm+bp5gvCgKBZhVIt2LTktsBDMcqaBu3
	 0eD5sEG+8udk7lJGtnVZvcrpRmQytABa+pQAR3MO/xOMlO1UE10I71S552V5meCKfg
	 R9ZfW2wl7Lz2FQ0v8ZLjX3jwU8lyD4XjcB5SHAiVLJP/vYT2GUEHHc8mabd/Rqko6I
	 OR97R/HDqu1Lw==
X-Nifty-SrcIP: [220.150.135.41]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
        Wladislav Artsimovich <cygwin@frost.kiwi>
Subject: [PATCH] Cygwin: pty: Fix reading CONIN$ when stdin is not a pty.
Date: Fri, 14 Apr 2023 12:29:22 +0900
Message-Id: <20230414032923.1774-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, the pty master sends inputs to the pipe for cygwin app
even when pseudo console is activated if stdin is not the pty.
This causes the problem that key input is not sent to non cygwin
app even if the app opens CONIN$. This patch sets switch_to_nat_pipe
to true regardless whether stdin is the pty or not to allow that case.

https://cygwin.com/pipermail/cygwin/2023-April/253424.html

Reported-by: Wladislav Artsimovich <cygwin@frost.kiwi>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pty.cc | 6 ++++++
 winsup/cygwin/release/3.4.7   | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 664d7dbc6..03c859172 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -3222,6 +3222,11 @@ fhandler_pty_slave::setup_pseudoconsole ()
       return false;
     }
 
+  /* Set switch_to_nat_pipe regardless whether stdin is the pty or not
+     so that the non-cygwin app can work when it opens CONIN$. */
+  bool switch_to_nat_pipe_orig = get_ttyp ()->switch_to_nat_pipe;
+  get_ttyp ()->switch_to_nat_pipe = true;
+
   HANDLE hpConIn, hpConOut;
   if (get_ttyp ()->pcon_activated)
     { /* The pseudo console is already activated. */
@@ -3499,6 +3504,7 @@ cleanup_pseudo_console:
       CloseHandle (tmp);
     }
 fallback:
+  get_ttyp ()->switch_to_nat_pipe = switch_to_nat_pipe_orig;
   return false;
 }
 
diff --git a/winsup/cygwin/release/3.4.7 b/winsup/cygwin/release/3.4.7
index 2c305ec5f..94410c678 100644
--- a/winsup/cygwin/release/3.4.7
+++ b/winsup/cygwin/release/3.4.7
@@ -9,3 +9,6 @@ Bug Fixes
 
 - Align behaviour of dirname in terms of leading slashes to POSIX:
   https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap04.html
+
+- Fix reading CONIN$ in non cygwin apps when stdin is not a pty.
+  Addresses https://cygwin.com/pipermail/cygwin/2023-April/253424.html
-- 
2.39.0

