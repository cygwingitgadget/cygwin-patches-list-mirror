Return-Path: <cygwin-patches-return-8538-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 66267 invoked by alias); 1 Apr 2016 15:43:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 65974 invoked by uid 89); 1 Apr 2016 15:43:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=
X-HELO: mail-qk0-f169.google.com
Received: from mail-qk0-f169.google.com (HELO mail-qk0-f169.google.com) (209.85.220.169) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Fri, 01 Apr 2016 15:42:52 +0000
Received: by mail-qk0-f169.google.com with SMTP id o6so39957880qkc.2        for <cygwin-patches@cygwin.com>; Fri, 01 Apr 2016 08:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:from:to:cc:subject:date:message-id;        bh=TMlnM7oD6pzrBxIWPy8hcaqOk9CjguMiehMTBOcv1/U=;        b=JaYdcpu9jukv/aTEZVVb1r3Oq/xZEEzUodoJSv/oJE8OBxzN4P3VygTYqEjcX4G9nQ         rfVVR6a8IPiqjiusjqph+/7PRC+LkY7aZ/g0oTZ7C9gOQBv8NnUAtrsOa8nhIk+Ma2yu         nkMpWwC4B9oPT1J6iReFejZEbBmNWpMQpyfBow1/uWi5Z/atoH9X2kAOzJCF1vazlfrW         yNhz4VU6yvqn1ne9dvn+2Cvq01CZR4AEBRjqU/cOXr4kYN0IT8CezrXF+ef3HCN10KH1         DuIdSnA4IqTlrffkecYQjW4JA9/KkqGFoPTDvzlHJGxfUl5ae+cSllTzXVM5/NHNKGhS         ZIRw==
X-Gm-Message-State: AD7BkJLWkSRW2xiNDYUrStnUwKNqjTXxFadi7jOyvMsajrSBXh1o7dIjo/rjTQaqeNeEhQ==
X-Received: by 10.55.25.229 with SMTP id 98mr19235170qkz.18.1459525370291;        Fri, 01 Apr 2016 08:42:50 -0700 (PDT)
Received: from bronx.local.pefoley.com (foleype-1-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:ee7::2])        by smtp.gmail.com with ESMTPSA id d188sm6373932qkb.9.2016.04.01.08.42.49        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);        Fri, 01 Apr 2016 08:42:49 -0700 (PDT)
From: Peter Foley <pefoley2@pefoley.com>
To: cygwin-patches@cygwin.com
Cc: Peter Foley <pefoley2@pefoley.com>
Subject: [RFC PATCH v3] Refactor to avoid nonnull checks on "this" pointer.
Date: Fri, 01 Apr 2016 15:43:00 -0000
Message-Id: <1459525365-21482-1-git-send-email-pefoley2@pefoley.com>
X-IsSubscribed: yes
X-SW-Source: 2016-q2/txt/msg00013.txt.bz2

G++ 6.0 asserts that the "this" pointer is non-null for member
functions.
Refactor methods that check if this is non-null to resolve this.

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
Just wanted to make sure that this approach looked good before I fix all the problematic files.

 winsup/cygwin/fhandler_dsp.cc | 55 +++++++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 15 deletions(-)

diff --git a/winsup/cygwin/fhandler_dsp.cc b/winsup/cygwin/fhandler_dsp.cc
index 9fa2c6e..55944b4 100644
--- a/winsup/cygwin/fhandler_dsp.cc
+++ b/winsup/cygwin/fhandler_dsp.cc
@@ -65,7 +65,7 @@ class fhandler_dev_dsp::Audio
   void convert_S16LE_S16BE (unsigned char *buffer, int size_bytes);
   void fillFormat (WAVEFORMATEX * format,
 		   int rate, int bits, int channels);
-  unsigned blockSize (int rate, int bits, int channels);
+  static unsigned blockSize (int rate, int bits, int channels);
   void (fhandler_dev_dsp::Audio::*convert_)
     (unsigned char *buffer, int size_bytes);
 
@@ -117,6 +117,7 @@ class fhandler_dev_dsp::Audio_out: public Audio
   void stop (bool immediately = false);
   int write (const char *pSampleData, int nBytes);
   void buf_info (audio_buf_info *p, int rate, int bits, int channels);
+  static void default_buf_info (audio_buf_info *p, int rate, int bits, int channels);
   void callback_sampledone (WAVEHDR *pHdr);
   bool parsewav (const char *&pData, int &nBytes,
 		 int rate, int bits, int channels);
@@ -151,6 +152,7 @@ public:
   void stop ();
   bool read (char *pSampleData, int &nBytes);
   void buf_info (audio_buf_info *p, int rate, int bits, int channels);
+  static void default_buf_info (audio_buf_info *p, int rate, int bits, int channels);
   void callback_blockfull (WAVEHDR *pHdr);
 
 private:
@@ -501,11 +503,11 @@ void
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
@@ -516,10 +518,17 @@ fhandler_dev_dsp::Audio_out::buf_info (audio_buf_info *p,
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
@@ -953,14 +962,23 @@ fhandler_dev_dsp::Audio_in::waitfordata ()
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
@@ -970,8 +988,7 @@ fhandler_dev_dsp::Audio_in::buf_info (audio_buf_info *p,
     }
   else
     {
-      p->fragments = 0;
-      p->bytes = 0;
+      default_buf_info(p, rate, bits, channels);
     }
 }
 
@@ -1345,9 +1362,13 @@ fhandler_dev_dsp::_ioctl (unsigned int cmd, void *buf)
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
 
@@ -1359,9 +1380,13 @@ fhandler_dev_dsp::_ioctl (unsigned int cmd, void *buf)
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
2.8.0
