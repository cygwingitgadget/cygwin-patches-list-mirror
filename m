Return-Path: <SRS0=haOa=BZ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:25])
	by sourceware.org (Postfix) with ESMTPS id 5C4094BB5927
	for <cygwin-patches@cygwin.com>; Wed, 25 Mar 2026 13:11:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5C4094BB5927
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5C4094BB5927
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774444291; cv=none;
	b=pQ+DyaR0lY65nQoYV1mG4x93lb/7HSEWRnIFfy9iDin/dPTUSHz8zA6d564VkYAWuE8wggnf2Wv/UAMAJEnZnApsdArFUPzj/flFH7PjmLtWAUukDWio9St1tlwtZY/Pmm+XLktWDIMYg0ITGEW191x5CnFH1ewSGCct7mlZqms=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774444291; c=relaxed/simple;
	bh=Morjc24/gDDOAEW55X1dSD0JkX+P9IQcanYjrQJ/38U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=jo2aVkhUW5Pp5DtrnIXkore7ZSDB5pwXzjLJkZcpjbeotarKagE3NSNimH/y/9XpgFk6dRkJCL3R0L3RvxSpeZQcEW/RoXUYZTkLl8ndAGYHJP/wQyeoW3mq+11ZsaUkS22iQbIJi0tEBWUbmYmHqNTvvHpcIm9yHfulJ/vRKqw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5C4094BB5927
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Gl6Ljwlm
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260325131121702.TVRA.127398.HP-Z230@nifty.com>;
          Wed, 25 Mar 2026 22:11:21 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v6 2/3] Cygwin: pty: Handle CSIc in pcon_start phase
Date: Wed, 25 Mar 2026 22:09:58 +0900
Message-ID: <20260325131056.69116-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260325131056.69116-1-takashi.yano@nifty.ne.jp>
References: <20260312113923.1528-1-takashi.yano@nifty.ne.jp>
 <20260325131056.69116-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774444281;
 bh=TOUwIGbGlFiVkLjmLlFdHBkUn59GfbZ3RjDEZP2QD2U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Gl6Ljwlm3jn7fjQ07ZYNjVlPv3CFuPUtBfshaYCBl05jHhnbmtCunmw+TRj8xBEa9TQbgBn2
 fOys6UNE0BrcDHLuVyf+rkyA6mNACVLI7oRHCnyvYjmecrMVgc5ixq03AsYfuJi6YFzEO73by3
 cdvp+wpH1dW7+1f8tGdWNrEewgFjW2PhH5WJuFNpIIHhev9cZPIBFzREV4mp8tBuUsY38y4/gQ
 ai24ptPCvk2qAsiC3U4cs7cy9xY1p2SHT9B9n5rYQ0KMAYRToLJq6d0VX0WX30LbcjwJIn1dJV
 hnRIVCYP9VRD1sDaMyvIUQQKoOKvg8XRsuFPwNFrZHURYqPQ==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,T_FILL_THIS_FORM_SHORT,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

OpenConsole.exe sends CSIc in addition to CSI6n in pcon_start phase
(in initialization of pseudo console). This patch adds code to handle
CSIc and its response.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:  Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 winsup/cygwin/fhandler/pty.cc           | 60 +++++++++++++++++++------
 winsup/cygwin/local_includes/fhandler.h |  1 +
 winsup/cygwin/local_includes/tty.h      |  1 +
 winsup/cygwin/tty.cc                    |  1 +
 4 files changed, 49 insertions(+), 14 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 84ce9a7dc..92c4a85d1 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -1370,7 +1370,8 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void)
     }
   if (isHybrid)
     return;
-  if (get_ttyp ()->pcon_start) /* Pseudo console initialization is on going */
+  if (get_ttyp ()->pcon_start || get_ttyp ()->pcon_start_csi_c)
+    /* Pseudo console initialization is on going */
     return;
   DWORD wait_ret = WaitForSingleObject (pipe_sw_mutex, mutex_timeout);
   if (wait_ret == WAIT_TIMEOUT)
@@ -1477,7 +1478,8 @@ fhandler_pty_common::to_be_read_from_nat_pipe (void)
      to CSI6n should be go to cyg-pipe. So, wait for pcon_start and
      return false. */
   while (WaitForSingleObject (pipe_sw_mutex, 0) == WAIT_TIMEOUT)
-    if (get_ttyp ()->pcon_start || get_ttyp ()->pcon_start_pid)
+    if (get_ttyp ()->pcon_start || get_ttyp ()->pcon_start_csi_c
+	|| get_ttyp ()->pcon_start_pid)
       return false;
     else
       yield ();
@@ -1803,7 +1805,7 @@ fhandler_pty_slave::tcgetattr (struct termios *t)
     if (cfd->get_major () == DEV_PTYM_MAJOR
 	&& cfd->get_minor () == get_minor ())
       {
-	if (get_ttyp ()->pcon_start)
+	if (get_ttyp ()->pcon_start || get_ttyp ()->pcon_start_csi_c)
 	  t->c_lflag &= ~(ICANON | ECHO);
 	if (get_ttyp ()->pcon_activated)
 	  t->c_iflag &= ~ICRNL;
@@ -2380,13 +2382,16 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 
   get_ttyp ()->discard_input = false;
 
-  if (get_ttyp ()->pcon_start)
+  int pcon_start_mode =
+    get_ttyp ()->pcon_start ? 1 : (get_ttyp ()->pcon_start_csi_c ? 2 : 0);
+  if (pcon_start_mode)
     { /* Reaches here when pseudo console initialization is on going. */
       /* Pseudo condole support uses "CSI6n" to get cursor position.
 	 If the reply for "CSI6n" is divided into multiple writes,
 	 pseudo console sometimes does not recognize it.  Therefore,
 	 put them together into wpbuf and write all at once. */
-      static const int wpbuf_len = strlen ("\033[32768;32868R");
+      /* Do the same for CSIc. */
+      static const int wpbuf_len = 64; /* Enough space for CSIc response */
       static char wpbuf[wpbuf_len];
       static int ixput = 0;
       static int state = 0;
@@ -2422,7 +2427,15 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	  len = orig_len - i - 1;
 	  ptr = p + i + 1;
 	  if (state == 1 && wp_tid == _my_tls.thread_id && p[i] == 'R')
-	    state = 2;
+	    {
+	      get_ttyp ()->pcon_start = false;
+	      state = 2;
+	    }
+	  if (state == 1 && wp_tid == _my_tls.thread_id && p[i] == 'c')
+	    {
+	      get_ttyp ()->pcon_start_csi_c = false;
+	      state = 2;
+	    }
 	  if (state == 2)
 	    {
 	      /* req_xfer_input is true if "ESC[6n" was sent just for
@@ -2433,13 +2446,14 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	      ixput = 0;
 	      state = 0;
 	      get_ttyp ()->req_xfer_input = false;
-	      get_ttyp ()->pcon_start = false;
-	      break;
+	      if (!get_ttyp ()->pcon_start && !get_ttyp ()->pcon_start_csi_c)
+		break;
 	    }
 	}
       ReleaseMutex (input_mutex);
 
-      if (!get_ttyp ()->pcon_start)
+      if (pcon_start_mode
+	  && !get_ttyp ()->pcon_start && !get_ttyp ()->pcon_start_csi_c)
 	{ /* Pseudo console initialization has been done in above code. */
 	  pinfo pp (get_ttyp ()->pcon_start_pid);
 	  if (get_ttyp ()->switch_to_nat_pipe
@@ -2585,7 +2599,7 @@ fhandler_pty_master::tcgetattr (struct termios *t)
 {
   *t = cygwin_shared->tty[get_minor ()]->ti;
   /* Workaround for rlwrap v0.40 or later */
-  if (get_ttyp ()->pcon_start)
+  if (get_ttyp ()->pcon_start || get_ttyp ()->pcon_start_csi_c)
     t->c_lflag &= ~(ICANON | ECHO);
   if (get_ttyp ()->pcon_activated)
     t->c_iflag &= ~ICRNL;
@@ -2948,8 +2962,10 @@ pty_master_thread (VOID *arg)
 #define CONSOLE_HELPER "\\bin\\cygwin-console-helper.exe"
 #define CONSOLE_HELPER_LEN (sizeof (CONSOLE_HELPER) - 1)
 
-inline static DWORD
-workarounds_for_pseudo_console_output (char *outbuf, DWORD rlen)
+DWORD
+fhandler_pty_master::workarounds_for_pseudo_console_output (char *outbuf,
+							    DWORD rlen,
+							    tty *ttyp)
 {
   int state = 0;
   int start_at = 0;
@@ -2958,6 +2974,7 @@ workarounds_for_pseudo_console_output (char *outbuf, DWORD rlen)
   int arg = 0;
   bool saw_greater_than_sign = false;
   bool saw_question_mark = false;
+  static bool in_pcon_start = false;
   for (DWORD i=0; i<rlen; i++)
     if (state == 0 && outbuf[i] == '\033')
       {
@@ -3039,8 +3056,21 @@ workarounds_for_pseudo_console_output (char *outbuf, DWORD rlen)
 	    start_at = i;
 	    state = 1;
 	  }
+	else if (arg == 6 && outbuf[i] == 'n' && ttyp->pcon_start)
+	  {
+	    in_pcon_start = true;
+	    state = 0;
+	  }
+	else if (arg == 0 && outbuf[i] == 'c' && in_pcon_start)
+	  {
+	    ttyp->pcon_start_csi_c = true;
+	    state = 0;
+	  }
 	else
-	  state = 0;
+	  {
+	    in_pcon_start = false;
+	    state = 0;
+	  }
 
 	if (state < 2)
 	  {
@@ -3098,6 +3128,7 @@ workarounds_for_pseudo_console_output (char *outbuf, DWORD rlen)
 	is_osc = false;
 	saw_greater_than_sign = false;
 	saw_question_mark = false;
+	in_pcon_start = false;
 	arg = 0;
 	state = 0;
       }
@@ -3153,7 +3184,8 @@ wait_event:
       char *ptr = outbuf;
       if (p->ttyp->pcon_activated)
 	{
-	  wlen = rlen = workarounds_for_pseudo_console_output (outbuf, rlen);
+	  wlen = rlen =
+	    workarounds_for_pseudo_console_output (outbuf, rlen, p->ttyp);
 
 	  if (p->ttyp->term_code_page != CP_UTF8)
 	    {
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index facc3c44c..5194aec6a 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2577,6 +2577,7 @@ public:
 
   static DWORD pty_master_thread (const master_thread_param_t *p);
   static DWORD pty_master_fwd_thread (const master_fwd_thread_param_t *p);
+  static DWORD workarounds_for_pseudo_console_output (char *, DWORD, tty *);
   int process_slave_output (char *buf, size_t len, int pktmode_on);
   void doecho (const void *str, DWORD len);
   int accept_input ();
diff --git a/winsup/cygwin/local_includes/tty.h b/winsup/cygwin/local_includes/tty.h
index 962697782..4fbebd820 100644
--- a/winsup/cygwin/local_includes/tty.h
+++ b/winsup/cygwin/local_includes/tty.h
@@ -122,6 +122,7 @@ private:
   bool pcon_activated;
   bool pcon_start;
   pid_t pcon_start_pid;
+  bool pcon_start_csi_c;
   bool switch_to_nat_pipe;
   DWORD nat_pipe_owner_pid;
   UINT term_code_page;
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index acc21c0ca..35853186a 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -243,6 +243,7 @@ tty::init ()
   fwd_not_empty = false;
   pcon_start = false;
   pcon_start_pid = 0;
+  pcon_start_csi_c = false;
   pcon_cap_checked = false;
   has_csi6n = false;
   need_invisible_console = false;
-- 
2.51.0

