Return-Path: <cygwin-patches-return-9846-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 61354 invoked by alias); 13 Nov 2019 10:49:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 61344 invoked by uid 89); 13 Nov 2019 10:49:51 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-16.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=screen, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-03.nifty.com
Received: from conuserg-03.nifty.com (HELO conuserg-03.nifty.com) (210.131.2.70) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 13 Nov 2019 10:49:49 +0000
Received: from localhost.localdomain (ntsitm355024.sitm.nt.ngn.ppp.infoweb.ne.jp [175.184.70.24]) (authenticated)	by conuserg-03.nifty.com with ESMTP id xADAnXqe027699;	Wed, 13 Nov 2019 19:49:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-03.nifty.com xADAnXqe027699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1573642177;	bh=CXXEJn4TlvY7oPZX1ZVbbOZHowpL645Okf59oQVS714=;	h=From:To:Cc:Subject:Date:From;	b=J9im+bX1v4ZvgqDAxFur+2GAGwj5AvYj5mDgXdRF4i9WYWXFFV5JXD0bChrpYHweJ	 tdlyppCpw0w6+0Y8vkF0M4gmfYy5AJZjON15y6vNxXKy9GEhVdt4OJ/ykJR5a/u9ZL	 Je1B4GnzWmg/OGWsC4Zc8Kn1ht7eDUCT9mEJABJ1jl7AVX4XBKYuqehjGdztLyMYMT	 GhxzCpW/1TlPBz4rFbzlQdTWsYV/IvtbUOMIFfq2zw6oaj8aKcLaWQM+UTPCb3TXpg	 jJj1plzOyZQTfsHfNHZKxY0w+6/wGyUQQXeTlCcSgwpgmdPWCKUQn5ahUOpbel/5qF	 2AedTRN4TCQHA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Trigger redraw screen if ESC[?3h or ESC[?3l is sent.
Date: Wed, 13 Nov 2019 10:49:00 -0000
Message-Id: <20191113104929.748-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00117.txt.bz2

- Pseudo console clears console screen buffer if ESC[?3h or ESC[?3l
  is sent. However, xterm/vt100 does not clear screen. This cause
  mismatch between real screen and console screen buffer. Therefore,
  this patch triggers redraw screen in that situation so that the
  synchronization is done on the next execution of native app.
  This solves the problem reported in:
  https://www.cygwin.com/ml/cygwin-patches/2019-q4/msg00116.html
---
 winsup/cygwin/fhandler_tty.cc | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index e02a8f43b..f9c7c3ade 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1255,6 +1255,28 @@ fhandler_pty_slave::push_to_pcon_screenbuffer (const char *ptr, size_t len)
       memmove (p0, p0+4, nlen - (p0+4 - buf));
       nlen -= 4;
     }
+
+  /* If the ESC sequence ESC[?3h or ESC[?3l which clears console screen
+     buffer is pushed, set need_redraw_screen to trigger redraw screen. */
+  p0 = buf;
+  while ((p0 = (char *) memmem (p0, nlen - (p0 - buf), "\033[?", 3)))
+    {
+      p0 += 3;
+      while (p0 < buf + nlen && *p0 != 'h' && *p0 != 'l')
+	{
+	  int arg = 0;
+	  while (p0 < buf + nlen && isdigit (*p0))
+	    arg = arg * 10 + (*p0 ++) - '0';
+	  if (arg == 3)
+	    get_ttyp ()->need_redraw_screen = true;
+	  if (p0 < buf + nlen && *p0 == ';')
+	    p0 ++;
+	}
+      p0 ++;
+      if (p0 >= buf + nlen)
+	break;
+    }
+
   DWORD dwMode, flags;
   flags = ENABLE_VIRTUAL_TERMINAL_PROCESSING;
   GetConsoleMode (get_output_handle (), &dwMode);
-- 
2.21.0
