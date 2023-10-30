Return-Path: <SRS0=SG5m=GM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta0015.nifty.com (mta-snd00014.nifty.com [106.153.226.46])
	by sourceware.org (Postfix) with ESMTPS id 8570B3858D20
	for <cygwin-patches@cygwin.com>; Mon, 30 Oct 2023 10:59:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8570B3858D20
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8570B3858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.46
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1698663601; cv=none;
	b=WH0jwwg3BQfP6HbsyDGg8Vg/vBl6FsFJ2oeb03PLhwxirx5cQ9O/FpA3QRuddArWDBBktnF3rgFyLX/gVcH+8mVcLWkYkBKAtzo+o3KqHyf2sDnNJuSvaMFkvMysGg/f1aJWTnZbvjLsxpZZ05vWp3xLxWSyJuOooJx2uK0ALBI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1698663601; c=relaxed/simple;
	bh=HPj8vpzdTaBoxOjQ/AJNQZcKA1dCJVwGOJPaQ1kGbYE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=GgA5/eo/ItvZMhtFnh1cWMq+E7C46Rp0YKuYwy7p/2/BN6uCgwcOiyM+9cu+T/pbDBlurqqCrUWW2UtT7H2UJ4cl+wLEl/broY1mINsO1q1++APGCfxzQ7HbqZ02mKMhZ+xFOOP1MvXVH0EH57bANbS+e1HxA7d6Zy/aWfggd0w=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by dmta0015.nifty.com with ESMTP
          id <20231030105955068.XHQF.14278.localhost.localdomain@nifty.com>;
          Mon, 30 Oct 2023 19:59:55 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: dsp: Improve minimum buffser size estimation.
Date: Mon, 30 Oct 2023 19:59:38 +0900
Message-Id: <20231030105938.25790-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The commit 322c7150b25e restricts buffer size with a fixed length,
however, the minimum buffer size should be varied by the sample rate.
With this patch, it is estimated using sample rate, sample width
and number of channels so that the buffer length is not less than
80 msec which is almost the minimum value of Win MME to work.

Fixes: 322c7150b25e ("Cygwin: dsp: Avoid setting buffer that is too small.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/dsp.cc | 60 +++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/winsup/cygwin/fhandler/dsp.cc b/winsup/cygwin/fhandler/dsp.cc
index 97f3eaa27..682618166 100644
--- a/winsup/cygwin/fhandler/dsp.cc
+++ b/winsup/cygwin/fhandler/dsp.cc
@@ -65,7 +65,7 @@ class fhandler_dev_dsp::Audio
   void convert_S16LE_S16BE (unsigned char *buffer, int size_bytes);
   void fillFormat (WAVEFORMATEX * format,
 		   int rate, int bits, int channels);
-  static unsigned blockSize (int rate, int bits, int channels);
+  static unsigned blockSize (double ms, int rate, int bits, int channels);
   void (fhandler_dev_dsp::Audio::*convert_)
     (unsigned char *buffer, int size_bytes);
 
@@ -352,10 +352,10 @@ fhandler_dev_dsp::Audio::fillFormat (WAVEFORMATEX * format,
 
 // calculate a good block size
 unsigned
-fhandler_dev_dsp::Audio::blockSize (int rate, int bits, int channels)
+fhandler_dev_dsp::Audio::blockSize (double ms, int rate, int bits, int channels)
 {
   unsigned blockSize;
-  blockSize = ((bits / 8) * channels * rate) / 8; // approx 125ms per block
+  blockSize = ms * ((bits / 8) * channels * rate) / 1000;
   // round up to multiple of 64
   blockSize +=  0x3f;
   blockSize &= ~0x3f;
@@ -525,7 +525,7 @@ void fhandler_dev_dsp::Audio_out::default_buf_info (audio_buf_info *p,
                                                 int rate, int bits, int channels)
 {
   p->fragstotal = DEFAULT_BLOCKS;
-  p->fragsize = blockSize (rate, bits, channels);
+  p->fragsize = blockSize (125, rate, bits, channels);
   p->fragments = p->fragstotal;
   p->bytes = p->fragsize * p->fragments;
 }
@@ -537,7 +537,7 @@ fhandler_dev_dsp::Audio_out::callback_sampledone (WAVEHDR *pHdr)
 {
   Qisr2app_->send (pHdr);
   ReleaseSemaphore (fh->get_select_sem (),
-		    get_obj_handle_count (fh->get_select_sem ()) - 1, NULL);
+		    get_obj_handle_count (fh->get_select_sem ()), NULL);
 }
 
 bool
@@ -555,8 +555,7 @@ fhandler_dev_dsp::Audio_out::waitforspace ()
 	  set_errno (EAGAIN);
 	  return false;
 	}
-      debug_printf ("1ms");
-      switch (cygwait (1))
+      switch (cygwait (fh->get_select_sem (), 10))
 	{
 	case WAIT_SIGNALED:
 	  if (!_my_tls.call_signal_handler ())
@@ -934,8 +933,7 @@ fhandler_dev_dsp::Audio_in::waitfordata ()
 	  set_errno (EAGAIN);
 	  return false;
 	}
-      debug_printf ("1ms");
-      switch (cygwait (1))
+      switch (cygwait (fh->get_select_sem (), 10))
 	{
 	case WAIT_SIGNALED:
 	  if (!_my_tls.call_signal_handler ())
@@ -967,7 +965,7 @@ void fhandler_dev_dsp::Audio_in::default_buf_info (audio_buf_info *p,
                                                 int rate, int bits, int channels)
 {
   p->fragstotal = DEFAULT_BLOCKS;
-  p->fragsize = blockSize (rate, bits, channels);
+  p->fragsize = blockSize (125, rate, bits, channels);
   p->fragments = 0;
   p->bytes = 0;
 }
@@ -998,7 +996,7 @@ fhandler_dev_dsp::Audio_in::callback_blockfull (WAVEHDR *pHdr)
 {
   Qisr2app_->send (pHdr);
   ReleaseSemaphore (fh->get_select_sem (),
-		    get_obj_handle_count (fh->get_select_sem ()) - 1, NULL);
+		    get_obj_handle_count (fh->get_select_sem ()), NULL);
 }
 
 static void CALLBACK
@@ -1127,8 +1125,13 @@ fhandler_dev_dsp::_write (const void *ptr, size_t len)
     /* nothing to do */;
   else if (IS_WRITE ())
     {
-      if (!fragment_has_been_set)
-	fragsize_ = Audio::blockSize (audiofreq_, audiobits_, audiochannels_);
+      if (fragment_has_been_set)
+	fragsize_ = max (Audio::blockSize (80.0 / fragstotal_, audiofreq_,
+					   audiobits_, audiochannels_),
+			 fragsize_);
+      else
+	fragsize_ = Audio::blockSize (125, audiofreq_, audiobits_,
+				      audiochannels_);
       debug_printf ("Allocating");
       if (!(audio_out_ = new Audio_out (this)))
 	return -1;
@@ -1174,7 +1177,8 @@ fhandler_dev_dsp::_read (void *ptr, size_t& len)
   else if (IS_READ ())
     {
       if (!fragment_has_been_set)
-	fragsize_ = Audio::blockSize (audiofreq_, audiobits_, audiochannels_);
+	fragsize_ = Audio::blockSize (125, audiofreq_, audiobits_,
+				      audiochannels_);
       debug_printf ("Allocating");
       if (!(audio_in_ = new Audio_in (this)))
 	{
@@ -1233,7 +1237,7 @@ fhandler_dev_dsp::close ()
   being_closed = true;
   close_audio_in ();
   close_audio_out ();
-  ReleaseSemaphore (select_sem, get_obj_handle_count (select_sem) - 1, NULL);
+  ReleaseSemaphore (select_sem, get_obj_handle_count (select_sem), NULL);
   CloseHandle (select_sem);
   select_sem = NULL;
   return fhandler_base::close ();
@@ -1255,9 +1259,13 @@ fhandler_dev_dsp::_ioctl (unsigned int cmd, void *buf)
 	break;
 
       CASE (SNDCTL_DSP_GETBLKSIZE)
-	if (!fragment_has_been_set)
-	  fragsize_ = Audio::blockSize (audiofreq_, audiobits_, audiochannels_);
-	*intbuf = fragsize_;
+	if (fragment_has_been_set)
+	  *intbuf = max (Audio::blockSize (80.0 / fragstotal_, audiofreq_,
+					   audiobits_, audiochannels_),
+			 fragsize_);
+	else
+	  *intbuf = Audio::blockSize (125, audiofreq_, audiobits_,
+					audiochannels_);
 	return 0;
 
       CASE (SNDCTL_DSP_SETFMT)
@@ -1387,8 +1395,11 @@ fhandler_dev_dsp::_ioctl (unsigned int cmd, void *buf)
 	  audio_out_->buf_info (p, audiofreq_, audiobits_, audiochannels_);
 	else if (fragment_has_been_set)
 	  {
-	    p->bytes = fragsize_ * fragstotal_;
-	    p->fragsize = fragsize_;
+	    p->fragsize = max (Audio::blockSize (80.0 / fragstotal_,
+						 audiofreq_, audiobits_,
+						 audiochannels_),
+			       fragsize_);
+	    p->bytes = p->fragsize * fragstotal_;
 	    p->fragstotal = fragstotal_;
 	    p->fragments = fragstotal_;
 	  }
@@ -1412,7 +1423,10 @@ fhandler_dev_dsp::_ioctl (unsigned int cmd, void *buf)
 	else if (fragment_has_been_set)
 	  {
 	    p->bytes = 0;
-	    p->fragsize = fragsize_;
+	    p->fragsize = max (Audio::blockSize (80.0 / fragstotal_,
+						 audiofreq_, audiobits_,
+						 audiochannels_),
+			       fragsize_);
 	    p->fragstotal = fragstotal_;
 	    p->fragments = 0;
 	  }
@@ -1430,8 +1444,8 @@ fhandler_dev_dsp::_ioctl (unsigned int cmd, void *buf)
 	int *p = (int *) buf;
 	fragstotal_ = min (*p >> 16, MAX_BLOCKS);
 	fragsize_ = 1 << (*p & 0xffff);
-	while (fragsize_ * fragstotal_ < 16384)
-	  fragsize_ *= 2;
+	if (fragstotal_ < 2)
+	  fragstotal_ = 2;
 	fragment_has_been_set = true;
 	return 0;
       }
-- 
2.39.0

