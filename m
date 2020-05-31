Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id 26303383E808
 for <cygwin-patches@cygwin.com>; Sun, 31 May 2020 05:54:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 26303383E808
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 04V5rSi3024218;
 Sun, 31 May 2020 14:53:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 04V5rSi3024218
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/4] Cygwin: console: Discard some unsupported escape
 sequences.
Date: Sun, 31 May 2020 14:53:18 +0900
Message-Id: <20200531055320.1419-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200531055320.1419-1-takashi.yano@nifty.ne.jp>
References: <20200531055320.1419-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sun, 31 May 2020 05:54:20 -0000

- If the cygwin vim is started from a non-cygwin process which is
  executed in pseudo console, shift key and ctrl key do not work.
  In this case, vim is executed under /dev/cons*. If vim outputs
  escape sequence which is not supported by pseudo console, the
  escape sequence is leaked into the parent pty. This causes
  unexpected results. This patch fixes the issue by discarding
  "CSI > Pm m". "OSC 10;? BEL/ST" and "OSC 11;? BEL/ST" are
  discarded as well.
---
 winsup/cygwin/fhandler_console.cc | 54 ++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 16 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 5cb4343ea..dd979fb8e 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -2186,6 +2186,14 @@ fhandler_console::char_command (char c)
 	  /* Just send the sequence */
 	  wpbuf.send (get_output_handle ());
 	  break;
+	case 'm':
+	  if (con.saw_greater_than_sign)
+	    break; /* Ignore unsupported CSI > Pm m */
+	  /* Text attribute settings */
+	  wpbuf.put (c);
+	  /* Just send the sequence */
+	  wpbuf.send (get_output_handle ());
+	  break;
 	default:
 	  /* Other escape sequences */
 	  wpbuf.put (c);
@@ -3077,6 +3085,13 @@ fhandler_console::write (const void *vsrc, size_t len)
 	      con.state = normal;
 	      wpbuf.empty();
 	    }
+	  else if (*src == ']')		/* OSC Operating System Command */
+	    {
+	      wpbuf.put (*src);
+	      con.rarg = 0;
+	      con.my_title_buf[0] = '\0';
+	      con.state = gotrsquare;
+	    }
 	  else if (wincap.has_con_24bit_colors () && !con_is_legacy)
 	    {
 	      if (*src == 'c') /* RIS Full reset */
@@ -3095,13 +3110,6 @@ fhandler_console::write (const void *vsrc, size_t len)
 	      con.state = normal;
 	      wpbuf.empty();
 	    }
-	  else if (*src == ']')		/* OSC Operating System Command */
-	    {
-	      wpbuf.put (*src);
-	      con.rarg = 0;
-	      con.my_title_buf[0] = '\0';
-	      con.state = gotrsquare;
-	    }
 	  else if (*src == '(')		/* Designate G0 character set */
 	    {
 	      wpbuf.put (*src);
@@ -3179,7 +3187,8 @@ fhandler_console::write (const void *vsrc, size_t len)
 	    con.rarg = con.rarg * 10 + (*src - '0');
 	  else if (*src == ';' && (con.rarg == 2 || con.rarg == 0))
 	    con.state = gettitle;
-	  else if (*src == ';' && (con.rarg == 4 || con.rarg == 104))
+	  else if (*src == ';' && (con.rarg == 4 || con.rarg == 104
+				   || (con.rarg >= 10 && con.rarg <= 19)))
 	    con.state = eatpalette;
 	  else
 	    con.state = eattitle;
@@ -3189,10 +3198,13 @@ fhandler_console::write (const void *vsrc, size_t len)
 	case eattitle:
 	case gettitle:
 	  {
+	    wpbuf.put (*src);
 	    int n = strlen (con.my_title_buf);
 	    if (*src < ' ')
 	      {
-		if (*src == '\007' && con.state == gettitle)
+		if (wincap.has_con_24bit_colors () && !con_is_legacy)
+		  wpbuf.send (get_output_handle ());
+		else if (*src == '\007' && con.state == gettitle)
 		  set_console_title (con.my_title_buf);
 		con.state = normal;
 		wpbuf.empty();
@@ -3201,27 +3213,37 @@ fhandler_console::write (const void *vsrc, size_t len)
 	      {
 		con.my_title_buf[n++] = *src;
 		con.my_title_buf[n] = '\0';
-		wpbuf.put (*src);
 	      }
 	    src++;
 	    break;
 	  }
 	case eatpalette:
-	  if (*src == '\033')
-	    {
-	      wpbuf.put (*src);
-	      con.state = endpalette;
-	    }
+	  wpbuf.put (*src);
+	  if (*src == '?')
+	    con.saw_question_mark = true;
+	  else if (*src == '\033')
+	    con.state = endpalette;
 	  else if (*src == '\a')
 	    {
+	      /* Send OSC Ps; Pt BEL other than OSC Ps; ? BEL */
+	      if (wincap.has_con_24bit_colors () && !con_is_legacy
+		  && !con.saw_question_mark)
+		wpbuf.send (get_output_handle ());
 	      con.state = normal;
 	      wpbuf.empty();
 	    }
 	  src++;
 	  break;
 	case endpalette:
+	  wpbuf.put (*src);
 	  if (*src == '\\')
-	    con.state = normal;
+	    {
+	      /* Send OSC Ps; Pt ST other than OSC Ps; ? ST */
+	      if (wincap.has_con_24bit_colors () && !con_is_legacy
+		  && !con.saw_question_mark)
+		wpbuf.send (get_output_handle ());
+	      con.state = normal;
+	    }
 	  else
 	    /* Sequence error (abort) */
 	    con.state = normal;
-- 
2.26.2

