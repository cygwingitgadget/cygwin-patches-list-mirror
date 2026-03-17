Return-Path: <SRS0=iP9N=BR=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 3D5064AADCE6
	for <cygwin-patches@cygwin.com>; Tue, 17 Mar 2026 12:25:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3D5064AADCE6
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3D5064AADCE6
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773750312; cv=none;
	b=PTIRNRF3V/X3h5F2zyyE54XfYBgomRkijqQzB8oMUCxWBtf4NKRZ1Szc7ZdqDSHD0vvNIwdlpVBjgZINLx1JceVPcPQZeQlXDrqttI3GwZKeI2bu5isE5W+vWfveUIpDJU2N0iJSGplT0aNTWtqTEppG/Q737EZKsKKBNghPMqU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773750312; c=relaxed/simple;
	bh=bNkaO3w6z6YH7oKVOapsHreQvf8e9dgpbgRJ0ndheUA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=gAybPztGBxhs7CE3tmx/vBRnHJiVm7cg68HBSexaJ+zGrDGwYnacxzSBf6cDhLxxhCtFlCtZ6hamGcNTgSZF8RqiF64Pkt9+nhMsZyHLcUw2YlALvcF8kPe39hofcIru1Iql90DIwkSA/76piQ+q4Hm1XFVg57cVq/1PzZT3OiA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3D5064AADCE6
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=cQdQIng/
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260317122510354.NPQW.36235.HP-Z230@nifty.com>;
          Tue, 17 Mar 2026 21:25:10 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 3/6] Cygwin: console Use input_mutex in the parent PTY in master thread
Date: Tue, 17 Mar 2026 21:23:07 +0900
Message-ID: <20260317122433.721-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317122433.721-1-takashi.yano@nifty.ne.jp>
References: <22f45be0-3a22-f9c6-6d91-a7c2484621ef@gmx.de>
 <20260317122433.721-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773750310;
 bh=U45vY9baQ2aoh9Y9yZofIFZ3ZIT1MJSAo6FoNEBJO7M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cQdQIng/axB6c0/FD+GZrGTwDCQYzK8mvwJhSExSZ0jBknAdKFqHY8YfPExwWt512YtvQilo
 72/Etn3IYOp9FvQgPlrwiINqaSWRQ0+4M9gm17wq2R4D3Rb6L5w7f04l4SAKjN3cZg0IweQSNX
 lpDtZ+EWBrWwE14WqQqUB60yi0xSqaOypYx3YfYFOd4lSgVmSR/TN9f5N4zF80kOp8CF8ZcGu4
 6vZwf3cZCzWQahdDpZjm28Ws33LlM/c92RSYHT5tEqSEld6YrxmXw6djRDCPVlZDdH7MmVkLGr
 OhRET6twgCtc/XZAj8iK/1n/P2q+ykiwWOkz8M5wT6pm9ONg==
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If the console is originating from pseudo console, the input into
console is comming from PTY master. Therefore, input_mutex in PTY
can be used to avoid conflicts between fhandler_pty_master::write()
and cons_master_thread(). With this patch, use parent input_mutex
as well as input_mutex in console device in cons_master_thread().

Fixes: 04f386e9af99 ("Cygwin: console: Inherit pcon hand over from parent pty")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/console.cc | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 582505cb8..8ea5d3a2a 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -63,6 +63,7 @@ fhandler_console::console_state NO_COPY
 static bool NO_COPY inside_pcon_checked = false;
 static bool NO_COPY inside_pcon = false;
 static int NO_COPY parent_pty;
+static HANDLE NO_COPY parent_pty_input_mutex = NULL;
 
 bool NO_COPY fhandler_console::invisible_console;
 
@@ -421,6 +422,8 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 	  continue;
 	}
       total_read = 0;
+      if (inside_pcon)
+	WaitForSingleObject (parent_pty_input_mutex, mutex_timeout);
       switch (cygwait (p->input_handle, (DWORD) 0))
 	{
 	case WAIT_OBJECT_0:
@@ -445,6 +448,8 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 	default: /* Error */
 	  free (input_rec);
 	  free (input_tmp);
+	  if (inside_pcon)
+	    ReleaseMutex (parent_pty_input_mutex);
 	  ReleaseMutex (p->input_mutex);
 	  return;
 	}
@@ -601,6 +606,8 @@ remove_record:
 	  while (true);
 	}
 skip_writeback:
+      if (inside_pcon)
+	ReleaseMutex (parent_pty_input_mutex);
       ReleaseMutex (p->input_mutex);
       cygwait (40);
     }
@@ -1906,6 +1913,8 @@ fhandler_console::setup_pcon_hand_over ()
 	    inside_pcon = true;
 	    atexit (fhandler_console::pcon_hand_over_proc);
 	    parent_pty = i;
+	    parent_pty_input_mutex =
+	      cygwin_shared->tty[i]->open_input_mutex (MAXIMUM_ALLOWED);
 	    break;
 	  }
       }
@@ -1933,6 +1942,7 @@ fhandler_console::pcon_hand_over_proc (void)
     }
   else
     system_printf("Acquiring pcon_ho_mutex failed.");
+  CloseHandle (parent_pty_input_mutex);
   /* Do not release the mutex.
      Hold onto the mutex until this process completes. */
 }
-- 
2.51.0

