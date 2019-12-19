Return-Path: <cygwin-patches-return-9869-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 43719 invoked by alias); 19 Dec 2019 11:03:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 43707 invoked by uid 89); 19 Dec 2019 11:03:53 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-17.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: conuserg-03.nifty.com
Received: from conuserg-03.nifty.com (HELO conuserg-03.nifty.com) (210.131.2.70) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 19 Dec 2019 11:03:50 +0000
Received: from localhost.localdomain (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conuserg-03.nifty.com with ESMTP id xBJB3cw1004269;	Thu, 19 Dec 2019 20:03:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-03.nifty.com xBJB3cw1004269
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1576753425;	bh=qJMnWnrL9cHgW9zugpa6PrIEuWnnb3C1wjgPgpeb7rg=;	h=From:To:Cc:Subject:Date:From;	b=M9a80wfr5IkrrI+pMU7A76ns1RWTjByT4YDnIBHw7FuknQ7dRxpI5OvQYXkfFW3I1	 FV0xDO129Xkm6OrzJxg7yyTAMgzSWD50JuLZbUY8GqGVC/zoMj7+zyNmLRnq7q7IYg	 dyuf/0a+6C9w8e0NuMTBolXWNKBDVsW2y31Y6IvTqYL4Jee28yBe5tWxSPmzthgVbu	 GbRZuS+4xhA5bNT3f93oXwP354J2Z0KAJIJPAdXyhss/Lksi2DlYrU1KvXZH2DnI/g	 B1/QU2pa40oiGbWrzw3O9gM/ZgKJgPY5Ab90GI78F1kal4oXhGMVn8jmA2MEHXkUrH	 9hnu+p0YPyF6g==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Fix ESC[?3h and ESC[?3l handling again.
Date: Thu, 19 Dec 2019 11:03:00 -0000
Message-Id: <20191219110330.1902-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00140.txt.bz2

- Even with commit fe512b2b12a2cea8393d14f038dc3914b1bf3f60, pty
  still has a problem in ESC[?3h and ESC[?3l handling if invalid
  sequence such as ESC[?$ is sent. This patch fixes the issue.
---
 winsup/cygwin/fhandler_tty.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 8c3a6e72e..f10f0fc61 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1263,7 +1263,7 @@ fhandler_pty_slave::push_to_pcon_screenbuffer (const char *ptr, size_t len)
     {
       p0 += 3;
       bool exist_arg_3 = false;
-      while (p0 < buf + nlen && !isalpha (*p0))
+      while (p0 < buf + nlen && (isdigit (*p0) || *p0 == ';'))
 	{
 	  int arg = 0;
 	  while (p0 < buf + nlen && isdigit (*p0))
-- 
2.21.0
