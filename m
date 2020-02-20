Return-Path: <cygwin-patches-return-10088-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 58706 invoked by alias); 20 Feb 2020 11:52:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 58695 invoked by uid 89); 20 Feb 2020 11:52:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-16.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,RCVD_IN_JMF_BL autolearn=ham version=3.3.1 spammy=H*Ad:D*jp, HX-Languages-Length:955, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-03.nifty.com
Received: from conuserg-03.nifty.com (HELO conuserg-03.nifty.com) (210.131.2.70) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 20 Feb 2020 11:52:12 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-03.nifty.com with ESMTP id 01KBpqZJ032362;	Thu, 20 Feb 2020 20:51:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-03.nifty.com 01KBpqZJ032362
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1582199518;	bh=tfM+C51dAOw8mQIpq4RYUHr5Qn7b5sMR9laDrJvflws=;	h=From:To:Cc:Subject:Date:From;	b=ehIEUKWHV/Bx0vGoa0iNz3n/tVMhkq51wCsXy/duhORNDQ+wtnPEUlciwzxaBfXKy	 3DrHiuNpEKta3/Jreloe8fKsbbLwVGCEyZqbAY8UR7lfHHPsSla9Nazc7IhSF+wUiM	 TbCp3p/zBWw3cv84jCfo7jEVU0DygEQk+mtxE1DiWO8SohjEJzF+GYoTbsNysn7Qf1	 fskcC0NIJzVDrouJK7lD7s1mWvM8rb70y59iz7WLdbhlrmij+VSXSJIh2QT2uR3bIr	 rVbI1UZOfymwlPftJvdnGpkMuT2G+jLxkynXI13WT4kfF12nFlPM762319cbr+dDUv	 +hSwsKmPO4ZDA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Ignore 0x00 on write().
Date: Thu, 20 Feb 2020 11:52:00 -0000
Message-Id: <20200220115145.2033-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00194.txt

- In xterm compatible mode, 0x00 on write() behaves incompatible
  with real xterm. In xterm, 0x00 completely ignored. Therefore,
  0x00 is ignored by console with this patch.
---
 winsup/cygwin/fhandler_console.cc | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 66e645aa1..705ce696e 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -1794,6 +1794,16 @@ bool fhandler_console::write_console (PWCHAR buf, DWORD len, DWORD& done)
 	  len -= 4;
 	}
     }
+  /* Workaround for ^@ (0x00) handling in xterm compatible mode. */
+  if (wincap.has_con_24bit_colors () && !con_is_legacy)
+    {
+      WCHAR *p = buf;
+      while ((p = wmemchr (p, L'\0', len - (p - buf))))
+	{
+	  memmove (p, p+1, (len - (p+1 - buf))*sizeof (WCHAR));
+	  len --;
+	}
+    }
 
   if (con.iso_2022_G1
 	? con.vt100_graphics_mode_G1
-- 
2.21.0
