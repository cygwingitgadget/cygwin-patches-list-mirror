Return-Path: <cygwin-patches-return-9896-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18899 invoked by alias); 1 Jan 2020 06:50:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 18890 invoked by uid 89); 1 Jan 2020 06:50:10 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-17.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: conuserg-06.nifty.com
Received: from conuserg-06.nifty.com (HELO conuserg-06.nifty.com) (210.131.2.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 01 Jan 2020 06:50:09 +0000
Received: from localhost.localdomain (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conuserg-06.nifty.com with ESMTP id 0016nlj1016066;	Wed, 1 Jan 2020 15:49:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-06.nifty.com 0016nlj1016066
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1577861392;	bh=ylJRDUKcHExxPm+vrTTbX9XJF2VcXoWRkh3VW50xhXk=;	h=From:To:Cc:Subject:Date:From;	b=2eP3Ns31VMvMvLDqZ72lCLLoxejKKlUiYoFnv52jJos+NjDTYK3BPlz/ji7Upw3Po	 ZHcgxvEJzpwqXXhJvl8qr4fjfR19dCT2ARaHv8ShXmMDUbJwQO63cdmwrvf3r4uuZ5	 LtXhKCvTGov2b2fDkW53Fiz7YM5ReNDBygKatn7TPp2PWb/7TccGVpYNdwINaf1GT9	 Jh7Iv9RyUR2iK6RwHszq/2zCXox3wyWdh6xYkFlGLeUO8SLk4ofwX5WfTRXLsJg+8r	 XIP26b2f/cb3NwAwh0PDWLa33CpcVbulxILTEz42TADKfGwWsTzXoypRwisrpXFHaq	 7xbR7Vcb/GyTw==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Remove destructor for fhandler_pty_master class.
Date: Wed, 01 Jan 2020 06:50:00 -0000
Message-Id: <20200101064941.8803-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00002.txt

- The destructor for fhandler_pty_master class does not seem to be
  necessary anymore. Therefore, it has been removed.
---
 winsup/cygwin/fhandler.h      | 1 -
 winsup/cygwin/fhandler_tty.cc | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 3954c37d1..4a71c1628 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2218,7 +2218,6 @@ public:
   HANDLE get_echo_handle () const { return echo_r; }
   /* Constructor */
   fhandler_pty_master (int);
-  ~fhandler_pty_master ();
 
   DWORD pty_master_thread ();
   DWORD pty_master_fwd_thread ();
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 23156f977..d3d0d7430 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2126,15 +2126,6 @@ fhandler_pty_master::fhandler_pty_master (int unit)
   set_name ("/dev/ptmx");
 }
 
-fhandler_pty_master::~fhandler_pty_master ()
-{
-  /* Without this wait, helper process for pseudo console
-     sometimes remains running after the pty session is
-     closed. The reason is not clear. */
-  if (to_master && from_master)
-    Sleep (20);
-}
-
 int
 fhandler_pty_master::open (int flags, mode_t)
 {
-- 
2.21.0
