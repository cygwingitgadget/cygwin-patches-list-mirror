Return-Path: <cygwin-patches-return-9679-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2038 invoked by alias); 15 Sep 2019 04:06:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 1913 invoked by uid 89); 15 Sep 2019 04:06:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=UD:jp, 8578, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-01.nifty.com
Received: from conuserg-01.nifty.com (HELO conuserg-01.nifty.com) (210.131.2.68) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 15 Sep 2019 04:06:16 +0000
Received: from localhost.localdomain (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conuserg-01.nifty.com with ESMTP id x8F45sLp026084;	Sun, 15 Sep 2019 13:06:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-01.nifty.com x8F45sLp026084
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1568520362;	bh=ITVe9frNbJWxLfOAl0x00EXD9mThI6ywxLivahg8I1U=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=vRZ4UeI8Q9wv7P7kPobJtncn3ieAzUWevw7MSsl8xhqowdfj31HIEnWINyqyORNX5	 6ZFlUW5lCLuhjguzvwLH4eVNmNgs84cFV14+QZc5XpgQ/npnie1PoKQVjNS/uGujLs	 ++VTaM1BChnD1BMqCzXHh5xFwqUCUb9gz5kedPQyaqo5XvuLasaVu++gCHjfcIEhu9	 ghixqwtyUoGzUcLH6WJrTBhZ8eM+nGY+b8asE5qZ8/C4MwYzIz5cJr98z8xUlLo3pR	 T2RiX3AnVNhnN4zmK68osxDKm8LjerHq0tbB9OAyQebG9tPJ8zi9Le1o4/5XQYn57H	 iO8Lm2QxwDaCg==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 1/3] Cygwin: pty: Fix bad file descriptor error in some environment.
Date: Sun, 15 Sep 2019 04:06:00 -0000
Message-Id: <20190915040553.849-2-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190915040553.849-1-takashi.yano@nifty.ne.jp>
References: <20190915040553.849-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00199.txt.bz2

- The bad file descriptor problem reported in:
  https://cygwin.com/ml/cygwin-patches/2019-q3/msg00104.html
  was recurring. Fixed again.
---
 winsup/cygwin/fhandler_tty.cc | 2 --
 1 file changed, 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 9aa832641..1b1d54447 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -857,8 +857,6 @@ fhandler_pty_slave::open (int flags, mode_t)
       pcon_attached_to = get_minor ();
       init_console_handler (true);
     }
-  else if (pcon_attached_to < 0)
-    fhandler_console::need_invisible ();
 
   set_open_status ();
   return 1;
-- 
2.21.0
