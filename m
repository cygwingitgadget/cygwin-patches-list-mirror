Return-Path: <cygwin-patches-return-10037-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 105956 invoked by alias); 1 Feb 2020 02:16:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 105947 invoked by uid 89); 1 Feb 2020 02:16:48 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-16.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SCC_5_SHORT_WORD_LINES autolearn=ham version=3.3.1 spammy=sk:BACKGRO, H*Ad:D*jp, sk:backgro, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 01 Feb 2020 02:16:45 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-05.nifty.com with ESMTP id 0112G7ng013562;	Sat, 1 Feb 2020 11:16:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com 0112G7ng013562
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1580523373;	bh=XH+BYl2xq9gmOZCBfEg/0zpRWxWeCDM2vIYy1dle26k=;	h=From:To:Cc:Subject:Date:From;	b=pXoNIgPA0xUrgiGip5lIvEpBLcs0sKHULZPn395s6qdBXmqWnQpq2pWzaa2od+4gf	 nlxI+sGwIbGegbQQei2/C9M3bvr0kSz3KErlucGVs3VWh0fY0ZnYnWSLFcZvIB30Rs	 WBp1cv6x3nAO9AXu3GRoE5Fk3YQpSey9rQ1UzftF5bgxd0Ap7aClF1mTPj73kv1ZWx	 7BT4vsqn7+ENb99v/rYmxskFEnOmFYZUKFpjPBcpPza9e1d5Jpx9ZFrU2LtUUtkTqp	 1YSGN6Z0jZPPK4mUzttTBMVUDzA67YbvLBEowN53EHeTMIHiFW+DgWP4lMcR1PGJux	 9JUM6GdxlCmfQ==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Revise color setting codes in legacy console mode.
Date: Sat, 01 Feb 2020 02:16:00 -0000
Message-Id: <20200201021601.1161-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00143.txt

- With this patch, foreground color and background color are allowed
  to be set simultaneously by escape sequence such as
  ESC[38;2;0;0;255;48;2;128;128;0m in legacy console mode.
---
 winsup/cygwin/fhandler_console.cc | 38 ++++++++++++++++---------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index f88d24701..e2832dad8 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -2020,38 +2020,39 @@ fhandler_console::char_command (char c)
 	       con.fg = FOREGROUND_BLUE | FOREGROUND_GREEN | FOREGROUND_RED;
 	       break;
 	     case 38:
-	       if (con.nargs < 1)
+	       if (con.nargs < i + 1)
 		 /* Sequence error (abort) */
 		 break;
-	       switch (con.args[1])
+	       switch (con.args[i + 1])
 		 {
 		 case 2:
-		   if (con.nargs != 4)
+		   if (con.nargs < i + 4)
 		     /* Sequence error (abort) */
 		     break;
-		   r = con.args[2];
-		   g = con.args[3];
-		   b = con.args[4];
+		   r = con.args[i + 2];
+		   g = con.args[i + 3];
+		   b = con.args[i + 4];
 		   r = r < (95 + 1) / 2 ? 0 : r > 255 ? 5 : (r - 55 + 20) / 40;
 		   g = g < (95 + 1) / 2 ? 0 : g > 255 ? 5 : (g - 55 + 20) / 40;
 		   b = b < (95 + 1) / 2 ? 0 : b > 255 ? 5 : (b - 55 + 20) / 40;
 		   con.fg = table256[16 + r*36 + g*6 + b];
+		   i += 4;
 		   break;
 		 case 5:
-		   if (con.nargs != 2)
+		   if (con.nargs < i + 2)
 		     /* Sequence error (abort) */
 		     break;
 		   {
-		     int idx = con.args[2];
+		     int idx = con.args[i + 2];
 		     if (idx < 0)
 		       idx = 0;
 		     if (idx > 255)
 		       idx = 255;
 		     con.fg = table256[idx];
+		     i += 2;
 		   }
 		   break;
 		 }
-	       i += con.nargs;
 	       break;
 	     case 39:
 	       con.fg = con.default_color & FOREGROUND_ATTR_MASK;
@@ -2081,38 +2082,39 @@ fhandler_console::char_command (char c)
 	       con.bg = BACKGROUND_BLUE | BACKGROUND_GREEN | BACKGROUND_RED;
 	       break;
 	     case 48:
-	       if (con.nargs < 1)
+	       if (con.nargs < i + 1)
 		 /* Sequence error (abort) */
 		 break;
-	       switch (con.args[1])
+	       switch (con.args[i + 1])
 		 {
 		 case 2:
-		   if (con.nargs != 4)
+		   if (con.nargs < i + 4)
 		     /* Sequence error (abort) */
 		     break;
-		   r = con.args[2];
-		   g = con.args[3];
-		   b = con.args[4];
+		   r = con.args[i + 2];
+		   g = con.args[i + 3];
+		   b = con.args[i + 4];
 		   r = r < (95 + 1) / 2 ? 0 : r > 255 ? 5 : (r - 55 + 20) / 40;
 		   g = g < (95 + 1) / 2 ? 0 : g > 255 ? 5 : (g - 55 + 20) / 40;
 		   b = b < (95 + 1) / 2 ? 0 : b > 255 ? 5 : (b - 55 + 20) / 40;
 		   con.bg = table256[16 + r*36 + g*6 + b] << 4;
+		   i += 4;
 		   break;
 		 case 5:
-		   if (con.nargs != 2)
+		   if (con.nargs < i + 2)
 		     /* Sequence error (abort) */
 		     break;
 		   {
-		     int idx = con.args[2];
+		     int idx = con.args[i + 2];
 		     if (idx < 0)
 		       idx = 0;
 		     if (idx > 255)
 		       idx = 255;
 		     con.bg = table256[idx] << 4;
+		     i += 2;
 		   }
 		   break;
 		 }
-	       i += con.nargs;
 	       break;
 	     case 49:
 	       con.bg = con.default_color & BACKGROUND_ATTR_MASK;
-- 
2.21.0
