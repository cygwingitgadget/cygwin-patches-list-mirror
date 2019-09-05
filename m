Return-Path: <cygwin-patches-return-9634-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 65091 invoked by alias); 5 Sep 2019 04:23:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 64999 invoked by uid 89); 5 Sep 2019 04:23:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=pi, UD:name
X-HELO: conuserg-02.nifty.com
Received: from conuserg-02.nifty.com (HELO conuserg-02.nifty.com) (210.131.2.69) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 05 Sep 2019 04:23:15 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-02.nifty.com with ESMTP id x854N0rE007571;	Thu, 5 Sep 2019 13:23:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-02.nifty.com x854N0rE007571
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567657389;	bh=VP8x0MXqC43+uX8oI/Zmi3Dni06vqBzbDQ+XZRIEBcE=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=DnPXaaaPtT5HUbAmji+lBzsJoP0kfvQ4oqruphbkuxSPSitZHWOq+t6XzzQwtthVE	 KVHyklzIyCUxSyYtjO5LztB52gYJfhvgNUuqOCapdHnxw3eikw3xSCukQfPPYEpKxA	 Wmau6KcP2blNqLPpKN/LUNoDU7W1B+Iut/2Yi4Rtgmd2azbbBDHsMKlcRbZIAuizrD	 eA6ED4mPfdBKAn9xPcxW8Sff1eMT2biq7rlls8vljup+wNKLbKMTvbpyWXFYF0G5YG	 eoTYz6JWftKgHVbcnspHwyltapn+nGeuoVllTMIm5S0ohXOp0Z62LH+abghY3jwLTU	 Q4+TH45H120iA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 1/1] Cygwin: pty: Fix select() with pseudo console support.
Date: Thu, 05 Sep 2019 04:23:00 -0000
Message-Id: <20190905042254.1954-2-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190905042254.1954-1-takashi.yano@nifty.ne.jp>
References: <20190905042254.1954-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00154.txt.bz2

- select() did not work correctly when both read and except are
  polled simultaneously for the same fd and the r/w pipe is switched
  to pseudo console side. This patch fixes this isseu.
---
 winsup/cygwin/fhandler.h      |  15 +++
 winsup/cygwin/fhandler_tty.cc |  13 ++-
 winsup/cygwin/select.cc       | 192 ++++++++++++++++++++++++++++++++--
 winsup/cygwin/select.h        |   2 +
 4 files changed, 207 insertions(+), 15 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index e8c165100..e72e11f7a 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2102,6 +2102,7 @@ class fhandler_pty_common: public fhandler_termios
   {
     return get_ttyp ()->hPseudoConsole;
   }
+  bool to_be_read_from_pcon (void);
 
  protected:
   BOOL process_opost_output (HANDLE h,
@@ -2150,6 +2151,8 @@ class fhandler_pty_slave: public fhandler_pty_common
   void fixup_after_exec ();
 
   select_record *select_read (select_stuff *);
+  select_record *select_write (select_stuff *);
+  select_record *select_except (select_stuff *);
   virtual char const *ttyname () { return pc.dev.name (); }
   int __reg2 fstat (struct stat *buf);
   int __reg3 facl (int, int, struct acl *);
@@ -2177,9 +2180,21 @@ class fhandler_pty_slave: public fhandler_pty_common
   void push_to_pcon_screenbuffer (const char *ptr, size_t len);
   void mask_switch_to_pcon (bool mask)
   {
+    if (!mask && get_ttyp ()->pcon_pid &&
+	get_ttyp ()->pcon_pid != myself->pid &&
+	kill (get_ttyp ()->pcon_pid, 0) == 0)
+      return;
     get_ttyp ()->mask_switch_to_pcon = mask;
   }
   void fixup_after_attach (bool native_maybe);
+  pid_t get_pcon_pid (void)
+  {
+    return get_ttyp ()->pcon_pid;
+  }
+  bool is_line_input (void)
+  {
+    return get_ttyp ()->ti.c_lflag & ICANON;
+  }
 };
 
 #define __ptsname(buf, unit) __small_sprintf ((buf), "/dev/pty%d", (unit))
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index a6844832b..78c9c9128 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1223,6 +1223,13 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
   return towrite;
 }
 
+bool
+fhandler_pty_common::to_be_read_from_pcon (void)
+{
+  return get_ttyp ()->switch_to_pcon &&
+    (!get_ttyp ()->mask_switch_to_pcon || ALWAYS_USE_PCON);
+}
+
 void __reg3
 fhandler_pty_slave::read (void *ptr, size_t& len)
 {
@@ -1351,8 +1358,7 @@ fhandler_pty_slave::read (void *ptr, size_t& len)
 	    }
 	  goto out;
 	}
-      if (get_ttyp ()->switch_to_pcon &&
-	  (!get_ttyp ()->mask_switch_to_pcon || ALWAYS_USE_PCON))
+      if (to_be_read_from_pcon ())
 	{
 	  if (!try_reattach_pcon ())
 	    {
@@ -2129,8 +2135,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 
   /* Write terminal input to to_slave pipe instead of output_handle
      if current application is native console application. */
-  if (get_ttyp ()->switch_to_pcon &&
-      (!get_ttyp ()->mask_switch_to_pcon || ALWAYS_USE_PCON))
+  if (to_be_read_from_pcon ())
     {
       char *buf;
       size_t nlen;
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index d29f3d2f4..4efc302df 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -667,9 +667,6 @@ peek_pipe (select_record *s, bool from_select)
 	    fhm->flush_to_slave ();
 	  }
 	  break;
-	case DEV_PTYS_MAJOR:
-	  ((fhandler_pty_slave *) fh)->reset_switch_to_pcon ();
-	  break;
 	default:
 	  if (fh->get_readahead_valid ())
 	    {
@@ -713,6 +710,7 @@ peek_pipe (select_record *s, bool from_select)
     }
 
 out:
+  h = fh->get_output_handle_cyg ();
   if (s->write_selected && dev != FH_PIPER)
     {
       gotone += s->write_ready =  pipe_data_available (s->fd, fh, h, true);
@@ -1176,33 +1174,173 @@ static int
 verify_tty_slave (select_record *me, fd_set *readfds, fd_set *writefds,
 	   fd_set *exceptfds)
 {
-  if (IsEventSignalled (me->h))
+  fhandler_pty_slave *ptys = (fhandler_pty_slave *) me->fh;
+  if (me->read_selected && !ptys->to_be_read_from_pcon () &&
+      IsEventSignalled (ptys->input_available_event))
     me->read_ready = true;
   return set_bits (me, readfds, writefds, exceptfds);
 }
 
 static int
-pty_slave_startup (select_record *s, select_stuff *)
+peek_pty_slave (select_record *s, bool from_select)
 {
+  int gotone = 0;
   fhandler_base *fh = (fhandler_base *) s->fh;
-  ((fhandler_pty_slave *) fh)->mask_switch_to_pcon (true);
+  fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
+
+  ptys->reset_switch_to_pcon ();
+
+  if (s->read_selected)
+    {
+      if (s->read_ready)
+	{
+	  select_printf ("%s, already ready for read", fh->get_name ());
+	  gotone = 1;
+	  goto out;
+	}
+
+      if (fh->bg_check (SIGTTIN, true) <= bg_eof)
+	{
+	  gotone = s->read_ready = true;
+	  goto out;
+	}
+
+      if (ptys->to_be_read_from_pcon ())
+	{
+	  if (ptys->is_line_input ())
+	    {
+#define INREC_SIZE (65536 / sizeof (INPUT_RECORD))
+	      INPUT_RECORD inp[INREC_SIZE];
+	      DWORD n;
+	      PeekConsoleInput (ptys->get_handle (), inp, INREC_SIZE, &n);
+	      bool end_of_line = false;
+	      while (n-- > 0)
+		if (inp[n].EventType == KEY_EVENT &&
+		    inp[n].Event.KeyEvent.bKeyDown &&
+		    inp[n].Event.KeyEvent.uChar.AsciiChar == '\r')
+		  end_of_line = true;
+	      if (end_of_line)
+		{
+		  gotone = s->read_ready = true;
+		  goto out;
+		}
+	      else
+		goto out;
+	    }
+	}
+
+      if (IsEventSignalled (ptys->input_available_event))
+	{
+	  gotone = s->read_ready = true;
+	  goto out;
+	}
+
+      if (!gotone && s->fh->hit_eof ())
+	{
+	  select_printf ("read: %s, saw EOF", fh->get_name ());
+	  if (s->except_selected)
+	    gotone += s->except_ready = true;
+	  if (s->read_selected)
+	    gotone += s->read_ready = true;
+	}
+    }
+
+out:
+  HANDLE h = ptys->get_output_handle_cyg ();
+  if (s->write_selected)
+    {
+      gotone += s->write_ready =  pipe_data_available (s->fd, fh, h, true);
+      select_printf ("write: %s, gotone %d", fh->get_name (), gotone);
+    }
+  return gotone;
+}
+
+static int pty_slave_startup (select_record *me, select_stuff *stuff);
+
+static DWORD WINAPI
+thread_pty_slave (void *arg)
+{
+  select_pipe_info *pi = (select_pipe_info *) arg;
+  DWORD sleep_time = 0;
+  bool looping = true;
+
+  while (looping)
+    {
+      for (select_record *s = pi->start; (s = s->next); )
+	if (s->startup == pty_slave_startup)
+	  {
+	    if (peek_pty_slave (s, true))
+	      looping = false;
+	    if (pi->stop_thread)
+	      {
+		select_printf ("stopping");
+		looping = false;
+		break;
+	      }
+	  }
+      if (!looping)
+	break;
+      Sleep (sleep_time >> 3);
+      if (sleep_time < 80)
+	++sleep_time;
+      if (pi->stop_thread)
+	break;
+    }
+  return 0;
+}
+
+static int
+pty_slave_startup (select_record *me, select_stuff *stuff)
+{
+  fhandler_base *fh = (fhandler_base *) me->fh;
+  fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
+  if (me->read_selected && ptys->get_pcon_pid () != myself->pid)
+    ptys->mask_switch_to_pcon (true);
+
+  select_pipe_info *pi = stuff->device_specific_ptys;
+  if (pi->start)
+    me->h = *((select_pipe_info *) stuff->device_specific_ptys)->thread;
+  else
+    {
+      pi->start = &stuff->start;
+      pi->stop_thread = false;
+      pi->thread = new cygthread (thread_pty_slave, pi, "ptyssel");
+      me->h = *pi->thread;
+      if (!me->h)
+	return 0;
+    }
   return 1;
 }
 
 static void
-pty_slave_cleanup (select_record *s, select_stuff *)
+pty_slave_cleanup (select_record *me, select_stuff *stuff)
 {
-  fhandler_base *fh = (fhandler_base *) s->fh;
-  ((fhandler_pty_slave *) fh)->mask_switch_to_pcon (false);
+  fhandler_base *fh = (fhandler_base *) me->fh;
+  fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
+  if (me->read_selected)
+    ptys->mask_switch_to_pcon (false);
+
+  select_pipe_info *pi = (select_pipe_info *) stuff->device_specific_ptys;
+  if (!pi)
+    return;
+  if (pi->thread)
+    {
+      pi->stop_thread = true;
+      pi->thread->detach ();
+    }
+  delete pi;
+  stuff->device_specific_ptys = NULL;
 }
 
 select_record *
 fhandler_pty_slave::select_read (select_stuff *ss)
 {
+  if (!ss->device_specific_ptys
+      && (ss->device_specific_ptys = new select_pipe_info) == NULL)
+    return NULL;
   select_record *s = ss->start.next;
-  s->h = input_available_event;
   s->startup = pty_slave_startup;
-  s->peek = peek_pipe;
+  s->peek = peek_pty_slave;
   s->verify = verify_tty_slave;
   s->read_selected = true;
   s->read_ready = false;
@@ -1210,6 +1348,38 @@ fhandler_pty_slave::select_read (select_stuff *ss)
   return s;
 }
 
+select_record *
+fhandler_pty_slave::select_write (select_stuff *ss)
+{
+  if (!ss->device_specific_ptys
+      && (ss->device_specific_ptys = new select_pipe_info) == NULL)
+    return NULL;
+  select_record *s = ss->start.next;
+  s->startup = pty_slave_startup;
+  s->peek = peek_pty_slave;
+  s->verify = verify_tty_slave;
+  s->write_selected = true;
+  s->write_ready = false;
+  s->cleanup = pty_slave_cleanup;
+  return s;
+}
+
+select_record *
+fhandler_pty_slave::select_except (select_stuff *ss)
+{
+  if (!ss->device_specific_ptys
+      && (ss->device_specific_ptys = new select_pipe_info) == NULL)
+    return NULL;
+  select_record *s = ss->start.next;
+  s->startup = pty_slave_startup;
+  s->peek = peek_pty_slave;
+  s->verify = verify_tty_slave;
+  s->except_selected = true;
+  s->except_ready = false;
+  s->cleanup = pty_slave_cleanup;
+  return s;
+}
+
 select_record *
 fhandler_dev_null::select_read (select_stuff *ss)
 {
diff --git a/winsup/cygwin/select.h b/winsup/cygwin/select.h
index 7d6dee753..ae98c658d 100644
--- a/winsup/cygwin/select.h
+++ b/winsup/cygwin/select.h
@@ -88,6 +88,7 @@ public:
   select_record start;
 
   select_pipe_info *device_specific_pipe;
+  select_pipe_info *device_specific_ptys;
   select_fifo_info *device_specific_fifo;
   select_socket_info *device_specific_socket;
   select_serial_info *device_specific_serial;
@@ -101,6 +102,7 @@ public:
   select_stuff (): return_on_signal (false), always_ready (false),
 		   windows_used (false), start (),
 		   device_specific_pipe (NULL),
+		   device_specific_ptys (NULL),
 		   device_specific_fifo (NULL),
 		   device_specific_socket (NULL),
 		   device_specific_serial (NULL)
-- 
2.21.0
