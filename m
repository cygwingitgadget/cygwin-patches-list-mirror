Return-Path: <SRS0=EBeo=53=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
	by sourceware.org (Postfix) with ESMTPS id F03E83858D1E
	for <cygwin-patches@cygwin.com>; Mon, 30 Jan 2023 13:09:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F03E83858D1E
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (aj135041.dynamic.ppp.asahi-net.or.jp [220.150.135.41]) (authenticated)
	by conuserg-09.nifty.com with ESMTP id 30UD9RCj026975;
	Mon, 30 Jan 2023 22:09:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 30UD9RCj026975
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1675084172;
	bh=d0Mp7gta/W12EZeseG1NSb6H3QWvsOCgPX9mxmWwDB4=;
	h=From:To:Cc:Subject:Date:From;
	b=diru3Ex/VTFWvoxO8mDRbEszZW210GOzhpo+2DCGpitSd/iuGZSHWMdjCxg4B/q3O
	 S10/1QlDAIJPTimVahZS7l12Mwvx6KWpDJUOy4MknHCD0a/DJeFLAhu/M06uCul/GO
	 7xeXJJ3VjimkhFLTXMGY1cqnkwVxESuUZ9Ib3uGxr14refXUGrGlEjc52Fg/JEsGIG
	 mnWgWC/x05abzTDm07r9Z/Q4U0iYGL560sZJ7q+VcLHtXeP8FXaDwvEKGT48I3d5Ou
	 iuM8EJZZITdR2OatCukoSnOy6/q8qWfS2lywnu6xqgeOFSiDb3NcauZljPNYv/EtDg
	 zS7G8Uz2Ji5Gw==
X-Nifty-SrcIP: [220.150.135.41]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
        Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH] Cygwin: dsp: Implement SNDCTL_DSP_SETFRAGMENT ioctl().
Date: Mon, 30 Jan 2023 22:09:16 +0900
Message-Id: <20230130130916.47489-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, SNDCTL_DSP_SETFRAGMENT was just a fake. In this patch,
it has been implemented to allow latency control in some apps.

Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/dsp.cc           | 78 ++++++++++++-------------
 winsup/cygwin/local_includes/fhandler.h |  3 +
 2 files changed, 42 insertions(+), 39 deletions(-)

diff --git a/winsup/cygwin/fhandler/dsp.cc b/winsup/cygwin/fhandler/dsp.cc
index cfbf6bec7..dd1aac8e2 100644
--- a/winsup/cygwin/fhandler/dsp.cc
+++ b/winsup/cygwin/fhandler/dsp.cc
@@ -46,6 +46,8 @@ details. */
      children. They only inherit the settings from the parent.
  */
 
+enum { DEFAULT_BLOCKS = 12, MAX_BLOCKS = 256 };
+
 class fhandler_dev_dsp::Audio
 { // This class contains functionality common to Audio_in and Audio_out
  public:
@@ -67,7 +69,6 @@ class fhandler_dev_dsp::Audio
   void (fhandler_dev_dsp::Audio::*convert_)
     (unsigned char *buffer, int size_bytes);
 
-  enum { MAX_BLOCKS = 12 };
   int bufferIndex_;  // offset into pHdr_->lpData
   WAVEHDR *pHdr_;    // data to be filled by write
   WAVEHDR wavehdr_[MAX_BLOCKS];
@@ -126,7 +127,6 @@ class fhandler_dev_dsp::Audio_out: public Audio
   bool waitforspace ();
   bool sendcurrent ();
 
-  enum { MAX_BLOCKS = 12 };
   HWAVEOUT dev_;     // The wave device
   /* Private copies of audiofreq_, audiobits_, audiochannels_,
      possibly set from wave file */
@@ -235,9 +235,9 @@ fhandler_dev_dsp::Audio::queue::query ()
 fhandler_dev_dsp::Audio::Audio (fhandler_dev_dsp *my_fh)
 {
   bigwavebuffer_ = NULL;
-  Qisr2app_ = new queue (MAX_BLOCKS);
-  convert_ = &fhandler_dev_dsp::Audio::convert_none;
   fh = my_fh;
+  Qisr2app_ = new queue (fh->fragstotal_);
+  convert_ = &fhandler_dev_dsp::Audio::convert_none;
 }
 
 fhandler_dev_dsp::Audio::~Audio ()
@@ -389,14 +389,13 @@ fhandler_dev_dsp::Audio_out::start ()
 {
   WAVEFORMATEX format;
   MMRESULT rc;
-  unsigned bSize = blockSize (freq_, bits_, channels_);
 
   if (dev_)
     return true;
 
   /* In case of fork bigwavebuffer may already exist */
   if (!bigwavebuffer_)
-    bigwavebuffer_ = new char[MAX_BLOCKS * bSize];
+    bigwavebuffer_ = new char[fh->fragstotal_ * fh->fragsize_];
 
   if (!isvalid ())
     return false;
@@ -405,7 +404,7 @@ fhandler_dev_dsp::Audio_out::start ()
   rc = waveOutOpen (&dev_, WAVE_MAPPER, &format, (DWORD_PTR) waveOut_callback,
 		     (DWORD_PTR) this, CALLBACK_FUNCTION);
   if (rc == MMSYSERR_NOERROR)
-    init (bSize);
+    init (fh->fragsize_);
 
   debug_printf ("%u = waveOutOpen(freq=%d bits=%d channels=%d)", rc, freq_, bits_, channels_);
 
@@ -450,7 +449,7 @@ fhandler_dev_dsp::Audio_out::init (unsigned blockSize)
 
   // internally queue all of our buffer for later use by write
   Qisr2app_->reset ();
-  for (i = 0; i < MAX_BLOCKS; i++)
+  for (i = 0; i < fh->fragstotal_; i++)
     {
       wavehdr_[i].lpData = &bigwavebuffer_[i * blockSize];
       wavehdr_[i].dwUser = (int) blockSize;
@@ -505,8 +504,8 @@ fhandler_dev_dsp::Audio_out::buf_info (audio_buf_info *p,
     {
       /* If the device is running we use the internal values,
 	 possibly set from the wave file. */
-      p->fragstotal = MAX_BLOCKS;
-      p->fragsize = blockSize (freq_, bits_, channels_);
+      p->fragstotal = fh->fragstotal_;
+      p->fragsize = fh->fragsize_;
       p->fragments = Qisr2app_->query ();
       if (pHdr_ != NULL)
 	p->bytes = (int)pHdr_->dwUser - bufferIndex_
@@ -523,10 +522,10 @@ fhandler_dev_dsp::Audio_out::buf_info (audio_buf_info *p,
 void fhandler_dev_dsp::Audio_out::default_buf_info (audio_buf_info *p,
                                                 int rate, int bits, int channels)
 {
-      p->fragstotal = MAX_BLOCKS;
-      p->fragsize = blockSize (rate, bits, channels);
-      p->fragments = MAX_BLOCKS;
-      p->bytes = p->fragsize * p->fragments;
+  p->fragstotal = DEFAULT_BLOCKS;
+  p->fragsize = blockSize (rate, bits, channels);
+  p->fragments = p->fragstotal;
+  p->bytes = p->fragsize * p->fragments;
 }
 
 /* This is called on an interupt so use locking.. Note Qisr2app_
@@ -552,8 +551,8 @@ fhandler_dev_dsp::Audio_out::waitforspace ()
 	  set_errno (EAGAIN);
 	  return false;
 	}
-      debug_printf ("100ms");
-      switch (cygwait (100))
+      debug_printf ("1ms");
+      switch (cygwait (1))
 	{
 	case WAIT_SIGNALED:
 	  if (!_my_tls.call_signal_handler ())
@@ -584,7 +583,7 @@ fhandler_dev_dsp::Audio_out::waitforspace ()
 void
 fhandler_dev_dsp::Audio_out::waitforallsent ()
 {
-  while (Qisr2app_->query () != MAX_BLOCKS)
+  while (Qisr2app_->query () != fh->fragstotal_)
     {
       debug_printf ("%d blocks in Qisr2app", Qisr2app_->query ());
       Sleep (100);
@@ -771,14 +770,13 @@ fhandler_dev_dsp::Audio_in::start (int rate, int bits, int channels)
 {
   WAVEFORMATEX format;
   MMRESULT rc;
-  unsigned bSize = blockSize (rate, bits, channels);
 
   if (dev_)
     return true;
 
   /* In case of fork bigwavebuffer may already exist */
   if (!bigwavebuffer_)
-    bigwavebuffer_ = new char[MAX_BLOCKS * bSize];
+    bigwavebuffer_ = new char[fh->fragstotal_ * fh->fragsize_];
 
   if (!isvalid ())
     return false;
@@ -790,7 +788,7 @@ fhandler_dev_dsp::Audio_in::start (int rate, int bits, int channels)
 
   if (rc == MMSYSERR_NOERROR)
     {
-      if (!init (bSize))
+      if (!init (fh->fragsize_))
 	return false;
     }
   return (rc == MMSYSERR_NOERROR);
@@ -855,7 +853,7 @@ fhandler_dev_dsp::Audio_in::init (unsigned blockSize)
 
   // try to queue all of our buffer for reception
   Qisr2app_->reset ();
-  for (i = 0; i < MAX_BLOCKS; i++)
+  for (i = 0; i < fh->fragstotal_; i++)
     {
       wavehdr_[i].lpData = &bigwavebuffer_[i * blockSize];
       wavehdr_[i].dwBufferLength = blockSize;
@@ -963,7 +961,7 @@ fhandler_dev_dsp::Audio_in::waitfordata ()
 void fhandler_dev_dsp::Audio_in::default_buf_info (audio_buf_info *p,
                                                 int rate, int bits, int channels)
 {
-  p->fragstotal = MAX_BLOCKS;
+  p->fragstotal = DEFAULT_BLOCKS;
   p->fragsize = blockSize (rate, bits, channels);
   p->fragments = 0;
   p->bytes = 0;
@@ -975,8 +973,8 @@ fhandler_dev_dsp::Audio_in::buf_info (audio_buf_info *p,
 {
   if (dev_)
     {
-      p->fragstotal = MAX_BLOCKS;
-      p->fragsize = blockSize (rate, bits, channels);
+      p->fragstotal = fh->fragstotal_;
+      p->fragsize = fh->fragsize_;
       p->fragments = Qisr2app_->query ();
       if (pHdr_ != NULL)
 	p->bytes = pHdr_->dwBytesRecorded - bufferIndex_
@@ -1068,6 +1066,8 @@ fhandler_dev_dsp::open (int flags, mode_t)
   audiofreq_ = 8000;
   audiobits_ = 8;
   audiochannels_ = 1;
+  fragstotal_ = DEFAULT_BLOCKS;
+  fragment_has_been_set = false;
   switch (flags & O_ACCMODE)
     {
     case O_RDWR:
@@ -1118,6 +1118,8 @@ fhandler_dev_dsp::_write (const void *ptr, size_t len)
     /* nothing to do */;
   else if (IS_WRITE ())
     {
+      if (!fragment_has_been_set)
+	fragsize_ = Audio::blockSize (audiofreq_, audiobits_, audiochannels_);
       debug_printf ("Allocating");
       if (!(audio_out_ = new Audio_out (this)))
 	return -1;
@@ -1162,6 +1164,8 @@ fhandler_dev_dsp::_read (void *ptr, size_t& len)
     /* nothing to do */;
   else if (IS_READ ())
     {
+      if (!fragment_has_been_set)
+	fragsize_ = Audio::blockSize (audiofreq_, audiobits_, audiochannels_);
       debug_printf ("Allocating");
       if (!(audio_in_ = new Audio_in (this)))
 	{
@@ -1237,19 +1241,9 @@ fhandler_dev_dsp::_ioctl (unsigned int cmd, void *buf)
 	break;
 
       CASE (SNDCTL_DSP_GETBLKSIZE)
-	/* This is valid even if audio_X is NULL */
-	if (IS_WRITE ())
-	  {
-	    *intbuf = audio_out_->blockSize (audiofreq_,
-					     audiobits_,
-					     audiochannels_);
-	  }
-	else
-	  { // I am very sure that IS_READ is valid
-	    *intbuf = audio_in_->blockSize (audiofreq_,
-					    audiobits_,
-					    audiochannels_);
-	  }
+	if (!fragment_has_been_set)
+	  fragsize_ = Audio::blockSize (audiofreq_, audiobits_, audiochannels_);
+	*intbuf = fragsize_;
 	return 0;
 
       CASE (SNDCTL_DSP_SETFMT)
@@ -1404,9 +1398,15 @@ fhandler_dev_dsp::_ioctl (unsigned int cmd, void *buf)
       }
 
       CASE (SNDCTL_DSP_SETFRAGMENT)
-	// Fake!! esound & mikmod require this on non PowerPC platforms.
-	//
+      {
+	if (audio_out_ || audio_in_)
+	  return 0; /* Too late to set fragment. Ignore. */
+	int *p = (int *) buf;
+	fragstotal_ = min (*p >> 16, MAX_BLOCKS);
+	fragsize_ = 1 << (*p & 0xffff);
+	fragment_has_been_set = true;
 	return 0;
+      }
 
       CASE (SNDCTL_DSP_GETFMTS)
 	*intbuf = AFMT_S16_LE | AFMT_U8; // only native formats returned here
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index e7315ae16..59e815558 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2759,6 +2759,9 @@ class fhandler_dev_dsp: public fhandler_base
   Audio_out *audio_out_;
   Audio_in  *audio_in_;
   bool being_closed;
+  bool fragment_has_been_set;
+  int fragstotal_;
+  int fragsize_;
  public:
   fhandler_dev_dsp ();
   fhandler_dev_dsp *base () const {return (fhandler_dev_dsp *)archetype;}
-- 
2.39.0

