Return-Path: <SRS0=4mOZ=BT=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:27])
	by sourceware.org (Postfix) with ESMTPS id 823A24BA2E12
	for <cygwin-patches@cygwin.com>; Thu, 19 Mar 2026 10:57:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 823A24BA2E12
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 823A24BA2E12
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773917833; cv=none;
	b=VvaNm1dyEqZ1TxPqfue7Dsgi7rzQiCI8MidvibLTXG+0m55k9t/NkDHIQaMkPXfEvt4jFi+qKKb3e9ddhzif6HvbFlDXVRS6NmQireid8M016Naheq3EatigO6fBtTQ+VI8ldWf63l3W/UcVrYnELat559sZriH7Sm0/y+UlQiA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773917833; c=relaxed/simple;
	bh=D+jykCJmKyZuaLIyKEj9c+KV3NJMae4OdR68uanYx8M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Yahji0NXjrQVEu9i/JdBTId2+kW7/4vYLzGsRIQZcPpgbSvLBY+qkYx6VTG1FF4+ljyyWlUefUCyxmrnUXghc5sjioTeIOW0CSbzBO3qJyv0ef0KMjO52PVFmtV7723cFxwME1WxqGcIXxa1gl0YtitCDrVWN1A8eOUK2rNvFVM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 823A24BA2E12
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Lw0zAcn9
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260319105705349.LQAN.19957.HP-Z230@nifty.com>;
          Thu, 19 Mar 2026 19:57:05 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v3 4/6] Cygwin: pty: Apply line_edit() for transferred input to to_cyg
Date: Thu, 19 Mar 2026 19:55:18 +0900
Message-ID: <20260319105608.597-5-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319105608.597-1-takashi.yano@nifty.ne.jp>
References: <20260317122433.721-1-takashi.yano@nifty.ne.jp>
 <20260319105608.597-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773917825;
 bh=Re8/+onEMiucHGAfvKR6cOQu39IHWUAfNR5/i02iUkA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Lw0zAcn90dOcznXi22iIp+r0f7o3O7snktNkYwl92c3lRps8rGobsQbYyV2isTjT46flBl+y
 sgPZuBw2t8c87/4bfqPOfFk2Yy5JuXp/L2XbrBtAD1pKV1a2a+IKbJl1YkT2LuEczZmkX0bipG
 VLMqeFKdSiqFoutglmJRw0K0cQ4ro1axhTX8GnQNqqP/KDXxx9uPnzxOefHQdm7pIL483UTDoT
 thODvIlBbB0lxAtoGMzqA0LVG3wq4rsBS1j3cgACcs+pLP79bTKWefbOlZwuqU8jVfMxqcJn/s
 rvHxu5wQ5mehGDQ9+7bfnrkuZZFbkNs2Z7CZvI9aVpquAvTA==
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The typeahead input while non-cygwin app is running is put into
the pipe directly by transfer_input(). So, if the shell sets the
terminal canonical mode, erase char (such as backspace) fails to
erase chars transferred by transfer_input(). With this patch,
transferred input in the pipe is read and passed to line_edit()
to handle erase chars such as VERASE, VKILL, etc.

Fixes: 10d083c745dd ("Cygwin: pty: Inherit typeahead data between two input pipes.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc           | 135 +++++++++++++++++-------
 winsup/cygwin/local_includes/fhandler.h |  10 +-
 winsup/cygwin/local_includes/tty.h      |   1 +
 3 files changed, 105 insertions(+), 41 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 72a8ba140..2a0e0d2f7 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -210,6 +210,7 @@ atexit_func (void)
 	      {
 		ptys->get_handle_nat (),
 		ptys->get_input_available_event (),
+		ptys->input_transferred_to_cyg,
 		ptys->input_mutex,
 		ptys->pipe_sw_mutex
 	      };
@@ -739,7 +740,7 @@ fhandler_pty_slave::open (int flags, mode_t)
   {
     &from_master_nat_local, &input_available_event, &input_mutex, &inuse,
     &output_mutex, &to_master_nat_local, &pty_owner, &to_master_local,
-    &from_master_local, &pipe_sw_mutex,
+    &from_master_local, &pipe_sw_mutex, &input_transferred_to_cyg,
     NULL
   };
 
@@ -779,6 +780,12 @@ fhandler_pty_slave::open (int flags, mode_t)
       errmsg = "open input event failed, %E";
       goto err;
     }
+  shared_name (buf, INPUT_TRANSFERRED_EVENT, get_minor ());
+  if (!(input_transferred_to_cyg = OpenEvent (MAXIMUM_ALLOWED, TRUE, buf)))
+    {
+      errmsg = "open input transferred event failed, %E";
+      goto err;
+    }
 
   /* FIXME: Needs a method to eliminate tty races */
   {
@@ -993,6 +1000,8 @@ fhandler_pty_slave::close (int flag)
     termios_printf ("CloseHandle (inuse), %E");
   if (!ForceCloseHandle (input_available_event))
     termios_printf ("CloseHandle (input_available_event<%p>), %E", input_available_event);
+  if (!ForceCloseHandle (input_transferred_to_cyg))
+    termios_printf ("CloseHandle (input_transferred_to_cyg<%p>), %E", input_transferred_to_cyg);
   if (!ForceCloseHandle (get_output_handle_nat ()))
     termios_printf ("CloseHandle (get_output_handle_nat ()<%p>), %E",
 	get_output_handle_nat ());
@@ -1101,7 +1110,8 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void)
 		  WaitForSingleObject (input_mutex, mutex_timeout);
 		  acquire_attach_mutex (mutex_timeout);
 		  transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
-				  input_available_event);
+				  input_available_event,
+				  input_transferred_to_cyg);
 		  release_attach_mutex ();
 		  ReleaseMutex (input_mutex);
 		}
@@ -1277,14 +1287,14 @@ fhandler_pty_slave::mask_switch_to_nat_pipe (bool mask, bool xfer)
 	{
 	  acquire_attach_mutex (mutex_timeout);
 	  transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
-			  input_available_event);
+			  input_available_event, input_transferred_to_cyg);
 	  release_attach_mutex ();
 	}
       else if (!mask && get_ttyp ()->pty_input_state_eq (tty::to_cyg))
 	{
 	  acquire_attach_mutex (mutex_timeout);
 	  transfer_input (tty::to_nat, get_handle (), get_ttyp (),
-			  input_available_event);
+			  input_available_event, input_transferred_to_cyg);
 	  release_attach_mutex ();
 	}
     }
@@ -1862,11 +1872,15 @@ fhandler_pty_slave::fch_open_handles (bool chown)
   shared_name (buf, INPUT_AVAILABLE_EVENT, get_minor ());
   input_available_event = OpenEvent (READ_CONTROL | write_access,
 				     TRUE, buf);
+  shared_name (buf, INPUT_TRANSFERRED_EVENT, get_minor ());
+  input_transferred_to_cyg = OpenEvent (READ_CONTROL | write_access,
+					TRUE, buf);
   output_mutex = get_ttyp ()->open_output_mutex (write_access);
   input_mutex = get_ttyp ()->open_input_mutex (write_access);
   pipe_sw_mutex = get_ttyp ()->open_mutex (PIPE_SW_MUTEX, write_access);
   inuse = get_ttyp ()->open_inuse (write_access);
-  if (!input_available_event || !output_mutex || !input_mutex || !inuse)
+  if (!input_available_event || !output_mutex || !input_mutex || !inuse
+      || !input_transferred_to_cyg)
     {
       __seterrno ();
       return false;
@@ -1883,11 +1897,13 @@ fhandler_pty_slave::fch_set_sd (security_descriptor &sd, bool chown)
 
   get_object_sd (input_available_event, sd_old);
   if (!set_object_sd (input_available_event, sd, chown)
+      && !set_object_sd (input_transferred_to_cyg, sd, chown)
       && !set_object_sd (output_mutex, sd, chown)
       && !set_object_sd (input_mutex, sd, chown)
       && !set_object_sd (inuse, sd, chown))
     return 0;
   set_object_sd (input_available_event, sd_old, chown);
+  set_object_sd (input_transferred_to_cyg, sd_old, chown);
   set_object_sd (output_mutex, sd_old, chown);
   set_object_sd (input_mutex, sd_old, chown);
   set_object_sd (inuse, sd_old, chown);
@@ -1900,6 +1916,7 @@ void
 fhandler_pty_slave::fch_close_handles ()
 {
   close_maybe (input_available_event);
+  close_maybe (input_transferred_to_cyg);
   close_maybe (output_mutex);
   close_maybe (input_mutex);
   close_maybe (inuse);
@@ -2151,6 +2168,9 @@ fhandler_pty_master::close (int flag)
   if (!ForceCloseHandle (input_available_event))
     termios_printf ("CloseHandle (input_available_event<%p>), %E",
 		    input_available_event);
+  if (!ForceCloseHandle (input_transferred_to_cyg))
+    termios_printf ("CloseHandle (input_transferred_to_cyg<%p>), %E",
+		    input_transferred_to_cyg);
 
   /* The from_master must be closed last so that the same pty is not
      allocated before cleaning up the other corresponding instances. */
@@ -2248,7 +2268,8 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	      acquire_attach_mutex (mutex_timeout);
 	      fhandler_pty_slave::transfer_input (tty::to_nat, from_master,
 						  get_ttyp (),
-						  input_available_event);
+						  input_available_event,
+						  input_transferred_to_cyg);
 	      release_attach_mutex ();
 	      ReleaseMutex (input_mutex);
 	    }
@@ -2346,7 +2367,8 @@ fhandler_pty_master::write (const void *ptr, size_t len)
     {
       acquire_attach_mutex (mutex_timeout);
       fhandler_pty_slave::transfer_input (tty::to_nat, from_master,
-					  get_ttyp (), input_available_event);
+					  get_ttyp (), input_available_event,
+					  input_transferred_to_cyg);
       release_attach_mutex ();
     }
 
@@ -2707,6 +2729,24 @@ reply:
   return 0;
 }
 
+void
+fhandler_pty_master::apply_line_edit_to_transferred_input ()
+{
+  const size_t pipesize = fhandler_pty_common::pipesize;
+  char buf[pipesize];
+  DWORD n;
+  ReadFile (from_master, buf, pipesize, &n, NULL);
+  char *p = buf;
+  while (n)
+    {
+      ssize_t ret;
+      line_edit (p, n, get_ttyp ()->ti, &ret);
+      n -= ret;
+      p += ret;
+    }
+  SetEvent (input_available_event);
+}
+
 static DWORD
 pty_master_thread (VOID *arg)
 {
@@ -2891,19 +2931,34 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
   char *outbuf = tp.c_get ();
   char *mbbuf = tp.c_get ();
   static mbstate_t mbp;
+  OVERLAPPED ov = {0, };
+  ov.hEvent = CreateEvent(NULL, TRUE, FALSE, NULL);
+  HANDLE w[2] = {ov.hEvent, p->input_transferred_to_cyg};
 
   termios_printf ("Started.");
   for (;;)
     {
       p->ttyp->fwd_last_time = GetTickCount64 ();
-      DWORD n;
-      p->ttyp->fwd_not_empty =
-	::bytes_available (n, p->from_slave_nat) && n;
-      if (!ReadFile (p->from_slave_nat, outbuf, NT_MAX_PATH, &rlen, NULL))
+      if (!ReadFile (p->from_slave_nat, outbuf, NT_MAX_PATH, NULL, &ov)
+	  && GetLastError () != ERROR_IO_PENDING)
 	{
 	  termios_printf ("ReadFile for forwarding failed, %E");
 	  break;
 	}
+wait_event:
+      switch (WaitForMultipleObjects (2, w, FALSE, INFINITE))
+	{
+	case WAIT_OBJECT_0:
+	  GetOverlappedResult (p->from_slave_nat, &ov, &rlen, FALSE);
+	  ResetEvent (ov.hEvent);
+	  break;
+	case WAIT_OBJECT_0 + 1:
+	  p->master->apply_line_edit_to_transferred_input ();
+	  ResetEvent (p->input_transferred_to_cyg);
+	  goto wait_event;
+	default:
+	  goto wait_event;
+	}
       if (p->ttyp->stop_fwd_thread)
 	break;
       ssize_t wlen = rlen;
@@ -3029,7 +3084,8 @@ fhandler_pty_master::setup ()
   char pipename[sizeof ("ptyNNNN-from-master-nat")];
   __small_sprintf (pipename, "pty%d-to-master-nat", unit);
   res = fhandler_pipe::create (&sec_none, &from_slave_nat, &to_master_nat,
-			       fhandler_pty_common::pipesize, pipename, 0);
+			       fhandler_pty_common::pipesize, pipename,
+			       FILE_FLAG_OVERLAPPED);
   if (res)
     {
       errstr = "output pipe for non-cygwin apps";
@@ -3090,6 +3146,10 @@ fhandler_pty_master::setup ()
 					     &sa, TRUE))
       || GetLastError () == ERROR_ALREADY_EXISTS)
     goto err;
+  if (!(input_transferred_to_cyg = t.get_event (errstr = INPUT_TRANSFERRED_EVENT,
+						&sa, TRUE))
+      || GetLastError () == ERROR_ALREADY_EXISTS)
+    goto err;
 
   char buf[MAX_PATH];
   errstr = shared_name (buf, OUTPUT_MUTEX, unit);
@@ -3167,6 +3227,7 @@ err:
   close_maybe (get_handle ());
   close_maybe (get_output_handle ());
   close_maybe (input_available_event);
+  close_maybe (input_transferred_to_cyg);
   close_maybe (output_mutex);
   close_maybe (input_mutex);
   close_maybe (from_master_nat);
@@ -3978,6 +4039,8 @@ fhandler_pty_master::get_master_fwd_thread_param (master_fwd_thread_param_t *p)
   p->from_slave_nat = from_slave_nat;
   p->output_mutex = output_mutex;
   p->ttyp = get_ttyp ();
+  p->input_transferred_to_cyg = input_transferred_to_cyg;
+  p->master = this;
   SetEvent (thread_param_copied_event);
 }
 
@@ -3985,7 +4048,8 @@ fhandler_pty_master::get_master_fwd_thread_param (master_fwd_thread_param_t *p)
 #define CTRL_PRESSED (LEFT_CTRL_PRESSED | RIGHT_CTRL_PRESSED)
 void
 fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
-				    HANDLE input_available_event)
+				    HANDLE input_available_event,
+				    HANDLE input_transferred_to_cyg)
 {
   HANDLE to;
   if (dir == tty::to_nat)
@@ -4107,26 +4171,8 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
 	      ptr = mbbuf;
 	      len = nlen;
 	    }
-	  /* Call WriteFile() line by line */
-	  char *p0 = ptr;
-	  char *p_cr = (char *) memchr (p0, '\r', len - (p0 - ptr));
-	  char *p_lf = (char *) memchr (p0, '\n', len - (p0 - ptr));
-	  while (p_cr || p_lf)
-	    {
-	      char *p1 =
-		p_cr ?  (p_lf ? ((p_cr + 1 == p_lf)
-				 ?  p_lf : min(p_cr, p_lf)) : p_cr) : p_lf;
-	      *p1 = '\n';
-	      n = p1 - p0 + 1;
-	      if (n && WriteFile (to, p0, n, &n, NULL) && n)
-		transfered = true;
-	      p0 = p1 + 1;
-	      p_cr = (char *) memchr (p0, '\r', len - (p0 - ptr));
-	      p_lf = (char *) memchr (p0, '\n', len - (p0 - ptr));
-	    }
-	  n = len - (p0 - ptr);
-	  if (n && WriteFile (to, p0, n, &n, NULL) && n)
-	    transfered = true;
+	  if (len && WriteFile (to, ptr, len, &n, NULL) && n)
+	    transfered = true;;
 	}
     }
   else
@@ -4165,13 +4211,17 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
     }
   CloseHandle (to);
 
+  ttyp->pty_input_state = dir;
   /* Fix input_available_event which indicates availability in cyg pipe. */
   if (dir == tty::to_nat) /* all data is transfered to nat pipe,
 			     so no data available in cyg pipe. */
     ResetEvent (input_available_event);
   else if (transfered) /* There is data transfered to cyg pipe. */
-    SetEvent (input_available_event);
-  ttyp->pty_input_state = dir;
+    {
+      SetEvent (input_transferred_to_cyg);
+      while (IsEventSignalled (input_transferred_to_cyg))
+	yield ();
+    }
   ttyp->discard_input = false;
 }
 
@@ -4191,6 +4241,9 @@ fhandler_pty_slave::get_duplicated_handle_set (handle_set_t *p)
   DuplicateHandle (GetCurrentProcess (), input_available_event,
 		   GetCurrentProcess (), &p->input_available_event,
 		   0, 0, DUPLICATE_SAME_ACCESS);
+  DuplicateHandle (GetCurrentProcess (), input_transferred_to_cyg,
+		   GetCurrentProcess (), &p->input_transferred_to_cyg,
+		   0, 0, DUPLICATE_SAME_ACCESS);
   DuplicateHandle (GetCurrentProcess (), input_mutex,
 		   GetCurrentProcess (), &p->input_mutex,
 		   0, 0, DUPLICATE_SAME_ACCESS);
@@ -4206,6 +4259,8 @@ fhandler_pty_slave::close_handle_set (handle_set_t *p)
   p->from_master_nat = NULL;
   CloseHandle (p->input_available_event);
   p->input_available_event = NULL;
+  CloseHandle (p->input_transferred_to_cyg);
+  p->input_transferred_to_cyg = NULL;
   CloseHandle (p->input_mutex);
   p->input_mutex = NULL;
   CloseHandle (p->pipe_sw_mutex);
@@ -4241,7 +4296,7 @@ fhandler_pty_slave::setup_for_non_cygwin_app (bool nopcon,
       WaitForSingleObject (input_mutex, mutex_timeout);
       acquire_attach_mutex (mutex_timeout);
       transfer_input (tty::to_nat, get_handle (), get_ttyp (),
-		      input_available_event);
+		      input_available_event, input_transferred_to_cyg);
       release_attach_mutex ();
       ReleaseMutex (input_mutex);
     }
@@ -4263,7 +4318,8 @@ fhandler_pty_slave::cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
 	  WaitForSingleObject (p->input_mutex, mutex_timeout);
 	  acquire_attach_mutex (mutex_timeout);
 	  transfer_input (tty::to_cyg, p->from_master_nat, ttyp,
-			  p->input_available_event);
+			  p->input_available_event,
+			  p->input_transferred_to_cyg);
 	  release_attach_mutex ();
 	  ReleaseMutex (p->input_mutex);
 	}
@@ -4289,7 +4345,7 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
       WaitForSingleObject (input_mutex, mutex_timeout);
       acquire_attach_mutex (mutex_timeout);
       transfer_input (tty::to_nat, get_handle (), get_ttyp (),
-		      input_available_event);
+		      input_available_event, input_transferred_to_cyg);
       release_attach_mutex ();
       ReleaseMutex (input_mutex);
     }
@@ -4315,7 +4371,8 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
 	}
       else
 	acquire_attach_mutex (mutex_timeout);
-      transfer_input (tty::to_cyg, from, get_ttyp (), input_available_event);
+      transfer_input (tty::to_cyg, from, get_ttyp (), input_available_event,
+		      input_transferred_to_cyg);
       if (attach_restore)
 	resume_from_temporarily_attach (resume_pid);
       else
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 16f55b4f7..facc3c44c 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2012,6 +2012,7 @@ class fhandler_termios: public fhandler_base
   {
     HANDLE from_master_nat;
     HANDLE input_available_event;
+    HANDLE input_transferred_to_cyg;
     HANDLE input_mutex;
     HANDLE pipe_sw_mutex;
   };
@@ -2385,13 +2386,14 @@ class fhandler_pty_common: public fhandler_termios
   fhandler_pty_common ()
     : fhandler_termios (),
     output_mutex (NULL), input_mutex (NULL), pipe_sw_mutex (NULL),
-    input_available_event (NULL)
+    input_available_event (NULL), input_transferred_to_cyg (NULL)
   {
     pc.file_attributes (FILE_ATTRIBUTE_NORMAL);
   }
   static const unsigned pipesize = 128 * 1024;
   HANDLE output_mutex, input_mutex, pipe_sw_mutex;
   HANDLE input_available_event;
+  HANDLE input_transferred_to_cyg;
 
   bool use_archetype () const {return true;}
   DWORD __acquire_output_mutex (const char *fn, int ln, DWORD ms);
@@ -2514,7 +2516,8 @@ class fhandler_pty_slave: public fhandler_pty_common
   void setup_locale (void);
   void create_invisible_console (void);
   static void transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
-			      HANDLE input_available_event);
+			      HANDLE input_available_event,
+			      HANDLE input_transferred_to_cyg);
   HANDLE get_input_available_event (void) { return input_available_event; }
   bool pcon_activated (void) { return get_ttyp ()->pcon_activated; }
   void cleanup_before_exit ();
@@ -2549,8 +2552,10 @@ public:
   struct master_fwd_thread_param_t {
     HANDLE to_master;
     HANDLE from_slave_nat;
+    HANDLE input_transferred_to_cyg;
     HANDLE output_mutex;
     tty *ttyp;
+    fhandler_pty_master *master;
   };
 private:
   int pktmode;			// non-zero if pty in a packet mode.
@@ -2627,6 +2632,7 @@ public:
   void get_master_thread_param (master_thread_param_t *p);
   void get_master_fwd_thread_param (master_fwd_thread_param_t *p);
   bool need_send_ctrl_c_event ();
+  void apply_line_edit_to_transferred_input ();
 };
 
 class fhandler_dev_null: public fhandler_base
diff --git a/winsup/cygwin/local_includes/tty.h b/winsup/cygwin/local_includes/tty.h
index 9485e24c5..cd1e202f1 100644
--- a/winsup/cygwin/local_includes/tty.h
+++ b/winsup/cygwin/local_includes/tty.h
@@ -18,6 +18,7 @@ details. */
 /* Input/Output/ioctl events */
 
 #define INPUT_AVAILABLE_EVENT	"cygtty.input.avail"
+#define INPUT_TRANSFERRED_EVENT	"cygtty.input.xfer"
 #define OUTPUT_MUTEX		"cygtty.output.mutex"
 #define INPUT_MUTEX		"cygtty.input.mutex"
 #define PIPE_SW_MUTEX		"cygtty.pipe_sw.mutex"
-- 
2.51.0

