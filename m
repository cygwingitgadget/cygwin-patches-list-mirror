Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id C24CA3858D20
 for <cygwin-patches@cygwin.com>; Thu,  3 Mar 2022 18:15:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org C24CA3858D20
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 223IEmxi018846;
 Fri, 4 Mar 2022 03:14:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 223IEmxi018846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1646331293;
 bh=/R8UjXWHykUi+rw2q2rqwwl4o2hfWO7Uji+f2v9hd6w=;
 h=From:To:Cc:Subject:Date:From;
 b=kKAk0hZZioj9hblV3MAHcosXoNl1DalUVSBDnhQ+Xa3cm3DlAeffcysPyI9DkkZYq
 e3I9K355X31don854/XQ+VzCOisDX7oSkiE0Wo/FIBHL2hLdx9NMe2Cfn9YlzoEs0U
 t2fvbRc3zP3Wij39g0BKdOzWsGQS/9UEg7wYz1TEV1c0Vc9mUacZrUXnxQeHoxoXfK
 LWeqdLSr+aOWqTn7uiRkbUuQq4WVBifnSvB+l1lz6cuzJM6ieuY1aCYmFrVD3upfbv
 zc2iU5OnF1U3v+N7semPsD/wlnEgeJML7+scV2v7MfPOOx/ZpQ0b5VreFegVrC0VS2
 uLK3+C5z8as5w==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Simplify the setup code for GDB a bit.
Date: Fri,  4 Mar 2022 03:14:42 +0900
Message-Id: <20220303181442.5112-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Thu, 03 Mar 2022 18:15:07 -0000

- This patch omits the unnecessary code path for setup for GDB.
---
 winsup/cygwin/fhandler_tty.cc | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index be3e6fcba..c7588a073 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -121,12 +121,12 @@ static bool isHybrid; /* Set true if the active pipe is set to nat pipe even
 static HANDLE h_gdb_inferior; /* Handle of GDB inferior process. */
 
 static void
-set_switch_to_nat_pipe (HANDLE *in, HANDLE *out, HANDLE *err, bool iscygwin)
+set_switch_to_nat_pipe (HANDLE *in, HANDLE *out, HANDLE *err)
 {
   cygheap_fdenum cfd (false);
   int fd;
   fhandler_base *replace_in = NULL, *replace_out = NULL, *replace_err = NULL;
-  fhandler_pty_slave *ptys_nat = NULL;
+  fhandler_pty_slave *ptys = NULL;
   while ((fd = cfd.next ()) >= 0)
     {
       if (*in == cfd->get_handle () ||
@@ -141,15 +141,14 @@ set_switch_to_nat_pipe (HANDLE *in, HANDLE *out, HANDLE *err, bool iscygwin)
       if (cfd->get_device () == (dev_t) myself->ctty)
 	{
 	  fhandler_base *fh = cfd;
-	  fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
-	  if (*in == ptys->get_handle ()
-	      || *out == ptys->get_output_handle ()
-	      || *err == ptys->get_output_handle ())
-	    ptys_nat = ptys;
+	  if (*in == fh->get_handle ()
+	      || *out == fh->get_output_handle ()
+	      || *err == fh->get_output_handle ())
+	    ptys = (fhandler_pty_slave *) fh;
 	}
     }
-  if (!iscygwin && ptys_nat)
-    ptys_nat->set_switch_to_nat_pipe ();
+  if (ptys)
+    ptys->set_switch_to_nat_pipe ();
   if (replace_in)
     *in = replace_in->get_handle_nat ();
   if (replace_out)
@@ -280,8 +279,9 @@ CreateProcessA_Hooked
       siov->hStdError = GetStdHandle (STD_ERROR_HANDLE);
     }
   bool path_iscygexec = fhandler_termios::path_iscygexec_a (n, c);
-  set_switch_to_nat_pipe (&siov->hStdInput, &siov->hStdOutput,
-			  &siov->hStdError, path_iscygexec);
+  if (!path_iscygexec)
+    set_switch_to_nat_pipe (&siov->hStdInput, &siov->hStdOutput,
+			    &siov->hStdError);
   BOOL ret = CreateProcessA_Orig (n, c, pa, ta, inh, f, e, d, siov, pi);
   h_gdb_inferior = pi->hProcess;
   DuplicateHandle (GetCurrentProcess (), h_gdb_inferior,
@@ -318,8 +318,9 @@ CreateProcessW_Hooked
       siov->hStdError = GetStdHandle (STD_ERROR_HANDLE);
     }
   bool path_iscygexec = fhandler_termios::path_iscygexec_w (n, c);
-  set_switch_to_nat_pipe (&siov->hStdInput, &siov->hStdOutput,
-			  &siov->hStdError, path_iscygexec);
+  if (!path_iscygexec)
+    set_switch_to_nat_pipe (&siov->hStdInput, &siov->hStdOutput,
+			    &siov->hStdError);
   BOOL ret = CreateProcessW_Orig (n, c, pa, ta, inh, f, e, d, siov, pi);
   h_gdb_inferior = pi->hProcess;
   DuplicateHandle (GetCurrentProcess (), h_gdb_inferior,
-- 
2.35.1

