Return-Path: <SRS0=PWM1=EW=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1015.nifty.com (mta-snd01012.nifty.com [106.153.227.44])
	by sourceware.org (Postfix) with ESMTPS id 5701B3858C78
	for <cygwin-patches@cygwin.com>; Wed,  6 Sep 2023 13:11:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5701B3858C78
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain by dmta1015.nifty.com with ESMTP
          id <20230906131148093.MAQW.25674.localhost.localdomain@nifty.com>;
          Wed, 6 Sep 2023 22:11:48 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: dsp: Implement select()/poll().
Date: Wed,  6 Sep 2023 22:11:33 +0900
Message-Id: <20230906131133.671-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, sound device /dev/dsp did not support select()/poll().
These have been implemented with this patch.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/dsp.cc           |  38 +++++++
 winsup/cygwin/local_includes/fhandler.h |  11 ++
 winsup/cygwin/local_includes/select.h   |   9 +-
 winsup/cygwin/select.cc                 | 130 ++++++++++++++++++++++++
 4 files changed, 187 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/dsp.cc b/winsup/cygwin/fhandler/dsp.cc
index 861443352..f1634f7a8 100644
--- a/winsup/cygwin/fhandler/dsp.cc
+++ b/winsup/cygwin/fhandler/dsp.cc
@@ -1483,3 +1483,41 @@ fhandler_dev_dsp::_fixup_after_exec ()
       audio_out_ = NULL;
     }
 }
+
+bool
+fhandler_dev_dsp::_write_ready ()
+{
+  audio_buf_info info;
+  if (audio_out_)
+    {
+      audio_out_->buf_info (&info, audiofreq_, audiobits_, audiochannels_);
+      return info.bytes > 0;
+    }
+  else
+    return true;
+}
+
+bool
+fhandler_dev_dsp::_read_ready ()
+{
+  audio_buf_info info;
+  if (audio_in_)
+    {
+      audio_in_->buf_info (&info, audiofreq_, audiobits_, audiochannels_);
+      return info.bytes > 0;
+    }
+  else
+    return true;
+}
+
+bool
+fhandler_dev_dsp::write_ready ()
+{
+  return base ()->_write_ready ();
+}
+
+bool
+fhandler_dev_dsp::read_ready ()
+{
+  return base ()->_read_ready ();
+}
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index f2658a242..d7dc02e89 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2847,6 +2847,9 @@ class fhandler_dev_dsp: public fhandler_base
   void close_audio_in ();
   void close_audio_out (bool = false);
 
+  bool _read_ready();
+  bool _write_ready();
+
  public:
   bool use_archetype () const {return true;}
 
@@ -2866,6 +2869,14 @@ class fhandler_dev_dsp: public fhandler_base
     fh->copy_from (this);
     return fh;
   }
+
+  /* select.cc */
+  select_record *select_read (select_stuff *);
+  select_record *select_write (select_stuff *);
+  select_record *select_except (select_stuff *);
+
+  bool read_ready();
+  bool write_ready();
 };
 
 class fhandler_virtual : public fhandler_base
diff --git a/winsup/cygwin/local_includes/select.h b/winsup/cygwin/local_includes/select.h
index b794690b6..4e202128f 100644
--- a/winsup/cygwin/local_includes/select.h
+++ b/winsup/cygwin/local_includes/select.h
@@ -87,6 +87,11 @@ struct select_socket_info: public select_info
   select_socket_info (): select_info (), num_w4 (0), ser_num (0), w4 (NULL) {}
 };
 
+struct select_dsp_info: public select_info
+{
+  select_dsp_info (): select_info () {}
+};
+
 class select_stuff
 {
 public:
@@ -112,6 +117,7 @@ public:
   select_pipe_info *device_specific_ptys;
   select_fifo_info *device_specific_fifo;
   select_socket_info *device_specific_socket;
+  select_dsp_info *device_specific_dsp;
 
   bool test_and_set (int, fd_set *, fd_set *, fd_set *);
   int poll (fd_set *, fd_set *, fd_set *);
@@ -125,7 +131,8 @@ public:
 		   device_specific_pipe (NULL),
 		   device_specific_ptys (NULL),
 		   device_specific_fifo (NULL),
-		   device_specific_socket (NULL)
+		   device_specific_socket (NULL),
+		   device_specific_dsp (NULL)
 		   {}
 };
 
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index bad4c37f3..3ad12c262 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -2255,3 +2255,133 @@ fhandler_timerfd::select_except (select_stuff *stuff)
   s->except_ready = false;
   return s;
 }
+
+static int
+peek_dsp (select_record *s, bool from_select)
+{
+  int gotone = 0;
+  fhandler_dev_dsp *fh = (fhandler_dev_dsp *)(fhandler_base *) s->fh;
+
+  if (s->read_selected)
+      if (s->read_ready || fh->read_ready ())
+	gotone += s->read_ready = true;
+  if (s->write_selected)
+      if (s->write_ready || fh->write_ready ())
+	gotone += s->write_ready = true;
+  return gotone;
+}
+
+static int start_thread_dsp (select_record *me, select_stuff *stuff);
+
+static DWORD
+thread_dsp (void *arg)
+{
+  select_dsp_info *di = (select_dsp_info *) arg;
+  DWORD sleep_time = 0;
+  bool looping = true;
+
+  while (looping)
+    {
+      for (select_record *s = di->start; (s = s->next); )
+	if (s->startup == start_thread_dsp)
+	  {
+	    if (peek_dsp (s, true))
+	      looping = false;
+	    if (di->stop_thread)
+	      {
+		select_printf ("stopping");
+		looping = false;
+		break;
+	      }
+	  }
+      if (!looping)
+	break;
+      cygwait (sleep_time >> 3);
+      if (sleep_time < 80)
+	++sleep_time;
+      if (di->stop_thread)
+	break;
+    }
+  return 0;
+}
+
+static int
+start_thread_dsp (select_record *me, select_stuff *stuff)
+{
+  select_dsp_info *di = stuff->device_specific_dsp;
+  if (di->start)
+    me->h = *((select_dsp_info *) stuff->device_specific_dsp)->thread;
+  else
+    {
+      di->start = &stuff->start;
+      di->stop_thread = false;
+      di->thread = new cygthread (thread_dsp, di, "dspsel");
+      me->h = *di->thread;
+      if (!me->h)
+	return 0;
+    }
+  return 1;
+}
+
+static void
+dsp_cleanup (select_record *aaa, select_stuff *stuff)
+{
+  select_dsp_info *di = (select_dsp_info *) stuff->device_specific_dsp;
+  if (!di)
+    return;
+  if (di->thread)
+    {
+      di->stop_thread = true;
+      di->thread->detach ();
+    }
+  delete di;
+  stuff->device_specific_dsp = NULL;
+}
+
+select_record *
+fhandler_dev_dsp::select_read (select_stuff *stuff)
+{
+  if (!stuff->device_specific_dsp
+      && (stuff->device_specific_dsp = new select_dsp_info) == NULL)
+    return NULL;
+  select_record *s = stuff->start.next;
+  s->startup = start_thread_dsp;
+  s->peek = peek_dsp;
+  s->verify = verify_ok;
+  s->cleanup = dsp_cleanup;
+  s->read_selected = true;
+  s->read_ready = false;
+  return s;
+}
+
+select_record *
+fhandler_dev_dsp::select_write (select_stuff *stuff)
+{
+  if (!stuff->device_specific_dsp
+      && (stuff->device_specific_dsp = new select_dsp_info) == NULL)
+    return NULL;
+  select_record *s = stuff->start.next;
+  s->startup = start_thread_dsp;
+  s->peek = peek_dsp;
+  s->verify = verify_ok;
+  s->cleanup = dsp_cleanup;
+  s->write_selected = true;
+  s->write_ready = false;
+  return s;
+}
+
+select_record *
+fhandler_dev_dsp::select_except (select_stuff *stuff)
+{
+  if (!stuff->device_specific_dsp
+      && (stuff->device_specific_dsp = new select_dsp_info) == NULL)
+    return NULL;
+  select_record *s = stuff->start.next;
+  s->startup = start_thread_dsp;
+  s->peek = peek_dsp;
+  s->verify = verify_ok;
+  s->cleanup = dsp_cleanup;
+  s->except_selected = true;
+  s->except_ready = false;
+  return s;
+}
-- 
2.39.0

