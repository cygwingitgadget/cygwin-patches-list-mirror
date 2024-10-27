Return-Path: <SRS0=KPxw=RX=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [106.153.227.177])
	by sourceware.org (Postfix) with ESMTPS id 4249F3858D34
	for <cygwin-patches@cygwin.com>; Sun, 27 Oct 2024 08:57:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4249F3858D34
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4249F3858D34
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.177
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1730019434; cv=none;
	b=gaj24/nuTmMduhMU4DSSCHeNqWQhFoLHPyeJikcRQXU5FjQ1WQeZu8Oz+TYRso0o+Bj+Jka9U02sUsm08X/h04TdMkDMDTrpC89T9HDosz8Darr1v8OVXXyYdwfwV7OjngWwPFKP1D1E7vRPbGp/scf+XbdwoSvghqHnbLDi+EE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1730019434; c=relaxed/simple;
	bh=e4T4N0v2oQU6iIBh5Ysjjg9mAmNDRczYc0KTIl0qcy4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=kvpqZ6EnGslVF1tqSP/H4yaO3Y35A3NAnEfsC8r6VisY3AtAAs5Vhjcqk1K9hBi/t6YNK3aOoN7guBFpDCpJXEvMAERbc98JlWJ709y0Ajx8t1tB9KiVy6Nmv1DtulzKeaJmIiN8j1xED5hSN960tYTYdTYNvb1xe4ri1P6qRA0=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-e01.mail.nifty.com
          with ESMTP
          id <20241027085705022.HDVV.87244.localhost.localdomain@nifty.com>;
          Sun, 27 Oct 2024 17:57:05 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	isaacag,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v9] Cygwin: pipe: Switch pipe mode to blocking mode by default
Date: Sun, 27 Oct 2024 17:56:43 +0900
Message-ID: <20241027085650.1509-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1730019425;
 bh=FJJ3XYzBNrYi1XbQegIv9+b44w1nPZVbuTIphK7AW1U=;
 h=From:To:Cc:Subject:Date;
 b=ib9WsNRJsCuoIDM4CMXa84lcQGXKw3P0hCZvFDJUqtejrl7Ug2HgMgntxhmQk4YkeUWRI16o
 a3wrqwV82Bky83vp2uHrhIZM1zRyI2k2eC+E7LlgVOUfDDS4+5Nke80IVKP1KpfPSV2sF+/glg
 UE9PLyxP29YfhNmMvDTndzwlBeP8lean0IqYVUWj1yjPrU7J5khUDI7yMlDWbo7qVQaLoGG4kk
 bkOJow9zyUtVA6gMxv2tmWP6GOfhwYtZds/sSjcKe/GAupzU+E1ZefkErWi3Af420Ylxa5OGlN
 wcRKcTI26obvtfoDNeyIv5pQDGM4GP4lSJ9gno85qRLb+hIg==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, cygwin read pipe used non-blocking mode although non-
cygwin app uses blocking-mode by default. Despite this requirement,
if a cygwin app is executed from a non-cygwin app and the cygwin
app exits, read pipe remains on non-blocking mode because of the
commit fc691d0246b9. Due to this behaviour, the non-cygwin app
cannot read the pipe correctly after that. Similarly, if a non-
cygwin app is executed from a cygwin app and the non-cygwin app
exits, the read pipe mode remains on blocking mode although cygwin
read pipe should be non-blocking mode.

These bugs were provoked by pipe mode toggling between cygwin and
non-cygwin apps. To make management of pipe mode simpler, this
patch has re-designed the pipe implementation. In this new
implementation, both read and write pipe basically use only blocking
mode and the behaviour corresponding to the pipe mode is simulated
in raw_read() and raw_write(). Only when NtQueryInformationFile
(FilePipeLocalInformation) fails for some reasons, the raw_read()/
raw_write() cannot simulate non-blocking access. Therefore, the pipe
mode is temporarily changed to non-blocking mode.

Moreover, because the fact that NtSetInformationFile() in
set_pipe_non_blocking(true) fails with STATUS_PIPE_BUSY if the pipe
is not empty has been found, query handle is not necessary anymore.
This allows the implementation much simpler than before.

Addresses: https://github.com/git-for-windows/git/issues/5115
Fixes: fc691d0246b9 ("Cygwin: pipe: Make sure to set read pipe non-blocking for cygwin apps.");
Reported-by: isaacag, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Reviewed-by: Corinna Vinschen <corinna@vinschen.de>, Ken Brown <kbrown@cornell.edu>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/dtable.cc                 |   5 +-
 winsup/cygwin/fhandler/pipe.cc          | 665 +++++++++---------------
 winsup/cygwin/local_includes/fhandler.h |  44 +-
 winsup/cygwin/local_includes/sigproc.h  |   1 -
 winsup/cygwin/select.cc                 |  46 +-
 winsup/cygwin/sigproc.cc                |  10 -
 winsup/cygwin/spawn.cc                  |   4 -
 7 files changed, 256 insertions(+), 519 deletions(-)

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
index c686df650..18357f7e2 100644
--- a/winsup/cygwin/fhandler/pipe.cc
+++ b/winsup/cygwin/fhandler/pipe.cc
@@ -31,7 +31,7 @@ STATUS_PIPE_EMPTY simply means there's no data to be read. */
 		   || _s == STATUS_PIPE_EMPTY; })
 
 fhandler_pipe_fifo::fhandler_pipe_fifo ()
-  : fhandler_base (), pipe_buf_size (DEFAULT_PIPEBUFSIZE)
+  : fhandler_base (), pipe_buf_size (DEFAULT_PIPEBUFSIZE), pipe_mtx (NULL)
 {
 }
 
@@ -48,7 +48,7 @@ fhandler_pipe::fhandler_pipe ()
 
    In addition to setting the blocking mode of the pipe handle, it
    also sets the pipe's read mode to byte_stream unconditionally. */
-void
+NTSTATUS
 fhandler_pipe::set_pipe_non_blocking (bool nonblocking)
 {
   NTSTATUS status;
@@ -62,6 +62,7 @@ fhandler_pipe::set_pipe_non_blocking (bool nonblocking)
 				 FilePipeInformation);
   if (!NT_SUCCESS (status))
     debug_printf ("NtSetInformationFile(FilePipeInformation): %y", status);
+  return status;
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
@@ -211,42 +198,51 @@ out:
   return 0;
 }
 
+extern "C" int swscanf (const wchar_t *, const wchar_t *, ...);
+
+static char *
+get_mtx_name (HANDLE h, const char *io, char *name)
+{
+  ULONG len;
+  NTSTATUS status;
+  tmp_pathbuf tp;
+  OBJECT_NAME_INFORMATION *ntfn = (OBJECT_NAME_INFORMATION *) tp.w_get ();
+  DWORD pid;
+  LONG uniq_id;
+
+  status = NtQueryObject (h, ObjectNameInformation, ntfn, 65536, &len);
+  if (!NT_SUCCESS (status) || !ntfn->Name.Buffer)
+    return NULL;
+  ntfn->Name.Buffer[ntfn->Name.Length / sizeof (WCHAR)] = L'\0';
+  WCHAR *p = wcschr (ntfn->Name.Buffer, L'-');
+  if (p == NULL)
+    return NULL;
+  if (2 != swscanf (p, L"-%u-pipe-nt-0x%x", &pid, &uniq_id))
+    return NULL;
+  __small_sprintf (name, "cygpipe.%s.mutex.%u-%p",
+		   io, pid, (intptr_t) uniq_id);
+  return name;
+}
+
 bool
 fhandler_pipe::open_setup (int flags)
 {
-  bool read_mtx_created = false;
-
   if (!fhandler_base::open_setup (flags))
-    goto err;
-  if (get_dev () == FH_PIPER && !read_mtx)
-    {
-      SECURITY_ATTRIBUTES *sa = sec_none_cloexec (flags);
-      read_mtx = CreateMutex (sa, FALSE, NULL);
-      if (read_mtx)
-	read_mtx_created = true;
-      else
-	{
-	  debug_printf ("CreateMutex read_mtx failed: %E");
-	  goto err;
-	}
-    }
-  if (!hdl_cnt_mtx)
+    return false;
+  if (!pipe_mtx)
     {
       SECURITY_ATTRIBUTES *sa = sec_none_cloexec (flags);
-      hdl_cnt_mtx = CreateMutex (sa, FALSE, NULL);
-      if (!hdl_cnt_mtx)
+      char name[MAX_PATH];
+      const char *io = get_device () == FH_PIPER ? "input" : "output";
+      char *mtx_name = get_mtx_name (get_handle (), io, name);
+      pipe_mtx = CreateMutex (sa, FALSE, mtx_name);
+      if (!pipe_mtx)
 	{
-	  debug_printf ("CreateMutex hdl_cnt_mtx failed: %E");
-	  goto err_close_read_mtx;
+	  debug_printf ("CreateMutex pipe_mtx failed: %E");
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
@@ -279,12 +275,7 @@ fhandler_pipe::get_proc_fd_name (char *buf)
 void
 fhandler_pipe::release_select_sem (const char *from)
 {
-  LONG n_release;
-  if (get_dev () == FH_PIPER) /* Number of select() and writer */
-    n_release = get_obj_handle_count (select_sem)
-      - get_obj_handle_count (read_mtx);
-  else /* Number of select() call and reader */
-    n_release = get_obj_handle_count (select_sem)
+  LONG n_release = get_obj_handle_count (select_sem)
       - get_obj_handle_count (get_handle ());
   debug_printf("%s(%s) release %d", from,
 	       get_dev () == FH_PIPER ? "PIPER" : "PIPEW", n_release);
@@ -305,7 +296,7 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
     return;
 
   DWORD timeout = is_nonblocking () ? 0 : INFINITE;
-  DWORD waitret = cygwait (read_mtx, timeout);
+  DWORD waitret = cygwait (pipe_mtx, timeout);
   switch (waitret)
     {
     case WAIT_OBJECT_0:
@@ -332,6 +323,7 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
       ULONG_PTR nbytes_now = 0;
       ULONG len1 = (ULONG) (len - nbytes);
       DWORD select_sem_timeout = 0;
+      bool real_non_blocking_mode = false;
 
       FILE_PIPE_LOCAL_INFORMATION fpli;
       status = NtQueryInformationFile (get_handle (), &io,
@@ -339,13 +331,66 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
 				       FilePipeLocalInformation);
       if (NT_SUCCESS (status))
 	{
-	  if (fpli.ReadDataAvailable == 0 && nbytes != 0)
-	    break;
+	  if (fpli.ReadDataAvailable == 0)
+	    {
+	      if (fpli.NamedPipeState == FILE_PIPE_CLOSING_STATE)
+		/* EOF */
+		break;
+	      if (nbytes != 0)
+		break;
+	      if (is_nonblocking ())
+		{
+		  set_errno (EAGAIN);
+		  nbytes = (size_t) -1;
+		  break;
+		}
+	      /* If the pipe is a non-cygwin pipe, select_sem trick
+		 does not work. As a result, the following cygwait()
+		 will return only after timeout occurs. This causes
+		 performance degradation. However, setting timeout
+		 to zero causes high CPU load. So, set timeout to
+		 non-zero only when select_sem is valid or pipe is
+		 not ready to read for more than t0_threshold.
+		 This prevents both the performance degradation and
+		 the high CPU load. */
+	      if (select_sem || GetTickCount64 () - t0 > t0_threshold)
+		select_sem_timeout = 1;
+	      waitret = cygwait (select_sem, select_sem_timeout);
+	      if (waitret == WAIT_CANCELED)
+		pthread::static_cancel_self ();
+	      else if (waitret == WAIT_SIGNALED)
+		{
+		  set_errno (EINTR);
+		  nbytes = (size_t) -1;
+		  break;
+		}
+	      continue;
+	    }
 	}
       else if (nbytes != 0)
 	break;
+      else if (status == STATUS_END_OF_FILE || status == STATUS_PIPE_BROKEN)
+	/* EOF */
+	break;
+      else if (!NT_SUCCESS (status) && is_nonblocking ())
+	{
+	  status = set_pipe_non_blocking (true);
+	  if (status == STATUS_END_OF_FILE || status == STATUS_PIPE_BROKEN)
+	    /* EOF */
+	    break;
+	  if (!NT_SUCCESS (status))
+	    {
+	      /* Cannot continue. What should we do? */
+	      set_errno (EIO);
+	      nbytes = (size_t) -1;
+	      break;
+	    }
+	  real_non_blocking_mode = true;
+	}
       status = NtReadFile (get_handle (), NULL, NULL, NULL, &io, ptr,
 			   len1, NULL, NULL);
+      if (real_non_blocking_mode)
+	set_pipe_non_blocking (false);
       if (isclosed ())  /* A signal handler might have closed the fd. */
 	{
 	  set_errno (EBADF);
@@ -370,35 +415,12 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
 	      break;
 	    case STATUS_PIPE_LISTENING:
 	    case STATUS_PIPE_EMPTY:
+	      /* Only for real_non_blocking_mode */
 	      if (nbytes != 0)
 		break;
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
+	      set_errno (EAGAIN);
+	      nbytes = (size_t) -1;
+	      break;
 	    default:
 	      __seterrno_from_nt_status (status);
 	      nbytes = (size_t) -1;
@@ -410,22 +432,10 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
 	  || status == STATUS_BUFFER_OVERFLOW)
 	break;
     }
-  ReleaseMutex (read_mtx);
+  ReleaseMutex (pipe_mtx);
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
@@ -439,24 +449,100 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
   if (!len)
     return 0;
 
-  if (reader_closed ())
+  ssize_t avail = pipe_buf_size;
+  bool real_non_blocking_mode = false;
+
+  if (pipe_mtx) /* pipe_mtx is NULL in the fifo case */
+    {
+      DWORD timeout = is_nonblocking () ? 0 : INFINITE;
+      DWORD waitret = cygwait (pipe_mtx, timeout);
+      switch (waitret)
+	{
+	case WAIT_OBJECT_0:
+	  break;
+	case WAIT_TIMEOUT:
+	  set_errno (EAGAIN);
+	  return -1;
+	case WAIT_SIGNALED:
+	  set_errno (EINTR);
+	  return -1;
+	case WAIT_CANCELED:
+	  pthread::static_cancel_self ();
+	  /* NOTREACHED */
+	default:
+	  /* Should not reach here. */
+	  __seterrno ();
+	  return -1;
+	}
+    }
+  if (get_device () == FH_PIPEW && is_nonblocking ())
     {
-      set_errno (EPIPE);
-      raise (SIGPIPE);
-      return -1;
+      fhandler_pipe *fh = (fhandler_pipe *) this;
+      FILE_PIPE_LOCAL_INFORMATION fpli;
+      status = NtQueryInformationFile (get_handle (), &io, &fpli, sizeof fpli,
+				       FilePipeLocalInformation);
+      if (NT_SUCCESS (status))
+	{
+	  if (fpli.WriteQuotaAvailable != 0)
+	    avail = fpli.WriteQuotaAvailable;
+	  else /* WriteQuotaAvailable == 0 */
+	    { /* Refer to the comment in select.cc: pipe_data_available(). */
+	      /* NtSetInformationFile() in set_pipe_non_blocking(true) seems
+		 to fail with STATUS_PIPE_BUSY if the pipe is not empty.
+		 In this case, the pipe is really full if WriteQuotaAvailable
+		 is zero. Otherwise, the pipe is empty. */
+	      status = fh->set_pipe_non_blocking (true);
+	      if (NT_SUCCESS (status))
+		/* Pipe should be empty because reader is waiting for data. */
+		/* Restore the pipe mode to blocking. */
+		fh->set_pipe_non_blocking (false);
+	      else if (status == STATUS_PIPE_BUSY)
+		{
+		  /* Full */
+		  set_errno (EAGAIN);
+		  goto err;
+		}
+	    }
+	}
+      else
+	{
+	  /* The pipe space is unknown. */
+	  status = fh->set_pipe_non_blocking (true);
+	  if (NT_SUCCESS (status))
+	    real_non_blocking_mode = true;
+	  else if (status == STATUS_PIPE_BUSY)
+	    {
+	      /* The pipe is not empty and may be full.
+		 It is not safe to write now. */
+	      set_errno (EAGAIN);
+	      goto err;
+	    }
+	}
+      if (STATUS_PIPE_IS_CLOSED (status))
+	{
+	  set_errno (EPIPE);
+	  raise (SIGPIPE);
+	  goto err;
+	}
+      else if (!NT_SUCCESS (status))
+	{
+	  /* Cannot continue. What should we do? */
+	  set_errno (EIO);
+	  goto err;
+	}
     }
 
-  if (len <= pipe_buf_size || pipe_buf_size == 0)
+  if (len <= (size_t) avail || pipe_buf_size == 0)
     chunk = len;
   else if (is_nonblocking ())
     chunk = len = pipe_buf_size;
   else
-    chunk = pipe_buf_size;
+    chunk = avail;
 
   if (!(evt = CreateEvent (NULL, false, false, NULL)))
     {
       __seterrno ();
-      return -1;
+      goto err;
     }
 
   /* Write in chunks, accumulating a total.  If there's an error, just
@@ -497,27 +583,20 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
 	    errno set to [EAGAIN]. */
       while (len1 > 0)
 	{
-	  status = NtWriteFile (get_handle (), evt, NULL, NULL, &io,
-				(PVOID) ptr, len1, NULL, NULL);
+	  if (is_nonblocking() && !real_non_blocking_mode && len1 > avail)
+	    /* Avoid being blocked in NtWriteFile() */
+	    io.Information = 0;
+	  else
+	    status = NtWriteFile (get_handle (), evt, NULL, NULL, &io,
+				  (PVOID) ptr, len1, NULL, NULL);
 	  if (status == STATUS_PENDING)
 	    {
 	      do
 		{
-		  /* To allow constant reader_closed() checking even if the
-		     signal has been set up with SA_RESTART, we're handling
-		     the signal here --> cw_sig_eintr. */
-		  waitret = cygwait (evt, (DWORD) 0, cw_cancel | cw_sig_eintr);
+		  waitret = cygwait (evt, (DWORD) 0);
 		  /* Break out if no SA_RESTART. */
-		  if (waitret == WAIT_SIGNALED
-		      && !_my_tls.call_signal_handler ())
+		  if (waitret == WAIT_SIGNALED)
 		    break;
-		  if (reader_closed ())
-		    {
-		      CancelIo (get_handle ());
-		      set_errno (EPIPE);
-		      raise (SIGPIPE);
-		      goto out;
-		    }
 		  /* Break out on completion */
 		  if (waitret == WAIT_OBJECT_0)
 		    break;
@@ -530,8 +609,7 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
 		    }
 		  cygwait (select_sem, 10, cw_cancel);
 		}
-	      /* Loop in case of blocking write or SA_RESTART */
-	      while (waitret == WAIT_TIMEOUT || waitret == WAIT_SIGNALED);
+	      while (waitret == WAIT_TIMEOUT);
 	      /* If io.Status is STATUS_CANCELLED after CancelIo, IO has
 		 actually been cancelled and io.Information contains the
 		 number of bytes processed so far.
@@ -564,8 +642,7 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
 	     strategy because Linux is filling the pages of a pipe buffer
 	     in a very implementation-defined way we can't emulate, but it
 	     resembles it closely enough to get useful results. */
-	  ssize_t avail = pipe_data_available (-1, this, get_handle (),
-					       PDA_WRITE);
+	  avail = pipe_data_available (-1, this, get_handle (), PDA_WRITE);
 	  if (avail < 1)	/* error or pipe closed */
 	    break;
 	  if (avail > len1)	/* somebody read from the pipe */
@@ -609,55 +686,43 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
       if (nbytes_now == 0 || short_write_once)
 	break;
     }
-out:
+
+  if (real_non_blocking_mode)
+    ((fhandler_pipe *) this)->set_pipe_non_blocking (false);
+
   CloseHandle (evt);
+  if (pipe_mtx) /* pipe_mtx is NULL in the fifo case */
+    ReleaseMutex (pipe_mtx);
   if (status == STATUS_THREAD_SIGNALED && nbytes == 0)
     set_errno (EINTR);
   else if (status == STATUS_THREAD_CANCELED)
     pthread::static_cancel_self ();
   return nbytes ?: -1;
+
+err:
+  if (pipe_mtx)
+    ReleaseMutex (pipe_mtx);
+  return -1;
 }
 
 void
 fhandler_pipe::set_close_on_exec (bool val)
 {
   fhandler_base::set_close_on_exec (val);
-  if (read_mtx)
-    set_no_inheritance (read_mtx, val);
+  if (pipe_mtx)
+    set_no_inheritance (pipe_mtx, val);
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
-  if (read_mtx)
-    fork_fixup (parent, read_mtx, "read_mtx");
+  if (pipe_mtx)
+    fork_fixup (parent, pipe_mtx, "pipe_mtx");
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
@@ -667,12 +732,11 @@ fhandler_pipe::dup (fhandler_base *child, int flags)
   ftp->set_popen_pid (0);
 
   int res = 0;
-  WaitForSingleObject (hdl_cnt_mtx, INFINITE);
   if (fhandler_base::dup (child, flags))
     res = -1;
-  else if (read_mtx &&
-	   !DuplicateHandle (GetCurrentProcess (), read_mtx,
-			     GetCurrentProcess (), &ftp->read_mtx,
+  else if (pipe_mtx &&
+	   !DuplicateHandle (GetCurrentProcess (), pipe_mtx,
+			     GetCurrentProcess (), &ftp->pipe_mtx,
 			     0, !(flags & O_CLOEXEC), DUPLICATE_SAME_ACCESS))
     {
       __seterrno ();
@@ -688,34 +752,6 @@ fhandler_pipe::dup (fhandler_base *child, int flags)
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
@@ -729,18 +765,9 @@ fhandler_pipe::close ()
       release_select_sem ("close");
       CloseHandle (select_sem);
     }
-  if (read_mtx)
-    CloseHandle (read_mtx);
-  WaitForSingleObject (hdl_cnt_mtx, INFINITE);
-  if (query_hdl)
-    CloseHandle (query_hdl);
-  if (query_hdl_close_req_evt)
-    CloseHandle (query_hdl_close_req_evt);
+  if (pipe_mtx)
+    CloseHandle (pipe_mtx);
   int ret = fhandler_base::close ();
-  ReleaseMutex (hdl_cnt_mtx);
-  CloseHandle (hdl_cnt_mtx);
-  if (query_hdl_proc)
-    CloseHandle (query_hdl_proc);
   return ret;
 }
 
@@ -925,7 +952,7 @@ fhandler_pipe::create (fhandler_pipe *fhs[2], unsigned psize, int mode)
   HANDLE r, w;
   SECURITY_ATTRIBUTES *sa = sec_none_cloexec (mode);
   int res = -1;
-  int64_t unique_id;
+  int64_t unique_id = 0; /* Compiler complains if not initialized... */
 
   int ret = nt_create (sa, r, w, psize, &unique_id);
   if (ret)
@@ -941,57 +968,33 @@ fhandler_pipe::create (fhandler_pipe *fhs[2], unsigned psize, int mode)
   fhs[0]->init (r, FILE_CREATE_PIPE_INSTANCE | GENERIC_READ, mode, unique_id);
   fhs[1]->init (w, FILE_CREATE_PIPE_INSTANCE | GENERIC_WRITE, mode, unique_id);
 
-  /* For the read side of the pipe, add a mutex.  See raw_read for the
-     usage. */
-  fhs[0]->read_mtx = CreateMutexW (sa, FALSE, NULL);
-  if (!fhs[0]->read_mtx)
+  char name[MAX_PATH], *mtx_name;
+  mtx_name = get_mtx_name (fhs[0]->get_handle (), "input", name);
+  fhs[0]->pipe_mtx = CreateMutex (sa, FALSE, mtx_name);
+  if (!fhs[0]->pipe_mtx)
     goto err_delete_fhs1;
+  mtx_name = get_mtx_name (fhs[1]->get_handle (), "output", name);
+  fhs[1]->pipe_mtx = CreateMutex (sa, FALSE, mtx_name);
+  if (!fhs[1]->pipe_mtx)
+    goto err_close_pipe_mtx0;
 
   fhs[0]->select_sem = CreateSemaphore (sa, 0, INT32_MAX, NULL);
   if (!fhs[0]->select_sem)
-    goto err_close_read_mtx;
+    goto err_close_pipe_mtx1;
   if (!DuplicateHandle (GetCurrentProcess (), fhs[0]->select_sem,
 			GetCurrentProcess (), &fhs[1]->select_sem,
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
-err_close_read_mtx:
-  CloseHandle (fhs[0]->read_mtx);
+err_close_pipe_mtx1:
+  CloseHandle (fhs[1]->pipe_mtx);
+err_close_pipe_mtx0:
+  CloseHandle (fhs[0]->pipe_mtx);
 err_delete_fhs1:
   delete fhs[1];
 err_delete_fhs0:
@@ -1038,7 +1041,6 @@ nt_create (LPSECURITY_ATTRIBUTES sa_ptr, HANDLE &r, HANDLE &w,
 				 GetCurrentProcessId ());
 
   access = GENERIC_READ | FILE_WRITE_ATTRIBUTES | SYNCHRONIZE;
-  access |= FILE_WRITE_EA; /* Add this right as a marker of cygwin read pipe */
 
   ULONG pipe_type = pipe_byte ? FILE_PIPE_BYTE_STREAM_TYPE
     : FILE_PIPE_MESSAGE_TYPE;
@@ -1174,22 +1176,6 @@ fhandler_pipe::ioctl (unsigned int cmd, void *p)
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
@@ -1210,190 +1196,3 @@ fhandler_pipe::fstatvfs (struct statvfs *sfs)
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
index 1c339cfbc..24f355e41 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -1197,6 +1197,7 @@ class fhandler_pipe_fifo: public fhandler_base
 {
  protected:
   size_t pipe_buf_size;
+  HANDLE pipe_mtx; /* Used only in the pipe case */
   virtual void release_select_sem (const char *) {};
 
  public:
@@ -1209,15 +1210,8 @@ class fhandler_pipe_fifo: public fhandler_base
 class fhandler_pipe: public fhandler_pipe_fifo
 {
 private:
-  HANDLE read_mtx;
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
+  NTSTATUS set_pipe_non_blocking (bool nonblocking);
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
index bc02c3f9d..a440a98d4 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -639,35 +639,29 @@ pipe_data_available (int fd, fhandler_base *fh, HANDLE h, int flags)
         on the writer side assumes that no space is available in the read
         side inbound buffer.
 
-        Consequentially, the only reliable information is available on the
-        read side, so fetch info from the read side via the pipe-specific
-        query handle.  Use fpli.WriteQuotaAvailable as storage for the actual
-        interesting value, which is the InboundQuote on the write side,
-        decremented by the number of bytes of data in that buffer. */
-      /* Note: Do not use NtQueryInformationFile() for query_hdl because
-	 NtQueryInformationFile() seems to interfere with reading pipes
-	 in non-cygwin apps. Instead, use PeekNamedPipe() here. */
-      /* Note 2: we return the number of available bytes.  Select for writing
-         returns writable *only* if at least PIPE_BUF bytes are left in the
-	 buffer.  If we can't fetch the real number of available bytes, the
-	 number of bytes returned depends on the caller.  For select we return
-	 PIPE_BUF to fake writability, for writing we return 1 to allow
-	 handling this fact. */
+	Consequentially, there are two possibilities when WriteQuotaAvailable
+	is 0. One is that the buffer is really full. The other is that the
+	reader is currently trying to read the pipe and it is pending.
+	In the latter case, the fact that the reader cannot read the data
+	immediately means that the pipe is empty. In the former case,
+	NtSetInformationFile() in set_pipe_non_blocking(true) will fail
+	with STATUS_PIPE_BUSY, while it succeeds in the latter case.
+	Therefore, we can distinguish these cases by calling set_pipe_non_
+	blocking(true). If it returns success, the pipe is empty, so we
+	return the pipe buffer size. Otherwise, we return 0. */
       if (fh->get_device () == FH_PIPEW && fpli.WriteQuotaAvailable == 0)
 	{
-	  HANDLE query_hdl = ((fhandler_pipe *) fh)->get_query_handle ();
-	  if (!query_hdl)
-	    query_hdl = ((fhandler_pipe *) fh)->temporary_query_hdl ();
-	  if (!query_hdl) /* We cannot know actual write pipe space. */
+	  NTSTATUS status =
+	    ((fhandler_pipe *) fh)->set_pipe_non_blocking (true);
+	  if (status == STATUS_PIPE_BUSY)
+	    return 0; /* Full */
+	  else if (!NT_SUCCESS (status))
+	    /* We cannot know actual write pipe space. */
 	    return (flags & PDA_SELECT) ? PIPE_BUF : 1;
-	  DWORD nbytes_in_pipe;
-	  BOOL res =
-	    PeekNamedPipe (query_hdl, NULL, 0, NULL, &nbytes_in_pipe, NULL);
-	  if (!((fhandler_pipe *) fh)->get_query_handle ())
-	    CloseHandle (query_hdl); /* Close temporary query_hdl */
-	  if (!res) /* We cannot know actual write pipe space. */
-	    return (flags & PDA_SELECT) ? PIPE_BUF : 1;
-	  fpli.WriteQuotaAvailable = fpli.InboundQuota - nbytes_in_pipe;
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

