Return-Path: <cygwin-patches-return-9637-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 82748 invoked by alias); 5 Sep 2019 10:45:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 82591 invoked by uid 89); 5 Sep 2019 10:45:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 05 Sep 2019 10:45:20 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-05.nifty.com with ESMTP id x85AiitW031038;	Thu, 5 Sep 2019 19:44:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com x85AiitW031038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567680291;	bh=0axgJ2FxAUx2fu7KCPdgrRsTpku/WtaH0FX8FZgtmsQ=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=JOFmW8/8A8AKRjfidmFARAd1xdBf4OGyitOpOTUyRMKxv0cgMz0ztrc31QKDo08GM	 UrT2OnRU7tRfYz6rR600dOgdOnvDwRABwyE7J3+ZTP3Z+s6I9HQXAt+2fZcwI1AgBg	 OAYZaIS2iZBwNmkEeImGS8Ru7SRhbUvdtidDRoWClUcEQScdFtjmtGDeOYOhAMpTCe	 NQaXz94y5XuzQhfUD+3tpBqtet/MIUiARRxnUvQWJ6OjWKEsownyQm5l1QpuQ5dptZ	 Yz6+qZKi9sGTMgj/1uN7xWaOxHS4d3jlm03taVgqb26sqORpDhEp1KAWFQDMCa/kOK	 BWD46D+5KzIIw==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 1/1] Cygwin: pty: Fix potential state mismatch regarding pseudo console.
Date: Thu, 05 Sep 2019 10:45:00 -0000
Message-Id: <20190905104441.2075-2-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190905104441.2075-1-takashi.yano@nifty.ne.jp>
References: <20190905104441.2075-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00157.txt.bz2

- PTY with pseudo console support sitll has problem which potentially
  cause state mismatch between state variable and real console state.
  This patch fixes this issue.
---
 winsup/cygwin/dtable.cc | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
index 4e9b6ed56..7b2e52005 100644
--- a/winsup/cygwin/dtable.cc
+++ b/winsup/cygwin/dtable.cc
@@ -159,14 +159,19 @@ dtable::stdio_init ()
 	    {
 	      bool attached = !!fhandler_console::get_console_process_id
 		(ptys->getHelperProcessId (), true);
-	      if (!attached)
+	      if (attached)
+		break;
+	      else
 		{
 		  /* Not attached to pseudo console in fork() or spawn()
 		     by some reason. This happens if the executable is
 		     a windows GUI binary, such as mintty. */
 		  FreeConsole ();
 		  if (AttachConsole (ptys->getHelperProcessId ()))
-		    break;
+		    {
+		      ptys->fixup_after_attach (false);
+		      break;
+		    }
 		}
 	    }
 	}
-- 
2.21.0
