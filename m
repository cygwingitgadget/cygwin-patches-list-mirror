Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id 25D83383F875
 for <cygwin-patches@cygwin.com>; Sun, 31 May 2020 05:54:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 25D83383F875
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 04V5rSi5024218;
 Sun, 31 May 2020 14:53:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 04V5rSi5024218
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 3/4] Cygwin: pty: Clean up
 fhandler_pty_master::pty_master_fwd_thread().
Date: Sun, 31 May 2020 14:53:19 +0900
Message-Id: <20200531055320.1419-4-takashi.yano@nifty.ne.jp>
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

- Remove the code which is not necessary anymore.
---
 winsup/cygwin/fhandler_tty.cc | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index d017cde38..c3d49968d 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -3324,24 +3324,6 @@ fhandler_pty_master::pty_master_fwd_thread ()
 		continue;
 	      }
 
-	  /* Remove ESC sequence which returns results to console
-	     input buffer. Without this, cursor position report
-	     is put into the input buffer as a garbage. */
-	  /* Remove ESC sequence to report cursor position. */
-	  char *p0;
-	  while ((p0 = (char *) memmem (outbuf, rlen, "\033[6n", 4)))
-	    {
-	      memmove (p0, p0+4, rlen - (p0+4 - outbuf));
-	      rlen -= 4;
-	    }
-	  /* Remove ESC sequence to report terminal identity. */
-	  while ((p0 = (char *) memmem (outbuf, rlen, "\033[0c", 4)))
-	    {
-	      memmove (p0, p0+4, rlen - (p0+4 - outbuf));
-	      rlen -= 4;
-	    }
-	  wlen = rlen;
-
 	  size_t nlen;
 	  char *buf = convert_mb_str
 	    (get_ttyp ()->term_code_page, &nlen, CP_UTF8, ptr, wlen);
-- 
2.26.2

