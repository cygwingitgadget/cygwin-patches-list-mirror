Return-Path: <cygwin-patches-return-9905-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 63103 invoked by alias); 10 Jan 2020 11:47:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 63018 invoked by uid 89); 10 Jan 2020 11:47:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=mintty, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 10 Jan 2020 11:47:23 +0000
Received: from localhost.localdomain (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conuserg-05.nifty.com with ESMTP id 00ABlD4H027641;	Fri, 10 Jan 2020 20:47:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com 00ABlD4H027641
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1578656838;	bh=koxMD8h3dlmR9YMTWAunnpxU3h0bmc52iYbJjurhQwg=;	h=From:To:Cc:Subject:Date:From;	b=TTgS4wzDlWWNs6YHsPESTt+xqmKl1r4IGzuh/bHv/2rvHKB+zYFWRxuLJTtjXj8Kg	 6AplfNa0BD49hIGBfCe79hAp3bBFroRVC8CTnEbHq+B0SdKvyS2ta+jMGfkx1K9Glw	 leQHT3XrmtAULsoR2pbJtw9qmPpXFN7YveG3xydoWVmCfJMgNvqjSevE9bJJhuRcvq	 L+v/8Xt53hOqquDSZnzMO7AEtZfXdRDZiAGO0gldktTDwHdxYFivVG16zHSsPuzs+X	 Itheks2pYERe39uo3htkCJRP1H0HpOG+wd959dLxWwECJjVkN2FW0yMdvh3EowjrIa	 t00nu0Ol8R9uQ==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Set console code page only if pseudo console is enabled.
Date: Fri, 10 Jan 2020 11:47:00 -0000
Message-Id: <20200110114712.435-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00011.txt

- Input UTF-8 chars are garbled in ConEmu with cygwin connector if
  the environment does not support pseudo console. This patch fixes
  the issue.
---
 winsup/cygwin/fhandler_tty.cc | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 368054beb..14b39eb02 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2642,15 +2642,18 @@ fhandler_pty_slave::setup_locale (void)
   LCID lcid = get_langinfo (locale, charset);
 
   /* Set console code page form locale */
-  UINT code_page;
-  if (lcid == 0 || lcid == (LCID) -1)
-    code_page = 20127; /* ASCII */
-  else if (!GetLocaleInfo (lcid,
-			   LOCALE_IDEFAULTCODEPAGE | LOCALE_RETURN_NUMBER,
-			   (char *) &code_page, sizeof (code_page)))
-    code_page = 20127; /* ASCII */
-  SetConsoleCP (code_page);
-  SetConsoleOutputCP (code_page);
+  if (get_pseudo_console ())
+    {
+      UINT code_page;
+      if (lcid == 0 || lcid == (LCID) -1)
+	code_page = 20127; /* ASCII */
+      else if (!GetLocaleInfo (lcid,
+			       LOCALE_IDEFAULTCODEPAGE | LOCALE_RETURN_NUMBER,
+			       (char *) &code_page, sizeof (code_page)))
+	code_page = 20127; /* ASCII */
+      SetConsoleCP (code_page);
+      SetConsoleOutputCP (code_page);
+    }
 
   /* Set terminal code page from locale */
   /* This code is borrowed from mintty: charset.c */
-- 
2.21.0
