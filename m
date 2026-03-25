Return-Path: <SRS0=haOa=BZ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 23F2B4B92087
	for <cygwin-patches@cygwin.com>; Wed, 25 Mar 2026 13:05:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 23F2B4B92087
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 23F2B4B92087
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774443922; cv=none;
	b=Ab1XLBxcEVHGIHzaeNVLnYlddQCsXjYJPqi1y3XAZUAc/0+ae14scvQaMva1O5XG/i4eC4jc1XkrJcaZCXd1/vTbGEh0xBoaoRA4qGd8a696zwcgATBjTHvdql91mSHxeI68zzDbhoL3+C5F3Oykk0Dg/Sxw2OtN6rqn2KhzNh8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774443922; c=relaxed/simple;
	bh=OopE5AGmYwliiV2uStzH/RILmYhS0BdTqeyDgdTVUYA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=MjpkdGjI43WiA50RpQMolMK6VnmSQmTBatTnBCOCplpHgb1X5pOGHzQhOTgzhBBathJbvEb26S9UiETND3Lt5GK/SLR/Kje+Ys+3Oqc0wmVh5M2c7K+yIiiVusjnlp4XyQR4hXwP7muS53wcLvRQl/06wximQuAv3OCQ3sDIYdg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 23F2B4B92087
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=CUG2UUeg
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260325130520227.TUDL.127398.HP-Z230@nifty.com>;
          Wed, 25 Mar 2026 22:05:20 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v7 3/7] Cygwin: console: Use input_mutex in the parent PTY in master thread
Date: Wed, 25 Mar 2026 22:04:09 +0900
Message-ID: <20260325130453.62246-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260325130453.62246-1-takashi.yano@nifty.ne.jp>
References: <20260321113613.9443-1-takashi.yano@nifty.ne.jp>
 <20260325130453.62246-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774443920;
 bh=TXdWW/AjMqNc3dCEH7/06sK5ynPU4O1eHmCTSI8XenM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CUG2UUegSDNGLoBMtDgvicefrbElf/ggZd7u0qvRYLM2Z4OWfzIi4e/3WkvwXdG0OXA8kz3/
 il5DEw+tOVlEJEOZvaf5tnuxDuej0yJFTNLW5V1pcNI6FZJ2yYRphV7N6lyfET7mUzcyFUBDtH
 +k2twgWUhtht+s2xFI2RyJUdPmjISmFM/wJJv/+w9ikE4V48r7Xiah9KOP6SUBWFXxIWb0J4yx
 B3zgpqIuu0oR+VIfYpucQxxy0cgsat6vjG82X69x2KFpq4QpbZ8MO5Xp3cC9jOTpBq4sK/kzd9
 3slBim0ZZa0Cx7YzagIgToLpd1RQPiwPpjutHh9lmHXmrDGQ==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 9678775d1..29cdba0d3 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -63,6 +63,7 @@ fhandler_console::console_state NO_COPY
 static bool NO_COPY inside_pcon_checked = false;
 static bool NO_COPY inside_pcon = false;
 static int NO_COPY parent_pty;
+static HANDLE NO_COPY parent_pty_input_mutex = NULL;
 
 bool NO_COPY fhandler_console::invisible_console;
 
@@ -464,6 +465,8 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 	  continue;
 	}
       total_read = 0;
+      if (inside_pcon)
+	WaitForSingleObject (parent_pty_input_mutex, mutex_timeout);
       switch (cygwait (p->input_handle, (DWORD) 0))
 	{
 	case WAIT_OBJECT_0:
@@ -488,6 +491,8 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 	default: /* Error */
 	  free (input_rec);
 	  free (input_tmp);
+	  if (inside_pcon)
+	    ReleaseMutex (parent_pty_input_mutex);
 	  ReleaseMutex (p->input_mutex);
 	  return;
 	}
@@ -665,6 +670,8 @@ remove_record:
 	  while (true);
 	}
 skip_writeback:
+      if (inside_pcon)
+	ReleaseMutex (parent_pty_input_mutex);
       ReleaseMutex (p->input_mutex);
       cygwait (40);
     }
@@ -1970,6 +1977,8 @@ fhandler_console::setup_pcon_hand_over ()
 	    inside_pcon = true;
 	    atexit (fhandler_console::pcon_hand_over_proc);
 	    parent_pty = i;
+	    parent_pty_input_mutex =
+	      cygwin_shared->tty[i]->open_input_mutex (MAXIMUM_ALLOWED);
 	    break;
 	  }
       }
@@ -1997,6 +2006,7 @@ fhandler_console::pcon_hand_over_proc (void)
     }
   else
     system_printf("Acquiring pcon_ho_mutex failed.");
+  CloseHandle (parent_pty_input_mutex);
   /* Do not release the mutex.
      Hold onto the mutex until this process completes. */
 }
-- 
2.51.0

