Return-Path: <cygwin-patches-return-2862-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13003 invoked by alias); 25 Aug 2002 22:45:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12989 invoked from network); 25 Aug 2002 22:45:35 -0000
Message-ID: <010a01c24c89$82b70c20$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
Subject: SUSv3 compliant prototypes for socket calls
Date: Sun, 25 Aug 2002 15:45:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0107_01C24C91.E4214630"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00310.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0107_01C24C91.E4214630
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 243

I'm trying to unwind some of the changes that have built up in my
sandbox: here's a patch to fix the prototypes for recv/recvfrom
and send/sendto to match SUSv3; and some minor changes to strace
output too while I'm at it.

Enjoy,

// Conrad


------=_NextPart_000_0107_01C24C91.E4214630
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 768

2002-08-25  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* fhandler.h (fhandler_socket::recvfrom): Fix prototype.
	(fhandler_socket::sendto): Ditto.
	* fhandler_socket.cc (fhandler_socket::recvfrom): Ditto.
	(fhandler_socket::sendto): Ditto.
	* include/sys/socket.h (recv): Fix prototype.
	(recvfrom): Ditto.
	(send): Ditto.
	(sendto): Ditto.
	* net.cc (cygwin_sendto): Ditto. Improve strace message
	(cygwin_recvfrom): Ditto.  Ditto.
	(cygwin_setsockopt): Improve strace message.
	(cygwin_getsockopt): Ditto.
	(cygwin_connect): Ditto.
	(cygwin_accept): Ditto.
	(cygwin_bind): Ditto.
	(cygwin_getsockname): Ditto.
	(cygwin_getpeername): Ditto.
	(cygwin_recv): Fix prototype.
	(cygwin_send): Ditto.
	(cygwin_recvmsg): Improve strace message.
	(cygwin_sendmsg): Ditto.


------=_NextPart_000_0107_01C24C91.E4214630
Content-Type: text/plain;
	name="flags.patch.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="flags.patch.txt"
Content-length: 8307

Index: fhandler.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.135
diff -u -p -r1.135 fhandler.h
--- fhandler.h	19 Aug 2002 04:43:58 -0000	1.135
+++ fhandler.h	25 Aug 2002 22:33:58 -0000
@@ -398,12 +398,12 @@ class fhandler_socket: public fhandler_b
   int getpeername (struct sockaddr *name, int *namelen);
=20
   int __stdcall read (void *ptr, size_t len) __attribute__ ((regparm (3)));
-  int recvfrom (void *ptr, size_t len, unsigned int flags,
+  int recvfrom (void *ptr, size_t len, int flags,
 		struct sockaddr *from, int *fromlen);
   int recvmsg (struct msghdr *msg, int flags);
=20
   int write (const void *ptr, size_t len);
-  int sendto (const void *ptr, size_t len, unsigned int flags,
+  int sendto (const void *ptr, size_t len, int flags,
 	      const struct sockaddr *to, int tolen);
   int sendmsg (const struct msghdr *msg, int flags);
=20
Index: fhandler_socket.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler_socket.cc,v
retrieving revision 1.58
diff -u -p -r1.58 fhandler_socket.cc
--- fhandler_socket.cc	12 Aug 2002 13:54:12 -0000	1.58
+++ fhandler_socket.cc	25 Aug 2002 22:33:58 -0000
@@ -675,7 +675,7 @@ fhandler_socket::read (void *ptr, size_t
 }
=20
 int
-fhandler_socket::recvfrom (void *ptr, size_t len, unsigned int flags,
+fhandler_socket::recvfrom (void *ptr, size_t len, int flags,
 			   struct sockaddr *from, int *fromlen)
 {
   int res =3D -1;
@@ -763,7 +763,7 @@ fhandler_socket::write (const void *ptr,
 }
=20
 int
-fhandler_socket::sendto (const void *ptr, size_t len, unsigned int flags,
+fhandler_socket::sendto (const void *ptr, size_t len, int flags,
 			 const struct sockaddr *to, int tolen)
 {
   int res =3D -1;
Index: net.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/net.cc,v
retrieving revision 1.121
diff -u -p -r1.121 net.cc
--- net.cc	12 Aug 2002 13:54:12 -0000	1.121
+++ net.cc	25 Aug 2002 22:33:59 -0000
@@ -564,7 +564,7 @@ done:
=20
 /* exported as sendto: standards? */
 extern "C" int
-cygwin_sendto (int fd, const void *buf, int len, unsigned int flags,
+cygwin_sendto (int fd, const void *buf, int len, int flags,
 	       const struct sockaddr *to, int tolen)
 {
   int res;
@@ -577,15 +577,16 @@ cygwin_sendto (int fd, const void *buf,=20
   else if ((res =3D len) !=3D 0)
     res =3D fh->sendto (buf, len, flags, to, tolen);
=20
-  syscall_printf ("%d =3D sendto (%d, %x, %x, %x)", res, fd, buf, len, fla=
gs);
+  syscall_printf ("%d =3D sendto (%d, %p, %d, %x, %p, %d)",
+		  res, fd, buf, len, flags, to, tolen);
=20
   return res;
 }
=20
 /* exported as recvfrom: standards? */
 extern "C" int
-cygwin_recvfrom (int fd, void *buf, int len, int flags, struct sockaddr *f=
rom,
-		 int *fromlen)
+cygwin_recvfrom (int fd, void *buf, int len, int flags,
+		 struct sockaddr *from, int *fromlen)
 {
   int res;
   fhandler_socket *fh =3D get (fd);
@@ -599,7 +600,8 @@ cygwin_recvfrom (int fd, void *buf, int=20
   else if ((res =3D len) !=3D 0)
     res =3D fh->recvfrom (buf, len, flags, from, fromlen);
=20
-  syscall_printf ("%d =3D recvfrom (%d, %x, %x, %x)", res, fd, buf, len, f=
lags);
+  syscall_printf ("%d =3D recvfrom (%d, %p, %d, %x, %p, %p)",
+		  res, fd, buf, len, flags, from, fromlen);
=20
   return res;
 }
@@ -662,7 +664,7 @@ cygwin_setsockopt (int fd, int level, in
 	set_winsock_errno ();
     }
=20
-  syscall_printf ("%d =3D setsockopt (%d, %d, %x (%s), %x, %d)",
+  syscall_printf ("%d =3D setsockopt (%d, %d, %x (%s), %p, %d)",
 		  res, fd, level, optname, name, optval, optlen);
   return res;
 }
@@ -730,7 +732,7 @@ cygwin_getsockopt (int fd, int level, in
 	set_winsock_errno ();
     }
=20
-  syscall_printf ("%d =3D getsockopt (%d, %d, %x (%s), %x, %d)",
+  syscall_printf ("%d =3D getsockopt (%d, %d, %x (%s), %p, %p)",
 		  res, fd, level, optname, name, optval, optlen);
   return res;
 }
@@ -747,7 +749,7 @@ cygwin_connect (int fd, const struct soc
   else
     res =3D fh->connect (name, namelen);
=20
-  syscall_printf ("%d =3D connect (%d, %x, %x)", res, fd, name, namelen);
+  syscall_printf ("%d =3D connect (%d, %p, %d)", res, fd, name, namelen);
=20
   return res;
 }
@@ -1009,7 +1011,7 @@ cygwin_accept (int fd, struct sockaddr *
   else
     res =3D fh->accept (peer, len);
=20
-  syscall_printf ("%d =3D accept (%d, %x, %x)", res, fd, peer, len);
+  syscall_printf ("%d =3D accept (%d, %p, %d)", res, fd, peer, len);
   return res;
 }
=20
@@ -1025,7 +1027,7 @@ cygwin_bind (int fd, const struct sockad
   else
     res =3D fh->bind (my_addr, addrlen);
=20
-  syscall_printf ("%d =3D bind (%d, %x, %d)", res, fd, my_addr, addrlen);
+  syscall_printf ("%d =3D bind (%d, %p, %d)", res, fd, my_addr, addrlen);
   return res;
 }
=20
@@ -1043,7 +1045,7 @@ cygwin_getsockname (int fd, struct socka
   else
     res =3D fh->getsockname (addr, namelen);
=20
-  syscall_printf ("%d =3D getsockname (%d, %x, %d)", res, fd, addr, namele=
n);
+  syscall_printf ("%d =3D getsockname (%d, %p, %d)", res, fd, addr, namele=
n);
   return res;
 }
=20
@@ -1146,14 +1148,14 @@ cygwin_getpeername (int fd, struct socka
=20
 /* exported as recv: standards? */
 extern "C" int
-cygwin_recv (int fd, void *buf, int len, unsigned int flags)
+cygwin_recv (int fd, void *buf, int len, int flags)
 {
   return cygwin_recvfrom (fd, buf, len, flags, NULL, NULL);
 }
=20
 /* exported as send: standards? */
 extern "C" int
-cygwin_send (int fd, const void *buf, int len, unsigned int flags)
+cygwin_send (int fd, const void *buf, int len, int flags)
 {
   return cygwin_sendto (fd, buf, len, flags, NULL, 0);
 }
@@ -2096,7 +2098,7 @@ cygwin_recvmsg (int fd, struct msghdr *m
   else
     res =3D fh->recvmsg (msg, flags);
=20
-  syscall_printf ("%d =3D recvmsg (%d, %x, %x)", res, fd, msg, flags);
+  syscall_printf ("%d =3D recvmsg (%d, %p, %d)", res, fd, msg, flags);
   return res;
 }
=20
@@ -2116,6 +2118,6 @@ cygwin_sendmsg (int fd, const struct msg
   else
     res =3D fh->sendmsg (msg, flags);
=20
-  syscall_printf ("%d =3D recvmsg (%d, %x, %x)", res, fd, msg, flags);
+  syscall_printf ("%d =3D recvmsg (%d, %p, %d)", res, fd, msg, flags);
   return res;
 }
Index: include/sys/socket.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/include/sys/socket.h,v
retrieving revision 1.6
diff -u -p -r1.6 socket.h
--- include/sys/socket.h	19 Jan 2002 16:11:00 -0000	1.6
+++ include/sys/socket.h	25 Aug 2002 22:33:59 -0000
@@ -32,13 +32,14 @@ extern "C"
   int getpeername (int, struct sockaddr *__peer, int *);
   int getsockname (int, struct sockaddr *__addr, int *);
   int listen (int, int __n);
-  int recv (int, void *__buff, int __len, unsigned int __flags);
-  int recvfrom (int, char *__buff, int __len, int __flags,
-			 struct sockaddr *__from, int *__fromlen);
+  int recv (int, void *__buff, int __len, int __flags);
+  int recvfrom (int, void *__buff, int __len, int __flags,
+		struct sockaddr *__from, int *__fromlen);
   int recvmsg(int s, struct msghdr *msg, int flags);
-  int send (int, const void *__buff, int __len, unsigned int __flags);
+  int send (int, const void *__buff, int __len, int __flags);
   int sendmsg(int s, const struct msghdr *msg, int flags);
-  int sendto (int, const void *, int, unsigned int, const struct sockaddr =
*, int);
+  int sendto (int, const void *, int __len, int __flags,
+	      const struct sockaddr *__to, int __tolen);
   int setsockopt (int __s, int __level, int __optname, const void *optval,=
 int __optlen);
   int getsockopt (int __s, int __level, int __optname, void *__optval, int=
 *__optlen);
   int shutdown (int, int);

------=_NextPart_000_0107_01C24C91.E4214630--

