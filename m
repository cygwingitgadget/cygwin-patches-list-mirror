Return-Path: <SRS0=4mOZ=BT=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id 9C88E4B1968F
	for <cygwin-patches@cygwin.com>; Thu, 19 Mar 2026 10:56:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9C88E4B1968F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9C88E4B1968F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773917819; cv=none;
	b=StYMZrIUuy3rk3/C3knuvAG1Sp4vV3a+vAfalQJB9G1xizeC7koeAoFdarUQ3daARS8ahwvDYCItCYyyaPGFDxY8GHM6cV3Mly3GIHO2tVP+iTOA+NSDrm/lFGBZLbOcPpO2F8ZYvmujOvSSb3HGmEH4L3izcB3vAtJQ8FqNib8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773917819; c=relaxed/simple;
	bh=vS/UtDl+jGfjIUgldncM4xiNq6Q1XghesHdlDQV0vSQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=IA5F8R7ap1k2zXDfiJblZTzwHch041ifpeceFB1JVDwdVG4345zLhHPnw0Qf/op7/EFfaLIMD1hliKrTLN/3s6/m7eGWsft8QCq2WAiqKMHJ5qNbbplnZMLZDR8jT9RC8E1Y6hgW4i/yduhqu/3anGS6iMVOixqBmVT0q3hPiUU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9C88E4B1968F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Jx8d1Twn
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260319105656915.LPZO.19957.HP-Z230@nifty.com>;
          Thu, 19 Mar 2026 19:56:56 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v3 3/6] Cygwin: console Use input_mutex in the parent PTY in master thread
Date: Thu, 19 Mar 2026 19:55:17 +0900
Message-ID: <20260319105608.597-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319105608.597-1-takashi.yano@nifty.ne.jp>
References: <20260317122433.721-1-takashi.yano@nifty.ne.jp>
 <20260319105608.597-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773917817;
 bh=Fijpr85jzhNYZ7g96Kgm9P5PFmXeIDch4Mi65IMe0do=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Jx8d1Twn5CCtbgVJ/suf1GsZWXH632+pSntkliXi4KbOTHfz2vLrwIDKwDbj67gPvzZmJZFh
 ftSZdFUmNPby+8Z2NIf7tj2VdY+Gm8E4hSjRH8ToECegOmvlPauaA9XOQCQYW1vQYw7m5pNbBm
 dYB6HJZq7D+eqjPjs4IASTVOlOJsz5ml8PL3lIucBKMoM0iSjhkEKf4Ej+LVcK8wDkldjxs6MJ
 W0s5+zG1+mBFx2BBfXyUW2uI5Kdvl3/pBAFqcofPdGyrFyZDoy9H/g9TzhrRafaMXCeZrd9cIV
 Iz2fAC3lJq9TWPu63tMds8esPTCXS7N6GAif+B2Tgcgp1Zbg==
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
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
index 2b1b50f0a..310db57c8 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -63,6 +63,7 @@ fhandler_console::console_state NO_COPY
 static bool NO_COPY inside_pcon_checked = false;
 static bool NO_COPY inside_pcon = false;
 static int NO_COPY parent_pty;
+static HANDLE NO_COPY parent_pty_input_mutex = NULL;
 
 bool NO_COPY fhandler_console::invisible_console;
 
@@ -430,6 +431,8 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 	  continue;
 	}
       total_read = 0;
+      if (inside_pcon)
+	WaitForSingleObject (parent_pty_input_mutex, mutex_timeout);
       switch (cygwait (p->input_handle, (DWORD) 0))
 	{
 	case WAIT_OBJECT_0:
@@ -454,6 +457,8 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 	default: /* Error */
 	  free (input_rec);
 	  free (input_tmp);
+	  if (inside_pcon)
+	    ReleaseMutex (parent_pty_input_mutex);
 	  ReleaseMutex (p->input_mutex);
 	  return;
 	}
@@ -616,6 +621,8 @@ remove_record:
 	  while (true);
 	}
 skip_writeback:
+      if (inside_pcon)
+	ReleaseMutex (parent_pty_input_mutex);
       ReleaseMutex (p->input_mutex);
       cygwait (40);
     }
@@ -1921,6 +1928,8 @@ fhandler_console::setup_pcon_hand_over ()
 	    inside_pcon = true;
 	    atexit (fhandler_console::pcon_hand_over_proc);
 	    parent_pty = i;
+	    parent_pty_input_mutex =
+	      cygwin_shared->tty[i]->open_input_mutex (MAXIMUM_ALLOWED);
 	    break;
 	  }
       }
@@ -1948,6 +1957,7 @@ fhandler_console::pcon_hand_over_proc (void)
     }
   else
     system_printf("Acquiring pcon_ho_mutex failed.");
+  CloseHandle (parent_pty_input_mutex);
   /* Do not release the mutex.
      Hold onto the mutex until this process completes. */
 }
-- 
2.51.0

