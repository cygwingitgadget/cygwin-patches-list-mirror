Return-Path: <SRS0=lPB0=4S=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
	by sourceware.org (Postfix) with ESMTPS id 344903858421
	for <cygwin-patches@cygwin.com>; Tue, 20 Dec 2022 12:41:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 344903858421
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (aj135041.dynamic.ppp.asahi-net.or.jp [220.150.135.41]) (authenticated)
	by conuserg-11.nifty.com with ESMTP id 2BKCfGMO013964;
	Tue, 20 Dec 2022 21:41:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 2BKCfGMO013964
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1671540081;
	bh=SevvVRI+t9JWzepTWIdSggTQxA4+CybkCn7TAHmBWmg=;
	h=From:To:Cc:Subject:Date:From;
	b=kgJc+z5Bih5NvFT85FsB6CswD1Dgp0oSAB6VHFChpULfBf5u7WxPKe+NABmmXdWtN
	 1xT9P798GVh4CzQrBqIZ+85fNbPv1AIUZ7gAfWLc5v3FhttNF3Si0/eexmDLowZg1O
	 fMUFOu5+mWwa4063giqn8rUi992VA3BELwJRH3pZ8gr7yOrL+PldTC9L36ByN+Q7m0
	 MDPFCZ90d6Xsw0evUjwnh8uhH2eCMUwO+z0Htl4+1m8qH8NQaapBX9UPPtz84VpugA
	 RcbnN8toYHWMDzcWMUMIYfS3EIPR7ynhu7lPFAiUNJ41WvrLnv7gEUAEXZEXqNIESO
	 JeXxAtG9g3XYA==
X-Nifty-SrcIP: [220.150.135.41]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pinfo: Align CTTY behavior to the statement of POSIX.
Date: Tue, 20 Dec 2022 21:41:06 +0900
Message-Id: <20221220124106.487-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

POSIX states "A terminal may be the controlling terminal for at most
one session."
https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap11.html

However, in cygwin, multiple sessions could be associated with the
same TTY. This patch aligns CTTY behavior to the statement of POSIX.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/termios.cc | 6 +++++-
 winsup/cygwin/mm/cygheap.cc       | 2 ++
 winsup/cygwin/pinfo.cc            | 4 +++-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
index fe4dfd13e..f94e20ff6 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -737,7 +737,11 @@ fhandler_termios::ioctl (int cmd, void *varg)
     }
 
   myself->ctty = -1;
-  myself->set_ctty (this, 0);
+  if (!myself->set_ctty (this, 0))
+    {
+      set_errno (EPERM);
+      return -1;
+    }
   return 0;
 }
 
diff --git a/winsup/cygwin/mm/cygheap.cc b/winsup/cygwin/mm/cygheap.cc
index a305570df..72861d8d7 100644
--- a/winsup/cygwin/mm/cygheap.cc
+++ b/winsup/cygwin/mm/cygheap.cc
@@ -127,6 +127,8 @@ void
 init_cygheap::close_ctty ()
 {
   debug_printf ("closing cygheap->ctty %p", cygheap->ctty);
+  if (cygheap->ctty->tc ()->getsid () == pid)
+    cygheap->ctty->tc ()->setsid (0); /* Release CTTY ownership */
   cygheap->ctty->close_with_arch ();
   cygheap->ctty = NULL;
 }
diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
index e086ab9a8..749a4064c 100644
--- a/winsup/cygwin/pinfo.cc
+++ b/winsup/cygwin/pinfo.cc
@@ -528,7 +528,9 @@ _pinfo::set_ctty (fhandler_termios *fh, int flags)
 {
   tty_min& tc = *fh->tc ();
   debug_printf ("old %s, ctty device number %y, tc.ntty device number %y flags & O_NOCTTY %y", __ctty (), ctty, tc.ntty, flags & O_NOCTTY);
-  if (fh && (ctty <= 0 || ctty == tc.ntty) && !(flags & O_NOCTTY))
+  if (tc.getsid () && tc.getsid () != pid)
+    ; /* Do not attach if another session already attached to the CTTY. */
+  else if (fh && (ctty <= 0 || ctty == tc.ntty) && !(flags & O_NOCTTY))
     {
       ctty = tc.ntty;
       if (cygheap->ctty != fh->archetype)
-- 
2.39.0

