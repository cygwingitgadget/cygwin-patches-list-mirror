Return-Path: <cygwin-patches-return-4671-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31383 invoked by alias); 11 Apr 2004 21:00:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31374 invoked from network); 11 Apr 2004 21:00:19 -0000
Message-ID: <01C42018.B589D6F0.Gerd.Spalink@t-online.de>
From: Gerd.Spalink@t-online.de (Gerd Spalink)
Reply-To: "Gerd.Spalink@t-online.de" <Gerd.Spalink@t-online.de>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: Patch for /dev/dsp to make ioctl SNDCTL_DSP_RESET respond immediately
Date: Sun, 11 Apr 2004 21:00:00 -0000
Organization: privat
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: EXGExwZJYev+QR3sGIWUJwz3xbhBKQucqpXy7jvsnzlAc5W04p4Cke
X-SW-Source: 2004-q2/txt/msg00023.txt.bz2

Hello,

This patch makes the device /dev/dsp respond more quickly to
the ioctl SNDCTL_DSP_RESET. Thanks to Eran Tromer for the hint.

There are more fixes in this patch to enhance compatibility with OSS.
I have also adapted the code for the testsuite again.
Please look at the ChangeLogs below.

Gerd


ChangeLog for winsup/cygwin:

2004-04-11  Gerd Spalink  <Gerd.Spalink@t-online.de>
	* fhandler_dsp.cc (fhandler_dev_dsp::Audio_out::stop): Add optional boolean
	argument so that playing can be stopped without playing pending buffers.
	(fhandler_dev_dsp::ioctl): Stop playback immediately for SNDCTL_DSP_RESET.
	Do not reset audio parameters in this case.
	Add support for ioctl SNDCTL_DSP_GETISPACE.
	(fhandler_dev_dsp::Audio_out::emptyblocks): Now returns the number of
	completely empty blocks.
	(fhandler_dev_dsp::Audio_out::buf_info): p->fragments is now the number of
	completely empty blocks. This conforms with the OSS specification.
	(fhandler_dev_dsp::Audio_out::parsewav): Ignore wave headers that are not
	aligned on four byte boundary.
	(fhandler_dev_dsp::Audio_in::buf_info): New, needed for SNDCTL_DSP_GETISPACE.

ChangeLog for winsup/testsuite:

2004-04-11  Gerd Spalink  <Gerd.Spalink@t-online.de>
	* winsup.api/devdsp.c (forkrectest): Move synchronization with child
	so that test passes also under high CPU load.
	(forkplaytest): Ditto.
	(abortplaytest): New function to test ioctl code SNDCTL_DSP_RESET.


Index: fhandler_dsp.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_dsp.cc,v
retrieving revision 1.34
diff -u -p -r1.34 fhandler_dsp.cc
--- fhandler_dsp.cc	10 Apr 2004 13:45:09 -0000	1.34
+++ fhandler_dsp.cc	11 Apr 2004 20:25:07 -0000
@@ -113,7 +113,7 @@ class fhandler_dev_dsp::Audio_out: publi
 
   bool query (int rate, int bits, int channels);
   bool start (int rate, int bits, int channels);
-  void stop ();
+  void stop (bool immediately = false);
   bool write (const char *pSampleData, int nBytes);
   void buf_info (audio_buf_info *p, int rate, int bits, int channels);
   void callback_sampledone (WAVEHDR *pHdr);
@@ -152,6 +152,7 @@ public:
   bool start (int rate, int bits, int channels);
   void stop ();
   bool read (char *pSampleData, int &nBytes);
+  void buf_info (audio_buf_info *p, int rate, int bits, int channels);
   void callback_blockfull (WAVEHDR *pHdr);
 
 private:
@@ -418,7 +419,7 @@ fhandler_dev_dsp::Audio_out::start (int 
 }
 
 void
-fhandler_dev_dsp::Audio_out::stop ()
+fhandler_dev_dsp::Audio_out::stop (bool immediately)
 {
   MMRESULT rc;
   WAVEHDR *pHdr;
@@ -428,8 +429,11 @@ fhandler_dev_dsp::Audio_out::stop ()
 		GetCurrentProcessId (), getOwner ());
   if (getOwner () && !denyAccess ())
     {
-      sendcurrent ();		// force out last block whatever size..
-      waitforallsent ();        // block till finished..
+      if (!immediately)
+	{
+	  sendcurrent ();           // force out last block whatever size..
+	  waitforallsent ();        // block till finished..
+	}
 
       rc = waveOutReset (dev_);
       debug_printf ("waveOutReset rc=%d", rc);
@@ -507,7 +511,7 @@ fhandler_dev_dsp::Audio_out::write (cons
   return true;
 }
 
-// return number of (partially) empty blocks back.
+// return number of (completely) empty blocks back.
 int
 fhandler_dev_dsp::Audio_out::emptyblocks ()
 {
@@ -516,8 +520,6 @@ fhandler_dev_dsp::Audio_out::emptyblocks
   n = Qisr2app_->query ();
   unlock ();
   n += Qapp2app_->query ();
-  if (pHdr_ != NULL)
-    n++;
   return n;
 }
 
@@ -531,8 +533,8 @@ fhandler_dev_dsp::Audio_out::buf_info (a
     {
       p->fragments = emptyblocks ();
       if (pHdr_ != NULL)
-	p->bytes = p->fragsize - bufferIndex_ +
-	  p->fragsize * (p->fragments - 1);
+	p->bytes = (int)pHdr_->dwUser - bufferIndex_
+	  + p->fragsize * p->fragments;
       else
 	p->bytes = p->fragsize * p->fragments;
     }
@@ -685,7 +687,9 @@ fhandler_dev_dsp::Audio_out::parsewav (c
   const char *end = pData + nBytes;
   const char *pDat;
   int skip = 0;
-  
+  // Check alignment first: A lot of the code below depends on it
+  if (((int)pData & 0x3) != 0)
+    return false;
   if (!(pData[0] == 'R' && pData[1] == 'I'
 	&& pData[2] == 'F' && pData[3] == 'F'))
     return false;
@@ -971,6 +975,31 @@ fhandler_dev_dsp::Audio_in::waitfordata 
   bufferIndex_ = 0; 
 }
 
+void
+fhandler_dev_dsp::Audio_in::buf_info (audio_buf_info *p,
+				      int rate, int bits, int channels)
+{
+  p->fragstotal = MAX_BLOCKS;
+  p->fragsize = blockSize (rate, bits, channels);
+  if (getOwner ())
+    {
+      lock ();
+      p->fragments = Qisr2app_->query ();
+      unlock ();
+      p->fragments += Qapp2app_->query ();
+      if (pHdr_ != NULL)
+	p->bytes = pHdr_->dwBytesRecorded - bufferIndex_
+	  + p->fragsize * p->fragments;
+      else
+	p->bytes = p->fragsize * p->fragments;
+    }
+  else
+    {
+      p->fragments = 0;
+      p->bytes = 0;
+    }
+}
+
 // This is called on an interrupt so use locking..
 void
 fhandler_dev_dsp::Audio_in::callback_blockfull (WAVEHDR *pHdr)
@@ -1214,22 +1243,12 @@ fhandler_dev_dsp::ioctl (unsigned int cm
 	if (audio_out_)
 	  {
 	    RETURN_ERROR_WHEN_BUSY (audio_out_);
-	    audioformat_ = AFMT_U8;
-	    audiofreq_ = 8000;
-	    audiobits_ = 8;
-	    audiochannels_ = 1;
-	    audio_out_->stop ();
-	    audio_out_->setformat (audioformat_);
+	    audio_out_->stop (true);
 	  }
 	if (audio_in_)
 	  {
 	    RETURN_ERROR_WHEN_BUSY (audio_in_);
-	    audioformat_ = AFMT_U8;
-	    audiofreq_ = 8000;
-	    audiobits_ = 8;
-	    audiochannels_ = 1;
 	    audio_in_->stop ();
-	    audio_in_->setformat (audioformat_);
 	  }
 	return 0;
 	break;
@@ -1409,6 +1428,20 @@ fhandler_dev_dsp::ioctl (unsigned int cm
 	  {
 	    RETURN_ERROR_WHEN_BUSY (audio_out_);
 	    audio_out_->buf_info (p, audiofreq_, audiobits_, audiochannels_);
+	    debug_printf ("ptr=%p frags=%d fragsize=%d bytes=%d",
+			  ptr, p->fragments, p->fragsize, p->bytes);
+	  }
+	return 0;
+      }
+      break;
+
+      CASE (SNDCTL_DSP_GETISPACE)
+      {
+	audio_buf_info *p = (audio_buf_info *) ptr;
+	if (audio_in_)
+	  {
+	    RETURN_ERROR_WHEN_BUSY (audio_in_);
+	    audio_in_->buf_info (p, audiofreq_, audiobits_, audiochannels_);
 	    debug_printf ("ptr=%p frags=%d fragsize=%d bytes=%d",
 			  ptr, p->fragments, p->fragsize, p->bytes);
 	  }

Index: devdsp.c
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/devdsp.c,v
retrieving revision 1.2
diff -u -p -r1.2 devdsp.c
--- devdsp.c	5 Apr 2004 08:30:13 -0000	1.2
+++ devdsp.c	11 Apr 2004 20:08:44 -0000
@@ -36,7 +36,7 @@ static const char wavfile_okay[] =
 
 /* Globals required by libltp */
 const char *TCID = "devdsp";   /* set test case identifier */
-int TST_TOTAL = 34;
+int TST_TOTAL = 35;
 
 /* Prototypes */
 void sinegen (void *wave, int rate, int bits, int len, int stride);
@@ -53,6 +53,7 @@ void recordingtest (void);
 void playbacktest (void);
 void monitortest (void);
 void ioctltest (void);
+void abortplaytest (void);
 void playwavtest (void);
 void syncwithchild (pid_t pid, int expected_exit_status);
 void cleanup (void);
@@ -80,6 +81,7 @@ main (int argc, char *argv[])
   monitortest ();
   forkplaytest ();
   forkrectest ();
+  abortplaytest ();
   playwavtest ();
   tst_exit ();
   /* NOTREACHED */
@@ -247,11 +249,10 @@ forkrectest (void)
   if (pid)
     {
       tst_resm (TINFO, "forked, child PID=%d", pid);
-      sleep (1);
+      syncwithchild (pid, 0);
       tst_resm (TINFO, "parent records..");
       rectest (fd, 22050, 1, 16);
       tst_resm (TINFO, "parent done");
-      syncwithchild (pid, 0);
     }
   else
     {				/* child */
@@ -273,10 +274,10 @@ forkrectest (void)
   if (pid)
     {
       tst_resm (TINFO, "forked, child PID=%d", pid);
+      syncwithchild (pid, TFAIL);	/* expecting error exit */
       tst_resm (TINFO, "parent records again ..");
       rectest (fd, 22050, 1, 16);
       tst_resm (TINFO, "parent done");
-      syncwithchild (pid, TFAIL);	/* expecting error exit */
     }
   else
     {				/* child */
@@ -315,11 +316,10 @@ forkplaytest (void)
   if (pid)
     {
       tst_resm (TINFO, "forked, child PID=%d", pid);
-      sleep (1);
+      syncwithchild (pid, 0);
       tst_resm (TINFO, "parent plays..");
       playtest (fd, 22050, 0, 8);
       tst_resm (TINFO, "parent done");
-      syncwithchild (pid, 0);
     }
   else
     {				/* child */
@@ -341,10 +341,10 @@ forkplaytest (void)
   if (pid)
     {
       tst_resm (TINFO, "forked, child PID=%d", pid);
+      syncwithchild (pid, TFAIL);	/* expected failure */
       tst_resm (TINFO, "parent plays again..");
       playtest (fd, 22050, 0, 8);
       tst_resm (TINFO, "parent done");
-      syncwithchild (pid, TFAIL);	/* expected failure */
     }
   else
     {				/* child */
@@ -601,6 +601,39 @@ sinegenb (int freq, int samprate, unsign
       value += stride;
       phase += incr;
     }
+}
+
+void
+abortplaytest (void)
+{
+  int audio;
+  int size = sizeof (wavfile_okay);
+  int n;
+  int ioctl_par = 0;
+
+  audio = open ("/dev/dsp", O_WRONLY);
+  if (audio < 0)
+    {
+      tst_brkm (TFAIL, cleanup, "Error open /dev/dsp W: %s",
+		strerror (errno));
+    }
+  if ((n = write (audio, wavfile_okay, size)) < 0)
+    {
+      tst_brkm (TFAIL, cleanup, "write: %s", strerror (errno));
+    }
+  if (n != size)
+    {
+      tst_brkm (TFAIL, cleanup, "Wrote %d, expected %d; exit", n, size);
+    }
+  if (ioctl (audio, SNDCTL_DSP_RESET, &ioctl_par) < 0)
+    {
+      tst_brkm (TFAIL, cleanup, "ioctl DSP_RESET: %s", strerror (errno));
+    }
+  if (close (audio) < 0)
+    {
+      tst_brkm (TFAIL, cleanup, "Close audio: %s", strerror (errno));
+    }
+  tst_resm (TPASS, "Playwav + ioctl DSP_RESET=%d", ioctl_par);
 }
 
 void
