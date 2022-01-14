Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id 6BF8E3858403
 for <cygwin-patches@cygwin.com>; Fri, 14 Jan 2022 14:08:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 6BF8E3858403
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ae233132.dynamic.ppp.asahi-net.or.jp
 [14.3.233.132]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 20EE7Wdl027851;
 Fri, 14 Jan 2022 23:07:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 20EE7Wdl027851
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1642169259;
 bh=mIU20mgOcbWhqLEKlXDqrNFN4EyrlGWgXLDnF21rgIk=;
 h=From:To:Cc:Subject:Date:From;
 b=mhi+brb2GRG9RO/XxIW3zPtorYtBIV1zymvMKRM02lVTb7/vK0qZjOICtneL9r2JG
 fYCiHgFxtHUUwQLQ6JJEdn6e6Qjpon69UFC7DXVeH/ZBaVX2BLKkIDK2GBBleg5d1d
 9n8tNCoY+S1urTohmV6mSR0BtTgZuNRWFI6/0pU7cGnl9HCwPLyN2ZeX4F9XOEmm+t
 Hlx+Hxuek+BePb61sjQKCbhVPnyzhoUO4F6+KQMikue2zUKNgfaO1+zXnj5SN3HckV
 PBKERJmznXeidVdWOCtCzD0KzVht7jlJu9EOJYu4Cjnrm0z32A7DfRFWhTCKyPQcH9
 PeghDvmJdEf4Q==
X-Nifty-SrcIP: [14.3.233.132]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Fix race issue between closing and opening
 master.
Date: Fri, 14 Jan 2022 23:07:36 +0900
Message-Id: <20220114140736.984-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Fri, 14 Jan 2022 14:08:10 -0000

- If the from_master is closed before cleaning up other pipes, such
  as from_slave_nat, the same pty may be allocated and pty master may
  try to open the pipe which is not closed yet, and it will fail.
  This patch fixes the issue.
---
 winsup/cygwin/fhandler_tty.cc | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 1ae4edd63..7bef6958c 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2146,8 +2146,6 @@ fhandler_pty_master::close ()
 
   if (!ForceCloseHandle (from_master_nat))
     termios_printf ("error closing from_master_nat %p, %E", from_master_nat);
-  if (!ForceCloseHandle (from_master))
-    termios_printf ("error closing from_master %p, %E", from_master);
   if (!ForceCloseHandle (to_master_nat))
     termios_printf ("error closing to_master_nat %p, %E", to_master_nat);
   from_master_nat = to_master_nat = NULL;
@@ -2156,7 +2154,7 @@ fhandler_pty_master::close ()
   from_slave_nat = NULL;
   if (!ForceCloseHandle (to_master))
     termios_printf ("error closing to_master %p, %E", to_master);
-  to_master = from_master = NULL;
+  to_master = NULL;
   ForceCloseHandle (echo_r);
   ForceCloseHandle (echo_w);
   echo_r = echo_w = NULL;
@@ -2171,6 +2169,12 @@ fhandler_pty_master::close ()
     termios_printf ("CloseHandle (input_available_event<%p>), %E",
 		    input_available_event);
 
+  /* The from_master must be closed last so that the same pty is not
+     allocated before cleaning up the other corresponding instances. */
+  if (!ForceCloseHandle (from_master))
+    termios_printf ("error closing from_master %p, %E", from_master);
+  from_master = NULL;
+
   return 0;
 }
 
@@ -3069,12 +3073,14 @@ err:
   close_maybe (output_mutex);
   close_maybe (input_mutex);
   close_maybe (from_master_nat);
-  close_maybe (from_master);
   close_maybe (to_master_nat);
   close_maybe (to_master);
   close_maybe (echo_r);
   close_maybe (echo_w);
   close_maybe (master_ctl);
+  /* The from_master must be closed last so that the same pty is not
+     allocated before cleaning up the other corresponding instances. */
+  close_maybe (from_master);
   termios_printf ("pty%d open failed - failed to create %s", unit, errstr);
   return false;
 }
-- 
2.34.1

