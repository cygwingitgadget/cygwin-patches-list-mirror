From: "Andy Younger" <andylyounger@hotmail.com>
To: cygwin-patches@cygwin.com
Subject: Re: /dev/dsp
Date: Tue, 17 Apr 2001 00:42:00 -0000
Message-id: <F246ldMhxuwPQ0uWdTY00009100@hotmail.com>
X-SW-Source: 2001-q2/msg00094.html

Thanks, for looking into clearing up the soundcard.h problems, I was 
somewhat paranoid about this. Anyway,

The version in CVS, seems to work fine, I am currently listening to some 
MP3's under Esound & mpg123.

I have been real busy at my real work as of late :-(. So have not had time 
to do much with it. I have made a couple of small improvements, mostly to 
improve compatibility with some OSS apps, now Esound & Mikmod's sound 
drivers compile pretty much OOTB, (although there are some issues with with 
noise when using Esound's sockets it seems to work pretty well). Anyway here 
is my patch for the improvements.

Sorry about the use of machine/soundcard.h, I had a symbolic link for this, 
as it helps compiling BSD based source. sys/soundcard.h seems to be a linux 
thing.

Cheers,

Andy.

--

Mon Apr 16 23:20:00 2001  Andy Younger <andylyounger@hotmail.com>

    * fhandler_dsp.cc: Improved handling of 8 bit playback modes.
    Put in mock support for SNDCTL_DSP_SETFRAGMENT. This permits
    Esd & mikmod to compile out of the box.
--

diff -up src.original/winsup/cygwin/fhandler_dsp.cc 
src/winsup/cygwin/fhandler_dsp.cc
--- src.original/winsup/cygwin/fhandler_dsp.cc	Mon Apr 16 23:16:22 2001
+++ src/winsup/cygwin/fhandler_dsp.cc	Mon Apr 16 23:18:50 2001
@@ -28,7 +28,7 @@ static void CALLBACK wave_callback(HWAVE
class Audio
{
public:
-  enum { MAX_BLOCKS = 8, BLOCK_SIZE = 16384 };
+  enum { MAX_BLOCKS = 12, BLOCK_SIZE = 16384 };

   Audio ();
   ~Audio ();
@@ -40,7 +40,7 @@ public:
   bool write (const void *pSampleData, int nBytes);
   int blocks ();
   void callback_sampledone (void *pData);
-
+  void setformat(int format) { formattype_ = format; }
   int numbytesoutput ();

private:
@@ -55,6 +55,7 @@ private:
   int bufferIndex_;
   CRITICAL_SECTION lock_;
   char *freeblocks_[MAX_BLOCKS];
+  int formattype_;

   char bigwavebuffer_[MAX_BLOCKS * BLOCK_SIZE];
};
@@ -293,6 +294,17 @@ Audio::flush()
   // Send internal buffer out to the soundcard
   WAVEHDR *pHeader = ((WAVEHDR *)buffer_) - 1;
   pHeader->dwBufferLength = bufferIndex_;
+
+  // Quick bit of sample buffer conversion
+  if (formattype_ == AFMT_S8)
+    {
+      unsigned char *p = ((unsigned char *)buffer_);
+      for (int i = 0; i < bufferIndex_; i++)
+        {
+	  p[i] -= 0x7f;
+        }
+    }
+
   if (waveOutPrepareHeader(dev_, pHeader, sizeof(WAVEHDR)) == S_OK &&
       waveOutWrite(dev_, pHeader, sizeof (WAVEHDR)) == S_OK)
     {
@@ -513,10 +525,13 @@ fhandler_dev_dsp::ioctl(unsigned int cmd
	  int nBits = 0;
	  if (*intptr == AFMT_S16_LE)
	      nBits = 16;
+	  else if (*intptr == AFMT_U8)
+	      nBits = 8;
	  else if (*intptr == AFMT_S8)
	      nBits = 8;
	  if (nBits)
	    {
+	      s_audio.setformat(*intptr);
	      s_audio.close();
	      if (s_audio.open(audiofreq_, nBits, audiochannels_) == true)
		{
@@ -586,7 +601,14 @@ fhandler_dev_dsp::ioctl(unsigned int cmd

	  return 1;
	} break;
-
+
+      CASE(SNDCTL_DSP_SETFRAGMENT)
+        {
+	  // Fake!! esound & mikmod require this on non PowerPC platforms.
+	  //
+	  return 1;
+	} break;
+
       default:
	debug_printf("/dev/dsp: ioctl not handled yet! FIXME:\n");
	break;


_________________________________________________________________________
Get Your Private, Free E-mail from MSN Hotmail at http://www.hotmail.com .
