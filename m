Return-Path: <cygwin-patches-return-2922-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 1949 invoked by alias); 3 Sep 2002 13:46:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1928 invoked from network); 3 Sep 2002 13:46:21 -0000
Message-ID: <003c01c25350$b10c0800$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
Subject: readv/writev patch for sockets
Date: Tue, 03 Sep 2002 06:46:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0039_01C25359.125DD810"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00370.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0039_01C25359.125DD810
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 548

Dear all,

Now that Corinna's given her okay on the approach I've taken (my thanks
to you for that), attached is the second installment of my readv/writev
patch: this one uses the winsock2 scatter/gather IO interfaces to
support the readv/writev system calls directly.  I've tested this patch
(or one much like it) on win2k, nt4 and win98SE, so I hope it's good
this time around.  I've also removed all the new-style C++ cast
operators and I hope there are no other style aberrations of the kind I
let slip into the last patch.

Enjoy!

// Conrad


------=_NextPart_000_0039_01C25359.125DD810
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 695

2002-09-03  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* fhandler.h (fhandler_socket::read): Remove method.
	(fhandler_socket::write): Ditto.
	(fhandler_socket::readv): New method.
	(fhandler_socket::writev): Ditto.
	(fhandler_socket::recvmsg): Add new optional argument.
	(fhandler_socket::sendmsg): Ditto.
	* fhandler.cc (fhandler_socket::read): Remove method.
	(fhandler_socket::write): Ditto.
	(fhandler_socket::readv): New method.
	(fhandler_socket::writev): Ditto.
	(fhandler_socket::recvmsg): Use win32's scatter/gather IO where
	possible.
	(fhandler_socket::sendmsg): Ditto.
	* net.cc (cygwin_recvmsg): Check the msghdr's iovec fields.
	(cygwin_sendmsg): Ditto.  Add omitted sigframe.

------=_NextPart_000_0039_01C25359.125DD810
Content-Type: text/plain;
	name="iovec_sockets.patch.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="iovec_sockets.patch.txt"
Content-length: 15250

Index: fhandler.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.138
diff -u -p -r1.138 fhandler.h
--- fhandler.h	31 Aug 2002 03:35:50 -0000	1.138
+++ fhandler.h	3 Sep 2002 13:31:50 -0000
@@ -400,15 +400,15 @@ class fhandler_socket: public fhandler_b
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
retrieving revision 1.62
diff -u -p -r1.62 fhandler_socket.cc
--- fhandler_socket.cc	30 Aug 2002 15:47:09 -0000	1.62
+++ fhandler_socket.cc	3 Sep 2002 13:31:50 -0000
@@ -660,60 +660,69 @@ fhandler_socket::getpeername (struct soc
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
+      msg_iov:		(struct iovec *) iov, // const_cast
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
+  int res;
+  DWORD ret;
=20
   flags &=3D MSG_WINMASK;
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
+  if (!winsock2_active)
+    ret =3D res =3D ::recvfrom (get_socket (),
+			    (char *) ptr, len, flags,
+			    from, fromlen);
   else
     {
       WSABUF wsabuf =3D { len, (char *) ptr };
-      DWORD ret =3D 0;
-      if (WSARecvFrom (get_socket (), &wsabuf, 1, &ret, (DWORD *)&flags,
-		       from, fromlen, ovr, NULL) !=3D SOCKET_ERROR)
-	res =3D ret;
-      else if ((res =3D WSAGetLastError ()) !=3D WSA_IO_PENDING)
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
@@ -723,120 +732,294 @@ fhandler_socket::recvmsg (struct msghdr=20
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
-      ssize_t cnt =3D iov->iov_len;
-      if (nb < cnt)
-	cnt =3D nb;
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
+			(struct sockaddr *) msg->msg_name,
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
+	  char *buf =3D (char *) alloca (tot);
+
+	  if (!buf)
+	    {
+	      set_errno (ENOMEM);
+	      res =3D -1;
+	    }
+	  else
+	    {
+	      res =3D recvfrom (buf, tot, flags,
+			      (struct sockaddr *) msg->msg_name,
+			      &msg->msg_namelen);
+
+	      const struct iovec *iovptr =3D iov;
+	      int nbytes =3D res;
+
+	      while (nbytes > 0)
+		{
+		  const int frag =3D min (nbytes, (ssize_t) iovptr->iov_len);
+		  memcpy (iovptr->iov_base, buf, frag);
+		  buf +=3D frag;
+		  iovptr +=3D 1;
+		  nbytes -=3D frag;
+		}
+	    }
+	}
+    }
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
+	    wsaptr->buf =3D (char *) iovptr->iov_base;
+	  }
+	while (wsaptr !=3D wsabuf);
+      }
+
+      DWORD ret;
+
+      if (is_nonblocking ())
+	res =3D WSARecvFrom (get_socket (),
+			   wsabuf, iovcnt, &ret, (DWORD *) &flags,
+			   (struct sockaddr *) msg->msg_name,
+			   &msg->msg_namelen,
+			   NULL, NULL);
+      else
+	{
+	  wsock_event wsock_evt;
+	  res =3D WSARecvFrom (get_socket (),
+			     wsabuf, iovcnt, &ret, (DWORD *) &flags,
+			     (struct sockaddr *) msg->msg_name,
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
     }
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
+      msg_iov:		(struct iovec *) iov, // const_cast
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
-      if ((res =3D ::sendto (get_socket (), (const char *) ptr, len,
-			   flags & MSG_WINMASK,
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
+    res =3D ::sendto (get_socket (), (const char *) ptr, len,
+		    flags & MSG_WINMASK,
+		    (to ? (const struct sockaddr *) &sin : NULL), tolen);
   else
     {
       WSABUF wsabuf =3D { len, (char *) ptr };
-      DWORD ret =3D 0;
-      if (WSASendTo (get_socket (), &wsabuf, 1, &ret,
-		     (DWORD)(flags & MSG_WINMASK),
-		     (to ? (sockaddr *) &sin : NULL),
-		     tolen,
-		     ovr, NULL) !=3D SOCKET_ERROR)
-	res =3D ret;
-      else if ((res =3D WSAGetLastError ()) !=3D WSA_IO_PENDING)
+
+      if (is_nonblocking ())
+	res =3D WSASendTo (get_socket (), &wsabuf, 1, &ret,
+			 flags & MSG_WINMASK,
+			 (to ? (const struct sockaddr *) &sin : NULL), tolen,
+			 NULL, NULL);
+      else
 	{
-	  set_winsock_errno ();
-	  res =3D -1;
+	  wsock_event wsock_evt;
+	  res =3D WSASendTo (get_socket (), &wsabuf, 1, &ret,
+			   flags & MSG_WINMASK,
+			   (to ? (const struct sockaddr *) &sin : NULL), tolen,
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
   /* Special handling for SIGPIPE */
-  if (get_errno () =3D=3D ESHUTDOWN)
+  if (res =3D=3D -1 && get_errno () =3D=3D ESHUTDOWN)
     {
       set_errno (EPIPE);
       if (! (flags & MSG_NOSIGNAL))
         _raise (SIGPIPE);
     }
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
+		      (struct sockaddr *) msg->msg_name,
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
+	  char *const buf =3D (char *) alloca (tot);
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
+		  const int frag =3D min (nbytes, (ssize_t) iovptr->iov_len);
+		  memcpy (bufptr, iovptr->iov_base, frag);
+		  bufptr +=3D frag;
+		  iovptr +=3D 1;
+		  nbytes -=3D frag;
+		}
+
+	      res =3D sendto (buf, tot, flags,
+			    (struct sockaddr *) msg->msg_name,
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
+	    wsaptr->buf =3D (char *) iovptr->iov_base;
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
+			 (struct sockaddr *) msg->msg_name,
+			 msg->msg_namelen,
+			 NULL, NULL);
+      else
+	{
+	  wsock_event wsock_evt;
+	  res =3D WSASendTo (get_socket (), wsabuf, iovcnt, &ret, flags,
+			   (struct sockaddr *) msg->msg_name,
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
Index: net.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/net.cc,v
retrieving revision 1.123
diff -u -p -r1.123 net.cc
--- net.cc	27 Aug 2002 09:24:50 -0000	1.123
+++ net.cc	3 Sep 2002 13:31:51 -0000
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

------=_NextPart_000_0039_01C25359.125DD810--

