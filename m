Return-Path: <cygwin-patches-return-9693-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27613 invoked by alias); 18 Sep 2019 14:29:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 27537 invoked by uid 89); 18 Sep 2019 14:29:39 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=pty, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-06.nifty.com
Received: from conuserg-06.nifty.com (HELO conuserg-06.nifty.com) (210.131.2.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 18 Sep 2019 14:29:38 +0000
Received: from localhost.localdomain (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conuserg-06.nifty.com with ESMTP id x8IETKE3031962;	Wed, 18 Sep 2019 23:29:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-06.nifty.com x8IETKE3031962
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1568816975;	bh=YO7h1Aa2lQEiXeTWzRznPu7wKWVBpcRLPeKuRau19wA=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=njcowyrq3hFLG4Tzg/S/o+FtA3ZPS45fNJ35qIaXq2z0FDaf2KXS6Bt/N86B/9stc	 oSG+qeLutgEGQrONLlzsO7xjLRlqaNcfs3sKTLmN0OzR4W97DdPbtAmuTDE50uriKT	 bmINyeUi8MPMsV9Kmz9ZCBJC0fOxTCZ40e0MrJiMBgeurq6OjyrNaJT9jq766xVHBf	 PcN97idaenU7r89k0fw4tInWh1bm1fn94rs0sachQwyaSFjt1lqMPWhorFvMP5kiY/	 xGgPjdyIcsRinq67nbiGuqeSBpsrOzOj7eNYMLtn8ljAsMeQiV8lYhzGk7IZnPxLB7	 BXTdtGeYKSqIQ==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 5/5] Cygwin: pty: Add missing guard when PTY is in the legacy mode.
Date: Wed, 18 Sep 2019 14:29:00 -0000
Message-Id: <20190918142921.835-6-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190918142921.835-1-takashi.yano@nifty.ne.jp>
References: <20190918142921.835-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00214.txt.bz2

---
 winsup/cygwin/fhandler_tty.cc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 2a92e44cf..1095c82eb 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -87,7 +87,8 @@ set_switch_to_pcon (void)
       {
 	fhandler_base *fh = cfd;
 	fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
-	ptys->set_switch_to_pcon (fd);
+	if (ptys->getPseudoConsole ())
+	  ptys->set_switch_to_pcon (fd);
       }
 }
 
@@ -105,6 +106,8 @@ force_attach_to_pcon (HANDLE h)
 	  {
 	    fhandler_base *fh = cfd;
 	    fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
+	    if (!ptys->getPseudoConsole ())
+	      continue;
 	    if (n != 0
 		|| h == ptys->get_handle ()
 		|| h == ptys->get_output_handle ())
-- 
2.21.0
