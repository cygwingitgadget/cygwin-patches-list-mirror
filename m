Return-Path: <cygwin-patches-return-2788-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24149 invoked by alias); 7 Aug 2002 17:24:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24118 invoked from network); 7 Aug 2002 17:24:32 -0000
Message-ID: <040201c23e37$256b0810$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
Subject: IsBad*Ptr patch
Date: Wed, 07 Aug 2002 10:24:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_03FF_01C23E3F.858E4330"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00236.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_03FF_01C23E3F.858E4330
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 1059

I've attached a patch that starts from changing the signature of
__check_null_invalid_struct and __check_null_invalid_struct_errno
to take a non-const void *.  Previously they took a const argument
and as a result, were being called in a couple of places on const
system call arguments that should have had
__check_invalid_read_ptr_errno called on them.

So, I changed their signatures and patched a couple of problems
that showed up as a result.

While I was at it, I fiddled with those system call interfaces in
"net.cc" that delegate to fhandler_socket methods.  I've made the
error checking consistent, so the right errno is set for
non-socket file descriptors and they all emit their trace messages
even on error, and also corrected a couple of minor issues where
optional arguments were being unconditionally checked.

The recvmsg and sendmsg interfaces don't fully check their
arguments yet (i.e. the iovec part) but this patch is the first of
a set for readv/writev changes, and the final version will include
the relevant checks.

Enjoy!

// Conrad


------=_NextPart_000_03FF_01C23E3F.858E4330
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 1001

2002-08-07  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* winsup.h (__check_null_invalid_struct): Make ptr argument non-const.
	(__check_null_invalid_struct_errno): Ditto.
	* miscfuncs.cc (__check_null_invalid_struct): Ditto.
	(__check_null_invalid_struct_errno): Ditto.
	(__check_invalid_read_ptr_errno): Remove superfluous cast.
	* net.cc (get): Set appropriate errno if fd is not a socket.
	(cygwin_sendto): Fix parameter checking.
	(cygwin_recvfrom): Ditto.
	(cygwin_setsockopt): Ditto.
	(cygwin_getsockopt): Ditto.
	(cygwin_connect): Ditto.
	(cygwin_gethostbyaddr): Ditto.
	(cygwin_accept): Ditto.
	(cygwin_bind): Ditto.
	(cygwin_getsockname): Ditto.
	(cygwin_listen): Ditto.
	(cygwin_getpeername): Ditto.
	(cygwin_send): Ditto.
	(cygwin_shutdown): Ditto.  Move sigframe to fhandler_socket.
	(cygwin_recvmsg): Fix parameter checking.  Add tracing.
	(cygwin_sendmsg): Ditto.
	* fhandler_socket.cc (fhandler_socket::shutdown): Add sigframe.
	* resource.cc (setrlimit): Fix parameter checking.
=09

------=_NextPart_000_03FF_01C23E3F.858E4330
Content-Type: text/plain;
	name="isbad.patch.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="isbad.patch.txt"
Content-length: 14806

Index: fhandler_socket.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler_socket.cc,v
retrieving revision 1.56
diff -u -r1.56 fhandler_socket.cc
--- fhandler_socket.cc	7 Aug 2002 10:08:17 -0000	1.56
+++ fhandler_socket.cc	7 Aug 2002 16:51:49 -0000
@@ -915,6 +915,8 @@
 int
 fhandler_socket::shutdown (int how)
 {
+  sigframe thisframe (mainthread);
+
   int res =3D ::shutdown (get_socket (), how);
=20
   if (res)
Index: miscfuncs.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/miscfuncs.cc,v
retrieving revision 1.12
diff -u -r1.12 miscfuncs.cc
--- miscfuncs.cc	26 Jun 2002 05:29:41 -0000	1.12
+++ miscfuncs.cc	7 Aug 2002 16:51:49 -0000
@@ -154,16 +154,16 @@
 }
=20
 int __stdcall
-__check_null_invalid_struct (const void *s, unsigned sz)
+__check_null_invalid_struct (void *s, unsigned sz)
 {
-  if (s && !IsBadWritePtr ((void *) s, sz))
+  if (s && !IsBadWritePtr (s, sz))
     return 0;
=20
   return EFAULT;
 }
=20
 int __stdcall
-__check_null_invalid_struct_errno (const void *s, unsigned sz)
+__check_null_invalid_struct_errno (void *s, unsigned sz)
 {
   int err;
   if ((err =3D __check_null_invalid_struct (s, sz)))
@@ -174,7 +174,7 @@
 int __stdcall
 __check_invalid_read_ptr_errno (const void *s, unsigned sz)
 {
-  if (s && !IsBadReadPtr ((void *) s, sz))
+  if (s && !IsBadReadPtr (s, sz))
     return 0;
   return set_errno (EFAULT);
 }
Index: net.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/net.cc,v
retrieving revision 1.119
diff -u -r1.119 net.cc
--- net.cc	31 Jul 2002 13:18:51 -0000	1.119
+++ net.cc	7 Aug 2002 16:51:50 -0000
@@ -101,13 +101,17 @@
=20
 /* Cygwin internal */
 static fhandler_socket *
-get (int fd)
+get (const int fd)
 {
   cygheap_fdget cfd (fd);
   if (cfd < 0)
     return 0;
=20
-  return cfd->is_socket ();
+  fhandler_socket *const fh =3D cfd->is_socket ();
+  if (!fh)
+    set_errno (ENOTSOCK);
+
+  return fh;
 }
=20
 /* Cygwin internal */
@@ -567,7 +571,7 @@
   fhandler_socket *fh =3D get (fd);
=20
   if ((len && __check_invalid_read_ptr_errno (buf, (unsigned) len))
-      || __check_null_invalid_struct_errno (to, tolen)
+      || (to &&__check_invalid_read_ptr_errno (to, tolen))
       || !fh)
     res =3D -1;
   else
@@ -587,8 +591,9 @@
   fhandler_socket *fh =3D get (fd);
=20
   if (__check_null_invalid_struct_errno (buf, (unsigned) len)
-      || check_null_invalid_struct_errno (fromlen)
-      || (from && __check_null_invalid_struct_errno (from, (unsigned) *fro=
mlen))
+      || (from
+	  && (check_null_invalid_struct_errno (fromlen)
+	      ||__check_null_invalid_struct_errno (from, (unsigned) *fromlen)))
       || !fh)
     res =3D -1;
   else
@@ -604,47 +609,50 @@
 cygwin_setsockopt (int fd, int level, int optname, const void *optval,
 		   int optlen)
 {
+  int res;
   fhandler_socket *fh =3D get (fd);
-  int res =3D -1;
   const char *name =3D "error";
=20
-  if ((!optval || !__check_invalid_read_ptr_errno (optval, optlen)) && fh)
+  /* For the following debug_printf */
+  switch (optname)
     {
-      /* For the following debug_printf */
-      switch (optname)
-	{
-	case SO_DEBUG:
-	  name=3D"SO_DEBUG";
-	  break;
-	case SO_ACCEPTCONN:
-	  name=3D"SO_ACCEPTCONN";
-	  break;
-	case SO_REUSEADDR:
-	  name=3D"SO_REUSEADDR";
-	  break;
-	case SO_KEEPALIVE:
-	  name=3D"SO_KEEPALIVE";
-	  break;
-	case SO_DONTROUTE:
-	  name=3D"SO_DONTROUTE";
-	  break;
-	case SO_BROADCAST:
-	  name=3D"SO_BROADCAST";
-	  break;
-	case SO_USELOOPBACK:
-	  name=3D"SO_USELOOPBACK";
-	  break;
-	case SO_LINGER:
-	  name=3D"SO_LINGER";
-	  break;
-	case SO_OOBINLINE:
-	  name=3D"SO_OOBINLINE";
-	  break;
-	case SO_ERROR:
-	  name=3D"SO_ERROR";
-	  break;
-	}
+    case SO_DEBUG:
+      name=3D"SO_DEBUG";
+      break;
+    case SO_ACCEPTCONN:
+      name=3D"SO_ACCEPTCONN";
+      break;
+    case SO_REUSEADDR:
+      name=3D"SO_REUSEADDR";
+      break;
+    case SO_KEEPALIVE:
+      name=3D"SO_KEEPALIVE";
+      break;
+    case SO_DONTROUTE:
+      name=3D"SO_DONTROUTE";
+      break;
+    case SO_BROADCAST:
+      name=3D"SO_BROADCAST";
+      break;
+    case SO_USELOOPBACK:
+      name=3D"SO_USELOOPBACK";
+      break;
+    case SO_LINGER:
+      name=3D"SO_LINGER";
+      break;
+    case SO_OOBINLINE:
+      name=3D"SO_OOBINLINE";
+      break;
+    case SO_ERROR:
+      name=3D"SO_ERROR";
+      break;
+    }
=20
+  if ((optval && __check_invalid_read_ptr_errno (optval, optlen))
+      || !fh)
+    res =3D -1;
+  else
+    {
       res =3D setsockopt (fh->get_socket (), level, optname,
 			(const char *) optval, optlen);
=20
@@ -664,49 +672,52 @@
 extern "C" int
 cygwin_getsockopt (int fd, int level, int optname, void *optval, int *optl=
en)
 {
+  int res;
   fhandler_socket *fh =3D get (fd);
-  int res =3D -1;
   const char *name =3D "error";
-  if (!check_null_invalid_struct_errno (optlen)
-      && (!optval
-          || !__check_null_invalid_struct_errno (optval, (unsigned) *optle=
n))
-      && fh)
+
+  /* For the following debug_printf */
+  switch (optname)
     {
-      /* For the following debug_printf */
-      switch (optname)
-	{
-	case SO_DEBUG:
-	  name=3D"SO_DEBUG";
-	  break;
-	case SO_ACCEPTCONN:
-	  name=3D"SO_ACCEPTCONN";
-	  break;
-	case SO_REUSEADDR:
-	  name=3D"SO_REUSEADDR";
-	  break;
-	case SO_KEEPALIVE:
-	  name=3D"SO_KEEPALIVE";
-	  break;
-	case SO_DONTROUTE:
-	  name=3D"SO_DONTROUTE";
-	  break;
-	case SO_BROADCAST:
-	  name=3D"SO_BROADCAST";
-	  break;
-	case SO_USELOOPBACK:
-	  name=3D"SO_USELOOPBACK";
-	  break;
-	case SO_LINGER:
-	  name=3D"SO_LINGER";
-	  break;
-	case SO_OOBINLINE:
-	  name=3D"SO_OOBINLINE";
-	  break;
-	case SO_ERROR:
-	  name=3D"SO_ERROR";
-	  break;
-	}
+    case SO_DEBUG:
+      name=3D"SO_DEBUG";
+      break;
+    case SO_ACCEPTCONN:
+      name=3D"SO_ACCEPTCONN";
+      break;
+    case SO_REUSEADDR:
+      name=3D"SO_REUSEADDR";
+      break;
+    case SO_KEEPALIVE:
+      name=3D"SO_KEEPALIVE";
+      break;
+    case SO_DONTROUTE:
+      name=3D"SO_DONTROUTE";
+      break;
+    case SO_BROADCAST:
+      name=3D"SO_BROADCAST";
+      break;
+    case SO_USELOOPBACK:
+      name=3D"SO_USELOOPBACK";
+      break;
+    case SO_LINGER:
+      name=3D"SO_LINGER";
+      break;
+    case SO_OOBINLINE:
+      name=3D"SO_OOBINLINE";
+      break;
+    case SO_ERROR:
+      name=3D"SO_ERROR";
+      break;
+    }
=20
+  if ((optval
+       && (check_null_invalid_struct_errno (optlen)
+	   || __check_null_invalid_struct_errno (optval, (unsigned) *optlen)))
+      || !fh)
+    res =3D -1;
+  else
+    {
       res =3D getsockopt (fh->get_socket (), level, optname, (char *) optv=
al,
       			(int *) optlen);
=20
@@ -732,10 +743,7 @@
   int res;
   fhandler_socket *fh =3D get (fd);
=20
-  if (__check_invalid_read_ptr_errno (name, namelen))
-    return -1;
-
-  if (!fh)
+  if (__check_invalid_read_ptr_errno (name, namelen) || !fh)
     res =3D -1;
   else
     res =3D fh->connect (name, namelen);
@@ -970,7 +978,7 @@
 extern "C" struct hostent *
 cygwin_gethostbyaddr (const char *addr, int len, int type)
 {
-  if (__check_null_invalid_struct_errno (addr, len))
+  if (__check_invalid_read_ptr_errno (addr, len))
     return NULL;
=20
   free_hostent_ptr (hostent_buf);
@@ -992,15 +1000,14 @@
 extern "C" int
 cygwin_accept (int fd, struct sockaddr *peer, int *len)
 {
-  if (peer !=3D NULL
-      && (check_null_invalid_struct_errno (len)
-	  || __check_null_invalid_struct_errno (peer, (unsigned) *len)))
-    return -1;
-
-  int res =3D -1;
-
+  int res;
   fhandler_socket *fh =3D get (fd);
-  if (fh)
+
+  if ((peer && (check_null_invalid_struct_errno (len)
+		|| __check_null_invalid_struct_errno (peer, (unsigned) *len)))
+      || !fh)
+    res =3D -1;
+  else
     res =3D fh->accept (peer, len);
=20
   syscall_printf ("%d =3D accept (%d, %x, %x)", res, fd, peer, len);
@@ -1011,13 +1018,13 @@
 extern "C" int
 cygwin_bind (int fd, const struct sockaddr *my_addr, int addrlen)
 {
-  if (__check_null_invalid_struct_errno (my_addr, addrlen))
-    return -1;
-
-  int res =3D -1;
-
+  int res;
   fhandler_socket *fh =3D get (fd);
-  if (fh)
+
+  if (__check_invalid_read_ptr_errno (my_addr, addrlen)
+      || !fh)
+    res =3D -1;
+  else
     res =3D fh->bind (my_addr, addrlen);
=20
   syscall_printf ("%d =3D bind (%d, %x, %d)", res, fd, my_addr, addrlen);
@@ -1028,14 +1035,14 @@
 extern "C" int
 cygwin_getsockname (int fd, struct sockaddr *addr, int *namelen)
 {
-  if (check_null_invalid_struct_errno (namelen)
-      || __check_null_invalid_struct_errno (addr, (unsigned) *namelen))
-    return -1;
-
-  int res =3D -1;
-
+  int res;
   fhandler_socket *fh =3D get (fd);
-  if (fh)
+
+  if (check_null_invalid_struct_errno (namelen)
+      || __check_null_invalid_struct_errno (addr, (unsigned) *namelen)
+      || !fh)
+    res =3D -1;
+  else
     res =3D fh->getsockname (addr, namelen);
=20
   syscall_printf ("%d =3D getsockname (%d, %x, %d)", res, fd, addr, namele=
n);
@@ -1046,10 +1053,12 @@
 extern "C" int
 cygwin_listen (int fd, int backlog)
 {
-  int res =3D -1;
-
+  int res;
   fhandler_socket *fh =3D get (fd);
-  if (fh)
+
+  if (!fh)
+    res =3D -1;
+  else
     res =3D fh->listen (backlog);
=20
   syscall_printf ("%d =3D listen (%d, %d)", res, fd, backlog);
@@ -1060,11 +1069,12 @@
 extern "C" int
 cygwin_shutdown (int fd, int how)
 {
-  int res =3D -1;
-  sigframe thisframe (mainthread);
-
+  int res;
   fhandler_socket *fh =3D get (fd);
-  if (fh)
+
+  if (!fh)
+    res =3D -1;
+  else
     res =3D fh->shutdown (how);
=20
   syscall_printf ("%d =3D shutdown (%d, %d)", res, fd, how);
@@ -1122,18 +1132,17 @@
 extern "C" int
 cygwin_getpeername (int fd, struct sockaddr *name, int *len)
 {
-  int res =3D -1;
+  int res;
+  fhandler_socket *fh =3D get (fd);
=20
   if (check_null_invalid_struct_errno (len)
-      || __check_null_invalid_struct_errno (name, (unsigned) *len))
-    return -1;
-
-  fhandler_socket *fh =3D get (fd);
-  if (fh)
+      || __check_null_invalid_struct_errno (name, (unsigned) *len)
+      || !fh)
+    res =3D -1;
+  else
     res =3D fh->getpeername (name, len);
=20
   syscall_printf ("%d =3D getpeername %d", res, (fh ? fh->get_socket () : =
-1));
-
   return res;
 }
=20
@@ -1150,7 +1159,6 @@
     res =3D fh->recv (buf, len, flags);
=20
   syscall_printf ("%d =3D recv (%d, %x, %x, %x)", res, fd, buf, len, flags=
);
-
   return res;
 }
=20
@@ -1161,13 +1169,12 @@
   int res;
   fhandler_socket *fh =3D get (fd);
=20
-  if (__check_invalid_read_ptr_errno (buf, len) || !fh)
+  if ((len &&__check_invalid_read_ptr_errno (buf, len)) || !fh)
     res =3D -1;
   else
     res =3D fh->send (buf, len, flags);
=20
   syscall_printf ("%d =3D send (%d, %x, %d, %x)", res, fd, buf, len, flags=
);
-
   return res;
 }
=20
@@ -2095,32 +2102,40 @@
=20
 /* exported as recvmsg: standards? */
 extern "C" int
-cygwin_recvmsg (int s, struct msghdr *msg, int flags)
+cygwin_recvmsg (int fd, struct msghdr *msg, int flags)
 {
-  if (check_null_invalid_struct_errno (msg))
-    return -1;
+  int res;
+  fhandler_socket *fh =3D get (fd);
=20
-  fhandler_socket *fh =3D get (s);
-  if (!fh)
-    {
-      set_errno (EINVAL);
-      return -1;
-    }
-  return fh->recvmsg (msg, flags);
+  if (check_null_invalid_struct_errno (msg)
+      || (msg->msg_name
+	  && __check_null_invalid_struct_errno (msg->msg_name,
+						(unsigned) msg->msg_namelen))
+      || !fh)
+    res =3D -1;
+  else
+    res =3D fh->recvmsg (msg, flags);
+
+  syscall_printf ("%d =3D recvmsg (%d, %x, %x)", res, fd, msg, flags);
+  return res;
 }
=20
 /* exported as sendmsg: standards? */
 extern "C" int
-cygwin_sendmsg (int s, const struct msghdr *msg, int flags)
+cygwin_sendmsg (int fd, const struct msghdr *msg, int flags)
 {
-    if (__check_invalid_read_ptr_errno (msg, sizeof msg))
-      return -1;
+  int res;
+  fhandler_socket *fh =3D get (fd);
=20
-    fhandler_socket *fh =3D get (s);
-    if (!fh)
-      {
-        set_errno (EINVAL);
-	return -1;
-      }
-    return fh->sendmsg (msg, flags);
+  if (__check_invalid_read_ptr_errno (msg, sizeof msg)
+      || (msg->msg_name
+	  && __check_null_invalid_struct_errno (msg->msg_name,
+						(unsigned) msg->msg_namelen))
+      || !fh)
+    res =3D -1;
+  else
+    res =3D fh->sendmsg (msg, flags);
+
+  syscall_printf ("%d =3D recvmsg (%d, %x, %x)", res, fd, msg, flags);
+  return res;
 }
Index: resource.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/resource.cc,v
retrieving revision 1.21
diff -u -r1.21 resource.cc
--- resource.cc	5 Jun 2002 04:01:43 -0000	1.21
+++ resource.cc	7 Aug 2002 16:51:50 -0000
@@ -157,7 +157,7 @@
 extern "C" int
 setrlimit (int resource, const struct rlimit *rlp)
 {
-  if (check_null_invalid_struct_errno (rlp))
+  if (__check_invalid_read_ptr_errno (rlp, sizeof (*rlp)))
     return -1;
=20
   struct rlimit oldlimits;
Index: winsup.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/winsup.h,v
retrieving revision 1.96
diff -u -r1.96 winsup.h
--- winsup.h	27 Jun 2002 20:44:27 -0000	1.96
+++ winsup.h	7 Aug 2002 16:51:50 -0000
@@ -212,8 +212,8 @@
 int __stdcall check_null_empty_str (const char *name) __attribute__ ((regp=
arm(1)));
 int __stdcall check_null_empty_str_errno (const char *name) __attribute__ =
((regparm(1)));
 int __stdcall check_null_str_errno (const char *name) __attribute__ ((regp=
arm(1)));
-int __stdcall __check_null_invalid_struct (const void *s, unsigned sz) __a=
ttribute__ ((regparm(2)));
-int __stdcall __check_null_invalid_struct_errno (const void *s, unsigned s=
z) __attribute__ ((regparm(2)));
+int __stdcall __check_null_invalid_struct (void *s, unsigned sz) __attribu=
te__ ((regparm(2)));
+int __stdcall __check_null_invalid_struct_errno (void *s, unsigned sz) __a=
ttribute__ ((regparm(2)));
 int __stdcall __check_invalid_read_ptr_errno (const void *s, unsigned sz) =
__attribute__ ((regparm(2)));
=20
 #define check_null_invalid_struct(s) \

------=_NextPart_000_03FF_01C23E3F.858E4330--

