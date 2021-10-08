Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
 by sourceware.org (Postfix) with ESMTPS id 294FC3858D39
 for <cygwin-patches@cygwin.com>; Fri,  8 Oct 2021 16:29:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 294FC3858D39
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conuserg-12.nifty.com with ESMTP id 198GT1Bc027132;
 Sat, 9 Oct 2021 01:29:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 198GT1Bc027132
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1633710546;
 bh=nN7yQckDXb5nDkWe66z3PdlJDz8IPANyrDO1BOplRT8=;
 h=From:To:Cc:Subject:Date:From;
 b=AxQHWg2VxQg645bT8qSVhpfPmYPPyQ8Xn+O1SjMibuweLmtNjjJ6KRH5JhVC3L8rz
 Z2FZI062Amxwl64L6Zr9pOF/P6SsuvsunGA431uakr0eCiRNGk80RoIwrFFMJgaTMJ
 brImKI+nLGQXg4y/kHEA49gjJmwW623gpltnIuehAArQ5ecFW68HZvwwIAyKgnoOfP
 nSxP9XlzV794tD7C0YuMr22T+AnOQODStwBnTBjzR3/VN7CbSn+fe30TmlRaAWUlBn
 NuE3bGQ/fpRPkpByF12NPsuqpjpurrQFfnUmY4YNRY8kdt/T9+8DtykJUupY/ZiJ79
 /hyg895cBJkKg==
X-Nifty-SrcIP: [110.4.221.123]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Fix master closing error regarding attach_mutex.
Date: Sat,  9 Oct 2021 01:28:54 +0900
Message-Id: <20211008162854.1085-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Fri, 08 Oct 2021 16:29:31 -0000

- If two or more pty masters are opened in a process, closing master
  causes error when closing attach_mutex. This patch fixes the issue.

Addresses:
https://cygwin.com/pipermail/cygwin-developers/2021-October/012418.html
---
 winsup/cygwin/fhandler_tty.cc | 7 +++++--
 winsup/cygwin/release/3.3.0   | 3 +++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 05fe5348a..823dabf73 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -57,6 +57,7 @@ struct pipe_reply {
 };
 
 extern HANDLE attach_mutex; /* Defined in fhandler_console.cc */
+static LONG NO_COPY master_cnt = 0;
 
 inline static bool pcon_pid_alive (DWORD pid);
 
@@ -2041,7 +2042,8 @@ fhandler_pty_master::close ()
 	    }
 	  release_output_mutex ();
 	  master_fwd_thread->terminate_thread ();
-	  CloseHandle (attach_mutex);
+	  if (InterlockedDecrement (&master_cnt) == 0)
+	    CloseHandle (attach_mutex);
 	}
     }
 
@@ -2876,7 +2878,8 @@ fhandler_pty_master::setup ()
   if (!(pcon_mutex = CreateMutex (&sa, FALSE, buf)))
     goto err;
 
-  attach_mutex = CreateMutex (&sa, FALSE, NULL);
+  if (InterlockedIncrement (&master_cnt) == 1)
+    attach_mutex = CreateMutex (&sa, FALSE, NULL);
 
   /* Create master control pipe which allows the master to duplicate
      the pty pipe handles to processes which deserve it. */
diff --git a/winsup/cygwin/release/3.3.0 b/winsup/cygwin/release/3.3.0
index 2f7340ac5..2df81a4ae 100644
--- a/winsup/cygwin/release/3.3.0
+++ b/winsup/cygwin/release/3.3.0
@@ -71,3 +71,6 @@ Bug Fixes
   in ps(1) output.
   Addresses: https://cygwin.com/pipermail/cygwin/2021-July/248998.html
              https://cygwin.com/pipermail/cygwin/2021-August/249124.html
+
+- Fix pty master closing error regarding attach_mutex.
+  Addresses: https://cygwin.com/pipermail/cygwin-developers/2021-October/012418.html
-- 
2.33.0

