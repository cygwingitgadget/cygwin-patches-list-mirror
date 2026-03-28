Return-Path: <SRS0=/csx=B4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:29])
	by sourceware.org (Postfix) with ESMTPS id BDB184BA9018
	for <cygwin-patches@cygwin.com>; Sat, 28 Mar 2026 10:57:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BDB184BA9018
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BDB184BA9018
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:29
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774695424; cv=none;
	b=dOPqmsdoBxIZ1bcedrM9akap3uotuIvVWnwqrEyKnf6MfYnnciJ6rVsUkI9VU5nxWB54j17Mc3SxMarahhoPgCDJhhXMyCQ2uJyPSIC1ykrcBO3PLEkY6xad1RBx+YpvbEHK4bQhfhDuH7qx3SKmb0fKh7XvnGxXPEggjiDOVa8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774695424; c=relaxed/simple;
	bh=cMBnS2augoz28IRbi0N2oIQTPeOwZGFss9CtGTFSg/o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=utN0jrg1nBqonB5ERL8jdODUwv0yCtTrA2tzwh9OyxLqpIjmR07/J2lpprOXTGSdHtthUeTwppIdjnjsJO4VYJPoeMtFdieir2fLuHZLQrJOX4EbOsYfhId+nD5dTNC0mLNhI9bMRiozTS/8D10JwTAKU6Pw/LKExHcGUmmyUag=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BDB184BA9018
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=KTovnN68
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20260328105701920.LDBG.58584.HP-Z230@nifty.com>;
          Sat, 28 Mar 2026 19:57:01 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v8 3/7] Cygwin: console: Use input_mutex in the parent PTY in master thread
Date: Sat, 28 Mar 2026 19:55:47 +0900
Message-ID: <20260328105632.1916-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260328105632.1916-1-takashi.yano@nifty.ne.jp>
References: <20260325130453.62246-1-takashi.yano@nifty.ne.jp>
 <20260328105632.1916-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774695421;
 bh=yse905iDifXJTFOyHnWPlf0G0WGnQWF4rHaXtiwoCoc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KTovnN68XcyC2YgC6yJUKiUJKr3zVdPQCIYQRju1TRhtzVYTb3gv6qlslqtWJ5WGxPTTTqFj
 wxB8EaUIozcXgrTz9Dj1ai52yQVSJb2FlHTPewN9RtOsl2W3xuJEOBfz0RxpGKB9J/j+SKmEO7
 bUxU3b8p89s+OPu5112mDK5+xEkfrnsGeOXseYKEZtwuOKQTA3vr5z10P9LUQ03XTSKu/ahseL
 LFtvHRLqSA15st9W7vlP6i+oZAnEVHd9JOuRLF6MBmJo2TNIvXj8TLfDD/W8zbp0Z1pt48EvfF
 asdjq09QvWZnrXgg2BjNXByVNifVTtMGm3f2SV9cUojdQ8Wg==
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If the console is originating from pseudo console, the input into
console is coming from PTY master. This is because:

When the pseudo console is active, and a cygwin process is started
from non-cygwin process, `cons_master_thread()` runs inside the
Cygwin process that inherited the pseudo console from its parent
PTY. It reads all `INPUT_RECORD`s from the console input buffer via
`ReadConsoleInputW()`, processes signal-generating events (e.g. Ctrl+C),
and writes the remaining records back via `WriteConsoleInputW()`.
Meanwhile, the PTY master process (e.g. mintty) calls
`fhandler_pty_master::write()`, which writes keystrokes to `to_slave_nat`
(one end of the nat pipe). Conhost reads from the other end of that
pipe, parses the byte stream through its VT input path, and inserts
the resulting `INPUT_RECORD`s into the console input buffer.

If `cons_master_thread()` reads the buffer and removes a signal record
while conhost is simultaneously inserting new records from the PTY
master's write, the verify step (`inrec_eq()`) finds records in the
buffer that were not part of the original read, reports a mismatch, and
enters the fixup path. That fixup path itself can disturb the record
order, turning what was merely an interference into an actual problem.
Acquiring the PTY's `input_mutex` in `cons_master_thread()` prevents
`fhandler_pty_master::write()` from feeding new bytes into the pipe
while the read-process-writeback-verify cycle is in progress.

Use parent input_mutex as well as input_mutex in console device in
cons_master_thread().

Fixes: 04f386e9af99 ("Cygwin: console: Inherit pcon hand over from parent pty")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 winsup/cygwin/fhandler/console.cc | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 2a52ba575..39c4f6ff0 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -63,6 +63,7 @@ fhandler_console::console_state NO_COPY
 static bool NO_COPY inside_pcon_checked = false;
 static bool NO_COPY inside_pcon = false;
 static int NO_COPY parent_pty;
+static HANDLE NO_COPY parent_pty_input_mutex = NULL;
 
 bool NO_COPY fhandler_console::invisible_console;
 
@@ -465,6 +466,8 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 	  continue;
 	}
       total_read = 0;
+      if (inside_pcon && parent_pty_input_mutex)
+	WaitForSingleObject (parent_pty_input_mutex, mutex_timeout);
       switch (cygwait (p->input_handle, (DWORD) 0))
 	{
 	case WAIT_OBJECT_0:
@@ -489,6 +492,8 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 	default: /* Error */
 	  free (input_rec);
 	  free (input_tmp);
+	  if (inside_pcon && parent_pty_input_mutex)
+	    ReleaseMutex (parent_pty_input_mutex);
 	  ReleaseMutex (p->input_mutex);
 	  return;
 	}
@@ -666,6 +671,8 @@ remove_record:
 	  while (true);
 	}
 skip_writeback:
+      if (inside_pcon && parent_pty_input_mutex)
+	ReleaseMutex (parent_pty_input_mutex);
       ReleaseMutex (p->input_mutex);
       cygwait (40);
     }
@@ -1971,6 +1978,8 @@ fhandler_console::setup_pcon_hand_over ()
 	    inside_pcon = true;
 	    atexit (fhandler_console::pcon_hand_over_proc);
 	    parent_pty = i;
+	    parent_pty_input_mutex =
+	      cygwin_shared->tty[i]->open_input_mutex (MAXIMUM_ALLOWED);
 	    break;
 	  }
       }
@@ -1997,6 +2006,7 @@ fhandler_console::pcon_hand_over_proc (void)
   else
     system_printf("Acquiring pcon_ho_mutex failed.");
   ReleaseMutex (mtx);
+  ForceCloseHandle (parent_pty_input_mutex);
 }
 
 bool
-- 
2.51.0

