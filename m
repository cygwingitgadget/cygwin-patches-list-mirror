Return-Path: <SRS0=/Ih6=67=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
	by sourceware.org (Postfix) with ESMTPS id ECCEF3858D39
	for <cygwin-patches@cygwin.com>; Tue,  7 Mar 2023 02:32:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org ECCEF3858D39
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (aj135041.dynamic.ppp.asahi-net.or.jp [220.150.135.41]) (authenticated)
	by conuserg-09.nifty.com with ESMTP id 3272W5cL027966;
	Tue, 7 Mar 2023 11:32:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 3272W5cL027966
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1678156338;
	bh=DTZe92sjfAXdcXSv3+YkEWDM2ZnEgIc/8F1AXoofKYQ=;
	h=From:To:Cc:Subject:Date:From;
	b=xJc4a531nQm5Cmc2P2TlMRKoPgIu6U4S3Zueu0a1mY7BD2sVXSkPHZIlVtEcQMyOa
	 EbgecJRVK+rjys2jRmzsdO8not/z+OralfLyRpZb4o8hfouqzKbI7wZGS9mDtvyUPB
	 +kfhPetKYACLR+2rKBaoztw3H3FGtXmraHug6HPv5lcjO+tF+ZGhMOKCQ91UbSKFqb
	 O690sNfT6SWvkIR7oiKSlOXKtMy/2WrOa97duyXoC6ytsB4fQCFQf/qxLf6L3YNY78
	 RgUeN3d+MClCiUZGJN9Soz96Kj0sYWJzPajVrCjvejHKxL6Y8ma+kLElzs7nNHD1rg
	 hgJWkLM+yt3sA==
X-Nifty-SrcIP: [220.150.135.41]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: ctty: Add missing fixup_after_{exec,fork}() call.
Date: Tue,  7 Mar 2023 11:31:57 +0900
Message-Id: <20230307023157.1170-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, fixup_after_{exec,fork}() calls for CTTY were missing.
This patch fixes that.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/dtable.cc           | 5 +++++
 winsup/cygwin/fhandler/console.cc | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
index 6b2394814..8ebd7b211 100644
--- a/winsup/cygwin/dtable.cc
+++ b/winsup/cygwin/dtable.cc
@@ -913,6 +913,8 @@ dtable::fixup_after_exec ()
 	else if (i <= 2)
 	  SetStdHandle (std_consts[i], fh->get_output_handle ());
       }
+  if (cygheap->ctty)
+    cygheap->ctty->fixup_after_exec ();
 }
 
 void
@@ -939,6 +941,9 @@ dtable::fixup_after_fork (HANDLE parent)
 	else if (i <= 2)
 	  SetStdHandle (std_consts[i], fh->get_output_handle ());
       }
+
+  if (cygheap->ctty)
+    cygheap->ctty->fixup_after_fork (parent);
 }
 
 static void
diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 0cbfe4ea4..23e733e94 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -723,6 +723,7 @@ fhandler_console::set_unit ()
     pc.file_attributes (FILE_ATTRIBUTE_NORMAL);
   else
     {
+      _tc = NULL;
       set_handle (NULL);
       set_output_handle (NULL);
       created = false;
@@ -4251,6 +4252,12 @@ fhandler_console::fixup_after_fork_exec (bool execing)
   set_unit ();
   setup_io_mutex ();
   wpbuf.init ();
+  if (cygheap->ctty == this && !get_handle () && !get_output_handle ())
+    {
+      close_with_arch ();
+      cygheap->ctty = NULL;
+      return;
+    }
 
   if (!execing)
     return;
-- 
2.39.0

