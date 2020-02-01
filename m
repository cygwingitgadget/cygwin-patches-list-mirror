Return-Path: <cygwin-patches-return-10038-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 127719 invoked by alias); 1 Feb 2020 04:30:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 127701 invoked by uid 89); 1 Feb 2020 04:30:53 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-17.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SCC_5_SHORT_WORD_LINES autolearn=ham version=3.3.1 spammy=
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 01 Feb 2020 04:29:14 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-05.nifty.com with ESMTP id 0114Sg00021883;	Sat, 1 Feb 2020 13:28:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com 0114Sg00021883
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1580531329;	bh=9gTHNfr2hH5w1JWdQlHSUk8ZuHQNY1JNwPEmjCxEdxU=;	h=From:To:Cc:Subject:Date:From;	b=Q4B9VizDCBfkPoMqdBj6D5Yi2ZvxZ8K6gRczZeXl1UKcxYXveyWTYJzamDbLsSUrC	 2Zfubq83qNWQ+rL7SD6qUG9L+GwphsyTLzuegkIvj2OUi9t7bbCe4+Zm4d/QNgij/N	 zyk6935JXfSg2wJXxIvxbSOeSSS6mUm/d2wpIi4oe6rtzhMd6uFxfyg7JK5pKfrTD5	 fJyPzF/X43Df05eY2Gafft4xt4CRCSBChZ56RRjvFg0vDl80T44iiLehGfwacyoAc8	 zHduFfC9pABca6R5aSGojSQZNYIH2q/UtA6GojV4VD0s1di1ykdd3Do6lPQ+YGzGBs	 LKtfKrmCagQsQ==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2] Cygwin: console: Revise color setting codes in legacy console mode.
Date: Sat, 01 Feb 2020 04:30:00 -0000
Message-Id: <20200201042839.1899-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00144.txt

- With this patch, foreground color and background color are allowed
  to be set simultaneously by 24 bit color escape sequence such as
  ESC[38;2;0;0;255;48;2;128;128;0m in legacy console mode.
---
 winsup/cygwin/fhandler.h          |  2 +-
 winsup/cygwin/fhandler_console.cc | 47 ++++++++++++++++++-------------
 2 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 80a78d14c..608932c9c 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1829,7 +1829,7 @@ enum ansi_intensity
 #define gotrparen 9
 #define eatpalette 10
 #define endpalette 11
-#define MAXARGS 10
+#define MAXARGS 16
 
 enum cltype
 {
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index f88d24701..38eed05f4 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -1952,7 +1952,7 @@ fhandler_console::char_command (char c)
   switch (c)
     {
     case 'm':   /* Set Graphics Rendition */
-       for (int i = 0; i <= con.nargs; i++)
+       for (int i = 0; i < con.nargs; i++)
 	 switch (con.args[i])
 	   {
 	     case 0:    /* normal color */
@@ -2020,38 +2020,39 @@ fhandler_console::char_command (char c)
 	       con.fg = FOREGROUND_BLUE | FOREGROUND_GREEN | FOREGROUND_RED;
 	       break;
 	     case 38:
-	       if (con.nargs < 1)
+	       if (con.nargs < i + 2)
 		 /* Sequence error (abort) */
 		 break;
-	       switch (con.args[1])
+	       switch (con.args[i + 1])
 		 {
 		 case 2:
-		   if (con.nargs != 4)
+		   if (con.nargs < i + 5)
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
+		   if (con.nargs < i + 3)
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
+	       if (con.nargs < i + 2)
 		 /* Sequence error (abort) */
 		 break;
-	       switch (con.args[1])
+	       switch (con.args[i + 1])
 		 {
 		 case 2:
-		   if (con.nargs != 4)
+		   if (con.nargs < i + 5)
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
+		   if (con.nargs < i + 3)
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
@@ -2806,7 +2808,7 @@ fhandler_console::write (const void *vsrc, size_t len)
 	    {
 	      src++;
 	      con.nargs++;
-	      if (con.nargs >= MAXARGS)
+	      if (con.nargs > MAXARGS)
 		con.nargs--;
 	    }
 	  else if (*src == ' ')
@@ -2819,6 +2821,9 @@ fhandler_console::write (const void *vsrc, size_t len)
 	    con.state = gotcommand;
 	  break;
 	case gotcommand:
+	  con.nargs ++;
+	  if (con.nargs > MAXARGS)
+	    con.nargs--;
 	  char_command (*src++);
 	  con.state = normal;
 	  break;
@@ -2871,6 +2876,8 @@ fhandler_console::write (const void *vsrc, size_t len)
 	    {
 	      con.state = gotarg1;
 	      con.nargs++;
+	      if (con.nargs > MAXARGS)
+		con.nargs--;
 	      src++;
 	    }
 	  else if (isalpha (*src))
-- 
2.21.0
