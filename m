Return-Path: <SRS0=/Ih6=67=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
	by sourceware.org (Postfix) with ESMTPS id 9FA013858D39
	for <cygwin-patches@cygwin.com>; Tue,  7 Mar 2023 02:33:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9FA013858D39
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (aj135041.dynamic.ppp.asahi-net.or.jp [220.150.135.41]) (authenticated)
	by conuserg-08.nifty.com with ESMTP id 3272XOSk015636;
	Tue, 7 Mar 2023 11:33:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 3272XOSk015636
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1678156409;
	bh=1TWvSRFw0CtdF7sRilR+Uxno3/8YM52Aa5yJ3u6s6/g=;
	h=From:To:Cc:Subject:Date:From;
	b=a8OlPCB0ssTPLFMPluHzUeksTwsGLgnLsd2YkuSfyx5pkHhWYa0JeCHFbgLipTtLN
	 DdjLqgYmkwBu7aaH+1FnV3v0wEMwFORuNhXEUSdX5Zs3aYXLKgd+H8ySKXo88NvIpe
	 PBWKDTZM6Tc67nmfE8lUUJJakhesa4PaKszxOOMAL52LacJyZMhhEh54k0/bYkKE/e
	 nn0IUARABfuVhr1Ju0zdZSrxUWF5Az1DVWsS2Ry7tYWsXI+kXN2g8j0uoNvJhIOwLr
	 hviQJWR9UDLzfHPTgFuygFJZaPiDckdG5Dii18DiUNgA+t9bjSXKsYCmP3+EEUs/2O
	 Fw/2TeNrHx80Q==
X-Nifty-SrcIP: [220.150.135.41]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
        Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH] Cygwin: ctty: Replace ctty constant with more descriptive macros.
Date: Tue,  7 Mar 2023 11:33:16 +0900
Message-Id: <20230307023316.1190-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This patch replaces ctty constants with more descriptive macros
(CTTY_UNINITIALIZED and CTTY_RELEASED) rather than -1 and -2 as
well as checking sign with CTTY_IS_VALID().

Fixes: 3b7df69aaa57 (Cygwin: ctty: Add comments for the special values: -1 and -2.)
Suggested-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/dtable.cc                 |  8 ++++----
 winsup/cygwin/exceptions.cc             |  2 +-
 winsup/cygwin/external.cc               |  4 ++--
 winsup/cygwin/fhandler/console.cc       | 10 ++++++----
 winsup/cygwin/fhandler/process.cc       |  4 ++--
 winsup/cygwin/fhandler/pty.cc           | 12 ++++++------
 winsup/cygwin/fhandler/termios.cc       |  7 ++++---
 winsup/cygwin/local_includes/fhandler.h | 11 +++++++++++
 winsup/cygwin/local_includes/tty.h      |  2 +-
 winsup/cygwin/pinfo.cc                  | 17 +++++++----------
 winsup/cygwin/spawn.cc                  |  2 +-
 winsup/cygwin/syscalls.cc               |  6 ++----
 winsup/cygwin/tty.cc                    |  2 +-
 13 files changed, 48 insertions(+), 39 deletions(-)

diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
index 0ed3ea85d..7a8c12aa5 100644
--- a/winsup/cygwin/dtable.cc
+++ b/winsup/cygwin/dtable.cc
@@ -323,7 +323,7 @@ dtable::init_std_file_from_handle (int fd, HANDLE handle)
 	   || GetNumberOfConsoleInputEvents (handle, (DWORD *) &buf))
     {
       /* Console I/O */
-      if (myself->ctty > 0)
+      if (CTTY_IS_VALID (myself->ctty))
 	dev.parse (myself->ctty);
       else
 	{
@@ -603,10 +603,10 @@ fh_alloc (path_conv& pc)
 	      fhraw = cnew_no_ctor (fhandler_console, -1);
 	      debug_printf ("not called from open for /dev/tty");
 	    }
-	  else if (myself->ctty <= 0 && last_tty_dev
+	  else if (!CTTY_IS_VALID (myself->ctty) && last_tty_dev
 		   && !myself->set_ctty (fh_last_tty_dev, 0))
 	    debug_printf ("no /dev/tty assigned");
-	  else if (myself->ctty > 0)
+	  else if (CTTY_IS_VALID (myself->ctty))
 	    {
 	      debug_printf ("determining /dev/tty assignment for ctty %p", myself->ctty);
 	      if (iscons_dev (myself->ctty))
@@ -682,7 +682,7 @@ build_fh_pc (path_conv& pc)
 
   /* Keep track of the last tty-like thing opened.  We could potentially want
      to open it if /dev/tty is referenced. */
-  if (myself->ctty > 0 || !fh->is_tty () || !pc.isctty_capable ())
+  if (CTTY_IS_VALID (myself->ctty) || !fh->is_tty () || !pc.isctty_capable ())
     last_tty_dev = FH_NADA;
   else
     last_tty_dev = fh->dev ();
diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index c3433ab94..642afb788 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1049,7 +1049,7 @@ ctrl_c_handler (DWORD type)
       return FALSE;
     }
 
-  if (myself->ctty != -1)
+  if (myself->ctty != CTTY_UNINITIALIZED)
     {
       if (type == CTRL_CLOSE_EVENT)
 	{
diff --git a/winsup/cygwin/external.cc b/winsup/cygwin/external.cc
index 582bab84f..97e452874 100644
--- a/winsup/cygwin/external.cc
+++ b/winsup/cygwin/external.cc
@@ -73,12 +73,12 @@ fillout_pinfo (pid_t pid, int winpid)
 	  ep.pid = thispid + MAX_PID;
 	  ep.dwProcessId = thispid;
 	  ep.process_state = PID_IN_USE;
-	  ep.ctty = -1;
+	  ep.ctty = CTTY_UNINITIALIZED;
 	  break;
 	}
       else if (nextpid || p->pid == pid)
 	{
-	  ep.ctty = (p->ctty < 0 || iscons_dev (p->ctty))
+	  ep.ctty = (!CTTY_IS_VALID (p->ctty) || iscons_dev (p->ctty))
 		    ? p->ctty : device::minor (p->ctty);
 	  ep.pid = p->pid;
 	  ep.ppid = p->ppid;
diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 0cbfe4ea4..c67385e99 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -665,12 +665,13 @@ fhandler_console::set_unit ()
     this_unit == FH_CONSOLE || this_unit == FH_CONIN || this_unit == FH_CONOUT;
   if (!generic_console && this_unit != FH_TTY)
     unit = get_minor ();
-  else if (myself->ctty != -1)
+  else if (myself->ctty != CTTY_UNINITIALIZED)
     unit = device::minor (myself->ctty);
 
   if (shared_console_info[unit])
     ; /* Do nothing */
-  else if (generic_console && myself->ctty != -1 && !iscons_dev (myself->ctty))
+  else if (generic_console
+	   && myself->ctty != CTTY_UNINITIALIZED && !iscons_dev (myself->ctty))
     devset = FH_ERROR;
   else
     {
@@ -1731,7 +1732,7 @@ int
 fhandler_console::dup (fhandler_base *child, int flags)
 {
   /* See comments in fhandler_pty_slave::dup */
-  if (myself->ctty != -2)
+  if (myself->ctty != CTTY_RELEASED)
     myself->set_ctty (this, flags);
   return 0;
 }
@@ -1932,7 +1933,8 @@ fhandler_console::close ()
   memset (&con_ra, 0, sizeof (con_ra));
 
   if (!have_execed && !invisible_console
-      && (myself->ctty <= 0 || get_device () == (dev_t) myself->ctty))
+      && (!CTTY_IS_VALID (myself->ctty)
+	  || get_device () == (dev_t) myself->ctty))
     free_console ();
 
   if (shared_console_info[unit])
diff --git a/winsup/cygwin/fhandler/process.cc b/winsup/cygwin/fhandler/process.cc
index 864e2f4d5..1e5e83b4a 100644
--- a/winsup/cygwin/fhandler/process.cc
+++ b/winsup/cygwin/fhandler/process.cc
@@ -468,7 +468,7 @@ static off_t
 format_process_ctty (void *data, char *&destbuf)
 {
   _pinfo *p = (_pinfo *) data;
-  if (p->ctty < 0)
+  if (!CTTY_IS_VALID (p->ctty))
     {
       destbuf = (char *) crealloc_abort (destbuf, 2);
       return __small_sprintf (destbuf, "\n");
@@ -1098,7 +1098,7 @@ format_process_stat (void *data, char *&destbuf)
 /* ctty maj is 31:16, min is 15:0; tty_nr s/b maj 15:8, min 31:20, 7:0;
    maj is 31:16 >> 16 & fff << 8; min is 15:0 >> 8 & ff << 20 | & ff */
   int tty_nr = 0;
-  if (p->ctty > 0)
+  if (CTTY_IS_VALID (p->ctty))
     tty_nr =   (((p->ctty >>  8) & 0xff)  << 20)
 	     | (((p->ctty >> 16) & 0xfff) <<  8)
 	     |   (p->ctty        & 0xff);
diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 0dac80a16..664d7dbc6 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -1609,12 +1609,12 @@ fhandler_pty_slave::dup (fhandler_base *child, int flags)
   /* This code was added in Oct 2001 for some undisclosed reason.
      However, setting the controlling tty on a dup causes rxvt to
      hang when the parent does a dup since the controlling pgid changes.
-     Specifically testing for -2 (ctty has been setsid'ed) works around
-     this problem.  However, it's difficult to see scenarios in which you
-     have a dup'able fd, no controlling tty, and not having run setsid.
-     So, we might want to consider getting rid of the set_ctty in tty-like dup
-     methods entirely at some point */
-  if (myself->ctty != -2)
+     Specifically testing for CTTY_RELEASED (ctty has been setsid'ed)
+     works around this problem.  However, it's difficult to see scenarios
+     in which you have a dup'able fd, no controlling tty, and not having
+     run setsid.  So, we might want to consider getting rid of the
+     set_ctty in tty-like dup methods entirely at some point */
+  if (myself->ctty != CTTY_RELEASED)
     myself->set_ctty (this, flags);
   report_tty_counts (child, "duped slave", "");
   return 0;
diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
index 5b92cdd31..1a5dfdd1b 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -111,7 +111,7 @@ fhandler_termios::tcsetpgrp (const pid_t pgid)
 int
 fhandler_termios::tcgetpgrp ()
 {
-  if (myself->ctty > 0 && myself->ctty == tc ()->ntty)
+  if (CTTY_IS_VALID (myself->ctty) && myself->ctty == tc ()->ntty)
     return tc ()->pgid;
   set_errno (ENOTTY);
   return -1;
@@ -685,7 +685,7 @@ fhandler_termios::sigflush ()
 pid_t
 fhandler_termios::tcgetsid ()
 {
-  if (myself->ctty > 0 && myself->ctty == tc ()->ntty)
+  if (CTTY_IS_VALID (myself->ctty) && myself->ctty == tc ()->ntty)
     return tc ()->getsid ();
   set_errno (ENOTTY);
   return -1;
@@ -730,7 +730,8 @@ fhandler_termios::ioctl (int cmd, void *varg)
 
   termios_printf ("myself->ctty %d, myself->sid %d, myself->pid %d, arg %d, tc()->getsid () %d\n",
 		  myself->ctty, myself->sid, myself->pid, arg, tc ()->getsid ());
-  if (myself->ctty > 0 || myself->sid != myself->pid || (!arg && tc ()->getsid () > 0))
+  if (CTTY_IS_VALID (myself->ctty) || myself->sid != myself->pid
+      || (!arg && tc ()->getsid () > 0))
     {
       set_errno (EPERM);
       return -1;
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 085a2a10d..f82f565cf 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -1905,6 +1905,17 @@ class fhandler_serial: public fhandler_base
 #define release_output_mutex() \
   __release_output_mutex (__PRETTY_FUNCTION__, __LINE__)
 
+/*
+ -1: CTTY is not initialized yet. Can associate with the TTY
+     which is associated with the own session.
+ -2: CTTY has been released by setsid(). Can associate with
+     a new TTY as CTTY, but cannot associate with the TTYs
+     already associated with other sessions.
+*/
+#define CTTY_UNINITIALIZED -1
+#define CTTY_RELEASED -2
+#define CTTY_IS_VALID(c) ((c) > 0)
+
 extern DWORD mutex_timeout;
 DWORD acquire_attach_mutex (DWORD t);
 void release_attach_mutex (void);
diff --git a/winsup/cygwin/local_includes/tty.h b/winsup/cygwin/local_includes/tty.h
index cd1d6ecaa..df3bf60bf 100644
--- a/winsup/cygwin/local_includes/tty.h
+++ b/winsup/cygwin/local_includes/tty.h
@@ -13,7 +13,7 @@ details. */
 #define INP_BUFFER_SIZE 256
 #define OUT_BUFFER_SIZE 256
 #define NTTYS		128
-#define real_tty_attached(p)	((p)->ctty > 0 && !iscons_dev ((p)->ctty))
+#define real_tty_attached(p)	(CTTY_IS_VALID ((p)->ctty) && !iscons_dev ((p)->ctty))
 
 /* Input/Output/ioctl events */
 
diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
index 37770b643..bfd338e5b 100644
--- a/winsup/cygwin/pinfo.cc
+++ b/winsup/cygwin/pinfo.cc
@@ -97,7 +97,7 @@ pinfo_init (char **envp, int envc)
 
       myself.thisproc (NULL);
       myself->pgid = myself->sid = myself->pid;
-      myself->ctty = -1; /* -1 means not initialized yet. */
+      myself->ctty = CTTY_UNINITIALIZED;
       myself->uid = ILLEGAL_UID;
       myself->gid = ILLEGAL_GID;
       environ_init (NULL, 0);	/* call after myself has been set up */
@@ -212,7 +212,7 @@ pinfo::exit (DWORD n)
     maybe_set_exit_code_from_windows ();	/* may block */
   exit_state = ES_FINAL;
 
-  if (myself->ctty > 0 && !iscons_dev (myself->ctty))
+  if (CTTY_IS_VALID (myself->ctty) && !iscons_dev (myself->ctty))
     {
       lock_ttys here;
       tty *t = cygwin_shared->tty[device::minor(myself->ctty)];
@@ -514,7 +514,7 @@ pinfo::pinfo (HANDLE parent, pinfo_minimal& from, pid_t pid):
 const char *
 _pinfo::_ctty (char *buf)
 {
-  if (ctty <= 0)
+  if (!CTTY_IS_VALID (ctty))
     strcpy (buf, "no ctty");
   else
     {
@@ -530,12 +530,9 @@ _pinfo::set_ctty (fhandler_termios *fh, int flags)
 {
   tty_min& tc = *fh->tc ();
   debug_printf ("old %s, ctty device number %y, tc.ntty device number %y flags & O_NOCTTY %y", __ctty (), ctty, tc.ntty, flags & O_NOCTTY);
-  if (fh && (ctty <= 0 || ctty == tc.ntty) && !(flags & O_NOCTTY))
+  if (fh && (!CTTY_IS_VALID (ctty) || ctty == tc.ntty) && !(flags & O_NOCTTY))
     {
-      if (tc.getsid () && tc.getsid () != sid && ctty == -2)
-	/* ctty == -2 means CTTY has been released by setsid().
-	   Can be associated only with a new TTY which is not
-	   associated with any other session. */
+      if (tc.getsid () && tc.getsid () != sid && ctty == CTTY_RELEASED)
 	; /* Do nothing if another session is associated with the TTY. */
       else
 	{
@@ -581,14 +578,14 @@ _pinfo::set_ctty (fhandler_termios *fh, int flags)
 	 an obvious bug surfaces. */
       if (sid == pid && !tc.getsid ())
 	tc.setsid (sid);
-      if (ctty > 0)
+      if (CTTY_IS_VALID (ctty))
 	sid = tc.getsid ();
       /* See above */
       if ((!tc.getpgid () || being_debugged ()) && pgid == pid)
 	tc.setpgid (pgid);
     }
   debug_printf ("cygheap->ctty now %p, archetype %p", cygheap->ctty, fh ? fh->archetype : NULL);
-  return ctty > 0;
+  return CTTY_IS_VALID (ctty);
 }
 
 /* Test to determine if a process really exists and is processing signals.
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 32ba5b377..4d0ca127b 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -623,7 +623,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
       si.cb = sizeof (si);
 
       if (!iscygwin ())
-	init_console_handler (myself->ctty > 0);
+	init_console_handler (CTTY_IS_VALID (myself->ctty));
 
     loop:
       /* When ruid != euid we create the new process under the current original
diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index c529192b4..8ae0397fb 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -1176,9 +1176,7 @@ setsid (void)
     syscall_printf ("hmm.  pgid %d pid %d", myself->pgid, myself->pid);
   else
     {
-      myself->ctty = -2; /* -2 means CTTY has been released by setsid().
-			    Can be associated only with a new TTY which
-			    is not associated with any session. */
+      myself->ctty = CTTY_RELEASED;
       myself->sid = myself->pid;
       myself->pgid = myself->pid;
       if (cygheap->ctty)
@@ -2832,7 +2830,7 @@ ctermid (char *str)
 {
   if (str == NULL)
     str = _my_tls.locals.ttybuf;
-  if (myself->ctty < 0)
+  if (!CTTY_IS_VALID (myself->ctty))
     strcpy (str, "no tty");
   else
     {
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index 6ec8927cb..bf7c6010f 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -58,7 +58,7 @@ revoke (char *ttyname)
 extern "C" int
 ttyslot (void)
 {
-  if (myself->ctty <= 0 || iscons_dev (myself->ctty))
+  if (!CTTY_IS_VALID (myself->ctty) || iscons_dev (myself->ctty))
     return -1;
   return device::minor (myself->ctty);
 }
-- 
2.39.0

