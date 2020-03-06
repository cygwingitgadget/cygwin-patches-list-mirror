Return-Path: <cygwin-patches-return-10173-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15498 invoked by alias); 6 Mar 2020 01:55:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 15483 invoked by uid 89); 6 Mar 2020 01:55:37 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*Ad:D*jp, H*Ad:D*ne.jp, HX-Languages-Length:1328, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-06.nifty.com
Received: from conuserg-06.nifty.com (HELO conuserg-06.nifty.com) (210.131.2.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 06 Mar 2020 01:55:35 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-06.nifty.com with ESMTP id 0261tOCU024547;	Fri, 6 Mar 2020 10:55:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-06.nifty.com 0261tOCU024547
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1583459730;	bh=OenlEUatNPX4y/Ahhyfibyi9gNE9OFEi86adaB2245U=;	h=From:To:Cc:Subject:Date:From;	b=y6FP0PvWD3CgXLSJeF7uA3lNJiHBaEllFU6UXXf8VkSVE4F09UN5OITM8r6aZVYNV	 73EHhI0S75ICjeV9lGiQAgJzcc7XgxPSoVozoaXp5yEtHK68GiP1ejTOCCJpOMMGS+	 pZkqIzVOViI+wpg8sjwu1HrQc0Y+kn5j+tCPZWnH7NjnSik6emm2s9ypIeqFwz3wv/	 imhM8uPZ7/Zgl2SiF0lDFHvXCYsMXtnHDIqy6GDkwk+GM+FJBjQtX9eM+26cAuImSF	 Itf2Xty5ikU9bDQu6520xRaUIqbj1uUXYPVEQr7/UwjBbvyTL0xDLfjr3fuujlrwQU	 QTI5bkm4xmDHQ==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Fix behaviour of "ESC 8" after reset.
Date: Fri, 06 Mar 2020 01:55:00 -0000
Message-Id: <20200306015528.671-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00279.txt

- This patch matches the behaviour of "ESC 8" (DECRC) to the real
  xterm after full reset (RIS), soft reset (DECSTR) and "CSI 3 J".
---
 winsup/cygwin/fhandler_console.cc | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index c5f269168..72ccf7910 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -2114,6 +2114,11 @@ fhandler_console::char_command (char c)
 	  break;
 	case 'J': /* ED */
 	  wpbuf_put (c);
+	  if (con.args[0] == 3 && con.savey >= 0)
+	    {
+	      con.fillin (get_output_handle ());
+	      con.savey -= con.b.srWindow.Top;
+	    }
 	  if (con.args[0] == 3 && wincap.has_con_broken_csi3j ())
 	    { /* Workaround for broken CSI3J in Win10 1809 */
 	      CONSOLE_SCREEN_BUFFER_INFO sbi;
@@ -2158,6 +2163,7 @@ fhandler_console::char_command (char c)
 	    {
 	      con.scroll_region.Top = 0;
 	      con.scroll_region.Bottom = -1;
+	      con.savex = con.savey = -1;
 	    }
 	  wpbuf_put (c);
 	  /* Just send the sequence */
@@ -3063,6 +3069,7 @@ fhandler_console::write (const void *vsrc, size_t len)
 		{
 		  con.scroll_region.Top = 0;
 		  con.scroll_region.Bottom = -1;
+		  con.savex = con.savey = -1;
 		}
 	      /* ESC sequences below (e.g. OSC, etc) are left to xterm
 		 emulation in xterm compatible mode, therefore, are not
-- 
2.21.0
