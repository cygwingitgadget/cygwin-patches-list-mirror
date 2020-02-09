Return-Path: <cygwin-patches-return-10047-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 98391 invoked by alias); 9 Feb 2020 14:46:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 98339 invoked by uid 89); 9 Feb 2020 14:46:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-17.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*Ad:D*jp, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-04.nifty.com
Received: from conuserg-04.nifty.com (HELO conuserg-04.nifty.com) (210.131.2.71) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 09 Feb 2020 14:46:28 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-04.nifty.com with ESMTP id 019Ek4Rd005877;	Sun, 9 Feb 2020 23:46:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-04.nifty.com 019Ek4Rd005877
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1581259576;	bh=/4+qoSpa1v29coJni1wL+qvfd5gMinkj4pph1unafK8=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=0BX7tjoW5fHRYGpLSlMMYJp83Mk09neBUBbCZvp3hsAEjADNDdBFcBIlhxP/dxANw	 8HkcCXI1MEtUg7X9NLdnpbG+ZyYHUp64m5Mo+dEKCzbTikr7EcnUcbHApGKraFcZfU	 zxB6vh3xi1vqHxah1GPVxUmlSGrZBGowSkrSi91wE6zmRyOxOPgxGsIChwGQ3KUJ4C	 KHFCltbd16tACUKxrjV8hRy4I7g1ual0eiiVQoJnx6V3UtG9tYp3XpuNN0tYBrg/PF	 vKtHv0is9/nPePsKVqqiadBcOIg5XNL5iZF7rhI/3xuoIomGgPUuP+2A8ANsjI/znD	 IfLTZ1BH3aVfg==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 4/4] Cygwin: pty: Add missing member initialization for struct pipe_reply.
Date: Sun, 09 Feb 2020 14:46:00 -0000
Message-Id: <20200209144603.389-5-takashi.yano@nifty.ne.jp>
In-Reply-To: <20200209144603.389-1-takashi.yano@nifty.ne.jp>
References: <20200209144603.389-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00153.txt

- For pseudo console support, struct pipe_reply was changed in the
  past, however, the initialization was not fixed.
---
 winsup/cygwin/fhandler_tty.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 36b3341b1..1c23c93e3 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2878,7 +2878,7 @@ fhandler_pty_master::pty_master_thread ()
   while (!exit && (ConnectNamedPipe (master_ctl, NULL)
 		   || GetLastError () == ERROR_PIPE_CONNECTED))
     {
-      pipe_reply repl = { NULL, NULL, NULL, 0 };
+      pipe_reply repl = { NULL, NULL, NULL, NULL, 0 };
       bool deimp = false;
       NTSTATUS allow = STATUS_ACCESS_DENIED;
       ACCESS_MASK access = EVENT_MODIFY_STATE;
-- 
2.21.0
