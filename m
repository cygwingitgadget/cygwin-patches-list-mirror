Return-Path: <cygwin-patches-return-9867-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 81984 invoked by alias); 18 Dec 2019 16:08:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 81969 invoked by uid 89); 18 Dec 2019 16:08:02 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-14.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=ESC, esc, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-02.nifty.com
Received: from conuserg-02.nifty.com (HELO conuserg-02.nifty.com) (210.131.2.69) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 18 Dec 2019 16:08:00 +0000
Received: from localhost.localdomain (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conuserg-02.nifty.com with ESMTP id xBIG7cT7024346;	Thu, 19 Dec 2019 01:07:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-02.nifty.com xBIG7cT7024346
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1576685264;	bh=N7C4hMJIUmjmXt72dA8sEiOoUPfJ6alJgSAwqBGNdO0=;	h=From:To:Cc:Subject:Date:From;	b=Bsx2eyl2orN2gcQPU1/TWA2ZPVIEhjrcmVIo92vwX47TaiF1cvtj6RONfJlaff1fd	 kI4vw3rV4qKwv4nesT90608b4svBKUN1D5BflyJK0eNfTDb0PM0YRoqOdhZoGXJwGR	 WdPtVS0LJlbjan0AepxUbv1/8Y74Xh+TaBseuNnWtuNgP/uePAwz8hO5FrnvPQVLg9	 hHtAGfu1w3oIK0ajbXXlD+b/DhUx1VwNIVpdgQ5GjUWrVpc9CgC5JjL0HsfbeH0hr/	 IWPBbs5hY5wQaQvoNmGU4O6qyDjhJpbeIJhv8DMmkFX1Fm7vnrx9xpxtV5vBERdAY3	 g/CQw1ziSYebA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Fix a bug regarding ESC[?3h and ESC[?3l handling.
Date: Wed, 18 Dec 2019 16:08:00 -0000
Message-Id: <20191218160733.2084-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00138.txt.bz2

- Midnight commander (mc) does not work after the commit
  1626569222066ee601f6c41b29efcc95202674b7 as reported in
  https://www.cygwin.com/ml/cygwin/2019-12/msg00173.html.
  This patch fixes the issue.
---
 winsup/cygwin/fhandler_tty.cc | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 1d344c7fe..8c3a6e72e 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1262,16 +1262,19 @@ fhandler_pty_slave::push_to_pcon_screenbuffer (const char *ptr, size_t len)
   while ((p0 = (char *) memmem (p0, nlen - (p0 - buf), "\033[?", 3)))
     {
       p0 += 3;
-      while (p0 < buf + nlen && *p0 != 'h' && *p0 != 'l')
+      bool exist_arg_3 = false;
+      while (p0 < buf + nlen && !isalpha (*p0))
 	{
 	  int arg = 0;
 	  while (p0 < buf + nlen && isdigit (*p0))
 	    arg = arg * 10 + (*p0 ++) - '0';
 	  if (arg == 3)
-	    get_ttyp ()->need_redraw_screen = true;
+	    exist_arg_3 = true;
 	  if (p0 < buf + nlen && *p0 == ';')
 	    p0 ++;
 	}
+      if (p0 < buf + nlen && exist_arg_3 && (*p0 == 'h' || *p0 == 'l'))
+	get_ttyp ()->need_redraw_screen = true;
       p0 ++;
       if (p0 >= buf + nlen)
 	break;
-- 
2.21.0
