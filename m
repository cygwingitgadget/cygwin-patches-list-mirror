Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id 3E1083858D35
 for <cygwin-patches@cygwin.com>; Sun, 27 Feb 2022 23:15:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 3E1083858D35
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 21RNEX1u020040;
 Mon, 28 Feb 2022 08:14:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 21RNEX1u020040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1646003680;
 bh=yxL3ygsw6OcggHTJmEGjJGeCfBEw5VmWdHHlkrZCRhM=;
 h=From:To:Cc:Subject:Date:From;
 b=vPs1qjwV41OEQjz87tDW2wKbUoSjo2jaSzBdVyhUWu7bxVTNMhLP1PP7Mftckn4Ca
 iaXE6ureWmo6kx7QkfcRZxD3jzjzp04L8xWbTeDixQM3OTPrRnEqFG3gpn6PRJ6wBE
 xy8mkdn/Xb/uc8wWf0XTyfC05eoH9nLeE2j5H60qCwCs9GTZXM5BkbmOs8xViW6BiZ
 TKz25BhdT8ucooQ0VslOgWyGCEGCGE7DeVIa437oPOsfyDSO+utfj06CFhWvwSeQz2
 I2J/I1n9le3MeAsBptf8cWJL+JSCL0I/kxU9YbqLoDNbM4wD1LjLujeIwMj48qXFM3
 BhSYyEszg1bgQ==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: termios: Ensure detection of GDB inferior in
 process_sigs().
Date: Mon, 28 Feb 2022 08:14:30 +0900
Message-Id: <20220227231430.10199-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sun, 27 Feb 2022 23:15:24 -0000

- In some situations, some cygwin processes might wrongly identified
  as GDB inferior. This patch ensures the detection of GDB inferior.
---
 winsup/cygwin/fhandler_termios.cc  | 12 ++++++------
 winsup/cygwin/include/sys/cygwin.h |  1 +
 winsup/cygwin/pinfo.cc             |  2 ++
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_termios.cc
index f82ac76dc..028210d98 100644
--- a/winsup/cygwin/fhandler_termios.cc
+++ b/winsup/cygwin/fhandler_termios.cc
@@ -345,7 +345,8 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 		     without pcon enabled. In this case, the inferior is not
 		     cygwin process list. PID_NEW_PG is set as a marker for
 		     GDB with non-cygwin inferior in pty code.
-	 !PID_CYGPARENT: check this for GDB with cygwin inferior. */
+	 !PID_CYGPARENT: check this for GDB with cygwin inferior or
+			 cygwin apps started from non-cygwin shell. */
       if (c == '\003' && p && p->ctty == ttyp->ntty && p->pgid == pgid
 	  && ((p->process_state & PID_NOTCYGWIN)
 	      || (p->process_state & PID_NEW_PG)
@@ -408,13 +409,12 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 	  if (p->process_state & PID_TTYIN)
 	    cyg_reader = true; /* Theh process is reading the tty */
 	  if (!p->cygstarted && !(p->process_state & PID_NOTCYGWIN)
-	      && (p != myself || being_debugged ())
-	      && cyg_leader) /* inferior is cygwin app */
-	    with_debugger = true;
+	      && (p->process_state & PID_DEBUGGED))
+	    with_debugger = true; /* inferior is cygwin app */
 	  if (!(p->process_state & PID_NOTCYGWIN)
 	      && (p->process_state & PID_NEW_PG) /* Check marker */
-	      && p->pid == pgid) /* inferior is non-cygwin app */
-	    with_debugger_nat = true;
+	      && p->pid == pgid)
+	    with_debugger_nat = true; /* inferior is non-cygwin app */
 	}
     }
   if ((with_debugger || with_debugger_nat) && need_discard_input)
diff --git a/winsup/cygwin/include/sys/cygwin.h b/winsup/cygwin/include/sys/cygwin.h
index ac55ab09c..c9d4599a3 100644
--- a/winsup/cygwin/include/sys/cygwin.h
+++ b/winsup/cygwin/include/sys/cygwin.h
@@ -276,6 +276,7 @@ enum
   PID_PROCINFO	       = 0x08000, /* caller just asks for process info */
   PID_NEW_PG	       = 0x10000, /* Process created with
 				     CREATE_NEW_PROCESS_GROUOP flag */
+  PID_DEBUGGED	       = 0x20000, /* Process being debugged */
   PID_EXITED	       = 0x40000000, /* Free entry. */
   PID_REAPED	       = 0x80000000  /* Reaped */
 };
diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
index bb7c16547..5e04ea3da 100644
--- a/winsup/cygwin/pinfo.cc
+++ b/winsup/cygwin/pinfo.cc
@@ -106,6 +106,8 @@ pinfo_init (char **envp, int envc)
 
   myself->process_state |= PID_ACTIVE;
   myself->process_state &= ~(PID_INITIALIZING | PID_EXITED | PID_REAPED);
+  if (being_debugged ())
+    myself->process_state |= PID_DEBUGGED;
   myself.preserve ();
   debug_printf ("pid %d, pgid %d, process_state %y",
 		myself->pid, myself->pgid, myself->process_state);
-- 
2.35.1

