Return-Path: <cygwin-patches-return-4612-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10022 invoked by alias); 21 Mar 2004 21:55:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10011 invoked from network); 21 Mar 2004 21:55:49 -0000
Message-ID: <01C40F97.A1C224B0.Gerd.Spalink@t-online.de>
From: Gerd.Spalink@t-online.de (Gerd Spalink)
Reply-To: "Gerd.Spalink@t-online.de" <Gerd.Spalink@t-online.de>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Patch 20040321 for audio recording with /dev/dsp (indented)
Date: Sun, 21 Mar 2004 21:55:00 -0000
Organization: privat
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: TJ71DQZaoeiU9ly5HqbBjkesWxuBWOxG5pSqFDFsKeFG1V+rWpCscW
X-SW-Source: 2004-q1/txt/msg00102.txt.bz2

Below you can find the plain text ChangeLog entry and patch,
formatted as suggested by Corinna. I also updated some comments.
Hope it makes it into the repository this time...

There were no comments about the test program I sent. Do you want to
put it or something like it into the repository?

Gerd

===snip================================================================

2004-02-07  Gerd Spalink  <Gerd.Spalink@t-online.de>

	* autoload.cc: Load eight more functions for waveIn support.

	* fhandler.h (class fhandler_dev_dsp): Add class Audio,
	class Audio_in and class Audio_out members and 
	audio_in_, audio_out_ pointers so that future changes
	are restricted to file fhandler_dsp.cc.
	
	* fhandler_dsp.cc (fhandler_dev_dsp::Audio): Add this class
	to treat things common to audio recording and playback.
	Add more format conversions.
	(fhandler_dev_dsp::Audio::queue): New queues for buffer management
	to fix incomplete cleanup of buffers passed to the wave device.
	(fhandler_dev_dsp::Audio_in): New, added class
	to implement audio recording.
	(fhandler_dev_dsp::Audio_out): Rework to use
	functionality provided by fhandler_dev_dsp::Audio.
	Allocate memory audio buffers late, just before write.
	(fhandler_dev_dsp::Audio_out::start): Size of wave buffer
	allocated here depends on audio rate/bits/channels.
	(fhandler_dev_dsp::Audio_in::start): Ditto.
	(fhandler_dev_dsp::setupwav): Replaced by following function.
	(fhandler_dev_dsp::Audio_out::parsewav):
	Does not setup wave device any more. Discard wave header properly.
	(fhandler_dev_dsp::open): Add O_RDONLY and_RDWR as legal modes.
	Protect against re-open. Activate fork_fixup.
	(fhandler_dev_dsp::ioctl): Protect against actions when
	audio is active.
	SNDCTL_DSP_GETFMTS only returns formats supported by
	mmsystem wave API, not all supported formats.
	SNDCTL_DSP_GETBLKSIZE result now depends on current audio format.
	(fhandler_dev_dsp::fixup_after_fork):
	Call fork_fixup for the Audio classes to let them duplicate
	the CRITICAL_SECTION.

===snip===============================================================

Index: autoload.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/autoload.cc,v
retrieving revision 1.77
diff -u -p -r1.77 autoload.cc
--- autoload.cc	9 Feb 2004 04:04:22 -0000	1.77
+++ autoload.cc	21 Mar 2004 21:37:16 -0000
@@ -530,6 +530,15 @@ LoadDLLfuncEx (timeGetTime, 0, winmm, 1)
 LoadDLLfuncEx (timeBeginPeriod, 4, winmm, 1)
 LoadDLLfuncEx (timeEndPeriod, 4, winmm, 1)
 
+LoadDLLfuncEx (waveInGetNumDevs, 0, winmm, 1)
+LoadDLLfuncEx (waveInOpen, 24, winmm, 1)
+LoadDLLfuncEx (waveInUnprepareHeader, 12, winmm, 1)
+LoadDLLfuncEx (waveInPrepareHeader, 12, winmm, 1)
+LoadDLLfuncEx (waveInAddBuffer, 12, winmm, 1)
+LoadDLLfuncEx (waveInStart, 4, winmm, 1)
+LoadDLLfuncEx (waveInReset, 4, winmm, 1)
+LoadDLLfuncEx (waveInClose, 4, winmm, 1)
+
 LoadDLLfuncEx (UuidCreate, 4, rpcrt4, 1)
 LoadDLLfuncEx (UuidCreateSequential, 4, rpcrt4, 1)
 }
Index: cygheap.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygheap.cc,v
retrieving revision 1.98
diff -u -p -r1.98 cygheap.cc
--- cygheap.cc	21 Mar 2004 17:41:40 -0000	1.98
+++ cygheap.cc	21 Mar 2004 21:37:16 -0000
@@ -52,7 +52,7 @@ static void
 init_cheap ()
 {
 #ifndef DEBUGGING
-  alloc_sz = CYGHEAPSIZE;
+  DWORD initial_sz = alloc_sz = CYGHEAPSIZE;
 #else
   char buf[80];
   DWORD initial_sz = 0;
Index: fhandler.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.190
diff -u -p -r1.190 fhandler.h
--- fhandler.h	21 Mar 2004 17:41:40 -0000	1.190
+++ fhandler.h	21 Mar 2004 21:37:18 -0000
@@ -1105,14 +1105,20 @@ class fhandler_windows: public fhandler_
   bool is_slow () {return 1;}
 };
 
-class fhandler_dev_dsp : public fhandler_base
+class fhandler_dev_dsp: public fhandler_base
 {
+ public:
+  class Audio;
+  class Audio_out;
+  class Audio_in;
  private:
   int audioformat_;
   int audiofreq_;
   int audiobits_;
   int audiochannels_;
-  bool setupwav(const char *pData, int nBytes);
+  static int open_count; // per process
+  Audio_out *audio_out_;
+  Audio_in  *audio_in_;
  public:
   fhandler_dev_dsp ();
   ~fhandler_dev_dsp();
@@ -1125,6 +1131,7 @@ class fhandler_dev_dsp : public fhandler
   int close (void);
   int dup (fhandler_base *child);
   void dump (void);
+  void fixup_after_fork (HANDLE parent);
   void fixup_after_exec ();
 };
 
Index: fhandler_dsp.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_dsp.cc,v
retrieving revision 1.30
diff -u -p -r1.30 fhandler_dsp.cc
--- fhandler_dsp.cc	9 Feb 2004 04:04:22 -0000	1.30
+++ fhandler_dsp.cc	21 Mar 2004 21:37:20 -0000
@@ -3,6 +3,8 @@
    Copyright 2001, 2002, 2003, 2004 Red Hat, Inc
 
    Written by Andy Younger (andy@snoogie.demon.co.uk)
+   Extended by Gerd Spalink (Gerd.Spalink@t-online.de)
+     to support recording from the audio input
 
 This file is part of Cygwin.
 
@@ -20,314 +22,624 @@ details. */
 #include "path.h"
 #include "fhandler.h"
 
-//------------------------------------------------------------------------
-// Simple encapsulation of the win32 audio device.
-//
-static void CALLBACK wave_callback (HWAVE hWave, UINT msg, DWORD instance,
-				    DWORD param1, DWORD param2);
-class Audio
+/*------------------------------------------------------------------------
+  Simple encapsulation of the win32 audio device.
+
+  Implementation Notes
+  1. Audio buffers are created dynamically just before the first read or
+     write to /dev/dsp. The actual buffer size is determined at that time,
+     such that one buffer holds about 125ms of audio data.
+     At the time of this writing, 12 buffers are allocated,
+     so that up to 1.5 seconds can be buffered within Win32.
+     The buffer size can be queried with the ioctl SNDCTL_DSP_GETBLKSIZE,
+     but for this implementation only returns meaningful results if
+     sampling rate, number of channels and number of bits per sample
+     are not changed afterwards.
+
+  2. Every open call creates a new instance of the handler. To cope
+     with the fact that only a single wave device exists, the static
+     variable open_count tracks opens for one process. After a
+     successful open, every subsequent open from the same process
+     to the device fails with EBUSY.
+     If different processes open the audio device simultaneously,
+     the results are unpredictable - usually the first one wins.
+    
+  3. The wave device is reserved within a process from the time that
+     the first read or write call has been successful until /dev/dsp
+     has been closed by that process. During this reservation period
+     child processes that use the same file descriptor cannot
+     do read, write or ioctls that change the device properties.
+     This means that a parent can open the device, do some ioctl,
+     spawn children, and any one of them can do the data read/write
+ */
+
+class fhandler_dev_dsp::Audio
+{ // This class contains functionality common to Audio_in and Audio_out
+ public:
+   Audio ();
+  ~Audio ();
+
+  class queue;
+
+  bool denyAccess ();
+  void fork_fixup (HANDLE parent);
+  inline DWORD getOwner () { return owner_; }
+  void setOwner () { owner_ = GetCurrentProcessId(); }
+  inline void clearOwner () { owner_ = 0L; }
+  void setformat (int format);
+  void convert_none (unsigned char *buffer, int size_bytes) { }
+  void convert_U8_S8 (unsigned char *buffer, int size_bytes);
+  void convert_S16LE_U16LE (unsigned char *buffer, int size_bytes);
+  void convert_S16LE_U16BE (unsigned char *buffer, int size_bytes);
+  void convert_S16LE_S16BE (unsigned char *buffer, int size_bytes);
+  void fillFormat (WAVEFORMATEX * format,
+		   int rate, int bits, int channels);
+  unsigned blockSize (int rate, int bits, int channels);
+
+  void (fhandler_dev_dsp::Audio::*convert_)
+    (unsigned char *buffer, int size_bytes);
+  inline void lock () { EnterCriticalSection (&lock_); }
+  inline void unlock () { LeaveCriticalSection (&lock_); }
+ private:
+  DWORD owner_; /* Process ID when wave operation started, else 0 */
+  CRITICAL_SECTION lock_;
+};
+
+class fhandler_dev_dsp::Audio::queue
+{ // non-blocking fixed size queues for buffer management
+ public:
+   queue (int depth = 4);
+  ~queue ();
+
+  bool send (WAVEHDR *);  // queue an item, returns true if successful
+  bool recv (WAVEHDR **); // retrieve an item, returns true if successful
+  int query ();           // return number of items queued
+
+ private:
+  int head_;
+  int tail_;
+  int depth_, depth1_;
+  WAVEHDR **storage_;
+};
+
+static void CALLBACK waveOut_callback (HWAVEOUT hWave, UINT msg, DWORD instance,
+				       DWORD param1, DWORD param2);
+
+class fhandler_dev_dsp::Audio_out: public Audio
+{
+ public:
+   Audio_out ();
+  ~Audio_out ();
+
+  bool query (int rate, int bits, int channels);
+  bool start (int rate, int bits, int channels);
+  void stop ();
+  bool write (const char *pSampleData, int nBytes);
+  void buf_info (audio_buf_info *p, int rate, int bits, int channels);
+  void callback_sampledone (WAVEHDR *pHdr);
+  bool parsewav (const char *&pData, int &nBytes,
+		 int &rate, int &bits, int &channels);
+
+ private:
+  void init (unsigned blockSize);
+  void waitforallsent ();
+  void waitforspace ();
+  bool sendcurrent ();
+  int emptyblocks ();
+
+  enum { MAX_BLOCKS = 12 };
+  queue *Qapp2app_;  // empty and unprepared blocks
+  HWAVEOUT dev_;     // The wave device
+  int bufferIndex_;  // offset into pHdr_->lpData
+  WAVEHDR *pHdr_;    // data to be filled by write  
+  WAVEHDR wavehdr_[MAX_BLOCKS];
+  char *bigwavebuffer_; // audio samples only
+
+  // Member variables below must be locked
+  queue *Qisr2app_; // empty blocks passed from wave callback
+};
+
+static void CALLBACK waveIn_callback (HWAVEIN hWave, UINT msg, DWORD instance,
+				      DWORD param1, DWORD param2);
+
+class fhandler_dev_dsp::Audio_in: public Audio
 {
 public:
-  enum
-  {
-    MAX_BLOCKS = 12,
-    BLOCK_SIZE = 16384,
-    TOT_BLOCK_SIZE = BLOCK_SIZE + sizeof (WAVEHDR)
-   };
-
-    Audio ();
-   ~Audio ();
-
-  bool open (int rate, int bits, int channels, bool bCallback = false);
-  void close ();
-  int getvolume ();
-  void setvolume (int newVolume);
-  bool write (const void *pSampleData, int nBytes);
-  int blocks ();
-  void callback_sampledone (void *pData);
-  void setformat (int format) {formattype_ = format;}
-  int numbytesoutput ();
+   Audio_in ();
+  ~Audio_in ();
 
-  void *operator new (size_t, void *p) {return p;}
+  bool query (int rate, int bits, int channels);
+  bool start (int rate, int bits, int channels);
+  void stop ();
+  bool read (char *pSampleData, int &nBytes);
+  void callback_blockfull (WAVEHDR *pHdr);
 
 private:
-  char *initialisebuffer ();
-  void waitforcallback ();
-  bool flush ();
-
-  HWAVEOUT dev_;
-  volatile int nBlocksInQue_;
-  int nBytesWritten_;
-  char *buffer_;
-  int bufferIndex_;
-  CRITICAL_SECTION lock_;
-  char *freeblocks_[MAX_BLOCKS];
-  int formattype_;
+  bool init (unsigned blockSize);
+  bool queueblock (WAVEHDR *pHdr);
+  void waitfordata (); // blocks until we have a good pHdr_
+
+  enum { MAX_BLOCKS = 12 }; // read ahead of 1.5 seconds
+  queue *Qapp2app_;    // filled and unprepared blocks
+  HWAVEIN dev_;
+  int bufferIndex_;    // offset into pHdr_->lpData
+  WAVEHDR *pHdr_;      // successfully recorded data
+  WAVEHDR wavehdr_[MAX_BLOCKS];
+  char *bigwavebuffer_; // audio samples
 
-  char bigwavebuffer_[MAX_BLOCKS * TOT_BLOCK_SIZE];
+  // Member variables below must be locked
+  queue *Qisr2app_; // filled blocks passed from wave callback
 };
 
-static char audio_buf[sizeof (class Audio)];
+/* --------------------------------------------------------------------
+   Implementation */
+
+// Simple fixed length FIFO queue implementation for audio buffer management
+fhandler_dev_dsp::Audio::queue::queue (int depth)
+{
+  head_ = 0;
+  tail_ = 0;
+  depth_ = depth;
+  depth1_ = depth + 1;
+  // allow space for one extra object in the queue
+  // so we can distinguish full and empty status
+  storage_ = new WAVEHDR *[depth1_];
+}
+
+fhandler_dev_dsp::Audio::queue::~queue ()
+{
+  delete[] storage_;
+}
 
-Audio::Audio ()
+bool
+fhandler_dev_dsp::Audio::queue::send (WAVEHDR *x)
+{
+  if (query () == depth_)
+    return false;
+  storage_[tail_] = x;
+  tail_++;
+  if (tail_ == depth1_)
+    tail_ = 0;
+  return true;
+}
+
+bool
+fhandler_dev_dsp::Audio::queue::recv (WAVEHDR **x)
+{
+  if (query () == 0)
+    return false;
+  *x = storage_[head_];
+  head_++;
+  if (head_ == depth1_)
+    head_ = 0;
+  return true;
+}
+
+int
+fhandler_dev_dsp::Audio::queue::query ()
+{
+  int n = tail_ - head_;
+  if (n < 0)
+    n += depth1_;
+  return n;
+}
+
+// Audio class implements functionality need for both read and write
+fhandler_dev_dsp::Audio::Audio ()
 {
   InitializeCriticalSection (&lock_);
-  memset (bigwavebuffer_, 0, sizeof (bigwavebuffer_));
-  for (int i = 0; i < MAX_BLOCKS; i++)
-    freeblocks_[i] =  &bigwavebuffer_[i * TOT_BLOCK_SIZE];
+  convert_ = &fhandler_dev_dsp::Audio::convert_none;
+  owner_ = 0L;
 }
 
-Audio::~Audio ()
+fhandler_dev_dsp::Audio::~Audio ()
 {
-  if (dev_)
-    close ();
   DeleteCriticalSection (&lock_);
 }
 
-bool
-Audio::open (int rate, int bits, int channels, bool bCallback)
+void
+fhandler_dev_dsp::Audio::fork_fixup (HANDLE parent)
 {
-  WAVEFORMATEX format;
-  int nDevices = waveOutGetNumDevs ();
+  debug_printf ("parent=0x%08x", parent);
+  InitializeCriticalSection (&lock_);
+}
 
-  nBytesWritten_ = 0L;
-  bufferIndex_ = 0;
-  buffer_ = 0L;
-  debug_printf ("number devices %d", nDevices);
-  if (nDevices <= 0)
+bool
+fhandler_dev_dsp::Audio::denyAccess ()
+{
+  if (owner_ == 0L)
     return false;
+  return (GetCurrentProcessId () != owner_);
+}
 
-  debug_printf ("trying to map device freq %d, bits %d, "
-		"channels %d, callback %d", rate, bits, channels,
-		bCallback);
-
-  int bytesperSample = bits / 8;
-
-  memset (&format, 0, sizeof (format));
-  format.wFormatTag = WAVE_FORMAT_PCM;
-  format.wBitsPerSample = bits;
-  format.nChannels = channels;
-  format.nSamplesPerSec = rate;
-  format.nAvgBytesPerSec = format.nSamplesPerSec * format.nChannels *
-    bytesperSample;
-  format.nBlockAlign = format.nChannels * bytesperSample;
-
-  nBlocksInQue_ = 0;
-  HRESULT res = waveOutOpen (&dev_, WAVE_MAPPER, &format, (DWORD) wave_callback,
-			     (DWORD) this, bCallback ? CALLBACK_FUNCTION : 0);
-  if (res == S_OK)
+void
+fhandler_dev_dsp::Audio::setformat (int format)
+{
+  switch (format)
     {
-      debug_printf ("Sucessfully opened!");
-      return true;
+    case AFMT_S8:
+      convert_ = &fhandler_dev_dsp::Audio::convert_U8_S8;
+      debug_printf ("U8_S8");
+      break;
+    case AFMT_U16_LE:
+      convert_ = &fhandler_dev_dsp::Audio::convert_S16LE_U16LE;
+      debug_printf ("S16LE_U16LE");
+      break;
+    case AFMT_U16_BE:
+      convert_ = &fhandler_dev_dsp::Audio::convert_S16LE_U16BE;
+      debug_printf ("S16LE_U16BE");
+      break;
+    case AFMT_S16_BE:
+      convert_ = &fhandler_dev_dsp::Audio::convert_S16LE_S16BE;
+      debug_printf ("S16LE_S16BE");
+      break;
+    default:
+      convert_ = &fhandler_dev_dsp::Audio::convert_none;
+      debug_printf ("none");
     }
-  else
+}
+
+void
+fhandler_dev_dsp::Audio::convert_U8_S8 (unsigned char *buffer,
+					int size_bytes)
+{
+  while (size_bytes-- > 0)
     {
-      debug_printf ("failed to open");
-      return false;
+      *buffer ^= (unsigned char)0x80;
+      buffer++;
     }
 }
 
 void
-Audio::close ()
+fhandler_dev_dsp::Audio::convert_S16LE_U16BE (unsigned char *buffer,
+					      int size_bytes)
 {
-  if (dev_)
+  int size_samples = size_bytes / 2;
+  unsigned char hi, lo;
+  while (size_samples-- > 0)
     {
-      flush ();			// force out last block whatever size..
+      hi = buffer[0];
+      lo = buffer[1];
+      *buffer++ = lo;
+      *buffer++ = hi ^ (unsigned char)0x80;
+    }
+}
 
-      while (blocks ())		// block till finished..
-	waitforcallback ();
+void
+fhandler_dev_dsp::Audio::convert_S16LE_U16LE (unsigned char *buffer,
+					      int size_bytes)
+{
+  int size_samples = size_bytes / 2;
+  while (size_samples-- > 0)
+    {
+      buffer++;
+      *buffer ^= (unsigned char)0x80;
+      buffer++;
+    }
+}
 
-      waveOutReset (dev_);
-      waveOutClose (dev_);
-      dev_ = 0L;
+void
+fhandler_dev_dsp::Audio::convert_S16LE_S16BE (unsigned char *buffer,
+					      int size_bytes)
+{
+  int size_samples = size_bytes / 2;
+  unsigned char hi, lo;
+  while (size_samples-- > 0)
+    {
+      hi = buffer[0];
+      lo = buffer[1];
+      *buffer++ = lo;
+      *buffer++ = hi;
     }
-  nBytesWritten_ = 0L;
 }
 
-int
-Audio::numbytesoutput ()
+void
+fhandler_dev_dsp::Audio::fillFormat (WAVEFORMATEX * format,
+				     int rate, int bits, int channels)
 {
-  return nBytesWritten_;
+  memset (format, 0, sizeof (*format));
+  format->wFormatTag = WAVE_FORMAT_PCM;
+  format->wBitsPerSample = bits;
+  format->nChannels = channels;
+  format->nSamplesPerSec = rate;
+  format->nAvgBytesPerSec = format->nSamplesPerSec * format->nChannels
+    * (bits / 8);
+  format->nBlockAlign = format->nChannels * (bits / 8);
 }
 
-int
-Audio::getvolume ()
+// calculate a good block size
+unsigned
+fhandler_dev_dsp::Audio::blockSize (int rate, int bits, int channels)
 {
-  DWORD volume;
+  unsigned blockSize;
+  blockSize = ((bits / 8) * channels * rate) / 8; // approx 125ms per block
+  // round up to multiple of 64
+  blockSize +=  0x3f;
+  blockSize &= ~0x3f; 
+  return blockSize;
+}
 
-  waveOutGetVolume (dev_, &volume);
-  return ((volume >> 16) + (volume & 0xffff)) >> 1;
+//=======================================================================
+fhandler_dev_dsp::Audio_out::Audio_out (): Audio ()
+{
+  bigwavebuffer_ = NULL;
+  Qisr2app_ = new queue(MAX_BLOCKS);
+  Qapp2app_ = new queue(MAX_BLOCKS);
 }
 
-void
-Audio::setvolume (int newVolume)
+fhandler_dev_dsp::Audio_out::~Audio_out ()
+{
+  stop ();
+  delete Qapp2app_;
+  delete Qisr2app_;
+}
+
+bool
+fhandler_dev_dsp::Audio_out::query (int rate, int bits, int channels)
 {
-  waveOutSetVolume (dev_, (newVolume << 16) | newVolume);
+  WAVEFORMATEX format;
+  MMRESULT rc;
+
+  fillFormat (&format, rate, bits, channels);
+  rc = waveOutOpen (NULL, WAVE_MAPPER, &format, 0L, 0L, WAVE_FORMAT_QUERY);
+  debug_printf ("freq=%d bits=%d channels=%d %s", rate, bits, channels,
+		(rc != MMSYSERR_NOERROR) ? "FAIL" : "OK");
+  return (rc == MMSYSERR_NOERROR);
 }
 
-char *
-Audio::initialisebuffer ()
+bool
+fhandler_dev_dsp::Audio_out::start (int rate, int bits, int channels)
 {
-  EnterCriticalSection (&lock_);
-  WAVEHDR *pHeader = 0L;
-  for (int i = 0; i < MAX_BLOCKS; i++)
+  WAVEFORMATEX format;
+  MMRESULT rc;
+  unsigned bSize = blockSize (rate, bits, channels);
+  bigwavebuffer_ = new char[MAX_BLOCKS * bSize];
+  if (bigwavebuffer_ == NULL)
+    return false;
+
+  int nDevices = waveOutGetNumDevs ();
+  debug_printf ("number devices=%d, blocksize=%d", nDevices, bSize);
+  if (nDevices <= 0)
+    return false;
+
+  fillFormat (&format, rate, bits, channels);
+  rc = waveOutOpen (&dev_, WAVE_MAPPER, &format, (DWORD) waveOut_callback,
+		     (DWORD) this, CALLBACK_FUNCTION);
+  if (rc == MMSYSERR_NOERROR)
     {
-      char *pData = freeblocks_[i];
-      if (pData)
+      setOwner ();
+      init (bSize);
+    }
+
+  debug_printf ("freq=%d bits=%d channels=%d %s", rate, bits, channels,
+		(rc != MMSYSERR_NOERROR) ? "FAIL" : "OK");
+  
+  return (rc == MMSYSERR_NOERROR);
+}
+
+void
+fhandler_dev_dsp::Audio_out::stop ()
+{
+  MMRESULT rc;
+  WAVEHDR *pHdr;
+  bool gotblock;
+
+  debug_printf ("dev_=%08x pid=%d owner=%d", (int)dev_,
+		GetCurrentProcessId (), getOwner ());
+  if (getOwner () && !denyAccess ())
+    {
+      sendcurrent ();		// force out last block whatever size..
+      waitforallsent ();        // block till finished..
+
+      rc = waveOutReset (dev_);
+      debug_printf ("waveOutReset rc=%d", rc);
+      do
 	{
-	  pHeader = (WAVEHDR *) pData;
-	  if (pHeader->dwFlags & WHDR_DONE)
+	  lock ();
+	  gotblock = Qisr2app_->recv (&pHdr);
+	  unlock ();
+	  if (gotblock)
 	    {
-	      waveOutUnprepareHeader (dev_, pHeader, sizeof (WAVEHDR));
+	      rc = waveOutUnprepareHeader (dev_, pHdr, sizeof (WAVEHDR));
+	      debug_printf ("waveOutUnprepareHeader Block 0x%08x %s", pHdr,
+			    (rc != MMSYSERR_NOERROR) ? "FAIL" : "OK");
 	    }
-	  freeblocks_[i] = 0L;
-	  break;
+	}
+      while (gotblock);
+      while (Qapp2app_->recv (&pHdr))
+	/* flush queue */;
+
+      rc = waveOutClose (dev_);
+      debug_printf ("waveOutClose rc=%d", rc);
+
+      clearOwner ();
+
+      if (bigwavebuffer_)
+	{
+	  delete[] bigwavebuffer_;
+	  bigwavebuffer_ = NULL;
 	}
     }
-  LeaveCriticalSection (&lock_);
+}
 
-  if (pHeader)
+void
+fhandler_dev_dsp::Audio_out::init (unsigned blockSize)
+{
+  int i;
+
+  // internally queue all of our buffer for later use by write
+  for (i = 0; i < MAX_BLOCKS; i++)
     {
-      memset (pHeader, 0, sizeof (WAVEHDR));
-      pHeader->dwBufferLength = BLOCK_SIZE;
-      pHeader->lpData = (LPSTR) (&pHeader[1]);
-      return (char *) pHeader->lpData;
+      wavehdr_[i].lpData = &bigwavebuffer_[i * blockSize];
+      (int)wavehdr_[i].dwUser = blockSize;
+      if (!Qapp2app_->send (&wavehdr_[i]))
+	{
+	  debug_printf ("Internal Error i=%d", i);
+	  break; // should not happen
+	}
     }
-  return 0L;
+  pHdr_ = NULL;
 }
 
 bool
-Audio::write (const void *pSampleData, int nBytes)
+fhandler_dev_dsp::Audio_out::write (const char *pSampleData, int nBytes)
 {
-  // split up big blocks into smaller BLOCK_SIZE chunks
-  while (nBytes > BLOCK_SIZE)
-    {
-      write (pSampleData, BLOCK_SIZE);
-      nBytes -= BLOCK_SIZE;
-      pSampleData = (void *) ((char *) pSampleData + BLOCK_SIZE);
+  while (nBytes != 0)
+    { // Block if all blocks used until at least one is free
+      waitforspace ();
+
+      int sizeleft = (int)pHdr_->dwUser - bufferIndex_;
+      if (nBytes < sizeleft)
+	{ // all data fits into the current block, with some space left
+	  memcpy (&pHdr_->lpData[bufferIndex_], pSampleData, nBytes);
+	  bufferIndex_ += nBytes;
+	  break;
+	}
+      else
+	{ // data will fill up the current block
+	  memcpy (&pHdr_->lpData[bufferIndex_], pSampleData, sizeleft);
+	  bufferIndex_ += sizeleft;
+	  sendcurrent ();
+	  pSampleData += sizeleft;
+	  nBytes -= sizeleft;
+	}
     }
+  return true;
+}
 
-  // Block till next sound is flushed
-  if (blocks () == MAX_BLOCKS)
-    waitforcallback ();
+// return number of (partially) empty blocks back.
+int
+fhandler_dev_dsp::Audio_out::emptyblocks ()
+{
+  int n;
+  lock ();
+  n = Qisr2app_->query ();
+  unlock ();
+  n += Qapp2app_->query ();
+  if (pHdr_ != NULL)
+    n++;
+  return n;
+}
 
-  // Allocate new wave buffer if necessary
-  if (buffer_ == 0L)
+void
+fhandler_dev_dsp::Audio_out::buf_info (audio_buf_info *p,
+				       int rate, int bits, int channels)
+{
+  p->fragstotal = MAX_BLOCKS;
+  p->fragsize = blockSize (rate, bits, channels);
+  if (getOwner ())
     {
-      buffer_ = initialisebuffer ();
-      if (buffer_ == 0L)
-	return false;
+      p->fragments = emptyblocks ();
+      if (pHdr_ != NULL)
+	p->bytes = p->fragsize - bufferIndex_ +
+	  p->fragsize * (p->fragments - 1);
+      else
+	p->bytes = p->fragsize * p->fragments;
     }
-
-
-  // Handle gathering blocks into larger buffer
-  int sizeleft = BLOCK_SIZE - bufferIndex_;
-  if (nBytes < sizeleft)
+  else
     {
-      memcpy (&buffer_[bufferIndex_], pSampleData, nBytes);
-      bufferIndex_ += nBytes;
-      nBytesWritten_ += nBytes;
-      return true;
+      p->fragments = MAX_BLOCKS;
+      p->bytes = p->fragsize * p->fragments;
     }
-
-  // flushing when we reach our limit of BLOCK_SIZE
-  memcpy (&buffer_[bufferIndex_], pSampleData, sizeleft);
-  bufferIndex_ += sizeleft;
-  nBytesWritten_ += sizeleft;
-  flush ();
-
-  // change pointer to rest of sample, and size accordingly
-  pSampleData = (void *) ((char *) pSampleData + sizeleft);
-  nBytes -= sizeleft;
-
-  // if we still have some sample left over write it out
-  if (nBytes)
-    return write (pSampleData, nBytes);
-
-  return true;
 }
 
-// return number of blocks back.
-int
-Audio::blocks ()
+/* This is called on an interupt so use locking.. Note Qisr2app_
+   is used so we should wrap all references to it in locks. */
+void
+fhandler_dev_dsp::Audio_out::callback_sampledone (WAVEHDR *pHdr)
 {
-  EnterCriticalSection (&lock_);
-  int ret = nBlocksInQue_;
-  LeaveCriticalSection (&lock_);
-  return ret;
+  lock ();
+  Qisr2app_->send (pHdr);
+  unlock ();
 }
 
-// This is called on an interupt so use locking.. Note nBlocksInQue_ is
-// modified by it so we should wrap all references to it in locks.
 void
-Audio::callback_sampledone (void *pData)
+fhandler_dev_dsp::Audio_out::waitforspace ()
 {
-  EnterCriticalSection (&lock_);
-
-  nBlocksInQue_--;
-  for (int i = 0; i < MAX_BLOCKS; i++)
-    if (!freeblocks_[i])
-      {
-	freeblocks_[i] = (char *) pData;
-	break;
-      }
+  WAVEHDR *pHdr;
+  bool gotblock;
+  MMRESULT rc = WAVERR_STILLPLAYING;
 
-  LeaveCriticalSection (&lock_);
+  if (pHdr_ != NULL)
+    return;
+  while (Qapp2app_->recv (&pHdr) == false)
+    {
+      lock ();
+      gotblock = Qisr2app_->recv (&pHdr);
+      unlock ();
+      if (gotblock)
+	{
+	  if ((pHdr->dwFlags & WHDR_DONE) &&
+	      ((rc = waveOutUnprepareHeader (dev_, pHdr, sizeof (WAVEHDR)))
+	       == MMSYSERR_NOERROR))
+	    {
+	      Qapp2app_->send (pHdr);
+	    }
+	  else
+	    {
+	      debug_printf ("error UnprepareHeader 0x%08x, rc=%d, 100ms",
+			    pHdr, rc);
+	      lock ();
+	      Qisr2app_->send (pHdr);
+	      unlock ();
+	      Sleep (100);
+	    }
+	}
+      else
+	{
+	  debug_printf ("100ms");
+	  Sleep (100);
+	}
+    }
+  pHdr_ = pHdr;
+  bufferIndex_ = 0;
 }
 
 void
-Audio::waitforcallback ()
+fhandler_dev_dsp::Audio_out::waitforallsent ()
 {
-  int n = blocks ();
-  if (!n)
-    return;
-  do
+  while (emptyblocks () != MAX_BLOCKS)
     {
-      Sleep (250);
+      debug_printf ("100ms Qisr=%d Qapp=%d",
+		    Qisr2app_->query (), Qapp2app_->query ());
+      Sleep (100);
     }
-  while (n == blocks ());
 }
 
+// send the block described by pHdr_ and bufferIndex_ to wave device
 bool
-Audio::flush ()
+fhandler_dev_dsp::Audio_out::sendcurrent ()
 {
-  if (!buffer_)
+  WAVEHDR *pHdr = pHdr_;
+  if (pHdr_ == NULL)
     return false;
+  pHdr_ = NULL;
 
-  // Send internal buffer out to the soundcard
-  WAVEHDR *pHeader = ((WAVEHDR *) buffer_) - 1;
-  pHeader->dwBufferLength = bufferIndex_;
+  // Sample buffer conversion
+  (this->*convert_) ((unsigned char *)pHdr->lpData, bufferIndex_);
 
-  // Quick bit of sample buffer conversion
-  if (formattype_ == AFMT_S8)
+  // Send internal buffer out to the soundcard
+  pHdr->dwBufferLength = bufferIndex_;
+  pHdr->dwFlags = 0;
+  if (waveOutPrepareHeader (dev_, pHdr, sizeof (WAVEHDR)) == MMSYSERR_NOERROR)
     {
-      unsigned char *p = ((unsigned char *) buffer_);
-      for (int i = 0; i < bufferIndex_; i++)
+      if (waveOutWrite (dev_, pHdr, sizeof (WAVEHDR)) == MMSYSERR_NOERROR)
 	{
-	  p[i] -= 0x7f;
+	  debug_printf ("waveOutWrite bytes=%d", bufferIndex_);
+	  return true;
+	}
+      else
+	{
+	  debug_printf ("waveOutWrite failed");
+	  lock ();
+	  Qisr2app_->send (pHdr);
+	  unlock ();
 	}
-    }
-
-  if (waveOutPrepareHeader (dev_, pHeader, sizeof (WAVEHDR)) == S_OK &&
-      waveOutWrite (dev_, pHeader, sizeof (WAVEHDR)) == S_OK)
-    {
-      EnterCriticalSection (&lock_);
-      nBlocksInQue_++;
-      LeaveCriticalSection (&lock_);
-      bufferIndex_ = 0;
-      buffer_ = 0L;
-      return true;
     }
   else
     {
-      EnterCriticalSection (&lock_);
-      for (int i = 0; i < MAX_BLOCKS; i++)
-	if (!freeblocks_[i])
-	  {
-	    freeblocks_[i] = (char *) pHeader;
-	    break;
-	  }
-      LeaveCriticalSection (&lock_);
+      debug_printf ("waveOutPrepareHeader failed");
+      Qapp2app_->send (pHdr);
     }
   return false;
 }
@@ -335,21 +647,18 @@ Audio::flush ()
 //------------------------------------------------------------------------
 // Call back routine
 static void CALLBACK
-wave_callback (HWAVE hWave, UINT msg, DWORD instance, DWORD param1,
-	       DWORD param2)
+waveOut_callback (HWAVEOUT hWave, UINT msg, DWORD instance, DWORD param1,
+		  DWORD param2)
 {
   if (msg == WOM_DONE)
     {
-      Audio *ptr = (Audio *) instance;
-      ptr->callback_sampledone ((void *) param1);
+      fhandler_dev_dsp::Audio_out *ptr =
+	(fhandler_dev_dsp::Audio_out *) instance;
+      ptr->callback_sampledone ((WAVEHDR *) param1);
     }
 }
 
 //------------------------------------------------------------------------
-// /dev/dsp handler
-static Audio *s_audio;		// static instance of the Audio handler
-
-//------------------------------------------------------------------------
 // wav file detection..
 #pragma pack(1)
 struct wavchunk
@@ -369,11 +678,14 @@ struct wavformat
 #pragma pack()
 
 bool
-fhandler_dev_dsp::setupwav (const char *pData, int nBytes)
+fhandler_dev_dsp::Audio_out::parsewav (const char * &pData, int &nBytes,
+				       int &rate, int &bits, int &channels)
 {
   int len;
   const char *end = pData + nBytes;
-
+  const char *pDat;
+  int skip = 0;
+  
   if (!(pData[0] == 'R' && pData[1] == 'I' &&
 	pData[2] == 'F' && pData[3] == 'F'))
     return false;
@@ -382,108 +694,466 @@ fhandler_dev_dsp::setupwav (const char *
     return false;
 
   len = *(int *) &pData[4];
-  pData += 12;
-  while (len && pData < end)
-    {
-      wavchunk * pChunk = (wavchunk *) pData;
+  len -= 12;
+  pDat = pData + 12;
+  skip = 12;
+  while ((len > 0) && (pDat + sizeof (wavchunk) < end))
+    { /* We recognize two kinds of wavchunk:
+	 "fmt " for the PCM parameters (only PCM supported here)
+	 "data" for the start of PCM data */
+      wavchunk * pChunk = (wavchunk *) pDat;
       int blklen = pChunk-> len;
       if (pChunk->id[0] == 'f' && pChunk->id[1] == 'm' &&
 	  pChunk->id[2] == 't' && pChunk->id[3] == ' ')
 	{
 	  wavformat *format = (wavformat *) (pChunk + 1);
-	  if ((char *) (format + 1) > end)
+	  if ((char *) (format + 1) >= end)
 	    return false;
+	  // We have found the parameter chunk
+	  if (format->wFormatTag == 0x0001)
+	    { // Micr*s*ft PCM; check if parameters work with our device
+	      if (query (format->dwSamplesPerSec, format->wBitsPerSample,
+			 format->wChannels))
+		{ // return the parameters we found
+		  rate = format->dwSamplesPerSec;
+		  bits = format->wBitsPerSample;
+		  channels = format->wChannels;
+		}
+	    }
+	}
+      else
+	{
+	  if (pChunk->id[0] == 'd' && pChunk->id[1] == 'a' &&
+	      pChunk->id[2] == 't' && pChunk->id[3] == 'a')
+	    { // throw away all the header & not output it to the soundcard.
+	      skip += sizeof (wavchunk);
+	      debug_printf ("Discard %d bytes wave header", skip);
+	      pData += skip;
+	      nBytes -= skip;
+	      return true;
+	    }
+	}
+      pDat += blklen + sizeof (wavchunk);
+      skip += blklen + sizeof (wavchunk);
+      len -= blklen + sizeof (wavchunk);
+    }
+  return false;
+}
+
+/* ========================================================================
+   Buffering concept for Audio_in:
+   On the first read, we queue all blocks of our bigwavebuffer
+   for reception and start the wave-in device.
+   We manage queues of pointers to WAVEHDR
+   When a block has been filled, the callback puts the corresponding
+   WAVEHDR pointer into a queue. We need a second queue to distinguish
+   blocks with data from blocks that have been unprepared and are ready
+   to be used by read().
+   The function read() blocks (polled, sigh) until at least one good buffer
+   has arrived, then the data is copied into the buffer provided to read().
+   After a buffer has been fully used by read(), it is queued again
+   to the wave-in device immediately.
+   The function read() iterates until all data requested has been
+   received, there is no way to interrupt it */
+
+fhandler_dev_dsp::Audio_in::Audio_in () : Audio ()
+{
+  bigwavebuffer_ = NULL;
+  Qisr2app_ = new queue(MAX_BLOCKS);
+  Qapp2app_ = new queue(MAX_BLOCKS);
+}
+
+fhandler_dev_dsp::Audio_in::~Audio_in ()
+{
+  stop ();
+  delete Qapp2app_;
+  delete Qisr2app_;
+}
+
+bool
+fhandler_dev_dsp::Audio_in::query (int rate, int bits, int channels)
+{
+  WAVEFORMATEX format;
+  MMRESULT rc;
+
+  fillFormat (&format, rate, bits, channels);
+  rc = waveInOpen (NULL, WAVE_MAPPER, &format, 0L, 0L, WAVE_FORMAT_QUERY);
+  debug_printf ("freq=%d bits=%d channels=%d %s", rate, bits, channels,
+		(rc != MMSYSERR_NOERROR) ? "FAIL" : "OK");
+  return (rc == MMSYSERR_NOERROR);
+}
+
+bool
+fhandler_dev_dsp::Audio_in::start (int rate, int bits, int channels)
+{
+  WAVEFORMATEX format;
+  MMRESULT rc;
+  unsigned bSize = blockSize (rate, bits, channels);
+  bigwavebuffer_ = new char[MAX_BLOCKS * bSize];
+  if (bigwavebuffer_ == NULL)
+    return false;
+
+  int nDevices = waveInGetNumDevs ();
+  debug_printf ("number devices=%d, blocksize=%d", nDevices, bSize);
+  if (nDevices <= 0)
+    return false;
+
+  fillFormat (&format, rate, bits, channels);
+  rc = waveInOpen (&dev_, WAVE_MAPPER, &format, (DWORD) waveIn_callback,
+		    (DWORD) this, CALLBACK_FUNCTION);
+  if (rc == MMSYSERR_NOERROR)
+    {
+      setOwner ();
+      if (!init (bSize))
+	{
+	  stop ();
+	  return false;
+	}
+    }
+
+  debug_printf ("freq=%d bits=%d channels=%d %s", rate, bits, channels,
+		(rc != MMSYSERR_NOERROR) ? "FAIL" : "OK");
+  
+  return (rc == MMSYSERR_NOERROR);
+}
+
+void
+fhandler_dev_dsp::Audio_in::stop ()
+{
+  MMRESULT rc;
+  WAVEHDR *pHdr;
+  bool gotblock;
+
+  debug_printf ("dev_=%08x pid=%d owner=%d", (int)dev_,
+		GetCurrentProcessId (), getOwner ());
+  if (getOwner () && !denyAccess ())
+    {
+      rc = waveInReset (dev_);
+      /* Note that waveInReset calls our callback for all incomplete buffers.
+	 Since all the win32 wave functions appear to use a common lock,
+	 we must not call into the wave API from the callback.
+	 Otherwise we end up in a deadlock. */
+      debug_printf ("waveInReset rc=%d", rc);
 
-	  // Open up audio device with correct frequency for wav file
-	  //
-	  // FIXME: should through away all the header & not output
-	  // it to the soundcard.
-	  s_audio->close ();
-	  if (s_audio->open (format->dwSamplesPerSec, format->wBitsPerSample,
-			     format->wChannels) == false)
+      do
+	{
+	  lock ();
+	  gotblock = Qisr2app_->recv (&pHdr);
+	  unlock ();
+	  if (gotblock)
 	    {
-	      s_audio->open (audiofreq_, audiobits_, audiochannels_);
+	      rc = waveInUnprepareHeader (dev_, pHdr, sizeof (WAVEHDR));
+	      debug_printf ("waveInUnprepareHeader Block 0x%08x %s", pHdr,
+			    (rc != MMSYSERR_NOERROR) ? "FAIL" : "OK");
 	    }
-	  else
-	    {
-	      audiofreq_ = format->dwSamplesPerSec;
-	      audiobits_ = format->wBitsPerSample;
-	      audiochannels_ = format->wChannels;
+	}
+      while (gotblock);
+      while (Qapp2app_->recv (&pHdr))
+	/* flush queue */;
+
+      rc = waveInClose (dev_);
+      debug_printf ("waveInClose rc=%d", rc);
+
+      clearOwner ();
+
+      if (bigwavebuffer_)
+	{
+	  delete[] bigwavebuffer_;
+	  bigwavebuffer_ = NULL;
+	}
+    }
+}
+
+bool
+fhandler_dev_dsp::Audio_in::queueblock (WAVEHDR *pHdr)
+{
+  MMRESULT rc;
+  pHdr->dwFlags = 0;
+  rc = waveInPrepareHeader (dev_, pHdr, sizeof (WAVEHDR));
+  if (rc == MMSYSERR_NOERROR)
+    rc = waveInAddBuffer (dev_, pHdr, sizeof (WAVEHDR));
+  debug_printf ("waveInAddBuffer Block 0x%08x %s", pHdr,
+		(rc != MMSYSERR_NOERROR) ? "FAIL" : "OK");
+  return (rc == MMSYSERR_NOERROR);
+}
+
+bool
+fhandler_dev_dsp::Audio_in::init (unsigned blockSize)
+{
+  MMRESULT rc;
+  int i;
+
+  // try to queue all of our buffer for reception
+  for (i = 0; i < MAX_BLOCKS; i++)
+    {
+      wavehdr_[i].lpData = &bigwavebuffer_[i * blockSize];
+      wavehdr_[i].dwBufferLength = blockSize;
+      if (!queueblock (&wavehdr_[i]))
+	break;
+    }
+  pHdr_ = NULL;
+  rc = waveInStart (dev_);
+  debug_printf ("waveInStart=%d %s queued=%d",
+		rc, (rc != MMSYSERR_NOERROR) ? "FAIL" : "OK", i);
+  return (rc == MMSYSERR_NOERROR);
+}
+
+bool
+fhandler_dev_dsp::Audio_in::read (char *pSampleData, int &nBytes)
+{
+  int bytes_to_read = nBytes;
+  nBytes = 0;
+  debug_printf ("pSampleData=%08x nBytes=%d", pSampleData, bytes_to_read);
+  while (bytes_to_read != 0)
+    { // Block till next sound has been read
+      waitfordata ();
+
+      // Handle gathering our blocks into smaller or larger buffer
+      int sizeleft = pHdr_->dwBytesRecorded - bufferIndex_;
+      if (bytes_to_read < sizeleft)
+	{ // The current buffer holds more data than requested
+	  memcpy (pSampleData, &pHdr_->lpData[bufferIndex_], bytes_to_read);
+	  (this->*convert_) ((unsigned char *)pSampleData, bytes_to_read);
+	  nBytes += bytes_to_read;
+	  bufferIndex_ += bytes_to_read;
+	  debug_printf ("got %d", bytes_to_read); 
+	  break; // done; use remaining data in next call to read
+	}
+      else
+	{ // not enough or exact amount in the current buffer
+	  if (sizeleft)
+	    { // use up what we have
+	      memcpy (pSampleData, &pHdr_->lpData[bufferIndex_], sizeleft);
+	      (this->*convert_) ((unsigned char *)pSampleData, sizeleft);
+	      nBytes += sizeleft;
+	      bytes_to_read -= sizeleft;
+	      pSampleData += sizeleft;
+	      debug_printf ("got %d", sizeleft);
 	    }
-	  return true;
+	  queueblock (pHdr_); // re-queue this block to ISR
+	  pHdr_ = NULL;       // need to wait for a new block
+	  // if more samples are needed, we need a new block now
 	}
+    }
+  debug_printf ("end nBytes=%d", nBytes);
+  return true;
+}
+
+void
+fhandler_dev_dsp::Audio_in::waitfordata ()
+{
+  WAVEHDR *pHdr;
+  bool gotblock;
+  MMRESULT rc;
 
-      pData += blklen + sizeof (wavchunk);
+  if (pHdr_ != NULL)
+    return;
+  while (Qapp2app_->recv (&pHdr) == false)
+    {
+      lock ();
+      gotblock = Qisr2app_->recv (&pHdr);
+      unlock ();
+      if (gotblock)
+	{
+	  rc = waveInUnprepareHeader (dev_, pHdr, sizeof (WAVEHDR));
+	  if (rc == MMSYSERR_NOERROR)
+	    Qapp2app_->send (pHdr);
+	  else
+	    debug_printf ("error UnprepareHeader 0x%08x", pHdr);
+	}
+      else
+	{
+	  debug_printf ("100ms");
+	  Sleep (100);
+	}
     }
-  return false;
+  pHdr_ = pHdr;
+  bufferIndex_ = 0; 
 }
 
-//------------------------------------------------------------------------
+// This is called on an interrupt so use locking..
+void
+fhandler_dev_dsp::Audio_in::callback_blockfull (WAVEHDR *pHdr)
+{
+  lock ();
+  Qisr2app_->send (pHdr);
+  unlock ();
+}
+
+static void CALLBACK
+waveIn_callback (HWAVEIN hWave, UINT msg, DWORD instance, DWORD param1,
+		 DWORD param2)
+{
+  if (msg == WIM_DATA)
+    {
+      fhandler_dev_dsp::Audio_in *ptr =
+	(fhandler_dev_dsp::Audio_in *) instance;
+      ptr->callback_blockfull ((WAVEHDR *) param1);
+    }
+}
+
+
+/* ------------------------------------------------------------------------
+   /dev/dsp handler
+   ------------------------------------------------------------------------
+   instances of the handler statics */
+int fhandler_dev_dsp::open_count = 0;
+
 fhandler_dev_dsp::fhandler_dev_dsp ():
   fhandler_base ()
 {
+  debug_printf ("0x%08x", (int)this);
+  audio_in_ = NULL;
+  audio_out_ = NULL;
 }
 
 fhandler_dev_dsp::~fhandler_dev_dsp ()
 {
+  close ();
+  debug_printf ("0x%08x end", (int)this);
 }
 
 int
 fhandler_dev_dsp::open (int flags, mode_t mode)
 {
-  // currently we only support writing
-  if ((flags & (O_WRONLY | O_RDONLY | O_RDWR)) != O_WRONLY)
+  open_count++;
+  if (open_count > 1)
     {
-      set_errno (EACCES);
+      set_errno (EBUSY);
       return 0;
     }
-
   set_flags ((flags & ~O_TEXT) | O_BINARY);
-
-  if (!s_audio)
-    s_audio = new (audio_buf) Audio;
-
-  // Work out initial sample format & frequency
-      // dev/dsp defaults
-  audioformat_ = AFMT_S8;
+  // Work out initial sample format & frequency, /dev/dsp defaults
+  audioformat_ = AFMT_U8;
   audiofreq_ = 8000;
   audiobits_ = 8;
   audiochannels_ = 1;
-
-  int res;
-  if (!s_audio->open (audiofreq_, audiobits_, audiochannels_))
-    res = 0;
-  else
+  switch (flags & O_ACCMODE)
     {
+    case O_WRONLY:
+      audio_out_ = new Audio_out;
+      if (!audio_out_->query (audiofreq_, audiobits_, audiochannels_))
+	{
+	  delete audio_out_;
+	  audio_out_ = NULL;
+	}
+      break;
+    case O_RDONLY:
+      audio_in_ = new Audio_in;
+      if (!audio_in_->query (audiofreq_, audiobits_, audiochannels_)) 
+	{
+	  delete audio_in_;
+	  audio_in_ = NULL;
+	}
+      break;
+    case O_RDWR:
+      audio_out_ = new Audio_out;
+      if (audio_out_->query (audiofreq_, audiobits_, audiochannels_))
+	{
+	  audio_in_ = new Audio_in;
+	  if (!audio_in_->query (audiofreq_, audiobits_, audiochannels_))
+	    {
+	      delete audio_in_;
+	      audio_in_ = NULL;
+	      audio_out_->stop ();
+	      delete audio_out_;
+	      audio_out_ = NULL;
+	    }
+	}
+      else
+	{
+	  delete audio_out_;
+	  audio_out_ = NULL;
+	}
+      break;
+    default:
+      set_errno (EINVAL);
+      return 0;
+    } // switch (flags & O_ACCMODE)
+  int rc;
+  if (audio_in_ || audio_out_)
+    { /* All tried query () succeeded */
+      rc = 1;
       set_open_status ();
-      res = 1;
+      set_need_fork_fixup ();
+      set_close_on_exec_flag (1);
     }
-
-  debug_printf ("returns %d", res);
-  return res;
+  else
+    { /* One of the tried query () failed */
+      rc = 0;
+      set_errno (EIO);
+    }
+  debug_printf ("ACCMODE=0x%08x audio_in=%08x audio_out=%08x, rc=%d",
+                flags & O_ACCMODE, (int)audio_in_, (int)audio_out_, rc);
+  return rc;
 }
 
+#define RETURN_ERROR_WHEN_BUSY(audio)\
+  if ((audio)->denyAccess ())    \
+    {\
+      set_errno (EBUSY);\
+      return -1;\
+    }
+
 int
 fhandler_dev_dsp::write (const void *ptr, size_t len)
 {
-  if (s_audio->numbytesoutput () == 0)
+  int len_s = len; 
+  debug_printf ("ptr=%08x len=%d", ptr, len);
+  if (!audio_out_)
     {
-      // check for wave file & setup frequencys properly if possible.
-      setupwav ((const char *) ptr, len);
-
+      set_errno (EACCES); // device was opened for read?
+      return -1;
+    }
+  RETURN_ERROR_WHEN_BUSY(audio_out_);
+  if (audio_out_->getOwner () == 0L)
+    { // No owner yet, lets do it
+      // check for wave file & get parameters & skip header if possible.
+      if (audio_out_->parsewav ((const char *) ptr, len_s,
+				audiofreq_, audiobits_, audiochannels_))
+	{ // update our format conversion
+	  audioformat_ = ((audiobits_ == 8) ? AFMT_U8 : AFMT_S16_LE);
+	  audio_out_->setformat (audioformat_);
+	}
       // Open audio device properly with callbacks.
-      s_audio->close ();
-      if (!s_audio->open (audiofreq_, audiobits_, audiochannels_, true))
-	return 0;
+      if (!audio_out_->start (audiofreq_, audiobits_, audiochannels_))
+	{
+	  set_errno (EIO);
+	  return -1;
+	}
     }
 
-  s_audio->write (ptr, len);
+  audio_out_->write ((char *)ptr, len_s);
   return len;
 }
 
 void __stdcall
 fhandler_dev_dsp::read (void *ptr, size_t& len)
 {
+  debug_printf ("ptr=%08x len=%d", ptr, len);
+  if (!audio_in_)
+    {
+      len = (size_t)-1;
+      set_errno (EACCES); // device was opened for write?
+      return;
+    }
+  if (audio_in_->denyAccess ())
+    {
+      len = (size_t)-1;
+      set_errno (EBUSY);
+      return;
+    }
+  if (audio_in_->getOwner () == 0L)
+    { // No owner yet. Let's take it
+      // Open audio device properly with callbacks.
+      if (!audio_in_->start (audiofreq_, audiobits_, audiochannels_))
+	{
+	  len = (size_t)-1;
+	  set_errno (EIO);
+	  return;
+	}
+    }
+  audio_in_->read ((char *)ptr, (int&)len);
   return;
 }
 
@@ -496,13 +1166,27 @@ fhandler_dev_dsp::lseek (_off64_t offset
 int
 fhandler_dev_dsp::close (void)
 {
-  s_audio->close ();
+  debug_printf ("audio_in=%08x audio_out=%08x",
+		(int)audio_in_, (int)audio_out_);
+  if (audio_in_)
+    {
+      delete audio_in_;
+      audio_in_ = NULL;
+    }
+  if (audio_out_)
+    {
+      delete audio_out_;
+      audio_out_ = NULL;
+    }
+  if (open_count > 0)
+    open_count--;
   return 0;
 }
 
 int
 fhandler_dev_dsp::dup (fhandler_base * child)
 {
+  debug_printf ("");
   fhandler_dev_dsp *fhc = (fhandler_dev_dsp *) child;
 
   fhc->set_flags (get_flags ());
@@ -517,100 +1201,182 @@ int
 fhandler_dev_dsp::ioctl (unsigned int cmd, void *ptr)
 {
   int *intptr = (int *) ptr;
+  debug_printf ("audio_in=%08x audio_out=%08x",
+		(int)audio_in_, (int)audio_out_);
   switch (cmd)
     {
-#define CASE(a) case a : debug_printf("/dev/dsp: ioctl %s", #a);
+#define CASE(a) case a : debug_printf ("/dev/dsp: ioctl %s", #a);
 
       CASE (SNDCTL_DSP_RESET)
-	audioformat_ = AFMT_S8;
-	audiofreq_ = 8000;
-	audiobits_ = 8;
-	audiochannels_ = 1;
+	if (audio_out_)
+	  {
+	    RETURN_ERROR_WHEN_BUSY(audio_out_);
+	    audioformat_ = AFMT_U8;
+	    audiofreq_ = 8000;
+	    audiobits_ = 8;
+	    audiochannels_ = 1;
+	    audio_out_->stop ();
+	    audio_out_->setformat (audioformat_);
+	  }
+	if (audio_in_)
+	  {
+	    RETURN_ERROR_WHEN_BUSY(audio_in_);
+	    audioformat_ = AFMT_U8;
+	    audiofreq_ = 8000;
+	    audiobits_ = 8;
+	    audiochannels_ = 1;
+	    audio_in_->stop ();
+	    audio_in_->setformat (audioformat_);
+	  }
 	return 0;
+	break;
 
       CASE (SNDCTL_DSP_GETBLKSIZE)
-	*intptr = Audio::BLOCK_SIZE;
+	if (audio_out_)
+	  {
+	    *intptr = audio_out_->blockSize (audiofreq_,
+					     audiobits_,
+					     audiochannels_);
+	  }
+	else
+	  { // I am very sure that audio_in_ is valid
+	    *intptr = audio_in_->blockSize (audiofreq_,
+					    audiobits_,
+					    audiochannels_);
+	  }
 	return 0;
+	break;
 
       CASE (SNDCTL_DSP_SETFMT)
       {
-	int nBits = 0;
-	if (*intptr == AFMT_S16_LE)
-	  nBits = 16;
-	else if (*intptr == AFMT_U8)
-	  nBits = 8;
-	else if (*intptr == AFMT_S8)
-	  nBits = 8;
-	if (nBits)
-	  {
-	    s_audio->setformat (*intptr);
-	    s_audio->close ();
-	    if (s_audio->open (audiofreq_, nBits, audiochannels_) == true)
+	int nBits;
+	switch (*intptr)
+	  {
+	  case AFMT_QUERY:
+	    *intptr = audioformat_;
+	    return 0;
+	    break;
+	  case AFMT_U16_BE:
+	  case AFMT_U16_LE:
+	  case AFMT_S16_BE:
+	  case AFMT_S16_LE:
+	    nBits = 16;
+	    break;
+	  case AFMT_U8:
+	  case AFMT_S8:
+	    nBits = 8;
+	    break;
+	  default:
+	    nBits = 0;
+	  }
+	if (nBits && audio_out_)
+	  {
+	    RETURN_ERROR_WHEN_BUSY(audio_out_);
+	    audio_out_->stop ();
+	    audio_out_->setformat (*intptr);
+	    if (audio_out_->query (audiofreq_, nBits, audiochannels_))
 	      {
 		audiobits_ = nBits;
-		return 0;
+		audioformat_ = *intptr;
 	      }
 	    else
 	      {
-		s_audio->open (audiofreq_, audiobits_, audiochannels_);
+		*intptr = audiobits_;
 		return -1;
 	      }
 	  }
+	if (nBits && audio_in_)
+	  {
+	    RETURN_ERROR_WHEN_BUSY(audio_in_);
+	    audio_in_->stop ();
+	    audio_in_->setformat (*intptr);
+	    if (audio_in_->query (audiofreq_, nBits, audiochannels_))
+	      {
+		audiobits_ = nBits;
+		audioformat_ = *intptr;
+	      }
+	    else
+	      {
+		*intptr = audiobits_;
+		return -1;
+	      }
+	  }
+	return 0;
       }
       break;
 
       CASE (SNDCTL_DSP_SPEED)
-	s_audio->close ();
-	if (s_audio->open (*intptr, audiobits_, audiochannels_) == true)
-	  {
-	    audiofreq_ = *intptr;
-	    return 0;
+      {
+	if (audio_out_)
+	  {	    
+	    RETURN_ERROR_WHEN_BUSY(audio_out_);
+	    audio_out_->stop ();
+	    if (audio_out_->query (*intptr, audiobits_, audiochannels_))
+	      audiofreq_ = *intptr;
+	    else
+	      {
+		*intptr = audiofreq_;
+		return -1;
+	      }
 	  }
-	else
+	if (audio_in_)
 	  {
-	    s_audio->open (audiofreq_, audiobits_, audiochannels_);
-	    return -1;
+	    RETURN_ERROR_WHEN_BUSY(audio_in_);
+	    audio_in_->stop ();
+	    if (audio_in_->query (*intptr, audiobits_, audiochannels_))
+	      audiofreq_ = *intptr;
+	    else
+	      {
+		*intptr = audiofreq_;
+		return -1;
+	      }
 	  }
-	break;
+	return 0;
+      }
+      break;
 
       CASE (SNDCTL_DSP_STEREO)
       {
 	int nChannels = *intptr + 1;
 
-	s_audio->close ();
-	if (s_audio->open (audiofreq_, audiobits_, nChannels) == true)
-	  {
-	    audiochannels_ = nChannels;
-	    return 0;
+	if (audio_out_)
+	  {	    
+	    RETURN_ERROR_WHEN_BUSY(audio_out_);
+	    audio_out_->stop ();
+	    if (audio_out_->query (audiofreq_, audiobits_, nChannels))
+	      audiochannels_ = nChannels;
+	    else
+	      {
+		*intptr = audiochannels_ - 1;
+		return -1;
+	      }
 	  }
-	else
+	if (audio_in_)
 	  {
-	    s_audio->open (audiofreq_, audiobits_, audiochannels_);
-	    return -1;
+	    RETURN_ERROR_WHEN_BUSY(audio_in_);
+	    audio_in_->stop ();
+	    if (audio_in_->query (audiofreq_, audiobits_, nChannels))
+	      audiochannels_ = nChannels;
+	    else
+	      {
+		*intptr = audiochannels_ - 1;
+		return -1;
+	      }
 	  }
+	return 0;
       }
       break;
 
       CASE (SNDCTL_DSP_GETOSPACE)
       {
 	audio_buf_info *p = (audio_buf_info *) ptr;
-
-	int nBlocks = s_audio->blocks ();
-	int leftblocks = ((Audio::MAX_BLOCKS - nBlocks) - 1);
-	if (leftblocks < 0)
-	  leftblocks = 0;
-	if (leftblocks > 1)
-	  leftblocks = 1;
-	int left = leftblocks * Audio::BLOCK_SIZE;
-
-	p->fragments = leftblocks;
-	p->fragstotal = Audio::MAX_BLOCKS;
-	p->fragsize = Audio::BLOCK_SIZE;
-	p->bytes = left;
-
-	debug_printf ("ptr %p nblocks %d leftblocks %d left bytes %d ",
-		      ptr, nBlocks, leftblocks, left);
-
+	if (audio_out_)
+	  {
+	    RETURN_ERROR_WHEN_BUSY(audio_out_);
+	    audio_out_->buf_info (p, audiofreq_, audiobits_, audiochannels_);
+	    debug_printf ("ptr=%p frags=%d fragsize=%d bytes=%d",
+			  ptr, p->fragments, p->fragsize, p->bytes);
+	  }
 	return 0;
       }
       break;
@@ -625,29 +1391,62 @@ fhandler_dev_dsp::ioctl (unsigned int cm
 
       CASE (SNDCTL_DSP_GETFMTS)
       {
-	*intptr = AFMT_S16_LE | AFMT_U8 | AFMT_S8; // more?
+	*intptr = AFMT_S16_LE | AFMT_U8; // only native formats returned here
+	return 0;
+      }
+      break;
+
+      CASE (SNDCTL_DSP_POST)
+      CASE (SNDCTL_DSP_SYNC)
+      {
+	if (audio_out_)
+	  {
+	    // Stop audio out device
+	    RETURN_ERROR_WHEN_BUSY(audio_out_);
+	    audio_out_->stop ();
+	  }
+	if (audio_in_)
+	  {
+	    // Stop audio in device
+	    RETURN_ERROR_WHEN_BUSY(audio_in_);
+	    audio_in_->stop ();
+	  }
 	return 0;
       }
       break;
 
     default:
-      debug_printf ("/dev/dsp: ioctl not handled yet! FIXME:");
+      debug_printf ("/dev/dsp: ioctl 0x%08x not handled yet! FIXME:", cmd);
       break;
 
 #undef CASE
     };
+  set_errno (EINVAL);
   return -1;
 }
 
 void
 fhandler_dev_dsp::dump ()
 {
-  paranoid_printf ("here, fhandler_dev_dsp");
+  paranoid_printf ("here");
+}
+
+void
+fhandler_dev_dsp::fixup_after_fork (HANDLE parent)
+{ // called from new child process
+  debug_printf ("audio_in=%08x audio_out=%08x",
+		(int)audio_in_, (int)audio_out_);
+  if (audio_in_ )
+    audio_in_ ->fork_fixup (parent);
+  if (audio_out_)
+    audio_out_->fork_fixup (parent);
 }
 
 void
 fhandler_dev_dsp::fixup_after_exec ()
 {
-  /* FIXME:  Is there a better way to do this? */
-  s_audio = new (audio_buf) Audio;
+  debug_printf ("audio_in=%08x audio_out=%08x",
+		(int)audio_in_, (int)audio_out_);
 }
+
+
