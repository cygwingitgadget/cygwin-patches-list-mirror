Return-Path: <cygwin-patches-return-10040-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 85388 invoked by alias); 4 Feb 2020 12:26:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 85374 invoked by uid 89); 4 Feb 2020 12:26:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-17.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*Ad:D*jp, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-04.nifty.com
Received: from conuserg-04.nifty.com (HELO conuserg-04.nifty.com) (210.131.2.71) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 04 Feb 2020 12:26:12 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-04.nifty.com with ESMTP id 014CPoSE001263;	Tue, 4 Feb 2020 21:25:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-04.nifty.com 014CPoSE001263
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1580819155;	bh=Auq02cQiKKXHLQWyx5Nd5hhoJi/Yo14p6Xf+P0W/1HQ=;	h=From:To:Cc:Subject:Date:From;	b=hzRjUe5eoXIoim+6+IZpGaFdE0zLXT37GJ8Iu+Q2HiOyCB5SEstkXsMFQW2W2jRSS	 3WzQd5K2meJGIZs8Rlc9/S3UCaWcS62Ko/SNDQhbj6KamrM1Svtz7SV/R6pkNvkikN	 UEcxtHXzPi3AoOlLwICk7YTkQpAyPY9BVFZc0Os6NZ9Ah0Q4T040iH8Bh9F1y3FAom	 vMQGGntZ9tFqvbsF7Q2q3SxYcC19TEGvnKIBefC7QEHmXjomQSjKcAkK84yuTV9XHT	 SiUxGVe68R19KM+pOen0DpmaQZ3r+RBDKLXW7aWmevfl/6ysI3PccRuh258h5TVpHN	 6slvMlFEM2EJA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Remove meaningless pointer increment.
Date: Tue, 04 Feb 2020 12:26:00 -0000
Message-Id: <20200204122552.993-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00146.txt

- Since commit 73742508fcd8e994450582c1b7296c709da66764, a pointer
  increment in master write code which has no effect was remaining.
---
 winsup/cygwin/fhandler_tty.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index c1c0fb812..1dd57b369 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2338,7 +2338,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
       WriteFile (to_slave, "\003", 1, &n, 0);
     }
 
-  line_edit_status status = line_edit (p++, len, ti, &ret);
+  line_edit_status status = line_edit (p, len, ti, &ret);
   if (status > line_edit_signalled && status != line_edit_pipe_full)
     ret = -1;
   return ret;
-- 
2.21.0
