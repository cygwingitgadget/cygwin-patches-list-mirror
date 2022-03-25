Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id 50E4F385EC4E
 for <cygwin-patches@cygwin.com>; Fri, 25 Mar 2022 11:33:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 50E4F385EC4E
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 22PBWaon006685;
 Fri, 25 Mar 2022 20:32:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 22PBWaon006685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1648207961;
 bh=ZNIAZbu2IzJDPCXWUrEFnJQXH0wSsLGqQOXkod9AnPM=;
 h=From:To:Cc:Subject:Date:From;
 b=cyo4RarKeiyzmwNwLZzdsBBvlZ2lf9Lwy+YjBDDwsiXKyj47o169iQBo+t3Hb1ZIs
 Y+NkaPNcVbNBi+5lhSpDeBV7K75/L7cEyhxsgVIhy7FrRk5BplxHzY4gwCEM/KW6y6
 loJoPaJaRtsuH1IG4ycKl1dKjPmvrQdwqfvg3kcu8PQ5a27/cCW3Cjg3SvP/AJeRnT
 9eMHvZ0AyC1UsKzQ43NIobATHV5+uO92FJK9zS0OmplJGjoaSKQQeohmF57adiXKyp
 tphIJ2Gm+0+MzXOGJtzb4ok3tmyMsxF/Uil4CxUvbIwW4WFnzKtntUNjlqBAkkkdfW
 SUKlhvv9w4R6Q==
X-Nifty-SrcIP: [119.150.44.95]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v3] Cygwin: pipe: Avoid deadlock for non-cygwin writer.
Date: Fri, 25 Mar 2022 20:32:27 +0900
Message-Id: <20220325113227.1195-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Fri, 25 Mar 2022 11:33:12 -0000

- As mentioned in commit message of the commit b531d6b0, if multiple
  writers including non-cygwin app exist, the non-cygwin app cannot
  detect pipe closure on the read side when the pipe is created by
  system account or the the pipe creator is running as service.
  This is because query_hdl which is held in write side also is a
  read end of the pipe, so the pipe still alive for the non-cygwin
  app even after the reader is closed.

  To avoid this problem, this patch lets all processes in the same
  process group close query_hdl using newly introduced internal signal
  __SIGNONCYGCHLD when non-cygwin app is started to avoid the problem.

  Addresses: https://cygwin.com/pipermail/cygwin/2022-March/251097.html
---
 winsup/cygwin/sigproc.cc |  9 +++++++++
 winsup/cygwin/sigproc.h  |  1 +
 winsup/cygwin/spawn.cc   | 12 +++++++++++-
 3 files changed, 21 insertions(+), 1 deletion(-)

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
index fb3d09d84..3b65d32c8 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -28,6 +28,7 @@ details. */
 #include "tls_pbuf.h"
 #include "winf.h"
 #include "ntdll.h"
+#include "shared_info.h"
 
 static const suffix_info exe_suffixes[] =
 {
@@ -645,8 +646,17 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 		     && (fd == fileno_stdout || fd == fileno_stderr))
 	      {
 		fhandler_pipe *pipe = (fhandler_pipe *)(fhandler_base *) cfd;
-		pipe->close_query_handle ();
 		pipe->set_pipe_non_blocking (false);
+
+		tty_min dummy_tty;
+		dummy_tty.ntty = (fh_devices) myself->ctty;
+		dummy_tty.pgid = myself->pgid;
+		tty_min *t = cygwin_shared->tty.get_cttyp ();
+		if (!t) /* If tty is not allocated, use dummy_tty instead. */
+		  t = &dummy_tty;
+		/* Emit __SIGNONCYGCHLD to let all processes in the
+		   process group close query_hdl. */
+		t->kill_pgrp (__SIGNONCYGCHLD);
 	      }
 	    else if (cfd->get_dev () == FH_PIPER && fd == fileno_stdin)
 	      {
-- 
2.35.1

