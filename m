Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id 6F6443853804
 for <cygwin-patches@cygwin.com>; Fri, 18 Mar 2022 13:43:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 6F6443853804
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 22IDggKb003725;
 Fri, 18 Mar 2022 22:42:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 22IDggKb003725
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1647610967;
 bh=JC1Gus7UpA/edZ79GIx098c4aCiPBxja8DjFE0DRo/o=;
 h=From:To:Cc:Subject:Date:From;
 b=I7o+7BV9E/PmazElu2LvlJrXjBfecUJ2o/dWWUzFgWGLhLoa4ki+1oTOxZUMJxN97
 EItM2EGXwEffFEKJtlYE8bevH4wCmds5IYklfCdGRZt1fC03RZ/Gc8iXlxPKKi4bE1
 AoELlYIDZQmI9TLQltcOCy9PY9cs9uKJzRDeVcriUyQGt06IjSQMjIevZxJCbjGt5v
 LhbTRZqV8kw6lHtLOd/vvGGPwLXrXDcDeJv0Y/yrK7YUj/Ri1pmN0pRjSzDI9zDKT1
 AjRncK7rbM5twt6ODKfiEjwMGB1R9WHFi47JeEenSTcdiYN8PM3l+D5nGW6dn5LBjk
 rHKIAqpd2d/Mw==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Fix typeahead key swapping which still
 occurs.
Date: Fri, 18 Mar 2022 22:42:34 +0900
Message-Id: <20220318134234.311-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Fri, 18 Mar 2022 13:43:18 -0000

- The commit "Cygwin: console: Improve the code to avoid typeahead
  key swapping." did not solve the problem enough. Two unexpected
  things happen.
   (1) wVirtualKeyCode and wVirtualScanCode of readback key event may
       be null'ed even if they are not zero on WriteConsoleInputW().
       Therefore, memcmp() may report the event sequence is not equal.
   (2) WriteConsoleInputW() may not be atomic. The event sequence
       which is written by WriteConsoleInputW() may be inserted by
       key input in the middle of the sequence. Current code gives
       up to fix in this situation.
   This patch should fix that issue.
---
 winsup/cygwin/fhandler_console.cc | 58 ++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 20 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 241ca48ea..b92d758d1 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -180,6 +180,29 @@ cons_master_thread (VOID *arg)
   return 0;
 }
 
+/* Compare two INPUT_RECORD sequences */
+static inline bool
+inrec_eq (const INPUT_RECORD *a, const INPUT_RECORD *b, DWORD n)
+{
+  for (DWORD i = 0; i < n; i++)
+    {
+      if (a[i].EventType == KEY_EVENT && b[i].EventType == KEY_EVENT)
+	{ /* wVirtualKeyCode and wVirtualScanCode of the readback
+	     key event may be different from that of written event. */
+	  const KEY_EVENT_RECORD *ak = &a[i].Event.KeyEvent;
+	  const KEY_EVENT_RECORD *bk = &b[i].Event.KeyEvent;
+	  if (ak->bKeyDown != bk->bKeyDown
+	      || ak->uChar.UnicodeChar != bk->uChar.UnicodeChar
+	      || ak->dwControlKeyState != bk->dwControlKeyState
+	      || ak->wRepeatCount != bk->wRepeatCount)
+	    return false;
+	}
+      else if (memcmp (a + i, b + i, sizeof (INPUT_RECORD)) != 0)
+	return false;
+    }
+  return true;
+}
+
 /* This thread processes signals derived from input messages.
    Without this thread, those signals can be handled only when
    the process calls read() or select(). This thread reads input
@@ -328,30 +351,25 @@ remove_record:
 	      if (n < total_read)
 		break; /* Someone has read input without acquiring
 			  input_mutex. ConEmu cygwin-connector? */
-	      if (memcmp (input_rec, tmp, m::bytes (total_read)) == 0)
+	      if (inrec_eq (input_rec, tmp, total_read))
 		break; /* OK */
 	      /* Try to fix */
-	      DWORD incr = n - total_read;
-	      DWORD ofst;
-	      for (ofst = 1; ofst <= incr; ofst++)
-		if (memcmp (input_rec, tmp + ofst, m::bytes (total_read)) == 0)
+	      acquire_attach_mutex (mutex_timeout);
+	      ReadConsoleInputW (p->input_handle, tmp, inrec_size, &n);
+	      release_attach_mutex ();
+	      for (DWORD i = 0, j = 0; j < n; j++)
+		if (i == total_read || !inrec_eq (input_rec + i, tmp + j, 1))
 		  {
-		    acquire_attach_mutex (mutex_timeout);
-		    ReadConsoleInputW (p->input_handle, tmp, inrec_size, &n);
-		    release_attach_mutex ();
-		    memcpy (input_rec, tmp + ofst, m::bytes (total_read));
-		    memcpy (input_rec + total_read, tmp, m::bytes (ofst));
-		    if (n > ofst + total_read)
-		      memcpy (input_rec + total_read + ofst,
-			      tmp + ofst + total_read,
-			      m::bytes (n - (ofst + total_read)));
-		    total_read = n;
-		    break;
+		    if (total_read + j - i >= n)
+		      { /* Something is wrong. Giving up. */
+			WriteConsoleInputW (p->input_handle, tmp, n, &n);
+			goto skip_writeback;
+		      }
+		    input_rec[total_read + j - i] = tmp[j];
 		  }
-	      if (ofst > incr)
-		break; /* Writeback was not atomic. Or someone has read
-			  input without acquiring input_mutex.
-			  Giving up because hard to fix. */
+		else
+		  i++;
+	      total_read = n;
 	    }
 	  while (true);
 	}
-- 
2.35.1

