Return-Path: <SRS0=Yn/K=BV=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 0BE184BC8965
	for <cygwin-patches@cygwin.com>; Sat, 21 Mar 2026 11:36:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0BE184BC8965
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0BE184BC8965
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774093005; cv=none;
	b=KMVwHItsLAA9qHbcLpJ5LRhvtnU6VcR3mPXWrvAd4FOlTHiePmK8RBid8uiv7lWXy+SfU5rZJJDa2KcjrPErc2KUrMIFfwsw5gNoSnyQKDjCqPqmzzCc/XSgHzJbyLhbPcysjo/Fb+JHVpmfx3SR011H/U/84XL3+pWwZR8r828=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774093005; c=relaxed/simple;
	bh=OopE5AGmYwliiV2uStzH/RILmYhS0BdTqeyDgdTVUYA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=iyaFMSRpqDLDQnG+q9hNy8P6ie5oK9VNj4VPoQ2C9G3noq8Ivmi9CWi5GRCi4KkN1uqckwtYSAngdGI24I6SM8e5xh+oEpP2fX6Kw6Gt8MwgYZJggahprXQx6uvn5T2OcTpPEWmb5kcz8epk5qqoiaNzSNI9RKKHYpiKJWUCCFU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0BE184BC8965
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=RTGoHW2y
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260321113643319.VNTC.36235.HP-Z230@nifty.com>;
          Sat, 21 Mar 2026 20:36:43 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v6 3/6] Cygwin: console Use input_mutex in the parent PTY in master thread
Date: Sat, 21 Mar 2026 20:35:28 +0900
Message-ID: <20260321113613.9443-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260321113613.9443-1-takashi.yano@nifty.ne.jp>
References: <20260320160143.1548-1-takashi.yano@nifty.ne.jp>
 <20260321113613.9443-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774093003;
 bh=TXdWW/AjMqNc3dCEH7/06sK5ynPU4O1eHmCTSI8XenM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RTGoHW2yzBJh9nV0hy9lvyqBIQAu/4hdvYR9VB0l3fVRNHrcn3B+E+W9Tzw9UvHOItKZekri
 2lT9+n+7gM9D0z04JQp1bXGKWh4qHoAQh4WIgylXae2DP3FGm8GEfi+fdq1zArDtTj4O1B158g
 BGsYO0kYqeAMNvsRdf5hzeAcXIgNzWuJiTFBn4DiKaPinLkPsU2LzE/4+WapgoRjpXbRulzY6A
 E+0PZpYJKCBIh126DVYntAwgKsTBiRio9lpXzCSG4JX+D5o7k1uRbJyLMl/zfVTlaoA9B6eWhB
 N6OX6sKkb40jewzQSLiBwo4MeXI7gHyIyGYlx7hjqVELLefA==
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
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

