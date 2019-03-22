Return-Path: <cygwin-patches-return-9205-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 112463 invoked by alias); 22 Mar 2019 19:30:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 112433 invoked by uid 89); 22 Mar 2019 19:30:48 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-14.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=HTo:U*cygwin-patches, H*Ad:U*cygwin-patches, indicating, associate
X-HELO: NAM01-BY2-obe.outbound.protection.outlook.com
Received: from mail-eopbgr810112.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) (40.107.81.112) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 22 Mar 2019 19:30:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=kBlaYYuigrEuDxa1TiQkfPGTFVhzpTTe3aIXVlhZr8E=; b=q0RgcSASk09+uFKBw6AdS8ZnU4n0R1saTSUFztBt6Yz3s0nJhg7OFnkV+gFHouBrSLTb28sdJBB0Y2+sLxAWHa+4xY9883BNoPA10imnRZujxGzWyw2G1kyja+N601EhFtWFUaBJ1M0KeB2bpUqG1Klc/0mvOmTLMcmv+hOg8B4=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB5243.namprd04.prod.outlook.com (20.178.25.32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1730.15; Fri, 22 Mar 2019 19:30:36 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d%4]) with mapi id 15.20.1709.017; Fri, 22 Mar 2019 19:30:36 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH fifo 1/8] Cygwin: FIFO: stop using overlapped I/O
Date: Fri, 22 Mar 2019 19:31:00 -0000
Message-ID: <20190322193020.565-2-kbrown@cornell.edu>
References: <20190322193020.565-1-kbrown@cornell.edu>
In-Reply-To: <20190322193020.565-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00021.txt.bz2

Make fhandler_fifo a derived class of fhandler_base instead of
fhandler_base_overlapped.

Replace the create_pipe macro, which is based on
fhandler_pipe::create, by new create_pipe and open_pipe methods.
These use NT functions instead of Win32 functions.  Replace fifo_name
by get_pipe_name, which returns a pointer to a UNICODE_STRING.

Remove the fnevent macro, which would now be needed only once.

Add a raw_write method, adapted from fhandler_base::raw_write.

Adapt all functions to the changes above.
---
 winsup/cygwin/fhandler.h       |  13 +-
 winsup/cygwin/fhandler_fifo.cc | 337 ++++++++++++++++++++++-----------
 2 files changed, 236 insertions(+), 114 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 0da87e985..57e97c277 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1234,14 +1234,21 @@ public:
   }
 };
=20
-class fhandler_fifo: public fhandler_base_overlapped
+#define CYGWIN_FIFO_PIPE_NAME_LEN     47
+
+class fhandler_fifo: public fhandler_base
 {
   HANDLE read_ready;
   HANDLE write_ready;
+  UNICODE_STRING pipe_name;
+  WCHAR pipe_name_buf[CYGWIN_FIFO_PIPE_NAME_LEN + 1];
   bool __reg2 wait (HANDLE);
-  char __reg2 *fifo_name (char *, const char *);
+  NTSTATUS npfs_handle (HANDLE &);
+  HANDLE create_pipe ();
+  NTSTATUS open_pipe ();
 public:
   fhandler_fifo ();
+  PUNICODE_STRING get_pipe_name ();
   int open (int, mode_t);
   off_t lseek (off_t offset, int whence);
   int close ();
@@ -1249,6 +1256,7 @@ public:
   bool isfifo () const { return true; }
   void set_close_on_exec (bool val);
   void __reg3 raw_read (void *ptr, size_t& ulen);
+  ssize_t __reg3 raw_write (const void *ptr, size_t ulen);
   bool arm (HANDLE h);
   void fixup_after_fork (HANDLE);
   int __reg2 fstatvfs (struct statvfs *buf);
@@ -1262,7 +1270,6 @@ public:
   {
     x->pc.free_strings ();
     *reinterpret_cast<fhandler_fifo *> (x) =3D *this;
-    reinterpret_cast<fhandler_fifo *> (x)->atomic_write_buf =3D NULL;
     x->reset (this);
   }
=20
diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index 5733ec778..cb269e344 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -7,6 +7,7 @@
    details. */
=20
 #include "winsup.h"
+#include <w32api/winioctl.h>
 #include "miscfuncs.h"
=20
 #include "cygerrno.h"
@@ -21,26 +22,32 @@
 #include "ntdll.h"
 #include "cygwait.h"
=20
+/* This is only to be used for writers.  When reading,
+STATUS_PIPE_EMPTY simply means there's no data to be read. */
+#define STATUS_PIPE_IS_CLOSED(status)	\
+		({ NTSTATUS _s =3D (status); \
+		   _s =3D=3D STATUS_PIPE_CLOSING \
+		   || _s =3D=3D STATUS_PIPE_BROKEN \
+		   || _s =3D=3D STATUS_PIPE_EMPTY; })
+
 fhandler_fifo::fhandler_fifo ():
-  fhandler_base_overlapped (),
+  fhandler_base (),
   read_ready (NULL), write_ready (NULL)
 {
-  max_atomic_write =3D DEFAULT_PIPEBUFSIZE;
+  pipe_name_buf[0] =3D L'\0';
   need_fork_fixup (true);
 }
=20
-#define fnevent(w) fifo_name (npbuf, w "-event")
-#define fnpipe() fifo_name (npbuf, "fifo")
-#define create_pipe(r, w) \
-  fhandler_pipe::create (sa_buf, (r), (w), 0, fnpipe (), open_mode)
-
-char *
-fhandler_fifo::fifo_name (char *buf, const char *what)
+PUNICODE_STRING
+fhandler_fifo::get_pipe_name ()
 {
-  /* Generate a semi-unique name to associate with this fifo. */
-  __small_sprintf (buf, "%s.%08x.%016X", what, get_dev (),
-		   get_ino ());
-  return buf;
+  if (!pipe_name_buf[0])
+    {
+      __small_swprintf (pipe_name_buf, L"%S-fifo.%08x.%016X",
+			&cygheap->installation_key, get_dev (), get_ino ());
+      RtlInitUnicodeString (&pipe_name, pipe_name_buf);
+    }
+  return &pipe_name;
 }
=20
 inline PSECURITY_ATTRIBUTES
@@ -56,10 +63,8 @@ fhandler_fifo::arm (HANDLE h)
   const char *what;
   if (h =3D=3D read_ready)
     what =3D "reader";
-  else if (h =3D=3D write_ready)
-    what =3D "writer";
   else
-    what =3D "overlapped event";
+    what =3D "writer";
   debug_only_printf ("arming %s", what);
 #endif
=20
@@ -73,17 +78,113 @@ fhandler_fifo::arm (HANDLE h)
   return res;
 }
=20
+NTSTATUS
+fhandler_fifo::npfs_handle (HANDLE &nph)
+{
+  static NO_COPY SRWLOCK npfs_lock;
+  static NO_COPY HANDLE npfs_dirh;
+
+  NTSTATUS status =3D STATUS_SUCCESS;
+  OBJECT_ATTRIBUTES attr;
+  IO_STATUS_BLOCK io;
+
+  /* Lockless after first call. */
+  if (npfs_dirh)
+    {
+      nph =3D npfs_dirh;
+      return STATUS_SUCCESS;
+    }
+  AcquireSRWLockExclusive (&npfs_lock);
+  if (!npfs_dirh)
+    {
+      InitializeObjectAttributes (&attr, &ro_u_npfs, 0, NULL, NULL);
+      status =3D NtOpenFile (&npfs_dirh, FILE_READ_ATTRIBUTES | SYNCHRONIZ=
E,
+			   &attr, &io, FILE_SHARE_READ | FILE_SHARE_WRITE,
+			   0);
+    }
+  ReleaseSRWLockExclusive (&npfs_lock);
+  if (NT_SUCCESS (status))
+    nph =3D npfs_dirh;
+  return status;
+}
+
+/* Called when pipe is opened for reading. */
+HANDLE
+fhandler_fifo::create_pipe ()
+{
+  NTSTATUS status;
+  HANDLE npfsh;
+  HANDLE ph =3D NULL;
+  ACCESS_MASK access;
+  OBJECT_ATTRIBUTES attr;
+  IO_STATUS_BLOCK io;
+  ULONG hattr;
+  ULONG sharing;
+  ULONG nonblocking =3D FILE_PIPE_QUEUE_OPERATION;
+  ULONG max_instances =3D 1;
+  LARGE_INTEGER timeout;
+
+  status =3D npfs_handle (npfsh);
+  if (!NT_SUCCESS (status))
+    {
+      __seterrno_from_nt_status (status);
+      return NULL;
+    }
+  access =3D GENERIC_READ | FILE_READ_ATTRIBUTES | FILE_WRITE_ATTRIBUTES
+    | SYNCHRONIZE;
+  sharing =3D FILE_SHARE_READ | FILE_SHARE_WRITE;
+  hattr =3D OBJ_INHERIT | OBJ_CASE_INSENSITIVE;
+  InitializeObjectAttributes (&attr, get_pipe_name (),
+			      hattr, npfsh, NULL);
+  timeout.QuadPart =3D -500000;
+  status =3D NtCreateNamedPipeFile (&ph, access, &attr, &io, sharing,
+				  FILE_CREATE, 0,
+				  FILE_PIPE_MESSAGE_TYPE,
+				  FILE_PIPE_MESSAGE_MODE,
+				  nonblocking, max_instances,
+				  DEFAULT_PIPEBUFSIZE, DEFAULT_PIPEBUFSIZE,
+				  &timeout);
+  if (!NT_SUCCESS (status))
+    __seterrno_from_nt_status (status);
+  return ph;
+}
+
+/* Called when file is opened for writing. */
+NTSTATUS
+fhandler_fifo::open_pipe ()
+{
+  NTSTATUS status;
+  HANDLE npfsh;
+  ACCESS_MASK access;
+  OBJECT_ATTRIBUTES attr;
+  IO_STATUS_BLOCK io;
+  ULONG sharing;
+  HANDLE ph =3D NULL;
+
+  status =3D npfs_handle (npfsh);
+  if (!NT_SUCCESS (status))
+    return status;
+  access =3D GENERIC_WRITE | SYNCHRONIZE;
+  InitializeObjectAttributes (&attr, get_pipe_name (), OBJ_INHERIT,
+			      npfsh, NULL);
+  sharing =3D FILE_SHARE_READ | FILE_SHARE_WRITE;
+  status =3D NtOpenFile (&ph, access, &attr, &io, sharing, 0);
+  if (NT_SUCCESS (status))
+    set_io_handle (ph);
+  return status;
+}
+
 int
 fhandler_fifo::open (int flags, mode_t)
 {
   enum
   {
-    success,
-    error_errno_set,
-    error_set_errno
+   success,
+   error_errno_set,
+   error_set_errno
   } res;
   bool reader, writer, duplexer;
-  DWORD open_mode =3D FILE_FLAG_OVERLAPPED;
+  HANDLE ph =3D NULL;
=20
   /* Determine what we're doing with this fhandler: reading, writing, both=
 */
   switch (flags & O_ACCMODE)
@@ -99,7 +200,6 @@ fhandler_fifo::open (int flags, mode_t)
       duplexer =3D false;
       break;
     case O_RDWR:
-      open_mode |=3D PIPE_ACCESS_DUPLEX;
       reader =3D true;
       writer =3D false;
       duplexer =3D true;
@@ -112,22 +212,24 @@ fhandler_fifo::open (int flags, mode_t)
=20
   debug_only_printf ("reader %d, writer %d, duplexer %d", reader, writer, =
duplexer);
   set_flags (flags);
+  /* Create control events for this named pipe */
   char char_sa_buf[1024];
   LPSECURITY_ATTRIBUTES sa_buf;
   sa_buf =3D sec_user_cloexec (flags & O_CLOEXEC, (PSECURITY_ATTRIBUTES) c=
har_sa_buf,
 		      cygheap->user.sid());
-  char npbuf[MAX_PATH];
=20
-  /* Create control events for this named pipe */
-  if (!(read_ready =3D CreateEvent (sa_buf, duplexer, false, fnevent ("r")=
)))
+  char npbuf[MAX_PATH];
+  __small_sprintf (npbuf, "r-event.%08x.%016X", get_dev (), get_ino ());
+  if (!(read_ready =3D CreateEvent (sa_buf, duplexer, false, npbuf)))
     {
-      debug_printf ("CreatEvent for %s failed, %E", npbuf);
+      debug_printf ("CreateEvent for %s failed, %E", npbuf);
       res =3D error_set_errno;
       goto out;
     }
-  if (!(write_ready =3D CreateEvent (sa_buf, false, false, fnevent ("w"))))
+  npbuf[0] =3D 'w';
+  if (!(write_ready =3D CreateEvent (sa_buf, false, false, npbuf)))
     {
-      debug_printf ("CreatEvent for %s failed, %E", npbuf);
+      debug_printf ("CreateEvent for %s failed, %E", npbuf);
       res =3D error_set_errno;
       goto out;
     }
@@ -135,70 +237,54 @@ fhandler_fifo::open (int flags, mode_t)
   /* If we're reading, create the pipe, signal that we're ready and wait f=
or
      a writer.
      FIXME: Probably need to special case O_RDWR case.  */
-  if (!reader)
-    /* We are not a reader */;
-  else if (create_pipe (&get_io_handle (), NULL))
-    {
-      debug_printf ("create of reader failed");
-      res =3D error_set_errno;
-      goto out;
-    }
-  else if (!arm (read_ready))
-    {
-      res =3D error_set_errno;
-      goto out;
-    }
-  else if (!duplexer && !wait (write_ready))
+  if (reader)
     {
-      res =3D error_errno_set;
-      goto out;
+      ph =3D create_pipe ();
+      if (!ph)
+	{
+	  debug_printf ("create of reader failed");
+	  res =3D error_errno_set;
+	  goto out;
+	}
+      else if (!arm (read_ready))
+	{
+	  res =3D error_set_errno;
+	  goto out;
+	}
+      else if (!duplexer && !wait (write_ready))
+	{
+	  res =3D error_errno_set;
+	  goto out;
+	}
+      else
+	res =3D success;
     }
=20
-  /* If we're writing, it's a little tricky since it is possible that
-     we're attempting to open the other end of a pipe which is already
-     connected.  In that case, we detect ERROR_PIPE_BUSY, reset the
-     read_ready event and wait for the reader to allow us to connect
-     by signalling read_ready.
-
-     Once the pipe has been set up, we signal write_ready.  */
+  /* If we're writing, wait for read_ready and then connect to the
+     pipe.  Then signal write_ready.  */
   if (writer)
     {
-      int err;
-      while (1)
-	if (!wait (read_ready))
-	  {
-	    res =3D error_errno_set;
-	    goto out;
-	  }
-	else if ((err =3D create_pipe (NULL, &get_io_handle ())) =3D=3D 0)
-	  break;
-	else if (err =3D=3D ERROR_PIPE_BUSY)
-	  {
-	    debug_only_printf ("pipe busy");
-	    ResetEvent (read_ready);
-	  }
-	else
-	  {
-	    debug_printf ("create of writer failed");
-	    res =3D error_set_errno;
-	    goto out;
-	  }
-      if (!arm (write_ready))
+      if (!wait (read_ready))
+	{
+	  res =3D error_errno_set;
+	  goto out;
+	}
+      NTSTATUS status =3D open_pipe ();
+      if (!NT_SUCCESS (status))
+	{
+	  debug_printf ("create of writer failed");
+	  __seterrno_from_nt_status (status);
+	  res =3D error_errno_set;
+	  goto out;
+	}
+      else if (!arm (write_ready))
 	{
 	  res =3D error_set_errno;
 	  goto out;
 	}
+      else
+	res =3D success;
     }
-
-  /* If setup_overlapped() succeeds (and why wouldn't it?) we are all set.=
 */
-  if (setup_overlapped () =3D=3D 0)
-    res =3D success;
-  else
-    {
-      debug_printf ("setup_overlapped failed, %E");
-      res =3D error_set_errno;
-    }
-
 out:
   if (res =3D=3D error_set_errno)
     __seterrno ();
@@ -236,10 +322,8 @@ fhandler_fifo::wait (HANDLE h)
   const char *what;
   if (h =3D=3D read_ready)
     what =3D "reader";
-  else if (h =3D=3D write_ready)
-    what =3D "writer";
   else
-    what =3D "overlapped event";
+    what =3D "writer";
 #endif
   /* Set the wait to zero for non-blocking I/O-related events. */
   DWORD wait =3D ((h =3D=3D read_ready || h =3D=3D write_ready)
@@ -279,41 +363,72 @@ fhandler_fifo::wait (HANDLE h)
    }
 }
=20
+ssize_t __reg3
+fhandler_fifo::raw_write (const void *ptr, size_t len)
+{
+  ssize_t ret =3D -1;
+  NTSTATUS status;
+  IO_STATUS_BLOCK io;
+
+  status =3D NtWriteFile (get_handle (), NULL, NULL, NULL, &io,
+			(PVOID) ptr, len, NULL, NULL);
+  if (NT_SUCCESS (status))
+    {
+      /* NtWriteFile returns success with # of bytes written =3D=3D 0 in
+	 case writing on a non-blocking pipe fails if the pipe buffer
+	 is full. */
+      if (io.Information =3D=3D 0)
+	set_errno (EAGAIN);
+      else
+	ret =3D io.Information;
+    }
+  else if (STATUS_PIPE_IS_CLOSED (status))
+    {
+      set_errno (EPIPE);
+      raise (SIGPIPE);
+    }
+  else
+    __seterrno_from_nt_status (status);
+  return ret;
+}
+
 void __reg3
 fhandler_fifo::raw_read (void *in_ptr, size_t& len)
 {
   size_t orig_len =3D len;
-  for (int i =3D 0; i < 2; i++)
+  while (1)
     {
-      fhandler_base_overlapped::raw_read (in_ptr, len);
-      if (len || i || WaitForSingleObject (read_ready, 0) !=3D WAIT_OBJECT=
_0)
-	break;
-      /* If we got here, then fhandler_base_overlapped::raw_read returned =
0,
-	 indicating "EOF" and something has set read_ready to zero.  That means
-	 we should have a client waiting to connect.
-	 FIXME: If the client CTRL-C's the open during this time then this
-	 could hang indefinitely.  Maybe implement a timeout?  */
-      if (!DisconnectNamedPipe (get_io_handle ()))
+      len =3D orig_len;
+      fhandler_base::raw_read (in_ptr, len);
+      ssize_t nread =3D (ssize_t) len;
+      if (nread > 0)
+	return;
+      else if (nread < 0 && GetLastError () !=3D ERROR_NO_DATA)
+	goto errout;
+      else if (nread =3D=3D 0) /* Writer has disconnected. */
 	{
-	  debug_printf ("DisconnectNamedPipe failed, %E");
-	  goto errno_out;
+	  /* Not implemented yet. */
 	}
-      else if (!ConnectNamedPipe (get_io_handle (), get_overlapped ())
-	       && GetLastError () !=3D ERROR_IO_PENDING)
+      if (is_nonblocking ())
 	{
-	  debug_printf ("ConnectNamedPipe failed, %E");
-	  goto errno_out;
+	  set_errno (EAGAIN);
+	  goto errout;
+	}
+      else
+	{
+	  /* Allow interruption.  Copied from
+	     fhandler_socket_unix::open_reparse_point. */
+	  pthread_testcancel ();
+	  if (cygwait (NULL, cw_nowait, cw_sig_eintr) =3D=3D WAIT_SIGNALED
+	      && !_my_tls.call_signal_handler ())
+	    {
+	      set_errno (EINTR);
+	      goto errout;
+	    }
+	  /* Don't hog the CPU. */
+	  Sleep (1);
 	}
-      else if (!arm (read_ready))
-	goto errno_out;
-      else if (!wait (get_overlapped_buffer ()->hEvent))
-	goto errout;	/* If wait() fails, errno is set so no need to set it */
-      len =3D orig_len;	/* Reset since raw_read above set it to zero. */
     }
-  return;
-
-errno_out:
-  __seterrno ();
 errout:
   len =3D -1;
 }
@@ -337,7 +452,7 @@ fhandler_fifo::close ()
 int
 fhandler_fifo::dup (fhandler_base *child, int flags)
 {
-  if (fhandler_base_overlapped::dup (child, flags))
+  if (fhandler_base::dup (child, flags))
     {
       __seterrno ();
       return -1;
@@ -366,7 +481,7 @@ fhandler_fifo::dup (fhandler_base *child, int flags)
 void
 fhandler_fifo::fixup_after_fork (HANDLE parent)
 {
-  fhandler_base_overlapped::fixup_after_fork (parent);
+  fhandler_base::fixup_after_fork (parent);
   fork_fixup (parent, read_ready, "read_ready");
   fork_fixup (parent, write_ready, "write_ready");
 }
--=20
2.17.0
