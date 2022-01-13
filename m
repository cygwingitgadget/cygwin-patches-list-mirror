Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id 7C5FF394881E
 for <cygwin-patches@cygwin.com>; Thu, 13 Jan 2022 12:29:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 7C5FF394881E
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ae233132.dynamic.ppp.asahi-net.or.jp
 [14.3.233.132]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 20DCSLD6010973;
 Thu, 13 Jan 2022 21:28:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 20DCSLD6010973
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1642076926;
 bh=5KjYWcTifE0ucwm34IbODcOr6qzyi3TJWTyjR4eMtyE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vS4K+FW3TbYsnJPXpbALvwmnaFAaXX/sM++bVDYfd6laTn28naIrey3KI/vGNri9c
 7ZUqlVTuS4qJ3gxjZjBDL2x6NJM66OvHOftunScsGsjayoqihHR520yw3VOC38uybx
 /3nNODvikn5bb94kdMj9XPar5gy+RzVbTICNIzXHEvGh4ACaDcSzfdUFpaHcab/pAU
 R8QlMZIr/eRDXPGh8NHDNOY+PR4Z6tqOx1VdCr/cp8K2CnSv5/betMl3BIUuaGq6D7
 TKGZIA3+HEJOoDyCXWzdKK2HmmN5lDyk7UX/dIluoPRdu04bxdpsXFUqq1d5sgY+Fz
 nI6vVLhD5U8FQ==
X-Nifty-SrcIP: [14.3.233.132]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/4] Cygwin: pty: Fix memory leak in master_fwd_thread.
Date: Thu, 13 Jan 2022 21:28:09 +0900
Message-Id: <20220113122811.241-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220113122811.241-1-takashi.yano@nifty.ne.jp>
References: <20220113122811.241-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 13 Jan 2022 12:29:07 -0000

- If master_fwd_thread is terminated by cygthread::terminate_thread(),
  the opportunity to release tmp_pathbuf is missed, resulting in a
  memory leak. This patch fixes the issue.
---
 winsup/cygwin/fhandler_tty.cc | 6 +++++-
 winsup/cygwin/tty.cc          | 1 +
 winsup/cygwin/tty.h           | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 16dbc5c0a..f68e80df9 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2106,7 +2106,9 @@ fhandler_pty_master::close ()
 	      master_ctl = NULL;
 	    }
 	  release_output_mutex ();
-	  master_fwd_thread->terminate_thread ();
+	  get_ttyp ()->stop_fwd_thread = true;
+	  WriteFile (to_master_nat, "", 0, NULL, NULL);
+	  master_fwd_thread->detach ();
 	}
     }
   if (InterlockedDecrement (&master_cnt) == 0)
@@ -2695,6 +2697,8 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
 	  termios_printf ("ReadFile for forwarding failed, %E");
 	  break;
 	}
+      if (p->ttyp->stop_fwd_thread)
+	break;
       ssize_t wlen = rlen;
       char *ptr = outbuf;
       if (p->ttyp->pcon_activated)
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index e29d73dcb..789528856 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -254,6 +254,7 @@ tty::init ()
   last_sig = 0;
   mask_flusho = false;
   discard_input = false;
+  stop_fwd_thread = false;
 }
 
 HANDLE
diff --git a/winsup/cygwin/tty.h b/winsup/cygwin/tty.h
index 25d351a4a..519d7c0d5 100644
--- a/winsup/cygwin/tty.h
+++ b/winsup/cygwin/tty.h
@@ -132,6 +132,7 @@ private:
   xfer_dir pcon_input_state;
   bool mask_flusho;
   bool discard_input;
+  bool stop_fwd_thread;
 
 public:
   HANDLE from_master_nat () const { return _from_master_nat; }
-- 
2.34.1

