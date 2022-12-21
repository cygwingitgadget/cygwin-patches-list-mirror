Return-Path: <SRS0=tR/4=4T=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
	by sourceware.org (Postfix) with ESMTPS id 37BBB3858D1E
	for <cygwin-patches@cygwin.com>; Wed, 21 Dec 2022 10:25:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 37BBB3858D1E
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (aj135041.dynamic.ppp.asahi-net.or.jp [220.150.135.41]) (authenticated)
	by conuserg-08.nifty.com with ESMTP id 2BLAOrGr013376;
	Wed, 21 Dec 2022 19:24:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 2BLAOrGr013376
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1671618297;
	bh=T2boTysOKfNjG52EeShtMVh0iBo5wViNpxdGE3wtXB0=;
	h=From:To:Cc:Subject:Date:From;
	b=ocVxbZtavw4XxXPdoUuzVg6hQ0bURM8UWifBnnlagCMZJqS9V8c0Ub0QIEilV7CI5
	 xAGarYvXRxDGG1vgoRJteEvQ7yjsdJ4XuJXSAGkXg4nErtMuIQil/Cgo/HETeTrN4v
	 6smVsN69OW9GoIhRsXEGf9QH7IaCOafkZ0zqP7XG6xnA2dEFlPkn2P8c1xjW0DbjV0
	 7GpwHcSxO48x8DquWPgE6gQ/OVjCwnAuZ6oND5ovTMziIVvl9f7RZOpP42zL5rXwEM
	 wR7WXfKGeMBvgcWj4RrNWI1S1iQwCzz/e/OxTXuSMOPih5jUoY5Csz2rT6Xtms44dg
	 U1gptl0L9IK4g==
X-Nifty-SrcIP: [220.150.135.41]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
        Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v2] Cygwin: pinfo: Align CTTY behavior to the statement of POSIX.
Date: Wed, 21 Dec 2022 19:24:44 +0900
Message-Id: <20221221102444.1915-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

POSIX states "A terminal may be the controlling terminal for at most
one session."
https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap11.html

However, in cygwin, multiple sessions could be associated with the
same TTY. This patch aligns CTTY behavior to the statement of POSIX.

Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/termios.cc |  6 ++++-
 winsup/cygwin/mm/cygheap.cc       |  2 ++
 winsup/cygwin/pinfo.cc            | 38 ++++++++++++++++++-------------
 3 files changed, 29 insertions(+), 17 deletions(-)

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
index e086ab9a8..c0f3c4cbd 100644
--- a/winsup/cygwin/pinfo.cc
+++ b/winsup/cygwin/pinfo.cc
@@ -530,24 +530,30 @@ _pinfo::set_ctty (fhandler_termios *fh, int flags)
   debug_printf ("old %s, ctty device number %y, tc.ntty device number %y flags & O_NOCTTY %y", __ctty (), ctty, tc.ntty, flags & O_NOCTTY);
   if (fh && (ctty <= 0 || ctty == tc.ntty) && !(flags & O_NOCTTY))
     {
-      ctty = tc.ntty;
-      if (cygheap->ctty != fh->archetype)
+      if (tc.getsid ())
+	; /* Do nothing if a session is already associated with the TTY. */
+      else
 	{
-	  debug_printf ("cygheap->ctty %p, archetype %p", cygheap->ctty, fh->archetype);
-	  if (!cygheap->ctty)
-	    syscall_printf ("ctty was NULL");
-	  else
-	    {
-	      syscall_printf ("ctty %p, usecount %d", cygheap->ctty,
-			      cygheap->ctty->archetype_usecount (0));
-	      cygheap->ctty->close ();
-	    }
-	  cygheap->ctty = (fhandler_termios *) fh->archetype;
-	  if (cygheap->ctty)
+	  ctty = tc.ntty;
+	  if (cygheap->ctty != fh->archetype)
 	    {
-	      fh->archetype_usecount (1);
-	      /* guard ctty fh */
-	      report_tty_counts (cygheap->ctty, "ctty", "");
+	      debug_printf ("cygheap->ctty %p, archetype %p",
+			    cygheap->ctty, fh->archetype);
+	      if (!cygheap->ctty)
+		syscall_printf ("ctty was NULL");
+	      else
+		{
+		  syscall_printf ("ctty %p, usecount %d", cygheap->ctty,
+				  cygheap->ctty->archetype_usecount (0));
+		  cygheap->ctty->close ();
+		}
+	      cygheap->ctty = (fhandler_termios *) fh->archetype;
+	      if (cygheap->ctty)
+		{
+		  fh->archetype_usecount (1);
+		  /* guard ctty fh */
+		  report_tty_counts (cygheap->ctty, "ctty", "");
+		}
 	    }
 	}
 
-- 
2.39.0

