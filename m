Return-Path: <cygwin-patches-return-4203-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5114 invoked by alias); 11 Sep 2003 04:30:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5103 invoked from network); 11 Sep 2003 04:30:20 -0000
Message-ID: <20030911042913.19539.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From: "peter garrone" <pgarrone@linuxmail.org>
To: cygwin-patches@cygwin.com
Date: Thu, 11 Sep 2003 15:23:00 -0000
Subject: setfragment patch for sound device
X-Originating-Ip: 192.10.200.223
X-Originating-Server: ws5-2.us4.outblaze.com
X-SW-Source: 2003-q3/txt/msg00221.txt.bz2


 The following patch to the /dev/dsp sound device does the following:
 
 - implements SNDCTL_DSP_SETFRAGMENT, allowing smaller sound buffers to be used.
 - trivially implements SNDCTL_DSP_CHANNELS.
 - opens and closes the class device upon SNDCTL_DSP_RESET.
 - Uses win32 event to signal buffer output completion, instead of only a delay
 
 I have only tested my own proprietary application. It compiled and ran without change, so,
 of course, has to be buggy.

--- tmp/fhandler_dsp.cc	2003-09-11 08:32:15.796875000 +1000
+++ src/winsup/cygwin/fhandler_dsp.cc	2003-09-11 12:43:23.437500000 +1000
@@ -44,10 +44,13 @@
   bool write (const void *pSampleData, int nBytes);
   int blocks ();
   void callback_sampledone (void *pData);
   void setformat (int format) {formattype_ = format;}
   int numbytesoutput ();
+  void setfragment(int arg);
+  inline int get_fragment_size(void){ return fragment_size;}
+  inline int get_fragment_count(void){ return fragment_count;}
 
   void *operator new (size_t, void *p) {return p;}
 
 private:
   char *initialisebuffer ();
@@ -61,10 +64,14 @@
   int bufferIndex_;
   CRITICAL_SECTION lock_;
   char *freeblocks_[MAX_BLOCKS];
   int formattype_;
 
+  int fragment_size;
+  int fragment_count;
+  HANDLE callback_sync;
+
   char bigwavebuffer_[MAX_BLOCKS * TOT_BLOCK_SIZE];
 };
 
 static char audio_buf[sizeof (class Audio)];
 
@@ -72,17 +79,21 @@
 {
   InitializeCriticalSection (&lock_);
   memset (bigwavebuffer_, 0, sizeof (bigwavebuffer_));
   for (int i = 0; i < MAX_BLOCKS; i++)
     freeblocks_[i] =  &bigwavebuffer_[i * TOT_BLOCK_SIZE];
+  fragment_size = BLOCK_SIZE;
+  fragment_count = MAX_BLOCKS;
+  callback_sync = CreateEvent(NULL, FALSE, FALSE, NULL);
 }
 
 Audio::~Audio ()
 {
   if (dev_)
     close ();
   DeleteCriticalSection (&lock_);
+  CloseHandle(callback_sync);
 }
 
 bool
 Audio::open (int rate, int bits, int channels, bool bCallback)
 {
@@ -186,30 +197,30 @@
   LeaveCriticalSection (&lock_);
 
   if (pHeader)
     {
       memset (pHeader, 0, sizeof (WAVEHDR));
-      pHeader->dwBufferLength = BLOCK_SIZE;
+      pHeader->dwBufferLength = fragment_size;
       pHeader->lpData = (LPSTR) (&pHeader[1]);
       return (char *) pHeader->lpData;
     }
   return 0L;
 }
 
 bool
 Audio::write (const void *pSampleData, int nBytes)
 {
   // split up big blocks into smaller BLOCK_SIZE chunks
-  while (nBytes > BLOCK_SIZE)
+  while (nBytes > fragment_size)
     {
-      write (pSampleData, BLOCK_SIZE);
-      nBytes -= BLOCK_SIZE;
-      pSampleData = (void *) ((char *) pSampleData + BLOCK_SIZE);
+      write (pSampleData, fragment_size);
+      nBytes -= fragment_size;
+      pSampleData = (void *) ((char *) pSampleData + fragment_size);
     }
 
   // Block till next sound is flushed
-  if (blocks () == MAX_BLOCKS)
+  if (blocks () == fragment_count)
     waitforcallback ();
 
   // Allocate new wave buffer if necessary
   if (buffer_ == 0L)
     {
@@ -218,20 +229,21 @@
 	return false;
     }
 
 
   // Handle gathering blocks into larger buffer
-  int sizeleft = BLOCK_SIZE - bufferIndex_;
+  int sizeleft = fragment_size - bufferIndex_;
   if (nBytes < sizeleft)
     {
       memcpy (&buffer_[bufferIndex_], pSampleData, nBytes);
       bufferIndex_ += nBytes;
       nBytesWritten_ += nBytes;
       return true;
     }
 
   // flushing when we reach our limit of BLOCK_SIZE
+  // (now fragment_size not BLOCK_SIZE)
   memcpy (&buffer_[bufferIndex_], pSampleData, sizeleft);
   bufferIndex_ += sizeleft;
   nBytesWritten_ += sizeleft;
   flush ();
 
@@ -270,21 +282,22 @@
 	freeblocks_[i] = (char *) pData;
 	break;
       }
 
   LeaveCriticalSection (&lock_);
+  SetEvent(callback_sync);
 }
 
 void
 Audio::waitforcallback ()
 {
   int n = blocks ();
   if (!n)
     return;
   do
     {
-      Sleep (250);
+      WaitForSingleObject(callback_sync, 250);
     }
   while (n == blocks ());
 }
 
 bool
@@ -329,10 +342,41 @@
       LeaveCriticalSection (&lock_);
     }
   return false;
 }
 
+void
+Audio::setfragment(int arg)
+{
+  /*
+   * Information here is derived from 4front technologies
+   * Open Sound System Programming Guide version 1.11
+   */
+  int max_log_size = 0;
+  int count = (arg>>16)&0x0ffff;
+  int log_size = (arg)&0x0ffff;
+
+  int n = BLOCK_SIZE;
+  while((n&1)==0)
+  {
+    n >>= 1;
+    max_log_size++;
+  }
+
+  if(log_size == 0)log_size = max_log_size;
+  else if(log_size < 8)log_size = 8;
+  else if(log_size > max_log_size)log_size = max_log_size;
+
+  fragment_size = 1 << log_size;
+
+  if(count == 0)count = MAX_BLOCKS;
+  else if(count < 2)count = 2;
+  else if(count > MAX_BLOCKS)count = MAX_BLOCKS;
+
+  fragment_count = count;
+}
+
 //------------------------------------------------------------------------
 // Call back routine
 static void CALLBACK
 wave_callback (HWAVE hWave, UINT msg, DWORD instance, DWORD param1,
 	       DWORD param2)
@@ -519,18 +563,21 @@
   switch (cmd)
     {
 #define CASE(a) case a : debug_printf("/dev/dsp: ioctl %s", #a);
 
       CASE (SNDCTL_DSP_RESET)
+	s_audio->close ();
 	audioformat_ = AFMT_S8;
 	audiofreq_ = 8000;
 	audiobits_ = 8;
 	audiochannels_ = 1;
+	s_audio->setfragment(0xffffffff);
+	s_audio->open (audiofreq_, audiobits_, audiochannels_);
 	return 0;
 
       CASE (SNDCTL_DSP_GETBLKSIZE)
-	*intptr = Audio::BLOCK_SIZE;
+	*intptr = s_audio->get_fragment_size();
 	return 0;
 
       CASE (SNDCTL_DSP_SETFMT)
       {
 	int nBits = 0;
@@ -571,12 +618,14 @@
 	    return -1;
 	  }
 	break;
 
       CASE (SNDCTL_DSP_STEREO)
+      CASE (SNDCTL_DSP_CHANNELS)
       {
-	int nChannels = *intptr + 1;
+	int nChannels = *intptr;
+	if(cmd == SNDCTL_DSP_STEREO)nChannels++;
 
 	s_audio->close ();
 	if (s_audio->open (audiofreq_, audiobits_, nChannels) == true)
 	  {
 	    audiochannels_ = nChannels;
@@ -593,20 +642,20 @@
       CASE (SNDCTL_DSP_GETOSPACE)
       {
 	audio_buf_info *p = (audio_buf_info *) ptr;
 
 	int nBlocks = s_audio->blocks ();
-	int leftblocks = ((Audio::MAX_BLOCKS - nBlocks) - 1);
+	int leftblocks = ((s_audio->get_fragment_count() - nBlocks) - 1);
 	if (leftblocks < 0)
 	  leftblocks = 0;
 	if (leftblocks > 1)
 	  leftblocks = 1;
-	int left = leftblocks * Audio::BLOCK_SIZE;
+	int left = leftblocks * s_audio->get_fragment_size();
 
 	p->fragments = leftblocks;
-	p->fragstotal = Audio::MAX_BLOCKS;
-	p->fragsize = Audio::BLOCK_SIZE;
+	p->fragstotal = s_audio->get_fragment_count();
+	p->fragsize = s_audio->get_fragment_size();
 	p->bytes = left;
 
 	debug_printf ("ptr %p nblocks %d leftblocks %d left bytes %d ",
 		      ptr, nBlocks, leftblocks, left);
 
@@ -614,12 +663,13 @@
       }
       break;
 
       CASE (SNDCTL_DSP_SETFRAGMENT)
       {
-	// Fake!! esound & mikmod require this on non PowerPC platforms.
-	//
+	s_audio->close ();
+	s_audio->setfragment(*intptr);
+	s_audio->open (audiofreq_, audiobits_, audiochannels_);
 	return 0;
       }
       break;
 
       CASE (SNDCTL_DSP_GETFMTS)

-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
