Return-Path: <cygwin-patches-return-4862-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14287 invoked by alias); 18 Jul 2004 16:11:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14244 invoked from network); 18 Jul 2004 16:11:47 -0000
Message-ID: <01C46CF2.ACDB11A0.Gerd.Spalink@t-online.de>
From: Gerd.Spalink@t-online.de (Gerd Spalink)
Reply-To: "Gerd.Spalink@t-online.de" <Gerd.Spalink@t-online.de>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: Fix dup for /dev/dsp
Date: Sun, 18 Jul 2004 16:11:00 -0000
Organization: privat
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ID: G0bkZ8Z1rePUdQBD8E-BPbN72eEEZ-Q-7JHn6tI5sMZOjV2yUnMhgx
X-SW-Source: 2004-q3/txt/msg00014.txt.bz2

What I did:

The static open_count is no longer needed because now we consistently
use the return status from the windows API to decide if we can open or not.
This change is not related to dup.

Wave header parsing needed a small fix. It was a +/-1 problem.

To fix all cases of dup, a dup_chain is maintained to keep all duped instances
consistent. I did not understand how to apply archetypes for this problem,
and this solution works (test suite contribution is in separate patch).


ChangeLog:

2004-07-18 Gerd Spalink <Gerd.Spalink@t-online.de>

	* fhandler.h (class fhandler_dev_dsp): Remove static open_count,
	add members to keep track of duped instances.
	* fhandler_dsp.cc (fhandler_dev_dsp::Audio_out::parsewav): Compare
	with <= end for the case that only the header is passed to write.
	(fhandler_dev_dsp::fhandler_dev_dsp): Initialize new members
	dup_chain_next and dup_chain_prev.
	(fhandler_dev_dsp::open): Remove open_count; instead of query use
	start/stop to get wave device status from win32.
	(fhandler_dev_dsp::write): Insert call to update_duped.
	(fhandler_dev_dsp::close): Check dup_chain before stop of audio
	device.
	(fhandler_dev_dsp::dup): Create dup_chain linked list. Copy members
	by calling dup_cpy.
	(fhandler_dev_dsp::dup_cpy): New.
	(fhandler_dev_dsp::update_duped): New.
	(fhandler_dev_dsp::ioctl): Replace all inline return statements by
	setting variable rc. At the end, reflect any changes in duped instances
	by calling update_duped ().

Patch:

Index: fhandler.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.210
diff -u -p -r1.210 fhandler.h
--- fhandler.h	15 Jul 2004 14:56:05 -0000	1.210
+++ fhandler.h	18 Jul 2004 15:50:52 -0000
@@ -1069,9 +1069,12 @@ class fhandler_dev_dsp: public fhandler_
   int audiofreq_;
   int audiobits_;
   int audiochannels_;
-  static int open_count; // per process
   Audio_out *audio_out_;
   Audio_in  *audio_in_;
+  fhandler_dev_dsp *dup_chain_next;
+  fhandler_dev_dsp *dup_chain_prev;
+  void dup_cpy (fhandler_dev_dsp *to);
+  void update_duped ();
  public:
   fhandler_dev_dsp ();
   ~fhandler_dev_dsp();
Index: fhandler_dsp.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_dsp.cc,v
retrieving revision 1.37
diff -u -p -r1.37 fhandler_dsp.cc
--- fhandler_dsp.cc	28 May 2004 19:50:05 -0000	1.37
+++ fhandler_dsp.cc	18 Jul 2004 15:50:54 -0000
@@ -701,7 +701,7 @@ fhandler_dev_dsp::Audio_out::parsewav (c
   len -= 12;
   pDat = pData + 12;
   skip = 12;
-  while ((len > 0) && (pDat + sizeof (wavchunk) < end))
+  while ((len > 0) && (pDat + sizeof (wavchunk) <= end))
     { /* We recognize two kinds of wavchunk:
 	 "fmt " for the PCM parameters (only PCM supported here)
 	 "data" for the start of PCM data */
@@ -1025,8 +1025,7 @@ waveIn_callback (HWAVEIN hWave, UINT msg
 /* ------------------------------------------------------------------------
    /dev/dsp handler
    ------------------------------------------------------------------------
-   instances of the handler statics */
-int fhandler_dev_dsp::open_count = 0;
+ */
 
 fhandler_dev_dsp::fhandler_dev_dsp ():
   fhandler_base ()
@@ -1034,6 +1033,8 @@ fhandler_dev_dsp::fhandler_dev_dsp ():
   debug_printf ("0x%08x", (int)this);
   audio_in_ = NULL;
   audio_out_ = NULL;
+  dup_chain_next = NULL;
+  dup_chain_prev = NULL;
 }
 
 fhandler_dev_dsp::~fhandler_dev_dsp ()
@@ -1045,12 +1046,6 @@ fhandler_dev_dsp::~fhandler_dev_dsp ()
 int
 fhandler_dev_dsp::open (int flags, mode_t mode)
 {
-  open_count++;
-  if (open_count > 1)
-    {
-      set_errno (EBUSY);
-      return 0;
-    }
   set_flags ((flags & ~O_TEXT) | O_BINARY);
   // Work out initial sample format & frequency, /dev/dsp defaults
   audioformat_ = AFMT_U8;
@@ -1061,33 +1056,36 @@ fhandler_dev_dsp::open (int flags, mode_
     {
     case O_WRONLY:
       audio_out_ = new Audio_out;
-      if (!audio_out_->query (audiofreq_, audiobits_, audiochannels_))
+      if (!audio_out_->start (audiofreq_, audiobits_, audiochannels_))
 	{
 	  delete audio_out_;
 	  audio_out_ = NULL;
 	}
+      audio_out_->stop (true);
       break;
     case O_RDONLY:
       audio_in_ = new Audio_in;
-      if (!audio_in_->query (audiofreq_, audiobits_, audiochannels_))
+      if (!audio_in_->start (audiofreq_, audiobits_, audiochannels_))
 	{
 	  delete audio_in_;
 	  audio_in_ = NULL;
 	}
+      audio_in_->stop ();
       break;
     case O_RDWR:
       audio_out_ = new Audio_out;
-      if (audio_out_->query (audiofreq_, audiobits_, audiochannels_))
+      if (audio_out_->start (audiofreq_, audiobits_, audiochannels_))
 	{
 	  audio_in_ = new Audio_in;
-	  if (!audio_in_->query (audiofreq_, audiobits_, audiochannels_))
+	  if (!audio_in_->start (audiofreq_, audiobits_, audiochannels_))
 	    {
 	      delete audio_in_;
 	      audio_in_ = NULL;
-	      audio_out_->stop ();
 	      delete audio_out_;
 	      audio_out_ = NULL;
 	    }
+	  audio_in_->stop ();
+	  audio_out_->stop (true);
 	}
       else
 	{
@@ -1117,13 +1115,6 @@ fhandler_dev_dsp::open (int flags, mode_
   return rc;
 }
 
-#define RETURN_ERROR_WHEN_BUSY(audio)\
-  if ((audio)->denyAccess ())    \
-    {\
-      set_errno (EBUSY);\
-      return -1;\
-    }
-
 int
 fhandler_dev_dsp::write (const void *ptr, size_t len)
 {
@@ -1136,7 +1127,11 @@ fhandler_dev_dsp::write (const void *ptr
       set_errno (EACCES); // device was opened for read?
       return -1;
     }
-  RETURN_ERROR_WHEN_BUSY (audio_out_);
+  if (audio_out_->denyAccess ())
+    {
+      set_errno (EBUSY);
+      return -1;
+    }
   if (audio_out_->getOwner () == 0L)
     { // No owner yet, lets do it
       // check for wave file & get parameters & skip header if possible.
@@ -1146,6 +1141,7 @@ fhandler_dev_dsp::write (const void *ptr
 	  debug_printf ("=> ptr_s=%08x len_s=%d", ptr_s, len_s);
 	  audioformat_ = ((audiobits_ == 8) ? AFMT_U8 : AFMT_S16_LE);
 	  audio_out_->setformat (audioformat_);
+	  update_duped ();
 	}
       // Open audio device properly with callbacks.
       if (!audio_out_->start (audiofreq_, audiobits_, audiochannels_))
@@ -1200,44 +1196,93 @@ fhandler_dev_dsp::close (void)
 {
   debug_printf ("audio_in=%08x audio_out=%08x",
 		(int)audio_in_, (int)audio_out_);
-  if (audio_in_)
+  
+  if (dup_chain_next || dup_chain_prev)
     {
-      delete audio_in_;
-      audio_in_ = NULL;
+      debug_printf ("removing 0x%08x from dup chain", (int)this);
+      if (dup_chain_next)
+	{
+	  dup_chain_next->dup_chain_prev = dup_chain_prev;
+	}
+      if (dup_chain_prev)
+	{
+	  dup_chain_prev->dup_chain_next = dup_chain_next;
+	}
     }
-  if (audio_out_)
+  else // last instance to be closed
     {
-      if (exit_state != ES_NOT_EXITING)
-       { // emergency close due to call to exit() or Ctrl-C:
-	 // do not wait for all pending audio to be played
-	 audio_out_->stop (true);
-       }
-      delete audio_out_;
-      audio_out_ = NULL;
+      if (audio_in_)
+	{
+	  delete audio_in_;
+	  audio_in_ = NULL;
+	}
+      if (audio_out_)
+	{
+	  if (exit_state != ES_NOT_EXITING)
+	    { // emergency close due to call to exit() or Ctrl-C:
+	      // do not wait for all pending audio to be played
+	      audio_out_->stop (true);
+	    }
+	  delete audio_out_;
+	  audio_out_ = NULL;
+	}
     }
-  if (open_count > 0)
-    open_count--;
   return 0;
 }
 
 int
 fhandler_dev_dsp::dup (fhandler_base * child)
 {
-  debug_printf ("");
+  debug_printf ("old=0x%08x new=0x%08x", (int)this, (int)child);
   fhandler_dev_dsp *fhc = (fhandler_dev_dsp *) child;
 
   fhc->set_flags (get_flags ());
-  fhc->audiochannels_ = audiochannels_;
-  fhc->audiobits_ = audiobits_;
-  fhc->audiofreq_ = audiofreq_;
-  fhc->audioformat_ = audioformat_;
+  // insert new instance into list of duped copies
+  if (dup_chain_next)
+    {
+      dup_chain_next->dup_chain_prev = fhc;
+    }
+  fhc->dup_chain_next = dup_chain_next;
+  dup_chain_next = fhc;
+  fhc->dup_chain_prev = this;
+  update_duped ();
   return 0;
 }
 
+void
+fhandler_dev_dsp::dup_cpy (fhandler_dev_dsp *to)
+{
+  to->audioformat_ = audioformat_;
+  to->audiofreq_ = audiofreq_;
+  to->audiobits_ = audiobits_;
+  to->audiochannels_ = audiochannels_;
+  to->audio_out_ = audio_out_;
+  to->audio_in_ = audio_in_;
+}
+
+void
+fhandler_dev_dsp::update_duped (void)
+{
+  fhandler_dev_dsp* fhp;
+  fhp = dup_chain_next;
+  while (fhp)
+    {
+      dup_cpy (fhp);
+      fhp = fhp->dup_chain_next;
+    }
+  fhp = dup_chain_prev;
+  while (fhp)
+    {
+      dup_cpy (fhp);
+      fhp = fhp->dup_chain_prev;
+    }
+}
+
 int
 fhandler_dev_dsp::ioctl (unsigned int cmd, void *ptr)
 {
   int *intptr = (int *) ptr;
+  int rc = 0;
   debug_printf ("audio_in=%08x audio_out=%08x",
 		(int)audio_in_, (int)audio_out_);
   switch (cmd)
@@ -1247,15 +1292,18 @@ fhandler_dev_dsp::ioctl (unsigned int cm
       CASE (SNDCTL_DSP_RESET)
 	if (audio_out_)
 	  {
-	    RETURN_ERROR_WHEN_BUSY (audio_out_);
-	    audio_out_->stop (true);
+	    if (audio_out_->denyAccess ())
+	      rc = EBUSY;
+	    else
+	      audio_out_->stop (true);
 	  }
 	if (audio_in_)
 	  {
-	    RETURN_ERROR_WHEN_BUSY (audio_in_);
-	    audio_in_->stop ();
+	    if (audio_in_->denyAccess ())
+	      rc = EBUSY;
+	    else
+	      audio_in_->stop ();
 	  }
-	return 0;
 	break;
 
       CASE (SNDCTL_DSP_GETBLKSIZE)
@@ -1271,17 +1319,15 @@ fhandler_dev_dsp::ioctl (unsigned int cm
 					    audiobits_,
 					    audiochannels_);
 	  }
-	return 0;
 	break;
 
       CASE (SNDCTL_DSP_SETFMT)
       {
-	int nBits;
+	int nBits = 0;
 	switch (*intptr)
 	  {
 	  case AFMT_QUERY:
 	    *intptr = audioformat_;
-	    return 0;
 	    break;
 	  case AFMT_U16_BE:
 	  case AFMT_U16_LE:
@@ -1293,42 +1339,47 @@ fhandler_dev_dsp::ioctl (unsigned int cm
 	  case AFMT_S8:
 	    nBits = 8;
 	    break;
-	  default:
-	    nBits = 0;
 	  }
 	if (nBits && audio_out_)
 	  {
-	    RETURN_ERROR_WHEN_BUSY (audio_out_);
-	    audio_out_->stop ();
-	    audio_out_->setformat (*intptr);
-	    if (audio_out_->query (audiofreq_, nBits, audiochannels_))
-	      {
-		audiobits_ = nBits;
-		audioformat_ = *intptr;
-	      }
+	    if (audio_out_->denyAccess ())
+	      rc =  EBUSY;
 	    else
 	      {
-		*intptr = audiobits_;
-		return -1;
+		audio_out_->stop ();
+		audio_out_->setformat (*intptr);
+		if (audio_out_->query (audiofreq_, nBits, audiochannels_))
+		  {
+		    audiobits_ = nBits;
+		    audioformat_ = *intptr;
+		  }
+		else
+		  {
+		    *intptr = audiobits_;
+		    rc = EINVAL;
+		  }
 	      }
 	  }
 	if (nBits && audio_in_)
 	  {
-	    RETURN_ERROR_WHEN_BUSY (audio_in_);
-	    audio_in_->stop ();
-	    audio_in_->setformat (*intptr);
-	    if (audio_in_->query (audiofreq_, nBits, audiochannels_))
-	      {
-		audiobits_ = nBits;
-		audioformat_ = *intptr;
-	      }
+	    if (audio_in_->denyAccess ())
+	      rc = EBUSY;
 	    else
 	      {
-		*intptr = audiobits_;
-		return -1;
+		audio_in_->stop ();
+		audio_in_->setformat (*intptr);
+		if (audio_in_->query (audiofreq_, nBits, audiochannels_))
+		  {
+		    audiobits_ = nBits;
+		    audioformat_ = *intptr;
+		  }
+		else
+		  {
+		    *intptr = audiobits_;
+		    rc = EINVAL;
+		  }
 	      }
 	  }
-	return 0;
       }
       break;
 
@@ -1336,29 +1387,36 @@ fhandler_dev_dsp::ioctl (unsigned int cm
       {
 	if (audio_out_)
 	  {
-	    RETURN_ERROR_WHEN_BUSY (audio_out_);
-	    audio_out_->stop ();
-	    if (audio_out_->query (*intptr, audiobits_, audiochannels_))
-	      audiofreq_ = *intptr;
+	    if (audio_out_->denyAccess ())
+	      rc = EBUSY;
 	    else
 	      {
-		*intptr = audiofreq_;
-		return -1;
+		audio_out_->stop ();
+		if (audio_out_->query (*intptr, audiobits_, audiochannels_))
+		  audiofreq_ = *intptr;
+		else
+		  {
+		    *intptr = audiofreq_;
+		    rc = EINVAL;
+		  }
 	      }
 	  }
 	if (audio_in_)
 	  {
-	    RETURN_ERROR_WHEN_BUSY (audio_in_);
-	    audio_in_->stop ();
-	    if (audio_in_->query (*intptr, audiobits_, audiochannels_))
-	      audiofreq_ = *intptr;
+	    if (audio_in_->denyAccess ())
+	      rc = EBUSY;
 	    else
 	      {
-		*intptr = audiofreq_;
-		return -1;
+		audio_in_->stop ();
+		if (audio_in_->query (*intptr, audiobits_, audiochannels_))
+		  audiofreq_ = *intptr;
+		else
+		  {
+		    *intptr = audiofreq_;
+		    rc = EINVAL;
+		  }
 	      }
 	  }
-	return 0;
       }
       break;
 
@@ -1368,29 +1426,36 @@ fhandler_dev_dsp::ioctl (unsigned int cm
 
 	if (audio_out_)
 	  {
-	    RETURN_ERROR_WHEN_BUSY (audio_out_);
-	    audio_out_->stop ();
-	    if (audio_out_->query (audiofreq_, audiobits_, nChannels))
-	      audiochannels_ = nChannels;
+	    if (audio_out_->denyAccess ())
+	      rc = EBUSY;
 	    else
 	      {
-		*intptr = audiochannels_ - 1;
-		return -1;
+		audio_out_->stop ();
+		if (audio_out_->query (audiofreq_, audiobits_, nChannels))
+		  audiochannels_ = nChannels;
+		else
+		  {
+		    *intptr = audiochannels_ - 1;
+		    rc = EINVAL;
+		  }
 	      }
 	  }
 	if (audio_in_)
 	  {
-	    RETURN_ERROR_WHEN_BUSY (audio_in_);
-	    audio_in_->stop ();
-	    if (audio_in_->query (audiofreq_, audiobits_, nChannels))
-	      audiochannels_ = nChannels;
+	    if (audio_in_->denyAccess ())
+	      rc = EBUSY;
 	    else
 	      {
-		*intptr = audiochannels_ - 1;
-		return -1;
+		audio_in_->stop ();
+		if (audio_in_->query (audiofreq_, audiobits_, nChannels))
+		  audiochannels_ = nChannels;
+		else
+		  {
+		    *intptr = audiochannels_ - 1;
+		    rc = EINVAL;
+		  }
 	      }
 	  }
-	return 0;
       }
       break;
 
@@ -1400,29 +1465,36 @@ fhandler_dev_dsp::ioctl (unsigned int cm
 
 	if (audio_out_)
 	  {
-	    RETURN_ERROR_WHEN_BUSY (audio_out_);
-	    audio_out_->stop ();
-	    if (audio_out_->query (audiofreq_, audiobits_, nChannels))
-	      audiochannels_ = nChannels;
+	    if (audio_out_->denyAccess ())
+	      rc = EBUSY;
 	    else
 	      {
-		*intptr = audiochannels_;
-		return -1;
+		audio_out_->stop ();
+		if (audio_out_->query (audiofreq_, audiobits_, nChannels))
+		  audiochannels_ = nChannels;
+		else
+		  {
+		    *intptr = audiochannels_;
+		    rc = EINVAL;
+		  }
 	      }
 	  }
 	if (audio_in_)
 	  {
-	    RETURN_ERROR_WHEN_BUSY (audio_in_);
-	    audio_in_->stop ();
-	    if (audio_in_->query (audiofreq_, audiobits_, nChannels))
-	      audiochannels_ = nChannels;
+	    if (audio_in_->denyAccess ())
+	      rc = EBUSY;
 	    else
 	      {
-		*intptr = audiochannels_;
-		return -1;
+		audio_in_->stop ();
+		if (audio_in_->query (audiofreq_, audiobits_, nChannels))
+		  audiochannels_ = nChannels;
+		else
+		  {
+		    *intptr = audiochannels_;
+		    rc = EINVAL;
+		  }
 	      }
 	  }
-	return 0;
       }
       break;
 
@@ -1431,12 +1503,16 @@ fhandler_dev_dsp::ioctl (unsigned int cm
 	audio_buf_info *p = (audio_buf_info *) ptr;
 	if (audio_out_)
 	  {
-	    RETURN_ERROR_WHEN_BUSY (audio_out_);
-	    audio_out_->buf_info (p, audiofreq_, audiobits_, audiochannels_);
-	    debug_printf ("ptr=%p frags=%d fragsize=%d bytes=%d",
-			  ptr, p->fragments, p->fragsize, p->bytes);
+	    if (audio_out_->denyAccess ())
+	      rc = EBUSY;
+	    else
+	      {
+		audio_out_->buf_info (p, audiofreq_,
+				      audiobits_, audiochannels_);
+		debug_printf ("ptr=%p frags=%d fragsize=%d bytes=%d",
+			      ptr, p->fragments, p->fragsize, p->bytes);
+	      }
 	  }
-	return 0;
       }
       break;
 
@@ -1445,34 +1521,34 @@ fhandler_dev_dsp::ioctl (unsigned int cm
 	audio_buf_info *p = (audio_buf_info *) ptr;
 	if (audio_in_)
 	  {
-	    RETURN_ERROR_WHEN_BUSY (audio_in_);
-	    audio_in_->buf_info (p, audiofreq_, audiobits_, audiochannels_);
-	    debug_printf ("ptr=%p frags=%d fragsize=%d bytes=%d",
-			  ptr, p->fragments, p->fragsize, p->bytes);
+	    if (audio_in_->denyAccess ())
+	      rc = EBUSY;
+	    else
+	      {
+		audio_in_->buf_info (p, audiofreq_,
+				     audiobits_, audiochannels_);
+		debug_printf ("ptr=%p frags=%d fragsize=%d bytes=%d",
+			      ptr, p->fragments, p->fragsize, p->bytes);
+	      }
 	  }
-	return 0;
       }
       break;
 
       CASE (SNDCTL_DSP_SETFRAGMENT)
       {
 	// Fake!! esound & mikmod require this on non PowerPC platforms.
-	//
-	return 0;
       }
       break;
 
       CASE (SNDCTL_DSP_GETFMTS)
       {
 	*intptr = AFMT_S16_LE | AFMT_U8; // only native formats returned here
-	return 0;
       }
       break;
 
       CASE (SNDCTL_DSP_GETCAPS)
       {
 	*intptr = DSP_CAP_BATCH | DSP_CAP_DUPLEX;
-	return 0;
       }
       break;
 
@@ -1480,29 +1556,36 @@ fhandler_dev_dsp::ioctl (unsigned int cm
       CASE (SNDCTL_DSP_SYNC)
       {
 	if (audio_out_)
-	  {
-	    // Stop audio out device
-	    RETURN_ERROR_WHEN_BUSY (audio_out_);
-	    audio_out_->stop ();
+	  { // Stop audio out device
+	    if (audio_out_->denyAccess ())
+	      rc = EBUSY;
+	    else
+	      audio_out_->stop ();
 	  }
 	if (audio_in_)
-	  {
-	    // Stop audio in device
-	    RETURN_ERROR_WHEN_BUSY (audio_in_);
-	    audio_in_->stop ();
+	  { // Stop audio in device
+	    if (audio_in_->denyAccess ())
+	      rc = EBUSY;
+	    else
+	      audio_in_->stop ();
 	  }
-	return 0;
       }
       break;
 
     default:
       debug_printf ("/dev/dsp: ioctl 0x%08x not handled yet! FIXME:", cmd);
+      rc = EINVAL;
       break;
 
 #undef CASE
-    };
-  set_errno (EINVAL);
-  return -1;
+    }
+  if (rc != 0)
+    {
+      set_errno (rc);
+      rc = -1;
+    }
+  update_duped ();
+  return rc;
 }
 
 void
