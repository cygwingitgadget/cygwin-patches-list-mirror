Return-Path: <SRS0=dMBQ=EG=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e10.mail.nifty.com (mta-snd-e10.mail.nifty.com [106.153.226.42])
	by sourceware.org (Postfix) with ESMTPS id 536DA4143841
	for <cygwin-patches@cygwin.com>; Wed, 10 Jun 2026 16:36:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 536DA4143841
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 536DA4143841
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1781109379; cv=none;
	b=Ezg3fuXoXzCIr+88MCbR4MlUhrtqJ847ukTHrOKJmEGypjGzw7UlrltOOVzCZ1MFFbV6qKYx473LKoqQrvkBGD2vQOr215SHUY+WYM6OpNBXENfJ48tJUW1tKHQ0w9VlW1KpsAkunRp+vCz+3R2ff75bS9UrFCvuTmyl5M91aB4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1781109379; c=relaxed/simple;
	bh=lyVcSnaPMyyM10uxGMLgsTVSp+C4IB8VP1+X504fix8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=HJ/YnZvux8ny00fY6hLUMLV5clr5eCpA5MHWgUEdJY5d0xHuFxAcLh32/hzllkE/7eiCni9oGznpc5b9bTQAmlCWxIUyWQ6t8gxP4M/boqIwzfwa4VAuGwFx0UDrimzf7AWqXjzJAj89dmuLn7mVXoNG+d2J5aN4bS1H3BFS4bo=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=GqwiPF7g
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 536DA4143841
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=GqwiPF7g
Received: from HP-Z230 by mta-snd-e10.mail.nifty.com with ESMTP
          id <20260610163612571.KSZX.3198.HP-Z230@nifty.com>;
          Thu, 11 Jun 2026 01:36:12 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 3/3] Cygwin: console: Fix typeahead input for bash
Date: Thu, 11 Jun 2026 01:35:14 +0900
Message-ID: <20260610163533.10187-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260610163533.10187-1-takashi.yano@nifty.ne.jp>
References: <20260610163533.10187-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1781109372;
 bh=5odYhPuCYwn1nqkx2B25Xx6EXhY1mB2oVz70Fe2e9gs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GqwiPF7gtWmgs4HufcIFipbq/3a3alXoUgeuNdj0H4v+uU1nW80/MUQ3PwQLi+5sWGSNysVx
 Rhgrje6b8cGQyipIu4725uCasNnW9BvQKiH+4jRL1bwpgDVQcIl9BW6x4PJ0eDTLmTqIA+cE6Z
 iK+xgzAJ59DKCO5V4P0sithxZGNYd/2jUVNxHlKaAzEe0dbqp65dSWvwfmxYdGwKqHTgY6l4bC
 jOdIjibfG190isyWviwBJPCDaZti9AaeinR21CKDUp/JnZBGwoMe1UP7F99P5/aM8EgjYvoK/G
 4bmyiZMoexuoNwXLWJv5No+kHP0YjIpcABNSKWk8+uM3Prhw==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently, following misbehaviour occurs in bash.
  1) Run "sleep 10".
  2) Type "cmd<enter>ps<enter>" while "sleep is running".
  3) After "sleep" ends, "ps" does not run in "cmd".
  4) exit from "cmd". Then, "ps" is executed.
This is because process_input_message() handles all the events in
the console input buffer, and stores key input into readahead buffer.
However, since the readahead buffer is unique to process, "cmd"
cannot read it. Since "ps<enter>" is stored in bash's readahead
buffer, it is executed by bash after "cmd" exits. With this patch,
process_input_message() handles only the requested amount of events
by read().

Fixes: 8382778cdb57 ("Cygwin: console: fix select() behaviour")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/console.cc       | 15 ++++++++++++---
 winsup/cygwin/local_includes/fhandler.h |  2 +-
 winsup/cygwin/select.cc                 |  2 +-
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 9ac492980..1e4367816 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -1273,7 +1273,7 @@ wait_retry:
 
       int ret;
       acquire_input_mutex (mutex_timeout);
-      ret = process_input_message ();
+      ret = process_input_message (buflen);
       switch (ret)
 	{
 	case input_error:
@@ -1328,9 +1328,10 @@ sig_exit:
 }
 
 fhandler_console::input_states
-fhandler_console::process_input_message (void)
+fhandler_console::process_input_message (size_t len)
 {
   char tmp[60];
+  size_t num_chars = 0;
 
   if (!shared_console_info[unit])
     return input_error;
@@ -1717,6 +1718,7 @@ fhandler_console::process_input_message (void)
 	  continue;
 	}
 
+      num_chars += nread;
       if (toadd)
 	{
 	  ssize_t ret;
@@ -1734,15 +1736,22 @@ fhandler_console::process_input_message (void)
 		goto out;
 	    }
 	}
+      /* len == 0 if called from select.cc:peek_console() */
+      if (len && num_chars >= len)
+	goto out;
     }
 out:
+  if (len == 0)
+    /* If len == 0, cancel reading from console input buffer.
+       Clear readahead buffer. */
+    eat_readahead (-1);
   /* Discard processed recored. */
   DWORD discard_len = min (total_read, i + 1);
   /* If input is signalled, do not discard input here because
      tcflush() is already called from line_edit(). */
   if (stat == input_signalled && !(ti->c_lflag & NOFLSH))
     discard_len = 0;
-  if (discard_len)
+  if (discard_len && (len || stat != input_ok))
     {
       acquire_attach_mutex (mutex_timeout);
       DWORD resume_pid = attach_console (con.owner);
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 49e0e7983..322592bf1 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2327,7 +2327,7 @@ private:
     fh->copy_from (this);
     return fh;
   }
-  input_states process_input_message ();
+  input_states process_input_message (size_t len);
   bg_check_types bg_check (int sig, bool dontsignal = false);
   void setup_io_mutex (void);
   DWORD __acquire_input_mutex (const char *fn, int ln, DWORD ms);
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 523c46ee6..b72083447 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1172,7 +1172,7 @@ peek_console (select_record *me, bool)
 	  if (!r || !events_read)
 	    break;
 	}
-      if (fhandler_console::input_winch == fh->process_input_message ()
+      if (fhandler_console::input_winch == fh->process_input_message (0)
 	  && global_sigs[SIGWINCH].sa_handler != SIG_IGN
 	  && global_sigs[SIGWINCH].sa_handler != SIG_DFL)
 	{
-- 
2.51.0

