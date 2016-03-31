Return-Path: <cygwin-patches-return-8519-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 127255 invoked by alias); 31 Mar 2016 16:18:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 127240 invoked by uid 89); 31 Mar 2016 16:18:40 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=getpid, SIGCONT, pid_t, sigcont
X-HELO: mail-qg0-f54.google.com
Received: from mail-qg0-f54.google.com (HELO mail-qg0-f54.google.com) (209.85.192.54) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Thu, 31 Mar 2016 16:18:29 +0000
Received: by mail-qg0-f54.google.com with SMTP id j35so68991294qge.0        for <cygwin-patches@cygwin.com>; Thu, 31 Mar 2016 09:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:from:to:cc:subject:date:message-id;        bh=Krr7q1shM7qnHqTgQoQWEEFENKF35/YTHVVIH2qlY10=;        b=Y642wWz8R0eAF9+Dq6IxyVyI9GEufjPOYw/YL3N1UcD2Svwr2TtGpdmvr2HWwl0kY0         Qp17NOHBIn7zjVCkRZaqAMbtzI3bEbFMWn5FzGHNADlO6RPAGmlVIlVowQi8ryGf6giv         +LR4FRxPw0b659lfqtWSyPUXWZALTFzfQtZK6xOIkG4t/9Zy/UTtagOTTz27GOHOPvvO         QhxRI1rUyD/jjSk6YjdwSljJE/hD6hfsfSmp/0DmkUxFGrrpw63bfIv3fne09x1hq3Da         iSNdUJIwasJHQGAPPGfEVspl2K9D9Fp/vyMJGnNE0xeed5iGHpoD6/83pQw+xmklrbMB         EBeg==
X-Gm-Message-State: AD7BkJJQ87xGbvNls/9You8joJvGOVB+48RJ4kZO8zPoQguaK8/9NiJQRp1I+lWx/48fCw==
X-Received: by 10.140.167.137 with SMTP id n131mr17628437qhn.73.1459441107174;        Thu, 31 Mar 2016 09:18:27 -0700 (PDT)
Received: from bronx.local.pefoley.com (foleype-1-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:ee7::2])        by smtp.gmail.com with ESMTPSA id c7sm4199952qkb.38.2016.03.31.09.18.25        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);        Thu, 31 Mar 2016 09:18:26 -0700 (PDT)
From: Peter Foley <pefoley2@pefoley.com>
To: cygwin-patches@cygwin.com
Cc: Peter Foley <pefoley2@pefoley.com>
Subject: [PATCH v2] Refactor to avoid nonnull checks on "this" pointer.
Date: Thu, 31 Mar 2016 16:18:00 -0000
Message-Id: <1459441102-19941-1-git-send-email-pefoley2@pefoley.com>
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00225.txt.bz2

G++ 6.0 asserts that the "this" pointer is non-null for member functions.
Refactor methods that check if this is non-null to be static where
necessary, and remove the check where it is unnecessary.

winsup/cygwin/ChangeLog
external.cc (cygwin_internal): Call _pinfo::cmdline staticly
cygheap.h (fcwd_access_t::Free): Make static
fhandler_dsp.cc (Audio_in::buf_info): Ditto.
fhandler_dsp.cc (Audio_out::buf_info): Ditto.
pinfo.h (_pinfo::fd): Ditto.
pinfo.h (_pinfo::fds): Ditto.
pinfo.h (_pinfo::root): Ditto.
pinfo.h (_pinfo::cwd): Ditto.
pinfo.h (_pinfo::cmdline): Ditto.
pinfo.h (_pinfo::kill): Ditto.
pinfo.h (_pinfo::exists): Ditto.
pinfo.h (_pinfo::exists): Use __reg2, as a consequence of the added
argument.
pinfo.h (_pinfo::kill): Use __reg3, as a consequence of the added
argument.
fhandler_dsp.cc (Audio_out::buf_info): Refactor method to take object
explicity, rather then relying on potentially null "this" pointer.
fhandler_dsp.cc (Audio_in::buf_info): Ditto.
path.cc (fcwd_access_t::Free): Ditto.
pinfo.cc (_pinfo::exists): Ditto.
pinfo.cc (_pinfo::fd): Ditto.
pinfo.cc (_pinfo::fds): Ditto.
pinfo.cc (_pinfo::root): Ditto.
pinfo.cc (_pinfo::cwd): Ditto.
pinfo.cc (_pinfo::cmdline): Ditto.
signal.cc (_pinfo::kill): Ditto.
pinfo.cc (_pinfo::exists): Use __reg2, as a consequence of the added
argument.
signal.cc (_pinfo::kill): Use __reg3, as a consequence of the added
argument.
pinfo.cc (_pinfo::commune_request): remove non-null check on "this", as
this method is only called from pinfo.cc after null checks
pinfo.cc (_pinfo::pipe_fhandler): remove non-null check on "this", as
this method is only called from pipe.cc (fhandler_pipe::open) after a null check.
fhandler_dsp.cc (Audio_in::buf_info): Move blockSize call inside
conditional.
fhandler_dsp.cc (fhandler_dev_dsp::_ioctl): Call Audio_out::buf_info staticly.
fhandler_dsp.cc (fhandler_dev_dsp::_ioctl): Call Audio_in::buf_info staticly.
fhandler_process.cc (format_process_fd): Call _pinfo::fds staticly.
fhandler_process.cc (format_process_fd): Call _pinfo::fd staticly.
fhandler_process.cc (format_process_root): Call _pinfo::root staticly.
fhandler_process.cc (format_process_cwd): Call _pinfo::cwd staticly.
fhandler_process.cc (format_process_cmdline): Call _pinfo::cmdline staticly.
fhandler_termios.cc (tty_min::kill_pgrp): Call _pinfo::exists staticly.
fhandler_termios.cc (tty_min::is_orphaned_process_group): Call _pinfo::exists staticly.
signal.cc (kill0): Call _pinfo::kill staticly.
signal.cc (kill_pgrp): Call _pinfo::exists staticly.
signal.cc (kill_pgrp): Call _pinfo::kill staticly.
sigproc.cc (pid_exists): Call _pinfo::exists staticly.
sigproc.cc (remove_proc): Call _pinfo::exists staticly.
times.cc (clock_gettime): Call _pinfo::exists staticly.
times.cc (clock_getcpuclockid): Call _pinfo::exists staticly.

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---

I'm not 100% sure that the __reg1/2->__reg2/3 changes are necessary,
but i'm pretty confident about everything else.

 winsup/cygwin/cygheap.h           |  2 +-
 winsup/cygwin/external.cc         |  2 +-
 winsup/cygwin/fhandler_dsp.cc     | 36 ++++++++++++------------
 winsup/cygwin/fhandler_process.cc | 10 +++----
 winsup/cygwin/fhandler_termios.cc |  4 +--
 winsup/cygwin/path.cc             | 10 +++----
 winsup/cygwin/pinfo.cc            | 58 +++++++++++++++++++--------------------
 winsup/cygwin/pinfo.h             | 14 +++++-----
 winsup/cygwin/signal.cc           | 28 +++++++++----------
 winsup/cygwin/sigproc.cc          |  4 +--
 winsup/cygwin/times.cc            |  4 +--
 11 files changed, 87 insertions(+), 85 deletions(-)

diff --git a/winsup/cygwin/cygheap.h b/winsup/cygwin/cygheap.h
index c394e7f..75c27f0 100644
--- a/winsup/cygwin/cygheap.h
+++ b/winsup/cygwin/cygheap.h
@@ -281,7 +281,7 @@ class fcwd_access_t {
 
 public:
   void CopyPath (UNICODE_STRING &target);
-  void Free (PVOID heap);
+  static void Free (fcwd_access_t *cwd, PVOID heap);
   void FillIn (HANDLE dir, PUNICODE_STRING name, ULONG old_dismount_count);
   static void SetDirHandleFromBufferPointer (PWCHAR buf_p, HANDLE dir);
   static void SetVersionFromPointer (PBYTE buf_p, bool is_buffer);
diff --git a/winsup/cygwin/external.cc b/winsup/cygwin/external.cc
index 02335eb..8bcadc4 100644
--- a/winsup/cygwin/external.cc
+++ b/winsup/cygwin/external.cc
@@ -342,7 +342,7 @@ cygwin_internal (cygwin_getinfo_types t, ...)
 	  size_t n;
 	  pid_t pid = va_arg (arg, pid_t);
 	  pinfo p (pid);
-	  res = (uintptr_t) p->cmdline (n);
+	  res = (uintptr_t) _pinfo::cmdline (p, n);
 	}
 	break;
       case CW_CHECK_NTSEC:
diff --git a/winsup/cygwin/fhandler_dsp.cc b/winsup/cygwin/fhandler_dsp.cc
index 9fa2c6e..52d3e59 100644
--- a/winsup/cygwin/fhandler_dsp.cc
+++ b/winsup/cygwin/fhandler_dsp.cc
@@ -116,7 +116,7 @@ class fhandler_dev_dsp::Audio_out: public Audio
   bool start ();
   void stop (bool immediately = false);
   int write (const char *pSampleData, int nBytes);
-  void buf_info (audio_buf_info *p, int rate, int bits, int channels);
+  static void buf_info (Audio_out *dev, audio_buf_info *p, int rate, int bits, int channels);
   void callback_sampledone (WAVEHDR *pHdr);
   bool parsewav (const char *&pData, int &nBytes,
 		 int rate, int bits, int channels);
@@ -150,7 +150,7 @@ public:
   bool start (int rate, int bits, int channels);
   void stop ();
   bool read (char *pSampleData, int &nBytes);
-  void buf_info (audio_buf_info *p, int rate, int bits, int channels);
+  static void buf_info (Audio_in *dev, audio_buf_info *p, int rate, int bits, int channels);
   void callback_blockfull (WAVEHDR *pHdr);
 
 private:
@@ -498,25 +498,25 @@ fhandler_dev_dsp::Audio_out::write (const char *pSampleData, int nBytes)
 }
 
 void
-fhandler_dev_dsp::Audio_out::buf_info (audio_buf_info *p,
+fhandler_dev_dsp::Audio_out::buf_info (Audio_out *dev, audio_buf_info *p,
 				       int rate, int bits, int channels)
 {
   p->fragstotal = MAX_BLOCKS;
-  if (this && dev_)
+  if (dev && dev->dev_)
     {
       /* If the device is running we use the internal values,
 	 possibly set from the wave file. */
-      p->fragsize = blockSize (freq_, bits_, channels_);
-      p->fragments = Qisr2app_->query ();
-      if (pHdr_ != NULL)
-	p->bytes = (int)pHdr_->dwUser - bufferIndex_
+      p->fragsize = dev->blockSize (dev->freq_, dev->bits_, dev->channels_);
+      p->fragments = dev->Qisr2app_->query ();
+      if (dev->pHdr_)
+	p->bytes = (int)dev->pHdr_->dwUser - dev->bufferIndex_
 	  + p->fragsize * p->fragments;
       else
 	p->bytes = p->fragsize * p->fragments;
     }
   else
     {
-      p->fragsize = blockSize (rate, bits, channels);
+      p->fragsize = dev->blockSize (rate, bits, channels);
       p->fragments = MAX_BLOCKS;
       p->bytes = p->fragsize * p->fragments;
     }
@@ -954,16 +954,18 @@ fhandler_dev_dsp::Audio_in::waitfordata ()
 }
 
 void
-fhandler_dev_dsp::Audio_in::buf_info (audio_buf_info *p,
+fhandler_dev_dsp::Audio_in::buf_info (Audio_in *dev, audio_buf_info *p,
 				      int rate, int bits, int channels)
 {
   p->fragstotal = MAX_BLOCKS;
-  p->fragsize = blockSize (rate, bits, channels);
-  if (this && dev_)
+  if (dev && dev->dev_)
     {
-      p->fragments = Qisr2app_->query ();
-      if (pHdr_ != NULL)
-	p->bytes = pHdr_->dwBytesRecorded - bufferIndex_
+      /* If the device is running we use the internal values,
+         possibly set from the wave file. */
+      p->fragsize = dev->blockSize (rate, bits, channels);
+      p->fragments = dev->Qisr2app_->query ();
+      if (dev->pHdr_)
+	p->bytes = dev->pHdr_->dwBytesRecorded - dev->bufferIndex_
 	  + p->fragsize * p->fragments;
       else
 	p->bytes = p->fragsize * p->fragments;
@@ -1345,7 +1347,7 @@ fhandler_dev_dsp::_ioctl (unsigned int cmd, void *buf)
 	    return -1;
 	  }
 	audio_buf_info *p = (audio_buf_info *) buf;
-	audio_out_->buf_info (p, audiofreq_, audiobits_, audiochannels_);
+        Audio_out::buf_info (audio_out_, p, audiofreq_, audiobits_, audiochannels_);
 	debug_printf ("buf=%p frags=%d fragsize=%d bytes=%d",
 		      buf, p->fragments, p->fragsize, p->bytes);
 	return 0;
@@ -1359,7 +1361,7 @@ fhandler_dev_dsp::_ioctl (unsigned int cmd, void *buf)
 	    return -1;
 	  }
 	audio_buf_info *p = (audio_buf_info *) buf;
-	audio_in_->buf_info (p, audiofreq_, audiobits_, audiochannels_);
+        Audio_in::buf_info (audio_in_, p, audiofreq_, audiobits_, audiochannels_);
 	debug_printf ("buf=%p frags=%d fragsize=%d bytes=%d",
 		      buf, p->fragments, p->fragsize, p->bytes);
 	return 0;
diff --git a/winsup/cygwin/fhandler_process.cc b/winsup/cygwin/fhandler_process.cc
index f0423f3..94da7de 100644
--- a/winsup/cygwin/fhandler_process.cc
+++ b/winsup/cygwin/fhandler_process.cc
@@ -376,7 +376,7 @@ format_process_fd (void *data, char *&destbuf)
     {
       if (destbuf)
 	cfree (destbuf);
-      destbuf = p->fds (fs);
+      destbuf = _pinfo::fds (p, fs);
       *((process_fd_t *) data)->fd_type = virt_symlink;
     }
   else
@@ -392,7 +392,7 @@ format_process_fd (void *data, char *&destbuf)
 	  set_errno (ENOENT);
 	  return 0;
 	}
-      destbuf = p->fd (fd, fs);
+      destbuf = _pinfo::fd (p, fd, fs);
       if (!destbuf || !*destbuf)
 	{
 	  set_errno (ENOENT);
@@ -479,7 +479,7 @@ format_process_root (void *data, char *&destbuf)
       cfree (destbuf);
       destbuf = NULL;
     }
-  destbuf = p->root (fs);
+  destbuf = _pinfo::root (p, fs);
   if (!destbuf || !*destbuf)
     {
       destbuf = cstrdup ("<defunct>");
@@ -499,7 +499,7 @@ format_process_cwd (void *data, char *&destbuf)
       cfree (destbuf);
       destbuf = NULL;
     }
-  destbuf = p->cwd (fs);
+  destbuf = _pinfo::cwd (p, fs);
   if (!destbuf || !*destbuf)
     {
       destbuf = cstrdup ("<defunct>");
@@ -519,7 +519,7 @@ format_process_cmdline (void *data, char *&destbuf)
       cfree (destbuf);
       destbuf = NULL;
     }
-  destbuf = p->cmdline (fs);
+  destbuf = _pinfo::cmdline (p, fs);
   if (!destbuf || !*destbuf)
     {
       destbuf = cstrdup ("<defunct>");
diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_termios.cc
index 983e2f9..fc48795 100644
--- a/winsup/cygwin/fhandler_termios.cc
+++ b/winsup/cygwin/fhandler_termios.cc
@@ -134,7 +134,7 @@ tty_min::kill_pgrp (int sig)
   for (unsigned i = 0; i < pids.npids; i++)
     {
       _pinfo *p = pids[i];
-      if (!p->exists () || p->ctty != ntty || p->pgid != pgid)
+      if (!_pinfo::exists (p) || p->ctty != ntty || p->pgid != pgid)
 	continue;
       if (p == myself)
 	killself = sig != __SIGSETPGRP && !exit_state;
@@ -157,7 +157,7 @@ tty_min::is_orphaned_process_group (int pgid)
     {
       _pinfo *p = pids[i];
       termios_printf ("checking pid %d - has pgid %d\n", p->pid, p->pgid);
-      if (!p || !p->exists () || p->pgid != pgid)
+      if (!_pinfo::exists (p) || p->pgid != pgid)
 	continue;
       pinfo ppid (p->ppid);
       if (!ppid)
diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index 20391bf..1fa525c 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -3933,20 +3933,20 @@ fcwd_access_t::CopyPath (UNICODE_STRING &target)
 }
 
 void
-fcwd_access_t::Free (PVOID heap)
+fcwd_access_t::Free (fcwd_access_t *cwd, PVOID heap)
 {
   /* Decrement the reference count.  If it's down to 0, free
      structure from heap. */
-  if (this && InterlockedDecrement (&ReferenceCount ()) == 0)
+  if (cwd && InterlockedDecrement (&cwd->ReferenceCount ()) == 0)
     {
       /* In contrast to pre-Vista, the handle on init is always a
 	 fresh one and not the handle inherited from the parent
 	 process.  So we always have to close it here.  However, the
 	 handle could be NULL, if we cd'ed into a virtual dir. */
-      HANDLE h = DirectoryHandle ();
+      HANDLE h = cwd->DirectoryHandle ();
       if (h)
 	NtClose (h);
-      RtlFreeHeap (heap, 0, this);
+      RtlFreeHeap (heap, 0, cwd);
     }
 }
 
@@ -4325,7 +4325,7 @@ cwdstuff::override_win32_cwd (bool init, ULONG old_dismount_count)
 	  f_cwd->CopyPath (upp_cwd_str);
 	  upp_cwd_hdl = dir;
 	  RtlLeaveCriticalSection (peb.FastPebLock);
-	  old_cwd->Free (heap);
+          fcwd_access_t::Free (old_cwd, heap);
 	}
       else
 	{
diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
index d4b2afb..d742129 100644
--- a/winsup/cygwin/pinfo.cc
+++ b/winsup/cygwin/pinfo.cc
@@ -511,10 +511,10 @@ _pinfo::set_ctty (fhandler_termios *fh, int flags)
 
 /* Test to determine if a process really exists and is processing signals.
  */
-bool __reg1
-_pinfo::exists ()
+bool __reg2
+_pinfo::exists (_pinfo *p)
 {
-  return this && process_state && !(process_state & (PID_EXITED | PID_REAPED | PID_EXECED));
+  return p && p->process_state && !(p->process_state & (PID_EXITED | PID_REAPED | PID_EXECED));
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
@@ -793,14 +793,14 @@ _pinfo::pipe_fhandler (int64_t unique_id, size_t &n)
 }
 
 char *
-_pinfo::fd (int fd, size_t &n)
+_pinfo::fd (_pinfo *p, int fd, size_t &n)
 {
   char *s;
-  if (!this || !pid)
+  if (!p || !p->pid)
     return NULL;
-  if (pid != myself->pid)
+  if (p->pid != myself->pid)
     {
-      commune_result cr = commune_request (PICOM_FD, fd);
+      commune_result cr = p->commune_request (PICOM_FD, fd);
       s = cr.s;
       n = cr.n;
     }
@@ -817,14 +817,14 @@ _pinfo::fd (int fd, size_t &n)
 }
 
 char *
-_pinfo::fds (size_t &n)
+_pinfo::fds (_pinfo *p, size_t &n)
 {
   char *s;
-  if (!this || !pid)
+  if (!p || !p->pid)
     return NULL;
-  if (pid != myself->pid)
+  if (p->pid != myself->pid)
     {
-      commune_result cr = commune_request (PICOM_FDS);
+      commune_result cr = p->commune_request (PICOM_FDS);
       s = cr.s;
       n = cr.n;
     }
@@ -845,14 +845,14 @@ _pinfo::fds (size_t &n)
 }
 
 char *
-_pinfo::root (size_t& n)
+_pinfo::root (_pinfo *p, size_t& n)
 {
   char *s;
-  if (!this || !pid)
+  if (!p || !p->pid)
     return NULL;
-  if (pid != myself->pid && !ISSTATE (this, PID_NOTCYGWIN))
+  if (p->pid != myself->pid && !ISSTATE (p, PID_NOTCYGWIN))
     {
-      commune_result cr = commune_request (PICOM_ROOT);
+      commune_result cr = p->commune_request (PICOM_ROOT);
       s = cr.s;
       n = cr.n;
     }
@@ -890,15 +890,15 @@ open_commune_proc_parms (DWORD pid, PRTL_USER_PROCESS_PARAMETERS prupp)
 }
 
 char *
-_pinfo::cwd (size_t& n)
+_pinfo::cwd (_pinfo *p, size_t& n)
 {
   char *s = NULL;
-  if (!this || !pid)
+  if (!p || !p->pid)
     return NULL;
-  if (ISSTATE (this, PID_NOTCYGWIN))
+  if (ISSTATE (p, PID_NOTCYGWIN))
     {
       RTL_USER_PROCESS_PARAMETERS rupp;
-      HANDLE proc = open_commune_proc_parms (dwProcessId, &rupp);
+      HANDLE proc = open_commune_proc_parms (p->dwProcessId, &rupp);
 
       n = 0;
       if (!proc)
@@ -920,9 +920,9 @@ _pinfo::cwd (size_t& n)
 	}
       NtClose (proc);
     }
-  else if (pid != myself->pid)
+  else if (p->pid != myself->pid)
     {
-      commune_result cr = commune_request (PICOM_CWD);
+      commune_result cr = p->commune_request (PICOM_CWD);
       s = cr.s;
       n = cr.n;
     }
@@ -936,15 +936,15 @@ _pinfo::cwd (size_t& n)
 }
 
 char *
-_pinfo::cmdline (size_t& n)
+_pinfo::cmdline (_pinfo *p, size_t& n)
 {
   char *s = NULL;
-  if (!this || !pid)
+  if (!p || !p->pid)
     return NULL;
-  if (ISSTATE (this, PID_NOTCYGWIN))
+  if (ISSTATE (p, PID_NOTCYGWIN))
     {
       RTL_USER_PROCESS_PARAMETERS rupp;
-      HANDLE proc = open_commune_proc_parms (dwProcessId, &rupp);
+      HANDLE proc = open_commune_proc_parms (p->dwProcessId, &rupp);
 
       n = 0;
       if (!proc)
@@ -972,9 +972,9 @@ _pinfo::cmdline (size_t& n)
 	}
       NtClose (proc);
     }
-  else if (pid != myself->pid)
+  else if (p->pid != myself->pid)
     {
-      commune_result cr = commune_request (PICOM_CMDLINE);
+      commune_result cr = p->commune_request (PICOM_CMDLINE);
       s = cr.s;
       n = cr.n;
     }
diff --git a/winsup/cygwin/pinfo.h b/winsup/cygwin/pinfo.h
index 65a9e89..4bdfb1c 100644
--- a/winsup/cygwin/pinfo.h
+++ b/winsup/cygwin/pinfo.h
@@ -104,16 +104,16 @@ public:
   commune_result commune_request (__uint32_t, ...);
   bool alive ();
   fhandler_pipe *pipe_fhandler (int64_t, size_t &);
-  char *fd (int fd, size_t &);
-  char *fds (size_t &);
-  char *root (size_t &);
-  char *cwd (size_t &);
-  char *cmdline (size_t &);
+  static char *fd (_pinfo *, int fd, size_t &);
+  static char *fds (_pinfo *, size_t &);
+  static char *root (_pinfo *, size_t &);
+  static char *cwd (_pinfo *, size_t &);
+  static char *cmdline (_pinfo *, size_t &);
   char *win_heap_info (size_t &);
   bool set_ctty (class fhandler_termios *, int);
   bool alert_parent (char);
-  int __reg2 kill (siginfo_t&);
-  bool __reg1 exists ();
+  static int __reg3 kill (_pinfo *, siginfo_t&);
+  static bool __reg2 exists (_pinfo *);
   const char *_ctty (char *);
 
   /* signals */
diff --git a/winsup/cygwin/signal.cc b/winsup/cygwin/signal.cc
index 8dfd4ab..a946410 100644
--- a/winsup/cygwin/signal.cc
+++ b/winsup/cygwin/signal.cc
@@ -231,8 +231,8 @@ handle_sigprocmask (int how, const sigset_t *set, sigset_t *oldset, sigset_t& op
   return 0;
 }
 
-int __reg2
-_pinfo::kill (siginfo_t& si)
+int __reg3
+_pinfo::kill (_pinfo *p, siginfo_t& si)
 {
   int res;
   DWORD this_process_state;
@@ -240,16 +240,16 @@ _pinfo::kill (siginfo_t& si)
 
   sig_dispatch_pending ();
 
-  if (exists ())
+  if (_pinfo::exists (p))
     {
       bool sendSIGCONT;
-      this_process_state = process_state;
+      this_process_state = p->process_state;
       if ((sendSIGCONT = (si.si_signo < 0)))
 	si.si_signo = -si.si_signo;
 
       if (si.si_signo == 0)
 	res = 0;
-      else if ((res = sig_send (this, si)))
+      else if ((res = sig_send (p, si)))
 	{
 	  sigproc_printf ("%d = sig_send, %E ", res);
 	  res = -1;
@@ -259,14 +259,14 @@ _pinfo::kill (siginfo_t& si)
 	  siginfo_t si2 = {0};
 	  si2.si_signo = SIGCONT;
 	  si2.si_code = SI_KERNEL;
-	  sig_send (this, si2);
+	  sig_send (p, si2);
 	}
-      this_pid = pid;
+      this_pid = p->pid;
     }
-  else if (si.si_signo == 0 && this && process_state == PID_EXITED)
+  else if (si.si_signo == 0 && p && p->process_state == PID_EXITED)
     {
-      this_process_state = process_state;
-      this_pid = pid;
+      this_process_state = p->process_state;
+      this_pid = p->pid;
       res = 0;
     }
   else
@@ -300,7 +300,7 @@ kill0 (pid_t pid, siginfo_t& si)
       return -1;
     }
 
-  return (pid > 0) ? pinfo (pid)->kill (si) : kill_pgrp (-pid, si);
+  return (pid > 0) ? _pinfo::kill (pinfo (pid), si) : kill_pgrp (-pid, si);
 }
 
 int
@@ -326,7 +326,7 @@ kill_pgrp (pid_t pid, siginfo_t& si)
     {
       _pinfo *p = pids[i];
 
-      if (!p->exists ())
+      if (!_pinfo::exists (p))
 	continue;
 
       /* Is it a process we want to kill?  */
@@ -338,12 +338,12 @@ kill_pgrp (pid_t pid, siginfo_t& si)
 		      p->__ctty (), myctty ());
       if (p == myself)
 	killself++;
-      else if (p->kill (si))
+      else if (_pinfo::kill (p, si))
 	res = -1;
       found++;
     }
 
-  if (killself && !exit_state && myself->kill (si))
+  if (killself && !exit_state && _pinfo::kill (myself, si))
     res = -1;
 
   if (!found)
diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 9810045..b149d78 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -155,7 +155,7 @@ proc_can_be_signalled (_pinfo *p)
 bool __reg1
 pid_exists (pid_t pid)
 {
-  return pinfo (pid)->exists ();
+  return _pinfo::exists (pinfo (pid));
 }
 
 /* Return true if this is one of our children, false otherwise.  */
@@ -1143,7 +1143,7 @@ remove_proc (int ci)
       if (_my_tls._ctinfo != procs[ci].wait_thread)
 	procs[ci].wait_thread->terminate_thread ();
     }
-  else if (procs[ci]->exists ())
+  else if (_pinfo::exists (procs[ci]))
     return true;
 
   sigproc_printf ("removing procs[%d], pid %d, nprocs %d", ci, procs[ci]->pid,
diff --git a/winsup/cygwin/times.cc b/winsup/cygwin/times.cc
index e5aab8c..5fe2b5e 100644
--- a/winsup/cygwin/times.cc
+++ b/winsup/cygwin/times.cc
@@ -542,7 +542,7 @@ clock_gettime (clockid_t clk_id, struct timespec *tp)
 	pid = getpid ();
 
       pinfo p (pid);
-      if (!p->exists ())
+      if (!_pinfo::exists (p))
 	{
 	  set_errno (EINVAL);
 	  return -1;
@@ -765,7 +765,7 @@ clock_setres (clockid_t clk_id, struct timespec *tp)
 extern "C" int
 clock_getcpuclockid (pid_t pid, clockid_t *clk_id)
 {
-  if (pid != 0 && !pinfo (pid)->exists ())
+  if (pid != 0 && !_pinfo::exists (pinfo (pid)))
     return (ESRCH);
   *clk_id = (clockid_t) PID_TO_CLOCKID (pid);
   return 0;
-- 
2.8.0
