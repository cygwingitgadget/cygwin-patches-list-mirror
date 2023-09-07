Return-Path: <SRS0=xe7P=EX=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta0009.nifty.com (mta-snd00014.nifty.com [106.153.226.46])
	by sourceware.org (Postfix) with ESMTPS id 2D10A3858022
	for <cygwin-patches@cygwin.com>; Thu,  7 Sep 2023 08:36:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2D10A3858022
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain by dmta0009.nifty.com with ESMTP
          id <20230907083647995.CONG.104526.localhost.localdomain@nifty.com>;
          Thu, 7 Sep 2023 17:36:47 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: dsp: Improve response time of select()/poll().
Date: Thu,  7 Sep 2023 17:36:34 +0900
Message-Id: <20230907083634.8110-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

With this patch, the response time of select()/poll() has been
improved by utilizing semaphore (select_sem) just like pipe and
fifo. In addition, notification of exceptional conditions has
been added.

Fixes: 2c06014f12b0 ("Cygwin: dsp: Implement select()/poll().")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/dsp.cc           | 11 ++++++++++-
 winsup/cygwin/local_includes/fhandler.h |  5 +++--
 winsup/cygwin/select.cc                 | 16 ++++++++++++++--
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/fhandler/dsp.cc b/winsup/cygwin/fhandler/dsp.cc
index f1634f7a8..5f78821d4 100644
--- a/winsup/cygwin/fhandler/dsp.cc
+++ b/winsup/cygwin/fhandler/dsp.cc
@@ -536,6 +536,8 @@ inline void
 fhandler_dev_dsp::Audio_out::callback_sampledone (WAVEHDR *pHdr)
 {
   Qisr2app_->send (pHdr);
+  ReleaseSemaphore (fh->get_select_sem (),
+		    get_obj_handle_count (fh->get_select_sem ()) - 1, NULL);
 }
 
 bool
@@ -994,6 +996,8 @@ inline void
 fhandler_dev_dsp::Audio_in::callback_blockfull (WAVEHDR *pHdr)
 {
   Qisr2app_->send (pHdr);
+  ReleaseSemaphore (fh->get_select_sem (),
+		    get_obj_handle_count (fh->get_select_sem ()) - 1, NULL);
 }
 
 static void CALLBACK
@@ -1058,7 +1062,7 @@ fhandler_dev_dsp::fixup_after_exec ()
 
 
 int
-fhandler_dev_dsp::open (int flags, mode_t)
+fhandler_dev_dsp::open (int flags, mode_t mode)
 {
   int ret = -1, err = 0;
   UINT num_in = 0, num_out = 0;
@@ -1093,6 +1097,8 @@ fhandler_dev_dsp::open (int flags, mode_t)
   else
     ret = open_null (flags);
 
+  select_sem = CreateSemaphore (sec_none_cloexec (mode), 0, INT32_MAX, NULL);
+
   debug_printf ("ACCMODE=%y audio_in=%d audio_out=%d, err=%d, ret=%d",
 		flags & O_ACCMODE, num_in, num_out, err, ret);
   if (ret >= 0)
@@ -1226,6 +1232,9 @@ fhandler_dev_dsp::close ()
   being_closed = true;
   close_audio_in ();
   close_audio_out ();
+  ReleaseSemaphore (select_sem, get_obj_handle_count (select_sem) - 1, NULL);
+  CloseHandle (select_sem);
+  select_sem = NULL;
   return fhandler_base::close ();
 }
 
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index d7dc02e89..212c22344 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2875,8 +2875,9 @@ class fhandler_dev_dsp: public fhandler_base
   select_record *select_write (select_stuff *);
   select_record *select_except (select_stuff *);
 
-  bool read_ready();
-  bool write_ready();
+  bool read_ready ();
+  bool write_ready ();
+  bool is_closed () { return being_closed; };
 };
 
 class fhandler_virtual : public fhandler_base
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 3ad12c262..725aab90c 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -2268,6 +2268,9 @@ peek_dsp (select_record *s, bool from_select)
   if (s->write_selected)
       if (s->write_ready || fh->write_ready ())
 	gotone += s->write_ready = true;
+  if (s->except_selected)
+      if (s->except_ready || fh->is_closed ())
+	gotone += s->except_ready = true;
   return gotone;
 }
 
@@ -2296,7 +2299,7 @@ thread_dsp (void *arg)
 	  }
       if (!looping)
 	break;
-      cygwait (sleep_time >> 3);
+      cygwait (di->bye, sleep_time >> 3);
       if (sleep_time < 80)
 	++sleep_time;
       if (di->stop_thread)
@@ -2313,6 +2316,13 @@ start_thread_dsp (select_record *me, select_stuff *stuff)
     me->h = *((select_dsp_info *) stuff->device_specific_dsp)->thread;
   else
     {
+      di->bye = me->fh->get_select_sem ();
+      if (di->bye)
+	DuplicateHandle (GetCurrentProcess (), di->bye,
+			 GetCurrentProcess (), &di->bye,
+			 0, 0, DUPLICATE_SAME_ACCESS);
+      else
+	di->bye = CreateSemaphore (&sec_none_nih, 0, INT32_MAX, NULL);
       di->start = &stuff->start;
       di->stop_thread = false;
       di->thread = new cygthread (thread_dsp, di, "dspsel");
@@ -2324,7 +2334,7 @@ start_thread_dsp (select_record *me, select_stuff *stuff)
 }
 
 static void
-dsp_cleanup (select_record *aaa, select_stuff *stuff)
+dsp_cleanup (select_record *, select_stuff *stuff)
 {
   select_dsp_info *di = (select_dsp_info *) stuff->device_specific_dsp;
   if (!di)
@@ -2332,7 +2342,9 @@ dsp_cleanup (select_record *aaa, select_stuff *stuff)
   if (di->thread)
     {
       di->stop_thread = true;
+      ReleaseSemaphore (di->bye, get_obj_handle_count (di->bye), NULL);
       di->thread->detach ();
+      CloseHandle (di->bye);
     }
   delete di;
   stuff->device_specific_dsp = NULL;
-- 
2.39.0

