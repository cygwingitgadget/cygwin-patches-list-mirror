Return-Path: <cygwin-patches-return-4899-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9112 invoked by alias); 17 Aug 2004 03:13:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9099 invoked from network); 17 Aug 2004 03:13:56 -0000
Message-Id: <3.0.5.32.20040816230955.0080fb30@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Tue, 17 Aug 2004 03:13:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch] Update for the testsuite, devdsp 
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1092726595==_"
X-SW-Source: 2004-q3/txt/msg00051.txt.bz2

--=====================_1092726595==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 656

This patch is a merge of what Gerd sent on July 17 and of
my changes to match the improved capability of the driver.

This is the first time I run the testsuite, and it was on WinME. 
There were more failures than I expected, e.g. in mmap. I don't
know how this compares to NT.

Pierre


2004-08-17 Gerd Spalink <Gerd.Spalink@t-online.de>
	    Pierre Humblet <Pierre.Humblet@ieee.org>

	* devdsp.c: Outputs the names of the main test functions.
	(forkrectest): Expect child success.
	(forkplaytest): Ditto.
	(syncwithchild): Output the child status and the desired value.
	(sinegenw): Reduce volume of the beep.
	(sinegenb): Ditto.
	(dup_test): New test.


--=====================_1092726595==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="devdsp.diff"
Content-length: 9481

Index: devdsp.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/devdsp.c,v
retrieving revision 1.3
diff -u -p -r1.3 devdsp.c
--- devdsp.c	13 Apr 2004 09:40:03 -0000	1.3
+++ devdsp.c	17 Aug 2004 00:38:51 -0000
@@ -29,6 +29,9 @@ details. */
 #include <errno.h>
 #include "test.h" /* use libltp framework */

+/* Controls if a child can open the device after the parent */
+#define CHILD_EXPECT 0 /* 0 or 1 */
+
 static const char wavfile_okay[] =3D
   {
 #include "devdsp_okay.h" /* a sound sample */
@@ -36,7 +39,7 @@ static const char wavfile_okay[] =3D

 /* Globals required by libltp */
 const char *TCID =3D "devdsp";   /* set test case identifier */
-int TST_TOTAL =3D 35;
+int TST_TOTAL =3D 37;

 /* Prototypes */
 void sinegen (void *wave, int rate, int bits, int len, int stride);
@@ -57,6 +60,7 @@ void abortplaytest (void);
 void playwavtest (void);
 void syncwithchild (pid_t pid, int expected_exit_status);
 void cleanup (void);
+void dup_test (void);

 static int expect_child_failure =3D 0;

@@ -83,6 +87,7 @@ main (int argc, char *argv[])
   forkrectest ();
   abortplaytest ();
   playwavtest ();
+  dup_test ();
   tst_exit ();
   /* NOTREACHED */
   return 0;
@@ -96,6 +101,7 @@ ioctltest (void)
   int ioctl_par;
   int channels;

+  tst_resm (TINFO, "Running %s", __FUNCTION__);
   audio1 =3D open ("/dev/dsp", O_WRONLY);
   if (audio1 < 0)
     {
@@ -143,6 +149,7 @@ playbacktest (void)
   int audio1, audio2;
   int rate, k;

+  tst_resm (TINFO, "Running %s", __FUNCTION__);
   audio1 =3D open ("/dev/dsp", O_WRONLY);
   if (audio1 < 0)
     {
@@ -155,7 +162,7 @@ playbacktest (void)
       tst_brkm (TFAIL, cleanup,
 		"Second open /dev/dsp W succeeded, but is expected to fail");
     }
-  if (errno !=3D EBUSY)
+  else if (errno !=3D EBUSY)
     {
       tst_brkm (TFAIL, cleanup, "Expected EBUSY here, exit: %s",
 		strerror (errno));
@@ -179,7 +186,9 @@ recordingtest (void)
 {
   int audio1, audio2;
   int rate, k;
+
   /* test read / record */
+  tst_resm (TINFO, "Running %s", __FUNCTION__);
   audio1 =3D open ("/dev/dsp", O_RDONLY);
   if (audio1 < 0)
     {
@@ -192,7 +201,7 @@ recordingtest (void)
       tst_brkm (TFAIL, cleanup,
 		"Second open /dev/dsp R succeeded, but is expected to fail");
     }
-  if (errno !=3D EBUSY)
+  else if (errno !=3D EBUSY)
     {
       tst_brkm (TFAIL, cleanup, "Expected EBUSY here, exit: %s",
 		strerror (errno));
@@ -216,6 +225,7 @@ monitortest (void)
 {
   int fd;

+  tst_resm (TINFO, "Running %s", __FUNCTION__);
   fd =3D open ("/dev/dsp", O_RDWR);
   if (fd < 0)
     {
@@ -235,6 +245,7 @@ forkrectest (void)
   int pid;
   int fd;

+  tst_resm (TINFO, "Running %s", __FUNCTION__);
   fd =3D open ("/dev/dsp", O_RDONLY);
   if (fd < 0)
     {
@@ -274,15 +285,16 @@ forkrectest (void)
   if (pid)
     {
       tst_resm (TINFO, "forked, child PID=3D%d", pid);
-      syncwithchild (pid, TFAIL);	/* expecting error exit */
+      syncwithchild (pid, CHILD_EXPECT?TFAIL:0);   /* expecting error exit=
 */
       tst_resm (TINFO, "parent records again ..");
       rectest (fd, 22050, 1, 16);
       tst_resm (TINFO, "parent done");
     }
   else
     {				/* child */
-      expect_child_failure =3D 1;
-      tst_resm (TINFO, "child trying to record (should fail)..");
+      expect_child_failure =3D CHILD_EXPECT;
+      tst_resm (TINFO, "child trying to record %s",
+		CHILD_EXPECT?"(should fail)..":"");
       rectest (fd, 44100, 1, 16);
       /* NOTREACHED */
       tst_resm (TINFO, "child done");
@@ -293,7 +305,7 @@ forkrectest (void)
     {
       tst_brkm (TFAIL, cleanup, "Close audio: %s", strerror (errno));
     }
-  tst_resm (TPASS, "child cannot record if parent is already recording");
+  tst_resm (TPASS, "child tries to record while parent is already recordin=
g");
 }

 void
@@ -302,6 +314,7 @@ forkplaytest (void)
   int pid;
   int fd;

+  tst_resm (TINFO, "Running %s", __FUNCTION__);
   fd =3D open ("/dev/dsp", O_WRONLY);
   if (fd < 0)
     {
@@ -341,15 +354,16 @@ forkplaytest (void)
   if (pid)
     {
       tst_resm (TINFO, "forked, child PID=3D%d", pid);
-      syncwithchild (pid, TFAIL);	/* expected failure */
+      syncwithchild (pid, CHILD_EXPECT?TFAIL:0);  /* expected failure */
       tst_resm (TINFO, "parent plays again..");
       playtest (fd, 22050, 0, 8);
       tst_resm (TINFO, "parent done");
     }
   else
     {				/* child */
-      expect_child_failure =3D 1;
-      tst_resm (TINFO, "child trying to play (should fail)..");
+      expect_child_failure =3D CHILD_EXPECT;
+      tst_resm (TINFO, "child trying to play %s",
+		CHILD_EXPECT?"(should fail)..":"");
       playtest (fd, 44100, 1, 16);
       /* NOTREACHED */
       tst_resm (TINFO, "child done");
@@ -360,7 +374,7 @@ forkplaytest (void)
     {
       tst_brkm (TFAIL, cleanup, "Close audio: %s", strerror (errno));
     }
-  tst_resm (TPASS, "child cannot play if parent is already playing");
+  tst_resm (TPASS, "child tries to play while parent is already playing");
 }

 void
@@ -552,7 +566,8 @@ syncwithchild (pid_t pid, int expected_e
     }
   if (WEXITSTATUS (status) !=3D expected_exit_status)
     {
-      tst_brkm (TBROK, cleanup, "Child had exit status !=3D 0");
+      tst_brkm (TFAIL, cleanup, "Child had exit status %d !=3D %d",
+		WEXITSTATUS (status), expected_exit_status);
     }
 }

@@ -582,7 +597,7 @@ sinegenw (int freq, int samprate, short
   incr =3D M_PI * 2.0 * (double) freq / (double) samprate;
   while (len-- > 0)
     {
-      *value =3D (short) floor (0.5 + 32766.5 * sin (phase));
+      *value =3D (short) floor (0.5 + 6553 * sin (phase));
       value +=3D stride;
       phase +=3D incr;
     }
@@ -597,7 +612,7 @@ sinegenb (int freq, int samprate, unsign
   incr =3D M_PI * 2.0 * (double) freq / (double) samprate;
   while (len-- > 0)
     {
-      *value =3D (unsigned char) floor (128.5 + 126.5 * sin (phase));
+      *value =3D (unsigned char) floor (128.5 + 26 * sin (phase));
       value +=3D stride;
       phase +=3D incr;
     }
@@ -611,6 +626,7 @@ abortplaytest (void)
   int n;
   int ioctl_par =3D 0;

+  tst_resm (TINFO, "Running %s", __FUNCTION__);
   audio =3D open ("/dev/dsp", O_WRONLY);
   if (audio < 0)
     {
@@ -642,6 +658,8 @@ playwavtest (void)
   int audio;
   int size =3D sizeof (wavfile_okay);
   int n;
+
+  tst_resm (TINFO, "Running %s", __FUNCTION__);
   audio =3D open ("/dev/dsp", O_WRONLY);
   if (audio < 0)
     {
@@ -663,6 +681,102 @@ playwavtest (void)
   tst_resm (TPASS, "Set parameters from wave file header");
 }

+void dup_test (void)
+{
+  int audio, fd, n;
+  int bits1, bits2;
+  int size =3D sizeof (wavfile_okay);
+  int header =3D 44;
+  const char *okay =3D wavfile_okay + header;
+
+  tst_resm (TINFO, "Running %s", __FUNCTION__);
+  audio =3D open ("/dev/dsp", O_WRONLY);
+  if (audio < 0)
+    {
+      tst_brkm (TFAIL, cleanup, "Error open /dev/dsp W: %s",
+		strerror (errno));
+    }
+  /* write header once to set parameters correctly */
+  n =3D write (audio, wavfile_okay, header);
+  if (n !=3D header)
+    {
+      tst_brkm (TFAIL, cleanup, "Wrote %d, expected %d; exit", n, header);
+    }
+  size =3D size - header;
+  /* dup / close */
+  for (fd =3D audio+1; fd <=3D audio+5; fd++)
+    if (dup2 (fd-1, fd) !=3D -1)
+      {
+	if (fd-2 >=3D audio)
+	  if (close (fd-2) < 0)
+	    {
+	      tst_brkm (TFAIL, cleanup, "Close audio: %s", strerror (errno));
+	    }
+	if ((n =3D write (fd, okay, size)) < 0)
+	  {
+	    tst_brkm (TFAIL, cleanup, "write: %s", strerror (errno));
+	  }
+	if (n !=3D size)
+	  {
+	    tst_brkm (TFAIL, cleanup, "Wrote %d, expected %d; exit", n, size);
+	  }
+      }
+    else
+      tst_brkm (TFAIL, cleanup, "dup: %s", strerror (errno));
+
+  for (fd =3D audio+4; fd <=3D audio+5; fd++)
+    if (close (fd) < 0)
+      {
+	tst_brkm (TFAIL, cleanup, "Close audio: %s", strerror (errno));
+      }
+  tst_resm (TPASS, "Write to duped fd");
+
+  audio =3D open ("/dev/dsp", O_WRONLY);
+  if (audio < 0)
+    {
+      tst_brkm (TFAIL, cleanup, "Error open /dev/dsp W: %s",
+		strerror (errno));
+    }
+  fd =3D audio + 1;
+  if (dup2 (audio, fd) =3D=3D -1)
+    {
+      tst_brkm (TFAIL, cleanup, "dup: %s", strerror (errno));
+    }
+  bits1 =3D AFMT_U8;
+  if (ioctl (audio, SNDCTL_DSP_SAMPLESIZE, &bits1) < 0)
+    {
+      tst_brkm (TFAIL, cleanup, "ioctl: %s", strerror (errno));
+    }
+  bits1 =3D AFMT_S16_LE;
+  if (ioctl (fd, SNDCTL_DSP_SAMPLESIZE, &bits1) < 0)
+    {
+      tst_brkm (TFAIL, cleanup, "ioctl: %s", strerror (errno));
+    }
+  bits1 =3D AFMT_QUERY;
+  if (ioctl (audio, SNDCTL_DSP_SAMPLESIZE, &bits1) < 0)
+    {
+      tst_brkm (TFAIL, cleanup, "ioctl: %s", strerror (errno));
+    }
+  bits2 =3D AFMT_QUERY;
+  if (ioctl (fd, SNDCTL_DSP_SAMPLESIZE, &bits2) < 0)
+    {
+      tst_brkm (TFAIL, cleanup, "ioctl: %s", strerror (errno));
+    }
+  if (bits1 !=3D AFMT_S16_LE || bits2 !=3D AFMT_S16_LE)
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
 void
 cleanup (void)
 {

--=====================_1092726595==_--
