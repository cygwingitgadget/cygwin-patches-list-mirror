Return-Path: <SRS0=E7WB=N7=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.227.121])
	by sourceware.org (Postfix) with ESMTPS id A83853899089
	for <cygwin-patches@cygwin.com>; Sat, 29 Jun 2024 10:08:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A83853899089
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A83853899089
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.121
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1719655684; cv=none;
	b=erP3TOLgXsavcrqxcrI3fHtyQrQ8EPm8czlkxEEdzBBP1+osubCkeI6c/ZkuKp/EcFoOhFjd7X5+PkJLoZcjDkbt8JXEntaUl6zy9MmDDX0+kR09EV2uJYSkz/TvuvKwWH1zYHsu6SEHoV9DcKfrMDym7pHbsjmLdbY5qVjz+Bo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1719655684; c=relaxed/simple;
	bh=DySuu+I2ZDuvD1ornn7fPgvv2SaDcNqUPa3rfCsTlTs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=PA0pIsdMpcUUCPj8mfJ6DeeXYDtl0abC292OnD1LCAT2O+JnFtPnrwMLfQW8Y1ULYSBgFdJIHMfQjAC3lM8p3aFf0/l5WzDX66BiY4/E9e3xw7/1kJ8/cGnhVUS5y5qoe76IeSxrybJ8Nn0mSy0V1FHf4ePMnUn0a06D2s4D5ug=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-e09.mail.nifty.com
          with ESMTP
          id <20240629100758469.CVUF.13245.localhost.localdomain@nifty.com>;
          Sat, 29 Jun 2024 19:07:58 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Add error handling for thread_sync_event
Date: Sat, 29 Jun 2024 19:06:50 +0900
Message-ID: <20240629100742.2343-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1719655678;
 bh=yivrOLCn+Le0JfA0PPy4z5quq/0aZNI/q9boj/90jS0=;
 h=From:To:Cc:Subject:Date;
 b=O7iB2ioKFZazj3EJ9dAVQ8WRwA7+gdTu9VIICPB8lpdF5FkjL4mjWjF5httVaZG2gB9fDPJ1
 AbTCilRtRtBjOOjh/AquXh33/jVrYCVL5C46cpaO1hRKlTdzzmkJIvp2kOZFhD87c1Mvc4Grnb
 OwFl5ju4393fQqN1TErlj1SUuN5+jm0OMlJE0lFLG9zdeLjJ42Dl77OPtdlZWHCekPsI8eBRfP
 uw70yNZ8wNPyad2BKfeI5uk1ogVSpWNPx/au43LAiruLb7NbAEJUPWCo2n19L6wDPyMrJbe6ku
 0SjlB5bUT1KgYCBmGgb6N2QBso8w9/9Nn2ckyBzGbAugkqFg==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/console.cc | 51 ++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 1c0d5c815..881445824 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -272,17 +272,23 @@ cons_master_thread (VOID *arg)
   fhandler_console::handle_set_t handle_set;
   fh->get_duplicated_handle_set (&handle_set);
   HANDLE thread_sync_event;
-  DuplicateHandle (GetCurrentProcess (), fh->thread_sync_event,
-		   GetCurrentProcess (), &thread_sync_event,
-		   0, FALSE, DUPLICATE_SAME_ACCESS);
-  SetEvent (thread_sync_event);
-  master_thread_started = true;
-  /* Do not touch class members after here because the class instance
-     may have been destroyed. */
-  fhandler_console::cons_master_thread (&handle_set, ttyp);
-  fhandler_console::close_handle_set (&handle_set);
-  SetEvent (thread_sync_event);
-  CloseHandle (thread_sync_event);
+  if (DuplicateHandle (GetCurrentProcess (), fh->thread_sync_event,
+		       GetCurrentProcess (), &thread_sync_event,
+		       0, FALSE, DUPLICATE_SAME_ACCESS))
+    {
+      SetEvent (thread_sync_event);
+      master_thread_started = true;
+      /* Do not touch class members after here because the class instance
+	 may have been destroyed. */
+      fhandler_console::cons_master_thread (&handle_set, ttyp);
+      fhandler_console::close_handle_set (&handle_set);
+      SetEvent (thread_sync_event);
+      CloseHandle (thread_sync_event);
+      master_thread_started = false;
+    }
+  else
+    debug_printf ("cons_master_thread not started because thread_sync_event "
+		  "could not be duplicated %08x", GetLastError ());
   return 0;
 }
 
@@ -451,6 +457,8 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 	case WAIT_CANCELED:
 	  break;
 	default: /* Error */
+	  free (input_rec);
+	  free (input_tmp);
 	  ReleaseMutex (p->input_mutex);
 	  return;
 	}
@@ -1847,9 +1855,12 @@ fhandler_console::open (int flags, mode_t)
       char name[MAX_PATH];
       shared_name (name, CONS_THREAD_SYNC, get_minor ());
       thread_sync_event = CreateEvent(NULL, FALSE, FALSE, name);
-      new cygthread (::cons_master_thread, this, "consm");
-      WaitForSingleObject (thread_sync_event, INFINITE);
-      CloseHandle (thread_sync_event);
+      if (thread_sync_event)
+	{
+	  new cygthread (::cons_master_thread, this, "consm");
+	  WaitForSingleObject (thread_sync_event, INFINITE);
+	  CloseHandle (thread_sync_event);
+	}
     }
   return 1;
 }
@@ -1910,9 +1921,15 @@ fhandler_console::close ()
 	  char name[MAX_PATH];
 	  shared_name (name, CONS_THREAD_SYNC, get_minor ());
 	  thread_sync_event = OpenEvent (MAXIMUM_ALLOWED, FALSE, name);
-	  con.owner = MAX_PID + 1;
-	  WaitForSingleObject (thread_sync_event, INFINITE);
-	  CloseHandle (thread_sync_event);
+	  if (thread_sync_event)
+	    {
+	      con.owner = MAX_PID + 1;
+	      WaitForSingleObject (thread_sync_event, INFINITE);
+	      CloseHandle (thread_sync_event);
+	    }
+	  else
+	    debug_printf ("Failed to open thread_sync_event %08x",
+			  GetLastError ());
 	}
       con.owner = 0;
     }
-- 
2.45.1

