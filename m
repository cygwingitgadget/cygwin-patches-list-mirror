Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id 7E5C03858D37
 for <cygwin-patches@cygwin.com>; Tue,  1 Mar 2022 23:48:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 7E5C03858D37
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 221NmBwS022230;
 Wed, 2 Mar 2022 08:48:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 221NmBwS022230
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1646178497;
 bh=DuCWhZ15ELdRfsgwignEbDwu1bN8eXittNhmMyOBfzQ=;
 h=From:To:Cc:Subject:Date:From;
 b=igokxbZacFR1JSTj9DNrQknhfB/P61ax42oeysrOmcuY5+9hKv4xvXMl4fBMOQrAm
 /G0vmNecOJDbLvB0vBESTCaoGKaUl/q694W+T/cNaRdzhDyG6GR5uLYJOHATOdF7af
 Ojr5q9kmzPafhrHdWM61S/JKYK/7KPSONCVxbZkyH2THeuoYBidNQAmdYpGaA4Oo/S
 Mkjxm9W3h2uXz6DNraDnft7T2cYOljHni3qFpEk1OiDTQHOyzkNJEHYy50lIjCmN89
 sLjZWbwLKtO1F5aU4bHgmyFj50UEUp/ZK7u5ABs+UKz43w54h0R7xk/YrroS/6CQ8l
 tSkYkdXqX7DQQ==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Stop to create struct instance which is not
 needed.
Date: Wed,  2 Mar 2022 08:48:08 +0900
Message-Id: <20220301234808.898-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Tue, 01 Mar 2022 23:48:46 -0000

- In fhandler_console::cons_master_thread(), a struct which has
  only a static function is used. In this case, struct instance
  is not necessary. So with this patch, the static function is
  invoked without creating instance.
---
 winsup/cygwin/fhandler_console.cc | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 920dd4be0..2a4aa7a70 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -192,13 +192,13 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 				       during the process. Additional space
 				       should be left for writeback fix. */
   const int inrec_size = INREC_SIZE + additional_space;
-  struct
+  struct m
   {
     inline static size_t bytes (size_t n)
       {
 	return sizeof (INPUT_RECORD) * n;
       }
-  } m;
+  };
   termios &ti = ttyp->ti;
   int processed_up_to = -1;
   while (con.owner == myself->pid)
@@ -227,7 +227,7 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 	      ReadConsoleInputW (p->input_handle,
 				 input_rec + total_read, incr, &n);
 	      /* Discard oldest n events. */
-	      memmove (input_rec, input_rec + n, m.bytes (total_read));
+	      memmove (input_rec, input_rec + n, m::bytes (total_read));
 	      processed_up_to -= n;
 	      nowait = true;
 	    }
@@ -307,7 +307,7 @@ remove_record:
 	    { /* Remove corresponding record. */
 	      if (total_read > i + 1)
 		memmove (input_rec + i, input_rec + i + 1,
-			 m.bytes (total_read - i - 1));
+			 m::bytes (total_read - i - 1));
 	      total_read--;
 	      i--;
 	    }
@@ -325,21 +325,21 @@ remove_record:
 	      if (n < total_read)
 		break; /* Someone has read input without acquiring
 			  input_mutex. ConEmu cygwin-connector? */
-	      if (memcmp (input_rec, tmp, m.bytes (total_read)) == 0)
+	      if (memcmp (input_rec, tmp, m::bytes (total_read)) == 0)
 		break; /* OK */
 	      /* Try to fix */
 	      DWORD incr = n - total_read;
 	      DWORD ofst;
 	      for (ofst = 1; ofst <= incr; ofst++)
-		if (memcmp (input_rec, tmp + ofst, m.bytes (total_read)) == 0)
+		if (memcmp (input_rec, tmp + ofst, m::bytes (total_read)) == 0)
 		  {
 		    ReadConsoleInputW (p->input_handle, tmp, inrec_size, &n);
-		    memcpy (input_rec, tmp + ofst, m.bytes (total_read));
-		    memcpy (input_rec + total_read, tmp, m.bytes (ofst));
+		    memcpy (input_rec, tmp + ofst, m::bytes (total_read));
+		    memcpy (input_rec + total_read, tmp, m::bytes (ofst));
 		    if (n > ofst + total_read)
 		      memcpy (input_rec + total_read + ofst,
 			      tmp + ofst + total_read,
-			      m.bytes (n - (ofst + total_read)));
+			      m::bytes (n - (ofst + total_read)));
 		    total_read = n;
 		    break;
 		  }
-- 
2.35.1

