Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id BFBEE3858C27
 for <cygwin-patches@cygwin.com>; Fri,  4 Mar 2022 11:06:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org BFBEE3858C27
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 224B64YP017871;
 Fri, 4 Mar 2022 20:06:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 224B64YP017871
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1646391983;
 bh=LffDQvs71cwO0/U7KicKBNvw2d/0S8MFw7zI8zQKl8Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SwFka9E+2U3jOrrQ0whLiYHhviuzqDcnFqU4bBKoUsIeybdCNXfMQq8NVpqC35W0n
 Q3ptq1XciK7hnP5+T4TT1YeFLUmS2nHjKQBJGWcpiaok9rnpUXglmOclCw5XopwIaw
 Uk70vY81Fyq4+KCTSNOqYNqZ4yrH6Z2owS14ftkD6o/Wj7e7CPK2ezJxgrakRRxlwS
 O7JvwM/MiVOv1jOPJ3O+xnRRc/4v70rhPf7V1f5tJEqw0KS02tU+UHGtzcmEhNSnvE
 otOvuY9aHLqtP6Mlh/1ctdNDhyHBcbD1qzU68kU1ftl1jxIpLt/tZFukS+OoD/gE0l
 kZ0pBkK9/J/OQ==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Rearrange reset_switch_to_nat_pipe() calls.
Date: Fri,  4 Mar 2022 20:05:55 +0900
Message-Id: <20220304110556.2139-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304110556.2139-1-takashi.yano@nifty.ne.jp>
References: <20220304110556.2139-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_PASS, TXREP,
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
X-List-Received-Date: Fri, 04 Mar 2022 11:06:53 -0000

- Previously, reset_switch_to_nat_pipe() is called from many places
  in pty code. This patch reorganizes that. With this patch, it is
  called only from bg_check() and setpgid_aux(). The calls which
  does not have enough reason have been omitted.
---
 winsup/cygwin/fhandler.h      |  1 +
 winsup/cygwin/fhandler_tty.cc | 22 ++++++++++------------
 winsup/cygwin/select.cc       |  2 --
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index c32dc7b57..e7cf17df0 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2378,6 +2378,7 @@ class fhandler_pty_slave: public fhandler_pty_common
   select_record *select_read (select_stuff *);
   select_record *select_write (select_stuff *);
   select_record *select_except (select_stuff *);
+  bg_check_types bg_check (int sig, bool dontsignal = false);
   virtual char const *ttyname () { return pc.dev.name (); }
   int __reg2 fstat (struct stat *buf);
   int __reg3 facl (int, int, struct acl *);
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 3332fefd6..2f13e9990 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1287,8 +1287,6 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
 
   push_process_state process_state (PID_TTYOU);
 
-  reset_switch_to_nat_pipe ();
-
   acquire_output_mutex (mutex_timeout);
   if (!process_opost_output (get_output_handle (), ptr, towrite, false,
 			     get_ttyp (), is_nonblocking ()))
@@ -1409,10 +1407,7 @@ fhandler_pty_slave::read (void *ptr, size_t& len)
   push_process_state process_state (PID_TTYIN);
 
   if (ptr) /* Indicating not tcflush(). */
-    {
-      mask_switch_to_nat_pipe (true, true);
-      reset_switch_to_nat_pipe ();
-    }
+    mask_switch_to_nat_pipe (true, true);
 
   if (is_nonblocking () || !ptr) /* Indicating tcflush(). */
     time_to_wait = 0;
@@ -1669,7 +1664,6 @@ fhandler_pty_master::dup (fhandler_base *child, int)
 int
 fhandler_pty_slave::tcgetattr (struct termios *t)
 {
-  reset_switch_to_nat_pipe ();
   *t = get_ttyp ()->ti;
 
   /* Workaround for rlwrap */
@@ -1690,7 +1684,6 @@ fhandler_pty_slave::tcgetattr (struct termios *t)
 int
 fhandler_pty_slave::tcsetattr (int, const struct termios *t)
 {
-  reset_switch_to_nat_pipe ();
   acquire_output_mutex (mutex_timeout);
   get_ttyp ()->ti = *t;
   release_output_mutex ();
@@ -1704,8 +1697,6 @@ fhandler_pty_slave::tcflush (int queue)
 
   termios_printf ("tcflush(%d) handle %p", queue, get_handle ());
 
-  reset_switch_to_nat_pipe ();
-
   if (queue == TCIFLUSH || queue == TCIOFLUSH)
     {
       size_t len = UINT_MAX;
@@ -1725,7 +1716,6 @@ int
 fhandler_pty_slave::ioctl (unsigned int cmd, void *arg)
 {
   termios_printf ("ioctl (%x)", cmd);
-  reset_switch_to_nat_pipe ();
   int res = fhandler_termios::ioctl (cmd, arg);
   if (res <= 0)
     return res;
@@ -2489,6 +2479,13 @@ fhandler_pty_slave::setup_locale (void)
     }
 }
 
+bg_check_types
+fhandler_pty_slave::bg_check (int sig, bool dontsignal)
+{
+  reset_switch_to_nat_pipe ();
+  return fhandler_termios::bg_check (sig, dontsignal);
+}
+
 void
 fhandler_pty_slave::fixup_after_fork (HANDLE parent)
 {
@@ -2500,7 +2497,6 @@ fhandler_pty_slave::fixup_after_fork (HANDLE parent)
 void
 fhandler_pty_slave::fixup_after_exec ()
 {
-  reset_switch_to_nat_pipe ();
   create_invisible_console ();
 
   if (!close_on_exec ())
@@ -4104,6 +4100,8 @@ fhandler_pty_slave::cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
 void
 fhandler_pty_slave::setpgid_aux (pid_t pid)
 {
+  reset_switch_to_nat_pipe ();
+
   WaitForSingleObject (pipe_sw_mutex, INFINITE);
   bool was_nat_fg = get_ttyp ()->nat_fg (tc ()->pgid);
   bool nat_fg = get_ttyp ()->nat_fg (pid);
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 64e35cf12..4f23dfdef 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1353,8 +1353,6 @@ peek_pty_slave (select_record *s, bool from_select)
   fhandler_base *fh = (fhandler_base *) s->fh;
   fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
 
-  ptys->reset_switch_to_nat_pipe ();
-
   if (s->read_selected)
     {
       if (s->read_ready)
-- 
2.35.1

