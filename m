Return-Path: <cygwin-patches-return-8020-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 955 invoked by alias); 25 Sep 2014 12:40:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 942 invoked by uid 89); 25 Sep 2014 12:40:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RP_MATCHES_RCVD autolearn=ham version=3.3.2
X-HELO: mailout10.t-online.de
Received: from mailout10.t-online.de (HELO mailout10.t-online.de) (194.25.134.21) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Thu, 25 Sep 2014 12:40:43 +0000
Received: from fwd09.aul.t-online.de (fwd09.aul.t-online.de [172.20.27.151])	by mailout10.t-online.de (Postfix) with SMTP id 727452BB272	for <cygwin-patches@cygwin.com>; Thu, 25 Sep 2014 14:40:39 +0200 (CEST)
Received: from [192.168.2.108] (E4IXyvZG8h8czJSPY3s4a6CwHV8MWZNUdZRLHAkT0XhbAZhinWl9P9VctGrwc0ng3O@[84.180.90.136]) by fwd09.t-online.de	with (TLSv1.2:ECDHE-RSA-AES256-SHA encrypted)	esmtp id 1XX8Le-090lNY0; Thu, 25 Sep 2014 14:40:38 +0200
Message-ID: <54240D45.6080104@t-online.de>
Date: Thu, 25 Sep 2014 12:40:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:29.0) Gecko/20100101 Firefox/29.0 SeaMonkey/2.26.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Disable AF_UNIX handshake with setsockopt(..., SO_PEERCRED, ...)
Content-Type: multipart/mixed; boundary="------------080107070106090307050107"
X-IsSubscribed: yes
X-SW-Source: 2014-q3/txt/msg00015.txt.bz2

This is a multi-part message in MIME format.
--------------080107070106090307050107
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 488

This is a workaround for this problem which blocks ITP postfix:
https://cygwin.com/ml/cygwin/2014-08/msg00420.html

With the patch, this disables the secret+cred handshakes of the AF_UNIX 
emulation:

int sd = socket(AF_UNIX, SOCK_STREAM, 0);

setsockopt(sd, SOL_SOCKET, SO_PEERCRED, NULL, 0);

Postfix works if socket() calls are replaced by the above.

Calls of getsockopt(..., SO_PEERCRED, ...) and getpeereid() would fail with ENOTSUP then. These are not used by postfix.

Christian


--------------080107070106090307050107
Content-Type: text/x-patch;
 name="setsockopt-so_peercred.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="setsockopt-so_peercred.patch"
Content-length: 5080

2014-09-25  Christian Franke  <franke@computer.org>

	Add setsockopt(sd, SOL_SOCKET, SO_PEERCRED, NULL, 0) to disable
	initial handshake on AF_LOCAL sockets.

	* fhandler.h (fhandler_socket::no_getpeereid): New variable.
	(fhandler_socket::af_local_set_no_getpeereid): New prototype.
	* fhandler_socket.cc (fhandler_socket::fhandler_socket):
	Initialize no_getpeereid.
	(fhandler_socket::af_local_connect): Skip handshake if
	no_getpeereid is set.  Add debug output.
	(fhandler_socket::af_local_accept): Likewise.
	(fhandler_socket::af_local_set_no_getpeereid): New function.
	(fhandler_socket::af_local_copy): Copy no_getpeereid.
	(fhandler_socket::getpeereid): Fail if no_getpeereid is set.
	* net.cc (cygwin_setsockop): Add SO_PEERCRED.
	* select.cc (set_bits): Set socket connected state also if read
	bit is requested.

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index cf4de07..6c2c3d4 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -492,6 +492,7 @@ class fhandler_socket: public fhandler_base
   pid_t sec_peer_pid;
   uid_t sec_peer_uid;
   gid_t sec_peer_gid;
+  bool no_getpeereid;
   void af_local_set_secret (char *);
   void af_local_setblocking (bool &, bool &);
   void af_local_unsetblocking (bool, bool);
@@ -504,6 +505,7 @@ class fhandler_socket: public fhandler_base
   int af_local_accept ();
  public:
   int af_local_connect ();
+  int af_local_set_no_getpeereid ();
   void af_local_set_sockpair_cred ();
 
  private:
diff --git a/winsup/cygwin/fhandler_socket.cc b/winsup/cygwin/fhandler_socket.cc
index 0354ee2..256ac67 100644
--- a/winsup/cygwin/fhandler_socket.cc
+++ b/winsup/cygwin/fhandler_socket.cc
@@ -231,6 +231,7 @@ fhandler_socket::fhandler_socket () :
   wsock_events (NULL),
   wsock_mtx (NULL),
   wsock_evt (NULL),
+  no_getpeereid(false),
   prot_info_ptr (NULL),
   sun_path (NULL),
   peer_sun_path (NULL),
@@ -402,7 +403,10 @@ fhandler_socket::af_local_connect ()
   if (get_addr_family () != AF_LOCAL || get_socket_type () != SOCK_STREAM)
     return 0;
 
-  debug_printf ("af_local_connect called");
+  debug_printf ("af_local_connect called, no_getpeereid=%d", no_getpeereid);
+  if (no_getpeereid)
+    return 0;
+
   connect_state (connect_credxchg);
   af_local_setblocking (orig_async_io, orig_is_nonblocking);
   if (!af_local_send_secret () || !af_local_recv_secret ()
@@ -422,7 +426,10 @@ fhandler_socket::af_local_accept ()
 {
   bool orig_async_io, orig_is_nonblocking;
 
-  debug_printf ("af_local_accept called");
+  debug_printf ("af_local_accept called, no_getpeereid=%d", no_getpeereid);
+  if (no_getpeereid)
+    return 0;
+
   connect_state (connect_credxchg);
   af_local_setblocking (orig_async_io, orig_is_nonblocking);
   if (!af_local_recv_secret () || !af_local_send_secret ()
@@ -438,6 +445,25 @@ fhandler_socket::af_local_accept ()
   return 0;
 }
 
+int
+fhandler_socket::af_local_set_no_getpeereid ()
+{
+  if (get_addr_family () != AF_LOCAL || get_socket_type () != SOCK_STREAM)
+    {
+      set_errno (EINVAL);
+      return -1;
+    }
+  if (connect_state () != unconnected)
+    {
+      set_errno (EALREADY);
+      return -1;
+    }
+
+  debug_printf ("no_getpeereid set");
+  no_getpeereid = true;
+  return 0;
+}
+
 void
 fhandler_socket::af_local_set_cred ()
 {
@@ -462,6 +488,7 @@ fhandler_socket::af_local_copy (fhandler_socket *sock)
   sock->sec_peer_pid = sec_peer_pid;
   sock->sec_peer_uid = sec_peer_uid;
   sock->sec_peer_gid = sec_peer_gid;
+  sock->no_getpeereid = no_getpeereid;
 }
 
 void
@@ -2287,6 +2314,11 @@ fhandler_socket::getpeereid (pid_t *pid, uid_t *euid, gid_t *egid)
       set_errno (EINVAL);
       return -1;
     }
+  if (no_getpeereid)
+    {
+      set_errno (ENOTSUP);
+      return -1;
+    }
   if (connect_state () != connected)
     {
       set_errno (ENOTCONN);
diff --git a/winsup/cygwin/net.cc b/winsup/cygwin/net.cc
index b6c0f72..c5ca15e 100644
--- a/winsup/cygwin/net.cc
+++ b/winsup/cygwin/net.cc
@@ -810,6 +810,16 @@ cygwin_setsockopt (int fd, int level, int optname, const void *optval,
       fhandler_socket *fh = get (fd);
       if (!fh)
 	__leave;
+
+      if (optname == SO_PEERCRED && level == SOL_SOCKET)
+	{
+	  if (optval || optlen)
+	    set_errno (EINVAL);
+	  else
+	    res = fh->af_local_set_no_getpeereid ();
+	  __leave;
+	}
+
       /* Old applications still use the old WinSock1 IPPROTO_IP values. */
       if (level == IPPROTO_IP && CYGWIN_VERSION_CHECK_FOR_USING_WINSOCK1_VALUES)
 	optname = convert_ws1_ip_optname (optname);
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 6a39685..75eb726 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -473,6 +473,9 @@ set_bits (select_record *me, fd_set *readfds, fd_set *writefds,
   if (me->read_selected && me->read_ready)
     {
       UNIX_FD_SET (me->fd, readfds);
+      /* Special AF_LOCAL handling. */
+      if ((sock = me->fh->is_socket ()) && sock->connect_state () == connect_pending)
+	sock->connect_state (connected);
       ready++;
     }
   if (me->write_selected && me->write_ready)

--------------080107070106090307050107--
