Return-Path: <cygwin-patches-return-2872-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28934 invoked by alias); 27 Aug 2002 14:59:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28876 invoked from network); 27 Aug 2002 14:59:57 -0000
Message-ID: <01aa01c24dda$cc5384b0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
Subject: Readv/writev patch
Date: Tue, 27 Aug 2002 07:59:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_01A7_01C24DE3.2DBDBEC0"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00320.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_01A7_01C24DE3.2DBDBEC0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 1870

One last patch and the sandbox is empty (but a big one this time):

This patch adds readv and writev methods to the base fhandler
class and pushes all read and write calls through these.  I've
also added overridden versions of these methods to the socket
fhandler since it can implement them more efficiently.  (The same
is true of some other fhandler classes too but I haven't had the
energy to do any of the others.)  As part of this, I rewrote the
socket fhandler's recvmsg and sendmsg calls to use the winsock2
iovec-like i/face (i.e. WSABUF) where possible to avoid further
copying of the buffers.  I also re-arranged the other
fhandler_socket read/write-like methods to use the winsock2 calls
even in the nonblocking case: this is for the usual consistency
and beauty reasons apart from anything else.

There are two new functions to check incoming iovec arrays, called
check_iovec_for_read() and check_iovec_for_write().  I've put
these in miscfuncs.cc and declared them in winsup.h to match the
other check_XYZZY functions.

The readv(2) and writev(2) entry points are based on the old
read(2) and write(2) entry points but slightly modified to make
sure that the strace at the foot of the function is always reached
in all cases.  I also re-arranged the read/write access mode
checking to avoid relying on win32's impression of what might be
going on.

Finally, I updated the definition of the iovec struct to match the
SUSv3 definition.

I've tried to reduce the size of the patch by sending in some
unrelated parts over the last couple of days but I realize that
this is still quite large.  If you'ld like me to split the patch
up (e.g. into the base fhandler part and the socket part), give me
a call and I'll see if I can find the energy to do so; London's
now all cold and gray and it's not conducive to too much fun and
games.

Anyhow, enjoy!

// Conrad


------=_NextPart_000_01A7_01C24DE3.2DBDBEC0
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 1502

2002-08-27  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* fhandler.h (fhandler_base::readv): New method.
	(fhandler_base::writev): Ditto.
	(fhandler_socket::read): Remove method.
	(fhandler_socket::write): Ditto.
	(fhandler_socket::readv): New method.
	(fhandler_socket::writev): Ditto.
	(fhandler_socket::recvmsg): Add new argument.
	(fhandler_socket::sendmsg): Ditto.
	* fhandler.cc (fhandler_base::readv): New method.
	(fhandler_base::writev): Ditto.
	* fhandler_socket.cc (fhandler_socket::read): Remove method.
	(fhandler_socket::write): Remove method.
	(fhandler_socket::readv): New method.
	(fhandler_socket::writev): New method.
	(fhandler_socket::recvfrom): Use winsock2 calls if possible.
	(fhandler_socket::sendto): Ditto.
	(fhandler_socket::recvmsg): Rewrite to use winsock2 calls and
	avoid copying the iovec buffers if possible.
	(fhandler_socket::sendmsg): Ditto.
	* syscalls.cc (_read): Delegate to readv(2).
	 (_write): Delegate to writev(2).
	(readv): Rewrite, based on the old _read code, to use the new
	fhandler_base::readv method.
	(writev): Ditto, mutatis mutandi.
	* net.cc (cygwin_recvmsg): Error check the incoming iovec and
	match new fhandler_socket::recvmsg signature.
	(cygwin_sendmsg): Ditto, mutatis mutandi.  Add missing sigframe.
	* include/sys/uio.h (struct iovec): Change field types to match
	SUSv3.
	* winsup.h (check_iovec_for_read): New function.
	(check_iovec_for_write): Ditto.
	* miscfuncs.cc (check_iovec_for_read): Ditto.
	(check_iovec_for_write): Ditto.


------=_NextPart_000_01A7_01C24DE3.2DBDBEC0
Content-Type: text/plain;
	name="iovec.patch.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="iovec.patch.txt"
Content-length: 29810

Index: fhandler.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
retrieving revision 1.133
diff -u -p -r1.133 fhandler.cc
--- fhandler.cc	14 Jul 2002 19:15:32 -0000	1.133
+++ fhandler.cc	27 Aug 2002 14:42:38 -0000
@@ -13,6 +13,7 @@ details. */
 #include <unistd.h>
 #include <stdlib.h>
 #include <sys/cygwin.h>
+#include <sys/uio.h>
 #include <signal.h>
 #include "cygerrno.h"
 #include "perprocess.h"
@@ -695,6 +696,111 @@ fhandler_base::write (const void *ptr, s
=20
   debug_printf ("%d =3D write (%p, %d)", res, ptr, len);
   return res;
+}
+
+ssize_t
+fhandler_base::readv (const struct iovec *const iov, const int iovcnt,
+		      ssize_t tot)
+{
+  assert (iov);
+  assert (iovcnt >=3D 1);
+
+  if (iovcnt =3D=3D 1)
+    return read (iov->iov_base, iov->iov_len);
+
+  if (tot =3D=3D -1)		// i.e. if not pre-calculated by the caller.
+    {
+      tot =3D 0;
+      const struct iovec *iovptr =3D iov + iovcnt;
+      do=20
+	{
+	  iovptr -=3D 1;
+	  tot +=3D iovptr->iov_len;
+	}
+      while (iovptr !=3D iov);
+    }
+
+  assert (tot >=3D 0);
+
+  if (tot =3D=3D 0)
+    return 0;
+
+  char *buf =3D static_cast<char *> (alloca (tot));
+
+  if (!buf)
+    {
+      set_errno (ENOMEM);
+      return -1;
+    }
+
+  const ssize_t res =3D read (buf, tot);
+
+  const struct iovec *iovptr =3D iov;
+  int nbytes =3D res;
+
+  while (nbytes > 0)
+    {
+      const int frag =3D min (nbytes,
+			    static_cast<ssize_t> (iovptr->iov_len));
+      memcpy (iovptr->iov_base, buf, frag);
+      buf +=3D frag;
+      iovptr +=3D 1;
+      nbytes -=3D frag;
+    }
+
+  return res;
+}
+
+ssize_t
+fhandler_base::writev (const struct iovec *const iov, const int iovcnt,
+		       ssize_t tot)
+{
+  assert (iov);
+  assert (iovcnt >=3D 1);
+
+  if (iovcnt =3D=3D 1)
+    return write (iov->iov_base, iov->iov_len);
+
+  if (tot =3D=3D -1)		// i.e. if not pre-calculated by the caller.
+    {
+      tot =3D 0;
+      const struct iovec *iovptr =3D iov + iovcnt;
+      do=20
+	{
+	  iovptr -=3D 1;
+	  tot +=3D iovptr->iov_len;
+	}
+      while (iovptr !=3D iov);
+    }
+
+  assert (tot >=3D 0);
+
+  if (tot =3D=3D 0)
+    return 0;
+
+  char *const buf =3D static_cast<char *> (alloca (tot));
+
+  if (!buf)
+    {
+      set_errno (ENOMEM);
+      return -1;
+    }
+
+  char *bufptr =3D buf;
+  const struct iovec *iovptr =3D iov;
+  int nbytes =3D tot;
+
+  while (nbytes !=3D 0)
+    {
+      const int frag =3D min (nbytes,
+			    static_cast<ssize_t> (iovptr->iov_len));
+      memcpy (bufptr, iovptr->iov_base, frag);
+      bufptr +=3D frag;
+      iovptr +=3D 1;
+      nbytes -=3D frag;
+    }
+
+  return write (buf, tot);
 }
=20
 __off64_t
Index: fhandler.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.136
diff -u -p -r1.136 fhandler.h
--- fhandler.h	26 Aug 2002 09:57:26 -0000	1.136
+++ fhandler.h	27 Aug 2002 14:42:38 -0000
@@ -116,6 +116,7 @@ class path_conv;
 class fhandler_disk_file;
 typedef struct __DIR DIR;
 struct dirent;
+struct iovec;
=20
 enum bg_check_types
 {
@@ -297,6 +298,8 @@ class fhandler_base
   virtual char const * ttyname () { return get_name(); }
   virtual int __stdcall read (void *ptr, size_t len) __attribute__ ((regpa=
rm (3)));
   virtual int write (const void *ptr, size_t len);
+  virtual ssize_t readv (const struct iovec *, int iovcnt, ssize_t tot =3D=
 -1);
+  virtual ssize_t writev (const struct iovec *, int iovcnt, ssize_t tot =
=3D -1);
   virtual __off64_t lseek (__off64_t offset, int whence);
   virtual int lock (int, struct flock *);
   virtual void dump ();
@@ -397,15 +400,15 @@ class fhandler_socket: public fhandler_b
   int getsockname (struct sockaddr *name, int *namelen);
   int getpeername (struct sockaddr *name, int *namelen);
=20
-  int __stdcall read (void *ptr, size_t len) __attribute__ ((regparm (3)));
+  ssize_t readv (const struct iovec *, int iovcnt, ssize_t tot =3D -1);
   int recvfrom (void *ptr, size_t len, int flags,
 		struct sockaddr *from, int *fromlen);
-  int recvmsg (struct msghdr *msg, int flags);
+  int recvmsg (struct msghdr *msg, int flags, ssize_t tot =3D -1);
=20
-  int write (const void *ptr, size_t len);
+  ssize_t writev (const struct iovec *, int iovcnt, ssize_t tot =3D -1);
   int sendto (const void *ptr, size_t len, int flags,
 	      const struct sockaddr *to, int tolen);
-  int sendmsg (const struct msghdr *msg, int flags);
+  int sendmsg (const struct msghdr *msg, int flags, ssize_t tot =3D -1);
=20
   int ioctl (unsigned int cmd, void *);
   int fcntl (int cmd, void *);
Index: fhandler_socket.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler_socket.cc,v
retrieving revision 1.60
diff -u -p -r1.60 fhandler_socket.cc
--- fhandler_socket.cc	27 Aug 2002 09:24:50 -0000	1.60
+++ fhandler_socket.cc	27 Aug 2002 14:42:38 -0000
@@ -660,59 +660,68 @@ fhandler_socket::getpeername (struct soc
   return res;
 }
=20
-int __stdcall
-fhandler_socket::read (void *ptr, size_t len)
+int
+fhandler_socket::readv (const struct iovec *const iov, const int iovcnt,
+			ssize_t tot)
 {
-  return recvfrom (ptr, len, 0, NULL, NULL);
+  struct msghdr msg =3D
+    {
+      msg_name:		NULL,
+      msg_namelen:	0,
+      msg_iov:		const_cast<struct iovec *> (iov),
+      msg_iovlen:	iovcnt,
+      msg_accrights:	NULL,
+      msg_accrightslen:	0
+    };
+
+  return recvmsg (&msg, 0, tot);
 }
=20
 int
 fhandler_socket::recvfrom (void *ptr, size_t len, int flags,
 			   struct sockaddr *from, int *fromlen)
 {
-  int res =3D -1;
-  wsock_event wsock_evt;
-  LPWSAOVERLAPPED ovr;
-
-  if (is_nonblocking () || !(ovr =3D wsock_evt.prepare ()))
-    {
-      debug_printf ("Fallback to winsock 1 recvfrom call");
-      if ((res =3D ::recvfrom (get_socket (), (char *) ptr, len, flags, fr=
om,
-			     fromlen))
-	  =3D=3D SOCKET_ERROR)
-	{
-	  set_winsock_errno ();
-	  res =3D -1;
-	}
-    }
+  int res;
+  DWORD ret;
+
+  if (!winsock2_active)
+    ret =3D res =3D ::recvfrom (get_socket (),
+			    static_cast<char *> (ptr), len, flags,
+			    from, fromlen);
   else
     {
-      WSABUF wsabuf =3D { len, (char *) ptr };
-      DWORD ret =3D 0;
-      if (WSARecvFrom (get_socket (), &wsabuf, 1, &ret, (DWORD *)&flags,
-		       from, fromlen, ovr, NULL) !=3D SOCKET_ERROR)
-	res =3D ret;
-      else if ((res =3D WSAGetLastError ()) !=3D WSA_IO_PENDING)
+      WSABUF wsabuf =3D { len, static_cast<char *> (ptr) };
+
+      if (is_nonblocking ())
+	res =3D WSARecvFrom (get_socket (), &wsabuf, 1, &ret, (DWORD *) &flags,
+			   from, fromlen,
+			   NULL, NULL);
+      else
 	{
-	  set_winsock_errno ();
-	  res =3D -1;
+	  wsock_event wsock_evt;
+	  res =3D WSARecvFrom (get_socket (), &wsabuf, 1, &ret, (DWORD *) &flags,
+			     from, fromlen,
+			     wsock_evt.prepare (), NULL);
+
+	  if (res =3D=3D SOCKET_ERROR && WSAGetLastError () =3D=3D WSA_IO_PENDING)
+	    ret =3D res =3D wsock_evt.wait (get_socket (), (DWORD *) &flags);
 	}
-      else if ((res =3D wsock_evt.wait (get_socket (), (DWORD *)&flags)) =
=3D=3D -1)
-	set_winsock_errno ();
     }
=20
+  if (res =3D=3D SOCKET_ERROR)
+    {
+      res =3D -1;
+      set_winsock_errno ();
+    }
+  else
+    res =3D ret;
+
   return res;
 }
=20
 int
-fhandler_socket::recvmsg (struct msghdr *msg, int flags)
+fhandler_socket::recvmsg (struct msghdr *msg, int flags, ssize_t tot)
 {
-  int res =3D -1;
-  int nb;
-  size_t tot =3D 0;
-  char *buf, *p;
-  struct iovec *iov =3D msg->msg_iov;
-
   if (get_addr_family () =3D=3D AF_LOCAL)
     {
       /* On AF_LOCAL sockets the (fixed-size) name of the shared memory
@@ -722,109 +731,285 @@ fhandler_socket::recvmsg (struct msghdr=20
 	 special handling for descriptor passing. */
       /*TODO*/
     }
-  for (int i =3D 0; i < msg->msg_iovlen; ++i)
-    tot +=3D iov[i].iov_len;
-  buf =3D (char *) alloca (tot);
-  if (tot !=3D 0 && buf =3D=3D NULL)
-    {
-      set_errno (ENOMEM);
-      return -1;
-    }
-  nb =3D res =3D recvfrom (buf, tot, flags, (struct sockaddr *) msg->msg_n=
ame,
-		       (int *) &msg->msg_namelen);
-  p =3D buf;
-  while (nb > 0)
-    {
-      ssize_t cnt =3D min(nb, iov->iov_len);
-      memcpy (iov->iov_base, p, cnt);
-      p +=3D cnt;
-      nb -=3D cnt;
-      ++iov;
+
+  struct iovec *const iov =3D msg->msg_iov;
+  const int iovcnt =3D msg->msg_iovlen;
+
+  int res;
+
+  if (!winsock2_active)
+    {
+      if (iovcnt =3D=3D 1)
+	res =3D recvfrom (iov->iov_base, iov->iov_len, flags,
+			static_cast<struct sockaddr *> (msg->msg_name),
+			&msg->msg_namelen);
+      else
+	{
+	  if (tot =3D=3D -1)	// i.e. if not pre-calculated by the caller.
+	    {
+	      tot =3D 0;
+	      const struct iovec *iovptr =3D iov + iovcnt;
+	      do=20
+		{
+		  iovptr -=3D 1;
+		  tot +=3D iovptr->iov_len;
+		}
+	      while (iovptr !=3D iov);
+	    }
+
+	  char *buf =3D static_cast<char *> (alloca (tot));
+
+	  if (!buf)
+	    {
+	      set_errno (ENOMEM);
+	      res =3D -1;
+	    }
+	  else
+	    {
+	      res =3D recvfrom (buf, tot, flags,
+			      static_cast<struct sockaddr *> (msg->msg_name),
+			      &msg->msg_namelen);
+
+	      const struct iovec *iovptr =3D iov;
+	      int nbytes =3D res;
+
+	      while (nbytes > 0)
+		{
+		  const int frag =3D min (nbytes,
+					static_cast<ssize_t> (iovptr->iov_len));
+		  memcpy (iovptr->iov_base, buf, frag);
+		  buf +=3D frag;
+		  iovptr +=3D 1;
+		  nbytes -=3D frag;
+		}
+	    }
+	}
     }
+  else
+    {
+      WSABUF wsabuf[iovcnt];
+
+      {
+	const struct iovec *iovptr =3D iov + iovcnt;
+	WSABUF *wsaptr =3D wsabuf + iovcnt;
+	do
+	  {
+	    iovptr -=3D 1;
+	    wsaptr -=3D 1;
+	    wsaptr->len =3D iovptr->iov_len;
+	    wsaptr->buf =3D static_cast<char *> (iovptr->iov_base);
+	  }
+	while (wsaptr !=3D wsabuf);
+      }
+
+      DWORD ret;
+
+      if (is_nonblocking ())
+	res =3D WSARecvFrom (get_socket (),
+			   wsabuf, iovcnt, &ret, (DWORD *) &flags,
+			   static_cast<struct sockaddr *> (msg->msg_name),
+			   &msg->msg_namelen,
+			   NULL, NULL);
+      else
+	{
+	  wsock_event wsock_evt;
+	  res =3D WSARecvFrom (get_socket (),
+			     wsabuf, iovcnt, &ret, (DWORD *) &flags,
+			     static_cast<struct sockaddr *> (msg->msg_name),
+			     &msg->msg_namelen,
+			     wsock_evt.prepare (), NULL);
+
+	  if (res =3D=3D SOCKET_ERROR && WSAGetLastError () =3D=3D WSA_IO_PENDING)
+	    ret =3D res =3D wsock_evt.wait (get_socket (), (DWORD *) &flags);
+	}
+
+      if (res =3D=3D SOCKET_ERROR)
+	{
+	  res =3D -1;
+	  set_winsock_errno ();
+	}
+      else
+	res =3D ret;
+    }
+
   return res;
 }
=20
 int
-fhandler_socket::write (const void *ptr, size_t len)
+fhandler_socket::writev (const struct iovec *const iov, const int iovcnt,
+			 ssize_t tot)
 {
-  return sendto (ptr, len, 0, NULL, 0);
+  struct msghdr msg =3D
+    {
+      msg_name:		NULL,
+      msg_namelen:	0,
+      msg_iov:		const_cast<struct iovec *> (iov),
+      msg_iovlen:	iovcnt,
+      msg_accrights:	NULL,
+      msg_accrightslen:	0
+    };
+
+  return sendmsg (&msg, 0, tot);
 }
=20
 int
 fhandler_socket::sendto (const void *ptr, size_t len, int flags,
 			 const struct sockaddr *to, int tolen)
 {
-  int res =3D -1;
-  wsock_event wsock_evt;
-  LPWSAOVERLAPPED ovr;
   sockaddr_in sin;
=20
   if (to && !get_inet_addr (to, tolen, &sin, &tolen))
     return -1;
=20
-  if (is_nonblocking () || !(ovr =3D wsock_evt.prepare ()))
-    {
-      debug_printf ("Fallback to winsock 1 sendto call");
-      if ((res =3D ::sendto (get_socket (), (const char *) ptr, len, flags,
-			   (to ? (sockaddr *) &sin : NULL),
-			   tolen)) =3D=3D SOCKET_ERROR)
-	{
-	  set_winsock_errno ();
-	  res =3D -1;
-	}
-    }
+  int res;
+  DWORD ret;
+
+  if (!winsock2_active)
+    res =3D ::sendto (get_socket (), (const char *) ptr, len, flags,
+		    (to ? (sockaddr *) &sin : NULL), tolen);
   else
     {
       WSABUF wsabuf =3D { len, (char *) ptr };
-      DWORD ret =3D 0;
-      if (WSASendTo (get_socket (), &wsabuf, 1, &ret, (DWORD)flags,
-		     (to ? (sockaddr *) &sin : NULL),
-		     tolen,
-		     ovr, NULL) !=3D SOCKET_ERROR)
-	res =3D ret;
-      else if ((res =3D WSAGetLastError ()) !=3D WSA_IO_PENDING)
+
+      if (is_nonblocking ())
+	res =3D WSASendTo (get_socket (), &wsabuf, 1, &ret, flags,
+			 (to ? (const sockaddr *) &sin : NULL), tolen,
+			 NULL, NULL);
+      else
 	{
-	  set_winsock_errno ();
-	  res =3D -1;
+	  wsock_event wsock_evt;
+	  res =3D WSASendTo (get_socket (), &wsabuf, 1, &ret, flags,
+			   (to ? (const sockaddr *) &sin : NULL), tolen,
+			   wsock_evt.prepare (), NULL);
+
+	  if (res =3D=3D SOCKET_ERROR && WSAGetLastError () =3D=3D WSA_IO_PENDING)
+	    ret =3D res =3D wsock_evt.wait (get_socket (), (DWORD *) &flags);
 	}
-      else if ((res =3D wsock_evt.wait (get_socket (), (DWORD *)&flags)) =
=3D=3D -1)
-	set_winsock_errno ();
     }
=20
+  if (res =3D=3D SOCKET_ERROR)
+    {
+      res =3D -1;
+      set_winsock_errno ();
+    }
+  else
+    res =3D ret;
+
   return res;
 }
=20
 int
-fhandler_socket::sendmsg (const struct msghdr *msg, int flags)
+fhandler_socket::sendmsg (const struct msghdr *msg, int flags, ssize_t tot)
 {
-    size_t tot =3D 0;
-    char *buf, *p;
-    struct iovec *iov =3D msg->msg_iov;
-
-    if (get_addr_family () =3D=3D AF_LOCAL)
-      {
-        /* For AF_LOCAL/AF_UNIX sockets, if descriptors are given, start
-           the special handling for descriptor passing.  Otherwise just
-           transmit an empty string to tell the receiver that no
-           descriptor passing is done. */
+  if (get_addr_family () =3D=3D AF_LOCAL)
+    {
+      /* For AF_LOCAL/AF_UNIX sockets, if descriptors are given, start
+	 the special handling for descriptor passing.  Otherwise just
+	 transmit an empty string to tell the receiver that no
+	 descriptor passing is done. */
       /*TODO*/
-      }
-    for(int i =3D 0; i < msg->msg_iovlen; ++i)
-        tot +=3D iov[i].iov_len;
-    buf =3D (char *) alloca (tot);
-    if (tot !=3D 0 && buf =3D=3D NULL)
-      {
-        set_errno (ENOMEM);
-        return -1;
-      }
-    p =3D buf;
-    for (int i =3D 0; i < msg->msg_iovlen; ++i)
+    }
+
+  struct iovec *const iov =3D msg->msg_iov;
+  const int iovcnt =3D msg->msg_iovlen;
+
+  int res;
+
+  if (!winsock2_active)
+    {
+      if (iovcnt =3D=3D 1)
+	res =3D sendto (iov->iov_base, iov->iov_len, flags,
+		      static_cast<struct sockaddr *> (msg->msg_name),
+		      msg->msg_namelen);
+      else
+	{
+	  if (tot =3D=3D -1)	// i.e. if not pre-calculated by the caller.
+	    {
+	      tot =3D 0;
+	      const struct iovec *iovptr =3D iov + iovcnt;
+	      do=20
+		{
+		  iovptr -=3D 1;
+		  tot +=3D iovptr->iov_len;
+		}
+	      while (iovptr !=3D iov);
+	    }
+
+	  char *const buf =3D static_cast<char *> (alloca (tot));
+
+	  if (!buf)
+	    {
+	      set_errno (ENOMEM);
+	      res =3D -1;
+	    }
+	  else
+	    {
+	      char *bufptr =3D buf;
+	      const struct iovec *iovptr =3D iov;
+	      int nbytes =3D tot;
+
+	      while (nbytes !=3D 0)
+		{
+		  const int frag =3D min (nbytes,
+					static_cast<ssize_t> (iovptr->iov_len));
+		  memcpy (bufptr, iovptr->iov_base, frag);
+		  bufptr +=3D frag;
+		  iovptr +=3D 1;
+		  nbytes -=3D frag;
+		}
+
+	      res =3D sendto (buf, tot, flags,
+			    static_cast<struct sockaddr *> (msg->msg_name),
+			    msg->msg_namelen);
+	    }
+	}
+    }
+  else
+    {
+      WSABUF wsabuf[iovcnt];
+
       {
-        memcpy (p, iov[i].iov_base, iov[i].iov_len);
-        p +=3D iov[i].iov_len;
+	const struct iovec *iovptr =3D iov + iovcnt;
+	WSABUF *wsaptr =3D wsabuf + iovcnt;
+	do
+	  {
+	    iovptr -=3D 1;
+	    wsaptr -=3D 1;
+	    wsaptr->len =3D iovptr->iov_len;
+	    wsaptr->buf =3D static_cast<char *> (iovptr->iov_base);
+	  }
+	while (wsaptr !=3D wsabuf);
       }
-    return sendto (buf, tot, flags, (struct sockaddr *) msg->msg_name,
-		   msg->msg_namelen);
+
+      DWORD ret;
+
+      if (is_nonblocking ())
+	res =3D WSASendTo (get_socket (), wsabuf, iovcnt, &ret, flags,
+			 static_cast<struct sockaddr *> (msg->msg_name),
+			 msg->msg_namelen,
+			 NULL, NULL);
+      else
+	{
+	  wsock_event wsock_evt;
+	  res =3D WSASendTo (get_socket (), wsabuf, iovcnt, &ret, flags,
+			   static_cast<struct sockaddr *> (msg->msg_name),
+			   msg->msg_namelen,
+			   wsock_evt.prepare (), NULL);
+
+	  if (res =3D=3D SOCKET_ERROR && WSAGetLastError () =3D=3D WSA_IO_PENDING)
+	    ret =3D res =3D wsock_evt.wait (get_socket (), (DWORD *) &flags);
+	}
+
+      if (res =3D=3D SOCKET_ERROR)
+	{
+	  res =3D -1;
+	  set_winsock_errno ();
+	}
+      else
+	res =3D ret;
+    }
+
+  return res;
 }
=20
 int
Index: miscfuncs.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/miscfuncs.cc,v
retrieving revision 1.13
diff -u -p -r1.13 miscfuncs.cc
--- miscfuncs.cc	8 Aug 2002 17:03:20 -0000	1.13
+++ miscfuncs.cc	27 Aug 2002 14:42:38 -0000
@@ -11,6 +11,9 @@ details. */
 #include "winsup.h"
 #include "cygerrno.h"
 #include <sys/errno.h>
+#include <sys/uio.h>
+#include <assert.h>
+#include <limits.h>
 #include <winbase.h>
 #include <winnls.h>
=20
@@ -177,6 +180,74 @@ __check_invalid_read_ptr_errno (const vo
   if (s && !IsBadReadPtr (s, sz))
     return 0;
   return set_errno (EFAULT);
+}
+
+ssize_t
+check_iovec_for_read (const struct iovec *iov, int iovcnt)
+{
+  if (!(iovcnt > 0 && iovcnt <=3D IOV_MAX))
+    {
+      set_errno (EINVAL);
+      return -1;
+    }
+
+  if (__check_invalid_read_ptr_errno (iov, iovcnt * sizeof (*iov)))
+    return -1;
+
+  size_t tot =3D 0;
+
+  while (iovcnt !=3D 0)
+    {
+      if (iov->iov_len > SSIZE_MAX || (tot +=3D iov->iov_len) > SSIZE_MAX)
+	{
+	  set_errno (EINVAL);
+	  return -1;
+	}
+
+      if (__check_null_invalid_struct_errno (iov->iov_base, iov->iov_len))
+	return -1;
+
+      iov +=3D 1;
+      iovcnt -=3D 1;
+    }
+
+  assert (tot <=3D SSIZE_MAX);
+
+  return static_cast<ssize_t> (tot);
+}
+
+ssize_t
+check_iovec_for_write (const struct iovec *iov, int iovcnt)
+{
+  if (!(iovcnt > 0 && iovcnt <=3D IOV_MAX))
+    {
+      set_errno (EINVAL);
+      return -1;
+    }
+
+  if (__check_invalid_read_ptr_errno (iov, iovcnt * sizeof (*iov)))
+    return -1;
+
+  size_t tot =3D 0;
+
+  while (iovcnt !=3D 0)
+    {
+      if (iov->iov_len > SSIZE_MAX || (tot +=3D iov->iov_len) > SSIZE_MAX)
+	{
+	  set_errno (EINVAL);
+	  return -1;
+	}
+
+      if (__check_invalid_read_ptr_errno (iov->iov_base, iov->iov_len))
+	return -1;
+
+      iov +=3D 1;
+      iovcnt -=3D 1;
+    }
+
+  assert (tot <=3D SSIZE_MAX);
+
+  return static_cast<ssize_t> (tot);
 }
=20
 UINT
Index: net.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/net.cc,v
retrieving revision 1.123
diff -u -p -r1.123 net.cc
--- net.cc	27 Aug 2002 09:24:50 -0000	1.123
+++ net.cc	27 Aug 2002 14:42:39 -0000
@@ -2112,7 +2112,11 @@ cygwin_recvmsg (int fd, struct msghdr *m
       || !fh)
     res =3D -1;
   else
-    res =3D fh->recvmsg (msg, flags);
+    {
+      res =3D check_iovec_for_read (msg->msg_iov, msg->msg_iovlen);
+      if (res > 0)
+	res =3D fh->recvmsg (msg, flags, res); // res =3D=3D iovec tot
+    }
=20
   syscall_printf ("%d =3D recvmsg (%d, %p, %x)", res, fd, msg, flags);
   return res;
@@ -2123,6 +2127,8 @@ extern "C" int
 cygwin_sendmsg (int fd, const struct msghdr *msg, int flags)
 {
   int res;
+  sigframe thisframe (mainthread);
+
   fhandler_socket *fh =3D get (fd);
=20
   if (__check_invalid_read_ptr_errno (msg, sizeof msg)
@@ -2131,8 +2137,12 @@ cygwin_sendmsg (int fd, const struct msg
 					     (unsigned) msg->msg_namelen))
       || !fh)
     res =3D -1;
-  else
-    res =3D fh->sendmsg (msg, flags);
+  else=20
+    {
+      res =3D check_iovec_for_write (msg->msg_iov, msg->msg_iovlen);
+      if (res > 0)
+	res =3D fh->sendmsg (msg, flags, res); // res =3D=3D iovec tot
+    }
=20
   syscall_printf ("%d =3D sendmsg (%d, %p, %x)", res, fd, msg, flags);
   return res;
Index: syscalls.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.224
diff -u -p -r1.224 syscalls.cc
--- syscalls.cc	18 Aug 2002 05:49:25 -0000	1.224
+++ syscalls.cc	27 Aug 2002 14:42:40 -0000
@@ -321,15 +321,42 @@ getsid (pid_t pid)
 extern "C" ssize_t
 _read (int fd, void *ptr, size_t len)
 {
-  if (len =3D=3D 0)
-    return 0;
+  const struct iovec iov =3D
+    {
+      iov_base: ptr,
+      iov_len: len
+    };
+
+  return readv (fd, &iov, 1);
+}
=20
-  if (__check_null_invalid_struct_errno (ptr, len))
-    return -1;
+extern "C" ssize_t
+_write (int fd, const void *ptr, size_t len)
+{
+  const struct iovec iov =3D
+    {
+      iov_base: const_cast<void *> (ptr),
+      iov_len: len
+    };
+
+  return writev (fd, &iov, 1);
+}
=20
-  int res;
+extern "C" ssize_t
+readv (int fd, const struct iovec *const iov, const int iovcnt)
+{
   extern int sigcatchers;
-  int e =3D get_errno ();
+  const int e =3D get_errno ();
+
+  int res =3D -1;
+
+  const ssize_t tot =3D check_iovec_for_read (iov, iovcnt);
+
+  if (tot <=3D 0)
+    {
+      res =3D tot;
+      goto done;
+    }
=20
   while (1)
     {
@@ -337,197 +364,119 @@ _read (int fd, void *ptr, size_t len)
=20
       cygheap_fdget cfd (fd);
       if (cfd < 0)
-	return -1;
+	break;
+
+      if ((cfd->get_flags () & O_ACCMODE) =3D=3D O_WRONLY)
+	{
+	  set_errno (EBADF);
+	  break;
+	}
=20
       DWORD wait =3D cfd->is_nonblocking () ? 0 : INFINITE;
=20
       /* Could block, so let user know we at least got here.  */
-      syscall_printf ("read (%d, %p, %d) %sblocking, sigcatchers %d",
-		      fd, ptr, len, wait ? "" : "non", sigcatchers);
+      syscall_printf ("readv (%d, %p, %d) %sblocking, sigcatchers %d",
+		      fd, iov, iovcnt, wait ? "" : "non", sigcatchers);
=20
       if (wait && (!cfd->is_slow () || cfd->get_r_no_interrupt ()))
 	debug_printf ("no need to call ready_for_read\n");
       else if (!cfd->ready_for_read (fd, wait))
-	{
-	  res =3D -1;
-	  goto out;
-	}
+	goto out;
=20
       /* FIXME: This is not thread safe.  We need some method to
 	 ensure that an fd, closed in another thread, aborts I/O
 	 operations. */
       if (!cfd.isopen ())
-	return -1;
+	break;
=20
       /* Check to see if this is a background read from a "tty",
 	 sending a SIGTTIN, if appropriate */
       res =3D cfd->bg_check (SIGTTIN);
=20
       if (!cfd.isopen ())
-	return -1;
+	{
+	  res =3D -1;
+	  break;
+	}
=20
       if (res > bg_eof)
 	{
 	  myself->process_state |=3D PID_TTYIN;
 	  if (!cfd.isopen ())
-	    return -1;
-	  res =3D cfd->read (ptr, len);
+	    {
+	      res =3D -1;
+	      break;
+	    }
+	  res =3D cfd->readv (iov, iovcnt, tot);
 	  myself->process_state &=3D ~PID_TTYIN;
 	}
=20
     out:
-
-      if (res && get_errno () =3D=3D EACCES &&
-	  !(cfd->get_flags () & (O_RDONLY | O_RDWR)))
+      if (!(res =3D=3D -1
+	    && get_errno () =3D=3D EINTR
+	    && thisframe.call_signal_handler ()))
 	{
-	  set_errno (EBADF);
 	  break;
 	}
=20
-      if (res >=3D 0 || get_errno () !=3D EINTR || !thisframe.call_signal_=
handler ())
-	break;
       set_errno (e);
     }
=20
-  syscall_printf ("%d =3D read (%d, %p, %d), errno %d", res, fd, ptr, len,
-		  get_errno ());
+done:
+  syscall_printf ("%d =3D readv (%d, %p, %d), errno %d",
+		  res, fd, iov, iovcnt, get_errno ());
   MALLOC_CHECK;
   return res;
 }
=20
 extern "C" ssize_t
-_write (int fd, const void *ptr, size_t len)
+writev (const int fd, const struct iovec *const iov, const int iovcnt)
 {
   int res =3D -1;
+  const ssize_t tot =3D check_iovec_for_write (iov, iovcnt);
=20
   sigframe thisframe (mainthread);
   cygheap_fdget cfd (fd);
   if (cfd < 0)
     goto done;
=20
-  /* No further action required for len =3D=3D 0 */
-  if (len =3D=3D 0)
+  if (tot <=3D 0)
     {
-      res =3D 0;
+      res =3D tot;
       goto done;
     }
=20
-  if (len && __check_invalid_read_ptr_errno (ptr, len))
-    goto done;
+  if ((cfd->get_flags () & O_ACCMODE) =3D=3D O_RDONLY)
+    {
+      set_errno (EBADF);
+      goto done;
+    }
=20
   /* Could block, so let user know we at least got here.  */
   if (fd =3D=3D 1 || fd =3D=3D 2)
-    paranoid_printf ("write (%d, %p, %d)", fd, ptr, len);
+    paranoid_printf ("writev (%d, %p, %d)", fd, iov, iovcnt);
   else
-    syscall_printf  ("write (%d, %p, %d)", fd, ptr, len);
+    syscall_printf  ("writev (%d, %p, %d)", fd, iov, iovcnt);
=20
   res =3D cfd->bg_check (SIGTTOU);
=20
   if (res > bg_eof)
     {
       myself->process_state |=3D PID_TTYOU;
-      res =3D cfd->write (ptr, len);
+      res =3D cfd->writev (iov, iovcnt, tot);
       myself->process_state &=3D ~PID_TTYOU;
-      if (res && get_errno () =3D=3D EACCES &&
-	  !(cfd->get_flags () & (O_WRONLY | O_RDWR)))
-	set_errno (EBADF);
     }
=20
 done:
   if (fd =3D=3D 1 || fd =3D=3D 2)
-    paranoid_printf ("%d =3D write (%d, %p, %d)", res, fd, ptr, len);
+    paranoid_printf ("%d =3D write (%d, %p, %d), errno %d",
+		     res, fd, iov, iovcnt, get_errno ());
   else
-    syscall_printf ("%d =3D write (%d, %p, %d)", res, fd, ptr, len);
-
-  return (ssize_t) res;
-}
-
-/*
- * FIXME - should really move this interface into fhandler, and implement
- * write in terms of it. There are devices in Win32 that could do this with
- * overlapped I/O much more efficiently - we should eventually use
- * these.
- */
-
-extern "C" ssize_t
-writev (int fd, const struct iovec *iov, int iovcnt)
-{
-  int i;
-  ssize_t len, total;
-  char *base;
-
-  if (iovcnt < 1 || iovcnt > IOV_MAX)
-    {
-      set_errno (EINVAL);
-      return -1;
-    }
-
-  /* Ensure that the sum of the iov_len values is less than
-     SSIZE_MAX (per spec), if so, we must fail with no output (per spec).
-  */
-  total =3D 0;
-  for (i =3D 0; i < iovcnt; ++i)
-    {
-    total +=3D iov[i].iov_len;
-    if (total > SSIZE_MAX)
-      {
-      set_errno (EINVAL);
-      return -1;
-      }
-    }
-  /* Now write the data */
-  for (i =3D 0, total =3D 0; i < iovcnt; i++, iov++)
-    {
-      len =3D iov->iov_len;
-      base =3D iov->iov_base;
-      while (len > 0)
-	{
-	  register int nbytes;
-	  nbytes =3D write (fd, base, len);
-	  if (nbytes < 0 && total =3D=3D 0)
-	    return -1;
-	  if (nbytes <=3D 0)
-	    return total;
-	  len -=3D nbytes;
-	  total +=3D nbytes;
-	  base +=3D nbytes;
-	}
-    }
-  return total;
-}
+    syscall_printf ("%d =3D write (%d, %p, %d), errno %d",
+		    res, fd, iov, iovcnt, get_errno ());
=20
-/*
- * FIXME - should really move this interface into fhandler, and implement
- * read in terms of it. There are devices in Win32 that could do this with
- * overlapped I/O much more efficiently - we should eventually use
- * these.
- */
-
-extern "C" ssize_t
-readv (int fd, const struct iovec *iov, int iovcnt)
-{
-  int i;
-  ssize_t len, total;
-  char *base;
-
-  for (i =3D 0, total =3D 0; i < iovcnt; i++, iov++)
-    {
-      len =3D iov->iov_len;
-      base =3D iov->iov_base;
-      while (len > 0)
-	{
-	  register int nbytes;
-	  nbytes =3D read (fd, base, len);
-	  if (nbytes < 0 && total =3D=3D 0)
-	    return -1;
-	  if (nbytes <=3D 0)
-	    return total;
-	  len -=3D nbytes;
-	  total +=3D nbytes;
-	  base +=3D nbytes;
-	}
-    }
-  return total;
+  MALLOC_CHECK;
+  return res;
 }
=20
 /* _open */
Index: winsup.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/winsup.h,v
retrieving revision 1.99
diff -u -p -r1.99 winsup.h
--- winsup.h	16 Aug 2002 19:49:54 -0000	1.99
+++ winsup.h	27 Aug 2002 14:42:40 -0000
@@ -221,6 +221,10 @@ int __stdcall __check_invalid_read_ptr_e
 #define check_null_invalid_struct_errno(s) \
   __check_null_invalid_struct_errno ((s), sizeof (*(s)))
=20
+struct iovec;
+ssize_t check_iovec_for_read (const struct iovec *, int) __attribute__ ((r=
egparm(2)));
+ssize_t check_iovec_for_write (const struct iovec *, int) __attribute__ ((=
regparm(2)));
+
 #define set_winsock_errno() __set_winsock_errno (__FUNCTION__, __LINE__)
 void __set_winsock_errno (const char *fn, int ln) __attribute__ ((regparm(=
2)));
=20
Index: include/sys/uio.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/include/sys/uio.h,v
retrieving revision 1.4
diff -u -p -r1.4 uio.h
--- include/sys/uio.h	5 Mar 2001 21:29:23 -0000	1.4
+++ include/sys/uio.h	27 Aug 2002 14:42:40 -0000
@@ -25,8 +25,8 @@ __BEGIN_DECLS
  */
=20
 struct iovec {
-	caddr_t iov_base;
-	int iov_len;
+  void *iov_base;
+  size_t iov_len;
 };
=20
 extern ssize_t readv __P ((int filedes, const struct iovec *vector, int co=
unt));

------=_NextPart_000_01A7_01C24DE3.2DBDBEC0--

