Return-Path: <SRS0=+UMj=QD=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e08.mail.nifty.com (mta-snd-e08.mail.nifty.com [106.153.226.40])
	by sourceware.org (Postfix) with ESMTPS id 0EB51385843B
	for <cygwin-patches@cygwin.com>; Thu,  5 Sep 2024 13:19:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0EB51385843B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0EB51385843B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1725542364; cv=none;
	b=CsF8RJBB1krRG9eXmct4hGDlViwlzQEXU0JvRwz2cnxH04buCq614ftWmTuUw/LQo6907W8aD7URB/DZs7srKSMPwAkH+JQ9lqJtAxFTcDyazk7Ku1l0gU2DPUBp2hxHbGqhvdS6VD+IfF3pfW+xGea8M7vyA0NMRjZPlCD3Z9Y=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1725542364; c=relaxed/simple;
	bh=p0xKjpg53ePmMK2+fjywZEUwsVZqQ64UEVqwKAuyUMY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=R1uK4yQQ7O9DSm8gkse4lW7Hf5O59icwXvY5W+TZo0Jo0bsKo6YLrTXtf/4P9JXkvSKLD5/wWgy+2GXRykFP9T48fcgxv37nz7D6h6eP5KDz5K6xHFrvkCHDKO8zGf+ya9DXHm+I6DpByfSjDcaPQSmUpbEOQA+IwOJGaY6ledk=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-e08.mail.nifty.com
          with ESMTP
          id <20240905131918315.ZTJ.11752.localhost.localdomain@nifty.com>;
          Thu, 5 Sep 2024 22:19:18 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	isaacag,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Cygwin: pipe: Switch pipe mode to blocking mode by defaut
Date: Thu,  5 Sep 2024 22:18:31 +0900
Message-ID: <20240905131857.385-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1725542358;
 bh=TJ0LG5feidZp3sHOGwEIUsLr64zfNab3U92SN7cRCm8=;
 h=From:To:Cc:Subject:Date;
 b=Vc8ErwcNGM8pLoeGHD5AFNY3NZttol3N1R6OAcLya3GSKcdZ7K8HgVGcvpeSZ8xWt/Dv5nPG
 BqpHD6u8EDfbNrZ+ctyNYjFEH4EJo0bbtph6m6ow2dbwakbC0gvCCDsX1TuxZ3ICR9kaUee9rk
 IxrqGqxqFA9+i0/f7l3jJLAMYE9HWgndCGdkD6zOgnQN0LwhCLbYanLHmwWX4KqFE8+4yBPsY0
 jsHUwDWWMHDwh98UtWKv+/4QUadNXTlKKb5eGAL8O/R7Auik/hzqC20Btm3aA3wbYMgxbvyO25
 tRSP6EKjFVkotYheiDw46kQki54wX7kRfVY2fpAHT2sZM5oA==
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, cygwin read pipe used non-blocking mode althogh non-
cygwin app uses blocking-mode by default. Despite this requirement,
if a cygwin app is executed from a non-cygwwin app and the cygwin
app exits, read pipe remains on non-blocking mode because of the
commit fc691d0246b9. Due to this behaviour, the non-cygwin app
cannot read the pipe correctly after that. Similarly, if a non-
cygwin app is executed from a cygwin app and the non-cygwin app
exits, the read pipe mode remains on blocking mode although cygwin
read pipe should be non-blocking mode.

These bugs were provoked by pipe mode toggling between cygwin and
non-cygwin apps. To make management of pipe mode simpler,

This patch has re-designed the pipe implementation. In this new
implementation, both read and wrie pipe basically use only blocking
mode and the behaviour corresponding to the pipe mode is simulated
in raw_read() and raw_wrie(). Only when the query handle is not
available, the raw_write() cannot simulate non-blocking access.
Therefore, the pipe mode is temporarily changed to non-blocking
mode. This happens only if the pipe is created by non-cygwin app
and cygwin inherits that.

Addresses: https://github.com/git-for-windows/git/issues/5115
Fixes: fc691d0246b9 ("Cygwin: pipe: Make sure to set read pipe non-blocking for cygwin apps.");
Reported-by: isaacag, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/dtable.cc                 |   5 +-
 winsup/cygwin/fhandler/pipe.cc          | 352 ++++++++++--------------
 winsup/cygwin/local_includes/fhandler.h |   4 +-
 winsup/cygwin/select.cc                 |  19 +-
 4 files changed, 157 insertions(+), 223 deletions(-)

diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
index 9508f3e0b..7303f7eac 100644
--- a/winsup/cygwin/dtable.cc
+++ b/winsup/cygwin/dtable.cc
@@ -410,9 +410,8 @@ dtable::init_std_file_from_handle (int fd, HANDLE handle)
 	{
 	  fhandler_pipe *fhp = (fhandler_pipe *) fh;
 	  fhp->set_pipe_buf_size ();
-	  /* Set read pipe always to nonblocking */
-	  fhp->set_pipe_non_blocking (fhp->get_device () == FH_PIPER ?
-				      true : fhp->is_nonblocking ());
+	  /* Set pipe always blocking */
+	  fhp->set_pipe_non_blocking (false);
 	}
 
       if (!fh->open_setup (openflags))
diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
index c686df650..942de82b2 100644
--- a/winsup/cygwin/fhandler/pipe.cc
+++ b/winsup/cygwin/fhandler/pipe.cc
@@ -48,7 +48,7 @@ fhandler_pipe::fhandler_pipe ()
 
    In addition to setting the blocking mode of the pipe handle, it
    also sets the pipe's read mode to byte_stream unconditionally. */
-void
+bool
 fhandler_pipe::set_pipe_non_blocking (bool nonblocking)
 {
   NTSTATUS status;
@@ -62,6 +62,7 @@ fhandler_pipe::set_pipe_non_blocking (bool nonblocking)
 				 FilePipeInformation);
   if (!NT_SUCCESS (status))
     debug_printf ("NtSetInformationFile(FilePipeInformation): %y", status);
+  return NT_SUCCESS (status);
 }
 
 int
@@ -91,10 +92,10 @@ fhandler_pipe::init (HANDLE f, DWORD a, mode_t mode, int64_t uniq_id)
   set_ino (uniq_id);
   set_unique_id (uniq_id | !!(mode & GENERIC_WRITE));
   if (opened_properly)
-    /* Set read pipe always nonblocking to allow signal handling
-       even with FILE_SYNCHRONOUS_IO_NONALERT. */
-    set_pipe_non_blocking (get_device () == FH_PIPER ?
-			   true : is_nonblocking ());
+    /* Set pipe always blocking and simulate non-blocking mode in
+       raw_read()/raw_write() to allow signal handling even with
+       FILE_SYNCHRONOUS_IO_NONALERT. */
+    set_pipe_non_blocking (false);
 
   /* Store pipe name to path_conv pc for query_hdl check */
   if (get_dev () == FH_PIPEW)
@@ -333,17 +334,42 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
       ULONG len1 = (ULONG) (len - nbytes);
       DWORD select_sem_timeout = 0;
 
-      FILE_PIPE_LOCAL_INFORMATION fpli;
-      status = NtQueryInformationFile (get_handle (), &io,
-				       &fpli, sizeof (fpli),
-				       FilePipeLocalInformation);
-      if (NT_SUCCESS (status))
+      DWORD n;
+      BOOL ret = PeekNamedPipe (get_handle (), NULL, 0, NULL, &n, NULL);
+      if (!ret) /* Broken pipe ? */
+        break;
+      if (n == 0)
 	{
-	  if (fpli.ReadDataAvailable == 0 && nbytes != 0)
+	  if (nbytes != 0)
 	    break;
+	  if (is_nonblocking ())
+	    {
+	      set_errno (EAGAIN);
+	      nbytes = (size_t) -1;
+	      break;
+	    }
+	  /* If the pipe is a non-cygwin pipe, select_sem trick
+	     does not work. As a result, the following cygwait()
+	     will return only after timeout occurs. This causes
+	     performance degradation. However, setting timeout
+	     to zero causes high CPU load. So, set timeout to
+	     non-zero only when select_sem is valid or pipe is
+	     not ready to read for more than t0_threshold.
+	     This prevents both the performance degradation and
+	     the high CPU load. */
+	  if (select_sem || GetTickCount64 () - t0 > t0_threshold)
+	    select_sem_timeout = 1;
+	  waitret = cygwait (select_sem, select_sem_timeout);
+	  if (waitret == WAIT_CANCELED)
+	    pthread::static_cancel_self ();
+	  else if (waitret == WAIT_SIGNALED)
+	    {
+	      set_errno (EINTR);
+	      nbytes = (size_t) -1;
+	      break;
+	    }
+	  continue;
 	}
-      else if (nbytes != 0)
-	break;
       status = NtReadFile (get_handle (), NULL, NULL, NULL, &io, ptr,
 			   len1, NULL, NULL);
       if (isclosed ())  /* A signal handler might have closed the fd. */
@@ -368,37 +394,6 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
 	    case STATUS_PIPE_BROKEN:
 	      /* This is really EOF.  */
 	      break;
-	    case STATUS_PIPE_LISTENING:
-	    case STATUS_PIPE_EMPTY:
-	      if (nbytes != 0)
-		break;
-	      if (is_nonblocking ())
-		{
-		  set_errno (EAGAIN);
-		  nbytes = (size_t) -1;
-		  break;
-		}
-	      /* If the pipe is a non-cygwin pipe, select_sem trick
-		 does not work. As a result, the following cygwait()
-		 will return only after timeout occurs. This causes
-		 performance degradation. However, setting timeout
-		 to zero causes high CPU load. So, set timeout to
-		 non-zero only when select_sem is valid or pipe is
-		 not ready to read for more than t0_threshold.
-		 This prevents both the performance degradation and
-		 the high CPU load. */
-	      if (select_sem || GetTickCount64 () - t0 > t0_threshold)
-		select_sem_timeout = 1;
-	      waitret = cygwait (select_sem, select_sem_timeout);
-	      if (waitret == WAIT_CANCELED)
-		pthread::static_cancel_self ();
-	      else if (waitret == WAIT_SIGNALED)
-		{
-		  set_errno (EINTR);
-		  nbytes = (size_t) -1;
-		  break;
-		}
-	      continue;
 	    default:
 	      __seterrno_from_nt_status (status);
 	      nbytes = (size_t) -1;
@@ -446,12 +441,20 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
       return -1;
     }
 
-  if (len <= pipe_buf_size || pipe_buf_size == 0)
+  bool query_hdl_available = true;
+  ssize_t avail = pipe_buf_size;
+  if (is_nonblocking ())
+    avail = pipe_data_available (-1, this, get_handle (), PDA_WRITE);
+  if (avail == 0)
+    {
+      set_errno (EAGAIN);
+      return -1;
+    }
+
+  if (len <= (size_t) avail || pipe_buf_size == 0)
     chunk = len;
-  else if (is_nonblocking ())
-    chunk = len = pipe_buf_size;
   else
-    chunk = pipe_buf_size;
+    chunk = avail;
 
   if (!(evt = CreateEvent (NULL, false, false, NULL)))
     {
@@ -459,6 +462,28 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
       return -1;
     }
 
+  if (is_nonblocking ())
+    {
+      fhandler_pipe *fh = (fhandler_pipe *) this;
+      query_hdl_available =
+	fh->get_query_handle () || fh->temporary_query_hdl ();
+      if (avail > 1 || query_hdl_available)
+	len = chunk;
+      else if (avail == 0) /* The pipe is really full. */
+	{
+	  set_errno (EAGAIN);
+	  return -1;
+	}
+      else if (!fh->set_pipe_non_blocking (true))
+	/* NtSetInformationFile() in set_pipe_non_blocking(true)
+	   fails for unknown reasons if the pipe is not empty.
+	   In this case, no pipe reader should be reading the pipe,
+	   so pipe_data_available() has returned correct value. */
+	len = chunk; /* The pipe is not empty. */
+      else
+	chunk = len = min (len, pipe_buf_size); /* The pipe is empty. */
+    }
+
   /* Write in chunks, accumulating a total.  If there's an error, just
      return the accumulated total unless the first write fails, in
      which case return -1. */
@@ -528,6 +553,12 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
 		      waitret = WAIT_SIGNALED;
 		      break;
 		    }
+		  if (waitret == WAIT_TIMEOUT && is_nonblocking ())
+		    {
+		      CancelIo (get_handle ());
+		      set_errno (EAGAIN);
+		      goto out;
+		    }
 		  cygwait (select_sem, 10, cw_cancel);
 		}
 	      /* Loop in case of blocking write or SA_RESTART */
@@ -610,6 +641,9 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
 	break;
     }
 out:
+  if (avail == 1 && !query_hdl_available)
+    ((fhandler_pipe *) this)->set_pipe_non_blocking (false);
+
   CloseHandle (evt);
   if (status == STATUS_THREAD_SIGNALED && nbytes == 0)
     set_errno (EINTR);
@@ -649,17 +683,6 @@ fhandler_pipe::fixup_after_fork (HANDLE parent)
   ReleaseMutex (hdl_cnt_mtx);
 }
 
-void
-fhandler_pipe::fixup_after_exec ()
-{
-  /* Set read pipe itself always non-blocking for cygwin process.
-     Blocking/non-blocking is simulated in raw_read(). For write
-     pipe, follow is_nonblocking(). */
-  bool mode = get_device () == FH_PIPEW ? is_nonblocking () : true;
-  set_pipe_non_blocking (mode);
-  fhandler_base::fixup_after_exec ();
-}
-
 int
 fhandler_pipe::dup (fhandler_base *child, int flags)
 {
@@ -745,6 +768,7 @@ fhandler_pipe::close ()
 }
 
 #define PIPE_INTRO "\\\\.\\pipe\\cygwin-"
+#define PIPE_INTRO_NT "\\\\.\\pipe\\"
 
 /* Create a pipe, and return handles to the read and write ends,
    just like CreatePipe, but ensure that the write end permits
@@ -769,8 +793,16 @@ fhandler_pipe::create (LPSECURITY_ATTRIBUTES sa_ptr, PHANDLE r, PHANDLE w,
     psize = DEFAULT_PIPEBUFSIZE;
 
   char pipename[MAX_PATH];
-  size_t len = __small_sprintf (pipename, PIPE_INTRO "%S-",
-				      &cygheap->installation_key);
+  size_t len = __small_sprintf(pipename, "%S-%u-pipe-nt-0x",
+			       &cygheap->installation_key,
+			       GetCurrentProcessId ());
+  bool nt = !strncmp (name, pipename, len);
+  if (nt)
+    len = __small_sprintf (pipename, PIPE_INTRO_NT "%S-",
+			   &cygheap->installation_key);
+  else
+    len = __small_sprintf (pipename, PIPE_INTRO "%S-",
+			   &cygheap->installation_key);
   DWORD pipe_mode = PIPE_READMODE_BYTE | PIPE_REJECT_REMOTE_CLIENTS;
   if (!name)
     pipe_mode |= pipe_byte ? PIPE_TYPE_BYTE : PIPE_TYPE_MESSAGE;
@@ -821,11 +853,27 @@ fhandler_pipe::create (LPSECURITY_ATTRIBUTES sa_ptr, PHANDLE r, PHANDLE w,
 	 definitely required for pty handling since fhandler_pty_master
 	 writes to the pipe in chunks, terminated by newline when CANON mode
 	 is specified.  */
-      *r = CreateNamedPipe (pipename, open_mode, pipe_mode, 1, psize,
-			   psize, NMPWAIT_USE_DEFAULT_WAIT, sa_ptr);
+      /* PIPE_ACCESS_OUTBOUND is added to acquire FILE_WRITE_ATTRIBUTES right.
+	 Unnecessary rights such as FILE_WRITE_DATA will be dropped later. */
+      *r = CreateNamedPipe (pipename, open_mode | PIPE_ACCESS_OUTBOUND,
+			    pipe_mode, 1, psize, psize,
+			    NMPWAIT_USE_DEFAULT_WAIT, sa_ptr);
 
       if (*r != INVALID_HANDLE_VALUE)
 	{
+	  /* Drop unnecessary access rights. */
+	  HANDLE rtmp;
+	  DWORD access = GENERIC_READ | FILE_WRITE_ATTRIBUTES;
+	  if (nt)
+	    /* Add this right as a marker of cygwin read pipe for query_hdl */
+	    access |= FILE_WRITE_EA;
+	  if (DuplicateHandle (GetCurrentProcess (), r,
+			       GetCurrentProcess (), &rtmp,
+			       access, sa_ptr->bInheritHandle, 0))
+	    {
+	      CloseHandle (*r);
+	      *r = rtmp;
+	    }
 	  debug_printf ("pipe read handle %p", *r);
 	  err = 0;
 	  break;
@@ -916,6 +964,11 @@ is_running_as_service (void)
    simplicity, nt_create will omit the 'open_mode' and 'name'
    parameters, which aren't needed for our purposes.  */
 
+/* Regardless of above comment, the current nt_create() is reverted to just
+   call fhandler_pipe::create() to allow adding FILE_FLAG_OVERLAPPED flag.
+   This is needed for query_hdl so that PeekNamedPipe() and NtQueryObject()
+   are not blocked even while reader is reading the pipe. */
+
 static int nt_create (LPSECURITY_ATTRIBUTES, HANDLE &, HANDLE &, DWORD,
 		      int64_t *);
 
@@ -955,8 +1008,7 @@ fhandler_pipe::create (fhandler_pipe *fhs[2], unsigned psize, int mode)
 			0, sa->bInheritHandle, DUPLICATE_SAME_ACCESS))
     goto err_close_select_sem0;
 
-  if (is_running_as_service () &&
-      !DuplicateHandle (GetCurrentProcess (), r,
+  if (!DuplicateHandle (GetCurrentProcess (), r,
 			GetCurrentProcess (), &fhs[1]->query_hdl,
 			FILE_READ_DATA, sa->bInheritHandle, 0))
     goto err_close_select_sem1;
@@ -1005,131 +1057,29 @@ out:
   return res;
 }
 
+/* Current nt_create() does not use NtCreateNamedPipe() at all. The
+   function name is just inherited from previous implementation of
+   fhandler_pipe. */
 static int
 nt_create (LPSECURITY_ATTRIBUTES sa_ptr, HANDLE &r, HANDLE &w,
 		DWORD psize, int64_t *unique_id)
 {
-  NTSTATUS status;
-  HANDLE npfsh;
-  ACCESS_MASK access;
-  OBJECT_ATTRIBUTES attr;
-  IO_STATUS_BLOCK io;
-  LARGE_INTEGER timeout;
-
-  /* Default to error. */
-  r = NULL;
-  w = NULL;
-
-  status = fhandler_base::npfs_handle (npfsh);
-  if (!NT_SUCCESS (status))
-    {
-      __seterrno_from_nt_status (status);
-      return GetLastError ();
-    }
-
-  /* Ensure that there is enough pipe buffer space for atomic writes.  */
-  if (!psize)
-    psize = DEFAULT_PIPEBUFSIZE;
-
-  UNICODE_STRING pipename;
-  WCHAR pipename_buf[MAX_PATH];
-  size_t len = __small_swprintf (pipename_buf, L"%S-%u-",
-				 &cygheap->installation_key,
-				 GetCurrentProcessId ());
-
-  access = GENERIC_READ | FILE_WRITE_ATTRIBUTES | SYNCHRONIZE;
-  access |= FILE_WRITE_EA; /* Add this right as a marker of cygwin read pipe */
-
-  ULONG pipe_type = pipe_byte ? FILE_PIPE_BYTE_STREAM_TYPE
-    : FILE_PIPE_MESSAGE_TYPE;
-
-  /* Retry NtCreateNamedPipeFile as long as the pipe name is in use.
-     Retrying will probably never be necessary, but we want
-     to be as robust as possible.  */
-  DWORD err = 0;
-  while (!r)
-    {
-      static volatile ULONG pipe_unique_id;
-      LONG id = InterlockedIncrement ((LONG *) &pipe_unique_id);
-      __small_swprintf (pipename_buf + len, L"pipe-nt-%p", id);
-      if (unique_id)
-	*unique_id = ((int64_t) id << 32 | GetCurrentProcessId ());
-
-      debug_printf ("name %W, size %u, mode %s", pipename_buf, psize,
-		    (pipe_type & FILE_PIPE_MESSAGE_TYPE)
-		    ? "PIPE_TYPE_MESSAGE" : "PIPE_TYPE_BYTE");
-
-      RtlInitUnicodeString (&pipename, pipename_buf);
-
-      InitializeObjectAttributes (&attr, &pipename,
-				  sa_ptr->bInheritHandle ? OBJ_INHERIT : 0,
-				  npfsh, sa_ptr->lpSecurityDescriptor);
-
-      timeout.QuadPart = -500000;
-      /* Set FILE_SYNCHRONOUS_IO_NONALERT flag so that native
-	 C# programs work with cygwin pipe. */
-      status = NtCreateNamedPipeFile (&r, access, &attr, &io,
-				      FILE_SHARE_READ | FILE_SHARE_WRITE,
-				      FILE_CREATE,
-				      FILE_SYNCHRONOUS_IO_NONALERT, pipe_type,
-				      FILE_PIPE_BYTE_STREAM_MODE,
-				      0, 1, psize, psize, &timeout);
-
-      if (NT_SUCCESS (status))
-	{
-	  debug_printf ("pipe read handle %p", r);
-	  err = 0;
-	  break;
-	}
-
-      switch (status)
-	{
-	case STATUS_PIPE_BUSY:
-	case STATUS_INSTANCE_NOT_AVAILABLE:
-	case STATUS_PIPE_NOT_AVAILABLE:
-	  /* The pipe is already open with compatible parameters.
-	     Pick a new name and retry.  */
-	  debug_printf ("pipe busy, retrying");
-	  r = NULL;
-	  break;
-	case STATUS_ACCESS_DENIED:
-	  /* The pipe is already open with incompatible parameters.
-	     Pick a new name and retry.  */
-	  debug_printf ("pipe access denied, retrying");
-	  r = NULL;
-	  break;
-	default:
-	  {
-	    __seterrno_from_nt_status (status);
-	    err = GetLastError ();
-	    debug_printf ("failed, %E");
-	    r = NULL;
-	  }
-	}
-    }
-
-  if (err)
-    {
-      r = NULL;
-      return err;
-    }
-
-  debug_printf ("NtOpenFile: name %S", &pipename);
-
-  access = GENERIC_WRITE | FILE_READ_ATTRIBUTES | SYNCHRONIZE;
-  status = NtOpenFile (&w, access, &attr, &io, 0, 0);
-  if (!NT_SUCCESS (status))
-    {
-      DWORD err = GetLastError ();
-      debug_printf ("NtOpenFile failed, r %p, %E", r);
-      if (r)
-	NtClose (r);
-      w = NULL;
-      return err;
-    }
-
-  /* Success. */
-  return 0;
+  char name[MAX_PATH];
+  size_t len = __small_sprintf (name, "%u-", GetCurrentProcessId ());
+  static volatile ULONG pipe_unique_id;
+  LONG id = InterlockedIncrement ((LONG *) &pipe_unique_id);
+  __small_sprintf (name + len, "pipe-nt-%p", id);
+  *unique_id = ((int64_t) id << 32 | GetCurrentProcessId ());
+
+  /* FILE_FLAG_OVERLAPPED is added here to allow PeekNamedPipe() and
+     NtQueryObject() be not blocked even while reader is reading the
+     pipe.
+     Accordig to the official document, to access the handle opened
+     with FILE_FLAG_OVERLAPPED, it is mandatory to pass the OVERLAPPED
+     structure. However, in fact, it seems that the access will fallback
+     to the blocking access if it is not specified. */
+  return fhandler_pipe::create (sa_ptr, &r, &w, psize, name,
+				FILE_FLAG_OVERLAPPED, unique_id);
 }
 
 /* Called by dtable::init_std_file_from_handle for stdio handles
@@ -1174,22 +1124,6 @@ fhandler_pipe::ioctl (unsigned int cmd, void *p)
   return 0;
 }
 
-int
-fhandler_pipe::fcntl (int cmd, intptr_t arg)
-{
-  if (cmd != F_SETFL)
-    return fhandler_base::fcntl (cmd, arg);
-
-  const bool was_nonblocking = is_nonblocking ();
-  int res = fhandler_base::fcntl (cmd, arg);
-  const bool now_nonblocking = is_nonblocking ();
-  /* Do not set blocking mode for read pipe to allow signal handling
-     even with FILE_SYNCHRONOUS_IO_NONALERT. */
-  if (now_nonblocking != was_nonblocking && get_device () != FH_PIPER)
-    set_pipe_non_blocking (now_nonblocking);
-  return res;
-}
-
 int
 fhandler_pipe::fstat (struct stat *buf)
 {
@@ -1262,11 +1196,8 @@ fhandler_pipe::get_query_hdl_per_process (OBJECT_NAME_INFORMATION *ntfn)
       NTSTATUS status;
       ULONG len;
 
-      /* Non-cygwin app may call ReadFile() for empty pipe, which makes
-	NtQueryObject() for ObjectNameInformation block. Therefore, do
-	not try to get query_hdl for non-cygwin apps. */
       _pinfo *p = pids[i];
-      if (!p || ISSTATE (p, PID_NOTCYGWIN))
+      if (!p)
 	continue;
 
       HANDLE proc = OpenProcess (PROCESS_DUP_HANDLE
@@ -1361,18 +1292,11 @@ fhandler_pipe::spawn_worker (int fileno_stdin, int fileno_stdout,
     if (cfd->get_dev () == FH_PIPEW
 	&& (fd == fileno_stdout || fd == fileno_stderr))
       {
+	/* Setup for query_hdl stuff. Read the comment below. */
 	fhandler_pipe *pipe = (fhandler_pipe *)(fhandler_base *) cfd;
-	pipe->set_pipe_non_blocking (false);
-
-	/* Setup for query_ndl stuff. Read the comment below. */
 	if (pipe->request_close_query_hdl ())
 	  need_send_noncygchld_sig = true;
       }
-    else if (cfd->get_dev () == FH_PIPER && fd == fileno_stdin)
-      {
-	fhandler_pipe *pipe = (fhandler_pipe *)(fhandler_base *) cfd;
-	pipe->set_pipe_non_blocking (false);
-      }
 
   /* If multiple writers including non-cygwin app exist, the non-cygwin
      app cannot detect pipe closure on the read side when the pipe is
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 1c339cfbc..a6281d0c0 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -1234,13 +1234,11 @@ public:
   int open (int flags, mode_t mode = 0);
   bool open_setup (int flags);
   void fixup_after_fork (HANDLE);
-  void fixup_after_exec ();
   int dup (fhandler_base *child, int);
   void set_close_on_exec (bool val);
   int close ();
   void raw_read (void *ptr, size_t& len);
   int ioctl (unsigned int cmd, void *);
-  int fcntl (int cmd, intptr_t);
   int fstat (struct stat *buf);
   int fstatvfs (struct statvfs *buf);
   int fadvise (off_t, off_t, int);
@@ -1265,7 +1263,7 @@ public:
     fh->copy_from (this);
     return fh;
   }
-  void set_pipe_non_blocking (bool nonblocking);
+  bool set_pipe_non_blocking (bool nonblocking);
   HANDLE get_query_handle () const { return query_hdl; }
   void close_query_handle ()
   {
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index bc02c3f9d..672e856ef 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -642,7 +642,7 @@ pipe_data_available (int fd, fhandler_base *fh, HANDLE h, int flags)
         Consequentially, the only reliable information is available on the
         read side, so fetch info from the read side via the pipe-specific
         query handle.  Use fpli.WriteQuotaAvailable as storage for the actual
-        interesting value, which is the InboundQuote on the write side,
+        interesting value, which is the OutboundQuota on the write side,
         decremented by the number of bytes of data in that buffer. */
       /* Note: Do not use NtQueryInformationFile() for query_hdl because
 	 NtQueryInformationFile() seems to interfere with reading pipes
@@ -659,7 +659,20 @@ pipe_data_available (int fd, fhandler_base *fh, HANDLE h, int flags)
 	  if (!query_hdl)
 	    query_hdl = ((fhandler_pipe *) fh)->temporary_query_hdl ();
 	  if (!query_hdl) /* We cannot know actual write pipe space. */
-	    return (flags & PDA_SELECT) ? PIPE_BUF : 1;
+	    {
+	      /* NtSetInformationFile() in set_pipe_non_blocking(true)
+		 fails for unknown reasons if the pipe is not empty.
+		 In this case, no pipe reader should be reading the pipe,
+		 so the pipe is really full if WriteQuotaAvailable
+		 is zero.*/
+	      if (!((fhandler_pipe *) fh)->set_pipe_non_blocking (true))
+		return 0;
+	      /* Restore pipe mode to blocking mode */
+	      ((fhandler_pipe *) fh)->set_pipe_non_blocking (false);
+	      /* The pipe is empty here because set_pipe_non_blocking(true)
+		 has succeeded. */
+	      return fpli.OutboundQuota;;
+	    }
 	  DWORD nbytes_in_pipe;
 	  BOOL res =
 	    PeekNamedPipe (query_hdl, NULL, 0, NULL, &nbytes_in_pipe, NULL);
@@ -667,7 +680,7 @@ pipe_data_available (int fd, fhandler_base *fh, HANDLE h, int flags)
 	    CloseHandle (query_hdl); /* Close temporary query_hdl */
 	  if (!res) /* We cannot know actual write pipe space. */
 	    return (flags & PDA_SELECT) ? PIPE_BUF : 1;
-	  fpli.WriteQuotaAvailable = fpli.InboundQuota - nbytes_in_pipe;
+	  fpli.WriteQuotaAvailable = fpli.OutboundQuota - nbytes_in_pipe;
 	}
       if (fpli.WriteQuotaAvailable > 0)
 	{
-- 
2.45.1

