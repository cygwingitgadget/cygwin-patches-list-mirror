Return-Path: <cygwin-patches-return-10156-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 54119 invoked by alias); 2 Mar 2020 01:14:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 54110 invoked by uid 89); 2 Mar 2020 01:14:47 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 02 Mar 2020 01:14:46 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-05.nifty.com with ESMTP id 0221D5nS031112;	Mon, 2 Mar 2020 10:14:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com 0221D5nS031112
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1583111682;	bh=CO2eOTFmTBMClwvQykkEXED/QO7W6vqdQz6uoe1MM8c=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=vgqQGF+w0CujjRKUVwhiScmgS3JoAXrwctKhpWnLN6G0v3xKrk7I2Qg4v49CRI+Gw	 gzwYxPlVQ8dTYgiAN+MYLJSHGqFomcyeJ94oOXDjMRmA+ppGzcD5nfIrxrAu2s2cHT	 CVafbOBCAstmV68KOQW/Vw/KIVdGP/nxuFr9CZHIPdAaxIliNpdsM4CuRyWbnTboZM	 wyzOmseUvCmc9II6jDBHJh6ZZNdRUUNgClGFhFd7nNdTr8QNAOur6/axMlpPDGpHrB	 UozEIGP41Vd+YG6/aICM/C3/ildSsdgXuJJk1AZf+l6z4QAVVOSUoIDPSfkCLzvCJp	 n8jp0y9iiO+Jw==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 3/4] Cygwin: console: Prevent buffer overrun.
Date: Mon, 02 Mar 2020 01:14:00 -0000
Message-Id: <20200302011258.592-4-takashi.yano@nifty.ne.jp>
In-Reply-To: <20200302011258.592-1-takashi.yano@nifty.ne.jp>
References: <20200302011258.592-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00262.txt

- This patch prevent potential buffer overrun in the code handling
  escape sequences.
---
 winsup/cygwin/fhandler_console.cc | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 9c5b80181..8b4687724 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -3094,7 +3094,8 @@ fhandler_console::write (const void *vsrc, size_t len)
 	case gotarg1:
 	  if (isdigit (*src))
 	    {
-	      con.args[con.nargs] = con.args[con.nargs] * 10 + *src - '0';
+	      if (con.nargs < MAXARGS)
+		con.args[con.nargs] = con.args[con.nargs] * 10 + *src - '0';
 	      wpbuf_put (*src);
 	      src++;
 	    }
@@ -3102,9 +3103,8 @@ fhandler_console::write (const void *vsrc, size_t len)
 	    {
 	      wpbuf_put (*src);
 	      src++;
-	      con.nargs++;
-	      if (con.nargs > MAXARGS)
-		con.nargs--;
+	      if (con.nargs < MAXARGS)
+		con.nargs++;
 	    }
 	  else if (*src == ' ')
 	    {
@@ -3117,9 +3117,8 @@ fhandler_console::write (const void *vsrc, size_t len)
 	    con.state = gotcommand;
 	  break;
 	case gotcommand:
-	  con.nargs ++;
-	  if (con.nargs > MAXARGS)
-	    con.nargs--;
+	  if (con.nargs < MAXARGS)
+	    con.nargs++;
 	  char_command (*src++);
 	  con.state = normal;
 	  wpixput = 0;
@@ -3183,9 +3182,8 @@ fhandler_console::write (const void *vsrc, size_t len)
 	    {
 	      con.state = gotarg1;
 	      wpbuf_put (*src);
-	      con.nargs++;
-	      if (con.nargs > MAXARGS)
-		con.nargs--;
+	      if (con.nargs < MAXARGS)
+		con.nargs++;
 	      src++;
 	    }
 	  else if (isalpha (*src))
-- 
2.21.0
