Return-Path: <cygwin-patches-return-4655-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18663 invoked by alias); 4 Apr 2004 22:33:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18652 invoked from network); 4 Apr 2004 22:33:00 -0000
Message-ID: <01C41AA5.8795BD40.Gerd.Spalink@t-online.de>
From: Gerd.Spalink@t-online.de (Gerd Spalink)
Reply-To: "Gerd.Spalink@t-online.de" <Gerd.Spalink@t-online.de>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Again: Support for SNDCTL_DSP_CHANNELS ioctl
Date: Sun, 04 Apr 2004 22:33:00 -0000
Organization: privat
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: VakLBTZ-Zeb8CKP47393wXN6WwqydjzAcOQ84nIE0Djj9TJi1kszYS
X-SW-Source: 2004-q2/txt/msg00007.txt.bz2

Hello,

Below comes my version of the patch and the corresponding test.
I have successfully tested it in my environment.

Gerd


ChangeLog for winsup/cygwin:

2004-04-04  Gerd Spalink  <Gerd.Spalink@t-online.de>
	* fhandler_dsp.cc (fhandler_dev_dsp::ioctl): Add implementation
	for ioctl codes SNDCTL_DSP_CHANNELS and SNDCTL_DSP_GETCAPS

ChangeLog for winsup/testsuite:

2004-04-04  Gerd Spalink  <Gerd.Spalink@t-online.de>
	* winsup.api/devdsp.c (ioctltest): Add 2 tests for ioctl codes
	SNDCTL_DSP_CHANNELS and SNDCTL_DSP_GETCAPS

Index: fhandler_dsp.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_dsp.cc,v
retrieving revision 1.32
diff -p -u -r1.32 fhandler_dsp.cc
--- fhandler_dsp.cc	24 Mar 2004 08:57:17 -0000	1.32
+++ fhandler_dsp.cc	4 Apr 2004 21:51:17 -0000
@@ -1370,6 +1370,38 @@ fhandler_dev_dsp::ioctl (unsigned int cm
       }
       break;
 
+      CASE (SNDCTL_DSP_CHANNELS)
+      {
+	int nChannels = *intptr;
+
+	if (audio_out_)
+	  {	    
+	    RETURN_ERROR_WHEN_BUSY (audio_out_);
+	    audio_out_->stop ();
+	    if (audio_out_->query (audiofreq_, audiobits_, nChannels))
+	      audiochannels_ = nChannels;
+	    else
+	      {
+		*intptr = audiochannels_;
+		return -1;
+	      }
+	  }
+	if (audio_in_)
+	  {
+	    RETURN_ERROR_WHEN_BUSY (audio_in_);
+	    audio_in_->stop ();
+	    if (audio_in_->query (audiofreq_, audiobits_, nChannels))
+	      audiochannels_ = nChannels;
+	    else
+	      {
+		*intptr = audiochannels_;
+		return -1;
+	      }
+	  }
+	return 0;
+      }
+      break;
+
       CASE (SNDCTL_DSP_GETOSPACE)
       {
 	audio_buf_info *p = (audio_buf_info *) ptr;
@@ -1395,6 +1427,13 @@ fhandler_dev_dsp::ioctl (unsigned int cm
       CASE (SNDCTL_DSP_GETFMTS)
       {
 	*intptr = AFMT_S16_LE | AFMT_U8; // only native formats returned here
+	return 0;
+      }
+      break;
+
+      CASE (SNDCTL_DSP_GETCAPS)
+      {
+	*intptr = DSP_CAP_BATCH | DSP_CAP_DUPLEX;
 	return 0;
       }
       break;


Index: devdsp.c
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/devdsp.c,v
retrieving revision 1.1
diff -p -u -r1.1 devdsp.c
--- devdsp.c    24 Mar 2004 10:20:14 -0000      1.1
+++ devdsp.c    4 Apr 2004 22:26:24 -0000
@@ -36,7 +36,7 @@ static const char wavfile_okay[] =

 /* Globals required by libltp */
 const char *TCID = "devdsp";   /* set test case identifier */
-int TST_TOTAL = 32;
+int TST_TOTAL = 34;

 /* Prototypes */
 void sinegen (void *wave, int rate, int bits, int len, int stride);
@@ -92,6 +92,7 @@ ioctltest (void)
 {
   int audio1;
   int ioctl_par;
+  int channels;

   audio1 = open ("/dev/dsp", O_WRONLY);
   if (audio1 < 0)
@@ -99,6 +100,18 @@ ioctltest (void)
       tst_brkm (TFAIL, cleanup, "open W: %s", strerror (errno));
     }
   setpars (audio1, 44100, 1, 16);
+
+  channels = ioctl_par = 1;
+  while (ioctl (audio1, SNDCTL_DSP_CHANNELS, &ioctl_par) == 0)
+    {
+      channels++;
+      ioctl_par = channels;
+    }
+  if (channels == ioctl_par)
+    tst_resm (TFAIL, "Max channels=%d failed", ioctl_par);
+  else
+    tst_resm (TPASS, "Max channels=%d failed, OK=%d", channels, ioctl_par);
+
   /* Note: block size may depend on parameters */
   if (ioctl (audio1, SNDCTL_DSP_GETBLKSIZE, &ioctl_par) < 0)
     {
@@ -110,6 +123,11 @@ ioctltest (void)
       tst_brkm (TFAIL, cleanup, "ioctl GETFMTS: %s", strerror (errno));
     }
   tst_resm (TPASS, "ioctl get formats=%08x", ioctl_par);
+  if (ioctl (audio1, SNDCTL_DSP_GETCAPS, &ioctl_par) < 0)
+    {
+      tst_brkm (TFAIL, cleanup, "ioctl GETCAPS: %s", strerror (errno));
+    }
+  tst_resm (TPASS, "ioctl get caps=%08x", ioctl_par);
   if (close (audio1) < 0)
     {
       tst_brkm (TFAIL, cleanup, "Close audio: %s", strerror (errno));
