Return-Path: <cygwin-patches-return-2749-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 1529 invoked by alias); 30 Jul 2002 23:07:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1515 invoked from network); 30 Jul 2002 23:07:55 -0000
Message-ID: <07f001c2381e$43118070$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
Subject: Performance: fhandler_socket and ready_for_read()
Date: Tue, 30 Jul 2002 16:07:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_07EB_01C23826.A4571B80"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00197.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_07EB_01C23826.A4571B80
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 2556

Attached is a socket patch that can make some programs by as much
as 50 times quicker.

In looking for something else, it struck me that there doesn't
seem to be any reason for the fhandler_base::ready_for_read()
method when reading from sockets.  All that the method seems to be
doing is checking for signals while waiting for data to arrive on
the relevant fhandler object (eventually it calls peek_socket()
which does a select() on the socket).  The fhandler_socket::read()
method already handles signals happily (if the socket is blocking
and winsock2 is available) since it uses an overlapped read and
then blocks on the socket event and the signal_arrived event.

Assuming that there is thus no need for this call to
ready_to_read() for sockets (and please tell me if I'm wrong
here), the following patch provides an stubbed
fhandler_read::ready_for_read() that does nothing when that is
valid.

In testing "transactional" programs, i.e. where one program writes
a message then reads a reply, I've seen speedups of between 3 and
50 times :-)  Goody, goody!

The 3 times quicker is for applications that have a connection per
transaction, where the connection set up and tear down dominates
the times.  The 50 times quicker is for applications that have one
connection and read/write zillions of messages to each other.
Applications that are not transactional, in this sense, are
(generally) unaffected by this patch.

I've found one situation where a (test) program is slower *with*
this patch.  I've got test programs that read and write 1Mb
messages between each other.  If they use small buffers (e.g. 1Kb)
or v. large buffers (e.g. 1Mb), they run at the same speed with or
without the patch.  On the other hand, if they use intermediate
sized buffers (e.g. 64Kb), they run twice as slowly *with* this
patch.

The reason for this seems to be that the WSARecv returns as soon
as there is any data available.  With the current (heavy)
ready_for_read() implementation, there is time for the socket
buffers to fill/empty (as appropriate) leading to fewer calls to
WSARecv().  To test this, I added a Sleep(0) into the test
programs before each call to read(2) and, lo and behold! they then
performed as well as they had w/o the patch.

I assume then that this slowdown will not affect many programs,
since most will be doing something with all the data and so will
not trip over this.  Even if they do, I would have thought that
the patch is worth it's salt.

Anyhow, enjoy!

// Conrad

p.s. This patch is independent of my UNIX domain socket patch.


------=_NextPart_000_07EB_01C23826.A4571B80
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 172

2002-07-30  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* fhandler.h (fhandler_socket::ready_for_read): New method.
	* select.cc (fhandler_socket::ready_for_read): Ditto.

------=_NextPart_000_07EB_01C23826.A4571B80
Content-Type: text/plain;
	name="ready_for_read.patch.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ready_for_read.patch.txt"
Content-length: 1516

Index: fhandler.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.83.2.11
diff -u -r1.83.2.11 fhandler.h
--- fhandler.h	23 Jul 2002 03:19:13 -0000	1.83.2.11
+++ fhandler.h	30 Jul 2002 20:01:59 -0000
@@ -426,6 +426,7 @@
   select_record *select_read (select_record *s);
   select_record *select_write (select_record *s);
   select_record *select_except (select_record *s);
+  int ready_for_read (int fd, DWORD howlong);
   void set_addr_family (int af) {addr_family =3D af;}
   int get_addr_family () {return addr_family;}
   void set_socket_type (int st) { type =3D st;}
Index: select.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/select.cc,v
retrieving revision 1.48.2.8
diff -u -r1.48.2.8 select.cc
--- select.cc	29 Jul 2002 10:54:14 -0000	1.48.2.8
+++ select.cc	30 Jul 2002 20:02:00 -0000
@@ -1451,6 +1451,15 @@
   return s;
 }
=20
+int
+fhandler_socket::ready_for_read (int fd, DWORD howlong)
+{
+  if (!is_nonblocking () && winsock2_active)
+    return 1;
+  else
+    return fhandler_base::ready_for_read (fd, howlong);
+}
+
 static int
 peek_windows (select_record *me, bool)
 {

------=_NextPart_000_07EB_01C23826.A4571B80--

