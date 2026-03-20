Return-Path: <SRS0=xrNc=BU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:27])
	by sourceware.org (Postfix) with ESMTPS id E63EA4B1A2D0
	for <cygwin-patches@cygwin.com>; Fri, 20 Mar 2026 14:30:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E63EA4B1A2D0
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E63EA4B1A2D0
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774017011; cv=none;
	b=LEC6XDoJf4zAbftqE0t28o75xbJ+7R+nfJ7e6k8V7fXnyYJqMcjcHPirFF62efShko3fdLXvfJR0dKgrDdsvWKhtkLEi9wUUAf46o/4YQ9qW2jdQdKOArQmVpfYTM/MP2u0h+EsXashh3uhq2eII0oTe4lsk1qRggeKX6EVws24=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774017011; c=relaxed/simple;
	bh=hLFtecHPjiwmaIU4L650NsRAb4QMbv0EubZb4k6Hrvs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=RVdy8uZ75XYk+kxDFINwEnf/eZyC9veb7o+7O2tBqYIjS8dAejTz1ih9zMLXmk9Ch7DMwhr5R894IYha/GVm0K5SLibzsRtt3VUmCOPu+UmIx//T+gSOQZaowjZsvhuzAIkRRbii9F6n82Vz6iTGBV/TkK7U2n6nuxHZh8bSJr4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E63EA4B1A2D0
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=qMq622I4
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260320143009225.CZAQ.19957.HP-Z230@nifty.com>;
          Fri, 20 Mar 2026 23:30:09 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v4 3/6] Cygwin: console Use input_mutex in the parent PTY in master thread
Date: Fri, 20 Mar 2026 23:28:52 +0900
Message-ID: <20260320142925.8779-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260320142925.8779-1-takashi.yano@nifty.ne.jp>
References: <20260319105608.597-1-takashi.yano@nifty.ne.jp>
 <20260320142925.8779-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774017009;
 bh=A98iPmmCw1nWUxKPNQRCHQxoYbOlPYBIgc55INPv0EU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=qMq622I4G9B4xvKGzd7d+cdlHWFopwUBIrjLWrnFTjJd7xx23jf6PKIyh4A6/vMp2VEzI7QA
 m5OVbXcdSjsSfkGDaTVScOl0Vd+rTYri9WIqr+gkq/dZL/w+f8CsWJqOQ6nAjVraHUJFZ3twFY
 oRmEqIkg36R8PgKqjRpaJoLDCJGFLib34DangQuHCtZczbVcqbwKPuhdIhHcT1t8Fi9ORwb/X3
 h3jZo96jhQnXTWgpwTv0Gvy59iK1Dw5IeUDTCm6czpf8VdSsvkpafMXMqrFCnlXFuvOawE5wsi
 UaGnbXUHdsllw+a1pFsS/W0iB5amOTLnnVpMR9YqmN93rheQ==
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 7fd655d0e..0b4293f3e 100644
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
@@ -648,6 +653,8 @@ remove_record:
 	  while (true);
 	}
 skip_writeback:
+      if (inside_pcon)
+	ReleaseMutex (parent_pty_input_mutex);
       ReleaseMutex (p->input_mutex);
       cygwait (40);
     }
@@ -1953,6 +1960,8 @@ fhandler_console::setup_pcon_hand_over ()
 	    inside_pcon = true;
 	    atexit (fhandler_console::pcon_hand_over_proc);
 	    parent_pty = i;
+	    parent_pty_input_mutex =
+	      cygwin_shared->tty[i]->open_input_mutex (MAXIMUM_ALLOWED);
 	    break;
 	  }
       }
@@ -1980,6 +1989,7 @@ fhandler_console::pcon_hand_over_proc (void)
     }
   else
     system_printf("Acquiring pcon_ho_mutex failed.");
+  CloseHandle (parent_pty_input_mutex);
   /* Do not release the mutex.
      Hold onto the mutex until this process completes. */
 }
-- 
2.51.0

