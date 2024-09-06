Return-Path: <SRS0=8gjk=QE=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id D3DB1385C6E1
	for <cygwin-patches@cygwin.com>; Fri,  6 Sep 2024 16:26:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D3DB1385C6E1
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D3DB1385C6E1
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1725640002; cv=none;
	b=osK0qKLJVpRXf3M69Wijrq7ikMItD6gqtNeTGszi4PBt8iUotPCoWBCxsjrwpeX6lyFQFXt02eKxRBIo7e7SAYUq/qmBEkpKdAg9txYp008NHIK9RblgQZ7nmrr2phPrKUbsQSvp0JrK5q5hBPjHt/SERWPmzeMOmV4CfWMfcE0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1725640002; c=relaxed/simple;
	bh=7zALWDe1kzQA2Ve1B7sfIMjwzvNIdXcMYTbnUmM3J1Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=MajSWjLTfyX7mOWnfnrJGoEZ/8AOUFA26jQcKJjMg9QkaI5viPLNktznQj0tpPPPkGly9+xJBvRjz05XBkfZPbGlTVNfVATTNm8LP4RPgxp03Cr9eBjwi268IaG7Jh2QPJT9Tffow9emPDdb6Eq7I0yqCepdJW7KqcM/3ZmWPqA=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-w07.mail.nifty.com
          with ESMTP
          id <20240906162633551.TGXU.84910.localhost.localdomain@nifty.com>;
          Sat, 7 Sep 2024 01:26:33 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	isaacag,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v3] Cygwin: pipe: Switch pipe mode to blocking mode by defaut
Date: Sat,  7 Sep 2024 01:26:09 +0900
Message-ID: <20240906162618.1474-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1725639993;
 bh=bg+xpd55wCRTq4S/nx1UvlaaeCPPYUEqoii6+yv+/sc=;
 h=From:To:Cc:Subject:Date;
 b=dbG4/kyEGomVR5V7i6ygGKFaViqbhdWbXR5blpNlQblzQrA5NRp0FIUCqKx5fY8EXZyV73wS
 xy/AgihKGCB6jnonDNBiTz8LgPAUFP6JpnTToa3ZeYX//PStJzhq/3WEBhhajAGBB/NLPb5/XO
 ArYIUp356/yRzFY/Mp/HdT2USb82NsWOwRIatvuW9ab9gvzLKFGELjxtZdjV8MN6bGGq6BuA2l
 uFl0sG2SXqH5DAAvIsjNU4BVRzqM8HHgcTJsCzt7AQrbdbEB35kuZDiQjv2mRp6O4LukHvm5k4
 61KmgnlgvQkU7rGJDV4xUsWyfmUzhpHDE2sUH8LB0l6t4otQ==
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
non-cygwin apps. To make management of pipe mode simpler, this
patch has re-designed the pipe implementation. In this new
implementation, both read and wrie pipe basically use only blocking
mode and the behaviour corresponding to the pipe mode is simulated
in raw_read() and raw_write(). Only when NtQueryInformationFile(
FilePipeLocalInformation) fails for some reasons, the raw_write()
cannot simulate non-blocking access. Therefore, the pipe mode is
temporarily changed to non-blocking mode.

Moreover, because the fact that NtSetInformationFile() in
set_pipe_non_blocking(true) fails with STATUS_PIPE_BUSY if the pipe
is not empty has been founhd, query handle is not necessary anymore.
This allows the implementation much simpler than before.

Addresses: https://github.com/git-for-windows/git/issues/5115
Fixes: fc691d0246b9 ("Cygwin: pipe: Make sure to set read pipe non-blocking for cygwin apps.");
Reported-by: isaacag, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/dtable.cc                 |   5 +-
 winsup/cygwin/fhandler/pipe.cc          | 483 ++++--------------------
 winsup/cygwin/local_includes/fhandler.h |  42 +--
 winsup/cygwin/local_includes/sigproc.h  |   1 -
 winsup/cygwin/select.cc                 |  26 +-
 winsup/cygwin/sigproc.cc                |  10 -
 winsup/cygwin/spawn.cc                  |   4 -
 7 files changed, 98 insertions(+), 473 deletions(-)

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
index c686df650..21447cdc4 100644
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
@@ -91,24 +92,10 @@ fhandler_pipe::init (HANDLE f, DWORD a, mode_t mode, int64_t uniq_id)
   set_ino (uniq_id);
   set_unique_id (uniq_id | !!(mode & GENERIC_WRITE));
   if (opened_properly)
-    /* Set read pipe always nonblocking to allow signal handling
-       even with FILE_SYNCHRONOUS_IO_NONALERT. */
-    set_pipe_non_blocking (get_device () == FH_PIPER ?
-			   true : is_nonblocking ());
-
-  /* Store pipe name to path_conv pc for query_hdl check */
-  if (get_dev () == FH_PIPEW)
-    {
-      UNICODE_STRING name;
-      WCHAR pipename_buf[MAX_PATH];
-      __small_swprintf (pipename_buf, L"%S%S-%u-pipe-nt-%p",
-			&ro_u_npfs, &cygheap->installation_key,
-			GetCurrentProcessId (), unique_id >> 32);
-      name.Length = wcslen (pipename_buf) * sizeof (WCHAR);
-      name.MaximumLength = sizeof (pipename_buf);
-      name.Buffer = pipename_buf;
-      pc.set_nt_native_path (&name);
-    }
+    /* Set pipe always blocking and simulate non-blocking mode in
+       raw_read()/raw_write() to allow signal handling even with
+       FILE_SYNCHRONOUS_IO_NONALERT. */
+    set_pipe_non_blocking (false);
 
   return 1;
 }
@@ -214,39 +201,19 @@ out:
 bool
 fhandler_pipe::open_setup (int flags)
 {
-  bool read_mtx_created = false;
-
   if (!fhandler_base::open_setup (flags))
-    goto err;
+    return false;
   if (get_dev () == FH_PIPER && !read_mtx)
     {
       SECURITY_ATTRIBUTES *sa = sec_none_cloexec (flags);
       read_mtx = CreateMutex (sa, FALSE, NULL);
-      if (read_mtx)
-	read_mtx_created = true;
-      else
+      if (!read_mtx)
 	{
 	  debug_printf ("CreateMutex read_mtx failed: %E");
-	  goto err;
-	}
-    }
-  if (!hdl_cnt_mtx)
-    {
-      SECURITY_ATTRIBUTES *sa = sec_none_cloexec (flags);
-      hdl_cnt_mtx = CreateMutex (sa, FALSE, NULL);
-      if (!hdl_cnt_mtx)
-	{
-	  debug_printf ("CreateMutex hdl_cnt_mtx failed: %E");
-	  goto err_close_read_mtx;
+	  return false;
 	}
     }
   return true;
-
-err_close_read_mtx:
-  if (read_mtx_created)
-    CloseHandle (read_mtx);
-err:
-  return false;
 }
 
 off_t
@@ -339,37 +306,11 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
 				       FilePipeLocalInformation);
       if (NT_SUCCESS (status))
 	{
-	  if (fpli.ReadDataAvailable == 0 && nbytes != 0)
-	    break;
-	}
-      else if (nbytes != 0)
-	break;
-      status = NtReadFile (get_handle (), NULL, NULL, NULL, &io, ptr,
-			   len1, NULL, NULL);
-      if (isclosed ())  /* A signal handler might have closed the fd. */
-	{
-	  set_errno (EBADF);
-	  nbytes = (size_t) -1;
-	}
-      else if (NT_SUCCESS (status) || status == STATUS_BUFFER_OVERFLOW)
-	{
-	  nbytes_now = io.Information;
-	  ptr = ((char *) ptr) + nbytes_now;
-	  nbytes += nbytes_now;
-	  if (select_sem && nbytes_now > 0)
-	    release_select_sem ("raw_read");
-	}
-      else
-	{
-	  /* Some errors are not really errors.  Detect such cases here.  */
-	  switch (status)
+	  if (fpli.ReadDataAvailable == 0)
 	    {
-	    case STATUS_END_OF_FILE:
-	    case STATUS_PIPE_BROKEN:
-	      /* This is really EOF.  */
-	      break;
-	    case STATUS_PIPE_LISTENING:
-	    case STATUS_PIPE_EMPTY:
+	      if (fpli.NamedPipeState == FILE_PIPE_CLOSING_STATE)
+		/* Broken pipe ? */
+		break;
 	      if (nbytes != 0)
 		break;
 	      if (is_nonblocking ())
@@ -399,6 +340,34 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
 		  break;
 		}
 	      continue;
+	    }
+	}
+      else if (nbytes != 0)
+	break;
+      status = NtReadFile (get_handle (), NULL, NULL, NULL, &io, ptr,
+			   len1, NULL, NULL);
+      if (isclosed ())  /* A signal handler might have closed the fd. */
+	{
+	  set_errno (EBADF);
+	  nbytes = (size_t) -1;
+	}
+      else if (NT_SUCCESS (status) || status == STATUS_BUFFER_OVERFLOW)
+	{
+	  nbytes_now = io.Information;
+	  ptr = ((char *) ptr) + nbytes_now;
+	  nbytes += nbytes_now;
+	  if (select_sem && nbytes_now > 0)
+	    release_select_sem ("raw_read");
+	}
+      else
+	{
+	  /* Some errors are not really errors.  Detect such cases here.  */
+	  switch (status)
+	    {
+	    case STATUS_END_OF_FILE:
+	    case STATUS_PIPE_BROKEN:
+	      /* This is really EOF.  */
+	      break;
 	    default:
 	      __seterrno_from_nt_status (status);
 	      nbytes = (size_t) -1;
@@ -414,18 +383,6 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
   len = nbytes;
 }
 
-bool
-fhandler_pipe::reader_closed ()
-{
-  if (!query_hdl)
-    return false;
-  WaitForSingleObject (hdl_cnt_mtx, INFINITE);
-  int n_reader = get_obj_handle_count (query_hdl);
-  int n_writer = get_obj_handle_count (get_handle ());
-  ReleaseMutex (hdl_cnt_mtx);
-  return n_reader == n_writer;
-}
-
 ssize_t
 fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
 {
@@ -439,19 +396,49 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
   if (!len)
     return 0;
 
-  if (reader_closed ())
+  ssize_t avail = pipe_buf_size;
+  bool real_non_blocking_mode = false;
+  if (is_nonblocking ())
     {
-      set_errno (EPIPE);
-      raise (SIGPIPE);
-      return -1;
+      NTSTATUS status;
+      IO_STATUS_BLOCK io;
+      FILE_PIPE_LOCAL_INFORMATION fpli;
+
+      status = NtQueryInformationFile (get_handle (), &io, &fpli, sizeof fpli,
+				       FilePipeLocalInformation);
+      if (NT_SUCCESS (status))
+	{
+	  if (fpli.WriteQuotaAvailable != 0)
+	    avail = fpli.WriteQuotaAvailable;
+	  else /* WriteQuotaAvailable == 0 */
+	    { /* Reffer to the comment in select.cc: pipe_data_available(). */
+	      /* NtSetInformationFile() in set_pipe_non_blocking(true)
+		 seems to fail for unknown reasons with STATUS_PIPE_BUSY
+		 if no reader is reading the pipe. In this case, the pipe
+		 is really full if WriteQuotaAvailable is zero. Otherwise,
+		 the pipe is empty. */
+	      if (!((fhandler_pipe *)this)->set_pipe_non_blocking (true))
+		{
+		  /* Full */
+		  set_errno (EAGAIN);
+		  return -1;
+		}
+	      /* Restore the pipe mode to blocking. */
+	      ((fhandler_pipe *)this)->set_pipe_non_blocking (false);
+	      /* Pipe should be empty because reader is waiting the data. */
+	    }
+	}
+      else if (((fhandler_pipe *)this)->set_pipe_non_blocking (true))
+	/* The pipe space is unknown. */
+	real_non_blocking_mode = true;
     }
 
-  if (len <= pipe_buf_size || pipe_buf_size == 0)
+  if (len <= (size_t) avail || pipe_buf_size == 0)
     chunk = len;
   else if (is_nonblocking ())
-    chunk = len = pipe_buf_size;
+    chunk = len = avail;
   else
-    chunk = pipe_buf_size;
+    chunk = avail;
 
   if (!(evt = CreateEvent (NULL, false, false, NULL)))
     {
@@ -503,21 +490,7 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
 	    {
 	      do
 		{
-		  /* To allow constant reader_closed() checking even if the
-		     signal has been set up with SA_RESTART, we're handling
-		     the signal here --> cw_sig_eintr. */
-		  waitret = cygwait (evt, (DWORD) 0, cw_cancel | cw_sig_eintr);
-		  /* Break out if no SA_RESTART. */
-		  if (waitret == WAIT_SIGNALED
-		      && !_my_tls.call_signal_handler ())
-		    break;
-		  if (reader_closed ())
-		    {
-		      CancelIo (get_handle ());
-		      set_errno (EPIPE);
-		      raise (SIGPIPE);
-		      goto out;
-		    }
+		  waitret = cygwait (evt, (DWORD) 0);
 		  /* Break out on completion */
 		  if (waitret == WAIT_OBJECT_0)
 		    break;
@@ -609,7 +582,10 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
       if (nbytes_now == 0 || short_write_once)
 	break;
     }
-out:
+
+  if (real_non_blocking_mode)
+    ((fhandler_pipe *) this)->set_pipe_non_blocking (false);
+
   CloseHandle (evt);
   if (status == STATUS_THREAD_SIGNALED && nbytes == 0)
     set_errno (EINTR);
@@ -626,38 +602,16 @@ fhandler_pipe::set_close_on_exec (bool val)
     set_no_inheritance (read_mtx, val);
   if (select_sem)
     set_no_inheritance (select_sem, val);
-  if (query_hdl)
-    set_no_inheritance (query_hdl, val);
-  set_no_inheritance (hdl_cnt_mtx, val);
 }
 
 void
 fhandler_pipe::fixup_after_fork (HANDLE parent)
 {
-  fork_fixup (parent, hdl_cnt_mtx, "hdl_cnt_mtx");
-  WaitForSingleObject (hdl_cnt_mtx, INFINITE);
   if (read_mtx)
     fork_fixup (parent, read_mtx, "read_mtx");
   if (select_sem)
     fork_fixup (parent, select_sem, "select_sem");
-  if (query_hdl)
-    fork_fixup (parent, query_hdl, "query_hdl");
-  if (query_hdl_close_req_evt)
-    fork_fixup (parent, query_hdl_close_req_evt, "query_hdl_close_req_evt");
-
   fhandler_base::fixup_after_fork (parent);
-  ReleaseMutex (hdl_cnt_mtx);
-}
-
-void
-fhandler_pipe::fixup_after_exec ()
-{
-  /* Set read pipe itself always non-blocking for cygwin process.
-     Blocking/non-blocking is simulated in raw_read(). For write
-     pipe, follow is_nonblocking(). */
-  bool mode = get_device () == FH_PIPEW ? is_nonblocking () : true;
-  set_pipe_non_blocking (mode);
-  fhandler_base::fixup_after_exec ();
 }
 
 int
@@ -667,7 +621,6 @@ fhandler_pipe::dup (fhandler_base *child, int flags)
   ftp->set_popen_pid (0);
 
   int res = 0;
-  WaitForSingleObject (hdl_cnt_mtx, INFINITE);
   if (fhandler_base::dup (child, flags))
     res = -1;
   else if (read_mtx &&
@@ -688,34 +641,6 @@ fhandler_pipe::dup (fhandler_base *child, int flags)
       ftp->close ();
       res = -1;
     }
-  else if (query_hdl &&
-	   !DuplicateHandle (GetCurrentProcess (), query_hdl,
-			     GetCurrentProcess (), &ftp->query_hdl,
-			     0, !(flags & O_CLOEXEC), DUPLICATE_SAME_ACCESS))
-    {
-      __seterrno ();
-      ftp->close ();
-      res = -1;
-    }
-  else if (!DuplicateHandle (GetCurrentProcess (), hdl_cnt_mtx,
-			     GetCurrentProcess (), &ftp->hdl_cnt_mtx,
-			     0, !(flags & O_CLOEXEC), DUPLICATE_SAME_ACCESS))
-    {
-      __seterrno ();
-      ftp->close ();
-      res = -1;
-    }
-  else if (query_hdl_close_req_evt &&
-	   !DuplicateHandle (GetCurrentProcess (), query_hdl_close_req_evt,
-			     GetCurrentProcess (),
-			     &ftp->query_hdl_close_req_evt,
-			     0, !(flags & O_CLOEXEC), DUPLICATE_SAME_ACCESS))
-    {
-      __seterrno ();
-      ftp->close ();
-      res = -1;
-    }
-  ReleaseMutex (hdl_cnt_mtx);
 
   debug_printf ("res %d", res);
   return res;
@@ -731,16 +656,7 @@ fhandler_pipe::close ()
     }
   if (read_mtx)
     CloseHandle (read_mtx);
-  WaitForSingleObject (hdl_cnt_mtx, INFINITE);
-  if (query_hdl)
-    CloseHandle (query_hdl);
-  if (query_hdl_close_req_evt)
-    CloseHandle (query_hdl_close_req_evt);
   int ret = fhandler_base::close ();
-  ReleaseMutex (hdl_cnt_mtx);
-  CloseHandle (hdl_cnt_mtx);
-  if (query_hdl_proc)
-    CloseHandle (query_hdl_proc);
   return ret;
 }
 
@@ -955,39 +871,9 @@ fhandler_pipe::create (fhandler_pipe *fhs[2], unsigned psize, int mode)
 			0, sa->bInheritHandle, DUPLICATE_SAME_ACCESS))
     goto err_close_select_sem0;
 
-  if (is_running_as_service () &&
-      !DuplicateHandle (GetCurrentProcess (), r,
-			GetCurrentProcess (), &fhs[1]->query_hdl,
-			FILE_READ_DATA, sa->bInheritHandle, 0))
-    goto err_close_select_sem1;
-
-  fhs[0]->hdl_cnt_mtx = CreateMutexW (sa, FALSE, NULL);
-  if (!fhs[0]->hdl_cnt_mtx)
-    goto err_close_query_hdl;
-  if (!DuplicateHandle (GetCurrentProcess (), fhs[0]->hdl_cnt_mtx,
-			GetCurrentProcess (), &fhs[1]->hdl_cnt_mtx,
-			0, sa->bInheritHandle, DUPLICATE_SAME_ACCESS))
-    goto err_close_hdl_cnt_mtx0;
-
-  if (fhs[1]->query_hdl)
-    {
-      fhs[1]->query_hdl_close_req_evt = CreateEvent (sa, TRUE, FALSE, NULL);
-      if (!fhs[1]->query_hdl_close_req_evt)
-	goto err_close_hdl_cnt_mtx1;
-    }
-
   res = 0;
   goto out;
 
-err_close_hdl_cnt_mtx1:
-  CloseHandle (fhs[1]->hdl_cnt_mtx);
-err_close_hdl_cnt_mtx0:
-  CloseHandle (fhs[0]->hdl_cnt_mtx);
-err_close_query_hdl:
-  if (fhs[1]->query_hdl)
-    CloseHandle (fhs[1]->query_hdl);
-err_close_select_sem1:
-  CloseHandle (fhs[1]->select_sem);
 err_close_select_sem0:
   CloseHandle (fhs[0]->select_sem);
 err_close_read_mtx:
@@ -1174,22 +1060,6 @@ fhandler_pipe::ioctl (unsigned int cmd, void *p)
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
@@ -1210,190 +1080,3 @@ fhandler_pipe::fstatvfs (struct statvfs *sfs)
   set_errno (EBADF);
   return -1;
 }
-
-HANDLE
-fhandler_pipe::temporary_query_hdl ()
-{
-  if (get_dev () != FH_PIPEW)
-    return NULL;
-
-  ULONG len;
-  NTSTATUS status;
-  tmp_pathbuf tp;
-  OBJECT_NAME_INFORMATION *ntfn = (OBJECT_NAME_INFORMATION *) tp.w_get ();
-
-  UNICODE_STRING *name = pc.get_nt_native_path (NULL);
-
-  /* Try process handle opened and pipe handle value cached first
-     in order to reduce overhead. */
-  if (query_hdl_proc && query_hdl_value)
-    {
-      HANDLE h;
-      if (!DuplicateHandle (query_hdl_proc, query_hdl_value,
-			   GetCurrentProcess (), &h, FILE_READ_DATA, 0, 0))
-	goto cache_err;
-      /* Check name */
-      status = NtQueryObject (h, ObjectNameInformation, ntfn, 65536, &len);
-      if (!NT_SUCCESS (status) || !ntfn->Name.Buffer)
-	goto hdl_err;
-      if (RtlEqualUnicodeString (name, &ntfn->Name, FALSE))
-	return h;
-hdl_err:
-      CloseHandle (h);
-cache_err:
-      CloseHandle (query_hdl_proc);
-      query_hdl_proc = NULL;
-      query_hdl_value = NULL;
-    }
-
-  if (name->Length == 0 || name->Buffer == NULL)
-    return NULL; /* Non cygwin pipe? */
-  return get_query_hdl_per_process (ntfn); /* Since Win8 */
-}
-
-HANDLE
-fhandler_pipe::get_query_hdl_per_process (OBJECT_NAME_INFORMATION *ntfn)
-{
-  winpids pids ((DWORD) 0);
-
-  /* In most cases, it is faster to check the processes in reverse order. */
-  for (LONG i = (LONG) pids.npids - 1; i >= 0; i--)
-    {
-      NTSTATUS status;
-      ULONG len;
-
-      /* Non-cygwin app may call ReadFile() for empty pipe, which makes
-	NtQueryObject() for ObjectNameInformation block. Therefore, do
-	not try to get query_hdl for non-cygwin apps. */
-      _pinfo *p = pids[i];
-      if (!p || ISSTATE (p, PID_NOTCYGWIN))
-	continue;
-
-      HANDLE proc = OpenProcess (PROCESS_DUP_HANDLE
-				 | PROCESS_QUERY_INFORMATION,
-				 0, p->dwProcessId);
-      if (!proc)
-	continue;
-
-      /* Retrieve process handles */
-      DWORD n_handle = 256;
-      PPROCESS_HANDLE_SNAPSHOT_INFORMATION phi;
-      do
-	{
-	  DWORD nbytes = 2 * sizeof (ULONG_PTR) +
-	    n_handle * sizeof (PROCESS_HANDLE_TABLE_ENTRY_INFO);
-	  phi = (PPROCESS_HANDLE_SNAPSHOT_INFORMATION)
-	    HeapAlloc (GetProcessHeap (), 0, nbytes);
-	  if (!phi)
-	    goto close_proc;
-	  /* NtQueryInformationProcess can return STATUS_SUCCESS with
-	     invalid handle data for certain processes.  See
-	     https://github.com/processhacker/processhacker/blob/05f5e9fa477dcaa1709d9518170d18e1b3b8330d/phlib/native.c#L5754.
-	     We need to ensure that NumberOfHandles is zero in this
-	     case to avoid a crash in the for loop below. */
-	  phi->NumberOfHandles = 0;
-	  status = NtQueryInformationProcess (proc, ProcessHandleInformation,
-					      phi, nbytes, &len);
-	  if (NT_SUCCESS (status))
-	    break;
-	  HeapFree (GetProcessHeap (), 0, phi);
-	  n_handle *= 2;
-	}
-      while (n_handle < (1L<<20) && status == STATUS_INFO_LENGTH_MISMATCH);
-      if (!NT_SUCCESS (status))
-	goto close_proc;
-
-      /* Sanity check in case Microsoft changes
-	 NtQueryInformationProcess and the initialization of
-	 NumberOfHandles above is no longer sufficient. */
-      assert (phi->NumberOfHandles <= n_handle);
-      for (ULONG j = 0; j < phi->NumberOfHandles; j++)
-	{
-	  /* Check for the peculiarity of cygwin read pipe */
-	  const ULONG access = FILE_READ_DATA | FILE_READ_EA
-	    | FILE_WRITE_EA /* marker */
-	    | FILE_READ_ATTRIBUTES | FILE_WRITE_ATTRIBUTES
-	    | READ_CONTROL | SYNCHRONIZE;
-	  if (phi->Handles[j].GrantedAccess != access)
-	    continue;
-
-	  /* Retrieve handle */
-	  HANDLE h = (HANDLE)(intptr_t) phi->Handles[j].HandleValue;
-	  BOOL res = DuplicateHandle (proc, h, GetCurrentProcess (), &h,
-				      FILE_READ_DATA, 0, 0);
-	  if (!res)
-	    continue;
-
-	  /* Check object name */
-	  status = NtQueryObject (h, ObjectNameInformation,
-				  ntfn, 65536, &len);
-	  if (!NT_SUCCESS (status) || !ntfn->Name.Buffer)
-	    goto close_handle;
-	  if (RtlEqualUnicodeString (pc.get_nt_native_path (),
-				     &ntfn->Name, FALSE))
-	    {
-	      query_hdl_proc = proc;
-	      query_hdl_value = (HANDLE)(intptr_t) phi->Handles[j].HandleValue;
-	      HeapFree (GetProcessHeap (), 0, phi);
-	      return h;
-	    }
-close_handle:
-	  CloseHandle (h);
-	}
-      HeapFree (GetProcessHeap (), 0, phi);
-close_proc:
-      CloseHandle (proc);
-    }
-  return NULL;
-}
-
-void
-fhandler_pipe::spawn_worker (int fileno_stdin, int fileno_stdout,
-			     int fileno_stderr)
-{
-  bool need_send_noncygchld_sig = false;
-
-  /* spawn_worker() is called from spawn.cc only when non-cygwin app
-     is started. Set pipe mode blocking for the non-cygwin process. */
-  int fd;
-  cygheap_fdenum cfd (false);
-  while ((fd = cfd.next ()) >= 0)
-    if (cfd->get_dev () == FH_PIPEW
-	&& (fd == fileno_stdout || fd == fileno_stderr))
-      {
-	fhandler_pipe *pipe = (fhandler_pipe *)(fhandler_base *) cfd;
-	pipe->set_pipe_non_blocking (false);
-
-	/* Setup for query_ndl stuff. Read the comment below. */
-	if (pipe->request_close_query_hdl ())
-	  need_send_noncygchld_sig = true;
-      }
-    else if (cfd->get_dev () == FH_PIPER && fd == fileno_stdin)
-      {
-	fhandler_pipe *pipe = (fhandler_pipe *)(fhandler_base *) cfd;
-	pipe->set_pipe_non_blocking (false);
-      }
-
-  /* If multiple writers including non-cygwin app exist, the non-cygwin
-     app cannot detect pipe closure on the read side when the pipe is
-     created by system account or the pipe creator is running as service.
-     This is because query_hdl which is held in write side also is a read
-     end of the pipe, so the pipe is still alive for the non-cygwin app
-     even after the reader is closed.
-
-     To avoid this problem, let all processes in the same process
-     group close query_hdl using internal signal __SIGNONCYGCHLD when
-     non-cygwin app is started.  */
-  if (need_send_noncygchld_sig)
-    {
-      tty_min dummy_tty;
-      dummy_tty.ntty = (fh_devices) myself->ctty;
-      dummy_tty.pgid = myself->pgid;
-      tty_min *t = cygwin_shared->tty.get_cttyp ();
-      if (!t) /* If tty is not allocated, use dummy_tty instead. */
-	t = &dummy_tty;
-      /* Emit __SIGNONCYGCHLD to let all processes in the
-	 process group close query_hdl. */
-      t->kill_pgrp (__SIGNONCYGCHLD);
-    }
-}
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 1c339cfbc..20190ae93 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -1211,13 +1211,7 @@ class fhandler_pipe: public fhandler_pipe_fifo
 private:
   HANDLE read_mtx;
   pid_t popen_pid;
-  HANDLE query_hdl;
-  HANDLE hdl_cnt_mtx;
-  HANDLE query_hdl_proc;
-  HANDLE query_hdl_value;
-  HANDLE query_hdl_close_req_evt;
   void release_select_sem (const char *);
-  HANDLE get_query_hdl_per_process (OBJECT_NAME_INFORMATION *);
 public:
   fhandler_pipe ();
 
@@ -1234,13 +1228,11 @@ public:
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
@@ -1265,39 +1257,7 @@ public:
     fh->copy_from (this);
     return fh;
   }
-  void set_pipe_non_blocking (bool nonblocking);
-  HANDLE get_query_handle () const { return query_hdl; }
-  void close_query_handle ()
-  {
-    if (query_hdl)
-      {
-	CloseHandle (query_hdl);
-	query_hdl = NULL;
-      }
-    if (query_hdl_close_req_evt)
-      {
-	CloseHandle (query_hdl_close_req_evt);
-	query_hdl_close_req_evt = NULL;
-      }
-  }
-  bool reader_closed ();
-  HANDLE temporary_query_hdl ();
-  bool need_close_query_hdl ()
-    {
-      return query_hdl_close_req_evt ?
-	IsEventSignalled (query_hdl_close_req_evt) : false;
-    }
-  bool request_close_query_hdl ()
-    {
-      if (query_hdl_close_req_evt)
-	{
-	  SetEvent (query_hdl_close_req_evt);
-	  return true;
-	}
-      return false;
-    }
-  static void spawn_worker (int fileno_stdin, int fileno_stdout,
-			    int fileno_stderr);
+  bool set_pipe_non_blocking (bool nonblocking);
 };
 
 #define CYGWIN_FIFO_PIPE_NAME_LEN     47
diff --git a/winsup/cygwin/local_includes/sigproc.h b/winsup/cygwin/local_includes/sigproc.h
index 7aca80595..46e26db19 100644
--- a/winsup/cygwin/local_includes/sigproc.h
+++ b/winsup/cygwin/local_includes/sigproc.h
@@ -24,7 +24,6 @@ enum
   __SIGSETPGRP	    = -(_NSIG + 9),
   __SIGTHREADEXIT   = -(_NSIG + 10),
   __SIGPENDINGALL   = -(_NSIG + 11),
-  __SIGNONCYGCHLD   = -(_NSIG + 12),
 };
 #endif
 
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index bc02c3f9d..7df38e052 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -642,7 +642,7 @@ pipe_data_available (int fd, fhandler_base *fh, HANDLE h, int flags)
         Consequentially, the only reliable information is available on the
         read side, so fetch info from the read side via the pipe-specific
         query handle.  Use fpli.WriteQuotaAvailable as storage for the actual
-        interesting value, which is the InboundQuote on the write side,
+        interesting value, which is the IutboundQuota on the write side,
         decremented by the number of bytes of data in that buffer. */
       /* Note: Do not use NtQueryInformationFile() for query_hdl because
 	 NtQueryInformationFile() seems to interfere with reading pipes
@@ -655,19 +655,17 @@ pipe_data_available (int fd, fhandler_base *fh, HANDLE h, int flags)
 	 handling this fact. */
       if (fh->get_device () == FH_PIPEW && fpli.WriteQuotaAvailable == 0)
 	{
-	  HANDLE query_hdl = ((fhandler_pipe *) fh)->get_query_handle ();
-	  if (!query_hdl)
-	    query_hdl = ((fhandler_pipe *) fh)->temporary_query_hdl ();
-	  if (!query_hdl) /* We cannot know actual write pipe space. */
-	    return (flags & PDA_SELECT) ? PIPE_BUF : 1;
-	  DWORD nbytes_in_pipe;
-	  BOOL res =
-	    PeekNamedPipe (query_hdl, NULL, 0, NULL, &nbytes_in_pipe, NULL);
-	  if (!((fhandler_pipe *) fh)->get_query_handle ())
-	    CloseHandle (query_hdl); /* Close temporary query_hdl */
-	  if (!res) /* We cannot know actual write pipe space. */
-	    return (flags & PDA_SELECT) ? PIPE_BUF : 1;
-	  fpli.WriteQuotaAvailable = fpli.InboundQuota - nbytes_in_pipe;
+	  /* NtSetInformationFile() in set_pipe_non_blocking(true)
+	     seems to fail for unknown reasons with STATUS_PIPE_BUSY
+	     if no reader is reading the pipe. In this case, the pipe
+	     is really full if WriteQuotaAvailable is zero. Otherwise,
+	     the pipe is empty. */
+	  if (!((fhandler_pipe *) fh)->set_pipe_non_blocking (true))
+	    return 0; /* Full */
+	  /* Restore pipe mode to blocking mode */
+	  ((fhandler_pipe *) fh)->set_pipe_non_blocking (false);
+	  /* Empty */
+	  fpli.WriteQuotaAvailable = fpli.InboundQuota;
 	}
       if (fpli.WriteQuotaAvailable > 0)
 	{
diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 99fa3c342..81b6c3169 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -1474,16 +1474,6 @@ wait_sig (VOID *)
 		clearwait = true;
 	    }
 	  break;
-	case __SIGNONCYGCHLD:
-	  cygheap_fdenum cfd (false);
-	  while (cfd.next () >= 0)
-	    if (cfd->get_dev () == FH_PIPEW)
-	      {
-		fhandler_pipe *pipe = (fhandler_pipe *)(fhandler_base *) cfd;
-		if (pipe->need_close_query_hdl ())
-		  pipe->close_query_handle ();
-	      }
-	  break;
 	}
       if (clearwait && !have_execed)
 	proc_subproc (PROC_CLEARWAIT, 0);
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 3da77088d..89404c464 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -579,10 +579,6 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
       int fileno_stdout = in__stdout < 0 ? 1 : in__stdout;
       int fileno_stderr = 2;
 
-      if (!iscygwin ())
-	fhandler_pipe::spawn_worker (fileno_stdin, fileno_stdout,
-				     fileno_stderr);
-
       bool no_pcon = mode != _P_OVERLAY && mode != _P_WAIT;
       term_spawn_worker.setup (iscygwin (), handle (fileno_stdin, false),
 			       runpath, no_pcon, reset_sendsig, envblock);
-- 
2.45.1

