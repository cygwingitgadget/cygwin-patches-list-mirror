Return-Path: <cygwin-patches-return-9568-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17207 invoked by alias); 15 Aug 2019 05:03:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 17187 invoked by uid 89); 15 Aug 2019 05:03:23 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:898, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 15 Aug 2019 05:03:22 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-05.nifty.com with ESMTP id x7F539N3011273;	Thu, 15 Aug 2019 14:03:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com x7F539N3011273
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1565845397;	bh=4GUIXKHk/bs0Cf5mEvnry8vyJ6iAJdU65HGa1DTf5VY=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=ESZYLkpg9AQphu9aPVlD9+LG01KFXG1zNky9LI1ZVBlPOQhUtMg9l8WL01OGx+l5/	 sQsPJMlOTDkE//j1QL9lBVJldRFATOKFEELD69Kp4z5zG9bHAmwZ85RJxg7gUnLgv0	 Kd4SRYYJen1dBIPPQwQvavyleOLcND91uxwwWm0Hzj24c/vi6gxzsuTqxESwEU/nF9	 SrBfi3bqfqZx+qxuqqp8MHzXLr5gtJSrY8rcvhmSAgewenbFNUc4KLLt+Afr4DsAUv	 ezYCJyh0BTvXddwx0zbGVBHanr0Th0ExYgQCu+kbuuc23hlbwtqwXxHJA2YBYxtp2N	 DiFYFlgihQYfA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 1/1] Cygwin: console: Fix the condition to interrupt select() by SIGWINCH
Date: Thu, 15 Aug 2019 05:03:00 -0000
Message-Id: <20190815050300.6380-2-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190815050300.6380-1-takashi.yano@nifty.ne.jp>
References: <20190815050300.6380-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00088.txt.bz2

- Add code so that select() is not interrupted by SIGWINCH if it is
  ignored (SIG_IGN or SIG_DFL).
---
 winsup/cygwin/select.cc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 9cf892801..4e9256b9f 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1045,7 +1045,9 @@ peek_console (select_record *me, bool)
       else if (!PeekConsoleInputW (h, &irec, 1, &events_read) || !events_read)
 	break;
       fh->acquire_input_mutex (INFINITE);
-      if (fhandler_console::input_winch == fh->process_input_message ())
+      if (fhandler_console::input_winch == fh->process_input_message ()
+	  && global_sigs[SIGWINCH].sa_handler != SIG_IGN
+	  && global_sigs[SIGWINCH].sa_handler != SIG_DFL)
 	{
 	  set_sig_errno (EINTR);
 	  fh->release_input_mutex ();
-- 
2.21.0
