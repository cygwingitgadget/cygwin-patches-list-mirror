Return-Path: <cygwin-patches-return-9558-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 51362 invoked by alias); 12 Aug 2019 13:46:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 51322 invoked by uid 89); 12 Aug 2019 13:46:37 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-21.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:839, HContent-Transfer-Encoding:8bit, H*F:D*jp
X-HELO: conuserg-03.nifty.com
Received: from conuserg-03.nifty.com (HELO conuserg-03.nifty.com) (210.131.2.70) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 12 Aug 2019 13:46:36 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-03.nifty.com with ESMTP id x7CDkP1O012869;	Mon, 12 Aug 2019 22:46:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-03.nifty.com x7CDkP1O012869
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1565617592;	bh=K5Rm5HfKpTfpHh92LuJjq+TYM6S4oqJgLnXwVQ8Y2XI=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=cvX7dltEl9qLChSUPwjM3m/27XT4GDrD0ttTt22xl194nOxySI20UJf5ZlsXUqTy/	 oVh0lPwY7qgzAyxvYViz7VMyWR8WqJl6cHqmt3Knm6guxDTmG/hUDdGUisyI04R+Yj	 yfW3oKSThjyx5Jp+CFKZ9ZJPVifXtBqnY7suhtNElf/92ukXA6rbjWodwqM1NTCyBt	 YU+atDy/l0xkrI39Xn8L+OOXnmXJrnKgryi/SNcjstk1xDE870/iO9peK214SJovt1	 K074B3AuJFcumw7fw7vRjP3bFAqjQdYPcbLhmVnirW7HiEHHhih5yXqq+dA4yWNME+	 sneqt6rbQAU7A==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 1/1] Cygwin: console: Fix deadlock at calling fork().
Date: Mon, 12 Aug 2019 13:46:00 -0000
Message-Id: <20190812134623.2102-2-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190812134623.2102-1-takashi.yano@nifty.ne.jp>
References: <20190812134623.2102-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00078.txt.bz2

- Calling fork() on console occasionally falls into deadlock. The reason
  is not clear, however, this patch fixes this problem anyway.
---
 winsup/cygwin/fhandler_console.cc | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 3d26a0b90..4afb7efb7 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -168,8 +168,12 @@ fhandler_console::set_unit ()
       if (created)
 	con.owner = getpid ();
     }
-  if (!created && shared_console_info && kill (con.owner, 0) == -1)
-    con.owner = getpid ();
+  if (!created && shared_console_info)
+    {
+      pinfo p (con.owner);
+      if (!p)
+	con.owner = getpid ();
+    }
 
   dev ().parse (devset);
   if (devset != FH_ERROR)
-- 
2.21.0
