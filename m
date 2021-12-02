Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id 54FEB3858D28
 for <cygwin-patches@cygwin.com>; Thu,  2 Dec 2021 08:44:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 54FEB3858D28
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 1B28hxdS025001;
 Thu, 2 Dec 2021 17:44:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 1B28hxdS025001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1638434648;
 bh=bsWO6LJ3NU+VJgZyVe/2Mb/9dABLhfJjr5mzvDLaI3E=;
 h=From:To:Cc:Subject:Date:From;
 b=yAAyX8eyyQJI700U0hezmRZTTtcwjjmvIapBMvXrr5mUekOIKC9NpPwcr9bfOfvlj
 LXHf+cwyF82rpYJws0gj2m7U9Jnp+pourtlOY9FQyFb0sXW0NX5I4vyrAbxeuur7YC
 zIirWTcJjQagaNpXXIe718G/ECScA0aXwQk4n+N9cmnNFMYDosr7685qkiZ0UmDWGO
 eMVjxgwAzr9AZ67tvNTHMScxZANQ72To4buuas1bhJK5im0bEPru5VXbYsg2cemuL+
 9ImG+9k6bzmGOrYEKiBfX9tCgPqnbarDd8W3MWoFsGp8ZjMy0oRE2LJh3PhhF+zlvX
 N6OGrEWpwWD3g==
X-Nifty-SrcIP: [110.4.221.123]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Fix OSC sequence handling.
Date: Thu,  2 Dec 2021 17:43:49 +0900
Message-Id: <20211202084349.336-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 02 Dec 2021 08:44:41 -0000

- Currently, some OSC escape sequences, such as 'OSC 110 BEL', are
  not handled correctly. This patch fixes the issue.
---
 winsup/cygwin/fhandler_console.cc | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index d9ed71af8..4c98b5355 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -3308,13 +3308,30 @@ fhandler_console::write (const void *vsrc, size_t len)
 	case gotrsquare:
 	  if (isdigit (*src))
 	    con.rarg = con.rarg * 10 + (*src - '0');
-	  else if (*src == ';' && (con.rarg == 2 || con.rarg == 0))
-	    con.state = gettitle;
-	  else if (*src == ';' && (con.rarg == 4 || con.rarg == 104
-				   || (con.rarg >= 10 && con.rarg <= 19)))
-	    con.state = eatpalette;
-	  else
-	    con.state = eattitle;
+	  else if (*src == ';')
+	    {
+	      if (con.rarg == 0 || con.rarg == 2)
+		con.state = gettitle;
+	      else if ((con.rarg >= 4 && con.rarg <= 6)
+		       || (con.rarg >=10 && con.rarg <= 19)
+		       || (con.rarg >=104 && con.rarg <= 106)
+		       || (con.rarg >=110 && con.rarg <= 119))
+		con.state = eatpalette;
+	      else
+		con.state = eattitle;
+	    }
+	  else if (*src == '\033')
+	    con.state = endpalette;
+	  else if (*src == '\007')
+	    {
+	      wpbuf.put (*src);
+	      if (wincap.has_con_24bit_colors () && !con_is_legacy)
+		wpbuf.send (get_output_handle ());
+	      wpbuf.empty ();
+	      con.state = normal;
+	      src++;
+	      break;
+	    }
 	  wpbuf.put (*src);
 	  src++;
 	  break;
-- 
2.33.0

