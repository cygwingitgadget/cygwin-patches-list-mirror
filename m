Return-Path: <cygwin-patches-return-4863-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18700 invoked by alias); 18 Jul 2004 16:20:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18690 invoked from network); 18 Jul 2004 16:20:19 -0000
Message-ID: <01C46CF3.DE6329F0.Gerd.Spalink@t-online.de>
From: Gerd.Spalink@t-online.de (Gerd Spalink)
Reply-To: "Gerd.Spalink@t-online.de" <Gerd.Spalink@t-online.de>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: Update for the testsuite, devdsp
Date: Sun, 18 Jul 2004 16:20:00 -0000
Organization: privat
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ID: VrxG8uZrQeejyyjuxwltS8XDyAyr54M8mk8zSwxWhAB-QesihozJ62
X-SW-Source: 2004-q3/txt/msg00015.txt.bz2

The first of the two new tests for dup test use of duped file descriptors,
after the first has been closed. The second test checks the consistency of
the audio parameters in duped descriptors.

ChangeLog:

2004-07-18 Gerd Spalink <Gerd.Spalink@t-online.de>

	* devdsp.c (playbacktest): Do not rate successful second open
	as an error, just log the result.
	(recordingtest): ditto.
	(sinegenw): Reduce volume of the beep.
	(sinegenb): ditto.
	(dup_test): New.

Patch:

Index: devdsp.c
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/devdsp.c,v
retrieving revision 1.3
diff -p -u -r1.3 devdsp.c
--- devdsp.c	13 Apr 2004 09:40:03 -0000	1.3
+++ devdsp.c	18 Jul 2004 15:34:32 -0000
@@ -36,7 +36,7 @@ static const char wavfile_okay[] =
 
 /* Globals required by libltp */
 const char *TCID = "devdsp";   /* set test case identifier */
-int TST_TOTAL = 35;
+int TST_TOTAL = 37;
 
 /* Prototypes */
 void sinegen (void *wave, int rate, int bits, int len, int stride);
@@ -57,6 +57,7 @@ void abortplaytest (void);
 void playwavtest (void);
 void syncwithchild (pid_t pid, int expected_exit_status);
 void cleanup (void);
+void dup_test (void);
 
 static int expect_child_failure = 0;
 
@@ -83,6 +84,7 @@ main (int argc, char *argv[])
   forkrectest ();
   abortplaytest ();
   playwavtest ();
+  dup_test ();
   tst_exit ();
   /* NOTREACHED */
   return 0;
@@ -150,15 +152,11 @@ playbacktest (void)
 		strerror (errno));
     }
   audio2 = open ("/dev/dsp", O_WRONLY);
+  tst_resm (TINFO, "Second open /dev/dsp W %s ",
+	    audio2 >= 0 ? "WORKS" : "DOESN'T WORK");
   if (audio2 >= 0)
     {
-      tst_brkm (TFAIL, cleanup,
-		"Second open /dev/dsp W succeeded, but is expected to fail");
-    }
-  if (errno != EBUSY)
-    {
-      tst_brkm (TFAIL, cleanup, "Expected EBUSY here, exit: %s",
-		strerror (errno));
+      close (audio2);
     }
   for (rate = 0; rate < sizeof (rates) / sizeof (int); rate++)
     for (k = 0; k < sizeof (sblut) / sizeof (struct sb); k++)
@@ -187,15 +185,11 @@ recordingtest (void)
 		strerror (errno));
     }
   audio2 = open ("/dev/dsp", O_RDONLY);
+  tst_resm (TINFO, "Second open /dev/dsp R %s",
+	    audio2 >= 0 ? "WORKS" : "DOESN'T WORK");
   if (audio2 >= 0)
     {
-      tst_brkm (TFAIL, cleanup,
-		"Second open /dev/dsp R succeeded, but is expected to fail");
-    }
-  if (errno != EBUSY)
-    {
-      tst_brkm (TFAIL, cleanup, "Expected EBUSY here, exit: %s",
-		strerror (errno));
+      close (audio2);
     }
   for (rate = 0; rate < sizeof (rates) / sizeof (int); rate++)
     for (k = 0; k < sizeof (sblut) / sizeof (struct sb); k++)
@@ -582,7 +576,7 @@ sinegenw (int freq, int samprate, short 
   incr = M_PI * 2.0 * (double) freq / (double) samprate;
   while (len-- > 0)
     {
-      *value = (short) floor (0.5 + 32766.5 * sin (phase));
+      *value = (short) floor (0.5 + 6553 * sin (phase));
       value += stride;
       phase += incr;
     }
@@ -597,7 +591,7 @@ sinegenb (int freq, int samprate, unsign
   incr = M_PI * 2.0 * (double) freq / (double) samprate;
   while (len-- > 0)
     {
-      *value = (unsigned char) floor (128.5 + 126.5 * sin (phase));
+      *value = (unsigned char) floor (128.5 + 26 * sin (phase));
       value += stride;
       phase += incr;
     }
@@ -667,3 +661,98 @@ void
 cleanup (void)
 {
 }
+
+void dup_test (void)
+{
+  int audio, fd, n;
+  int bits1, bits2;
+  int size = sizeof (wavfile_okay);
+  int header = 44;
+  const char *okay = wavfile_okay + header;
+  audio = open ("/dev/dsp", O_WRONLY);
+  if (audio < 0)
+    {
+      tst_brkm (TFAIL, cleanup, "Error open /dev/dsp W: %s",
+		strerror (errno));
+    }
+  /* write header once to set parameters correctly */
+  n = write (audio, wavfile_okay, header);
+  if (n != header)
+    {
+      tst_brkm (TFAIL, cleanup, "Wrote %d, expected %d; exit", n, header);
+    }
+  size = size - header;
+  /* dup / close */
+  for (fd = audio+1; fd <= audio+5; fd++)
+    if (dup2 (fd-1, fd) != -1)
+      {
+	if (fd-2 >= audio)
+	  if (close (fd-2) < 0)
+	    {
+	      tst_brkm (TFAIL, cleanup, "Close audio: %s", strerror (errno));
+	    }
+	if ((n = write (fd, okay, size)) < 0)
+	  {
+	    tst_brkm (TFAIL, cleanup, "write: %s", strerror (errno));
+	  }
+	if (n != size)
+	  {
+	    tst_brkm (TFAIL, cleanup, "Wrote %d, expected %d; exit", n, size);
+	  }
+      }
+    else
+      tst_brkm (TFAIL, cleanup, "dup: %s", strerror (errno));
+
+  for (fd = audio+4; fd <= audio+5; fd++)
+    if (close (fd) < 0)
+      {
+	tst_brkm (TFAIL, cleanup, "Close audio: %s", strerror (errno));
+      }
+  tst_resm (TPASS, "Write to duped fd");
+
+  audio = open ("/dev/dsp", O_WRONLY);
+  if (audio < 0)
+    {
+      tst_brkm (TFAIL, cleanup, "Error open /dev/dsp W: %s",
+		strerror (errno));
+    }
+  fd = audio + 1;
+  if (dup2 (audio, fd) == -1)
+    {
+      tst_brkm (TFAIL, cleanup, "dup: %s", strerror (errno));
+    }
+  bits1 = AFMT_U8;
+  if (ioctl (audio, SNDCTL_DSP_SAMPLESIZE, &bits1) < 0)
+    {
+      tst_brkm (TFAIL, cleanup, "ioctl: %s", strerror (errno));
+    }
+  bits1 = AFMT_S16_LE;
+  if (ioctl (fd, SNDCTL_DSP_SAMPLESIZE, &bits1) < 0)
+    {
+      tst_brkm (TFAIL, cleanup, "ioctl: %s", strerror (errno));
+    }
+  bits1 = AFMT_QUERY;
+  if (ioctl (audio, SNDCTL_DSP_SAMPLESIZE, &bits1) < 0)
+    {
+      tst_brkm (TFAIL, cleanup, "ioctl: %s", strerror (errno));
+    }
+  bits2 = AFMT_QUERY;
+  if (ioctl (fd, SNDCTL_DSP_SAMPLESIZE, &bits2) < 0)
+    {
+      tst_brkm (TFAIL, cleanup, "ioctl: %s", strerror (errno));
+    }
+  if (bits1 != AFMT_S16_LE || bits2 != AFMT_S16_LE)
+    {
+      tst_brkm (TFAIL, cleanup, "Inconsistent state of duped fd: %d %d %d",
+		AFMT_S16_LE,bits1,bits2);
+    }
+  if (close (audio) < 0)
+    {
+      tst_brkm (TFAIL, cleanup, "Close audio: %s", strerror (errno));
+    }
+  if (close (fd) < 0)
+    {
+      tst_brkm (TFAIL, cleanup, "Close audio: %s", strerror (errno));
+    }
+  tst_resm (TPASS, "Parameter change to duped fd");
+}
