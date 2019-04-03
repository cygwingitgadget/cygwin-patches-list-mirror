Return-Path: <cygwin-patches-return-9306-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 77571 invoked by alias); 3 Apr 2019 16:26:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 77450 invoked by uid 89); 3 Apr 2019 16:26:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-17.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: conuserg-03.nifty.com
Received: from conuserg-03.nifty.com (HELO conuserg-03.nifty.com) (210.131.2.70) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 03 Apr 2019 16:26:45 +0000
Received: from localhost.localdomain (ntsitm424054.sitm.nt.ngn.ppp.infoweb.ne.jp [219.97.74.54]) (authenticated)	by conuserg-03.nifty.com with ESMTP id x33GPxpp019653;	Thu, 4 Apr 2019 01:26:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-03.nifty.com x33GPxpp019653
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1554308779;	bh=nitYjKWzSwRiKxLbuNiu9eUIbwiPLtkJO+w2cZSTb8s=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=Iy6aoQllCUs/KTZeJMwqOpKz/QKBNY5Ze7KtPvx/H3Y14aGZJ7J859CA6mH2qbXsZ	 FSjL5thzg7VRR01SAHhEmvMJs1MoJgfQjEZMdahPYY3a+i26C1UJu5m3izy1SqHoZN	 wWk1W3JBZj/SISGNSp//AJlUO/U0eCtLFF0vAKbLdjSjvqu0YSpf+cpzD4zamtuCub	 kGmTim2TgO6O7ULQ77bDGEaUeCd1i64Ynehthkoy5u32NuJTMXqQ8QrecTD+y2ouy4	 dXLx3MnQ+2zXS15qzJ0GroMcrv6JXZOYqFiOvoNmDdPCpxAC4/aFwtiyjJWSVLlzhb	 OKmfclGmdH0qw==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 1/1] Cygwin: console: fix key input for native console application
Date: Wed, 03 Apr 2019 16:26:00 -0000
Message-Id: <20190403162531.2837-2-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190403162531.2837-1-takashi.yano@nifty.ne.jp>
References: <20190403072758.GR3337@calimero.vinschen.de> <20190403162531.2837-1-takashi.yano@nifty.ne.jp>
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00013.txt.bz2

- After 24 bit color support patch, arrow keys and function keys
  do not work properly in native console applications if they
  are started in cygwin console. This patch fixes this issue.
---
 winsup/cygwin/fhandler_console.cc | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index d2e3184a6..335467b0b 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -455,6 +455,15 @@ sig_exit:
 fhandler_console::input_states
 fhandler_console::process_input_message (void)
 {
+  if (wincap.has_con_24bit_colors ())
+    {
+      DWORD dwMode;
+      /* Enable xterm compatible mode in input */
+      GetConsoleMode (get_handle (), &dwMode);
+      dwMode |= ENABLE_VIRTUAL_TERMINAL_INPUT;
+      SetConsoleMode (get_handle (), dwMode);
+    }
+
   char tmp[60];
 
   if (!shared_console_info)
@@ -2894,6 +2903,14 @@ fhandler_console::fixup_after_fork_exec (bool execing)
 {
   set_unit ();
   setup_io_mutex ();
+  if (wincap.has_con_24bit_colors ())
+    {
+      DWORD dwMode;
+      /* Disable xterm compatible mode in input */
+      GetConsoleMode (get_handle (), &dwMode);
+      dwMode &= ~ENABLE_VIRTUAL_TERMINAL_INPUT;
+      SetConsoleMode (get_handle (), dwMode);
+    }
 }
 
 // #define WINSTA_ACCESS (WINSTA_READATTRIBUTES | STANDARD_RIGHTS_READ | STANDARD_RIGHTS_WRITE | WINSTA_CREATEDESKTOP | WINSTA_EXITWINDOWS)
-- 
2.17.0
