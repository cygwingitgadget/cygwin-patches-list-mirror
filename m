Return-Path: <cygwin-patches-return-2868-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 15466 invoked by alias); 26 Aug 2002 14:00:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15451 invoked from network); 26 Aug 2002 14:00:26 -0000
Message-ID: <015b01c24d09$50499840$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
Subject: fhandler_socket & sigframe patch
Date: Mon, 26 Aug 2002 07:00:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0158_01C24D11.B1921980"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00316.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0158_01C24D11.B1921980
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 804

Another batch of stuff from the pit:

The fhandler_socket class is unique in that many of its methods
contain a sigframe.  None of the other fhandler classes do this;
instead the sigframe is in the system call itself (in syscalls.cc
or wherever).

Attached is a patch to move these declarations from the
fhandler_socket methods into the relevant functions, mostly in
net.cc; I've also had to add one to the ioctl system call in
ioctl.cc.

Apart from the *important* and *critical* reasons of beauty and
consistency :-), another excuse for the change is that there are
occasionally two sigframe's, e.g. in fhandler_close() where one
already exists in syscalls.cc close().  Maybe not important but .
. .

I've also swept up a couple more strace touch-ups that my last
patch missed out.

Enjoy!

// Conrad


------=_NextPart_000_0158_01C24D11.B1921980
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 882

2002-08-26  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* fhandler_socket.cc (fhandler_socket::check_peer_secret_event):
	Fix strace message.
	(fhandler_socket::connect): Remove sigframe.
	(fhandler_socket::accept): Ditto.
	(fhandler_socket::getsockname): Ditto.
	(fhandler_socket::getpeername): Ditto.
	(fhandler_socket::recvfrom): Ditto.
	(fhandler_socket::recvmsg): Ditto.
	(fhandler_socket::sendto): Ditto.
	(fhandler_socket::sendmsg): Ditto.
	(fhandler_socket::close): Ditto.
	(fhandler_socket::ioctl): Ditto.
	* ioctl.cc (ioctl): Add sigframe.
	*net.cc (cygwin_sendto): Ditto.
	(cygwin_recvfrom): Ditto.
	(cygwin_recvfrom): Ditto.
	(cygwin_connect): Ditto.
	(cygwin_shutdown): Ditto.
	(cygwin_getpeername): Ditto.
	(cygwin_accept): Ditto.  Improve strace message.
	(cygwin_getsockname): Ditto.  Ditto.
	(cygwin_recvmsg): Ditto.  Ditto.
	(cygwin_sendmsg): Fix strace message.

------=_NextPart_000_0158_01C24D11.B1921980
Content-Type: text/plain;
	name="sigframe.patch.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="sigframe.patch.txt"
Content-length: 7482

Index: fhandler_socket.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler_socket.cc,v
retrieving revision 1.59
diff -u -p -r1.59 fhandler_socket.cc
--- fhandler_socket.cc	26 Aug 2002 09:57:26 -0000	1.59
+++ fhandler_socket.cc	26 Aug 2002 13:49:19 -0000
@@ -203,7 +203,7 @@ fhandler_socket::check_peer_secret_event
   ev =3D CreateEvent (&sec_all_nih, FALSE, FALSE, buf);
   if (!ev && GetLastError () =3D=3D ERROR_ALREADY_EXISTS)
     {
-      debug_printf ("%s event already exist");
+      debug_printf ("event \"%s\" already exists", buf);
       ev =3D OpenEvent (EVENT_ALL_ACCESS, FALSE, buf);
     }
=20
@@ -406,8 +406,6 @@ fhandler_socket::connect (const struct s
   sockaddr_in sin;
   int secret [4];
=20
-  sigframe thisframe (mainthread);
-
   if (!get_inet_addr (name, namelen, &sin, &namelen, secret))
     return -1;
=20
@@ -486,8 +484,6 @@ fhandler_socket::accept (struct sockaddr
   BOOL secret_check_failed =3D FALSE;
   BOOL in_progress =3D FALSE;
=20
-  sigframe thisframe (mainthread);
-
   /* Allows NULL peer and len parameters. */
   struct sockaddr_in peer_dummy;
   int len_dummy;
@@ -624,8 +620,6 @@ fhandler_socket::getsockname (struct soc
 {
   int res =3D -1;
=20
-  sigframe thisframe (mainthread);
-
   if (get_addr_family () =3D=3D AF_LOCAL)
     {
       struct sockaddr_un *sun =3D (struct sockaddr_un *) name;
@@ -659,8 +653,6 @@ fhandler_socket::getsockname (struct soc
 int
 fhandler_socket::getpeername (struct sockaddr *name, int *namelen)
 {
-  sigframe thisframe (mainthread);
-
   int res =3D ::getpeername (get_socket (), name, namelen);
   if (res)
     set_winsock_errno ();
@@ -682,8 +674,6 @@ fhandler_socket::recvfrom (void *ptr, si
   wsock_event wsock_evt;
   LPWSAOVERLAPPED ovr;
=20
-  sigframe thisframe (mainthread);
-
   if (is_nonblocking () || !(ovr =3D wsock_evt.prepare ()))
     {
       debug_printf ("Fallback to winsock 1 recvfrom call");
@@ -723,8 +713,6 @@ fhandler_socket::recvmsg (struct msghdr=20
   char *buf, *p;
   struct iovec *iov =3D msg->msg_iov;
=20
-  sigframe thisframe (mainthread);
-
   if (get_addr_family () =3D=3D AF_LOCAL)
     {
       /* On AF_LOCAL sockets the (fixed-size) name of the shared memory
@@ -771,8 +759,6 @@ fhandler_socket::sendto (const void *ptr
   LPWSAOVERLAPPED ovr;
   sockaddr_in sin;
=20
-  sigframe thisframe (mainthread);
-
   if (to && !get_inet_addr (to, tolen, &sin, &tolen))
     return -1;
=20
@@ -844,8 +830,6 @@ fhandler_socket::sendmsg (const struct m
 int
 fhandler_socket::shutdown (int how)
 {
-  sigframe thisframe (mainthread);
-
   int res =3D ::shutdown (get_socket (), how);
=20
   if (res)
@@ -872,8 +856,6 @@ fhandler_socket::close ()
 {
   int res =3D 0;
=20
-  sigframe thisframe (mainthread);
-
   /* HACK to allow a graceful shutdown even if shutdown() hasn't been
      called by the application. Note that this isn't the ultimate
      solution but it helps in many cases. */
@@ -915,8 +897,6 @@ fhandler_socket::ioctl (unsigned int cmd
   int res;
   struct ifconf ifc, *ifcp;
   struct ifreq *ifr, *ifrp;
-
-  sigframe thisframe (mainthread);
=20
   switch (cmd)
     {
Index: ioctl.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/ioctl.cc,v
retrieving revision 1.15
diff -u -p -r1.15 ioctl.cc
--- ioctl.cc	13 Jan 2002 20:03:03 -0000	1.15
+++ ioctl.cc	26 Aug 2002 13:49:19 -0000
@@ -20,11 +20,14 @@ details. */
 #include "path.h"
 #include "dtable.h"
 #include "cygheap.h"
+#include "sigproc.h"
 #include <sys/termios.h>
=20
 extern "C" int
 ioctl (int fd, int cmd, ...)
 {
+  sigframe thisframe (mainthread);
+
   cygheap_fdget cfd (fd);
   if (cfd < 0)
     return -1;
Index: net.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/net.cc,v
retrieving revision 1.122
diff -u -p -r1.122 net.cc
--- net.cc	26 Aug 2002 09:57:26 -0000	1.122
+++ net.cc	26 Aug 2002 13:49:19 -0000
@@ -568,6 +568,8 @@ cygwin_sendto (int fd, const void *buf,=20
 	       const struct sockaddr *to, int tolen)
 {
   int res;
+  sigframe thisframe (mainthread);
+
   fhandler_socket *fh =3D get (fd);
=20
   if ((len && __check_invalid_read_ptr_errno (buf, (unsigned) len))
@@ -589,6 +591,8 @@ cygwin_recvfrom (int fd, void *buf, int=20
 		 struct sockaddr *from, int *fromlen)
 {
   int res;
+  sigframe thisframe (mainthread);
+
   fhandler_socket *fh =3D get (fd);
=20
   if ((len && __check_null_invalid_struct_errno (buf, (unsigned) len))
@@ -742,6 +746,8 @@ extern "C" int
 cygwin_connect (int fd, const struct sockaddr *name, int namelen)
 {
   int res;
+  sigframe thisframe (mainthread);
+
   fhandler_socket *fh =3D get (fd);
=20
   if (__check_invalid_read_ptr_errno (name, namelen) || !fh)
@@ -1002,6 +1008,8 @@ extern "C" int
 cygwin_accept (int fd, struct sockaddr *peer, int *len)
 {
   int res;
+  sigframe thisframe (mainthread);
+
   fhandler_socket *fh =3D get (fd);
=20
   if ((peer && (check_null_invalid_struct_errno (len)
@@ -1011,7 +1019,7 @@ cygwin_accept (int fd, struct sockaddr *
   else
     res =3D fh->accept (peer, len);
=20
-  syscall_printf ("%d =3D accept (%d, %p, %d)", res, fd, peer, len);
+  syscall_printf ("%d =3D accept (%d, %p, %p)", res, fd, peer, len);
   return res;
 }
=20
@@ -1036,6 +1044,8 @@ extern "C" int
 cygwin_getsockname (int fd, struct sockaddr *addr, int *namelen)
 {
   int res;
+  sigframe thisframe (mainthread);
+
   fhandler_socket *fh =3D get (fd);
=20
   if (check_null_invalid_struct_errno (namelen)
@@ -1045,7 +1055,7 @@ cygwin_getsockname (int fd, struct socka
   else
     res =3D fh->getsockname (addr, namelen);
=20
-  syscall_printf ("%d =3D getsockname (%d, %p, %d)", res, fd, addr, namele=
n);
+  syscall_printf ("%d =3D getsockname (%d, %p, %p)", res, fd, addr, namele=
n);
   return res;
 }
=20
@@ -1070,6 +1080,8 @@ extern "C" int
 cygwin_shutdown (int fd, int how)
 {
   int res;
+  sigframe thisframe (mainthread);
+
   fhandler_socket *fh =3D get (fd);
=20
   if (!fh)
@@ -1133,6 +1145,8 @@ extern "C" int
 cygwin_getpeername (int fd, struct sockaddr *name, int *len)
 {
   int res;
+  sigframe thisframe (mainthread);
+
   fhandler_socket *fh =3D get (fd);
=20
   if (check_null_invalid_struct_errno (len)
@@ -2087,6 +2101,8 @@ extern "C" int
 cygwin_recvmsg (int fd, struct msghdr *msg, int flags)
 {
   int res;
+  sigframe thisframe (mainthread);
+
   fhandler_socket *fh =3D get (fd);
=20
   if (check_null_invalid_struct_errno (msg)
@@ -2098,7 +2114,7 @@ cygwin_recvmsg (int fd, struct msghdr *m
   else
     res =3D fh->recvmsg (msg, flags);
=20
-  syscall_printf ("%d =3D recvmsg (%d, %p, %d)", res, fd, msg, flags);
+  syscall_printf ("%d =3D recvmsg (%d, %p, %x)", res, fd, msg, flags);
   return res;
 }
=20
@@ -2118,6 +2134,6 @@ cygwin_sendmsg (int fd, const struct msg
   else
     res =3D fh->sendmsg (msg, flags);
=20
-  syscall_printf ("%d =3D recvmsg (%d, %p, %d)", res, fd, msg, flags);
+  syscall_printf ("%d =3D sendmsg (%d, %p, %x)", res, fd, msg, flags);
   return res;
 }

------=_NextPart_000_0158_01C24D11.B1921980--

