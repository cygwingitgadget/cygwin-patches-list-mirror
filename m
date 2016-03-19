Return-Path: <cygwin-patches-return-8422-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 64061 invoked by alias); 19 Mar 2016 17:46:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 63735 invoked by uid 89); 19 Mar 2016 17:46:21 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=channels, !this, fds, 7967
X-HELO: mail-qg0-f68.google.com
Received: from mail-qg0-f68.google.com (HELO mail-qg0-f68.google.com) (209.85.192.68) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Sat, 19 Mar 2016 17:46:18 +0000
Received: by mail-qg0-f68.google.com with SMTP id y89so9897005qge.0        for <cygwin-patches@cygwin.com>; Sat, 19 Mar 2016 10:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to         :references;        bh=8UsNEfUDCe3tKSa8RWbd5LAvtcX1+YlvunM4aip+6YQ=;        b=WHzlFYzAB69EFWOIu/Pf+OLWVqmMIHvyceb5ZuxBB1pWRNgXRaP+00Kb92NwjvGXLV         9p9VPkOZXOAvxn5muz62HsXyWvR2qh0e68tbdH39h8dRlIV17L8wFCuY7IY1GVlvwXZh         hvvPcivEuSc76ZDYY3zff3XsIOVAqIguql0fxSUzChIpvwX605StmrTejK5iarkBTU5T         7MCgDL+F82LkxTMrXcZ7TxyQUPxvImf+jWdCEZ2jKSe7n+QGmsctNysl1qyYvRnrIJGv         PdWqAeAZyqlx5cqE0Tlmv1o2XRz9YbC/xSElIx9lrjPU08BJvNdspJzNEmrRE1EQCGdS         UgYQ==
X-Gm-Message-State: AD7BkJIXVLk4Mtn4n3aAFRZ4Qj2gYjm3Mid+QKJmlCoe92nPVGSXXrnWv3wn7cglnc5R3g==
X-Received: by 10.140.232.15 with SMTP id d15mr33023847qhc.87.1458409575854;        Sat, 19 Mar 2016 10:46:15 -0700 (PDT)
Received: from bronx.local.pefoley.com (foleype-1-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:ee7::2])        by smtp.gmail.com with ESMTPSA id 78sm8582720qgt.1.2016.03.19.10.46.15        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);        Sat, 19 Mar 2016 10:46:15 -0700 (PDT)
From: Peter Foley <pefoley2@pefoley.com>
To: cygwin-patches@cygwin.com
Cc: Peter Foley <pefoley2@pefoley.com>
Subject: [PATCH 06/11] Remove always true nonnull check on "this" pointer.
Date: Sat, 19 Mar 2016 17:46:00 -0000
Message-Id: <1458409557-13156-6-git-send-email-pefoley2@pefoley.com>
In-Reply-To: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com>
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com>
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00126.txt.bz2

G++ 6.0 can assert that the this pointer is non-null for member functions.

winsup/cygserver/ChangeLog
process.cc (submission_loop::request_loop): Remove nonnull check on this.
process.cc (sync_wait_array): Ditto.
process.cc (check_and_remove_process): Ditto.
threaded_queue.cc (add_submission_loop): Ditto.
threaded_queue.cc (add): Ditto.
threaded_queue.cc (start): Ditto.
threaded_queue.cc (stop): Ditto.

winsup/cygwin/ChangeLog
fhandler_dsp.cc (Audio_out::buf_info): Remove nonnull check on this.
fhandler_dsp.cc (Audio_in::buf_info): Ditto.
path.cc (fcwd_access_t::Free): Ditto.
pinfo.cc (_pinfo::exists): Ditto.
pinfo.cc (_pinfo::commune_request): Ditto.
pinfo.cc (_pinfo::pipe_fhandler): Ditto.
pinfo.cc (_pinfo::fd): Ditto.
pinfo.cc (_pinfo::fds): Ditto.
pinfo.cc (_pinfo::root): Ditto.
pinfo.cc (_pinfo::cwd): Ditto.
pinfo.cc (_pinfo::cmdline): Ditto.
signal.cc (_pinfo::kill): Ditto.

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 winsup/cygserver/process.cc        |  3 ---
 winsup/cygserver/threaded_queue.cc |  4 ----
 winsup/cygwin/fhandler_dsp.cc      |  4 ++--
 winsup/cygwin/path.cc              |  2 +-
 winsup/cygwin/pinfo.cc             | 16 ++++++++--------
 winsup/cygwin/signal.cc            |  2 +-
 6 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/winsup/cygserver/process.cc b/winsup/cygserver/process.cc
index d78ca37..d8b2bea 100644
--- a/winsup/cygserver/process.cc
+++ b/winsup/cygserver/process.cc
@@ -174,7 +174,6 @@ process::cleanup ()
 void
 process_cache::submission_loop::request_loop ()
 {
-  assert (this);
   assert (_cache);
   assert (_interrupt_event);
 
@@ -379,7 +378,6 @@ process_cache::wait_for_processes (const HANDLE interrupt_event)
 size_t
 process_cache::sync_wait_array (const HANDLE interrupt_event)
 {
-  assert (this);
   assert (interrupt_event && interrupt_event != INVALID_HANDLE_VALUE);
 
   /* Always reset _cache_add_trigger before filling up the array again. */
@@ -426,7 +424,6 @@ process_cache::sync_wait_array (const HANDLE interrupt_event)
 void
 process_cache::check_and_remove_process (const size_t index)
 {
-  assert (this);
   assert (index < elements (_wait_array) - SPECIALS_COUNT);
 
   class process *const process = _process_array[index];
diff --git a/winsup/cygserver/threaded_queue.cc b/winsup/cygserver/threaded_queue.cc
index ba69e1a..4a4e94c 100644
--- a/winsup/cygserver/threaded_queue.cc
+++ b/winsup/cygserver/threaded_queue.cc
@@ -86,7 +86,6 @@ threaded_queue::~threaded_queue ()
 void
 threaded_queue::add_submission_loop (queue_submission_loop *const submitter)
 {
-  assert (this);
   assert (submitter);
   assert (submitter->_queue == this);
   assert (!submitter->_next);
@@ -159,7 +158,6 @@ threaded_queue::stop ()
 void
 threaded_queue::add (queue_request *const therequest)
 {
-  assert (this);
   assert (therequest);
   assert (!therequest->_next);
 
@@ -317,7 +315,6 @@ queue_submission_loop::~queue_submission_loop ()
 bool
 queue_submission_loop::start ()
 {
-  assert (this);
   assert (!_hThread);
 
   const bool was_running = _running;
@@ -341,7 +338,6 @@ queue_submission_loop::start ()
 bool
 queue_submission_loop::stop ()
 {
-  assert (this);
   assert (_hThread && _hThread != INVALID_HANDLE_VALUE);
 
   const bool was_running = _running;
diff --git a/winsup/cygwin/fhandler_dsp.cc b/winsup/cygwin/fhandler_dsp.cc
index 9fa2c6e..bfdd4c4 100644
--- a/winsup/cygwin/fhandler_dsp.cc
+++ b/winsup/cygwin/fhandler_dsp.cc
@@ -502,7 +502,7 @@ fhandler_dev_dsp::Audio_out::buf_info (audio_buf_info *p,
 				       int rate, int bits, int channels)
 {
   p->fragstotal = MAX_BLOCKS;
-  if (this && dev_)
+  if (dev_)
     {
       /* If the device is running we use the internal values,
 	 possibly set from the wave file. */
@@ -959,7 +959,7 @@ fhandler_dev_dsp::Audio_in::buf_info (audio_buf_info *p,
 {
   p->fragstotal = MAX_BLOCKS;
   p->fragsize = blockSize (rate, bits, channels);
-  if (this && dev_)
+  if (dev_)
     {
       p->fragments = Qisr2app_->query ();
       if (pHdr_ != NULL)
diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index 20391bf..df09d70 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -3937,7 +3937,7 @@ fcwd_access_t::Free (PVOID heap)
 {
   /* Decrement the reference count.  If it's down to 0, free
      structure from heap. */
-  if (this && InterlockedDecrement (&ReferenceCount ()) == 0)
+  if (InterlockedDecrement (&ReferenceCount ()) == 0)
     {
       /* In contrast to pre-Vista, the handle on init is always a
 	 fresh one and not the handle inherited from the parent
diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
index be32cfd..409a0b7 100644
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
index 8dfd4ab..c259678 100644
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
-- 
2.7.4
