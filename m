Return-Path: <cygwin-patches-return-4525-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20573 invoked by alias); 22 Jan 2004 23:34:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20551 invoked from network); 22 Jan 2004 23:34:05 -0000
Message-Id: <3.0.5.32.20040122183313.00839860@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Thu, 22 Jan 2004 23:34:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: secret event
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1074832393==_"
X-SW-Source: 2004-q1/txt/msg00015.txt.bz2

--=====================_1074832393==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 939

fhandler_socket.cc has a handle leak: when several accept()'s are 
made on an AF_LOCAL parent socket, it accumulates secret_event handles.

Also close on exec does not work properly on the secret_event when 
the call occurs after the event creation.

The patch fixes both issues. For the close on exec, the event is
always created with inheritance allowed, but the handle inheritance
is set appropriately.
I had to drop the ProtectHandle because of the changing inheritance.

Pierre

2004-01-22  Pierre Humblet <pierre.humblet@ieee.org>

	* fhandler_socket.cc (fhandler_socket::create_secret_event): Avoid
	creating multiple handles. Always allow event inheritance but set the
	handle inheritance appropriately. Improve error handling.
	(fhandler_socket::check_peer_secret_event): Improve error handling.
	(fhandler_socket::close_secret_event): Simply call CloseHandle.
	(fhandler_socket::set_close_on_exec): Set secret event inheritance.

--=====================_1074832393==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="fhandler_socket.diff"
Content-length: 2687

Index: fhandler_socket.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler_socket.cc,v
retrieving revision 1.115
diff -u -p -r1.115 fhandler_socket.cc
--- fhandler_socket.cc	7 Dec 2003 22:37:11 -0000	1.115
+++ fhandler_socket.cc	22 Jan 2004 23:27:49 -0000
@@ -183,6 +183,9 @@ fhandler_socket::create_secret_event (in
   struct sockaddr_in sin;
   int sin_len =3D sizeof (sin);

+  if (secret_event)
+    return secret_event;
+
   if (::getsockname (get_socket (), (struct sockaddr*) &sin, &sin_len))
     {
       debug_printf ("error getting local socket name (%d)", WSAGetLastErro=
r ());
@@ -191,17 +194,13 @@ fhandler_socket::create_secret_event (in

   char event_name[CYG_MAX_PATH];
   secret_event_name (event_name, sin.sin_port, secret ?: connect_secret);
-  LPSECURITY_ATTRIBUTES sec =3D get_inheritance (true);
-  secret_event =3D CreateEvent (sec, FALSE, FALSE, event_name);
-  if (!secret_event && GetLastError () =3D=3D ERROR_ALREADY_EXISTS)
-    secret_event =3D OpenEvent (EVENT_ALL_ACCESS, FALSE, event_name);
+  secret_event =3D CreateEvent (&sec_all, FALSE, FALSE, event_name);

   if (!secret_event)
-    /* nothing to do */;
-  else if (sec =3D=3D &sec_all_nih || sec =3D=3D &sec_none_nih)
-    ProtectHandle (secret_event);
-  else
-    ProtectHandleINH (secret_event);
+    debug_printf("create event %E");
+  else if (get_close_on_exec ())
+    /* Event allows inheritance, but handle will not be inherited */
+    set_inheritance (secret_event, 1);

   return secret_event;
 }
@@ -222,7 +221,7 @@ void
 fhandler_socket::close_secret_event ()
 {
   if (secret_event)
-    ForceCloseHandle (secret_event);
+    CloseHandle (secret_event);
   secret_event =3D NULL;
 }

@@ -234,11 +233,8 @@ fhandler_socket::check_peer_secret_event

   secret_event_name (event_name, peer->sin_port, secret ?: connect_secret);
   HANDLE ev =3D CreateEvent (&sec_all_nih, FALSE, FALSE, event_name);
-  if (!ev && GetLastError () =3D=3D ERROR_ALREADY_EXISTS)
-    {
-      debug_printf ("event \"%s\" already exists", event_name);
-      ev =3D OpenEvent (EVENT_ALL_ACCESS, FALSE, event_name);
-    }
+  if (!ev)
+    debug_printf("create event %E");

   signal_secret_event ();

@@ -1302,6 +1298,8 @@ fhandler_socket::fcntl (int cmd, void *a
 void
 fhandler_socket::set_close_on_exec (int val)
 {
+  if (secret_event)
+    set_inheritance (secret_event, val);
   if (!winsock2_active) /* < Winsock 2.0 */
     set_inheritance (get_handle (), val);
   set_close_on_exec_flag (val);

--=====================_1074832393==_--
