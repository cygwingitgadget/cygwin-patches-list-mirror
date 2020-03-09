Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-03.nifty.com (conuserg-03.nifty.com [210.131.2.70])
 by server2.sourceware.org (Postfix) with ESMTPS id 5896F3945058
 for <cygwin-patches@cygwin.com>; Mon,  9 Mar 2020 01:38:54 +0000 (GMT)
Received: from localhost.localdomain
 (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)
 by conuserg-03.nifty.com with ESMTP id 0291caTX007478;
 Mon, 9 Mar 2020 10:38:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-03.nifty.com 0291caTX007478
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1583717921;
 bh=uj2GddlThm7Nbl8rSuyKiqNc1o5X8pK5etRQ6adwvnA=;
 h=From:To:Cc:Subject:Date:From;
 b=e2FtAAXd+voXAa0a/w64r9VqLQGeirhE2blz76Lc6dJDVP+zWHxCDnJ4IJqlLGpPQ
 MHwZGkGBzLgbF296BV8KXeM4CIVmxKl0hyWX/OBBVNJpdq/Gp//h8Mbrxv9Qd/lX+9
 nE+UKnL/1iN9r3JptChEOuwbOKHwH+Pt9Ngq3TIdwUtk1pnhZCRjwN5Zr5zuydSqc+
 YLk9gKh1LANdPLyig+nDdnhFo1bEQs8dtaJRtDOHoL+c2nY5o12d76VgB9IgNgPjoy
 Cq3Tp/ZaS9eLb31vcnJyAO1JJrYLXJdBg1aljTweq0mpVBU5rVjQuSlDZr0TEZnZ29
 dzS8K/tv54i4A==
X-Nifty-SrcIP: [125.0.207.171]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2] Cygwin: console: Fix behaviour of "ESC 8" after reset.
Date: Mon,  9 Mar 2020 10:38:36 +0900
Message-Id: <20200309013836.1999-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-25.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, GIT_PATCH_1,
 GIT_PATCH_2, GIT_PATCH_3, PDS_OTHER_BAD_TLD, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE,
 SPF_PASS autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin-patches mailing list <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <http://cygwin.com/pipermail/cygwin-patches/>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 09 Mar 2020 01:38:55 -0000

- This patch matches the behaviour of "ESC 8" (DECRC) to the real
  xterm after full reset (RIS), soft reset (DECSTR) and "CSI 3 J".
---
 winsup/cygwin/fhandler_console.cc | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 1c376291f..2a239b866 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -2124,6 +2124,11 @@ fhandler_console::char_command (char c)
 	  break;
 	case 'J': /* ED */
 	  wpbuf.put (c);
+	  if (con.args[0] == 3 && con.savey >= 0)
+	    {
+	      con.fillin (get_output_handle ());
+	      con.savey -= con.b.srWindow.Top;
+	    }
 	  if (con.args[0] == 3 && wincap.has_con_broken_csi3j ())
 	    { /* Workaround for broken CSI3J in Win10 1809 */
 	      CONSOLE_SCREEN_BUFFER_INFO sbi;
@@ -2168,6 +2173,7 @@ fhandler_console::char_command (char c)
 	    {
 	      con.scroll_region.Top = 0;
 	      con.scroll_region.Bottom = -1;
+	      con.savex = con.savey = -1;
 	    }
 	  wpbuf.put (c);
 	  /* Just send the sequence */
@@ -3070,6 +3076,7 @@ fhandler_console::write (const void *vsrc, size_t len)
 		{
 		  con.scroll_region.Top = 0;
 		  con.scroll_region.Bottom = -1;
+		  con.savex = con.savey = -1;
 		}
 	      /* ESC sequences below (e.g. OSC, etc) are left to xterm
 		 emulation in xterm compatible mode, therefore, are not
-- 
2.21.0

