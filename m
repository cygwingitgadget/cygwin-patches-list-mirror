Return-Path: <cygwin-patches-return-2745-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9970 invoked by alias); 29 Jul 2002 16:56:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9907 invoked from network); 29 Jul 2002 16:56:22 -0000
Message-ID: <007a01c23721$31a7bc80$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <03f001c23504$5be06890$6132bc3e@BABEL> <025701c235a1$058cb730$6132bc3e@BABEL> <20020729150716.X3921@cygbert.vinschen.de>
Subject: Re: UNIX domain socket patch
Date: Mon, 29 Jul 2002 09:56:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0077_01C23729.93043AF0"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00193.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0077_01C23729.93043AF0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 451

"Corinna Vinschen" <cygwin-patches@cygwin.com> wrote:
> even if it's a pretty big patch, could you please attach it in
> clear text rather than using some sort of compressing on it?
>
> The reason is, it's not as easy to discuss parts of the code
> if it's not possible to quote code from the original mail.

. . . and just when I thought I was getting the hang of being a
considerate emailer :-)

Attached again, in clear text this time.

// Conrad


------=_NextPart_000_0077_01C23729.93043AF0
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

------=_NextPart_000_0077_01C23729.93043AF0
Content-Type: application/octet-stream;
	name="af_local.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="af_local.patch"
Content-length: 33960

Index: fhandler.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v=0A=
retrieving revision 1.130=0A=
diff -u -r1.130 fhandler.h=0A=
--- fhandler.h	22 Jul 2002 09:11:44 -0000	1.130=0A=
+++ fhandler.h	27 Jul 2002 19:02:37 -0000=0A=
@@ -368,9 +368,11 @@=0A=
   int addr_family;=0A=
   int type;=0A=
   int connect_secret [4];=0A=
+  bool connect_secret_initialized;=0A=
   HANDLE secret_event;=0A=
   struct _WSAPROTOCOL_INFOA *prot_info_ptr;=0A=
   char *sun_path;=0A=
+  char *peer_sun_path;=0A=
   int had_connect_or_listen;=0A=
=20=0A=
  public:=0A=
@@ -432,12 +434,13 @@=0A=
   int get_socket_type () {return type;}=0A=
   void set_sun_path (const char *path);=0A=
   char *get_sun_path () {return sun_path;}=0A=
-  void set_connect_secret ();=0A=
-  void get_connect_secret (char*);=0A=
-  HANDLE create_secret_event (int *secret =3D NULL);=0A=
-  int check_peer_secret_event (struct sockaddr_in *peer, int *secret =3D N=
ULL);=0A=
-  void signal_secret_event ();=0A=
-  void close_secret_event ();=0A=
+  void set_peer_sun_path (const char *path);=0A=
+  char *get_peer_sun_path () {return peer_sun_path;}=0A=
+  bool set_connect_secret ();=0A=
+  void get_connect_secret (char *);=0A=
+  bool create_secret_event (int *secret =3D NULL);=0A=
+  bool check_peer_secret_event (struct sockaddr_in *peer, int *secret =3D =
NULL);=0A=
+  bool close_secret_event ();=0A=
   int __stdcall fstat (struct __stat64 *buf, path_conv *) __attribute__ ((=
regparm (3)));=0A=
 };=0A=
=20=0A=
Index: fhandler_socket.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_socket.cc,v=0A=
retrieving revision 1.55=0A=
diff -u -r1.55 fhandler_socket.cc=0A=
--- fhandler_socket.cc	13 Jul 2002 20:00:25 -0000	1.55=0A=
+++ fhandler_socket.cc	27 Jul 2002 19:02:37 -0000=0A=
@@ -19,6 +19,8 @@=0A=
 #include <sys/uio.h>=0A=
 #include <asm/byteorder.h>=0A=
=20=0A=
+#include <assert.h>=0A=
+#include <stdio.h>=0A=
 #include <stdlib.h>=0A=
 #include <unistd.h>=0A=
 #define USE_SYS_TYPES_FD_SET=0A=
@@ -35,12 +37,11 @@=0A=
 #include "wsock_event.h"=0A=
=20=0A=
 #define SECRET_EVENT_NAME "cygwin.local_socket.secret.%d.%08x-%08x-%08x-%0=
8x"=0A=
-#define ENTROPY_SOURCE_NAME "/dev/urandom"=0A=
-#define ENTROPY_SOURCE_DEV_UNIT 9=0A=
+#define ENTROPY_SOURCE_DEV_UNIT 9 /* /dev/urandom */=0A=
=20=0A=
 extern fhandler_socket *fdsock (int& fd, const char *name, SOCKET soc);=0A=
 extern "C" {=0A=
-int sscanf (const char *, const char *, ...);=0A=
+int _fstat (int, struct __stat32 *);=0A=
 } /* End of "C" section */=0A=
=20=0A=
 fhandler_dev_random* entropy_source;=0A=
@@ -65,6 +66,25 @@=0A=
       if (fd =3D=3D -1)=0A=
         return 0;=0A=
=20=0A=
+      {=0A=
+	struct __stat32 sbuf;=0A=
+	if (_fstat (fd, &sbuf) =3D=3D -1)=0A=
+	  {=0A=
+	    save_errno here;=0A=
+	    _close (fd);=0A=
+	    return 0;=0A=
+	  }=0A=
+=0A=
+	if (!S_ISSOCK (sbuf.st_mode))=0A=
+	  {=0A=
+	    syscall_printf ("AF_LOCAL: \"%s\" is not a socket file",=0A=
+			    in->sa_data);=0A=
+	    _close (fd);=0A=
+	    set_errno (EINVAL);=0A=
+	    return 0;=0A=
+	  }=0A=
+      }=0A=
+=0A=
       int ret =3D 0;=0A=
       char buf[128];=0A=
       memset (buf, 0, sizeof buf);=0A=
@@ -72,15 +92,26 @@=0A=
         {=0A=
           sockaddr_in sin;=0A=
           sin.sin_family =3D AF_INET;=0A=
-          sscanf (buf + strlen (SOCKET_COOKIE), "%hu %08x-%08x-%08x-%08x",=
=0A=
-                  &sin.sin_port,=0A=
-                  secret_ptr, secret_ptr + 1, secret_ptr + 2, secret_ptr +=
 3);=0A=
-          sin.sin_port =3D htons (sin.sin_port);=0A=
-          sin.sin_addr.s_addr =3D htonl (INADDR_LOOPBACK);=0A=
-          *out =3D sin;=0A=
-          *outlen =3D sizeof sin;=0A=
-          ret =3D 1;=0A=
+          if (sscanf (buf, (SOCKET_COOKIE "%hu %08x-%08x-%08x-%08x"),=0A=
+		      &sin.sin_port,=0A=
+		      secret_ptr + 0, secret_ptr + 1,=0A=
+		      secret_ptr + 2, secret_ptr + 3) !=3D 5)=0A=
+	    {=0A=
+	      syscall_printf ("AF_LOCAL: "=0A=
+			      "file system socket object bad format");=0A=
+	      set_errno (EINVAL);=0A=
+	      ret =3D 0;=0A=
+	    }=0A=
+	  else=0A=
+	    {=0A=
+	      sin.sin_port =3D htons (sin.sin_port);=0A=
+	      sin.sin_addr.s_addr =3D htonl (INADDR_LOOPBACK);=0A=
+	      *out =3D sin;=0A=
+	      *outlen =3D sizeof sin;=0A=
+	      ret =3D 1;=0A=
+	    }=0A=
         }=0A=
+      save_errno here;=0A=
       _close (fd);=0A=
       return ret;=0A=
     }=0A=
@@ -95,8 +126,17 @@=0A=
 /* fhandler_socket */=0A=
=20=0A=
 fhandler_socket::fhandler_socket ()=0A=
-  : fhandler_base (FH_SOCKET), sun_path (NULL)=0A=
+  : fhandler_base (FH_SOCKET),=0A=
+    addr_family (AF_UNSPEC),=0A=
+    type (0),			/* i.e. `SOCK_UNSPEC' */=0A=
+    connect_secret_initialized (false),=0A=
+    secret_event (NULL),=0A=
+    prot_info_ptr (NULL),=0A=
+    sun_path (NULL),=0A=
+    peer_sun_path (NULL),=0A=
+    had_connect_or_listen (UNCONNECTED)=0A=
 {=0A=
+  bzero (connect_secret, sizeof (connect_secret));=0A=
   set_need_fork_fixup ();=0A=
   prot_info_ptr =3D (LPWSAPROTOCOL_INFOA) cmalloc (HEAP_BUF,=0A=
 						 sizeof (WSAPROTOCOL_INFOA));=0A=
@@ -104,43 +144,76 @@=0A=
=20=0A=
 fhandler_socket::~fhandler_socket ()=0A=
 {=0A=
+  close_secret_event ();=0A=
   if (prot_info_ptr)=0A=
     cfree (prot_info_ptr);=0A=
   if (sun_path)=0A=
     cfree (sun_path);=0A=
+  if (peer_sun_path)=0A=
+    cfree (peer_sun_path);=0A=
 }=0A=
=20=0A=
-void=0A=
+bool=0A=
 fhandler_socket::set_connect_secret ()=0A=
 {=0A=
+  assert (get_addr_family () =3D=3D AF_LOCAL);=0A=
+  assert (!connect_secret_initialized);=0A=
+=0A=
   if (!entropy_source)=0A=
     {=0A=
       void *buf =3D malloc (sizeof (fhandler_dev_random));=0A=
       entropy_source =3D new (buf) fhandler_dev_random (ENTROPY_SOURCE_DEV=
_UNIT);=0A=
     }=0A=
-  if (entropy_source &&=0A=
-      !entropy_source->open (NULL, O_RDONLY))=0A=
+=0A=
+  if (!entropy_source)=0A=
+    {=0A=
+      syscall_printf ("AF_LOCAL: failed to allocate entropy source");=0A=
+      set_errno (ENOMEM);=0A=
+    }=0A=
+  else if (!entropy_source->open (NULL, O_RDONLY))=0A=
+    {=0A=
+      syscall_printf ("AF_LOCAL: failed to open entropy source (%d)",=0A=
+		      get_errno ());=0A=
+    }=0A=
+  else if (entropy_source->read (connect_secret, sizeof (connect_secret))=
=0A=
+	   !=3D sizeof (connect_secret))=0A=
     {=0A=
-      delete entropy_source;=0A=
+      syscall_printf ("AF_LOCAL: failed to read from entropy source (%d)",=
=0A=
+		      get_errno ());=0A=
+      bzero (connect_secret, sizeof (connect_secret));=0A=
+    }=0A=
+  else=0A=
+    connect_secret_initialized =3D true;=0A=
+=0A=
+  if (entropy_source && !connect_secret_initialized)=0A=
+    {=0A=
+      save_errno here;=0A=
+      entropy_source->~fhandler_dev_random ();=0A=
+      free (entropy_source);=0A=
       entropy_source =3D NULL;=0A=
     }=0A=
-  if (!entropy_source ||=0A=
-      (entropy_source->read (connect_secret, sizeof (connect_secret)) !=3D=
=0A=
-					     sizeof (connect_secret)))=0A=
-    bzero ((char*) connect_secret, sizeof (connect_secret));=0A=
+=0A=
+  return connect_secret_initialized;=0A=
 }=0A=
=20=0A=
 void=0A=
 fhandler_socket::get_connect_secret (char* buf)=0A=
 {=0A=
+  assert (get_addr_family () =3D=3D AF_LOCAL);=0A=
+  assert (connect_secret_initialized);=0A=
+=0A=
   __small_sprintf (buf, "%08x-%08x-%08x-%08x",=0A=
 		   connect_secret [0], connect_secret [1],=0A=
 		   connect_secret [2], connect_secret [3]);=0A=
 }=0A=
=20=0A=
-HANDLE=0A=
+bool=0A=
 fhandler_socket::create_secret_event (int* secret)=0A=
 {=0A=
+  assert (get_addr_family () =3D=3D AF_LOCAL);=0A=
+  assert (!secret_event);=0A=
+  assert (secret || connect_secret_initialized);=0A=
+=0A=
   char buf [128];=0A=
   int* secret_ptr =3D (secret ? : connect_secret);=0A=
   struct sockaddr_in sin;=0A=
@@ -148,51 +221,184 @@=0A=
=20=0A=
   if (::getsockname (get_socket (), (struct sockaddr*) &sin, &sin_len))=0A=
     {=0A=
-      debug_printf ("error getting local socket name (%d)", WSAGetLastErro=
r ());=0A=
-      return NULL;=0A=
+      syscall_printf ("AF_LOCAL: getsockname failed (%d)", WSAGetLastError=
 ());=0A=
+      set_winsock_errno ();=0A=
+      return false;=0A=
     }=0A=
=20=0A=
   __small_sprintf (buf, SECRET_EVENT_NAME, sin.sin_port,=0A=
 		   secret_ptr [0], secret_ptr [1],=0A=
 		   secret_ptr [2], secret_ptr [3]);=0A=
   LPSECURITY_ATTRIBUTES sec =3D get_inheritance (true);=0A=
-  secret_event =3D CreateEvent (sec, FALSE, FALSE, buf);=0A=
-  if (!secret_event && GetLastError () =3D=3D ERROR_ALREADY_EXISTS)=0A=
-    secret_event =3D OpenEvent (EVENT_ALL_ACCESS, FALSE, buf);=0A=
-=0A=
-  if (!secret_event)=0A=
-    /* nothing to do */;=0A=
-  else if (sec =3D=3D &sec_all_nih || sec =3D=3D &sec_none_nih)=0A=
-    ProtectHandle (secret_event);=0A=
-  else=0A=
-    ProtectHandleINH (secret_event);=0A=
+  secret_event =3D CreateSemaphore (sec, 0, 1023, buf);=0A=
=20=0A=
-  return secret_event;=0A=
-}=0A=
+  bool res =3D false;=0A=
=20=0A=
-void=0A=
-fhandler_socket::signal_secret_event ()=0A=
-{=0A=
   if (!secret_event)=0A=
-    debug_printf ("no secret event?");=0A=
+    syscall_printf ("AF_LOCAL: failed to create secret event \"%s\", %E", =
buf);=0A=
+  else if (GetLastError () =3D=3D ERROR_ALREADY_EXISTS)=0A=
+    {=0A=
+      syscall_printf ("AF_LOCAL: secret event \"%s\" already exists", buf)=
;=0A=
+      (void) CloseHandle (secret_event);=0A=
+      secret_event =3D NULL;=0A=
+    }=0A=
   else=0A=
     {=0A=
-      SetEvent (secret_event);=0A=
-      debug_printf ("signaled secret_event");=0A=
+      debug_printf ("AF_LOCAL: created event \"%s\"", buf);=0A=
+=0A=
+      if (get_close_on_exec ())=0A=
+	ProtectHandle (secret_event);=0A=
+      else=0A=
+	ProtectHandleINH (secret_event);=0A=
+=0A=
+      res =3D true;=0A=
     }=0A=
+=0A=
+  return res;=0A=
 }=0A=
=20=0A=
-void=0A=
+/* The client in a UNIX domain socket connection must make sure that=0A=
+ * its secret event still exists by the time that the accept(2) call=0A=
+ * happens in the server.  This is only problematic for clients that=0A=
+ * only write to the socket and don't read; these can close the socket=0A=
+ * too quickly for the server to detect it.  To avoid this, the client=0A=
+ * waits for the server to signal its secret event, which it does in=0A=
+ * accept(2).  To avoid testing here whether this is the server or the=0A=
+ * client end of a connection, the server signals its own secret event=0A=
+ * when it creates it so waiting on it is safe here.  A similar trick=0A=
+ * is used when duplicating a socket or forking: the copy is signalled=0A=
+ * immediately.  In this way the number of open copies is always one=0A=
+ * greater than the event count, until the server also signals the=0A=
+ * event; only then is the client free to close every event handle.=0A=
+ *=0A=
+ * Nb. The WaitForSingleObject is not an optimization.  Rather the=0A=
+ * idea is that the WSAWaitForMultipleEvents is only called for the=0A=
+ * last close on a socket, as otherwise the WSAEventSelect can=0A=
+ * interfere with other uses of that, i.e., the one in the accept=0A=
+ * method, since it seems to clear *all* the pending event information=0A=
+ * on the socket when called, i.e., including any pending accept.=0A=
+ */=0A=
+bool=0A=
 fhandler_socket::close_secret_event ()=0A=
 {=0A=
+  bool res =3D true;=0A=
+=0A=
   if (secret_event)=0A=
-    ForceCloseHandle (secret_event);=0A=
-  secret_event =3D NULL;=0A=
+    {=0A=
+      const HANDLE hSecret =3D secret_event;=0A=
+      secret_event =3D NULL;=0A=
+=0A=
+      const DWORD wfso_res =3D WaitForSingleObject (hSecret, 0);=0A=
+=0A=
+      if (wfso_res =3D=3D WAIT_OBJECT_0)=0A=
+	debug_printf ("AF_LOCAL: secret event signalled");=0A=
+      else=0A=
+	{=0A=
+	  HANDLE hWSAEvent =3D WSACreateEvent ();=0A=
+=0A=
+	  if (hWSAEvent =3D=3D WSA_INVALID_EVENT)=0A=
+	    {=0A=
+	      syscall_printf ("AF_LOCAL: WSACreateEvent failed (%d)",=0A=
+			      WSAGetLastError ());=0A=
+	      hWSAEvent =3D NULL;=0A=
+	    }=0A=
+	  else if (WSAEventSelect (get_socket (),=0A=
+				   hWSAEvent,=0A=
+				   FD_CLOSE) =3D=3D SOCKET_ERROR)=0A=
+	    {=0A=
+	      syscall_printf ("AF_LOCAL: WSAEventSelect failed (%d)",=0A=
+			      WSAGetLastError ());=0A=
+	      (void) WSACloseEvent (hWSAEvent);=0A=
+	      hWSAEvent =3D NULL;=0A=
+	    }=0A=
+=0A=
+	  const WSAEVENT w4[] =3D { hSecret, signal_arrived, hWSAEvent };=0A=
+	  const int cEvents =3D (hWSAEvent ? 3 : 2);=0A=
+=0A=
+	  bool complete =3D false;=0A=
+=0A=
+	  while (!complete)=0A=
+	    {=0A=
+	      const DWORD wfme_res=0A=
+		=3D WSAWaitForMultipleEvents (cEvents, w4,=0A=
+					    FALSE, WSA_INFINITE, FALSE);=0A=
+=0A=
+	      switch (wfme_res)=0A=
+		{=0A=
+		case WSA_WAIT_EVENT_0:=0A=
+		  debug_printf ("AF_LOCAL: secret event signalled");=0A=
+		  complete =3D true;=0A=
+		  break;=0A=
+=0A=
+		case WSA_WAIT_EVENT_0 + 1:=0A=
+		  syscall_printf ("AF_LOCAL: signal received during wait");=0A=
+		  complete =3D true;=0A=
+		  set_errno (EINTR);=0A=
+		  res =3D false;=0A=
+		  break;=0A=
+=0A=
+		case WSA_WAIT_EVENT_0 + 2:=0A=
+		  {=0A=
+		    WSANETWORKEVENTS events;=0A=
+		    (void) WSAEnumNetworkEvents (get_socket (),=0A=
+						 hWSAEvent,=0A=
+						 &events);=0A=
+=0A=
+		    if (events.lNetworkEvents & FD_CLOSE)=0A=
+		      {=0A=
+			syscall_printf (("AF_LOCAL: "=0A=
+					 "remote close during wait (%d)"),=0A=
+					events.iErrorCode[FD_CLOSE_BIT]);=0A=
+			complete =3D true;=0A=
+		      }=0A=
+		    else=0A=
+		      debug_printf (("AF_LOCAL: "=0A=
+				     "unknown network event during wait (%x)"),=0A=
+				    events.lNetworkEvents);=0A=
+		  }=0A=
+		  break;=0A=
+=0A=
+		case WSA_WAIT_FAILED:=0A=
+		  syscall_printf (("AF_LOCAL: "=0A=
+				   "WSAWaitForMultipleEvents failed (%d)"),=0A=
+				  WSAGetLastError ());=0A=
+		  complete =3D true;=0A=
+		  break;=0A=
+=0A=
+		default:=0A=
+		  syscall_printf (("AF_LOCAL: unexpected result "=0A=
+				   "from WSAWaitForMultipleEvents (%d)"),=0A=
+				  wfme_res);=0A=
+		  complete =3D true;=0A=
+		  break;=0A=
+		}=0A=
+	    }=0A=
+=0A=
+	  /* Unset events for listening socket and switch back to=0A=
+	   * blocking mode.=0A=
+	   */=0A=
+	  if (hWSAEvent)=0A=
+	    {=0A=
+	      (void) WSAEventSelect (get_socket (), hWSAEvent, 0 );=0A=
+	      (void) ioctlsocket (get_socket (), FIONBIO, 0);=0A=
+	      (void) WSACloseEvent (hWSAEvent);=0A=
+	    }=0A=
+	}=0A=
+=0A=
+      if (res)=0A=
+	ForceCloseHandle1 (hSecret, secret_event);=0A=
+      else=0A=
+	secret_event =3D hSecret;=0A=
+    }=0A=
+=0A=
+  return res;=0A=
 }=0A=
=20=0A=
-int=0A=
+bool=0A=
 fhandler_socket::check_peer_secret_event (struct sockaddr_in* peer, int* s=
ecret)=0A=
 {=0A=
+  assert (get_addr_family () =3D=3D AF_LOCAL);=0A=
+=0A=
   char buf [128];=0A=
   HANDLE ev;=0A=
   int* secret_ptr =3D (secret ? : connect_secret);=0A=
@@ -200,24 +406,41 @@=0A=
   __small_sprintf (buf, SECRET_EVENT_NAME, peer->sin_port,=0A=
 		  secret_ptr [0], secret_ptr [1],=0A=
 		  secret_ptr [2], secret_ptr [3]);=0A=
-  ev =3D CreateEvent (&sec_all_nih, FALSE, FALSE, buf);=0A=
-  if (!ev && GetLastError () =3D=3D ERROR_ALREADY_EXISTS)=0A=
-    {=0A=
-      debug_printf ("%s event already exist");=0A=
-      ev =3D OpenEvent (EVENT_ALL_ACCESS, FALSE, buf);=0A=
-    }=0A=
=20=0A=
-  signal_secret_event ();=0A=
+  bool result =3D false;=0A=
=20=0A=
-  if (ev)=0A=
+  ev =3D OpenSemaphore (SEMAPHORE_MODIFY_STATE, FALSE, buf);=0A=
+=0A=
+  if (secret)			/* connect */=0A=
     {=0A=
-      DWORD rc =3D WaitForSingleObject (ev, 10000);=0A=
-      debug_printf ("WFSO rc=3D%d", rc);=0A=
-      CloseHandle (ev);=0A=
-      return (rc =3D=3D WAIT_OBJECT_0 ? 1 : 0 );=0A=
+      if (!ev)=0A=
+	syscall_printf ("AF_LOCAL: failed to open peer event \"%s\", %E",=0A=
+			buf);=0A=
+      else=0A=
+	{=0A=
+	  debug_printf ("AF_LOCAL: found peer event \"%s\"", buf);=0A=
+	  result =3D true;=0A=
+	}=0A=
     }=0A=
-  else=0A=
-    return 0;=0A=
+  else				/* accept */=0A=
+    {=0A=
+      if (!ev)=0A=
+	syscall_printf ("AF_LOCAL: failed to open peer event \"%s\", %E", buf);=
=0A=
+      else=0A=
+	if (!ReleaseSemaphore (ev, 1, NULL))=0A=
+	  syscall_printf ("AF_LOCAL: failed to signal peer event \"%s\", %E",=0A=
+			  buf);=0A=
+	else=0A=
+	  {=0A=
+	    debug_printf ("AF_LOCAL: signalled peer event \"%s\"", buf);=0A=
+	    result =3D true;=0A=
+	  }=0A=
+    }=0A=
+=0A=
+  if (ev)=0A=
+    (void) CloseHandle (ev);=0A=
+=0A=
+  return result;=0A=
 }=0A=
=20=0A=
 void=0A=
@@ -269,7 +492,15 @@=0A=
     }=0A=
=20=0A=
   if (secret_event)=0A=
-    fork_fixup (parent, secret_event, "secret_event");=0A=
+    {=0A=
+      /* Since this copy will be closed eventually and each close=0A=
+       * waits for a signal.=0A=
+       */=0A=
+      if (!ReleaseSemaphore (secret_event, 1, NULL))=0A=
+	syscall_printf ("AF_LOCAL: failed to signal the secret event, %E");=0A=
+      else=0A=
+	debug_printf ("AF_LOCAL: signalled the copy of the secret event");=0A=
+    }=0A=
 }=0A=
=20=0A=
 void=0A=
@@ -289,10 +520,35 @@=0A=
 {=0A=
   debug_printf ("here");=0A=
   fhandler_socket *fhs =3D (fhandler_socket *) child;=0A=
-  fhs->addr_family =3D addr_family;=0A=
   fhs->set_io_handle (get_io_handle ());=0A=
+  fhs->set_addr_family (get_addr_family ());=0A=
+  fhs->set_socket_type (get_socket_type ());=0A=
   if (get_addr_family () =3D=3D AF_LOCAL)=0A=
-    fhs->set_sun_path (get_sun_path ());=0A=
+    {=0A=
+      memcpy (fhs->connect_secret, connect_secret,=0A=
+	      sizeof (connect_secret));=0A=
+      fhs->connect_secret_initialized =3D connect_secret_initialized;=0A=
+      if (secret_event)=0A=
+	{=0A=
+	  if (!DuplicateHandle (hMainProc, secret_event,=0A=
+				hMainProc, &fhs->secret_event,=0A=
+				0, TRUE, DUPLICATE_SAME_ACCESS))=0A=
+	    {=0A=
+	      system_printf ("secret event dup (%s) failed, handle %x, %E",=0A=
+			     get_name (), get_handle());=0A=
+	      __seterrno ();=0A=
+	      return -1;=0A=
+	    }=0A=
+=0A=
+	  if (get_close_on_exec ())=0A=
+	    ProtectHandle1 (fhs->secret_event, secret_event);=0A=
+	  else=0A=
+	    ProtectHandle1INH (fhs->secret_event, secret_event);=0A=
+	}=0A=
+      fhs->set_sun_path (get_sun_path ());=0A=
+      fhs->set_peer_sun_path (get_peer_sun_path ());=0A=
+    }=0A=
+  fhs->had_connect_or_listen =3D had_connect_or_listen;=0A=
=20=0A=
   fhs->fixup_before_fork_exec (GetCurrentProcessId ());=0A=
   if (winsock2_active)=0A=
@@ -319,11 +575,17 @@=0A=
 int=0A=
 fhandler_socket::bind (const struct sockaddr *name, int namelen)=0A=
 {=0A=
+  if (name->sa_family !=3D get_addr_family ())=0A=
+    {=0A=
+      set_errno (EAFNOSUPPORT);=0A=
+      return -1;=0A=
+    }=0A=
+=0A=
   int res =3D -1;=0A=
=20=0A=
   if (name->sa_family =3D=3D AF_LOCAL)=0A=
     {=0A=
-#define un_addr ((struct sockaddr_un *) name)=0A=
+      const sockaddr_un *const un_addr =3D (const sockaddr_un *) name;=0A=
       struct sockaddr_in sin;=0A=
       int len =3D sizeof sin;=20=0A=
       int fd;=0A=
@@ -338,13 +600,14 @@=0A=
       sin.sin_addr.s_addr =3D htonl (INADDR_LOOPBACK);=0A=
       if (::bind (get_socket (), (sockaddr *) &sin, len))=0A=
 	{=0A=
-	  syscall_printf ("AF_LOCAL: bind failed %d", get_errno ());=0A=
+	  syscall_printf ("AF_LOCAL: bind failed (%d)", WSAGetLastError ());=0A=
 	  set_winsock_errno ();=0A=
 	  goto out;=0A=
 	}=0A=
       if (::getsockname (get_socket (), (sockaddr *) &sin, &len))=0A=
 	{=0A=
-	  syscall_printf ("AF_LOCAL: getsockname failed %d", get_errno ());=0A=
+	  syscall_printf ("AF_LOCAL: getsockname failed (%d)",=0A=
+			  WSAGetLastError ());=0A=
 	  set_winsock_errno ();=0A=
 	  goto out;=0A=
 	}=0A=
@@ -352,6 +615,23 @@=0A=
       sin.sin_port =3D ntohs (sin.sin_port);=0A=
       debug_printf ("AF_LOCAL: socket bound to port %u", sin.sin_port);=0A=
=20=0A=
+      if (!set_connect_secret () || !create_secret_event ())=0A=
+	goto out;=0A=
+=0A=
+      /* The server signals its own secret event immediately since it=0A=
+       * is never signalled by the client; if this wasn't done here,=0A=
+       * close() would block.=0A=
+       */=0A=
+      assert (secret_event);=0A=
+      if (!ReleaseSemaphore (secret_event, 1, NULL))=0A=
+	{=0A=
+	  syscall_printf ("AF_LOCAL: failed to signal secret event, %E");=0A=
+	  __seterrno_from_win_error (GetLastError ());=0A=
+	  goto out;=0A=
+	}=0A=
+=0A=
+      debug_printf ("AF_LOCAL: signalled server's own secret event");=0A=
+=0A=
       /* bind must fail if file system socket object already exists=0A=
 	 so _open () is called with O_EXCL flag. */=0A=
       fd =3D _open (un_addr->sun_path,=0A=
@@ -364,8 +644,6 @@=0A=
 	  goto out;=0A=
 	}=0A=
=20=0A=
-      set_connect_secret ();=0A=
-=0A=
       char buf[sizeof (SOCKET_COOKIE) + 80];=0A=
       __small_sprintf (buf, "%s%u ", SOCKET_COOKIE, sin.sin_port);=0A=
       get_connect_secret (strchr (buf, '\0'));=0A=
@@ -386,7 +664,6 @@=0A=
 	  set_sun_path (un_addr->sun_path);=0A=
 	  res =3D 0;=0A=
 	}=0A=
-#undef un_addr=0A=
     }=0A=
   else if (::bind (get_socket (), name, namelen))=0A=
     set_winsock_errno ();=0A=
@@ -401,67 +678,116 @@=0A=
 fhandler_socket::connect (const struct sockaddr *name, int namelen)=0A=
 {=0A=
   int res =3D -1;=0A=
-  BOOL secret_check_failed =3D FALSE;=0A=
-  BOOL in_progress =3D FALSE;=0A=
   sockaddr_in sin;=0A=
   int secret [4];=0A=
=20=0A=
   sigframe thisframe (mainthread);=0A=
=20=0A=
+  if (name->sa_family !=3D get_addr_family ())=0A=
+    {=0A=
+      set_errno (EAFNOSUPPORT);=0A=
+      return -1;=0A=
+    }=0A=
+=0A=
   if (!get_inet_addr (name, namelen, &sin, &namelen, secret))=0A=
     return -1;=0A=
=20=0A=
+  /* Allocate the local port so that the (local) secret event can be=0A=
+   * created ahead of the call to ::connect.=0A=
+   */=0A=
+  if (get_addr_family () =3D=3D AF_LOCAL && get_socket_type () =3D=3D SOCK=
_STREAM)=0A=
+    if (is_unconnected ())=0A=
+      {=0A=
+	const sockaddr_un *const un_addr =3D (const sockaddr_un *) name;=0A=
+=0A=
+	if (strlen (un_addr->sun_path) >=3D UNIX_PATH_LEN)=0A=
+	  {=0A=
+	    set_errno (ENAMETOOLONG);=0A=
+	    return -1;=0A=
+	  }=0A=
+=0A=
+	if (!check_peer_secret_event (&sin, secret))=0A=
+	  {=0A=
+	    syscall_printf ("AF_LOCAL: "=0A=
+			    "connection blocked to unauthorized socket");=0A=
+	    set_errno (ECONNREFUSED);=0A=
+	    return -1;=0A=
+	  }=0A=
+=0A=
+	sockaddr_in addr;=0A=
+	const socklen_t addr_len =3D sizeof (addr);=0A=
+=0A=
+	addr.sin_family =3D AF_INET;=0A=
+	addr.sin_port =3D 0;=0A=
+	addr.sin_addr.s_addr =3D htonl (INADDR_LOOPBACK);=0A=
+=0A=
+	if (::bind (get_socket (), (sockaddr *) &addr, addr_len) =3D=3D -1)=0A=
+	  {=0A=
+	    syscall_printf ("AF_LOCAL: failed to bind INET socket (%d)",=0A=
+			    WSAGetLastError ());=0A=
+	    set_errno (ECONNREFUSED);=0A=
+	    return -1;=0A=
+	  }=0A=
+=0A=
+	if (!create_secret_event (secret))=0A=
+	  {=0A=
+	    set_errno (ECONNREFUSED);=0A=
+	    return -1;=0A=
+	  }=0A=
+=0A=
+	set_peer_sun_path (un_addr->sun_path);=0A=
+      }=0A=
+=0A=
   res =3D ::connect (get_socket (), (sockaddr *) &sin, namelen);=0A=
   if (res)=0A=
     {=0A=
+      const int err =3D WSAGetLastError ();=0A=
+=0A=
+      /* These checks are outside the `is_nonblocking ()' condition as=0A=
+       * a program may have set the socket to blocking *after* having=0A=
+       * made a non-blocking call to connect(2).=0A=
+       */=0A=
+      if (err =3D=3D WSAEALREADY && !is_connect_pending ())=0A=
+	debug_printf (("state (%d) out-of-sync: "=0A=
+		       "WSAEALREADY && !is_connect_pending ()"),=0A=
+		      had_connect_or_listen);=0A=
+      if (err =3D=3D WSAEINVAL && is_connect_pending ())=0A=
+	WSASetLastError (WSAEALREADY); /* Special case for WinSock 1. */=0A=
+=0A=
       /* Special handling for connect to return the correct error code=0A=
 	 when called on a non-blocking socket. */=0A=
       if (is_nonblocking ())=0A=
-	{=0A=
-	  DWORD err =3D WSAGetLastError ();=0A=
-	  if (err =3D=3D WSAEWOULDBLOCK || err =3D=3D WSAEALREADY)=0A=
-	    {=0A=
-	      WSASetLastError (WSAEINPROGRESS);=0A=
-	      in_progress =3D TRUE;=0A=
-	    }=0A=
-	  else if (err =3D=3D WSAEINVAL)=0A=
-	    WSASetLastError (WSAEISCONN);=0A=
-	}=0A=
-      set_winsock_errno ();=0A=
-    }=0A=
-  if (get_addr_family () =3D=3D AF_LOCAL && get_socket_type () =3D=3D SOCK=
_STREAM)=0A=
-    {=0A=
-      if (!res || in_progress)=0A=
-	{=0A=
-	  if (!create_secret_event (secret))=0A=
-	    {=0A=
-	      secret_check_failed =3D TRUE;=0A=
-	    }=0A=
-	  else if (in_progress)=0A=
-	    signal_secret_event ();=0A=
-	}=0A=
+	if (err =3D=3D WSAEWOULDBLOCK)=0A=
+	  {=0A=
+	    if (is_connect_pending ())=0A=
+	      debug_printf (("state (%d) out-of-sync: "=0A=
+			     "WSAEWOULDBLOCK && is_connect_pending ()"),=0A=
+			    had_connect_or_listen);=0A=
+	    WSASetLastError (WSAEINPROGRESS);=0A=
+	    set_connect_state (CONNECT_PENDING);=0A=
+	  }=0A=
+	else if (err =3D=3D WSAEISCONN)=0A=
+	  {=0A=
+	    /* Nb. The socket's state can be set to CONNECTED by=0A=
+	     * set_bits() in "select.cc".=0A=
+	     */=0A=
+	    if (!is_connect_pending () && !is_connected ())=0A=
+	      debug_printf (("state (%d) out-of-sync: "=0A=
+			     "WSAEISCONN && !is_connect_pending ()"),=0A=
+			    had_connect_or_listen);=0A=
+	    set_connect_state (CONNECTED);=0A=
+	  }=0A=
=20=0A=
-      if (!secret_check_failed && !res)=0A=
-	{=0A=
-	  if (!check_peer_secret_event (&sin, secret))=0A=
-	    {=0A=
-	      debug_printf ( "accept from unauthorized server" );=0A=
-	      secret_check_failed =3D TRUE;=0A=
-	    }=0A=
-       }=0A=
+      /* In case the connection attempt was never seen by the server,=0A=
+       * set the secret event here so that we don't block on close.=0A=
+       */=0A=
+      if (get_addr_family () =3D=3D AF_LOCAL && get_socket_type () =3D=3D =
SOCK_STREAM)=0A=
+	if (is_unconnected ())=0A=
+	  if (!ReleaseSemaphore (secret_event, 1, NULL))=0A=
+	    syscall_printf ("AF_LOCAL: failed to signal secret event, %E");=0A=
=20=0A=
-      if (secret_check_failed)=0A=
-	{=0A=
-	  close_secret_event ();=0A=
-	  if (res)=0A=
-	    closesocket (res);=0A=
-	  set_errno (ECONNREFUSED);=0A=
-	  res =3D -1;=0A=
-	}=0A=
+      set_winsock_errno ();=0A=
     }=0A=
-=0A=
-  if (WSAGetLastError () =3D=3D WSAEINPROGRESS)=0A=
-    set_connect_state (CONNECT_PENDING);=0A=
   else=0A=
     set_connect_state (CONNECTED);=0A=
   return res;=0A=
@@ -483,8 +809,6 @@=0A=
 {=0A=
   int res =3D -1;=0A=
   WSAEVENT ev[2] =3D { WSA_INVALID_EVENT, signal_arrived };=0A=
-  BOOL secret_check_failed =3D FALSE;=0A=
-  BOOL in_progress =3D FALSE;=0A=
=20=0A=
   sigframe thisframe (mainthread);=0A=
=20=0A=
@@ -514,7 +838,7 @@=0A=
           !WSAEventSelect (get_socket (), ev[0], FD_ACCEPT))=0A=
         {=0A=
           WSANETWORKEVENTS sock_event;=0A=
-          int wait_result;=0A=
+          DWORD wait_result;=0A=
=20=0A=
           wait_result =3D WSAWaitForMultipleEvents (2, ev, FALSE, WSA_INFI=
NITE,=0A=
 	  					  FALSE);=0A=
@@ -559,54 +883,41 @@=0A=
=20=0A=
   res =3D ::accept (get_socket (), peer, len);=0A=
=20=0A=
-  if ((SOCKET) res =3D=3D (SOCKET) INVALID_SOCKET &&=0A=
-      WSAGetLastError () =3D=3D WSAEWOULDBLOCK)=0A=
-    in_progress =3D TRUE;=0A=
-=0A=
-  if (get_addr_family () =3D=3D AF_LOCAL && get_socket_type () =3D=3D SOCK=
_STREAM)=0A=
+  if ((SOCKET) res =3D=3D INVALID_SOCKET)=0A=
     {=0A=
-      if ((SOCKET) res !=3D (SOCKET) INVALID_SOCKET || in_progress)=0A=
-	{=0A=
-	  if (!create_secret_event ())=0A=
-	    secret_check_failed =3D TRUE;=0A=
-	  else if (in_progress)=20=0A=
-	    signal_secret_event ();=0A=
-	}=0A=
+      set_winsock_errno ();=0A=
+      goto done;=0A=
+    }=0A=
=20=0A=
-      if (!secret_check_failed &&=0A=
-	  (SOCKET) res !=3D (SOCKET) INVALID_SOCKET)=0A=
-	{=0A=
-	  if (!check_peer_secret_event ((struct sockaddr_in*) peer))=0A=
-	    {=0A=
-	      debug_printf ("connect from unauthorized client");=0A=
-	      secret_check_failed =3D TRUE;=0A=
-	    }=0A=
-	}=0A=
+  if (get_addr_family () =3D=3D AF_LOCAL && get_socket_type () =3D=3D SOCK=
_STREAM)=0A=
+    if (!check_peer_secret_event ((struct sockaddr_in *) peer))=0A=
+      {=0A=
+	syscall_printf ("AF_LOCAL: "=0A=
+			"connection blocked from unauthorized socket");=0A=
=20=0A=
-      if (secret_check_failed)=0A=
-	{=0A=
-	  close_secret_event ();=0A=
-	  if ((SOCKET) res !=3D (SOCKET) INVALID_SOCKET)=0A=
-	    closesocket (res);=0A=
-	  set_errno (ECONNABORTED);=0A=
-	  res =3D -1;=0A=
-	  goto done;=0A=
-	}=0A=
-    }=0A=
+	const struct linger linger =3D { l_onoff: 1, l_linger: 0 };=0A=
+	setsockopt (get_socket (), SOL_SOCKET, SO_LINGER,=0A=
+		    (const char *) &linger, sizeof (linger));=0A=
+	closesocket (res);=0A=
+=0A=
+	set_errno (ECONNABORTED);=0A=
+	res =3D -1;=0A=
+	goto done;=0A=
+      }=0A=
=20=0A=
   {=0A=
     cygheap_fdnew res_fd;=0A=
-    if (res_fd < 0)=0A=
-      /* FIXME: what is correct errno? */;=0A=
-    else if ((SOCKET) res =3D=3D (SOCKET) INVALID_SOCKET)=0A=
-      set_winsock_errno ();=0A=
-    else=0A=
+    if (res_fd >=3D 0)=0A=
       {=0A=
         fhandler_socket* res_fh =3D fdsock (res_fd, get_name (), res);=0A=
-        if (get_addr_family () =3D=3D AF_LOCAL)=0A=
-          res_fh->set_sun_path (get_sun_path ());=0A=
         res_fh->set_addr_family (get_addr_family ());=0A=
         res_fh->set_socket_type (get_socket_type ());=0A=
+        if (get_addr_family () =3D=3D AF_LOCAL)=0A=
+	  {=0A=
+	    res_fh->set_sun_path (get_sun_path ());=0A=
+	    res_fh->set_peer_sun_path (get_peer_sun_path ());=0A=
+	  }=0A=
+	res_fh->had_connect_or_listen =3D had_connect_or_listen;=0A=
         res =3D res_fd;=0A=
       }=0A=
   }=0A=
@@ -618,6 +929,11 @@=0A=
   return res;=0A=
 }=0A=
=20=0A=
+/* getsockname () should only succeed if the socket has been=0A=
+ * explicitly or implicitly bound.  For the emulated UNIX domain=0A=
+ * sockets, this corresponds to the situation that getsockname () would=0A=
+ * succeed on the underlying socket.=0A=
+ */=0A=
 int=0A=
 fhandler_socket::getsockname (struct sockaddr *name, int *namelen)=0A=
 {=0A=
@@ -625,7 +941,11 @@=0A=
=20=0A=
   sigframe thisframe (mainthread);=0A=
=20=0A=
-  if (get_addr_family () =3D=3D AF_LOCAL)=0A=
+  res =3D ::getsockname (get_socket (), name, namelen);=0A=
+  if (res !=3D 0)=0A=
+    set_winsock_errno ();=0A=
+=0A=
+  if (res =3D=3D 0 && get_addr_family () =3D=3D AF_LOCAL)=0A=
     {=0A=
       struct sockaddr_un *sun =3D (struct sockaddr_un *) name;=0A=
       memset (sun, 0, *namelen);=0A=
@@ -643,13 +963,6 @@=0A=
=20=0A=
       *namelen =3D sizeof *sun - sizeof sun->sun_path=0A=
 		 + strlen (sun->sun_path) + 1;=0A=
-      res =3D 0;=0A=
-    }=0A=
-  else=0A=
-    {=0A=
-      res =3D ::getsockname (get_socket (), name, namelen);=0A=
-      if (res)=0A=
-	set_winsock_errno ();=0A=
     }=0A=
=20=0A=
   return res;=0A=
@@ -664,6 +977,26 @@=0A=
   if (res)=0A=
     set_winsock_errno ();=0A=
=20=0A=
+  if (res =3D=3D 0 && get_addr_family () =3D=3D AF_LOCAL)=0A=
+    {=0A=
+      struct sockaddr_un *const sun =3D (struct sockaddr_un *) name;=0A=
+      memset (sun, '\0', *namelen);=0A=
+      sun->sun_family =3D AF_LOCAL;=0A=
+=0A=
+      if (!get_peer_sun_path ())=0A=
+	sun->sun_path[0] =3D '\0';=0A=
+      else=0A=
+	/* According to SUSv2 "If the actual length of the address is=0A=
+	   greater than the length of the supplied sockaddr structure, the=0A=
+	   stored address will be truncated."  We play it save here so=0A=
+	   that the path always has a trailing 0 even if it's truncated. */=0A=
+	strncpy (sun->sun_path, get_peer_sun_path (),=0A=
+		 *namelen - sizeof *sun + sizeof sun->sun_path - 1);=0A=
+=0A=
+      *namelen =3D sizeof *sun - sizeof sun->sun_path=0A=
+		 + strlen (sun->sun_path) + 1;=0A=
+    }=0A=
+=0A=
   return res;=0A=
 }=0A=
=20=0A=
@@ -942,6 +1275,9 @@=0A=
=20=0A=
   sigframe thisframe (mainthread);=0A=
=20=0A=
+  if (!close_secret_event ())=0A=
+    return -1;			// EINTR=0A=
+=0A=
   /* HACK to allow a graceful shutdown even if shutdown() hasn't been=0A=
      called by the application. Note that this isn't the ultimate=0A=
      solution but it helps in many cases. */=0A=
@@ -968,8 +1304,6 @@=0A=
       WSASetLastError (0);=0A=
     }=0A=
=20=0A=
-  close_secret_event ();=0A=
-=0A=
   debug_printf ("%d =3D fhandler_socket::close()", res);=0A=
   return res;=0A=
 }=0A=
@@ -1152,5 +1486,21 @@=0A=
 void=0A=
 fhandler_socket::set_sun_path (const char *path)=0A=
 {=0A=
+  assert (get_addr_family () =3D=3D AF_LOCAL);=0A=
+=0A=
+  if (sun_path)=0A=
+    cfree (sun_path);=0A=
+=0A=
   sun_path =3D path ? cstrdup (path) : NULL;=0A=
+}=0A=
+=0A=
+void=0A=
+fhandler_socket::set_peer_sun_path (const char *const path)=0A=
+{=0A=
+  assert (get_addr_family () =3D=3D AF_LOCAL);=0A=
+=0A=
+  if (peer_sun_path)=0A=
+    cfree (peer_sun_path);=0A=
+=0A=
+  peer_sun_path =3D path ? cstrdup (path) : NULL;=0A=
 }=0A=
Index: net.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/net.cc,v=0A=
retrieving revision 1.118=0A=
diff -u -r1.118 net.cc=0A=
--- net.cc	6 Jul 2002 11:16:07 -0000	1.118=0A=
+++ net.cc	27 Jul 2002 19:02:38 -0000=0A=
@@ -519,6 +519,12 @@=0A=
 extern "C" int=0A=
 cygwin_socket (int af, int type, int protocol)=0A=
 {=0A=
+  if (af !=3D AF_INET && af !=3D AF_LOCAL)=0A=
+    {=0A=
+      set_errno (EAFNOSUPPORT);=0A=
+      return -1;=0A=
+    }=0A=
+=0A=
   int res =3D -1;=0A=
   SOCKET soc =3D 0;=0A=
   fhandler_socket* fh =3D NULL;=0A=

------=_NextPart_000_0077_01C23729.93043AF0--

