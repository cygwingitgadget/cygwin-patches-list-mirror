Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id 99A443858427
 for <cygwin-patches@cygwin.com>; Wed, 23 Mar 2022 08:48:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 99A443858427
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 22N8mBOl031859;
 Wed, 23 Mar 2022 17:48:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 22N8mBOl031859
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1648025296;
 bh=63il32n8Fual98v569mA51cPvkFK7YLUiBCc2wXCNFI=;
 h=From:To:Cc:Subject:Date:From;
 b=1ZdMOafVDjCZVhovPLhXpgKYJBTrhQuBY+eWQr/fCbap4LhzwsY+4iwnuapMwd0nD
 iEXIsMNFr6SxHkUWOyttCnaTp22kcwhZ+b6uUiPfwZ16Xf3ZCwrWZffqPfyOGlMVQe
 rL8VPnzv9JsgjnSCKqkL/jvDwT50Hi4NLlalb/Gxwuqm6yc03+s8I0d6Oqg5iv3b1c
 l0yCs4ZeKPgfn2VEg3QknGgpAd7pcxWxEutQfaY3g9e8Zh+cOz5Y7M/qu40GnvNc73
 5Vi8euUkXnZj6txuHWHbKgm9lIdAjsvm5jWyQAAUoTgr+EbwadUjuS4OF6EqXqAzlS
 9D0dvHUZN8h9Q==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2] Cygwin: pipe: Avoid deadlock for non-cygwin writer.
Date: Wed, 23 Mar 2022 17:48:01 +0900
Message-Id: <20220323084802.1917-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Wed, 23 Mar 2022 08:48:39 -0000

- As mentioned in commit message of the commit b531d6b0, if multiple
  writers including non-cygwin app exist, the non-cygwin app cannot
  detect pipe closure on the read side when the pipe is created by
  system account or the the pipe creator is running as service.
  This is because query_hdl which is held in write side also is a
  read end of the pipe, so the pipe still alive for the non-cygwin
  app even after the reader is closed.

  To avoid this problem, this patch lets all processes in the same
  process group close query_hdl using newly introduced internal signal
  __SIGNONCYGCHLD when non-cygwin app is started.

  Addresses: https://cygwin.com/pipermail/cygwin/2022-March/251097.html
---
 winsup/cygwin/sigproc.cc | 9 +++++++++
 winsup/cygwin/sigproc.h  | 1 +
 winsup/cygwin/spawn.cc   | 7 ++++++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index d3f2b0c6a..9a2f75861 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -1477,6 +1477,15 @@ wait_sig (VOID *)
 		clearwait = true;
 	    }
 	  break;
+	case __SIGNONCYGCHLD:
+	  cygheap_fdenum cfd (false);
+	  while (cfd.next () >= 0)
+	    if (cfd->get_dev () == FH_PIPEW)
+	      {
+		fhandler_pipe *pipe = (fhandler_pipe *)(fhandler_base *) cfd;
+		pipe->close_query_handle ();
+	      }
+	  break;
 	}
       if (clearwait && !have_execed)
 	proc_subproc (PROC_CLEARWAIT, 0);
diff --git a/winsup/cygwin/sigproc.h b/winsup/cygwin/sigproc.h
index 23287c85b..d037eaec3 100644
--- a/winsup/cygwin/sigproc.h
+++ b/winsup/cygwin/sigproc.h
@@ -24,6 +24,7 @@ enum
   __SIGSETPGRP	    = -(_NSIG + 9),
   __SIGTHREADEXIT   = -(_NSIG + 10),
   __SIGPENDINGALL   = -(_NSIG + 11),
+  __SIGNONCYGCHLD   = -(_NSIG + 12),
 };
 #endif
 
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index fb3d09d84..a32a4180c 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -28,6 +28,7 @@ details. */
 #include "tls_pbuf.h"
 #include "winf.h"
 #include "ntdll.h"
+#include "shared_info.h"
 
 static const suffix_info exe_suffixes[] =
 {
@@ -645,8 +646,12 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 		     && (fd == fileno_stdout || fd == fileno_stderr))
 	      {
 		fhandler_pipe *pipe = (fhandler_pipe *)(fhandler_base *) cfd;
-		pipe->close_query_handle ();
 		pipe->set_pipe_non_blocking (false);
+		tty_min *t = cygwin_shared->tty.get_cttyp ();
+		if (t)
+		  /* Emit __SIGNONCYGCHLD to let all processes in the
+		     process group close query_hdl. */
+		  t->kill_pgrp (__SIGNONCYGCHLD);
 	      }
 	    else if (cfd->get_dev () == FH_PIPER && fd == fileno_stdin)
 	      {
-- 
2.35.1

