Return-Path: <cygwin-patches-return-8856-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11913 invoked by alias); 17 Sep 2017 02:04:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 10566 invoked by uid 89); 17 Sep 2017 02:04:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-25.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RP_MATCHES_RCVD,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=winsup, audio_in, buf_info, dev_
X-HELO: limerock01.mail.cornell.edu
Received: from limerock01.mail.cornell.edu (HELO limerock01.mail.cornell.edu) (128.84.13.241) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 17 Sep 2017 02:04:32 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite4.serverfarm.cornell.edu [10.16.197.9])	by limerock01.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id v8H24Uaq024095;	Sat, 16 Sep 2017 22:04:30 -0400
Received: from nothing.nyroc.rr.com (mta-68-175-129-7.twcny.rr.com [68.175.129.7] (may be forged))	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id v8H24LfE025218	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);	Sat, 16 Sep 2017 22:04:29 -0400
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 01/12] cygwin: Remove comparisons of 'this' to 'NULL' in fhandler_dsp.cc
Date: Sun, 17 Sep 2017 02:05:00 -0000
Message-Id: <20170917020420.10488-1-kbrown@cornell.edu>
X-PMX-Cornell-Gauge: Gauge=XXXXX
X-PMX-CORNELL-AUTH-RESULTS: dkim-out=none;
X-IsSubscribed: yes
X-SW-Source: 2017-q3/txt/msg00061.txt.bz2

Fix all callers.
---
 winsup/cygwin/fhandler_dsp.cc | 55 +++++++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 15 deletions(-)

diff --git a/winsup/cygwin/fhandler_dsp.cc b/winsup/cygwin/fhandler_dsp.cc
index 5ae3309f8..b5c685bf8 100644
--- a/winsup/cygwin/fhandler_dsp.cc
+++ b/winsup/cygwin/fhandler_dsp.cc
@@ -63,7 +63,7 @@ class fhandler_dev_dsp::Audio
   void convert_S16LE_S16BE (unsigned char *buffer, int size_bytes);
   void fillFormat (WAVEFORMATEX * format,
 		   int rate, int bits, int channels);
-  unsigned blockSize (int rate, int bits, int channels);
+  static unsigned blockSize (int rate, int bits, int channels);
   void (fhandler_dev_dsp::Audio::*convert_)
     (unsigned char *buffer, int size_bytes);
 
@@ -115,6 +115,7 @@ class fhandler_dev_dsp::Audio_out: public Audio
   void stop (bool immediately = false);
   int write (const char *pSampleData, int nBytes);
   void buf_info (audio_buf_info *p, int rate, int bits, int channels);
+  static void default_buf_info (audio_buf_info *p, int rate, int bits, int channels);
   void callback_sampledone (WAVEHDR *pHdr);
   bool parsewav (const char *&pData, int &nBytes,
 		 int rate, int bits, int channels);
@@ -149,6 +150,7 @@ public:
   void stop ();
   bool read (char *pSampleData, int &nBytes);
   void buf_info (audio_buf_info *p, int rate, int bits, int channels);
+  static void default_buf_info (audio_buf_info *p, int rate, int bits, int channels);
   void callback_blockfull (WAVEHDR *pHdr);
 
 private:
@@ -499,11 +501,11 @@ void
 fhandler_dev_dsp::Audio_out::buf_info (audio_buf_info *p,
 				       int rate, int bits, int channels)
 {
-  p->fragstotal = MAX_BLOCKS;
-  if (this && dev_)
+  if (dev_)
     {
       /* If the device is running we use the internal values,
 	 possibly set from the wave file. */
+      p->fragstotal = MAX_BLOCKS;
       p->fragsize = blockSize (freq_, bits_, channels_);
       p->fragments = Qisr2app_->query ();
       if (pHdr_ != NULL)
@@ -514,10 +516,17 @@ fhandler_dev_dsp::Audio_out::buf_info (audio_buf_info *p,
     }
   else
     {
+      default_buf_info(p, rate, bits, channels);
+    }
+}
+
+void fhandler_dev_dsp::Audio_out::default_buf_info (audio_buf_info *p,
+                                                int rate, int bits, int channels)
+{
+      p->fragstotal = MAX_BLOCKS;
       p->fragsize = blockSize (rate, bits, channels);
       p->fragments = MAX_BLOCKS;
       p->bytes = p->fragsize * p->fragments;
-    }
 }
 
 /* This is called on an interupt so use locking.. Note Qisr2app_
@@ -951,14 +960,23 @@ fhandler_dev_dsp::Audio_in::waitfordata ()
   return true;
 }
 
+void fhandler_dev_dsp::Audio_in::default_buf_info (audio_buf_info *p,
+                                                int rate, int bits, int channels)
+{
+  p->fragstotal = MAX_BLOCKS;
+  p->fragsize = blockSize (rate, bits, channels);
+  p->fragments = 0;
+  p->bytes = 0;
+}
+
 void
 fhandler_dev_dsp::Audio_in::buf_info (audio_buf_info *p,
 				      int rate, int bits, int channels)
 {
-  p->fragstotal = MAX_BLOCKS;
-  p->fragsize = blockSize (rate, bits, channels);
-  if (this && dev_)
+  if (dev_)
     {
+      p->fragstotal = MAX_BLOCKS;
+      p->fragsize = blockSize (rate, bits, channels);
       p->fragments = Qisr2app_->query ();
       if (pHdr_ != NULL)
 	p->bytes = pHdr_->dwBytesRecorded - bufferIndex_
@@ -968,8 +986,7 @@ fhandler_dev_dsp::Audio_in::buf_info (audio_buf_info *p,
     }
   else
     {
-      p->fragments = 0;
-      p->bytes = 0;
+      default_buf_info(p, rate, bits, channels);
     }
 }
 
@@ -1343,9 +1360,13 @@ fhandler_dev_dsp::_ioctl (unsigned int cmd, void *buf)
 	    return -1;
 	  }
 	audio_buf_info *p = (audio_buf_info *) buf;
-	audio_out_->buf_info (p, audiofreq_, audiobits_, audiochannels_);
-	debug_printf ("buf=%p frags=%d fragsize=%d bytes=%d",
-		      buf, p->fragments, p->fragsize, p->bytes);
+        if (audio_out_) {
+            audio_out_->buf_info (p, audiofreq_, audiobits_, audiochannels_);
+        } else {
+            Audio_out::default_buf_info(p, audiofreq_, audiobits_, audiochannels_);
+        }
+        debug_printf ("buf=%p frags=%d fragsize=%d bytes=%d",
+                      buf, p->fragments, p->fragsize, p->bytes);
 	return 0;
       }
 
@@ -1357,9 +1378,13 @@ fhandler_dev_dsp::_ioctl (unsigned int cmd, void *buf)
 	    return -1;
 	  }
 	audio_buf_info *p = (audio_buf_info *) buf;
-	audio_in_->buf_info (p, audiofreq_, audiobits_, audiochannels_);
-	debug_printf ("buf=%p frags=%d fragsize=%d bytes=%d",
-		      buf, p->fragments, p->fragsize, p->bytes);
+        if (audio_in_) {
+            audio_in_->buf_info (p, audiofreq_, audiobits_, audiochannels_);
+        } else {
+            Audio_in::default_buf_info(p, audiofreq_, audiobits_, audiochannels_);
+        }
+        debug_printf ("buf=%p frags=%d fragsize=%d bytes=%d",
+                      buf, p->fragments, p->fragsize, p->bytes);
 	return 0;
       }
 
-- 
2.14.1
