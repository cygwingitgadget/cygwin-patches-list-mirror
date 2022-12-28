Return-Path: <SRS0=l16K=42=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
	by sourceware.org (Postfix) with ESMTPS id 5A7B93858D37
	for <cygwin-patches@cygwin.com>; Wed, 28 Dec 2022 08:36:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 5A7B93858D37
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (aj135041.dynamic.ppp.asahi-net.or.jp [220.150.135.41]) (authenticated)
	by conuserg-12.nifty.com with ESMTP id 2BS8ZPde012762;
	Wed, 28 Dec 2022 17:35:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2BS8ZPde012762
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1672216551;
	bh=YmtOqWkAj6z/lihsY7CCslJTrjzLa75U7qz4VMGQf8M=;
	h=From:To:Cc:Subject:Date:From;
	b=GwcVu3BPLy5xiGcafLXWdgfm0qyU7rcUbe8MMZiYvbrYVFFSfXEUW6zTqXXk4nA8o
	 DaPIh8YJMD0wdaP0pAopH5Td7aqf6MAQmoEUO+G4p63jlL3ncn35ETL3aPq8BYr3Th
	 pxsLv8k5rbCJ/Jl3ipKtzMZFItPz9PFtVF9eAN0+YzxDSsZNEeFyDXl5ktUmktkH+k
	 zyGN3qHrmHzWJvgcVBNt1I+vBf5uak7SJNWR0j2dL3vXp1OrjPXkd8g1o05LEwUlei
	 SqFdr4WPlQ9tVgv8J/h/hGvXrxJ2AWJu5DdUXFreYPJ83oTOMadH9D6+48JT2aGbzR
	 sYXyBNY7nOoXQ==
X-Nifty-SrcIP: [220.150.135.41]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pinfo: Additional fix for CTTY behavior.
Date: Wed, 28 Dec 2022 17:35:16 +0900
Message-Id: <20221228083516.1226-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The commit 25c4ad6ea52f did not fix the CTTY behavior enough. For
example, in the following test case, TTY will be associated as
a CTTY on the second open() call even though the TTY is already
CTTY of another session. This patch fixes the issue.

  #include <unistd.h>
  #include <sys/fcntl.h>

  int main()
  {
    if (fork () == 0) {
      char *tty = ttyname(0);
      int fd;
      setsid();
      fd = open(tty, O_RDWR);
      close(fd);
      fd = open(tty, O_RDWR);
      usleep (60000000L);
    }
    return 0;
  }

Fixes: 25c4ad6ea52f ("Cygwin: pinfo: Align CTTY behavior to the
statement of POSIX.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/termios.cc | 1 -
 winsup/cygwin/pinfo.cc            | 5 +++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
index f94e20ff6..5b92cdd31 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -736,7 +736,6 @@ fhandler_termios::ioctl (int cmd, void *varg)
       return -1;
     }
 
-  myself->ctty = -1;
   if (!myself->set_ctty (this, 0))
     {
       set_errno (EPERM);
diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
index 586a4204d..735b3be8e 100644
--- a/winsup/cygwin/pinfo.cc
+++ b/winsup/cygwin/pinfo.cc
@@ -530,7 +530,7 @@ _pinfo::set_ctty (fhandler_termios *fh, int flags)
   debug_printf ("old %s, ctty device number %y, tc.ntty device number %y flags & O_NOCTTY %y", __ctty (), ctty, tc.ntty, flags & O_NOCTTY);
   if (fh && (ctty <= 0 || ctty == tc.ntty) && !(flags & O_NOCTTY))
     {
-      if (tc.getsid () && tc.getsid () != sid)
+      if (tc.getsid () && tc.getsid () != sid && ctty == -2)
 	; /* Do nothing if another session is associated with the TTY. */
       else
 	{
@@ -576,7 +576,8 @@ _pinfo::set_ctty (fhandler_termios *fh, int flags)
 	 an obvious bug surfaces. */
       if (sid == pid && !tc.getsid ())
 	tc.setsid (sid);
-      sid = tc.getsid ();
+      if (ctty > 0)
+	sid = tc.getsid ();
       /* See above */
       if ((!tc.getpgid () || being_debugged ()) && pgid == pid)
 	tc.setpgid (pgid);
-- 
2.39.0

