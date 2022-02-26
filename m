Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id 610A43858D1E
 for <cygwin-patches@cygwin.com>; Sat, 26 Feb 2022 10:36:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 610A43858D1E
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 21QAaPOL007841;
 Sat, 26 Feb 2022 19:36:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 21QAaPOL007841
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1645871793;
 bh=/O42hLkuUzvCmlnMiDuxx0hRBid5nuPVT7LBWM+QQiI=;
 h=From:To:Cc:Subject:Date:From;
 b=KME9ehEIICKOLLtFWvu3VFUOgiL1XwLjfBiaiRNQxC437O67IoUMLzSqiSAKlWgK3
 dVrUQ0TXlJdQczVCPggty/AOvl+5/pJtvgDIpHHDdK225GvmPKXjSst50wqCyig7M4
 i1kqlZGyz/YiqEcHHXApFo+TVgXCtGWheWXLeFuDJQROC5kAWiqZxrZjIMTu9cVPIW
 JTiwQvVbOwEjHS0YCun9FXdVRtbivrBaAjCTxp+al7oXUGrphF3frMIeFPuV7H9K61
 SiJ3/vgudYTemYNPxlHtFszyRdSoOuv1fTukG98z+cSIOr2LHU9k0r1jFNe9xTBYd1
 ehoImR/+Sll0A==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Prevent the order of typeahead input from
 swapped.
Date: Sat, 26 Feb 2022 19:36:16 +0900
Message-Id: <20220226103616.1517-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Sat, 26 Feb 2022 10:36:52 -0000

- If a lot of keys are typed very quickly in the app which does
  not read console, the order of input keys in console input buffer
  occasionally swapped. Although this extremely rarely happens,
  is obviously a bug of cons_master_thread. This patch fixes the
  issue.
---
 winsup/cygwin/fhandler_console.cc | 53 +++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index aa0f26450..88c0f894b 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -208,6 +208,20 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 	case WAIT_OBJECT_0:
 	  ReadConsoleInputW (p->input_handle,
 			     input_rec, INREC_SIZE, &total_read);
+	  if (total_read == INREC_SIZE /* Working space full */
+	      && cygwait (p->input_handle, (DWORD) 0) == WAIT_OBJECT_0)
+	    {
+	      const int incr = 1;
+	      size_t bytes = sizeof (INPUT_RECORD) * (total_read - incr);
+	      /* Discard oldest incr events. */
+	      memmove (input_rec, input_rec + incr, bytes);
+	      total_read -= incr;
+	      processed_up_to =
+		(processed_up_to + 1 >= incr) ? processed_up_to - incr : -1;
+	      ReadConsoleInputW (p->input_handle,
+				 input_rec + total_read, incr, &n);
+	      total_read += n;
+	    }
 	  break;
 	case WAIT_TIMEOUT:
 	  processed_up_to = -1;
@@ -291,8 +305,43 @@ remove_record:
 	}
       processed_up_to = total_read - 1;
       if (total_read)
-	/* Writeback input records other than interrupt. */
-	WriteConsoleInputW (p->input_handle, input_rec, total_read, &n);
+	{
+	  /* Writeback input records other than interrupt. */
+	  WriteConsoleInputW (p->input_handle, input_rec, total_read, &n);
+	  size_t bytes = sizeof (INPUT_RECORD) * total_read;
+	  do
+	    {
+	      const int additional_size = 128; /* Possible max number of
+						  incoming events during
+						  above process. */
+	      const int new_size = INREC_SIZE + additional_size;
+	      INPUT_RECORD tmp[new_size];
+	      /* Check if writeback was successfull. */
+	      PeekConsoleInputW (p->input_handle, tmp, new_size, &n);
+	      if (memcmp (input_rec, tmp, bytes) == 0)
+		break; /* OK */
+	      /* Try to fix */
+	      DWORD incr = n - total_read;
+	      DWORD ofst;
+	      for (ofst = 1; ofst <= incr; ofst++)
+		if (memcmp (input_rec, tmp + ofst, bytes) == 0)
+		  {
+		    ReadConsoleInputW (p->input_handle, tmp, new_size, &n);
+		    DWORD m;
+		    WriteConsoleInputW (p->input_handle, tmp + ofst,
+					total_read, &m);
+		    WriteConsoleInputW (p->input_handle, tmp, ofst, &m);
+		    if ( n > ofst + total_read)
+		      WriteConsoleInputW (p->input_handle,
+					  tmp + ofst + total_read,
+					  n - (ofst + total_read), &m);
+		    break;
+		  }
+	      if (ofst > incr) /* Hard to fix */
+		break; /* Giving up */
+	    }
+	  while (true);
+	}
 skip_writeback:
       ReleaseMutex (p->input_mutex);
       cygwait (40);
-- 
2.35.1

