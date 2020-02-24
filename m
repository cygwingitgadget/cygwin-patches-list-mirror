Return-Path: <cygwin-patches-return-10109-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 98610 invoked by alias); 24 Feb 2020 16:12:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 98600 invoked by uid 89); 24 Feb 2020 16:12:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: conuserg-06.nifty.com
Received: from conuserg-06.nifty.com (HELO conuserg-06.nifty.com) (210.131.2.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 24 Feb 2020 16:12:34 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-06.nifty.com with ESMTP id 01OGCO81023390;	Tue, 25 Feb 2020 01:12:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-06.nifty.com 01OGCO81023390
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1582560749;	bh=eINjFpfx9QqS01+tc+2qNseV7WdYVdn8TKryZi7HQLo=;	h=From:To:Cc:Subject:Date:From;	b=i1vgIBIlkE0092aod9XARzSjcBIaGWrZFHP86FnJIBVCPghJaIGuJO3JwVngDmpNb	 gc6rV4BFgmUt9RXCKfux+hTLyhg0KBcuYyBNdat/eOO+zTEiZe/EY2W0m3iVrS+SpL	 S5T0g2ugV/jl2DRYE9MhLaVU1a1ym7VtvGusRjLyuNqa0ug+CZGyP3g2pg7wC762W2	 W7uGWGXiALz9THBObEXDCbVXcaz8UsQLGlfCegyL9cWkY/Q7n9WwagrQRZEkh/JCA+	 ehwQTxo2s1veycyOwqqX0ehNCA10UDGl1k1QYY9sW4+dBoJrK2OoOv/QiXq5Knf4c3	 Be7YSKJLo+i4g==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2] Cygwin: console: Fix segfault on shared_console_info access.
Date: Mon, 24 Feb 2020 16:12:00 -0000
Message-Id: <20200224161217.1879-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00215.txt

- Accessing shared_console_info before initialization causes access
  violation because it is a NULL pointer. The cause of the problem
  reported in https://cygwin.com/ml/cygwin/2020-02/msg00197.html is
  this NULL pointer access in request_xterm_mode_output() when it is
  called from close(). This patch makes sure that shared_console_info
  is not NULL before calling request_xterm_mode_output().
---
 winsup/cygwin/fhandler_console.cc | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 42040a971..328424a7d 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -1159,18 +1159,17 @@ fhandler_console::close ()
 
   acquire_output_mutex (INFINITE);
 
-  if (shared_console_info && myself->pid == con.owner &&
-      wincap.has_con_24bit_colors () && !con_is_legacy)
-    request_xterm_mode_output (false);
-
-  /* Restore console mode if this is the last closure. */
-  OBJECT_BASIC_INFORMATION obi;
-  NTSTATUS status;
-  status = NtQueryObject (get_handle (), ObjectBasicInformation,
-			  &obi, sizeof obi, NULL);
-  if (NT_SUCCESS (status) && obi.HandleCount == 1)
-    if (wincap.has_con_24bit_colors ())
-      request_xterm_mode_output (false);
+  if (shared_console_info && wincap.has_con_24bit_colors ())
+    {
+      /* Restore console mode if this is the last closure. */
+      OBJECT_BASIC_INFORMATION obi;
+      NTSTATUS status;
+      status = NtQueryObject (get_handle (), ObjectBasicInformation,
+			      &obi, sizeof obi, NULL);
+      if ((NT_SUCCESS (status) && obi.HandleCount == 1)
+	  || myself->pid == con.owner)
+	request_xterm_mode_output (false);
+    }
 
   release_output_mutex ();
 
-- 
2.21.0
