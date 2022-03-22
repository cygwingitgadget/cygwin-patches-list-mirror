Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id E74123947422
 for <cygwin-patches@cygwin.com>; Tue, 22 Mar 2022 14:29:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org E74123947422
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 22MET2Tt016309;
 Tue, 22 Mar 2022 23:29:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 22MET2Tt016309
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1647959347;
 bh=EUdPN+eRhuS/7d27688cCExD48WsVP3ITaRTeARNnB0=;
 h=From:To:Cc:Subject:Date:From;
 b=Jpl5IgBzSB7+RtItT3GLLGOvE744xOAambwvadU24LsEWbjgFUcXNioxoNDgYJW2R
 023NimwVSBhu7tZm+EbiQwFvZ5G+BLJOff6gaJXcUbYlUUqBiMF+nqTXR/+E+P9yGc
 vCKpnmEprW4pONq8xZcac2pjuc/pIxK6xVSMzdRkyLHL3Jku5S2vBKeAwS8ct5gNga
 nMPT0CSZ2CQCqgyVYxepsblMZBLT4TboxOxM2TdycmcGMnhHXFzHg8ajwJ6RrUMYVa
 LG027NOL6sOcng4PJ2pgId+95zwSjyu8GT8c19iSdujFH2xf0ZNbRmQ2mIxiGlRb1t
 g7D/V8oCPMiww==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pipe: Avoid deadlock for non-cygwin writer.
Date: Tue, 22 Mar 2022 23:28:53 +0900
Message-Id: <20220322142853.888-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Tue, 22 Mar 2022 14:29:40 -0000

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
 winsup/cygwin/sigproc.cc | 9 +++++++++
 winsup/cygwin/sigproc.h  | 1 +
 winsup/cygwin/spawn.cc   | 5 ++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

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
index fb3d09d84..54be7abec 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -645,8 +645,11 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 		     && (fd == fileno_stdout || fd == fileno_stderr))
 	      {
 		fhandler_pipe *pipe = (fhandler_pipe *)(fhandler_base *) cfd;
-		pipe->close_query_handle ();
 		pipe->set_pipe_non_blocking (false);
+		if (::cygheap->ctty)
+		  /* Emit __SIGNONCYGCHLD to let all processes in the
+		     process group close query_hdl. */
+		  ::cygheap->ctty->tc ()->kill_pgrp (__SIGNONCYGCHLD);
 	      }
 	    else if (cfd->get_dev () == FH_PIPER && fd == fileno_stdin)
 	      {
-- 
2.35.1

