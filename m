Return-Path: <SRS0=MpmZ=CZ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta0013.nifty.com (mta-snd00009.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:29])
	by sourceware.org (Postfix) with ESMTPS id AF1783858D38
	for <cygwin-patches@cygwin.com>; Fri,  7 Jul 2023 03:35:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AF1783858D38
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain by dmta0013.nifty.com with ESMTP
          id <20230707033529776.WELQ.104052.localhost.localdomain@nifty.com>;
          Fri, 7 Jul 2023 12:35:29 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Bruce Jerrick <bmj001@gmail.com>
Subject: [PATCH 1/2] Cygwin: stat(): Fix "Bad address" error on stat() for /dev/tty.
Date: Fri,  7 Jul 2023 12:34:57 +0900
Message-Id: <20230707033458.1034-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230707033458.1034-1-takashi.yano@nifty.ne.jp>
References: <20230707033458.1034-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

As reported in
https://cygwin.com/pipermail/cygwin/2023-June/253888.html,
"Bad address" error occurs when stat() is called after the commit
3721a756b0d8 ("Cygwin: console: Make the console accessible from
other terminals.").

There are two problems in the current code. One is fhandler_console::
fstat() calls get_ttyp()->getsid(). However, fh_alloc() in dtable.cc
omits to initialize the fhandler_console instance when stat() is
called. Due to this, get_ttyp() returns NULL and access violation
occurs. The other problem is fh_alloc() assigns fhandler_console
even if the CTTY is not a console. So the first problem above occurs
even if the CTTY is a pty.

This patch fixes the issue by:
1) Call set_unit() to initialize _tc if the get_ttyp() returns NULL.
2) Assign fhandler_pty_slave for /dev/tty if CTTY is a pty in fh_alloc().

Fixes: 3721a756b0d8 ("Cygwin: console: Make the console accessible
  from other terminals.").
Fixes: 23771fa1f7028 ("dtable.cc (fh_alloc): Make different decisions
  when generating fhandler for not-opened devices. Add kludge to deal
  with opening /dev/tty.")
Reported-by: Bruce Jerrick <bmj001@gmail.com>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/dtable.cc           | 8 +++++++-
 winsup/cygwin/fhandler/console.cc | 6 ++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
index 18e0f3097..2aae2fd65 100644
--- a/winsup/cygwin/dtable.cc
+++ b/winsup/cygwin/dtable.cc
@@ -600,7 +600,13 @@ fh_alloc (path_conv& pc)
 	case FH_TTY:
 	  if (!pc.isopen ())
 	    {
-	      fhraw = cnew_no_ctor (fhandler_console, -1);
+	      if (CTTY_IS_VALID (myself->ctty))
+		{
+		  if (iscons_dev (myself->ctty))
+		    fhraw = cnew_no_ctor (fhandler_console, -1);
+		  else
+		    fhraw = cnew_no_ctor (fhandler_pty_slave, -1);
+		}
 	      debug_printf ("not called from open for /dev/tty");
 	    }
 	  else if (!CTTY_IS_VALID (myself->ctty) && last_tty_dev
diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 7768a9941..6aa3b50bf 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -4554,6 +4554,12 @@ fhandler_console::set_disable_master_thread (bool x, fhandler_console *cons)
 int
 fhandler_console::fstat (struct stat *st)
 {
+  /* When stat() is called, fh_alloc() in dtable.cc omits to initialize
+     the console instance. Due to this, get_ttyp() returns NULL here.
+     So, calling set_unit() is necessary to access getsid(). */
+  if (!get_ttyp ())
+    set_unit ();
+
   fhandler_base::fstat (st);
   st->st_mode = S_IFCHR | S_IRUSR | S_IWUSR;
   pinfo p (get_ttyp ()->getsid ());
-- 
2.39.0

