Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id 099853841470
 for <cygwin-patches@cygwin.com>; Mon, 27 Jun 2022 01:51:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 099853841470
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 25R1of2t006176;
 Mon, 27 Jun 2022 10:50:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 25R1of2t006176
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1656294656;
 bh=u0MJKPgQ5silIAKyThy6fVdcXxOmToo0gOMjrO/gaqQ=;
 h=From:To:Cc:Subject:Date:From;
 b=uwccYcUG1fbMdpuYvpd6VWHyFHqyaCVAmwaN2qP+gX9fdrG8wEDrNmUz4foPERpet
 3Rh/AD9uYtr08DGqHj70KW7lNCrY4fW8bsV+vb9B3Zqhpgf287AXXHpS+QZLXo2GYL
 2+IZGRfJNp3qkoVavyl+JoN6yEcg4PlxFBPEoAyRn9r0Nb5oWAM/wNLE8SeDTBZdCY
 Tjib/RsoukB55RuW3Im2uCYhM7L47LN135OKzl1DLhO2/S1jFO02p2+uVXCy2qTHOp
 WEWMNLAuYSk1noCSzKgzdLUBOXuScwzGhiOI7wloA52BOF0f1o+v5VZGcL3X6CWsho
 DFZlrGK71Jurw==
X-Nifty-SrcIP: [119.150.44.95]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: poll: Fix a bug on inquiring same fd with different
 events.
Date: Mon, 27 Jun 2022 10:50:32 +0900
Message-Id: <20220627015032.278-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Mon, 27 Jun 2022 01:51:18 -0000

- poll() has a bug that it returns event which is not inquired if
  events are inquired in multiple pollfd entries on the same fd at
  the same time. This patch fixes the issue.
Addresses: https://cygwin.com/pipermail/cygwin/2022-June/251732.html
---
 winsup/cygwin/poll.cc       | 8 +++++---
 winsup/cygwin/release/3.3.6 | 5 +++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/poll.cc b/winsup/cygwin/poll.cc
index 440413433..a67507bbd 100644
--- a/winsup/cygwin/poll.cc
+++ b/winsup/cygwin/poll.cc
@@ -104,7 +104,7 @@ poll (struct pollfd *fds, nfds_t nfds, int timeout)
 	    fds[i].revents = POLLHUP;
 	  else
 	    {
-	      if (FD_ISSET(fds[i].fd, read_fds))
+	      if ((fds[i].events & POLLIN) && FD_ISSET(fds[i].fd, read_fds))
 		/* This should be sufficient for sockets, too.  Using
 		   MSG_PEEK, as before, can be considered dangerous at
 		   best.  Quote from W. Richard Stevens: "The presence
@@ -122,9 +122,11 @@ poll (struct pollfd *fds, nfds_t nfds, int timeout)
 		fds[i].revents |= (POLLIN | POLLERR);
 	      else
 		{
-		  if (FD_ISSET(fds[i].fd, write_fds))
+		  if ((fds[i].events & POLLOUT)
+		      && FD_ISSET(fds[i].fd, write_fds))
 		    fds[i].revents |= POLLOUT;
-		  if (FD_ISSET(fds[i].fd, except_fds))
+		  if ((fds[i].events & POLLPRI)
+		      && FD_ISSET(fds[i].fd, except_fds))
 		    fds[i].revents |= POLLPRI;
 		}
 	    }
diff --git a/winsup/cygwin/release/3.3.6 b/winsup/cygwin/release/3.3.6
index 49ac58ba4..f1a4b7812 100644
--- a/winsup/cygwin/release/3.3.6
+++ b/winsup/cygwin/release/3.3.6
@@ -17,3 +17,8 @@ Bug Fixes
 
 - Handle setting very long window title correctly in console.
   Addresses: https://cygwin.com/pipermail/cygwin/2022-June/251662.html
+
+- Fix a bug of poll() that it returns event which is not inquired
+  if events are inquired in multiple pollfd entries on the same fd
+  at the same time.
+  Addresses: https://cygwin.com/pipermail/cygwin/2022-June/251732.html
-- 
2.36.1

