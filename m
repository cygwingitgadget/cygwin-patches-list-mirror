Return-Path: <cygwin-patches-return-2746-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 1600 invoked by alias); 29 Jul 2002 17:50:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1586 invoked from network); 29 Jul 2002 17:50:14 -0000
Message-ID: <002e01c23728$025a0a30$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <03f001c23504$5be06890$6132bc3e@BABEL> <025701c235a1$058cb730$6132bc3e@BABEL> <20020729150716.X3921@cygbert.vinschen.de> <007a01c23721$31a7bc80$6132bc3e@BABEL>
Subject: Re: UNIX domain socket patch
Date: Mon, 29 Jul 2002 10:50:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_002B_01C23730.63CA5EC0"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00194.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_002B_01C23730.63CA5EC0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 157

And one more time with the patch attached as text rather than
binary.

This thread really should teach me something, I just wish I knew
what :-(

// Conrad


------=_NextPart_000_002B_01C23730.63CA5EC0
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 4010

2002-07-27  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* fhandler.h
	(fhandler_socket::connect_secret_initialized): New field.
	(fhandler_socket::peer_sun_path): Ditto.
	(fhandler_socket::set_peer_sun_path): New method.
	(fhandler_socket::get_peer_sun_path): Ditto.
	(fhandler_socket::set_connect_secret): Change return type to bool.
	(fhandler_socket::get_connect_secret): Ditto.
	(fhandler_socket::create_connect_secret): Ditto.
	(fhandler_socket::check_peer_secret_event): Ditto.
	(fhandler_socket::signal_secret_event): Remove method.
	* fhandler_socket.cc (ENTROPY_SOURCE_NAME): Remove #define.
	(get_inet_addr): Check that the UNIX domain sun_path refers to a
	socket file.  Add the SOCKET_COOKIE string to the sscanf(3)
	format.  Check the return value from sscanf(3) and set errno as
	appropriate.  Add save_errno objects as appropriate.
	(fhandler_socket::fhandler_socket): Initialize every field.
	(fhandler_socket::~fhandler_socket): Call close_secret_event().
	Free peer_sun_path if required.
	(fhandler_socket::set_connect_secret): Change return type to bool.
	Add asserts.  Use explicit destructor and free(3) rather than
	delete.  Add tracing messages.  Set connect_secret_initialized as
	appropriate.  Return true if the connect_secret has been
	initialized.
	(fhandler_socket::get_connect_secret): Add asserts.
	(fhandler_socket::create_secret_event): Change return type to
	bool.  Add asserts.  Add AF_LOCAL marker to tracing statements.
	Change all tracing failure statements to syscall level.  Set errno
	as appropriate.  Change the secret_event to be a semaphore.
	(fhandler_socket::signal_secret_event): Remove method.
	(fhandler_socket::close_secret_event): Wait for the secret event
	(or an error) to be signalled before closing the event.
	(fhandler_socket::check_peer_secret_event): Change return type to
	bool.  Add asserts.  Add AF_LOCAL marker to tracing statements.
	Set errno as appropriate.  Change all tracing failure statements
	to syscall level.  Change to support new UNIX domain emulation
	protocol.
	(fhandler_socket::fixup_after_fork): Remove ineffective call to
	fork_fixup.  Signal the secret_event to keep handle count and
	signal count in sync.
	(fhandler_socket::dup): Duplicate every field.  In particular,
	explicitly duplicate the secret event handle and protect it.
	(fhandler_socket::bind): Check that the requested address family
	matches the socket's address family.  Change tracing messages to
	use WSAGetLastError rather than errno.  For UNIX domain sockets,
	create the secret event before creating the file system socket,
	then immediately signal that event.
	(fhandler_socket::connect): Remove the secret_check_failed and
	in_progress flags.  Check that the requested address family
	matches the socket's address family.  For the first connect on a
	UNIX domain socket, check the that the server's secret event
	exists; then bind the local socket and create its own secret
	event.  Also set the peer sun path here.  Remove the old secret
	event code.  Rewrite code that generates the errno for
	non-blocking sockets to match SUSv3.  Change the code that sets
	had_connect_or_listen likewise.
	(fhandler_socket::accept): Remove the secret_check_failed and
	in_progress flags.  Remove the old secret event code.  Check peer
	secret event and do a hard reset on the accepted socket if it
	fails.  Duplicate the peer sun path and the had_connect_or_listen
	flag into the accepted fhandler.
	(fhandler_socket::getsockname): Call ::getsockname() even for UNIX
	domain sockets as an error check.
	(fhandler_socket::getpeername): Add special case for UNIX domain
	sockets as per the getsockname method.
	(fhandler_socket::close): Close the secret event before, rather
	than after, closing the underlying socket and return error status
	as appropriate.
	(fhandler_socket::set_sun_path): Add assert.  Free the previous
	sun path as appropriate.
	(fhandler_socket::set_peer_sun_path): New method.
	* net.cc (cygwin_socket): Check for supported protocol families.

------=_NextPart_000_002B_01C23730.63CA5EC0
Content-Type: text/plain;
	name="af_local.patch.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="af_local.patch.txt"
Content-length: 29872

Index: fhandler.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.130
diff -u -r1.130 fhandler.h
--- fhandler.h	22 Jul 2002 09:11:44 -0000	1.130
+++ fhandler.h	27 Jul 2002 19:02:37 -0000
@@ -368,9 +368,11 @@
   int addr_family;
   int type;
   int connect_secret [4];
+  bool connect_secret_initialized;
   HANDLE secret_event;
   struct _WSAPROTOCOL_INFOA *prot_info_ptr;
   char *sun_path;
+  char *peer_sun_path;
   int had_connect_or_listen;
=20
  public:
@@ -432,12 +434,13 @@
   int get_socket_type () {return type;}
   void set_sun_path (const char *path);
   char *get_sun_path () {return sun_path;}
-  void set_connect_secret ();
-  void get_connect_secret (char*);
-  HANDLE create_secret_event (int *secret =3D NULL);
-  int check_peer_secret_event (struct sockaddr_in *peer, int *secret =3D N=
ULL);
-  void signal_secret_event ();
-  void close_secret_event ();
+  void set_peer_sun_path (const char *path);
+  char *get_peer_sun_path () {return peer_sun_path;}
+  bool set_connect_secret ();
+  void get_connect_secret (char *);
+  bool create_secret_event (int *secret =3D NULL);
+  bool check_peer_secret_event (struct sockaddr_in *peer, int *secret =3D =
NULL);
+  bool close_secret_event ();
   int __stdcall fstat (struct __stat64 *buf, path_conv *) __attribute__ ((=
regparm (3)));
 };
=20
Index: fhandler_socket.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler_socket.cc,v
retrieving revision 1.55
diff -u -r1.55 fhandler_socket.cc
--- fhandler_socket.cc	13 Jul 2002 20:00:25 -0000	1.55
+++ fhandler_socket.cc	27 Jul 2002 19:02:37 -0000
@@ -19,6 +19,8 @@
 #include <sys/uio.h>
 #include <asm/byteorder.h>
=20
+#include <assert.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
 #define USE_SYS_TYPES_FD_SET
@@ -35,12 +37,11 @@
 #include "wsock_event.h"
=20
 #define SECRET_EVENT_NAME "cygwin.local_socket.secret.%d.%08x-%08x-%08x-%0=
8x"
-#define ENTROPY_SOURCE_NAME "/dev/urandom"
-#define ENTROPY_SOURCE_DEV_UNIT 9
+#define ENTROPY_SOURCE_DEV_UNIT 9 /* /dev/urandom */
=20
 extern fhandler_socket *fdsock (int& fd, const char *name, SOCKET soc);
 extern "C" {
-int sscanf (const char *, const char *, ...);
+int _fstat (int, struct __stat32 *);
 } /* End of "C" section */
=20
 fhandler_dev_random* entropy_source;
@@ -65,6 +66,25 @@
       if (fd =3D=3D -1)
         return 0;
=20
+      {
+	struct __stat32 sbuf;
+	if (_fstat (fd, &sbuf) =3D=3D -1)
+	  {
+	    save_errno here;
+	    _close (fd);
+	    return 0;
+	  }
+
+	if (!S_ISSOCK (sbuf.st_mode))
+	  {
+	    syscall_printf ("AF_LOCAL: \"%s\" is not a socket file",
+			    in->sa_data);
+	    _close (fd);
+	    set_errno (EINVAL);
+	    return 0;
+	  }
+      }
+
       int ret =3D 0;
       char buf[128];
       memset (buf, 0, sizeof buf);
@@ -72,15 +92,26 @@
         {
           sockaddr_in sin;
           sin.sin_family =3D AF_INET;
-          sscanf (buf + strlen (SOCKET_COOKIE), "%hu %08x-%08x-%08x-%08x",
-                  &sin.sin_port,
-                  secret_ptr, secret_ptr + 1, secret_ptr + 2, secret_ptr +=
 3);
-          sin.sin_port =3D htons (sin.sin_port);
-          sin.sin_addr.s_addr =3D htonl (INADDR_LOOPBACK);
-          *out =3D sin;
-          *outlen =3D sizeof sin;
-          ret =3D 1;
+          if (sscanf (buf, (SOCKET_COOKIE "%hu %08x-%08x-%08x-%08x"),
+		      &sin.sin_port,
+		      secret_ptr + 0, secret_ptr + 1,
+		      secret_ptr + 2, secret_ptr + 3) !=3D 5)
+	    {
+	      syscall_printf ("AF_LOCAL: "
+			      "file system socket object bad format");
+	      set_errno (EINVAL);
+	      ret =3D 0;
+	    }
+	  else
+	    {
+	      sin.sin_port =3D htons (sin.sin_port);
+	      sin.sin_addr.s_addr =3D htonl (INADDR_LOOPBACK);
+	      *out =3D sin;
+	      *outlen =3D sizeof sin;
+	      ret =3D 1;
+	    }
         }
+      save_errno here;
       _close (fd);
       return ret;
     }
@@ -95,8 +126,17 @@
 /* fhandler_socket */
=20
 fhandler_socket::fhandler_socket ()
-  : fhandler_base (FH_SOCKET), sun_path (NULL)
+  : fhandler_base (FH_SOCKET),
+    addr_family (AF_UNSPEC),
+    type (0),			/* i.e. `SOCK_UNSPEC' */
+    connect_secret_initialized (false),
+    secret_event (NULL),
+    prot_info_ptr (NULL),
+    sun_path (NULL),
+    peer_sun_path (NULL),
+    had_connect_or_listen (UNCONNECTED)
 {
+  bzero (connect_secret, sizeof (connect_secret));
   set_need_fork_fixup ();
   prot_info_ptr =3D (LPWSAPROTOCOL_INFOA) cmalloc (HEAP_BUF,
 						 sizeof (WSAPROTOCOL_INFOA));
@@ -104,43 +144,76 @@
=20
 fhandler_socket::~fhandler_socket ()
 {
+  close_secret_event ();
   if (prot_info_ptr)
     cfree (prot_info_ptr);
   if (sun_path)
     cfree (sun_path);
+  if (peer_sun_path)
+    cfree (peer_sun_path);
 }
=20
-void
+bool
 fhandler_socket::set_connect_secret ()
 {
+  assert (get_addr_family () =3D=3D AF_LOCAL);
+  assert (!connect_secret_initialized);
+
   if (!entropy_source)
     {
       void *buf =3D malloc (sizeof (fhandler_dev_random));
       entropy_source =3D new (buf) fhandler_dev_random (ENTROPY_SOURCE_DEV=
_UNIT);
     }
-  if (entropy_source &&
-      !entropy_source->open (NULL, O_RDONLY))
+
+  if (!entropy_source)
+    {
+      syscall_printf ("AF_LOCAL: failed to allocate entropy source");
+      set_errno (ENOMEM);
+    }
+  else if (!entropy_source->open (NULL, O_RDONLY))
+    {
+      syscall_printf ("AF_LOCAL: failed to open entropy source (%d)",
+		      get_errno ());
+    }
+  else if (entropy_source->read (connect_secret, sizeof (connect_secret))
+	   !=3D sizeof (connect_secret))
     {
-      delete entropy_source;
+      syscall_printf ("AF_LOCAL: failed to read from entropy source (%d)",
+		      get_errno ());
+      bzero (connect_secret, sizeof (connect_secret));
+    }
+  else
+    connect_secret_initialized =3D true;
+
+  if (entropy_source && !connect_secret_initialized)
+    {
+      save_errno here;
+      entropy_source->~fhandler_dev_random ();
+      free (entropy_source);
       entropy_source =3D NULL;
     }
-  if (!entropy_source ||
-      (entropy_source->read (connect_secret, sizeof (connect_secret)) !=3D
-					     sizeof (connect_secret)))
-    bzero ((char*) connect_secret, sizeof (connect_secret));
+
+  return connect_secret_initialized;
 }
=20
 void
 fhandler_socket::get_connect_secret (char* buf)
 {
+  assert (get_addr_family () =3D=3D AF_LOCAL);
+  assert (connect_secret_initialized);
+
   __small_sprintf (buf, "%08x-%08x-%08x-%08x",
 		   connect_secret [0], connect_secret [1],
 		   connect_secret [2], connect_secret [3]);
 }
=20
-HANDLE
+bool
 fhandler_socket::create_secret_event (int* secret)
 {
+  assert (get_addr_family () =3D=3D AF_LOCAL);
+  assert (!secret_event);
+  assert (secret || connect_secret_initialized);
+
   char buf [128];
   int* secret_ptr =3D (secret ? : connect_secret);
   struct sockaddr_in sin;
@@ -148,51 +221,184 @@
=20
   if (::getsockname (get_socket (), (struct sockaddr*) &sin, &sin_len))
     {
-      debug_printf ("error getting local socket name (%d)", WSAGetLastErro=
r ());
-      return NULL;
+      syscall_printf ("AF_LOCAL: getsockname failed (%d)", WSAGetLastError=
 ());
+      set_winsock_errno ();
+      return false;
     }
=20
   __small_sprintf (buf, SECRET_EVENT_NAME, sin.sin_port,
 		   secret_ptr [0], secret_ptr [1],
 		   secret_ptr [2], secret_ptr [3]);
   LPSECURITY_ATTRIBUTES sec =3D get_inheritance (true);
-  secret_event =3D CreateEvent (sec, FALSE, FALSE, buf);
-  if (!secret_event && GetLastError () =3D=3D ERROR_ALREADY_EXISTS)
-    secret_event =3D OpenEvent (EVENT_ALL_ACCESS, FALSE, buf);
-
-  if (!secret_event)
-    /* nothing to do */;
-  else if (sec =3D=3D &sec_all_nih || sec =3D=3D &sec_none_nih)
-    ProtectHandle (secret_event);
-  else
-    ProtectHandleINH (secret_event);
+  secret_event =3D CreateSemaphore (sec, 0, 1023, buf);
=20
-  return secret_event;
-}
+  bool res =3D false;
=20
-void
-fhandler_socket::signal_secret_event ()
-{
   if (!secret_event)
-    debug_printf ("no secret event?");
+    syscall_printf ("AF_LOCAL: failed to create secret event \"%s\", %E", =
buf);
+  else if (GetLastError () =3D=3D ERROR_ALREADY_EXISTS)
+    {
+      syscall_printf ("AF_LOCAL: secret event \"%s\" already exists", buf);
+      (void) CloseHandle (secret_event);
+      secret_event =3D NULL;
+    }
   else
     {
-      SetEvent (secret_event);
-      debug_printf ("signaled secret_event");
+      debug_printf ("AF_LOCAL: created event \"%s\"", buf);
+
+      if (get_close_on_exec ())
+	ProtectHandle (secret_event);
+      else
+	ProtectHandleINH (secret_event);
+
+      res =3D true;
     }
+
+  return res;
 }
=20
-void
+/* The client in a UNIX domain socket connection must make sure that
+ * its secret event still exists by the time that the accept(2) call
+ * happens in the server.  This is only problematic for clients that
+ * only write to the socket and don't read; these can close the socket
+ * too quickly for the server to detect it.  To avoid this, the client
+ * waits for the server to signal its secret event, which it does in
+ * accept(2).  To avoid testing here whether this is the server or the
+ * client end of a connection, the server signals its own secret event
+ * when it creates it so waiting on it is safe here.  A similar trick
+ * is used when duplicating a socket or forking: the copy is signalled
+ * immediately.  In this way the number of open copies is always one
+ * greater than the event count, until the server also signals the
+ * event; only then is the client free to close every event handle.
+ *
+ * Nb. The WaitForSingleObject is not an optimization.  Rather the
+ * idea is that the WSAWaitForMultipleEvents is only called for the
+ * last close on a socket, as otherwise the WSAEventSelect can
+ * interfere with other uses of that, i.e., the one in the accept
+ * method, since it seems to clear *all* the pending event information
+ * on the socket when called, i.e., including any pending accept.
+ */
+bool
 fhandler_socket::close_secret_event ()
 {
+  bool res =3D true;
+
   if (secret_event)
-    ForceCloseHandle (secret_event);
-  secret_event =3D NULL;
+    {
+      const HANDLE hSecret =3D secret_event;
+      secret_event =3D NULL;
+
+      const DWORD wfso_res =3D WaitForSingleObject (hSecret, 0);
+
+      if (wfso_res =3D=3D WAIT_OBJECT_0)
+	debug_printf ("AF_LOCAL: secret event signalled");
+      else
+	{
+	  HANDLE hWSAEvent =3D WSACreateEvent ();
+
+	  if (hWSAEvent =3D=3D WSA_INVALID_EVENT)
+	    {
+	      syscall_printf ("AF_LOCAL: WSACreateEvent failed (%d)",
+			      WSAGetLastError ());
+	      hWSAEvent =3D NULL;
+	    }
+	  else if (WSAEventSelect (get_socket (),
+				   hWSAEvent,
+				   FD_CLOSE) =3D=3D SOCKET_ERROR)
+	    {
+	      syscall_printf ("AF_LOCAL: WSAEventSelect failed (%d)",
+			      WSAGetLastError ());
+	      (void) WSACloseEvent (hWSAEvent);
+	      hWSAEvent =3D NULL;
+	    }
+
+	  const WSAEVENT w4[] =3D { hSecret, signal_arrived, hWSAEvent };
+	  const int cEvents =3D (hWSAEvent ? 3 : 2);
+
+	  bool complete =3D false;
+
+	  while (!complete)
+	    {
+	      const DWORD wfme_res
+		=3D WSAWaitForMultipleEvents (cEvents, w4,
+					    FALSE, WSA_INFINITE, FALSE);
+
+	      switch (wfme_res)
+		{
+		case WSA_WAIT_EVENT_0:
+		  debug_printf ("AF_LOCAL: secret event signalled");
+		  complete =3D true;
+		  break;
+
+		case WSA_WAIT_EVENT_0 + 1:
+		  syscall_printf ("AF_LOCAL: signal received during wait");
+		  complete =3D true;
+		  set_errno (EINTR);
+		  res =3D false;
+		  break;
+
+		case WSA_WAIT_EVENT_0 + 2:
+		  {
+		    WSANETWORKEVENTS events;
+		    (void) WSAEnumNetworkEvents (get_socket (),
+						 hWSAEvent,
+						 &events);
+
+		    if (events.lNetworkEvents & FD_CLOSE)
+		      {
+			syscall_printf (("AF_LOCAL: "
+					 "remote close during wait (%d)"),
+					events.iErrorCode[FD_CLOSE_BIT]);
+			complete =3D true;
+		      }
+		    else
+		      debug_printf (("AF_LOCAL: "
+				     "unknown network event during wait (%x)"),
+				    events.lNetworkEvents);
+		  }
+		  break;
+
+		case WSA_WAIT_FAILED:
+		  syscall_printf (("AF_LOCAL: "
+				   "WSAWaitForMultipleEvents failed (%d)"),
+				  WSAGetLastError ());
+		  complete =3D true;
+		  break;
+
+		default:
+		  syscall_printf (("AF_LOCAL: unexpected result "
+				   "from WSAWaitForMultipleEvents (%d)"),
+				  wfme_res);
+		  complete =3D true;
+		  break;
+		}
+	    }
+
+	  /* Unset events for listening socket and switch back to
+	   * blocking mode.
+	   */
+	  if (hWSAEvent)
+	    {
+	      (void) WSAEventSelect (get_socket (), hWSAEvent, 0 );
+	      (void) ioctlsocket (get_socket (), FIONBIO, 0);
+	      (void) WSACloseEvent (hWSAEvent);
+	    }
+	}
+
+      if (res)
+	ForceCloseHandle1 (hSecret, secret_event);
+      else
+	secret_event =3D hSecret;
+    }
+
+  return res;
 }
=20
-int
+bool
 fhandler_socket::check_peer_secret_event (struct sockaddr_in* peer, int* s=
ecret)
 {
+  assert (get_addr_family () =3D=3D AF_LOCAL);
+
   char buf [128];
   HANDLE ev;
   int* secret_ptr =3D (secret ? : connect_secret);
@@ -200,24 +406,41 @@
   __small_sprintf (buf, SECRET_EVENT_NAME, peer->sin_port,
 		  secret_ptr [0], secret_ptr [1],
 		  secret_ptr [2], secret_ptr [3]);
-  ev =3D CreateEvent (&sec_all_nih, FALSE, FALSE, buf);
-  if (!ev && GetLastError () =3D=3D ERROR_ALREADY_EXISTS)
-    {
-      debug_printf ("%s event already exist");
-      ev =3D OpenEvent (EVENT_ALL_ACCESS, FALSE, buf);
-    }
=20
-  signal_secret_event ();
+  bool result =3D false;
=20
-  if (ev)
+  ev =3D OpenSemaphore (SEMAPHORE_MODIFY_STATE, FALSE, buf);
+
+  if (secret)			/* connect */
     {
-      DWORD rc =3D WaitForSingleObject (ev, 10000);
-      debug_printf ("WFSO rc=3D%d", rc);
-      CloseHandle (ev);
-      return (rc =3D=3D WAIT_OBJECT_0 ? 1 : 0 );
+      if (!ev)
+	syscall_printf ("AF_LOCAL: failed to open peer event \"%s\", %E",
+			buf);
+      else
+	{
+	  debug_printf ("AF_LOCAL: found peer event \"%s\"", buf);
+	  result =3D true;
+	}
     }
-  else
-    return 0;
+  else				/* accept */
+    {
+      if (!ev)
+	syscall_printf ("AF_LOCAL: failed to open peer event \"%s\", %E", buf);
+      else
+	if (!ReleaseSemaphore (ev, 1, NULL))
+	  syscall_printf ("AF_LOCAL: failed to signal peer event \"%s\", %E",
+			  buf);
+	else
+	  {
+	    debug_printf ("AF_LOCAL: signalled peer event \"%s\"", buf);
+	    result =3D true;
+	  }
+    }
+
+  if (ev)
+    (void) CloseHandle (ev);
+
+  return result;
 }
=20
 void
@@ -269,7 +492,15 @@
     }
=20
   if (secret_event)
-    fork_fixup (parent, secret_event, "secret_event");
+    {
+      /* Since this copy will be closed eventually and each close
+       * waits for a signal.
+       */
+      if (!ReleaseSemaphore (secret_event, 1, NULL))
+	syscall_printf ("AF_LOCAL: failed to signal the secret event, %E");
+      else
+	debug_printf ("AF_LOCAL: signalled the copy of the secret event");
+    }
 }
=20
 void
@@ -289,10 +520,35 @@
 {
   debug_printf ("here");
   fhandler_socket *fhs =3D (fhandler_socket *) child;
-  fhs->addr_family =3D addr_family;
   fhs->set_io_handle (get_io_handle ());
+  fhs->set_addr_family (get_addr_family ());
+  fhs->set_socket_type (get_socket_type ());
   if (get_addr_family () =3D=3D AF_LOCAL)
-    fhs->set_sun_path (get_sun_path ());
+    {
+      memcpy (fhs->connect_secret, connect_secret,
+	      sizeof (connect_secret));
+      fhs->connect_secret_initialized =3D connect_secret_initialized;
+      if (secret_event)
+	{
+	  if (!DuplicateHandle (hMainProc, secret_event,
+				hMainProc, &fhs->secret_event,
+				0, TRUE, DUPLICATE_SAME_ACCESS))
+	    {
+	      system_printf ("secret event dup (%s) failed, handle %x, %E",
+			     get_name (), get_handle());
+	      __seterrno ();
+	      return -1;
+	    }
+
+	  if (get_close_on_exec ())
+	    ProtectHandle1 (fhs->secret_event, secret_event);
+	  else
+	    ProtectHandle1INH (fhs->secret_event, secret_event);
+	}
+      fhs->set_sun_path (get_sun_path ());
+      fhs->set_peer_sun_path (get_peer_sun_path ());
+    }
+  fhs->had_connect_or_listen =3D had_connect_or_listen;
=20
   fhs->fixup_before_fork_exec (GetCurrentProcessId ());
   if (winsock2_active)
@@ -319,11 +575,17 @@
 int
 fhandler_socket::bind (const struct sockaddr *name, int namelen)
 {
+  if (name->sa_family !=3D get_addr_family ())
+    {
+      set_errno (EAFNOSUPPORT);
+      return -1;
+    }
+
   int res =3D -1;
=20
   if (name->sa_family =3D=3D AF_LOCAL)
     {
-#define un_addr ((struct sockaddr_un *) name)
+      const sockaddr_un *const un_addr =3D (const sockaddr_un *) name;
       struct sockaddr_in sin;
       int len =3D sizeof sin;=20
       int fd;
@@ -338,13 +600,14 @@
       sin.sin_addr.s_addr =3D htonl (INADDR_LOOPBACK);
       if (::bind (get_socket (), (sockaddr *) &sin, len))
 	{
-	  syscall_printf ("AF_LOCAL: bind failed %d", get_errno ());
+	  syscall_printf ("AF_LOCAL: bind failed (%d)", WSAGetLastError ());
 	  set_winsock_errno ();
 	  goto out;
 	}
       if (::getsockname (get_socket (), (sockaddr *) &sin, &len))
 	{
-	  syscall_printf ("AF_LOCAL: getsockname failed %d", get_errno ());
+	  syscall_printf ("AF_LOCAL: getsockname failed (%d)",
+			  WSAGetLastError ());
 	  set_winsock_errno ();
 	  goto out;
 	}
@@ -352,6 +615,23 @@
       sin.sin_port =3D ntohs (sin.sin_port);
       debug_printf ("AF_LOCAL: socket bound to port %u", sin.sin_port);
=20
+      if (!set_connect_secret () || !create_secret_event ())
+	goto out;
+
+      /* The server signals its own secret event immediately since it
+       * is never signalled by the client; if this wasn't done here,
+       * close() would block.
+       */
+      assert (secret_event);
+      if (!ReleaseSemaphore (secret_event, 1, NULL))
+	{
+	  syscall_printf ("AF_LOCAL: failed to signal secret event, %E");
+	  __seterrno_from_win_error (GetLastError ());
+	  goto out;
+	}
+
+      debug_printf ("AF_LOCAL: signalled server's own secret event");
+
       /* bind must fail if file system socket object already exists
 	 so _open () is called with O_EXCL flag. */
       fd =3D _open (un_addr->sun_path,
@@ -364,8 +644,6 @@
 	  goto out;
 	}
=20
-      set_connect_secret ();
-
       char buf[sizeof (SOCKET_COOKIE) + 80];
       __small_sprintf (buf, "%s%u ", SOCKET_COOKIE, sin.sin_port);
       get_connect_secret (strchr (buf, '\0'));
@@ -386,7 +664,6 @@
 	  set_sun_path (un_addr->sun_path);
 	  res =3D 0;
 	}
-#undef un_addr
     }
   else if (::bind (get_socket (), name, namelen))
     set_winsock_errno ();
@@ -401,67 +678,116 @@
 fhandler_socket::connect (const struct sockaddr *name, int namelen)
 {
   int res =3D -1;
-  BOOL secret_check_failed =3D FALSE;
-  BOOL in_progress =3D FALSE;
   sockaddr_in sin;
   int secret [4];
=20
   sigframe thisframe (mainthread);
=20
+  if (name->sa_family !=3D get_addr_family ())
+    {
+      set_errno (EAFNOSUPPORT);
+      return -1;
+    }
+
   if (!get_inet_addr (name, namelen, &sin, &namelen, secret))
     return -1;
=20
+  /* Allocate the local port so that the (local) secret event can be
+   * created ahead of the call to ::connect.
+   */
+  if (get_addr_family () =3D=3D AF_LOCAL && get_socket_type () =3D=3D SOCK=
_STREAM)
+    if (is_unconnected ())
+      {
+	const sockaddr_un *const un_addr =3D (const sockaddr_un *) name;
+
+	if (strlen (un_addr->sun_path) >=3D UNIX_PATH_LEN)
+	  {
+	    set_errno (ENAMETOOLONG);
+	    return -1;
+	  }
+
+	if (!check_peer_secret_event (&sin, secret))
+	  {
+	    syscall_printf ("AF_LOCAL: "
+			    "connection blocked to unauthorized socket");
+	    set_errno (ECONNREFUSED);
+	    return -1;
+	  }
+
+	sockaddr_in addr;
+	const socklen_t addr_len =3D sizeof (addr);
+
+	addr.sin_family =3D AF_INET;
+	addr.sin_port =3D 0;
+	addr.sin_addr.s_addr =3D htonl (INADDR_LOOPBACK);
+
+	if (::bind (get_socket (), (sockaddr *) &addr, addr_len) =3D=3D -1)
+	  {
+	    syscall_printf ("AF_LOCAL: failed to bind INET socket (%d)",
+			    WSAGetLastError ());
+	    set_errno (ECONNREFUSED);
+	    return -1;
+	  }
+
+	if (!create_secret_event (secret))
+	  {
+	    set_errno (ECONNREFUSED);
+	    return -1;
+	  }
+
+	set_peer_sun_path (un_addr->sun_path);
+      }
+
   res =3D ::connect (get_socket (), (sockaddr *) &sin, namelen);
   if (res)
     {
+      const int err =3D WSAGetLastError ();
+
+      /* These checks are outside the `is_nonblocking ()' condition as
+       * a program may have set the socket to blocking *after* having
+       * made a non-blocking call to connect(2).
+       */
+      if (err =3D=3D WSAEALREADY && !is_connect_pending ())
+	debug_printf (("state (%d) out-of-sync: "
+		       "WSAEALREADY && !is_connect_pending ()"),
+		      had_connect_or_listen);
+      if (err =3D=3D WSAEINVAL && is_connect_pending ())
+	WSASetLastError (WSAEALREADY); /* Special case for WinSock 1. */
+
       /* Special handling for connect to return the correct error code
 	 when called on a non-blocking socket. */
       if (is_nonblocking ())
-	{
-	  DWORD err =3D WSAGetLastError ();
-	  if (err =3D=3D WSAEWOULDBLOCK || err =3D=3D WSAEALREADY)
-	    {
-	      WSASetLastError (WSAEINPROGRESS);
-	      in_progress =3D TRUE;
-	    }
-	  else if (err =3D=3D WSAEINVAL)
-	    WSASetLastError (WSAEISCONN);
-	}
-      set_winsock_errno ();
-    }
-  if (get_addr_family () =3D=3D AF_LOCAL && get_socket_type () =3D=3D SOCK=
_STREAM)
-    {
-      if (!res || in_progress)
-	{
-	  if (!create_secret_event (secret))
-	    {
-	      secret_check_failed =3D TRUE;
-	    }
-	  else if (in_progress)
-	    signal_secret_event ();
-	}
+	if (err =3D=3D WSAEWOULDBLOCK)
+	  {
+	    if (is_connect_pending ())
+	      debug_printf (("state (%d) out-of-sync: "
+			     "WSAEWOULDBLOCK && is_connect_pending ()"),
+			    had_connect_or_listen);
+	    WSASetLastError (WSAEINPROGRESS);
+	    set_connect_state (CONNECT_PENDING);
+	  }
+	else if (err =3D=3D WSAEISCONN)
+	  {
+	    /* Nb. The socket's state can be set to CONNECTED by
+	     * set_bits() in "select.cc".
+	     */
+	    if (!is_connect_pending () && !is_connected ())
+	      debug_printf (("state (%d) out-of-sync: "
+			     "WSAEISCONN && !is_connect_pending ()"),
+			    had_connect_or_listen);
+	    set_connect_state (CONNECTED);
+	  }
=20
-      if (!secret_check_failed && !res)
-	{
-	  if (!check_peer_secret_event (&sin, secret))
-	    {
-	      debug_printf ( "accept from unauthorized server" );
-	      secret_check_failed =3D TRUE;
-	    }
-       }
+      /* In case the connection attempt was never seen by the server,
+       * set the secret event here so that we don't block on close.
+       */
+      if (get_addr_family () =3D=3D AF_LOCAL && get_socket_type () =3D=3D =
SOCK_STREAM)
+	if (is_unconnected ())
+	  if (!ReleaseSemaphore (secret_event, 1, NULL))
+	    syscall_printf ("AF_LOCAL: failed to signal secret event, %E");
=20
-      if (secret_check_failed)
-	{
-	  close_secret_event ();
-	  if (res)
-	    closesocket (res);
-	  set_errno (ECONNREFUSED);
-	  res =3D -1;
-	}
+      set_winsock_errno ();
     }
-
-  if (WSAGetLastError () =3D=3D WSAEINPROGRESS)
-    set_connect_state (CONNECT_PENDING);
   else
     set_connect_state (CONNECTED);
   return res;
@@ -483,8 +809,6 @@
 {
   int res =3D -1;
   WSAEVENT ev[2] =3D { WSA_INVALID_EVENT, signal_arrived };
-  BOOL secret_check_failed =3D FALSE;
-  BOOL in_progress =3D FALSE;
=20
   sigframe thisframe (mainthread);
=20
@@ -514,7 +838,7 @@
           !WSAEventSelect (get_socket (), ev[0], FD_ACCEPT))
         {
           WSANETWORKEVENTS sock_event;
-          int wait_result;
+          DWORD wait_result;
=20
           wait_result =3D WSAWaitForMultipleEvents (2, ev, FALSE, WSA_INFI=
NITE,
 	  					  FALSE);
@@ -559,54 +883,41 @@
=20
   res =3D ::accept (get_socket (), peer, len);
=20
-  if ((SOCKET) res =3D=3D (SOCKET) INVALID_SOCKET &&
-      WSAGetLastError () =3D=3D WSAEWOULDBLOCK)
-    in_progress =3D TRUE;
-
-  if (get_addr_family () =3D=3D AF_LOCAL && get_socket_type () =3D=3D SOCK=
_STREAM)
+  if ((SOCKET) res =3D=3D INVALID_SOCKET)
     {
-      if ((SOCKET) res !=3D (SOCKET) INVALID_SOCKET || in_progress)
-	{
-	  if (!create_secret_event ())
-	    secret_check_failed =3D TRUE;
-	  else if (in_progress)=20
-	    signal_secret_event ();
-	}
+      set_winsock_errno ();
+      goto done;
+    }
=20
-      if (!secret_check_failed &&
-	  (SOCKET) res !=3D (SOCKET) INVALID_SOCKET)
-	{
-	  if (!check_peer_secret_event ((struct sockaddr_in*) peer))
-	    {
-	      debug_printf ("connect from unauthorized client");
-	      secret_check_failed =3D TRUE;
-	    }
-	}
+  if (get_addr_family () =3D=3D AF_LOCAL && get_socket_type () =3D=3D SOCK=
_STREAM)
+    if (!check_peer_secret_event ((struct sockaddr_in *) peer))
+      {
+	syscall_printf ("AF_LOCAL: "
+			"connection blocked from unauthorized socket");
=20
-      if (secret_check_failed)
-	{
-	  close_secret_event ();
-	  if ((SOCKET) res !=3D (SOCKET) INVALID_SOCKET)
-	    closesocket (res);
-	  set_errno (ECONNABORTED);
-	  res =3D -1;
-	  goto done;
-	}
-    }
+	const struct linger linger =3D { l_onoff: 1, l_linger: 0 };
+	setsockopt (get_socket (), SOL_SOCKET, SO_LINGER,
+		    (const char *) &linger, sizeof (linger));
+	closesocket (res);
+
+	set_errno (ECONNABORTED);
+	res =3D -1;
+	goto done;
+      }
=20
   {
     cygheap_fdnew res_fd;
-    if (res_fd < 0)
-      /* FIXME: what is correct errno? */;
-    else if ((SOCKET) res =3D=3D (SOCKET) INVALID_SOCKET)
-      set_winsock_errno ();
-    else
+    if (res_fd >=3D 0)
       {
         fhandler_socket* res_fh =3D fdsock (res_fd, get_name (), res);
-        if (get_addr_family () =3D=3D AF_LOCAL)
-          res_fh->set_sun_path (get_sun_path ());
         res_fh->set_addr_family (get_addr_family ());
         res_fh->set_socket_type (get_socket_type ());
+        if (get_addr_family () =3D=3D AF_LOCAL)
+	  {
+	    res_fh->set_sun_path (get_sun_path ());
+	    res_fh->set_peer_sun_path (get_peer_sun_path ());
+	  }
+	res_fh->had_connect_or_listen =3D had_connect_or_listen;
         res =3D res_fd;
       }
   }
@@ -618,6 +929,11 @@
   return res;
 }
=20
+/* getsockname () should only succeed if the socket has been
+ * explicitly or implicitly bound.  For the emulated UNIX domain
+ * sockets, this corresponds to the situation that getsockname () would
+ * succeed on the underlying socket.
+ */
 int
 fhandler_socket::getsockname (struct sockaddr *name, int *namelen)
 {
@@ -625,7 +941,11 @@
=20
   sigframe thisframe (mainthread);
=20
-  if (get_addr_family () =3D=3D AF_LOCAL)
+  res =3D ::getsockname (get_socket (), name, namelen);
+  if (res !=3D 0)
+    set_winsock_errno ();
+
+  if (res =3D=3D 0 && get_addr_family () =3D=3D AF_LOCAL)
     {
       struct sockaddr_un *sun =3D (struct sockaddr_un *) name;
       memset (sun, 0, *namelen);
@@ -643,13 +963,6 @@
=20
       *namelen =3D sizeof *sun - sizeof sun->sun_path
 		 + strlen (sun->sun_path) + 1;
-      res =3D 0;
-    }
-  else
-    {
-      res =3D ::getsockname (get_socket (), name, namelen);
-      if (res)
-	set_winsock_errno ();
     }
=20
   return res;
@@ -664,6 +977,26 @@
   if (res)
     set_winsock_errno ();
=20
+  if (res =3D=3D 0 && get_addr_family () =3D=3D AF_LOCAL)
+    {
+      struct sockaddr_un *const sun =3D (struct sockaddr_un *) name;
+      memset (sun, '\0', *namelen);
+      sun->sun_family =3D AF_LOCAL;
+
+      if (!get_peer_sun_path ())
+	sun->sun_path[0] =3D '\0';
+      else
+	/* According to SUSv2 "If the actual length of the address is
+	   greater than the length of the supplied sockaddr structure, the
+	   stored address will be truncated."  We play it save here so
+	   that the path always has a trailing 0 even if it's truncated. */
+	strncpy (sun->sun_path, get_peer_sun_path (),
+		 *namelen - sizeof *sun + sizeof sun->sun_path - 1);
+
+      *namelen =3D sizeof *sun - sizeof sun->sun_path
+		 + strlen (sun->sun_path) + 1;
+    }
+
   return res;
 }
=20
@@ -942,6 +1275,9 @@
=20
   sigframe thisframe (mainthread);
=20
+  if (!close_secret_event ())
+    return -1;			// EINTR
+
   /* HACK to allow a graceful shutdown even if shutdown() hasn't been
      called by the application. Note that this isn't the ultimate
      solution but it helps in many cases. */
@@ -968,8 +1304,6 @@
       WSASetLastError (0);
     }
=20
-  close_secret_event ();
-
   debug_printf ("%d =3D fhandler_socket::close()", res);
   return res;
 }
@@ -1152,5 +1486,21 @@
 void
 fhandler_socket::set_sun_path (const char *path)
 {
+  assert (get_addr_family () =3D=3D AF_LOCAL);
+
+  if (sun_path)
+    cfree (sun_path);
+
   sun_path =3D path ? cstrdup (path) : NULL;
+}
+
+void
+fhandler_socket::set_peer_sun_path (const char *const path)
+{
+  assert (get_addr_family () =3D=3D AF_LOCAL);
+
+  if (peer_sun_path)
+    cfree (peer_sun_path);
+
+  peer_sun_path =3D path ? cstrdup (path) : NULL;
 }
Index: net.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/net.cc,v
retrieving revision 1.118
diff -u -r1.118 net.cc
--- net.cc	6 Jul 2002 11:16:07 -0000	1.118
+++ net.cc	27 Jul 2002 19:02:38 -0000
@@ -519,6 +519,12 @@
 extern "C" int
 cygwin_socket (int af, int type, int protocol)
 {
+  if (af !=3D AF_INET && af !=3D AF_LOCAL)
+    {
+      set_errno (EAFNOSUPPORT);
+      return -1;
+    }
+
   int res =3D -1;
   SOCKET soc =3D 0;
   fhandler_socket* fh =3D NULL;

------=_NextPart_000_002B_01C23730.63CA5EC0--

