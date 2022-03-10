Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id CE80B3858039
 for <cygwin-patches@cygwin.com>; Thu, 10 Mar 2022 11:34:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org CE80B3858039
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 22ABXZsd011098;
 Thu, 10 Mar 2022 20:33:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 22ABXZsd011098
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1646912021;
 bh=PAGYJ0Ke4AMd0nbhWmbb14pu7s1CZiprueI0GTx8B+g=;
 h=From:To:Cc:Subject:Date:From;
 b=GAnLVtX4eC2Xi4okm57F/ig2PzefsdLwGeCnJWYKI8tVpRMOqleSZnPQuJ7oztiy7
 leAuGpKXfyN80eIczjwwTRgkzoptjZ1ViCysKBD10VRYzuglL/XnaibYTcl3X2xVh7
 0Ceu4JaT+d/70uluYiyIJLOj0yqd/drJdb1v1hKxBAPOuVnpCKGCHNI1uRwhtzp8H6
 yvAbQVIpjimMZGRWCJxSTdGG9uAQ3nl8oqaf5K74RQoRJ9W5ZXqxKXxxOLR5MSFiZ0
 4z2EGh5atEWz76a9LKby8m4FKqY26YQ7MDJnLakdYz4k9tziXahrdoQmCbB7wDEYEZ
 QCU2Jw6pN6+Og==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console,
 pty: Fix segfault in child_info_spawn::worker().
Date: Thu, 10 Mar 2022 20:33:27 +0900
Message-Id: <20220310113327.1909-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 10 Mar 2022 11:34:09 -0000

- After the commit "Cygwin: pty, console: Fix handle leak which
  occurs on exec() error.", startxwin cannot start X due to the
  error "Failed to activate virtual core keyboard: 2". The problem
  is access violation in the code retrieving the pgid of the ctty.
  This patch fixes the issue.
---
 winsup/cygwin/fhandler.h | 8 ++++++--
 winsup/cygwin/spawn.cc   | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index e7cf17df0..b87160edb 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1915,6 +1915,7 @@ class fhandler_termios: public fhandler_base
   };
 
  public:
+  virtual pid_t tc_getpgid () { return 0; };
   tty_min*& tc () {return _tc;}
   fhandler_termios () :
   fhandler_base ()
@@ -2158,9 +2159,10 @@ private:
 			       const handle_set_t *p);
 
  public:
-  static pid_t tc_getpgid ()
+  pid_t tc_getpgid ()
   {
-    return shared_console_info ? shared_console_info->tty_min_state.getpgid () : myself->pgid;
+    return shared_console_info ?
+      shared_console_info->tty_min_state.getpgid () : 0;
   }
   fhandler_console (fh_devices);
   static console_state *open_shared_console (HWND hw, HANDLE& h)
@@ -2343,6 +2345,8 @@ class fhandler_pty_slave: public fhandler_pty_common
   void fch_close_handles ();
 
  public:
+  pid_t tc_getpgid () { return _tc ? _tc->pgid : 0; }
+
   struct handle_set_t
   {
     HANDLE from_master_nat;
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 3b54309a2..fb3d09d84 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -564,7 +564,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	 because the Ctrl-C event is sent to all processes in the console, unless
 	 they ignore it explicitely.  CREATE_NEW_PROCESS_GROUP does that for us. */
       pid_t ctty_pgid =
-	::cygheap->ctty ? ::cygheap->ctty->tc ()->getpgid () : 0;
+	::cygheap->ctty ? ::cygheap->ctty->tc_getpgid () : 0;
       if (!iscygwin () && ctty_pgid && ctty_pgid != myself->pgid)
 	c_flags |= CREATE_NEW_PROCESS_GROUP;
       refresh_cygheap ();
-- 
2.35.1

