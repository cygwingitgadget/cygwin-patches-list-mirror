Return-Path: <cygwin-patches-return-4904-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5476 invoked by alias); 21 Aug 2004 13:54:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5125 invoked from network); 21 Aug 2004 13:54:25 -0000
Date: Sat, 21 Aug 2004 13:54:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: fhandler_dsp.cc
Message-ID: <20040821135505.GC9451@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <01C4821C.DCA0AFF0.Gerd.Spalink@t-online.de> <3.0.5.32.20040816230400.00810670@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040816230400.00810670@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q3/txt/msg00056.txt.bz2

On Mon, Aug 16, 2004 at 11:04:00PM -0400, Pierre A. Humblet wrote:
>Following Gerd's comments, here is an updated patch that also improves 
>the internal error handling. It follows Gerd's approach.
>
>He has not answered my previous e-mail but he has indicated he would
>be in vacation for two weeks, so this is not unexpected.
> 
>I have also verified that the code passes Gerd's new nasty dup test.
>I think we are good to go for now.

If Gerd is on vacation and he has previously commented on your patch
favorably, I think it makes sense to check this in and tweak things
later, if there are problems.  I'd like to get a 1.5.11 released and if
this helps things then we probably want it.

cgf

>2004-08-17  Pierre Humblet <pierre.humblet@ieee.org>
>
>	* fhandler.h (fhandler_dev_dsp:~fhandler_dev_dsp): Delete.
>	(fhandler_dev_dsp::open_count): Delete.		   
>	(fhandler_dev_dsp::close_audio_in): New method declaration.
>	(fhandler_dev_dsp::close_audio_in): Ditto.
>	* fhandler_dsp.cc: Add and edit debug_printf throughout.
>	(fhandler_dev_dsp::Audio::denyAccess): Delete.
>	(fhandler_dev_dsp::Audio::fork_fixup): Ditto.
>	(fhandler_dev_dsp::Audio::getOwner): Ditto.
>	(fhandler_dev_dsp::Audio::clearOwner): Ditto.
>	(fhandler_dev_dsp::Audio::owner_): Ditto.
>	(fhandler_dev_dsp::Audio::setformat): Ditto, rename to setconvert.
>	(fhandler_dev_dsp::Audio::lock): Ditto, move to queue.
>	(fhandler_dev_dsp::Audio::unlock): Ditto.
>	(fhandler_dev_dsp::Audio::lock_): Ditto.
>	(fhandler_dev_dsp::Audio::bufferIndex_): New member, from Audio_out
>	and Audio_in.
>	(fhandler_dev_dsp::Audio::pHdr_): Ditto.
>	(fhandler_dev_dsp::Audio::wavehdr_): Ditto.
>	(fhandler_dev_dsp::Audio::bigwavebuffer_): ditto.
>	(fhandler_dev_dsp::Audio::Qisr2app_): Ditto.
>	(fhandler_dev_dsp::Audio::setconvert): New method, from old setformat.
>	(fhandler_dev_dsp::Audio::queue::lock): New method.
>	(fhandler_dev_dsp::Audio::queue::unlock): Ditto.
>	(fhandler_dev_dsp::Audio::queue::dellock): Ditto.
>	(fhandler_dev_dsp::Audio::queue::isvalid): Ditto.
>	(fhandler_dev_dsp::Audio::queue::lock_): New member.
>	(fhandler_dev_dsp::Audio::queue::depth1_): Delete.
>	(fhandler_dev_dsp::Audio_out::fork_fixup): New method.
>	(fhandler_dev_dsp::Audio_out::isvalid): New method.
>	(fhandler_dev_dsp::Audio_out::start): Remove arguments.
>	(fhandler_dev_dsp::Audio_out::parsewav): Change arguments and set 
>	internal state.
>	(fhandler_dev_dsp::Audio_out::emptyblocks): Delete.
>	(fhandler_dev_dsp::Audio_out::Qapp2app_): Ditto.
>	(fhandler_dev_dsp::Audio_out::Qisr2app_): Ditto, move to Audio.
>	(fhandler_dev_dsp::Audio_out::bufferIndex_): Ditto.
>	(fhandler_dev_dsp::Audio_out::pHdr_): Ditto.
>	(fhandler_dev_dsp::Audio_out::wavehdr_): Ditto.
>	(fhandler_dev_dsp::Audio_out::bigwavefuffer_): Ditto.
>	(fhandler_dev_dsp::Audio_out::freq_): New member.
>	(fhandler_dev_dsp::Audio_out::bits_): New member.
>	(fhandler_dev_dsp::Audio_out::channels_): New member.
>	(fhandler_dev_dsp::Audio_in::fork_fixup): New method.
>	(fhandler_dev_dsp::Audio_in::isvalid): New method.
>	(fhandler_dev_dsp::Audio_in::Qapp2app_): Delete.
>	(fhandler_dev_dsp::Audio_in::Qisr2app_): Ditto, move to Audio.
>	(fhandler_dev_dsp::Audio_in::bufferIndex_): Ditto.
>	(fhandler_dev_dsp::Audio_in::pHdr_): Ditto.
>	(fhandler_dev_dsp::Audio_in::wavehdr_): Ditto.
>	(fhandler_dev_dsp::Audio_in::bigwavefuffer_): Ditto.
>	(fhandler_dev_dsp::Audio::queue::queue): Simplify.
>	(fhandler_dev_dsp::Audio::queue::send): Use lock.
>	(fhandler_dev_dsp::Audio::queue::query): Do not use depth1_.
>	(fhandler_dev_dsp::Audio::queue::recv): Ditto.
>	(fhandler_dev_dsp::Audio::Audio): Adapt to new class members.
>	(fhandler_dev_dsp::Audio::~Audio): Ditto
>	(fhandler_dev_dsp::Audio_out::start): Reorganize.
>	(fhandler_dev_dsp::Audio_out::stop): Simplify.
>	(fhandler_dev_dsp::Audio_out::init): Reset the queue and clear flag.
>	(fhandler_dev_dsp::Audio_out::write): Reorganize to allocate audio_out.
>	(fhandler_dev_dsp::Audio_out::buf_info): Use appropriate block size.
>	(fhandler_dev_dsp::Audio_out::callback_sampledone): Do not use lock.
>	(fhandler_dev_dsp::Audio_out::waitforspace): Simplify.
>	(fhandler_dev_dsp::Audio_out::waitforallsent):Ditto.
>	(fhandler_dev_dsp::Audio_out::sendcurrent): Reorganize.
>	Clear flag before requeuing.
>	(fhandler_dev_dsp::Audio_out::parsewav): 
>	(fhandler_dev_dsp::Audio_in::start): Reorganize.
>	(fhandler_dev_dsp::Audio_in::stop): Simplify.
>	(fhandler_dev_dsp::Audio_in::queueblock): Ditto.
>	Requeue header in case of error.
>	(fhandler_dev_dsp::Audio_in::init): Reset the queue and clear flag.
>	(fhandler_dev_dsp::Audio_in::waitfordata): Simplify.
>	Do not UnprepareHeader if the flag is zero.
>	(fhandler_dev_dsp::Audio_in::buf_info): Ditto.
>	(fhandler_dev_dsp::Audio_in::callback_blockfull): Do not use lock.
>	(fhandler_dev_dsp::open_count): Delete.
>	(fhandler_dev_dsp::open): Only check existence, do not allocate
>	anything. Set flags appropriately. Create archetype.
>	(fhandler_dev_dsp::write): Call archetype as needed. Create audio_out.
>	(fhandler_dev_dsp::read): Call archetype as needed. Create audio_in.
>	(fhandler_dev_dsp::close): Call archetype as needed. 
>	Call close_audio_in and close_audio_out.
>	(fhandler_dev_dsp::close_audio_in): New function.
>	(fhandler_dev_dsp::close_audio_out): New function.
>	(fhandler_dev_dsp::dup): Use archetypes.
>	(fhandler_dev_dsp::ioctl): Call archetype as needed. Reorganize for
>	new structures.
>	(fhandler_dev_dsp::fixup_after_fork): Call archetype as needed.
>	(fhandler_dev_dsp::fixup_after_exec): Call archetype as needed.
>	Clear audio_in and audio_out.

>Index: fhandler.h
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
>retrieving revision 1.210
>diff -u -p -r1.210 fhandler.h
>--- fhandler.h	15 Jul 2004 14:56:05 -0000	1.210
>+++ fhandler.h	14 Aug 2004 03:30:18 -0000
>@@ -1069,12 +1069,10 @@ class fhandler_dev_dsp: public fhandler_
>   int audiofreq_;
>   int audiobits_;
>   int audiochannels_;
>-  static int open_count; // per process
>   Audio_out *audio_out_;
>   Audio_in  *audio_in_;
>  public:
>   fhandler_dev_dsp ();
>-  ~fhandler_dev_dsp();
>
>   int open (int flags, mode_t mode = 0);
>   int write (const void *ptr, size_t len);
>@@ -1086,6 +1084,9 @@ class fhandler_dev_dsp: public fhandler_
>   void dump (void);
>   void fixup_after_fork (HANDLE parent);
>   void fixup_after_exec ();
>+ private:
>+  void close_audio_in ();
>+  void close_audio_out (bool immediately = false);
> };
>
> class fhandler_virtual : public fhandler_base
>Index: fhandler_dsp.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/fhandler_dsp.cc,v
>retrieving revision 1.38
>diff -u -p -r1.38 fhandler_dsp.cc
>--- fhandler_dsp.cc	19 Jul 2004 13:13:48 -0000	1.38
>+++ fhandler_dsp.cc	16 Aug 2004 23:47:11 -0000
>@@ -1,4 +1,4 @@
>-/* fhandler_dev_dsp: code to emulate OSS sound model /dev/dsp
>+/* Fhandler_dev_dsp: code to emulate OSS sound model /dev/dsp
>
>    Copyright 2001, 2002, 2003, 2004 Red Hat, Inc
>
>@@ -21,12 +21,14 @@ details. */
> #include "security.h"
> #include "path.h"
> #include "fhandler.h"
>+#include "dtable.h"
>+#include "cygheap.h"
>
> /*------------------------------------------------------------------------
>   Simple encapsulation of the win32 audio device.
>
>   Implementation Notes
>-  1. Audio buffers are created dynamically just before the first read or
>+  1. Audio structures are malloced just before the first read or
>      write to /dev/dsp. The actual buffer size is determined at that time,
>      such that one buffer holds about 125ms of audio data.
>      At the time of this writing, 12 buffers are allocated,
>@@ -35,38 +37,28 @@ details. */
>      but for this implementation only returns meaningful results if
>      sampling rate, number of channels and number of bits per sample
>      are not changed afterwards.
>+     The audio structures are freed when the device is reset or closed,
>+     and they are not passed to exec'ed processes.
>+     The dev_ member is cleared after a fork. This forces the child
>+     to reopen the audio device._
>
>-  2. Every open call creates a new instance of the handler. To cope
>-     with the fact that only a single wave device exists, the static
>-     variable open_count tracks opens for one process. After a
>+  2. Every open call creates a new instance of the handler. After a
>      successful open, every subsequent open from the same process
>      to the device fails with EBUSY.
>-     If different processes open the audio device simultaneously,
>-     the results are unpredictable - usually the first one wins.
>-
>-  3. The wave device is reserved within a process from the time that
>-     the first read or write call has been successful until /dev/dsp
>-     has been closed by that process. During this reservation period
>-     child processes that use the same file descriptor cannot
>-     do read, write or ioctls that change the device properties.
>-     This means that a parent can open the device, do some ioctl,
>-     spawn children, and any one of them can do the data read/write
>+     The structures are shared between duped handles, but not with
>+     children. They only inherit the settings from the parent.
>  */
>
> class fhandler_dev_dsp::Audio
> { // This class contains functionality common to Audio_in and Audio_out
>  public:
>    Audio ();
>-  ~Audio ();
>+   ~Audio ();
>
>   class queue;
>
>-  bool denyAccess ();
>-  void fork_fixup (HANDLE parent);
>-  inline DWORD getOwner () { return owner_; }
>-  void setOwner () { owner_ = GetCurrentProcessId (); }
>-  inline void clearOwner () { owner_ = 0L; }
>-  void setformat (int format);
>+  bool isvalid ();
>+  void setconvert (int format);
>   void convert_none (unsigned char *buffer, int size_bytes) { }
>   void convert_U8_S8 (unsigned char *buffer, int size_bytes);
>   void convert_S16LE_U16LE (unsigned char *buffer, int size_bytes);
>@@ -75,14 +67,16 @@ class fhandler_dev_dsp::Audio
>   void fillFormat (WAVEFORMATEX * format,
> 		   int rate, int bits, int channels);
>   unsigned blockSize (int rate, int bits, int channels);
>-
>   void (fhandler_dev_dsp::Audio::*convert_)
>     (unsigned char *buffer, int size_bytes);
>-  inline void lock () { EnterCriticalSection (&lock_); }
>-  inline void unlock () { LeaveCriticalSection (&lock_); }
>- private:
>-  DWORD owner_; /* Process ID when wave operation started, else 0 */
>-  CRITICAL_SECTION lock_;
>+
>+  enum { MAX_BLOCKS = 12 };
>+  int bufferIndex_;  // offset into pHdr_->lpData
>+  WAVEHDR *pHdr_;    // data to be filled by write
>+  WAVEHDR wavehdr_[MAX_BLOCKS];
>+  char *bigwavebuffer_; // audio samples only
>+  // Member variables below must be locked
>+  queue *Qisr2app_; // blocks passed from wave callback
> };
>
> class fhandler_dev_dsp::Audio::queue
>@@ -93,12 +87,17 @@ class fhandler_dev_dsp::Audio::queue
>
>   bool send (WAVEHDR *);  // queue an item, returns true if successful
>   bool recv (WAVEHDR **); // retrieve an item, returns true if successful
>-  int query ();		  // return number of items queued
>-
>+  void reset ();
>+  int query (); // return number of items queued
>+  inline void lock () { EnterCriticalSection (&lock_); }
>+  inline void unlock () { LeaveCriticalSection (&lock_); }
>+  inline void dellock () { debug_printf ("Deleting Critical Section"); DeleteCriticalSection (&lock_); }
>+  bool isvalid () { return storage_; }
>  private:
>+  CRITICAL_SECTION lock_;
>   int head_;
>   int tail_;
>-  int depth_, depth1_;
>+  int depth_;
>   WAVEHDR **storage_;
> };
>
>@@ -108,35 +107,29 @@ static void CALLBACK waveOut_callback (H
> class fhandler_dev_dsp::Audio_out: public Audio
> {
>  public:
>-   Audio_out ();
>-  ~Audio_out ();
>-
>+  void fork_fixup (HANDLE parent);
>   bool query (int rate, int bits, int channels);
>-  bool start (int rate, int bits, int channels);
>+  bool start ();
>   void stop (bool immediately = false);
>   bool write (const char *pSampleData, int nBytes);
>   void buf_info (audio_buf_info *p, int rate, int bits, int channels);
>   void callback_sampledone (WAVEHDR *pHdr);
>   bool parsewav (const char *&pData, int &nBytes,
>-		 int &rate, int &bits, int &channels);
>+		 int rate, int bits, int channels);
>
>  private:
>   void init (unsigned blockSize);
>   void waitforallsent ();
>   void waitforspace ();
>   bool sendcurrent ();
>-  int emptyblocks ();
>
>   enum { MAX_BLOCKS = 12 };
>-  queue *Qapp2app_;  // empty and unprepared blocks
>   HWAVEOUT dev_;     // The wave device
>-  int bufferIndex_;  // offset into pHdr_->lpData
>-  WAVEHDR *pHdr_;    // data to be filled by write
>-  WAVEHDR wavehdr_[MAX_BLOCKS];
>-  char *bigwavebuffer_; // audio samples only
>-
>-  // Member variables below must be locked
>-  queue *Qisr2app_; // empty blocks passed from wave callback
>+  /* Private copies of audiofreq_, audiobits_, audiochannels_,
>+     possibly set from wave file */
>+  int freq_;
>+  int bits_;
>+  int channels_;
> };
>
> static void CALLBACK waveIn_callback (HWAVEIN hWave, UINT msg, DWORD instance,
>@@ -145,9 +138,7 @@ static void CALLBACK waveIn_callback (HW
> class fhandler_dev_dsp::Audio_in: public Audio
> {
> public:
>-   Audio_in ();
>-  ~Audio_in ();
>-
>+  void fork_fixup (HANDLE parent);
>   bool query (int rate, int bits, int channels);
>   bool start (int rate, int bits, int channels);
>   void stop ();
>@@ -160,16 +151,7 @@ private:
>   bool queueblock (WAVEHDR *pHdr);
>   void waitfordata (); // blocks until we have a good pHdr_
>
>-  enum { MAX_BLOCKS = 12 }; // read ahead of 1.5 seconds
>-  queue *Qapp2app_;    // filled and unprepared blocks
>   HWAVEIN dev_;
>-  int bufferIndex_;    // offset into pHdr_->lpData
>-  WAVEHDR *pHdr_;      // successfully recorded data
>-  WAVEHDR wavehdr_[MAX_BLOCKS];
>-  char *bigwavebuffer_; // audio samples
>-
>-  // Member variables below must be locked
>-  queue *Qisr2app_; // filled blocks passed from wave callback
> };
>
> /* --------------------------------------------------------------------
>@@ -178,13 +160,10 @@ private:
> // Simple fixed length FIFO queue implementation for audio buffer management
> fhandler_dev_dsp::Audio::queue::queue (int depth)
> {
>-  head_ = 0;
>-  tail_ = 0;
>-  depth_ = depth;
>-  depth1_ = depth + 1;
>   // allow space for one extra object in the queue
>   // so we can distinguish full and empty status
>-  storage_ = new WAVEHDR *[depth1_];
>+  depth_ = depth;
>+  storage_ = new WAVEHDR *[depth_ + 1];
> }
>
> fhandler_dev_dsp::Audio::queue::~queue ()
>@@ -192,28 +171,48 @@ fhandler_dev_dsp::Audio::queue::~queue (
>   delete[] storage_;
> }
>
>+void
>+fhandler_dev_dsp::Audio::queue::reset ()
>+ {
>+   /* When starting, after reset and after fork */
>+   head_ = tail_ = 0;
>+   debug_printf ("InitializeCriticalSection");
>+   memset (&lock_, 0, sizeof (lock_));
>+   InitializeCriticalSection (&lock_);
>+ }
>+
> bool
> fhandler_dev_dsp::Audio::queue::send (WAVEHDR *x)
> {
>+  bool res = false;
>+  lock ();
>   if (query () == depth_)
>-    return false;
>-  storage_[tail_] = x;
>-  tail_++;
>-  if (tail_ == depth1_)
>-    tail_ = 0;
>-  return true;
>+    system_printf ("Queue overflow");
>+  else
>+    {
>+      storage_[tail_] = x;
>+      if (++tail_ > depth_)
>+	tail_ = 0;
>+      res = true;
>+    }
>+  unlock ();
>+  return res;
> }
>
> bool
> fhandler_dev_dsp::Audio::queue::recv (WAVEHDR **x)
> {
>-  if (query () == 0)
>-    return false;
>-  *x = storage_[head_];
>-  head_++;
>-  if (head_ == depth1_)
>-    head_ = 0;
>-  return true;
>+  bool res = false;
>+  lock ();
>+  if (query () != 0)
>+    {
>+      *x = storage_[head_];
>+      if (++head_ > depth_)
>+	head_ = 0;
>+      res = true;
>+    }
>+  unlock ();
>+  return res;
> }
>
> int
>@@ -221,40 +220,33 @@ fhandler_dev_dsp::Audio::queue::query ()
> {
>   int n = tail_ - head_;
>   if (n < 0)
>-    n += depth1_;
>+    n += depth_ + 1;
>   return n;
> }
>
> // Audio class implements functionality need for both read and write
> fhandler_dev_dsp::Audio::Audio ()
> {
>-  InitializeCriticalSection (&lock_);
>+  bigwavebuffer_ = NULL;
>+  Qisr2app_ = new queue (MAX_BLOCKS);
>   convert_ = &fhandler_dev_dsp::Audio::convert_none;
>-  owner_ = 0L;
> }
>
> fhandler_dev_dsp::Audio::~Audio ()
> {
>-  DeleteCriticalSection (&lock_);
>+  debug_printf("");
>+  delete Qisr2app_;
>+  delete[] bigwavebuffer_;
> }
>
>-void
>-fhandler_dev_dsp::Audio::fork_fixup (HANDLE parent)
>-{
>-  debug_printf ("parent=0x%08x", parent);
>-  InitializeCriticalSection (&lock_);
>-}
>-
>-bool
>-fhandler_dev_dsp::Audio::denyAccess ()
>-{
>-  if (owner_ == 0L)
>-    return false;
>-  return (GetCurrentProcessId () != owner_);
>+inline bool
>+fhandler_dev_dsp::Audio::isvalid ()
>+{
>+  return bigwavebuffer_ && Qisr2app_ && Qisr2app_->isvalid ();
> }
>
> void
>-fhandler_dev_dsp::Audio::setformat (int format)
>+fhandler_dev_dsp::Audio::setconvert (int format)
> {
>   switch (format)
>     {
>@@ -361,19 +353,16 @@ fhandler_dev_dsp::Audio::blockSize (int
> }
>
> //=======================================================================
>-fhandler_dev_dsp::Audio_out::Audio_out (): Audio ()
>+void
>+fhandler_dev_dsp::Audio_out::fork_fixup (HANDLE parent)
> {
>-  bigwavebuffer_ = NULL;
>-  Qisr2app_ = new queue (MAX_BLOCKS);
>-  Qapp2app_ = new queue (MAX_BLOCKS);
>+  /* Null dev_.
>+     It will be necessary to reset the queue, open the device
>+     and create a lock when writing */
>+  debug_printf ("parent=0x%08x", parent);
>+  dev_ = NULL;
> }
>
>-fhandler_dev_dsp::Audio_out::~Audio_out ()
>-{
>-  stop ();
>-  delete Qapp2app_;
>-  delete Qisr2app_;
>-}
>
> bool
> fhandler_dev_dsp::Audio_out::query (int rate, int bits, int channels)
>@@ -383,37 +372,34 @@ fhandler_dev_dsp::Audio_out::query (int
>
>   fillFormat (&format, rate, bits, channels);
>   rc = waveOutOpen (NULL, WAVE_MAPPER, &format, 0L, 0L, WAVE_FORMAT_QUERY);
>-  debug_printf ("freq=%d bits=%d channels=%d %s", rate, bits, channels,
>-		(rc != MMSYSERR_NOERROR) ? "FAIL" : "OK");
>+  debug_printf ("%d = waveOutOpen (freq=%d bits=%d channels=%d)", rc, rate, bits, channels);
>   return (rc == MMSYSERR_NOERROR);
> }
>
> bool
>-fhandler_dev_dsp::Audio_out::start (int rate, int bits, int channels)
>+fhandler_dev_dsp::Audio_out::start ()
> {
>   WAVEFORMATEX format;
>   MMRESULT rc;
>-  unsigned bSize = blockSize (rate, bits, channels);
>-  bigwavebuffer_ = new char[MAX_BLOCKS * bSize];
>-  if (bigwavebuffer_ == NULL)
>-    return false;
>+  unsigned bSize = blockSize (freq_, bits_, channels_);
>+
>+  if (dev_)
>+    return true;
>+
>+  /* In case of fork bigwavebuffer may already exist */
>+  if (!bigwavebuffer_)
>+    bigwavebuffer_ = new char[MAX_BLOCKS * bSize];
>
>-  int nDevices = waveOutGetNumDevs ();
>-  debug_printf ("number devices=%d, blocksize=%d", nDevices, bSize);
>-  if (nDevices <= 0)
>+  if (!isvalid ())
>     return false;
>
>-  fillFormat (&format, rate, bits, channels);
>+  fillFormat (&format, freq_, bits_, channels_);
>   rc = waveOutOpen (&dev_, WAVE_MAPPER, &format, (DWORD) waveOut_callback,
> 		     (DWORD) this, CALLBACK_FUNCTION);
>   if (rc == MMSYSERR_NOERROR)
>-    {
>-      setOwner ();
>-      init (bSize);
>-    }
>+    init (bSize);
>
>-  debug_printf ("freq=%d bits=%d channels=%d %s", rate, bits, channels,
>-		(rc != MMSYSERR_NOERROR) ? "FAIL" : "OK");
>+  debug_printf ("%d = waveOutOpen (freq=%d bits=%d channels=%d)", rc, freq_, bits_, channels_);
>
>   return (rc == MMSYSERR_NOERROR);
> }
>@@ -423,11 +409,9 @@ fhandler_dev_dsp::Audio_out::stop (bool
> {
>   MMRESULT rc;
>   WAVEHDR *pHdr;
>-  bool gotblock;
>
>-  debug_printf ("dev_=%08x pid=%d owner=%d", (int)dev_,
>-		GetCurrentProcessId (), getOwner ());
>-  if (getOwner () && !denyAccess ())
>+  debug_printf ("dev_=%08x", (int)dev_);
>+  if (dev_)
>     {
>       if (!immediately)
> 	{
>@@ -436,33 +420,17 @@ fhandler_dev_dsp::Audio_out::stop (bool
> 	}
>
>       rc = waveOutReset (dev_);
>-      debug_printf ("waveOutReset rc=%d", rc);
>-      do
>+      debug_printf ("%d = waveOutReset ()", rc);
>+      while (Qisr2app_->recv (&pHdr))
> 	{
>-	  lock ();
>-	  gotblock = Qisr2app_->recv (&pHdr);
>-	  unlock ();
>-	  if (gotblock)
>-	    {
>-	      rc = waveOutUnprepareHeader (dev_, pHdr, sizeof (WAVEHDR));
>-	      debug_printf ("waveOutUnprepareHeader Block 0x%08x %s", pHdr,
>-			    (rc != MMSYSERR_NOERROR) ? "FAIL" : "OK");
>-	    }
>+	  rc = waveOutUnprepareHeader (dev_, pHdr, sizeof (WAVEHDR));
>+	  debug_printf ("%d = waveOutUnprepareHeader (0x%08x)", rc, pHdr);
> 	}
>-      while (gotblock);
>-      while (Qapp2app_->recv (&pHdr))
>-	/* flush queue */;
>
>       rc = waveOutClose (dev_);
>-      debug_printf ("waveOutClose rc=%d", rc);
>+      debug_printf ("%d = waveOutClose ()", rc);
>
>-      clearOwner ();
>-    }
>-
>-  if (bigwavebuffer_)
>-    {
>-      delete[] bigwavebuffer_;
>-      bigwavebuffer_ = NULL;
>+      Qisr2app_->dellock ();
>     }
> }
>
>@@ -472,13 +440,15 @@ fhandler_dev_dsp::Audio_out::init (unsig
>   int i;
>
>   // internally queue all of our buffer for later use by write
>+  Qisr2app_->reset ();
>   for (i = 0; i < MAX_BLOCKS; i++)
>     {
>       wavehdr_[i].lpData = &bigwavebuffer_[i * blockSize];
>       wavehdr_[i].dwUser = (int) blockSize;
>-      if (!Qapp2app_->send (&wavehdr_[i]))
>+      wavehdr_[i].dwFlags = 0;
>+      if (!Qisr2app_->send (&wavehdr_[i]))
> 	{
>-	  debug_printf ("Internal Error i=%d", i);
>+	  system_printf ("Internal Error i=%d", i);
> 	  break; // should not happen
> 	}
>     }
>@@ -511,27 +481,17 @@ fhandler_dev_dsp::Audio_out::write (cons
>   return true;
> }
>
>-// return number of (completely) empty blocks back.
>-int
>-fhandler_dev_dsp::Audio_out::emptyblocks ()
>-{
>-  int n;
>-  lock ();
>-  n = Qisr2app_->query ();
>-  unlock ();
>-  n += Qapp2app_->query ();
>-  return n;
>-}
>-
> void
> fhandler_dev_dsp::Audio_out::buf_info (audio_buf_info *p,
> 				       int rate, int bits, int channels)
> {
>   p->fragstotal = MAX_BLOCKS;
>-  p->fragsize = blockSize (rate, bits, channels);
>-  if (getOwner ())
>+  if (this && dev_)
>     {
>-      p->fragments = emptyblocks ();
>+      /* If the device is running we use the internal values,
>+	 possibly set from the wave file. */
>+      p->fragsize = blockSize (freq_, bits_, channels_);
>+      p->fragments = Qisr2app_->query ();
>       if (pHdr_ != NULL)
> 	p->bytes = (int)pHdr_->dwUser - bufferIndex_
> 	  + p->fragsize * p->fragments;
>@@ -540,6 +500,7 @@ fhandler_dev_dsp::Audio_out::buf_info (a
>     }
>   else
>     {
>+      p->fragsize = blockSize (rate, bits, channels);
>       p->fragments = MAX_BLOCKS;
>       p->bytes = p->fragsize * p->fragments;
>     }
>@@ -547,51 +508,31 @@ fhandler_dev_dsp::Audio_out::buf_info (a
>
> /* This is called on an interupt so use locking.. Note Qisr2app_
>    is used so we should wrap all references to it in locks. */
>-void
>+inline void
> fhandler_dev_dsp::Audio_out::callback_sampledone (WAVEHDR *pHdr)
> {
>-  lock ();
>   Qisr2app_->send (pHdr);
>-  unlock ();
> }
>
> void
> fhandler_dev_dsp::Audio_out::waitforspace ()
> {
>   WAVEHDR *pHdr;
>-  bool gotblock;
>   MMRESULT rc = WAVERR_STILLPLAYING;
>
>   if (pHdr_ != NULL)
>     return;
>-  while (Qapp2app_->recv (&pHdr) == false)
>+  while (!Qisr2app_->recv (&pHdr))
>     {
>-      lock ();
>-      gotblock = Qisr2app_->recv (&pHdr);
>-      unlock ();
>-      if (gotblock)
>-	{
>-	  if ((pHdr->dwFlags & WHDR_DONE)
>-	      && ((rc = waveOutUnprepareHeader (dev_, pHdr, sizeof (WAVEHDR)))
>-	       == MMSYSERR_NOERROR))
>-	    {
>-	      Qapp2app_->send (pHdr);
>-	    }
>-	  else
>-	    {
>-	      debug_printf ("error UnprepareHeader 0x%08x, rc=%d, 100ms",
>-			    pHdr, rc);
>-	      lock ();
>-	      Qisr2app_->send (pHdr);
>-	      unlock ();
>-	      Sleep (100);
>-	    }
>-	}
>-      else
>-	{
>-	  debug_printf ("100ms");
>-	  Sleep (100);
>-	}
>+      debug_printf ("100ms");
>+      Sleep (100);
>+    }
>+  if (pHdr->dwFlags)
>+    {
>+      /* Errors are ignored here. They will probbaly cause a failure
>+	 in the subsequent PrepareHeader */
>+      rc = waveOutUnprepareHeader (dev_, pHdr, sizeof (WAVEHDR));
>+      debug_printf ("%d = waveOutUnprepareHeader (0x%08x)", rc, pHdr);
>     }
>   pHdr_ = pHdr;
>   bufferIndex_ = 0;
>@@ -600,10 +541,9 @@ fhandler_dev_dsp::Audio_out::waitforspac
> void
> fhandler_dev_dsp::Audio_out::waitforallsent ()
> {
>-  while (emptyblocks () != MAX_BLOCKS)
>+  while (Qisr2app_->query () != MAX_BLOCKS)
>     {
>-      debug_printf ("100ms Qisr=%d Qapp=%d",
>-		    Qisr2app_->query (), Qapp2app_->query ());
>+      debug_printf ("%d blocks in Qisr2app", Qisr2app_->query ());
>       Sleep (100);
>     }
> }
>@@ -613,6 +553,9 @@ bool
> fhandler_dev_dsp::Audio_out::sendcurrent ()
> {
>   WAVEHDR *pHdr = pHdr_;
>+  MMRESULT rc;
>+  debug_printf ("pHdr=0x%08x bytes=%d", pHdr, bufferIndex_);
>+
>   if (pHdr_ == NULL)
>     return false;
>   pHdr_ = NULL;
>@@ -622,27 +565,19 @@ fhandler_dev_dsp::Audio_out::sendcurrent
>
>   // Send internal buffer out to the soundcard
>   pHdr->dwBufferLength = bufferIndex_;
>-  pHdr->dwFlags = 0;
>-  if (waveOutPrepareHeader (dev_, pHdr, sizeof (WAVEHDR)) == MMSYSERR_NOERROR)
>-    {
>-      if (waveOutWrite (dev_, pHdr, sizeof (WAVEHDR)) == MMSYSERR_NOERROR)
>-	{
>-	  debug_printf ("waveOutWrite bytes=%d", bufferIndex_);
>-	  return true;
>-	}
>-      else
>-	{
>-	  debug_printf ("waveOutWrite failed");
>-	  lock ();
>-	  Qisr2app_->send (pHdr);
>-	  unlock ();
>-	}
>-    }
>-  else
>+  rc = waveOutPrepareHeader (dev_, pHdr, sizeof (WAVEHDR));
>+  debug_printf ("%d = waveOutPrepareHeader (0x%08x)", rc, pHdr);
>+  if (rc == MMSYSERR_NOERROR)
>     {
>-      debug_printf ("waveOutPrepareHeader failed");
>-      Qapp2app_->send (pHdr);
>+      rc = waveOutWrite (dev_, pHdr, sizeof (WAVEHDR));
>+      debug_printf ("%d = waveOutWrite (0x%08x)", rc, pHdr);
>     }
>+  if (rc == MMSYSERR_NOERROR)
>+    return true;
>+
>+  /* FIXME: Should we return an error instead ?*/
>+  pHdr->dwFlags = 0; /* avoid calling UnprepareHeader again */
>+  Qisr2app_->send (pHdr);
>   return false;
> }
>
>@@ -681,12 +616,19 @@ struct wavformat
>
> bool
> fhandler_dev_dsp::Audio_out::parsewav (const char * &pData, int &nBytes,
>-				       int &rate, int &bits, int &channels)
>+				       int dev_freq, int dev_bits, int dev_channels)
> {
>   int len;
>   const char *end = pData + nBytes;
>   const char *pDat;
>   int skip = 0;
>+
>+  /* Start with default values from the device handler */
>+  freq_ = dev_freq;
>+  bits_ = dev_bits;
>+  channels_ = dev_channels;
>+  setconvert (bits_ == 8 ? AFMT_U8 : AFMT_S16_LE);
>+
>   // Check alignment first: A lot of the code below depends on it
>   if (((int)pData & 0x3) != 0)
>     return false;
>@@ -719,9 +661,9 @@ fhandler_dev_dsp::Audio_out::parsewav (c
> 	      if (query (format->dwSamplesPerSec, format->wBitsPerSample,
> 			 format->wChannels))
> 		{ // return the parameters we found
>-		  rate = format->dwSamplesPerSec;
>-		  bits = format->wBitsPerSample;
>-		  channels = format->wChannels;
>+		  freq_ = format->dwSamplesPerSec;
>+		  bits_ = format->wBitsPerSample;
>+		  channels_ = format->wChannels;
> 		}
> 	    }
> 	}
>@@ -734,6 +676,7 @@ fhandler_dev_dsp::Audio_out::parsewav (c
> 	      debug_printf ("Discard %d bytes wave header", skip);
> 	      pData += skip;
> 	      nBytes -= skip;
>+	      setconvert (bits_ == 8 ? AFMT_U8 : AFMT_S16_LE);
> 	      return true;
> 	    }
> 	}
>@@ -750,9 +693,7 @@ fhandler_dev_dsp::Audio_out::parsewav (c
>    for reception and start the wave-in device.
>    We manage queues of pointers to WAVEHDR
>    When a block has been filled, the callback puts the corresponding
>-   WAVEHDR pointer into a queue. We need a second queue to distinguish
>-   blocks with data from blocks that have been unprepared and are ready
>-   to be used by read().
>+   WAVEHDR pointer into a queue.
>    The function read() blocks (polled, sigh) until at least one good buffer
>    has arrived, then the data is copied into the buffer provided to read().
>    After a buffer has been fully used by read(), it is queued again
>@@ -760,18 +701,14 @@ fhandler_dev_dsp::Audio_out::parsewav (c
>    The function read() iterates until all data requested has been
>    received, there is no way to interrupt it */
>
>-fhandler_dev_dsp::Audio_in::Audio_in () : Audio ()
>-{
>-  bigwavebuffer_ = NULL;
>-  Qisr2app_ = new queue (MAX_BLOCKS);
>-  Qapp2app_ = new queue (MAX_BLOCKS);
>-}
>-
>-fhandler_dev_dsp::Audio_in::~Audio_in ()
>+void
>+fhandler_dev_dsp::Audio_in::fork_fixup (HANDLE parent)
> {
>-  stop ();
>-  delete Qapp2app_;
>-  delete Qisr2app_;
>+  /* Null dev_.
>+     It will be necessary to reset the queue, open the device
>+     and create a lock when reading */
>+  debug_printf ("parent=0x%08x", parent);
>+  dev_ = NULL;
> }
>
> bool
>@@ -782,8 +719,7 @@ fhandler_dev_dsp::Audio_in::query (int r
>
>   fillFormat (&format, rate, bits, channels);
>   rc = waveInOpen (NULL, WAVE_MAPPER, &format, 0L, 0L, WAVE_FORMAT_QUERY);
>-  debug_printf ("freq=%d bits=%d channels=%d %s", rate, bits, channels,
>-		(rc != MMSYSERR_NOERROR) ? "FAIL" : "OK");
>+  debug_printf ("%d = waveInOpen (freq=%d bits=%d channels=%d)", rc, rate, bits, channels);
>   return (rc == MMSYSERR_NOERROR);
> }
>
>@@ -793,31 +729,27 @@ fhandler_dev_dsp::Audio_in::start (int r
>   WAVEFORMATEX format;
>   MMRESULT rc;
>   unsigned bSize = blockSize (rate, bits, channels);
>-  bigwavebuffer_ = new char[MAX_BLOCKS * bSize];
>-  if (bigwavebuffer_ == NULL)
>-    return false;
>
>-  int nDevices = waveInGetNumDevs ();
>-  debug_printf ("number devices=%d, blocksize=%d", nDevices, bSize);
>-  if (nDevices <= 0)
>+  if (dev_)
>+    return true;
>+
>+  /* In case of fork bigwavebuffer may already exist */
>+  if (!bigwavebuffer_)
>+    bigwavebuffer_ = new char[MAX_BLOCKS * bSize];
>+
>+  if (!isvalid ())
>     return false;
>
>   fillFormat (&format, rate, bits, channels);
>   rc = waveInOpen (&dev_, WAVE_MAPPER, &format, (DWORD) waveIn_callback,
> 		   (DWORD) this, CALLBACK_FUNCTION);
>+  debug_printf ("%d = waveInOpen (rate=%d bits=%d channels=%d)", rc, rate, bits, channels);
>+
>   if (rc == MMSYSERR_NOERROR)
>     {
>-      setOwner ();
>       if (!init (bSize))
>-	{
>-	  stop ();
>-	  return false;
>-	}
>+	return false;
>     }
>-
>-  debug_printf ("freq=%d bits=%d channels=%d %s", rate, bits, channels,
>-		(rc != MMSYSERR_NOERROR) ? "FAIL" : "OK");
>-
>   return (rc == MMSYSERR_NOERROR);
> }
>
>@@ -826,45 +758,27 @@ fhandler_dev_dsp::Audio_in::stop ()
> {
>   MMRESULT rc;
>   WAVEHDR *pHdr;
>-  bool gotblock;
>
>-  debug_printf ("dev_=%08x pid=%d owner=%d", (int)dev_,
>-		GetCurrentProcessId (), getOwner ());
>-  if (getOwner () && !denyAccess ())
>+  debug_printf ("dev_=%08x", (int)dev_);
>+  if (dev_)
>     {
>-      rc = waveInReset (dev_);
>       /* Note that waveInReset calls our callback for all incomplete buffers.
> 	 Since all the win32 wave functions appear to use a common lock,
> 	 we must not call into the wave API from the callback.
> 	 Otherwise we end up in a deadlock. */
>-      debug_printf ("waveInReset rc=%d", rc);
>+      rc = waveInReset (dev_);
>+      debug_printf ("%d = waveInReset ()", rc);
>
>-      do
>+      while (Qisr2app_->recv (&pHdr))
> 	{
>-	  lock ();
>-	  gotblock = Qisr2app_->recv (&pHdr);
>-	  unlock ();
>-	  if (gotblock)
>-	    {
>-	      rc = waveInUnprepareHeader (dev_, pHdr, sizeof (WAVEHDR));
>-	      debug_printf ("waveInUnprepareHeader Block 0x%08x %s", pHdr,
>-			    (rc != MMSYSERR_NOERROR) ? "FAIL" : "OK");
>-	    }
>+	  rc = waveInUnprepareHeader (dev_, pHdr, sizeof (WAVEHDR));
>+	  debug_printf ("%d = waveInUnprepareHeader (0x%08x)", rc, pHdr);
> 	}
>-      while (gotblock);
>-      while (Qapp2app_->recv (&pHdr))
>-	/* flush queue */;
>
>       rc = waveInClose (dev_);
>-      debug_printf ("waveInClose rc=%d", rc);
>+      debug_printf ("%d = waveInClose ()", rc);
>
>-      clearOwner ();
>-    }
>-
>-  if (bigwavebuffer_)
>-    {
>-      delete[] bigwavebuffer_;
>-      bigwavebuffer_ = NULL;
>+      Qisr2app_->dellock ();
>     }
> }
>
>@@ -872,13 +786,21 @@ bool
> fhandler_dev_dsp::Audio_in::queueblock (WAVEHDR *pHdr)
> {
>   MMRESULT rc;
>-  pHdr->dwFlags = 0;
>   rc = waveInPrepareHeader (dev_, pHdr, sizeof (WAVEHDR));
>+  debug_printf ("%d = waveInPrepareHeader (0x%08x)", rc, pHdr);
>   if (rc == MMSYSERR_NOERROR)
>-    rc = waveInAddBuffer (dev_, pHdr, sizeof (WAVEHDR));
>-  debug_printf ("waveInAddBuffer Block 0x%08x %s", pHdr,
>-		(rc != MMSYSERR_NOERROR) ? "FAIL" : "OK");
>-  return (rc == MMSYSERR_NOERROR);
>+    {
>+      rc = waveInAddBuffer (dev_, pHdr, sizeof (WAVEHDR));
>+      debug_printf ("%d = waveInAddBuffer (0x%08x)", rc, pHdr);
>+    }
>+  if (rc == MMSYSERR_NOERROR)
>+    return true;
>+
>+  /* FIXME: Should the calling function return an error instead ?*/
>+  pHdr->dwFlags = 0;  /* avoid calling UnprepareHeader again */
>+  pHdr->dwBytesRecorded = 0;  /* no data will have been read */
>+  Qisr2app_->send (pHdr);
>+  return false;
> }
>
> bool
>@@ -888,17 +810,18 @@ fhandler_dev_dsp::Audio_in::init (unsign
>   int i;
>
>   // try to queue all of our buffer for reception
>+  Qisr2app_->reset ();
>   for (i = 0; i < MAX_BLOCKS; i++)
>     {
>       wavehdr_[i].lpData = &bigwavebuffer_[i * blockSize];
>       wavehdr_[i].dwBufferLength = blockSize;
>+      wavehdr_[i].dwFlags = 0;
>       if (!queueblock (&wavehdr_[i]))
> 	break;
>     }
>   pHdr_ = NULL;
>   rc = waveInStart (dev_);
>-  debug_printf ("waveInStart=%d %s queued=%d",
>-		rc, (rc != MMSYSERR_NOERROR) ? "FAIL" : "OK", i);
>+  debug_printf ("%d = waveInStart (), queued=%d", rc, i);
>   return (rc == MMSYSERR_NOERROR);
> }
>
>@@ -947,29 +870,21 @@ void
> fhandler_dev_dsp::Audio_in::waitfordata ()
> {
>   WAVEHDR *pHdr;
>-  bool gotblock;
>   MMRESULT rc;
>
>   if (pHdr_ != NULL)
>     return;
>-  while (Qapp2app_->recv (&pHdr) == false)
>+  while (!Qisr2app_->recv (&pHdr))
>     {
>-      lock ();
>-      gotblock = Qisr2app_->recv (&pHdr);
>-      unlock ();
>-      if (gotblock)
>-	{
>-	  rc = waveInUnprepareHeader (dev_, pHdr, sizeof (WAVEHDR));
>-	  if (rc == MMSYSERR_NOERROR)
>-	    Qapp2app_->send (pHdr);
>-	  else
>-	    debug_printf ("error UnprepareHeader 0x%08x", pHdr);
>-	}
>-      else
>-	{
>-	  debug_printf ("100ms");
>-	  Sleep (100);
>-	}
>+      debug_printf ("100ms");
>+      Sleep (100);
>+    }
>+  if (pHdr->dwFlags) /* Zero if queued following error in queueblock */
>+    {
>+      /* Errors are ignored here. They will probbaly cause a failure
>+         in the subsequent PrepareHeader */
>+      rc = waveInUnprepareHeader (dev_, pHdr, sizeof (WAVEHDR));
>+      debug_printf ("%d = waveInUnprepareHeader (0x%08x)", rc, pHdr);
>     }
>   pHdr_ = pHdr;
>   bufferIndex_ = 0;
>@@ -981,12 +896,9 @@ fhandler_dev_dsp::Audio_in::buf_info (au
> {
>   p->fragstotal = MAX_BLOCKS;
>   p->fragsize = blockSize (rate, bits, channels);
>-  if (getOwner ())
>+  if (this && dev_)
>     {
>-      lock ();
>       p->fragments = Qisr2app_->query ();
>-      unlock ();
>-      p->fragments += Qapp2app_->query ();
>       if (pHdr_ != NULL)
> 	p->bytes = pHdr_->dwBytesRecorded - bufferIndex_
> 	  + p->fragsize * p->fragments;
>@@ -1000,13 +912,10 @@ fhandler_dev_dsp::Audio_in::buf_info (au
>     }
> }
>
>-// This is called on an interrupt so use locking..
>-void
>+inline void
> fhandler_dev_dsp::Audio_in::callback_blockfull (WAVEHDR *pHdr)
> {
>-  lock ();
>   Qisr2app_->send (pHdr);
>-  unlock ();
> }
>
> static void CALLBACK
>@@ -1024,10 +933,7 @@ waveIn_callback (HWAVEIN hWave, UINT msg
>
> /* ------------------------------------------------------------------------
>    /dev/dsp handler
>-   ------------------------------------------------------------------------
>-   instances of the handler statics */
>-int fhandler_dev_dsp::open_count = 0;
>-
>+   ------------------------------------------------------------------------ */
> fhandler_dev_dsp::fhandler_dev_dsp ():
>   fhandler_base ()
> {
>@@ -1036,21 +942,16 @@ fhandler_dev_dsp::fhandler_dev_dsp ():
>   audio_out_ = NULL;
> }
>
>-fhandler_dev_dsp::~fhandler_dev_dsp ()
>-{
>-  close ();
>-  debug_printf ("0x%08x end", (int)this);
>-}
>-
> int
> fhandler_dev_dsp::open (int flags, mode_t mode)
> {
>-  open_count++;
>-  if (open_count > 1)
>+  if (cygheap->fdtab.find_archetype (pc.dev))
>     {
>       set_errno (EBUSY);
>       return 0;
>     }
>+  int err = 0;
>+  UINT num_in = 0, num_out = 0;
>   set_flags ((flags & ~O_TEXT) | O_BINARY);
>   // Work out initial sample format & frequency, /dev/dsp defaults
>   audioformat_ = AFMT_U8;
>@@ -1059,102 +960,84 @@ fhandler_dev_dsp::open (int flags, mode_
>   audiochannels_ = 1;
>   switch (flags & O_ACCMODE)
>     {
>+    case O_RDWR:
>+      if ((num_in = waveInGetNumDevs ()) == 0)
>+	err = ENXIO;
>+      /* Fall through */
>     case O_WRONLY:
>-      audio_out_ = new Audio_out;
>-      if (!audio_out_->query (audiofreq_, audiobits_, audiochannels_))
>-	{
>-	  delete audio_out_;
>-	  audio_out_ = NULL;
>-	}
>+      if ((num_out = waveOutGetNumDevs ()) == 0)
>+	err = ENXIO;
>       break;
>     case O_RDONLY:
>-      audio_in_ = new Audio_in;
>-      if (!audio_in_->query (audiofreq_, audiobits_, audiochannels_))
>-	{
>-	  delete audio_in_;
>-	  audio_in_ = NULL;
>-	}
>-      break;
>-    case O_RDWR:
>-      audio_out_ = new Audio_out;
>-      if (audio_out_->query (audiofreq_, audiobits_, audiochannels_))
>-	{
>-	  audio_in_ = new Audio_in;
>-	  if (!audio_in_->query (audiofreq_, audiobits_, audiochannels_))
>-	    {
>-	      delete audio_in_;
>-	      audio_in_ = NULL;
>-	      audio_out_->stop ();
>-	      delete audio_out_;
>-	      audio_out_ = NULL;
>-	    }
>-	}
>-      else
>-	{
>-	  delete audio_out_;
>-	  audio_out_ = NULL;
>-	}
>+      if ((num_in = waveInGetNumDevs ()) == 0)
>+	err = ENXIO;
>       break;
>     default:
>-      set_errno (EINVAL);
>-      return 0;
>-    } // switch (flags & O_ACCMODE)
>-  int rc;
>-  if (audio_in_ || audio_out_)
>-    { /* All tried query () succeeded */
>-      rc = 1;
>+      err = EINVAL;
>+    }
>+
>+  if (!err)
>+    {
>       set_open_status ();
>       need_fork_fixup (true);
>-      close_on_exec (true);
>+      nohandle (true);
>+
>+      // FIXME: Do this better someday
>+      fhandler_dev_dsp *arch = (fhandler_dev_dsp *) cmalloc (HEAP_ARCHETYPES, sizeof (*this));
>+      archetype = arch;
>+      *((fhandler_dev_dsp **) cygheap->fdtab.add_archetype ()) = arch;
>+      *arch = *this;
>+      archetype->usecount = 1;
>     }
>   else
>-    { /* One of the tried query () failed */
>-      rc = 0;
>-      set_errno (EIO);
>-    }
>-  debug_printf ("ACCMODE=0x%08x audio_in=%08x audio_out=%08x, rc=%d",
>-		flags & O_ACCMODE, (int)audio_in_, (int)audio_out_, rc);
>-  return rc;
>+    set_errno (err);
>+
>+  debug_printf ("ACCMODE=0x%08x audio_in=%d audio_out=%d, err=%d",
>+		flags & O_ACCMODE, num_in, num_out, err);
>+  return !err;
> }
>
>-#define RETURN_ERROR_WHEN_BUSY(audio)\
>-  if ((audio)->denyAccess ())    \
>-    {\
>-      set_errno (EBUSY);\
>-      return -1;\
>-    }
>+#define IS_WRITE() ((get_flags() & O_ACCMODE) != O_RDONLY)
>+#define IS_READ() ((get_flags() & O_ACCMODE) != O_WRONLY)
>
> int
> fhandler_dev_dsp::write (const void *ptr, size_t len)
> {
>+  debug_printf ("ptr=%08x len=%d", ptr, len);
>+  if ((fhandler_dev_dsp *) archetype != this)
>+    return ((fhandler_dev_dsp *)archetype)->write(ptr, len);
>+
>   int len_s = len;
>   const char *ptr_s = static_cast <const char *> (ptr);
>
>-  debug_printf ("ptr=%08x len=%d", ptr, len);
>   if (!audio_out_)
>+    if (IS_WRITE ())
>+      {
>+	debug_printf ("Allocating");
>+	if (!(audio_out_ = new Audio_out))
>+	  return -1;
>+
>+	/* check for wave file & get parameters & skip header if possible. */
>+
>+	if (audio_out_->parsewav (ptr_s, len_s,
>+				  audiofreq_, audiobits_, audiochannels_))
>+	  debug_printf ("=> ptr_s=%08x len_s=%d", ptr_s, len_s);
>+      }
>+    else
>+      {
>+	set_errno (EBADF); // device was opened for read?
>+	return -1;
>+      }
>+
>+  /* Open audio device properly with callbacks.
>+     Private parameters were set in call to parsewav.
>+     This is a no-op when there are successive writes in the same process */
>+  if (!audio_out_->start ())
>     {
>-      set_errno (EACCES); // device was opened for read?
>+      set_errno (EIO);
>       return -1;
>     }
>-  RETURN_ERROR_WHEN_BUSY (audio_out_);
>-  if (audio_out_->getOwner () == 0L)
>-    { // No owner yet, lets do it
>-      // check for wave file & get parameters & skip header if possible.
>-      if (audio_out_->parsewav (ptr_s, len_s,
>-				audiofreq_, audiobits_, audiochannels_))
>-	{ // update our format conversion
>-	  debug_printf ("=> ptr_s=%08x len_s=%d", ptr_s, len_s);
>-	  audioformat_ = ((audiobits_ == 8) ? AFMT_U8 : AFMT_S16_LE);
>-	  audio_out_->setformat (audioformat_);
>-	}
>-      // Open audio device properly with callbacks.
>-      if (!audio_out_->start (audiofreq_, audiobits_, audiochannels_))
>-	{
>-	  set_errno (EIO);
>-	  return -1;
>-	}
>-    }
>-
>+
>   audio_out_->write (ptr_s, len_s);
>   return len;
> }
>@@ -1163,28 +1046,36 @@ void __stdcall
> fhandler_dev_dsp::read (void *ptr, size_t& len)
> {
>   debug_printf ("ptr=%08x len=%d", ptr, len);
>+  if ((fhandler_dev_dsp *) archetype != this)
>+    return ((fhandler_dev_dsp *)archetype)->read(ptr, len);
>+
>   if (!audio_in_)
>+    if (IS_READ ())
>+      {
>+	debug_printf ("Allocating");
>+	if (!(audio_in_ = new Audio_in))
>+	  {
>+	    len = (size_t)-1;
>+	    return;
>+	  }
>+	audio_in_->setconvert (audioformat_);
>+      }
>+    else
>+      {
>+	len = (size_t)-1;
>+	set_errno (EBADF); // device was opened for write?
>+	return;
>+      }
>+
>+  /* Open audio device properly with callbacks.
>+     This is a noop when there are successive reads in the same process */
>+  if (!audio_in_->start (audiofreq_, audiobits_, audiochannels_))
>     {
>       len = (size_t)-1;
>-      set_errno (EACCES); // device was opened for write?
>-      return;
>-    }
>-  if (audio_in_->denyAccess ())
>-    {
>-      len = (size_t)-1;
>-      set_errno (EBUSY);
>+      set_errno (EIO);
>       return;
>     }
>-  if (audio_in_->getOwner () == 0L)
>-    { // No owner yet. Let's take it
>-      // Open audio device properly with callbacks.
>-      if (!audio_in_->start (audiofreq_, audiobits_, audiochannels_))
>-	{
>-	  len = (size_t)-1;
>-	  set_errno (EIO);
>-	  return;
>-	}
>-    }
>+
>   audio_in_->read ((char *)ptr, (int&)len);
>   return;
> }
>@@ -1195,28 +1086,41 @@ fhandler_dev_dsp::lseek (_off64_t offset
>   return 0;
> }
>
>-int
>-fhandler_dev_dsp::close (void)
>+void
>+fhandler_dev_dsp::close_audio_in ()
> {
>-  debug_printf ("audio_in=%08x audio_out=%08x",
>-		(int)audio_in_, (int)audio_out_);
>   if (audio_in_)
>     {
>+      audio_in_->stop ();
>       delete audio_in_;
>       audio_in_ = NULL;
>     }
>+}
>+
>+void
>+fhandler_dev_dsp::close_audio_out (bool immediately)
>+{
>   if (audio_out_)
>     {
>-      if (exit_state != ES_NOT_EXITING)
>-       { // emergency close due to call to exit() or Ctrl-C:
>-	 // do not wait for all pending audio to be played
>-	 audio_out_->stop (true);
>-       }
>+      audio_out_->stop (immediately);
>       delete audio_out_;
>       audio_out_ = NULL;
>     }
>-  if (open_count > 0)
>-    open_count--;
>+}
>+
>+int
>+fhandler_dev_dsp::close (void)
>+{
>+  debug_printf ("audio_in=%08x audio_out=%08x",
>+		(int)audio_in_, (int)audio_out_);
>+  if ((fhandler_dev_dsp *) archetype != this)
>+    return ((fhandler_dev_dsp *)archetype)->close ();
>+
>+  if (--usecount == 0)
>+    {
>+      close_audio_in ();
>+      close_audio_out (exit_state != ES_NOT_EXITING);
>+    }
>   return 0;
> }
>
>@@ -1224,55 +1128,45 @@ int
> fhandler_dev_dsp::dup (fhandler_base * child)
> {
>   debug_printf ("");
>-  fhandler_dev_dsp *fhc = (fhandler_dev_dsp *) child;
>-
>-  fhc->set_flags (get_flags ());
>-  fhc->audiochannels_ = audiochannels_;
>-  fhc->audiobits_ = audiobits_;
>-  fhc->audiofreq_ = audiofreq_;
>-  fhc->audioformat_ = audioformat_;
>+  child->archetype = archetype;
>+  archetype->usecount++;
>   return 0;
> }
>
> int
> fhandler_dev_dsp::ioctl (unsigned int cmd, void *ptr)
> {
>-  int *intptr = (int *) ptr;
>   debug_printf ("audio_in=%08x audio_out=%08x",
> 		(int)audio_in_, (int)audio_out_);
>+  if ((fhandler_dev_dsp *) archetype != this)
>+    return ((fhandler_dev_dsp *)archetype)->ioctl(cmd, ptr);
>+
>+  int *intptr = (int *) ptr;
>   switch (cmd)
>     {
> #define CASE(a) case a : debug_printf ("/dev/dsp: ioctl %s", #a);
>
>       CASE (SNDCTL_DSP_RESET)
>-	if (audio_out_)
>-	  {
>-	    RETURN_ERROR_WHEN_BUSY (audio_out_);
>-	    audio_out_->stop (true);
>-	  }
>-	if (audio_in_)
>-	  {
>-	    RETURN_ERROR_WHEN_BUSY (audio_in_);
>-	    audio_in_->stop ();
>-	  }
>-	return 0;
>+	close_audio_in ();
>+	close_audio_out (true);
>+        return 0;
> 	break;
>
>       CASE (SNDCTL_DSP_GETBLKSIZE)
>-	if (audio_out_)
>+	/* This is valid even if audio_X is NULL */
>+	if (IS_WRITE ())
> 	  {
> 	    *intptr = audio_out_->blockSize (audiofreq_,
> 					     audiobits_,
> 					     audiochannels_);
> 	  }
> 	else
>-	  { // I am very sure that audio_in_ is valid
>+	  { // I am very sure that IS_READ is valid
> 	    *intptr = audio_in_->blockSize (audiofreq_,
> 					    audiobits_,
> 					    audiochannels_);
> 	  }
> 	return 0;
>-	break;
>
>       CASE (SNDCTL_DSP_SETFMT)
>       {
>@@ -1296,11 +1190,9 @@ fhandler_dev_dsp::ioctl (unsigned int cm
> 	  default:
> 	    nBits = 0;
> 	  }
>-	if (nBits && audio_out_)
>+	if (nBits && IS_WRITE ())
> 	  {
>-	    RETURN_ERROR_WHEN_BUSY (audio_out_);
>-	    audio_out_->stop ();
>-	    audio_out_->setformat (*intptr);
>+	    close_audio_out ();
> 	    if (audio_out_->query (audiofreq_, nBits, audiochannels_))
> 	      {
> 		audiobits_ = nBits;
>@@ -1312,11 +1204,9 @@ fhandler_dev_dsp::ioctl (unsigned int cm
> 		return -1;
> 	      }
> 	  }
>-	if (nBits && audio_in_)
>+	if (nBits && IS_READ ())
> 	  {
>-	    RETURN_ERROR_WHEN_BUSY (audio_in_);
>-	    audio_in_->stop ();
>-	    audio_in_->setformat (*intptr);
>+	    close_audio_in ();
> 	    if (audio_in_->query (audiofreq_, nBits, audiochannels_))
> 	      {
> 		audiobits_ = nBits;
>@@ -1330,14 +1220,11 @@ fhandler_dev_dsp::ioctl (unsigned int cm
> 	  }
> 	return 0;
>       }
>-      break;
>
>       CASE (SNDCTL_DSP_SPEED)
>-      {
>-	if (audio_out_)
>+	if (IS_WRITE ())
> 	  {
>-	    RETURN_ERROR_WHEN_BUSY (audio_out_);
>-	    audio_out_->stop ();
>+	    close_audio_out ();
> 	    if (audio_out_->query (*intptr, audiobits_, audiochannels_))
> 	      audiofreq_ = *intptr;
> 	    else
>@@ -1346,10 +1233,9 @@ fhandler_dev_dsp::ioctl (unsigned int cm
> 		return -1;
> 	      }
> 	  }
>-	if (audio_in_)
>+	if (IS_READ ())
> 	  {
>-	    RETURN_ERROR_WHEN_BUSY (audio_in_);
>-	    audio_in_->stop ();
>+	    close_audio_in ();
> 	    if (audio_in_->query (*intptr, audiobits_, audiochannels_))
> 	      audiofreq_ = *intptr;
> 	    else
>@@ -1359,49 +1245,22 @@ fhandler_dev_dsp::ioctl (unsigned int cm
> 	      }
> 	  }
> 	return 0;
>-      }
>-      break;
>
>       CASE (SNDCTL_DSP_STEREO)
>       {
> 	int nChannels = *intptr + 1;
>-
>-	if (audio_out_)
>-	  {
>-	    RETURN_ERROR_WHEN_BUSY (audio_out_);
>-	    audio_out_->stop ();
>-	    if (audio_out_->query (audiofreq_, audiobits_, nChannels))
>-	      audiochannels_ = nChannels;
>-	    else
>-	      {
>-		*intptr = audiochannels_ - 1;
>-		return -1;
>-	      }
>-	  }
>-	if (audio_in_)
>-	  {
>-	    RETURN_ERROR_WHEN_BUSY (audio_in_);
>-	    audio_in_->stop ();
>-	    if (audio_in_->query (audiofreq_, audiobits_, nChannels))
>-	      audiochannels_ = nChannels;
>-	    else
>-	      {
>-		*intptr = audiochannels_ - 1;
>-		return -1;
>-	      }
>-	  }
>-	return 0;
>+	int res = ioctl (SNDCTL_DSP_CHANNELS, &nChannels);
>+	*intptr = nChannels - 1;
>+	return res;
>       }
>-      break;
>
>       CASE (SNDCTL_DSP_CHANNELS)
>       {
> 	int nChannels = *intptr;
>
>-	if (audio_out_)
>+	if (IS_WRITE ())
> 	  {
>-	    RETURN_ERROR_WHEN_BUSY (audio_out_);
>-	    audio_out_->stop ();
>+	    close_audio_out ();
> 	    if (audio_out_->query (audiofreq_, audiobits_, nChannels))
> 	      audiochannels_ = nChannels;
> 	    else
>@@ -1410,10 +1269,9 @@ fhandler_dev_dsp::ioctl (unsigned int cm
> 		return -1;
> 	      }
> 	  }
>-	if (audio_in_)
>+	if (IS_READ ())
> 	  {
>-	    RETURN_ERROR_WHEN_BUSY (audio_in_);
>-	    audio_in_->stop ();
>+	    close_audio_in ();
> 	    if (audio_in_->query (audiofreq_, audiobits_, nChannels))
> 	      audiochannels_ = nChannels;
> 	    else
>@@ -1424,76 +1282,55 @@ fhandler_dev_dsp::ioctl (unsigned int cm
> 	  }
> 	return 0;
>       }
>-      break;
>
>       CASE (SNDCTL_DSP_GETOSPACE)
>       {
>-	audio_buf_info *p = (audio_buf_info *) ptr;
>-	if (audio_out_)
>+	if (!IS_WRITE ())
> 	  {
>-	    RETURN_ERROR_WHEN_BUSY (audio_out_);
>-	    audio_out_->buf_info (p, audiofreq_, audiobits_, audiochannels_);
>-	    debug_printf ("ptr=%p frags=%d fragsize=%d bytes=%d",
>-			  ptr, p->fragments, p->fragsize, p->bytes);
>+	    set_errno(EBADF);
>+	    return -1;
> 	  }
>+	audio_buf_info *p = (audio_buf_info *) ptr;
>+	audio_out_->buf_info (p, audiofreq_, audiobits_, audiochannels_);
>+	debug_printf ("ptr=%p frags=%d fragsize=%d bytes=%d",
>+		      ptr, p->fragments, p->fragsize, p->bytes);
> 	return 0;
>       }
>-      break;
>
>       CASE (SNDCTL_DSP_GETISPACE)
>       {
>-	audio_buf_info *p = (audio_buf_info *) ptr;
>-	if (audio_in_)
>+	if (!IS_READ ())
> 	  {
>-	    RETURN_ERROR_WHEN_BUSY (audio_in_);
>-	    audio_in_->buf_info (p, audiofreq_, audiobits_, audiochannels_);
>-	    debug_printf ("ptr=%p frags=%d fragsize=%d bytes=%d",
>-			  ptr, p->fragments, p->fragsize, p->bytes);
>+	    set_errno(EBADF);
>+	    return -1;
> 	  }
>+	audio_buf_info *p = (audio_buf_info *) ptr;
>+	audio_in_->buf_info (p, audiofreq_, audiobits_, audiochannels_);
>+	debug_printf ("ptr=%p frags=%d fragsize=%d bytes=%d",
>+		      ptr, p->fragments, p->fragsize, p->bytes);
> 	return 0;
>       }
>-      break;
>
>       CASE (SNDCTL_DSP_SETFRAGMENT)
>-      {
> 	// Fake!! esound & mikmod require this on non PowerPC platforms.
> 	//
> 	return 0;
>-      }
>-      break;
>
>       CASE (SNDCTL_DSP_GETFMTS)
>-      {
> 	*intptr = AFMT_S16_LE | AFMT_U8; // only native formats returned here
> 	return 0;
>-      }
>-      break;
>
>       CASE (SNDCTL_DSP_GETCAPS)
>-      {
> 	*intptr = DSP_CAP_BATCH | DSP_CAP_DUPLEX;
> 	return 0;
>-      }
>-      break;
>
>       CASE (SNDCTL_DSP_POST)
>       CASE (SNDCTL_DSP_SYNC)
>-      {
>-	if (audio_out_)
>-	  {
>-	    // Stop audio out device
>-	    RETURN_ERROR_WHEN_BUSY (audio_out_);
>-	    audio_out_->stop ();
>-	  }
>-	if (audio_in_)
>-	  {
>-	    // Stop audio in device
>-	    RETURN_ERROR_WHEN_BUSY (audio_in_);
>-	    audio_in_->stop ();
>-	  }
>+	// Stop audio out device
>+	close_audio_out ();
>+        // Stop audio in device
>+        close_audio_in ();
> 	return 0;
>-      }
>-      break;
>
>     default:
>       debug_printf ("/dev/dsp: ioctl 0x%08x not handled yet! FIXME:", cmd);
>@@ -1516,7 +1353,10 @@ fhandler_dev_dsp::fixup_after_fork (HAND
> { // called from new child process
>   debug_printf ("audio_in=%08x audio_out=%08x",
> 		(int)audio_in_, (int)audio_out_);
>-  if (audio_in_ )
>+  if (archetype != this)
>+    return ((fhandler_dev_dsp *)archetype)->fixup_after_fork (parent);
>+
>+  if (audio_in_)
>     audio_in_ ->fork_fixup (parent);
>   if (audio_out_)
>     audio_out_->fork_fixup (parent);
>@@ -1527,6 +1367,9 @@ fhandler_dev_dsp::fixup_after_exec ()
> {
>   debug_printf ("audio_in=%08x audio_out=%08x",
> 		(int)audio_in_, (int)audio_out_);
>-}
>-
>+  if (archetype != this)
>+    return ((fhandler_dev_dsp *)archetype)->fixup_after_exec ();
>
>+  audio_in_ = NULL;
>+  audio_out_ = NULL;
>+}
