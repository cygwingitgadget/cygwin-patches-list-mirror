Return-Path: <cygwin-patches-return-2751-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 32375 invoked by alias); 31 Jul 2002 01:11:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32360 invoked from network); 31 Jul 2002 01:11:01 -0000
Message-ID: <086701c2382f$2c6b19b0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <07f001c2381e$43118070$6132bc3e@BABEL> <20020731002910.GD17985@redhat.com>
Subject: Re: Performance: fhandler_socket and ready_for_read()
Date: Tue, 30 Jul 2002 18:11:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0864_01C23837.8D85FB40"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00199.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0864_01C23837.8D85FB40
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 636

"Christopher Faylor" <cgf@redhat.com> wrote:
> Unless you disagree, would you mind just adding a
> get_r_no_interrupt method to fhandler_socket,
> using the same criteria as your ready_for_read stub?

No disagreement there, that's cleaner.  See attached for a new
patch.

> Thanks for finding this, by the way.  A speed improvement in
> socket handling is very welcome.

Thanks.  And yes, after this patch cygserver with sockets is still
not as quick as with named pipes, but it's made up a lot of
ground.

> Sounds like it is time for a 1.3.13 release.

Ominous numbers those . . .  I'm just glad I'm not superstitious
:-)

// Conrad


------=_NextPart_000_0864_01C23837.8D85FB40
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 189

2002-07-31  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* fhandler.h (fhandler_socket::get_r_no_interrupt): New method.
	* fhandler_socket.cc (fhandler_socket::get_r_no_interrupt): Ditto.

------=_NextPart_000_0864_01C23837.8D85FB40
Content-Type: text/plain;
	name="get_r_no_interrupt.patch.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="get_r_no_interrupt.patch.txt"
Content-length: 1446

Index: fhandler.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.131
diff -u -r1.131 fhandler.h
--- fhandler.h	31 Jul 2002 00:26:36 -0000	1.131
+++ fhandler.h	31 Jul 2002 00:57:43 -0000
@@ -379,6 +379,8 @@
   int get_socket () { return (int) get_handle(); }
   fhandler_socket * is_socket () { return this; }
=20
+  virtual bool get_r_no_interrupt ();
+
   bool saw_shutdown_read () const {return FHISSETF (SHUTRD);}
   bool saw_shutdown_write () const {return FHISSETF (SHUTWR);}
=20
Index: fhandler_socket.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler_socket.cc,v
retrieving revision 1.55
diff -u -r1.55 fhandler_socket.cc
--- fhandler_socket.cc	13 Jul 2002 20:00:25 -0000	1.55
+++ fhandler_socket.cc	31 Jul 2002 00:57:44 -0000
@@ -110,6 +110,15 @@
     cfree (sun_path);
 }
=20
+bool
+fhandler_socket::get_r_no_interrupt ()
+{
+  if (!is_nonblocking () && winsock2_active)
+    return true;
+  else
+    return fhandler_base::get_r_no_interrupt ();
+}
+
 void
 fhandler_socket::set_connect_secret ()
 {

------=_NextPart_000_0864_01C23837.8D85FB40--

