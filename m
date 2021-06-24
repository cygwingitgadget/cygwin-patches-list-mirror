Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id 4B7A1389682A
 for <cygwin-patches@cygwin.com>; Thu, 24 Jun 2021 03:41:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 4B7A1389682A
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (y084232.dynamic.ppp.asahi-net.or.jp
 [118.243.84.232]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 15O3f0T2004895;
 Thu, 24 Jun 2021 12:41:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 15O3f0T2004895
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1624506069;
 bh=Gy5JnKZVMF4/Lf+E1NKx76XFkowT6Yhj0m18vtFdobw=;
 h=From:To:Cc:Subject:Date:From;
 b=DJD4y71uwOszPz/z5+Jro7coJpMSgY5kE6YoTajliN444JAsa1XI0O146miim0TWE
 6yT9F6rSFDCND1zNkMMUJXDoDn7+cPGbvHkyRMja+crxg077r7xBjIZeQPfDYsFAAJ
 NqHEcsWVW3bpb/2J0nOENf0bK6Z2T9Yp1Nj9NYdWOWtRno6FR1WpfJ3Ftmd1K/R4Qv
 DW+4Tw+vr53InjRYGFqy5htr5/FsxZdh3xpUvUpouwB1Mhhjkzr12oJ/3ag5tvCp36
 bH8VHRWkh4vnwTqYXsjwTrPRLaN8fB3hGLYtfV9cPcj5DZ4QwgmMhOOHvl/QuYFSzK
 KUamR7dMdvoTw==
X-Nifty-SrcIP: [118.243.84.232]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2] Cygwin: console: Fix garbled input for non-ASCII chars.
Date: Thu, 24 Jun 2021 12:40:58 +0900
Message-Id: <20210624034058.663-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 24 Jun 2021 03:41:30 -0000

- After the commit ff4440fc, non-ASCII input may sometimes be garbled.
  This patch fixes the issue.

  Addresses: https://cygwin.com/pipermail/cygwin/2021-June/248775.html
---
 winsup/cygwin/fhandler_console.cc | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index b3eae6a5a..e00f2cdbc 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -205,7 +205,7 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
   DWORD output_stopped_at = 0;
   while (con.owner == myself->pid)
     {
-      DWORD total_read, n, i, j;
+      DWORD total_read, n, i;
       INPUT_RECORD input_rec[INREC_SIZE];
 
       WaitForSingleObject (p->input_mutex, INFINITE);
@@ -213,7 +213,7 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
       switch (cygwait (p->input_handle, (DWORD) 0))
 	{
 	case WAIT_OBJECT_0:
-	  ReadConsoleInputA (p->input_handle,
+	  ReadConsoleInputW (p->input_handle,
 			     input_rec, INREC_SIZE, &total_read);
 	  break;
 	case WAIT_TIMEOUT:
@@ -241,7 +241,10 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 	}
       for (i = 0; i < total_read; i++)
 	{
-	  const char c = input_rec[i].Event.KeyEvent.uChar.AsciiChar;
+	  const wchar_t wc = input_rec[i].Event.KeyEvent.uChar.UnicodeChar;
+	  if ((wint_t) wc >= 0x80)
+	    continue;
+	  char c = (char) wc;
 	  bool processed = false;
 	  termios &ti = ttyp->ti;
 	  switch (input_rec[i].EventType)
@@ -318,15 +321,15 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 	    }
 	  if (processed)
 	    { /* Remove corresponding record. */
-	      for (j = i; j < total_read - 1; j++)
-		input_rec[j] = input_rec[j + 1];
+	      memmove (input_rec + i, input_rec + i + 1,
+		       sizeof (INPUT_RECORD) * (total_read - i - 1));
 	      total_read--;
 	      i--;
 	    }
 	}
       if (total_read)
 	/* Write back input records other than interrupt. */
-	WriteConsoleInput (p->input_handle, input_rec, total_read, &n);
+	WriteConsoleInputW (p->input_handle, input_rec, total_read, &n);
 skip_writeback:
       ReleaseMutex (p->input_mutex);
       cygwait (40);
-- 
2.32.0

