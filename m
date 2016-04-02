Return-Path: <cygwin-patches-return-8547-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31246 invoked by alias); 2 Apr 2016 15:36:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 31227 invoked by uid 89); 2 Apr 2016 15:36:35 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=330,7, prevista, 5047, 3427
X-HELO: mail-qg0-f44.google.com
Received: from mail-qg0-f44.google.com (HELO mail-qg0-f44.google.com) (209.85.192.44) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Sat, 02 Apr 2016 15:36:25 +0000
Received: by mail-qg0-f44.google.com with SMTP id n34so110722554qge.1        for <cygwin-patches@cygwin.com>; Sat, 02 Apr 2016 08:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:from:to:cc:subject:date:message-id;        bh=e7iyphb2oDTSIH7HKqFQg95fSZdIReMlgBjEJ15kTeo=;        b=Ixf3GnNnVU2ZSziEBvMYa7srGnXexhXnNL1JtVoaYi3gDvgkXdBi/9O13kOUwne3l8         AKjvYBSJ70hhS2WRlyRwD1pyzp9NRHoM0Bb5MPNj6cceFwNMlW664H3hh5y31iAAOcf/         2cmhDNLDT6d8yzCa4WU7xgGwqwAP1iaUjuqvdgSSJc9HeywBncYn1FWq7XpptpFwLTSp         l8ozPHcXxLrSFpoqtCWGm5NkliOMywdM0CSC81gesKZPuNzbVtJiCvtC7YsMFAvbisa3         kmDdzOzDDSTCH08+y34LYs4W2JFPrHVQkI0vz8ICaqNz/9gs7wMyX1gMAU//hwViGGlT         2qZQ==
X-Gm-Message-State: AD7BkJJDK99emI7Gp2gamy++U/fWI5/SneQ8MMeGxyjlL3RGzk/okMbfudE8brgO0c4YCg==
X-Received: by 10.140.19.98 with SMTP id 89mr705456qgg.71.1459611383120;        Sat, 02 Apr 2016 08:36:23 -0700 (PDT)
Received: from bronx.local.pefoley.com (foleype-1-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:ee7::2])        by smtp.gmail.com with ESMTPSA id b85sm8459038qhc.23.2016.04.02.08.36.22        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);        Sat, 02 Apr 2016 08:36:22 -0700 (PDT)
From: Peter Foley <pefoley2@pefoley.com>
To: cygwin-patches@cygwin.com
Cc: Peter Foley <pefoley2@pefoley.com>
Subject: [PATCH v3] Refactor to avoid nonnull checks on "this" pointer.
Date: Sat, 02 Apr 2016 15:36:00 -0000
Message-Id: <1459611378-25476-1-git-send-email-pefoley2@pefoley.com>
X-IsSubscribed: yes
X-SW-Source: 2016-q2/txt/msg00022.txt.bz2

G++ 6.0 asserts that the "this" pointer is non-null for member
functions.
Refactor methods that check if "this" is non-null to resolve this.

winsup/cygwin/ChangeLog:
external.cc (cygwin_internal): Check for a null pinfo before calling
cmdline.
fhandler_dsp.cc (Audio::blockSize): Make static.
fhandler_dsp.cc (Audio_in): add default_buf_info.
fhandler_dsp.cc (Audio_out): Ditto.
fhandler_dsp.cc (Audio_out::buf_info): Refactor method to call
default_buf_info if dev_ is null.
fhandler_dsp.cc (Audio_in::buf_info): Ditto.
fhandler_dsp.cc (fhandler_dev_dsp::_ioctl): Call Audio_out::default_buf_info if audio_out_ is null.
fhandler_dsp.cc (fhandler_dev_dsp::_ioctl): Call Audio_in::default_buf_info if audio_in_ is null.
fhandler_process.cc (format_process_fd): Check if pinfo is null.
fhandler_process.cc (format_process_root): Ditto.
fhandler_process.cc (format_process_cwd): Ditto.
fhandler_process.cc (format_process_cmdline): Ditto.
signal.cc (tty_min::kill_pgrp): Ditto.
signal.cc (_pinfo::kill0): Ditto.
sigproc.cc (pid_exists): Ditto.
sigproc.cc (remove_proc): Ditto.
times.cc (clock_gettime): Ditto.
times.cc (clock_getcpuclockid): Ditto.
path.cc (cwdstuff::override_win32_cwd): Check if old_cwd is null.
path.cc (fcwd_access_t::Free): Factor null check of "this" out to
caller(s).
pinfo.cc (_pinfo::exists): Ditto.
pinfo.cc (_pinfo::fd): Ditto.
pinfo.cc (_pinfo::fds): Ditto.
pinfo.cc (_pinfo::root): Ditto.
pinfo.cc (_pinfo::cwd): Ditto.
pinfo.cc (_pinfo::cmdline): Ditto.
signal.cc (_pinfo::kill): Ditto.
pinfo.cc (_pinfo::commune_request): remove non-null check on "this", as
this method is only called from pinfo.cc after null checks
pinfo.cc (_pinfo::pipe_fhandler): remove non-null check on "this", as
this method is only called from pipe.cc (fhandler_pipe::open) after a null check.

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 winsup/cygwin/external.cc         |  2 +-
 winsup/cygwin/fhandler_dsp.cc     | 55 ++++++++++++++++++++++++++++-----------
 winsup/cygwin/fhandler_process.cc | 11 +++++---
 winsup/cygwin/fhandler_termios.cc |  2 +-
 winsup/cygwin/path.cc             |  5 ++--
 winsup/cygwin/pinfo.cc            | 16 ++++++------
 winsup/cygwin/signal.cc           | 12 ++++++---
 winsup/cygwin/sigproc.cc          |  5 ++--
 winsup/cygwin/times.cc            |  5 ++--
 9 files changed, 75 insertions(+), 38 deletions(-)

diff --git a/winsup/cygwin/external.cc b/winsup/cygwin/external.cc
index 02335eb..603a8d7 100644
--- a/winsup/cygwin/external.cc
+++ b/winsup/cygwin/external.cc
@@ -342,7 +342,7 @@ cygwin_internal (cygwin_getinfo_types t, ...)
 	  size_t n;
 	  pid_t pid = va_arg (arg, pid_t);
 	  pinfo p (pid);
-	  res = (uintptr_t) p->cmdline (n);
+	  res = p ? (uintptr_t) p->cmdline (n) : 0;
 	}
 	break;
       case CW_CHECK_NTSEC:
diff --git a/winsup/cygwin/fhandler_dsp.cc b/winsup/cygwin/fhandler_dsp.cc
index 9fa2c6e..55944b4 100644
--- a/winsup/cygwin/fhandler_dsp.cc
+++ b/winsup/cygwin/fhandler_dsp.cc
@@ -65,7 +65,7 @@ class fhandler_dev_dsp::Audio
   void convert_S16LE_S16BE (unsigned char *buffer, int size_bytes);
   void fillFormat (WAVEFORMATEX * format,
 		   int rate, int bits, int channels);
-  unsigned blockSize (int rate, int bits, int channels);
+  static unsigned blockSize (int rate, int bits, int channels);
   void (fhandler_dev_dsp::Audio::*convert_)
     (unsigned char *buffer, int size_bytes);
 
@@ -117,6 +117,7 @@ class fhandler_dev_dsp::Audio_out: public Audio
   void stop (bool immediately = false);
   int write (const char *pSampleData, int nBytes);
   void buf_info (audio_buf_info *p, int rate, int bits, int channels);
+  static void default_buf_info (audio_buf_info *p, int rate, int bits, int channels);
   void callback_sampledone (WAVEHDR *pHdr);
   bool parsewav (const char *&pData, int &nBytes,
 		 int rate, int bits, int channels);
@@ -151,6 +152,7 @@ public:
   void stop ();
   bool read (char *pSampleData, int &nBytes);
   void buf_info (audio_buf_info *p, int rate, int bits, int channels);
+  static void default_buf_info (audio_buf_info *p, int rate, int bits, int channels);
   void callback_blockfull (WAVEHDR *pHdr);
 
 private:
@@ -501,11 +503,11 @@ void
 fhandler_dev_dsp::Audio_out::buf_info (audio_buf_info *p,
 				       int rate, int bits, int channels)
 {
-  p->fragstotal = MAX_BLOCKS;
-  if (this && dev_)
+  if (dev_)
     {
       /* If the device is running we use the internal values,
 	 possibly set from the wave file. */
+      p->fragstotal = MAX_BLOCKS;
       p->fragsize = blockSize (freq_, bits_, channels_);
       p->fragments = Qisr2app_->query ();
       if (pHdr_ != NULL)
@@ -516,10 +518,17 @@ fhandler_dev_dsp::Audio_out::buf_info (audio_buf_info *p,
     }
   else
     {
+      default_buf_info(p, rate, bits, channels);
+    }
+}
+
+void fhandler_dev_dsp::Audio_out::default_buf_info (audio_buf_info *p,
+                                                int rate, int bits, int channels)
+{
+      p->fragstotal = MAX_BLOCKS;
       p->fragsize = blockSize (rate, bits, channels);
       p->fragments = MAX_BLOCKS;
       p->bytes = p->fragsize * p->fragments;
-    }
 }
 
 /* This is called on an interupt so use locking.. Note Qisr2app_
@@ -953,14 +962,23 @@ fhandler_dev_dsp::Audio_in::waitfordata ()
   return true;
 }
 
+void fhandler_dev_dsp::Audio_in::default_buf_info (audio_buf_info *p,
+                                                int rate, int bits, int channels)
+{
+  p->fragstotal = MAX_BLOCKS;
+  p->fragsize = blockSize (rate, bits, channels);
+  p->fragments = 0;
+  p->bytes = 0;
+}
+
 void
 fhandler_dev_dsp::Audio_in::buf_info (audio_buf_info *p,
 				      int rate, int bits, int channels)
 {
-  p->fragstotal = MAX_BLOCKS;
-  p->fragsize = blockSize (rate, bits, channels);
-  if (this && dev_)
+  if (dev_)
     {
+      p->fragstotal = MAX_BLOCKS;
+      p->fragsize = blockSize (rate, bits, channels);
       p->fragments = Qisr2app_->query ();
       if (pHdr_ != NULL)
 	p->bytes = pHdr_->dwBytesRecorded - bufferIndex_
@@ -970,8 +988,7 @@ fhandler_dev_dsp::Audio_in::buf_info (audio_buf_info *p,
     }
   else
     {
-      p->fragments = 0;
-      p->bytes = 0;
+      default_buf_info(p, rate, bits, channels);
     }
 }
 
@@ -1345,9 +1362,13 @@ fhandler_dev_dsp::_ioctl (unsigned int cmd, void *buf)
 	    return -1;
 	  }
 	audio_buf_info *p = (audio_buf_info *) buf;
-	audio_out_->buf_info (p, audiofreq_, audiobits_, audiochannels_);
-	debug_printf ("buf=%p frags=%d fragsize=%d bytes=%d",
-		      buf, p->fragments, p->fragsize, p->bytes);
+        if (audio_out_) {
+            audio_out_->buf_info (p, audiofreq_, audiobits_, audiochannels_);
+        } else {
+            Audio_out::default_buf_info(p, audiofreq_, audiobits_, audiochannels_);
+        }
+        debug_printf ("buf=%p frags=%d fragsize=%d bytes=%d",
+                      buf, p->fragments, p->fragsize, p->bytes);
 	return 0;
       }
 
@@ -1359,9 +1380,13 @@ fhandler_dev_dsp::_ioctl (unsigned int cmd, void *buf)
 	    return -1;
 	  }
 	audio_buf_info *p = (audio_buf_info *) buf;
-	audio_in_->buf_info (p, audiofreq_, audiobits_, audiochannels_);
-	debug_printf ("buf=%p frags=%d fragsize=%d bytes=%d",
-		      buf, p->fragments, p->fragsize, p->bytes);
+        if (audio_in_) {
+            audio_in_->buf_info (p, audiofreq_, audiobits_, audiochannels_);
+        } else {
+            Audio_in::default_buf_info(p, audiofreq_, audiobits_, audiochannels_);
+        }
+        debug_printf ("buf=%p frags=%d fragsize=%d bytes=%d",
+                      buf, p->fragments, p->fragsize, p->bytes);
 	return 0;
       }
 
diff --git a/winsup/cygwin/fhandler_process.cc b/winsup/cygwin/fhandler_process.cc
index f0423f3..81f04c9 100644
--- a/winsup/cygwin/fhandler_process.cc
+++ b/winsup/cygwin/fhandler_process.cc
@@ -371,6 +371,11 @@ format_process_fd (void *data, char *&destbuf)
      case a trailing slash and more followup chars are allowed, provided the
      descriptor symlink points to a directory. */
   char *fdp = strchr (path, '/') + 3;
+  if (!p)
+    {
+      set_errno (ENOENT);
+      return 0;
+    }
   /* The "fd" directory itself? */
   if (fdp[0] =='\0' || (fdp[0] == '/' && fdp[1] == '\0'))
     {
@@ -479,7 +484,7 @@ format_process_root (void *data, char *&destbuf)
       cfree (destbuf);
       destbuf = NULL;
     }
-  destbuf = p->root (fs);
+  destbuf = p ? p->root (fs) : NULL;
   if (!destbuf || !*destbuf)
     {
       destbuf = cstrdup ("<defunct>");
@@ -499,7 +504,7 @@ format_process_cwd (void *data, char *&destbuf)
       cfree (destbuf);
       destbuf = NULL;
     }
-  destbuf = p->cwd (fs);
+  destbuf = p ? p->cwd (fs) : NULL;
   if (!destbuf || !*destbuf)
     {
       destbuf = cstrdup ("<defunct>");
@@ -519,7 +524,7 @@ format_process_cmdline (void *data, char *&destbuf)
       cfree (destbuf);
       destbuf = NULL;
     }
-  destbuf = p->cmdline (fs);
+  destbuf = p ? p->cmdline (fs) : NULL;
   if (!destbuf || !*destbuf)
     {
       destbuf = cstrdup ("<defunct>");
diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_termios.cc
index 983e2f9..7c20e78 100644
--- a/winsup/cygwin/fhandler_termios.cc
+++ b/winsup/cygwin/fhandler_termios.cc
@@ -134,7 +134,7 @@ tty_min::kill_pgrp (int sig)
   for (unsigned i = 0; i < pids.npids; i++)
     {
       _pinfo *p = pids[i];
-      if (!p->exists () || p->ctty != ntty || p->pgid != pgid)
+      if (!p || !p->exists () || p->ctty != ntty || p->pgid != pgid)
 	continue;
       if (p == myself)
 	killself = sig != __SIGSETPGRP && !exit_state;
diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index a839c0a..e48a2cd 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -3932,7 +3932,7 @@ fcwd_access_t::Free (PVOID heap)
 {
   /* Decrement the reference count.  If it's down to 0, free
      structure from heap. */
-  if (this && InterlockedDecrement (&ReferenceCount ()) == 0)
+  if (InterlockedDecrement (&ReferenceCount ()) == 0)
     {
       /* In contrast to pre-Vista, the handle on init is always a
 	 fresh one and not the handle inherited from the parent
@@ -4320,7 +4320,8 @@ cwdstuff::override_win32_cwd (bool init, ULONG old_dismount_count)
 	  f_cwd->CopyPath (upp_cwd_str);
 	  upp_cwd_hdl = dir;
 	  RtlLeaveCriticalSection (peb.FastPebLock);
-	  old_cwd->Free (heap);
+	  if (old_cwd)
+	    old_cwd->Free (heap);
 	}
       else
 	{
diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
index d4b2afb..e6ceba8 100644
--- a/winsup/cygwin/pinfo.cc
+++ b/winsup/cygwin/pinfo.cc
@@ -514,7 +514,7 @@ _pinfo::set_ctty (fhandler_termios *fh, int flags)
 bool __reg1
 _pinfo::exists ()
 {
-  return this && process_state && !(process_state & (PID_EXITED | PID_REAPED | PID_EXECED));
+  return process_state && !(process_state & (PID_EXITED | PID_REAPED | PID_EXECED));
 }
 
 bool
@@ -685,7 +685,7 @@ _pinfo::commune_request (__uint32_t code, ...)
   res.s = NULL;
   res.n = 0;
 
-  if (!this || !pid)
+  if (!pid)
     {
       set_errno (ESRCH);
       goto err;
@@ -783,7 +783,7 @@ out:
 fhandler_pipe *
 _pinfo::pipe_fhandler (int64_t unique_id, size_t &n)
 {
-  if (!this || !pid)
+  if (!pid)
     return NULL;
   if (pid == myself->pid)
     return NULL;
@@ -796,7 +796,7 @@ char *
 _pinfo::fd (int fd, size_t &n)
 {
   char *s;
-  if (!this || !pid)
+  if (!pid)
     return NULL;
   if (pid != myself->pid)
     {
@@ -820,7 +820,7 @@ char *
 _pinfo::fds (size_t &n)
 {
   char *s;
-  if (!this || !pid)
+  if (!pid)
     return NULL;
   if (pid != myself->pid)
     {
@@ -848,7 +848,7 @@ char *
 _pinfo::root (size_t& n)
 {
   char *s;
-  if (!this || !pid)
+  if (!pid)
     return NULL;
   if (pid != myself->pid && !ISSTATE (this, PID_NOTCYGWIN))
     {
@@ -893,7 +893,7 @@ char *
 _pinfo::cwd (size_t& n)
 {
   char *s = NULL;
-  if (!this || !pid)
+  if (!pid)
     return NULL;
   if (ISSTATE (this, PID_NOTCYGWIN))
     {
@@ -939,7 +939,7 @@ char *
 _pinfo::cmdline (size_t& n)
 {
   char *s = NULL;
-  if (!this || !pid)
+  if (!pid)
     return NULL;
   if (ISSTATE (this, PID_NOTCYGWIN))
     {
diff --git a/winsup/cygwin/signal.cc b/winsup/cygwin/signal.cc
index 8dfd4ab..dcb010b 100644
--- a/winsup/cygwin/signal.cc
+++ b/winsup/cygwin/signal.cc
@@ -263,7 +263,7 @@ _pinfo::kill (siginfo_t& si)
 	}
       this_pid = pid;
     }
-  else if (si.si_signo == 0 && this && process_state == PID_EXITED)
+  else if (si.si_signo == 0 && process_state == PID_EXITED)
     {
       this_process_state = process_state;
       this_pid = pid;
@@ -299,8 +299,12 @@ kill0 (pid_t pid, siginfo_t& si)
       syscall_printf ("signal %d out of range", si.si_signo);
       return -1;
     }
-
-  return (pid > 0) ? pinfo (pid)->kill (si) : kill_pgrp (-pid, si);
+  if (pid > 0) {
+      pinfo p(pid);
+      return p && p->kill(si);
+  } else {
+      return kill_pgrp(-pid, si);
+  }
 }
 
 int
@@ -326,7 +330,7 @@ kill_pgrp (pid_t pid, siginfo_t& si)
     {
       _pinfo *p = pids[i];
 
-      if (!p->exists ())
+      if (!p || !p->exists ())
 	continue;
 
       /* Is it a process we want to kill?  */
diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 9810045..32beb34 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -155,7 +155,8 @@ proc_can_be_signalled (_pinfo *p)
 bool __reg1
 pid_exists (pid_t pid)
 {
-  return pinfo (pid)->exists ();
+  pinfo p(pid);
+  return p && p->exists ();
 }
 
 /* Return true if this is one of our children, false otherwise.  */
@@ -1143,7 +1144,7 @@ remove_proc (int ci)
       if (_my_tls._ctinfo != procs[ci].wait_thread)
 	procs[ci].wait_thread->terminate_thread ();
     }
-  else if (procs[ci]->exists ())
+  else if (procs[ci] && procs[ci]->exists ())
     return true;
 
   sigproc_printf ("removing procs[%d], pid %d, nprocs %d", ci, procs[ci]->pid,
diff --git a/winsup/cygwin/times.cc b/winsup/cygwin/times.cc
index e5aab8c..29c090e 100644
--- a/winsup/cygwin/times.cc
+++ b/winsup/cygwin/times.cc
@@ -542,7 +542,7 @@ clock_gettime (clockid_t clk_id, struct timespec *tp)
 	pid = getpid ();
 
       pinfo p (pid);
-      if (!p->exists ())
+      if (!p || !p->exists ())
 	{
 	  set_errno (EINVAL);
 	  return -1;
@@ -765,7 +765,8 @@ clock_setres (clockid_t clk_id, struct timespec *tp)
 extern "C" int
 clock_getcpuclockid (pid_t pid, clockid_t *clk_id)
 {
-  if (pid != 0 && !pinfo (pid)->exists ())
+  pinfo p(pid);
+  if (pid != 0 && (!p || !p->exists ()))
     return (ESRCH);
   *clk_id = (clockid_t) PID_TO_CLOCKID (pid);
   return 0;
-- 
2.8.0
