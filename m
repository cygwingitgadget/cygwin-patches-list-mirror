Return-Path: <cygwin-patches-return-2817-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7418 invoked by alias); 11 Aug 2002 13:23:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7403 invoked from network); 11 Aug 2002 13:23:03 -0000
Message-ID: <011c01c2413a$949693c0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
Subject: recvfrom / sendto patch
Date: Sun, 11 Aug 2002 06:23:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0119_01C24142.F5DD8E60"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00265.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0119_01C24142.F5DD8E60
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 1007

Again, moving slowly towards my readv/writev patch, here's a
little patch to simplify the fhandler_socket sendto / recvfrom
code.

SUSv3 says that recvfrom, recv, and read are all equivalent on
sockets if no flags or addresses etc. are provided (and ditto for
sendto, send, and write).  So, this patch makes that true, partly
by removing some methods and making others just delegate to each
other as appropriate.  In detail:

*) I missed a couple of buflen == 0 checks in "net.cc" from my
last patch.

*) I've removed fhandler_socket recv and send methods and made the
cygwin_recv/send functions delegate to the cygwin_recvfrom/sendto
functions, with relevant default extra arguments.

*) The fhandler_socket read and write methods also delegate now to
recvfrom and sendto (rather than to recv and send as previously).

*) In all of this I discovered that fhandler_socket::sendto
couldn't handle a NULL address: patched too.

Enjoy!

// Conrad

p.s. This saves 1.5K on the DLL size!  Happy happy, joy joy!


------=_NextPart_000_0119_01C24142.F5DD8E60
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 590

2002-08-11  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* fhandler.h (fhandler_socket::recv): Remove method.
	(fhandler_socket::send): Ditto.
	* fhandler_socket.cc (fhandler_socket::recv): Ditto.
	(fhandler_socket::send): Ditto.
	(fhandler_socket::read): Delegate to fhandler_socket::recvfrom.
	(fhandler_socket::write): Delegate to fhandler_socket::sendto.
	(fhandler_socket::sendto): Check for null `to' address.
	* net.cc (cygwin_sendto): Check for zero request length.
	(cygwin_recvfrom): Ditto.
	(cygwin_recv): Delegate to cygwin_recvfrom.
	(cygwin_send): Delegate to cygwin_sendto.


------=_NextPart_000_0119_01C24142.F5DD8E60
Content-Type: text/plain;
	name="recvsend.patch.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="recvsend.patch.txt"
Content-length: 7567

Index: fhandler.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.133
diff -u -p -r1.133 fhandler.h
--- fhandler.h	2 Aug 2002 02:10:24 -0000	1.133
+++ fhandler.h	11 Aug 2002 13:05:59 -0000
@@ -397,15 +397,12 @@ class fhandler_socket: public fhandler_b
   int getsockname (struct sockaddr *name, int *namelen);
   int getpeername (struct sockaddr *name, int *namelen);
=20
-  int recv (void *ptr, size_t len, unsigned int flags);
   int __stdcall read (void *ptr, size_t len) __attribute__ ((regparm (3)));
   int recvfrom (void *ptr, size_t len, unsigned int flags,
 		struct sockaddr *from, int *fromlen);
   int recvmsg (struct msghdr *msg, int flags);
=20
-  int send (const void *ptr, size_t len, unsigned int flags);
   int write (const void *ptr, size_t len);
-
   int sendto (const void *ptr, size_t len, unsigned int flags,
 	      const struct sockaddr *to, int tolen);
   int sendmsg (const struct msghdr *msg, int flags);
Index: fhandler_socket.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler_socket.cc,v
retrieving revision 1.57
diff -u -p -r1.57 fhandler_socket.cc
--- fhandler_socket.cc	8 Aug 2002 17:03:20 -0000	1.57
+++ fhandler_socket.cc	11 Aug 2002 13:06:00 -0000
@@ -668,47 +668,10 @@ fhandler_socket::getpeername (struct soc
   return res;
 }
=20
-int
-fhandler_socket::recv (void *ptr, size_t len, unsigned int flags)
-{
-  int res =3D -1;
-  wsock_event wsock_evt;
-  LPWSAOVERLAPPED ovr;
-
-  sigframe thisframe (mainthread);
-
-  if (is_nonblocking () || !(ovr =3D wsock_evt.prepare ()))
-    {
-      debug_printf ("Fallback to winsock 1 recv call");
-      if ((res =3D ::recv (get_socket (), (char *) ptr, len, flags))
-	  =3D=3D SOCKET_ERROR)
-	{
-	  set_winsock_errno ();
-	  res =3D -1;
-	}
-    }
-  else
-    {
-      WSABUF wsabuf =3D { len, (char *) ptr };
-      DWORD ret =3D 0;
-      if (WSARecv (get_socket (), &wsabuf, 1, &ret, (DWORD *)&flags,
-		   ovr, NULL) !=3D SOCKET_ERROR)
-	res =3D ret;
-      else if ((res =3D WSAGetLastError ()) !=3D WSA_IO_PENDING)
-	{
-	  set_winsock_errno ();
-	  res =3D -1;
-	}
-      else if ((res =3D wsock_evt.wait (get_socket (), (DWORD *)&flags)) =
=3D=3D -1)
-	set_winsock_errno ();
-    }
-  return res;
-}
-
 int __stdcall
 fhandler_socket::read (void *ptr, size_t len)
 {
-  return recv (ptr, len, 0);
+  return recvfrom (ptr, len, 0, NULL, NULL);
 }
=20
 int
@@ -794,46 +757,9 @@ fhandler_socket::recvmsg (struct msghdr=20
 }
=20
 int
-fhandler_socket::send (const void *ptr, size_t len, unsigned int flags)
-{
-  int res =3D -1;
-  wsock_event wsock_evt;
-  LPWSAOVERLAPPED ovr;
-
-  sigframe thisframe (mainthread);
-
-  if (is_nonblocking () || !(ovr =3D wsock_evt.prepare ()))
-    {
-      debug_printf ("Fallback to winsock 1 send call");
-      if ((res =3D ::send (get_socket (), (const char *) ptr, len, flags))
-	  =3D=3D SOCKET_ERROR)
-	{
-	  set_winsock_errno ();
-	  res =3D -1;
-	}
-    }
-  else
-    {
-      WSABUF wsabuf =3D { len, (char *) ptr };
-      DWORD ret =3D 0;
-      if (WSASend (get_socket (), &wsabuf, 1, &ret, (DWORD)flags,
-		   ovr, NULL) !=3D SOCKET_ERROR)
-	res =3D ret;
-      else if ((res =3D WSAGetLastError ()) !=3D WSA_IO_PENDING)
-	{
-	  set_winsock_errno ();
-	  res =3D -1;
-	}
-      else if ((res =3D wsock_evt.wait (get_socket (), (DWORD *)&flags)) =
=3D=3D -1)
-	set_winsock_errno ();
-    }
-  return res;
-}
-
-int
 fhandler_socket::write (const void *ptr, size_t len)
 {
-  return send (ptr, len, 0);
+  return sendto (ptr, len, 0, NULL, 0);
 }
=20
 int
@@ -847,14 +773,15 @@ fhandler_socket::sendto (const void *ptr
=20
   sigframe thisframe (mainthread);
=20
-  if (!get_inet_addr (to, tolen, &sin, &tolen))
+  if (to && !get_inet_addr (to, tolen, &sin, &tolen))
     return -1;
=20
   if (is_nonblocking () || !(ovr =3D wsock_evt.prepare ()))
     {
       debug_printf ("Fallback to winsock 1 sendto call");
       if ((res =3D ::sendto (get_socket (), (const char *) ptr, len, flags,
-			   (sockaddr *) &sin, tolen)) =3D=3D SOCKET_ERROR)
+			   (to ? (sockaddr *) &sin : NULL),
+			   tolen)) =3D=3D SOCKET_ERROR)
 	{
 	  set_winsock_errno ();
 	  res =3D -1;
@@ -865,7 +792,9 @@ fhandler_socket::sendto (const void *ptr
       WSABUF wsabuf =3D { len, (char *) ptr };
       DWORD ret =3D 0;
       if (WSASendTo (get_socket (), &wsabuf, 1, &ret, (DWORD)flags,
-		     (sockaddr *) &sin, tolen, ovr, NULL) !=3D SOCKET_ERROR)
+		     (to ? (sockaddr *) &sin : NULL),
+		     tolen,
+		     ovr, NULL) !=3D SOCKET_ERROR)
 	res =3D ret;
       else if ((res =3D WSAGetLastError ()) !=3D WSA_IO_PENDING)
 	{
Index: net.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/net.cc,v
retrieving revision 1.120
diff -u -p -r1.120 net.cc
--- net.cc	8 Aug 2002 17:03:20 -0000	1.120
+++ net.cc	11 Aug 2002 13:06:01 -0000
@@ -574,7 +574,7 @@ cygwin_sendto (int fd, const void *buf,=20
       || (to &&__check_invalid_read_ptr_errno (to, tolen))
       || !fh)
     res =3D -1;
-  else
+  else if ((res =3D len) !=3D 0)
     res =3D fh->sendto (buf, len, flags, to, tolen);
=20
   syscall_printf ("%d =3D sendto (%d, %x, %x, %x)", res, fd, buf, len, fla=
gs);
@@ -584,19 +584,19 @@ cygwin_sendto (int fd, const void *buf,=20
=20
 /* exported as recvfrom: standards? */
 extern "C" int
-cygwin_recvfrom (int fd, char *buf, int len, int flags, struct sockaddr *f=
rom,
+cygwin_recvfrom (int fd, void *buf, int len, int flags, struct sockaddr *f=
rom,
 		 int *fromlen)
 {
   int res;
   fhandler_socket *fh =3D get (fd);
=20
-  if (__check_null_invalid_struct_errno (buf, (unsigned) len)
+  if ((len && __check_null_invalid_struct_errno (buf, (unsigned) len))
       || (from
 	  && (check_null_invalid_struct_errno (fromlen)
 	      ||__check_null_invalid_struct_errno (from, (unsigned) *fromlen)))
       || !fh)
     res =3D -1;
-  else
+  else if ((res =3D len) !=3D 0)
     res =3D fh->recvfrom (buf, len, flags, from, fromlen);
=20
   syscall_printf ("%d =3D recvfrom (%d, %x, %x, %x)", res, fd, buf, len, f=
lags);
@@ -1148,32 +1148,14 @@ cygwin_getpeername (int fd, struct socka
 extern "C" int
 cygwin_recv (int fd, void *buf, int len, unsigned int flags)
 {
-  int res;
-  fhandler_socket *fh =3D get (fd);
-
-  if (__check_null_invalid_struct_errno (buf, len) || !fh)
-    res =3D -1;
-  else
-    res =3D fh->recv (buf, len, flags);
-
-  syscall_printf ("%d =3D recv (%d, %x, %x, %x)", res, fd, buf, len, flags=
);
-  return res;
+  return cygwin_recvfrom (fd, buf, len, flags, NULL, NULL);
 }
=20
 /* exported as send: standards? */
 extern "C" int
 cygwin_send (int fd, const void *buf, int len, unsigned int flags)
 {
-  int res;
-  fhandler_socket *fh =3D get (fd);
-
-  if ((len &&__check_invalid_read_ptr_errno (buf, len)) || !fh)
-    res =3D -1;
-  else
-    res =3D fh->send (buf, len, flags);
-
-  syscall_printf ("%d =3D send (%d, %x, %d, %x)", res, fd, buf, len, flags=
);
-  return res;
+  return cygwin_sendto (fd, buf, len, flags, NULL, 0);
 }
=20
 /* getdomainname: standards? */

------=_NextPart_000_0119_01C24142.F5DD8E60--

