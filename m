Return-Path: <cygwin-patches-return-2850-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18349 invoked by alias); 21 Aug 2002 19:24:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18326 invoked from network); 21 Aug 2002 19:24:53 -0000
Message-ID: <017501c24948$aa02fa30$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
Subject: recv/send revert patch
Date: Wed, 21 Aug 2002 12:24:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0172_01C24951.0B5C6B60"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00298.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0172_01C24951.0B5C6B60
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 224

Attached is a patch to revert the recv/send patch I submitted a
couple of weeks ago.  This doesn't revert the whole patch, just
those parts related to using recvfrom/sendto calls to implement
recv/send.

Cheers,

// Conrad


------=_NextPart_000_0172_01C24951.0B5C6B60
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 346

2002-08-21  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* fhandler.h (fhandler_socket::recv): Revert.
	(fhandler_socket::send): Ditto.
	* fhandler_socket.cc (fhandler_socket::read): Ditto.
	(fhandler_socket::recv): Ditto.
	(fhandler_socket::write): Ditto.
	(fhandler_socket::send): Ditto.
	* net.cc (cygwin_recv): Ditto.
	(cygwin_send): Ditto.


------=_NextPart_000_0172_01C24951.0B5C6B60
Content-Type: text/plain;
	name="revert.patch.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="revert.patch.txt"
Content-length: 5329

Index: fhandler.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.135
diff -u -p -r1.135 fhandler.h
--- fhandler.h	19 Aug 2002 04:43:58 -0000	1.135
+++ fhandler.h	21 Aug 2002 19:13:51 -0000
@@ -398,11 +398,13 @@ class fhandler_socket: public fhandler_b
   int getpeername (struct sockaddr *name, int *namelen);
=20
   int __stdcall read (void *ptr, size_t len) __attribute__ ((regparm (3)));
+  int recv (void *ptr, size_t len, unsigned int flags);
   int recvfrom (void *ptr, size_t len, unsigned int flags,
 		struct sockaddr *from, int *fromlen);
   int recvmsg (struct msghdr *msg, int flags);
=20
   int write (const void *ptr, size_t len);
+  int send (const void *ptr, size_t len, unsigned int flags);
   int sendto (const void *ptr, size_t len, unsigned int flags,
 	      const struct sockaddr *to, int tolen);
   int sendmsg (const struct msghdr *msg, int flags);
Index: fhandler_socket.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler_socket.cc,v
retrieving revision 1.58
diff -u -p -r1.58 fhandler_socket.cc
--- fhandler_socket.cc	12 Aug 2002 13:54:12 -0000	1.58
+++ fhandler_socket.cc	21 Aug 2002 19:13:51 -0000
@@ -671,7 +671,44 @@ fhandler_socket::getpeername (struct soc
 int __stdcall
 fhandler_socket::read (void *ptr, size_t len)
 {
-  return recvfrom (ptr, len, 0, NULL, NULL);
+  return recv (ptr, len, 0);
+}
+
+int
+fhandler_socket::recv (void *ptr, size_t len, unsigned int flags)
+{
+  int res =3D -1;
+  wsock_event wsock_evt;
+  LPWSAOVERLAPPED ovr;
+
+  sigframe thisframe (mainthread);
+
+  if (is_nonblocking () || !(ovr =3D wsock_evt.prepare ()))
+    {
+      debug_printf ("Fallback to winsock 1 recv call");
+      if ((res =3D ::recv (get_socket (), (char *) ptr, len, flags))
+	  =3D=3D SOCKET_ERROR)
+	{
+	  set_winsock_errno ();
+	  res =3D -1;
+	}
+    }
+  else
+    {
+      WSABUF wsabuf =3D { len, (char *) ptr };
+      DWORD ret =3D 0;
+      if (WSARecv (get_socket (), &wsabuf, 1, &ret, (DWORD *)&flags,
+		   ovr, NULL) !=3D SOCKET_ERROR)
+	res =3D ret;
+      else if ((res =3D WSAGetLastError ()) !=3D WSA_IO_PENDING)
+	{
+	  set_winsock_errno ();
+	  res =3D -1;
+	}
+      else if ((res =3D wsock_evt.wait (get_socket (), (DWORD *)&flags)) =
=3D=3D -1)
+	set_winsock_errno ();
+    }
+  return res;
 }
=20
 int
@@ -759,7 +796,44 @@ fhandler_socket::recvmsg (struct msghdr=20
 int
 fhandler_socket::write (const void *ptr, size_t len)
 {
-  return sendto (ptr, len, 0, NULL, 0);
+  return send (ptr, len, 0);
+}
+
+ int
+fhandler_socket::send (const void *ptr, size_t len, unsigned int flags)
+{
+  int res =3D -1;
+  wsock_event wsock_evt;
+  LPWSAOVERLAPPED ovr;
+
+  sigframe thisframe (mainthread);
+
+  if (is_nonblocking () || !(ovr =3D wsock_evt.prepare ()))
+    {
+      debug_printf ("Fallback to winsock 1 send call");
+      if ((res =3D ::send (get_socket (), (const char *) ptr, len, flags))
+	  =3D=3D SOCKET_ERROR)
+	{
+	  set_winsock_errno ();
+	  res =3D -1;
+	}
+    }
+  else
+    {
+      WSABUF wsabuf =3D { len, (char *) ptr };
+      DWORD ret =3D 0;
+      if (WSASend (get_socket (), &wsabuf, 1, &ret, (DWORD)flags,
+		   ovr, NULL) !=3D SOCKET_ERROR)
+	res =3D ret;
+      else if ((res =3D WSAGetLastError ()) !=3D WSA_IO_PENDING)
+	{
+	  set_winsock_errno ();
+	  res =3D -1;
+	}
+      else if ((res =3D wsock_evt.wait (get_socket (), (DWORD *)&flags)) =
=3D=3D -1)
+	set_winsock_errno ();
+    }
+  return res;
 }
=20
 int
Index: net.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/net.cc,v
retrieving revision 1.121
diff -u -p -r1.121 net.cc
--- net.cc	12 Aug 2002 13:54:12 -0000	1.121
+++ net.cc	21 Aug 2002 19:13:52 -0000
@@ -1148,14 +1148,36 @@ cygwin_getpeername (int fd, struct socka
 extern "C" int
 cygwin_recv (int fd, void *buf, int len, unsigned int flags)
 {
-  return cygwin_recvfrom (fd, buf, len, flags, NULL, NULL);
+  int res;
+  fhandler_socket *fh =3D get (fd);
+
+  if ((len && __check_null_invalid_struct_errno (buf, (unsigned) len))
+      || !fh)
+    res =3D -1;
+  else if ((res =3D len) !=3D 0)
+    res =3D fh->recv (buf, len, flags);
+
+  syscall_printf ("%d =3D recv (%d, %x, %x, %x)", res, fd, buf, len, flags=
);
+
+  return res;
 }
=20
 /* exported as send: standards? */
 extern "C" int
 cygwin_send (int fd, const void *buf, int len, unsigned int flags)
 {
-  return cygwin_sendto (fd, buf, len, flags, NULL, 0);
+  int res;
+  fhandler_socket *fh =3D get (fd);
+
+  if ((len && __check_invalid_read_ptr_errno (buf, (unsigned) len))
+      || !fh)
+    res =3D -1;
+  else if ((res =3D len) !=3D 0)
+    res =3D fh->send (buf, len, flags);
+
+  syscall_printf ("%d =3D send (%d, %x, %x, %x)", res, fd, buf, len, flags=
);
+
+  return res;
 }
=20
 /* getdomainname: standards? */

------=_NextPart_000_0172_01C24951.0B5C6B60--

