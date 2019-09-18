Return-Path: <cygwin-patches-return-9692-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27600 invoked by alias); 18 Sep 2019 14:29:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 27536 invoked by uid 89); 18 Sep 2019 14:29:39 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=pty, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-06.nifty.com
Received: from conuserg-06.nifty.com (HELO conuserg-06.nifty.com) (210.131.2.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 18 Sep 2019 14:29:38 +0000
Received: from localhost.localdomain (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conuserg-06.nifty.com with ESMTP id x8IETKDt031962;	Wed, 18 Sep 2019 23:29:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-06.nifty.com x8IETKDt031962
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1568816967;	bh=ZraKJ8pHA+D6PFYtFJHrn09s/nya2+8YKCeNcssp4w8=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=aKCDGeYtooI06TqoJo5rwhQmL1xtHwJi4ljZNeNH+rPHQ1lMgwECeOk7uHbtSftRF	 NNV7WkWv6FzW5HNOPb56+0hCvdUDGeTJEb6vt6H51m3AAXeGuxgCXZeNL+noP9d56R	 gg6pmWXNCPEhYgXtKOtztoJwkCXqTsc4vSPkOSvhVt4qT3mXW7nNhnwwuQHsyP/WyY	 HNBAA/P1IIRxbfnmAry3PFky+eTzenKvk1VzC1p1OYOQydKGQF3r915mO3HUySWi7O	 QNX5kKYGpy9hyuqqFf6F0cdXoeLytTaYDTfSNtfAYRczLEX9Q4+jIIGrPGDIhViN8x	 l3HMzgY3PGGjg==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 1/5] Cygwin: pty: Avoid potential segfault in PTY code when ppid = 1.
Date: Wed, 18 Sep 2019 14:29:00 -0000
Message-Id: <20190918142921.835-2-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190918142921.835-1-takashi.yano@nifty.ne.jp>
References: <20190918142921.835-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00212.txt.bz2

---
 winsup/cygwin/fhandler_tty.cc | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 659e7b595..2a1c34f7d 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -137,9 +137,16 @@ force_attach_to_pcon (HANDLE h)
 		/* If the process is running on a console,
 		   the parent process should be attached
 		   to the same console. */
-		pinfo p (myself->ppid);
+		DWORD attach_wpid;
+		if (myself->ppid == 1)
+		  attach_wpid = ATTACH_PARENT_PROCESS;
+		else
+		  {
+		    pinfo p (myself->ppid);
+		    attach_wpid = p->dwProcessId;
+		  }
 		FreeConsole ();
-		if (AttachConsole (p->dwProcessId))
+		if (AttachConsole (attach_wpid))
 		  {
 		    pcon_attached_to = -1;
 		    attach_done = true;
-- 
2.21.0
