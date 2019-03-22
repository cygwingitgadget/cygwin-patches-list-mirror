Return-Path: <cygwin-patches-return-9207-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 113165 invoked by alias); 22 Mar 2019 19:30:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 113060 invoked by uid 89); 22 Mar 2019 19:30:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-16.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=Never, Fall, poll, connects
X-HELO: NAM01-BY2-obe.outbound.protection.outlook.com
Received: from mail-eopbgr810099.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) (40.107.81.99) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 22 Mar 2019 19:30:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=qEcFjRZG/qX63kAYzCiP14GqVegDwNwhX7Ism5WvXbU=; b=lYA1Yf+WYAIh5EOwraEz/saw3lZrmh14iL6jElVut7Y/678dSmfGJUvi3GrGEVcbKSjLMOybXfCtQSFV1E1yJ9r0xyxGvePTGb0JSIclmv+IFvplQhVfvzj+5S59k/NdiylKtu4X8dAZy4xjc4y77a2l0ArScSDpzei1XQ7w1bo=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB5243.namprd04.prod.outlook.com (20.178.25.32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1730.15; Fri, 22 Mar 2019 19:30:37 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d%4]) with mapi id 15.20.1709.017; Fri, 22 Mar 2019 19:30:37 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH fifo 2/8] Cygwin: FIFO: allow multiple writers
Date: Fri, 22 Mar 2019 19:31:00 -0000
Message-ID: <20190322193020.565-3-kbrown@cornell.edu>
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
X-SW-Source: 2019-q1/txt/msg00020.txt.bz2

Introduce a 'fifo_client_handler' structure that can be used by a
reader to communicate with a writer using an instance of the named
pipe.  An fhandler_fifo opened for reading creates a thread that does
the following:

 - maintains a list of fifo_client_handlers
 - listens for_clients trying to connect
 - creates new pipe instances as needed so that there's always at
   least one available for connecting.

The pipe instances are initially created in blocking mode, but they
are set to be non-blocking after a connection is made.

fhandler_fifo::raw_read now loops through the connected clients and
reads from the first one that has data available.

New fhandler_fifo methods: add_client, listen_client,
listen_client_thread, check_listen_client_thread.

Replace the create_pipe method by create_pipe_instance, which allows
unlimited pipe instances.

New helper functions: create_event, set_pipe_non_blocking.
---
 winsup/cygwin/fhandler.h       |  31 ++-
 winsup/cygwin/fhandler_fifo.cc | 368 ++++++++++++++++++++++++++++++---
 2 files changed, 367 insertions(+), 32 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 57e97c277..e7c4af6a1 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1235,20 +1235,49 @@ public:
 };
=20
 #define CYGWIN_FIFO_PIPE_NAME_LEN     47
+#define MAX_CLIENTS 64
+
+enum fifo_client_connect_state
+  {
+   fc_unknown,
+   fc_connecting,
+   fc_connected,
+   fc_invalid
+  };
+
+struct fifo_client_handler
+{
+  fhandler_base *fh;
+  fifo_client_connect_state state;
+  HANDLE connect_evt;
+  HANDLE dummy_evt;		/* Never signaled. */
+  fifo_client_handler () : fh (NULL), state (fc_unknown), connect_evt (NUL=
L),
+			   dummy_evt (NULL) {}
+  int connect ();
+  int close ();
+};
=20
 class fhandler_fifo: public fhandler_base
 {
   HANDLE read_ready;
   HANDLE write_ready;
+  HANDLE listen_client_thr;
+  HANDLE lct_termination_evt;
   UNICODE_STRING pipe_name;
   WCHAR pipe_name_buf[CYGWIN_FIFO_PIPE_NAME_LEN + 1];
+  fifo_client_handler client[MAX_CLIENTS];
+  int nclients, nconnected;
   bool __reg2 wait (HANDLE);
   NTSTATUS npfs_handle (HANDLE &);
-  HANDLE create_pipe ();
+  HANDLE create_pipe_instance (bool);
   NTSTATUS open_pipe ();
+  int disconnect_and_reconnect (int);
+  int add_client ();
+  bool listen_client ();
 public:
   fhandler_fifo ();
   PUNICODE_STRING get_pipe_name ();
+  DWORD listen_client_thread ();
   int open (int, mode_t);
   off_t lseek (off_t offset, int whence);
   int close ();
diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index cb269e344..e91e88050 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -31,8 +31,9 @@ STATUS_PIPE_EMPTY simply means there's no data to be read=
. */
 		   || _s =3D=3D STATUS_PIPE_EMPTY; })
=20
 fhandler_fifo::fhandler_fifo ():
-  fhandler_base (),
-  read_ready (NULL), write_ready (NULL)
+  fhandler_base (), read_ready (NULL), write_ready (NULL),
+  listen_client_thr (NULL), lct_termination_evt (NULL), nclients (0),
+  nconnected (0)
 {
   pipe_name_buf[0] =3D L'\0';
   need_fork_fixup (true);
@@ -78,6 +79,94 @@ fhandler_fifo::arm (HANDLE h)
   return res;
 }
=20
+static HANDLE
+create_event ()
+{
+  NTSTATUS status;
+  OBJECT_ATTRIBUTES attr;
+  HANDLE evt =3D NULL;
+
+  InitializeObjectAttributes (&attr, NULL, 0, NULL, NULL);
+  status =3D NtCreateEvent (&evt, EVENT_ALL_ACCESS, &attr,
+			  NotificationEvent, FALSE);
+  if (!NT_SUCCESS (status))
+    __seterrno_from_nt_status (status);
+  return evt;
+}
+
+
+static void
+set_pipe_non_blocking (HANDLE ph, bool nonblocking)
+{
+  NTSTATUS status;
+  IO_STATUS_BLOCK io;
+  FILE_PIPE_INFORMATION fpi;
+
+  fpi.ReadMode =3D FILE_PIPE_MESSAGE_MODE;
+  fpi.CompletionMode =3D nonblocking ? FILE_PIPE_COMPLETE_OPERATION
+    : FILE_PIPE_QUEUE_OPERATION;
+  status =3D NtSetInformationFile (ph, &io, &fpi, sizeof fpi,
+				 FilePipeInformation);
+  if (!NT_SUCCESS (status))
+    debug_printf ("NtSetInformationFile(FilePipeInformation): %y", status);
+}
+
+/* The pipe instance is always in blocking mode when this is called. */
+int
+fifo_client_handler::connect ()
+{
+  NTSTATUS status;
+  IO_STATUS_BLOCK io;
+
+  if (connect_evt)
+    ResetEvent (connect_evt);
+  else if (!(connect_evt =3D create_event ()))
+    return -1;
+  status =3D NtFsControlFile (fh->get_handle (), connect_evt, NULL, NULL, =
&io,
+			    FSCTL_PIPE_LISTEN, NULL, 0, NULL, 0);
+  switch (status)
+    {
+    case STATUS_PENDING:
+    case STATUS_PIPE_LISTENING:
+      state =3D fc_connecting;
+      break;
+    case STATUS_PIPE_CONNECTED:
+      state =3D fc_connected;
+      set_pipe_non_blocking (fh->get_handle (), true);
+      break;
+    default:
+      __seterrno_from_nt_status (status);
+      return -1;
+    }
+  return 0;
+}
+
+int
+fhandler_fifo::disconnect_and_reconnect (int i)
+{
+  NTSTATUS status;
+  IO_STATUS_BLOCK io;
+  HANDLE ph =3D client[i].fh->get_handle ();
+
+  status =3D NtFsControlFile (ph, NULL, NULL, NULL, &io, FSCTL_PIPE_DISCON=
NECT,
+			    NULL, 0, NULL, 0);
+  /* Short-lived.  Don't use cygwait.  We don't want to be interrupted. */
+  if (status =3D=3D STATUS_PENDING
+      && NtWaitForSingleObject (ph, FALSE, NULL) =3D=3D WAIT_OBJECT_0)
+    status =3D io.Status;
+  if (!NT_SUCCESS (status))
+    {
+      __seterrno_from_nt_status (status);
+      return -1;
+    }
+  set_pipe_non_blocking (client[i].fh->get_handle (), false);
+  if (client[i].connect () < 0)
+    return -1;
+  if (client[i].state =3D=3D fc_connected)
+    nconnected++;
+  return 0;
+}
+
 NTSTATUS
 fhandler_fifo::npfs_handle (HANDLE &nph)
 {
@@ -108,9 +197,12 @@ fhandler_fifo::npfs_handle (HANDLE &nph)
   return status;
 }
=20
-/* Called when pipe is opened for reading. */
+/* Called when a FIFO is first opened for reading and again each time
+   a new client is needed.  Each pipe instance is created in blocking
+   mode so that we can easily wait for a connection.  After it is
+   connected, it is put in nonblocking mode. */
 HANDLE
-fhandler_fifo::create_pipe ()
+fhandler_fifo::create_pipe_instance (bool first)
 {
   NTSTATUS status;
   HANDLE npfsh;
@@ -121,7 +213,7 @@ fhandler_fifo::create_pipe ()
   ULONG hattr;
   ULONG sharing;
   ULONG nonblocking =3D FILE_PIPE_QUEUE_OPERATION;
-  ULONG max_instances =3D 1;
+  ULONG max_instances =3D -1;
   LARGE_INTEGER timeout;
=20
   status =3D npfs_handle (npfsh);
@@ -133,12 +225,14 @@ fhandler_fifo::create_pipe ()
   access =3D GENERIC_READ | FILE_READ_ATTRIBUTES | FILE_WRITE_ATTRIBUTES
     | SYNCHRONIZE;
   sharing =3D FILE_SHARE_READ | FILE_SHARE_WRITE;
-  hattr =3D OBJ_INHERIT | OBJ_CASE_INSENSITIVE;
+  hattr =3D OBJ_INHERIT;
+  if (first)
+    hattr |=3D OBJ_CASE_INSENSITIVE;
   InitializeObjectAttributes (&attr, get_pipe_name (),
 			      hattr, npfsh, NULL);
   timeout.QuadPart =3D -500000;
   status =3D NtCreateNamedPipeFile (&ph, access, &attr, &io, sharing,
-				  FILE_CREATE, 0,
+				  first ? FILE_CREATE : FILE_OPEN, 0,
 				  FILE_PIPE_MESSAGE_TYPE,
 				  FILE_PIPE_MESSAGE_MODE,
 				  nonblocking, max_instances,
@@ -149,7 +243,7 @@ fhandler_fifo::create_pipe ()
   return ph;
 }
=20
-/* Called when file is opened for writing. */
+/* Called when a FIFO is opened for writing. */
 NTSTATUS
 fhandler_fifo::open_pipe ()
 {
@@ -174,6 +268,140 @@ fhandler_fifo::open_pipe ()
   return status;
 }
=20
+int
+fhandler_fifo::add_client ()
+{
+  fifo_client_handler fc;
+  fhandler_base *fh;
+  bool first =3D (nclients =3D=3D 0);
+
+  if (nclients =3D=3D MAX_CLIENTS)
+    {
+      set_errno (EMFILE);
+      return -1;
+    }
+  if (!(fc.dummy_evt =3D create_event ()))
+    return -1;
+  if (!(fh =3D build_fh_dev (dev ())))
+    {
+      set_errno (EMFILE);
+      return -1;
+    }
+  fc.fh =3D fh;
+  HANDLE ph =3D create_pipe_instance (first);
+  if (!ph)
+    goto errout;
+  fh->set_io_handle (ph);
+  fh->set_flags (get_flags ());
+  if (fc.connect () < 0)
+    {
+      fc.close ();
+      goto errout;
+    }
+  if (fc.state =3D=3D fc_connected)
+    nconnected++;
+  client[nclients++] =3D fc;
+  return 0;
+errout:
+  delete fh;
+  return -1;
+
+}
+
+/* Just hop to the listen_client_thread method. */
+DWORD WINAPI
+listen_client_func (LPVOID param)
+{
+  fhandler_fifo *fh =3D (fhandler_fifo *) param;
+  return fh->listen_client_thread ();
+}
+
+/* Start a thread that listens for client connections.  Whenever a new
+   client connects, it creates a new pipe_instance if necessary.
+   (There may already be an available instance if a client has
+   disconnected.)  */
+bool
+fhandler_fifo::listen_client ()
+{
+  if (!(lct_termination_evt =3D create_event ()))
+    return false;
+
+  listen_client_thr =3D CreateThread (NULL, PREFERRED_IO_BLKSIZE,
+				    listen_client_func, (PVOID) this, 0, NULL);
+  if (!listen_client_thr)
+    {
+      __seterrno ();
+      HANDLE evt =3D InterlockedExchangePointer (&lct_termination_evt, NUL=
L);
+      if (evt)
+	CloseHandle (evt);
+      return false;
+    }
+  return true;
+}
+
+DWORD
+fhandler_fifo::listen_client_thread ()
+{
+  while (1)
+    {
+      bool found;
+      HANDLE w[MAX_CLIENTS + 1];
+      int i;
+      DWORD wait_ret;
+
+      found =3D false;
+      for (i =3D 0; i < nclients; i++)
+	switch (client[i].state)
+	  {
+	  case fc_invalid:
+	    if (disconnect_and_reconnect (i) < 0)
+	      goto errout;
+	    /* Fall through. */
+	  case fc_connected:
+	    w[i] =3D client[i].dummy_evt;
+	    break;
+	  case fc_connecting:
+	    found =3D true;
+	    w[i] =3D client[i].connect_evt;
+	    break;
+	  case fc_unknown:	/* Shouldn't happen. */
+	  default:
+	    break;
+	  }
+      w[nclients] =3D lct_termination_evt;
+      if (!found)
+	{
+	  if (add_client () < 0)
+	    goto errout;
+	  else
+	    continue;
+	}
+      if (!arm (read_ready))
+	{
+	  __seterrno ();
+	  goto errout;
+	}
+
+      /* Wait for a client to connect. */
+      wait_ret =3D WaitForMultipleObjects (nclients + 1, w, false, INFINIT=
E);
+      i =3D wait_ret - WAIT_OBJECT_0;
+      if (i < 0 || i > nclients)
+	goto errout;
+      else if (i =3D=3D nclients)	/* Reader is closing. */
+	return 0;
+      else
+	{
+	  client[i].state =3D fc_connected;
+	  nconnected++;
+	  set_pipe_non_blocking (client[i].fh->get_handle (), true);
+	  yield ();
+	}
+    }
+errout:
+  ResetEvent (read_ready);
+  return -1;
+}
+
 int
 fhandler_fifo::open (int flags, mode_t)
 {
@@ -184,7 +412,6 @@ fhandler_fifo::open (int flags, mode_t)
    error_set_errno
   } res;
   bool reader, writer, duplexer;
-  HANDLE ph =3D NULL;
=20
   /* Determine what we're doing with this fhandler: reading, writing, both=
 */
   switch (flags & O_ACCMODE)
@@ -212,6 +439,9 @@ fhandler_fifo::open (int flags, mode_t)
=20
   debug_only_printf ("reader %d, writer %d, duplexer %d", reader, writer, =
duplexer);
   set_flags (flags);
+  if (reader)
+    nohandle (true);
+
   /* Create control events for this named pipe */
   char char_sa_buf[1024];
   LPSECURITY_ATTRIBUTES sa_buf;
@@ -234,24 +464,42 @@ fhandler_fifo::open (int flags, mode_t)
       goto out;
     }
=20
-  /* If we're reading, create the pipe, signal that we're ready and wait f=
or
-     a writer.
-     FIXME: Probably need to special case O_RDWR case.  */
+  /* If we're reading, start the listen_client thread (which should
+     signal read_ready), and wait for a writer. */
   if (reader)
     {
-      ph =3D create_pipe ();
-      if (!ph)
+      if (!listen_client ())
 	{
-	  debug_printf ("create of reader failed");
+	  debug_printf ("create of listen_client thread failed");
 	  res =3D error_errno_set;
 	  goto out;
 	}
-      else if (!arm (read_ready))
+      /* Wait for the listen_client thread to create the pipe and
+	 signal read_ready.  This should be quick.  */
+      HANDLE w[2] =3D { listen_client_thr, read_ready };
+      switch (WaitForMultipleObjects (2, w, FALSE, INFINITE))
 	{
+	case WAIT_OBJECT_0:
+	  debug_printf ("listen_client_thread exited unexpectedly");
+	  DWORD err;
+	  GetExitCodeThread (listen_client_thr, &err);
+	  __seterrno_from_win_error (err);
+	  res =3D error_errno_set;
+	  goto out;
+	  break;
+	case WAIT_OBJECT_0 + 1:
+	  if (!arm (read_ready))
+	    {
+	      res =3D error_set_errno;
+	      goto out;
+	    }
+	  break;
+	default:
 	  res =3D error_set_errno;
 	  goto out;
+	  break;
 	}
-      else if (!duplexer && !wait (write_ready))
+      if (!duplexer && !wait (write_ready))
 	{
 	  res =3D error_errno_set;
 	  goto out;
@@ -261,7 +509,8 @@ fhandler_fifo::open (int flags, mode_t)
     }
=20
   /* If we're writing, wait for read_ready and then connect to the
-     pipe.  Then signal write_ready.  */
+     pipe.  This should always succeed quickly if the reader's
+     listen_client thread is running.  Then signal write_ready.  */
   if (writer)
     {
       if (!wait (read_ready))
@@ -283,7 +532,10 @@ fhandler_fifo::open (int flags, mode_t)
 	  goto out;
 	}
       else
-	res =3D success;
+	{
+	  set_pipe_non_blocking (get_handle (), true);
+	  res =3D success;
+	}
     }
 out:
   if (res =3D=3D error_set_errno)
@@ -302,6 +554,8 @@ out:
 	}
       if (get_io_handle ())
 	CloseHandle (get_io_handle ());
+      if (listen_client_thr)
+	CloseHandle (listen_client_thr);
     }
   debug_printf ("res %d", res);
   return res =3D=3D success;
@@ -396,19 +650,36 @@ void __reg3
 fhandler_fifo::raw_read (void *in_ptr, size_t& len)
 {
   size_t orig_len =3D len;
+
+  /* Start the listen_client thread if necessary (e.g., after dup or fork)=
. */
+  if (!listen_client_thr && !listen_client ())
+    goto errout;
+
   while (1)
     {
-      len =3D orig_len;
-      fhandler_base::raw_read (in_ptr, len);
-      ssize_t nread =3D (ssize_t) len;
-      if (nread > 0)
-	return;
-      else if (nread < 0 && GetLastError () !=3D ERROR_NO_DATA)
-	goto errout;
-      else if (nread =3D=3D 0) /* Writer has disconnected. */
+      if (nconnected =3D=3D 0)	/* EOF */
 	{
-	  /* Not implemented yet. */
+	  len =3D 0;
+	  return;
 	}
+
+      /* Poll the connected clients for input. */
+      for (int i =3D 0; i < nclients; i++)
+	if (client[i].state =3D=3D fc_connected)
+	  {
+	    len =3D orig_len;
+	    client[i].fh->fhandler_base::raw_read (in_ptr, len);
+	    ssize_t nread =3D (ssize_t) len;
+	    if (nread > 0)
+	      return;
+	    else if (nread < 0 && GetLastError () !=3D ERROR_NO_DATA)
+	      goto errout;
+	    else if (nread =3D=3D 0) /* Client has disconnected. */
+	      {
+		client[i].state =3D fc_invalid;
+		nconnected--;
+	      }
+	  }
       if (is_nonblocking ())
 	{
 	  set_errno (EAGAIN);
@@ -441,12 +712,47 @@ fhandler_fifo::fstatvfs (struct statvfs *sfs)
   return fh.fstatvfs (sfs);
 }
=20
+int
+fifo_client_handler::close ()
+{
+  int res =3D 0;
+
+  if (fh)
+    res =3D fh->close ();
+  if (connect_evt)
+    CloseHandle (connect_evt);
+  if (dummy_evt)
+    CloseHandle (dummy_evt);
+  return res;
+}
+
 int
 fhandler_fifo::close ()
 {
-  CloseHandle (read_ready);
-  CloseHandle (write_ready);
-  return fhandler_base::close ();
+  int res =3D 0;
+  HANDLE evt =3D InterlockedExchangePointer (&lct_termination_evt, NULL);
+  HANDLE thr =3D InterlockedExchangePointer (&listen_client_thr, NULL);
+  if (thr)
+    {
+      if (evt)
+	SetEvent (evt);
+      WaitForSingleObject (thr, INFINITE);
+      DWORD err;
+      GetExitCodeThread (thr, &err);
+      if (err)
+	debug_printf ("listen_client_thread exited with code %d", err);
+      CloseHandle (thr);
+    }
+  if (evt)
+    CloseHandle (evt);
+  if (read_ready)
+    CloseHandle (read_ready);
+  if (write_ready)
+    CloseHandle (write_ready);
+  for (int i =3D 0; i < nclients; i++)
+    if (client[i].close () < 0)
+      res =3D -1;
+  return fhandler_base::close () || res;
 }
=20
 int
--=20
2.17.0
