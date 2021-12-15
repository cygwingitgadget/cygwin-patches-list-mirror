Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id DEAB53858D28
 for <cygwin-patches@cygwin.com>; Wed, 15 Dec 2021 03:30:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org DEAB53858D28
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (v050141.dynamic.ppp.asahi-net.or.jp
 [124.155.50.141]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 1BF3TnYA008831;
 Wed, 15 Dec 2021 12:29:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 1BF3TnYA008831
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1639538995;
 bh=IbLf+0kL9OiT3jnirfOp4Cdwp+tvRg2HSfxTTvO+djs=;
 h=From:To:Cc:Subject:Date:From;
 b=0sz6FE4gfoBE2meAeJhkhqk7nmAIaza3KBZnkpuOSD9CNv+ghbm66vCGRUJ1g5jMH
 zoSdc5UYhazA3JNRfLsCwrjpAgfhz0WAymTE/WYBRJwZiGdKZLtBPKbZ13fatVdOJ8
 VyJoTMez0jeabST29KXGt3pq8nVYr4jckcEK4PVxYEhLZLeAfiFNGVpbDyEdUAitve
 y5psVxj49iTGahXLck+2tDQ1PRHtZE4Q0nj8Z6MryJtpZeWy/s1lhKDVoR4me0Uoge
 ipAd7l6bY7vbtwjiVsD4XhOEsntgIoCSzEKtZdIN6zUBeuNg+UhpZ0C17Zc1Wp3Ae1
 89+DGwZvbwswQ==
X-Nifty-SrcIP: [124.155.50.141]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Fix input switching failure.
Date: Wed, 15 Dec 2021 12:29:48 +0900
Message-Id: <20211215032948.527-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Wed, 15 Dec 2021 03:30:11 -0000

- This patch fixes the failure of input switching between io_handle
  and io_handle_nat. This very rarely happens, however, input is
  wrongly switched to io_handle_nat even though the non-cygwin app
  is in the background.
---
 winsup/cygwin/fhandler_tty.cc | 3 +++
 winsup/cygwin/tty.cc          | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index ee687d9ad..c8ad53cb7 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1056,6 +1056,7 @@ fhandler_pty_slave::set_switch_to_pcon (void)
       isHybrid = true;
       setup_locale ();
       myself->exec_dwProcessId = myself->dwProcessId;
+      myself->process_state |= PID_NEW_PG; /* Marker for pcon_fg */
       bool nopcon = (disable_pcon || !term_has_pcon_cap (NULL));
       WaitForSingleObject (pcon_mutex, INFINITE);
       bool pcon_enabled = setup_pseudoconsole (nopcon);
@@ -1168,6 +1169,7 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
 		    }
 		}
 	      myself->exec_dwProcessId = 0;
+	      myself->process_state &= ~PID_NEW_PG;
 	      isHybrid = false;
 	    }
 	}
@@ -2272,6 +2274,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	      _pinfo *p = pids[i];
 	      if (p->ctty == get_ttyp ()->ntty
 		  && p->pgid == get_ttyp ()->getpgid ()
+		  && (p->process_state & PID_NOTCYGWIN)
 		  && (p->process_state & PID_NEW_PG))
 		{
 		  wpid = p->dwProcessId;
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index 2566f4c45..11ad3ec51 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -392,7 +392,8 @@ tty::pcon_fg (pid_t pgid)
   for (unsigned i = 0; i < pids.npids; i++)
     {
       _pinfo *p = pids[i];
-      if (p->ctty == ntty && p->pgid == pgid && p->exec_dwProcessId)
+      if (p->ctty == ntty && p->pgid == pgid
+	  && (p->process_state & (PID_NOTCYGWIN | PID_NEW_PG)))
 	return true;
     }
   if (pgid > MAX_PID)
-- 
2.34.1

