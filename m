Return-Path: <cygwin-patches-return-4722-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 308 invoked by alias); 6 May 2004 23:08:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32766 invoked from network); 6 May 2004 23:08:31 -0000
Message-ID: <01C433CF.C9723B10.Gerd.Spalink@t-online.de>
From: Gerd.Spalink@t-online.de (Gerd Spalink)
Reply-To: "Gerd.Spalink@t-online.de" <Gerd.Spalink@t-online.de>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: Patch for /dev/dsp to make audio play interruptible by Ctrl-C
Date: Thu, 06 May 2004 23:08:00 -0000
Organization: privat
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: E4xP8qZJQeIwk6qoDXI0m6UoVo7jZa-t2r53ZT6nBftltPicOlEVQI
X-SW-Source: 2004-q2/txt/msg00074.txt.bz2

Hello,

This patch makes /dev/dsp respond to exceptions without delay,
even if audio has been buffered and is currently playing.

Thank you, cgf, for the hint to use exit_state.

Can you make it go into the upcoming release 1.5.10?

Gerd


ChangeLog:

2004-05-07  Gerd Spalink  <Gerd.Spalink@t-online.de>
	* fhandler_dsp.cc (fhandler_dev_dsp::Audio_out::stop):
	Move delete of bigwavebuffer_ so that it is always cleaned,
	also in child processes.
	(fhandler_dev_dsp::Audio_in::stop): ditto
	(fhandler_dev_dsp::close): Stop audio play immediately
	in case of abnormal exit.



Index: fhandler_dsp.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_dsp.cc,v
retrieving revision 1.35
diff -u -p -r1.35 fhandler_dsp.cc
--- fhandler_dsp.cc     13 Apr 2004 09:38:32 -0000      1.35
+++ fhandler_dsp.cc     6 May 2004 22:55:34 -0000
@@ -457,12 +457,12 @@ fhandler_dev_dsp::Audio_out::stop (bool
       debug_printf ("waveOutClose rc=%d", rc);

       clearOwner ();
+    }

-      if (bigwavebuffer_)
-       {
-         delete[] bigwavebuffer_;
-         bigwavebuffer_ = NULL;
-       }
+  if (bigwavebuffer_)
+    {
+      delete[] bigwavebuffer_;
+      bigwavebuffer_ = NULL;
     }
 }

@@ -859,12 +859,12 @@ fhandler_dev_dsp::Audio_in::stop ()
       debug_printf ("waveInClose rc=%d", rc);

       clearOwner ();
+    }

-      if (bigwavebuffer_)
-       {
-         delete[] bigwavebuffer_;
-         bigwavebuffer_ = NULL;
-       }
+  if (bigwavebuffer_)
+    {
+      delete[] bigwavebuffer_;
+      bigwavebuffer_ = NULL;
     }
 }

@@ -1207,6 +1207,11 @@ fhandler_dev_dsp::close (void)
     }
   if (audio_out_)
     {
+      if (exit_state != ES_NOT_EXITING)
+       { // emergency close due to call to exit() or Ctrl-C:
+         // do not wait for all pending audio to be played
+         audio_out_->stop (true);
+       }
       delete audio_out_;
       audio_out_ = NULL;
     }
