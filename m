Return-Path: <cygwin-patches-return-2779-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18547 invoked by alias); 6 Aug 2002 23:40:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18533 invoked from network); 6 Aug 2002 23:40:06 -0000
Message-ID: <01de01c23da2$f1ead310$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
Subject: fhandler_socket::accept() and FIONBIO
Date: Tue, 06 Aug 2002 16:40:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_01DB_01C23DAB.53723210"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00227.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_01DB_01C23DAB.53723210
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 478

I've attached a tiny patch to fix the win98 / WSAENOBUFS problem
reported in
http://cygwin.com/ml/cygwin-developers/2002-07/msg00167.html
(amongst other places).

It turns out to be a minor ding in setting the socket back to
non-blocking in the (blocking) accept call.  Quite why this has
the effect it does on win98, I'll leave to the morning.  This
patch fixes the problem and is obviously the right thing to do:
the details I'm happy to leave 'til later.

Enjoy!

// Conrad


------=_NextPart_000_01DB_01C23DAB.53723210
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 124

2002-08-07  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* fhandler_socket.cc (fhandler_socket::accept): Fix FIONBIO call.


------=_NextPart_000_01DB_01C23DAB.53723210
Content-Type: text/plain;
	name="FIONBIO.patch.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="FIONBIO.patch.txt"
Content-length: 828

Index: fhandler_socket.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler_socket.cc,v
retrieving revision 1.55
diff -u -r1.55 fhandler_socket.cc
--- fhandler_socket.cc	13 Jul 2002 20:00:25 -0000	1.55
+++ fhandler_socket.cc	6 Aug 2002 23:33:08 -0000
@@ -524,7 +524,8 @@
           /* Unset events for listening socket and
              switch back to blocking mode */
           WSAEventSelect (get_socket (), ev[0], 0 );
-          ioctlsocket (get_socket (), FIONBIO, 0);
+	  unsigned long nonblocking =3D 0;
+          ioctlsocket (get_socket (), FIONBIO, &nonblocking);
=20
           switch (wait_result)
             {

------=_NextPart_000_01DB_01C23DAB.53723210--

