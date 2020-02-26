Return-Path: <cygwin-patches-return-10127-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 94110 invoked by alias); 26 Feb 2020 15:34:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 94085 invoked by uid 89); 26 Feb 2020 15:34:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=dy, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-03.nifty.com
Received: from conuserg-03.nifty.com (HELO conuserg-03.nifty.com) (210.131.2.70) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 26 Feb 2020 15:34:08 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-03.nifty.com with ESMTP id 01QFXDfC021601;	Thu, 27 Feb 2020 00:34:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-03.nifty.com 01QFXDfC021601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1582731241;	bh=UaJBQqdAB2rCgdbTNkN+YnmQVZPdr9mh5NwzjYcl4pI=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=G79TeE8nZlYIdm1veWr0cyOsXK9ahyQgOqv9KXev2lrAVHdhLFTwAGPkpl5f83Vlm	 GngaCg/dxWkH0fzQezeUqGMjaEtyITKxjyGqk7bOTLuMRDb+LPQScwBeMP+dxEgtAt	 Ha/AQKX5ku92IH0Q5KXclyFCtqBw4IRjWLKtMiFDqnHMLAaNAsM5f4d0+HZ+4wTI2D	 sCoKHTqaVL31pdL+3qigjCQszzrY1VSumcngHF6JzFTqTybZ/FlNfO0pF5b0Hx25go	 zHYXZNgY8M6n4j3/S0jz2pHDJBCAk0p3KHm9xA1RnvwCrhR5yny9Edh4H20kPVwOXG	 xLh6Rijlw38cw==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 4/4] Cygwin: console: Add emulation of CSI3J on Win10 1809.
Date: Wed, 26 Feb 2020 15:34:00 -0000
Message-Id: <20200226153302.584-5-takashi.yano@nifty.ne.jp>
In-Reply-To: <20200226153302.584-1-takashi.yano@nifty.ne.jp>
References: <20200226153302.584-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00233.txt

- This patch add emulation of CSI3J, which is broken in Win10 1809,
  rather than ignoring it as before.
---
 winsup/cygwin/fhandler_console.cc | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index b0951497a..7f2e8af5c 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -2102,8 +2102,23 @@ fhandler_console::char_command (char c)
 	  break;
 	case 'J': /* ED */
 	  wpbuf_put (c);
-	  /* Ignore CSI3J in Win10 1809 because it is broken. */
-	  if (con.args[0] != 3 || !wincap.has_con_broken_csi3j ())
+	  if (con.args[0] == 3 && wincap.has_con_broken_csi3j ())
+	    { /* Workaround for broken CSI3J in Win10 1809 */
+	      CONSOLE_SCREEN_BUFFER_INFO sbi;
+	      GetConsoleScreenBufferInfo (get_output_handle (), &sbi);
+	      SMALL_RECT r = {0, sbi.srWindow.Top,
+		(SHORT) (sbi.dwSize.X - 1), (SHORT) (sbi.dwSize.Y - 1)};
+	      CHAR_INFO f = {' ', sbi.wAttributes};
+	      COORD d = {0, 0};
+	      ScrollConsoleScreenBufferA (get_output_handle (),
+					  &r, NULL, d, &f);
+	      SetConsoleCursorPosition (get_output_handle (), d);
+	      d = sbi.dwCursorPosition;
+	      d.Y -= sbi.srWindow.Top;
+	      SetConsoleCursorPosition (get_output_handle (), d);
+	    }
+	  else
+	    /* Just send the sequence */
 	    WriteConsoleA (get_output_handle (), wpbuf, wpixput, &wn, 0);
 	  break;
 	case 'h': /* DECSET */
-- 
2.21.0
