Return-Path: <cygwin-patches-return-2753-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13797 invoked by alias); 31 Jul 2002 01:44:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13783 invoked from network); 31 Jul 2002 01:44:48 -0000
Message-ID: <08e301c23833$d05627f0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <07f001c2381e$43118070$6132bc3e@BABEL> <20020731002910.GD17985@redhat.com> <086701c2382f$2c6b19b0$6132bc3e@BABEL> <20020731012133.GB21134@redhat.com>
Subject: Re: Performance: fhandler_socket and ready_for_read()
Date: Tue, 30 Jul 2002 18:44:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_08E0_01C2383C.3195A880"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00201.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_08E0_01C2383C.3195A880
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 1114

"Christopher Faylor" <cgf@redhat.com> wrote:
> Maybe I'm missing something but I don't think it has to be this
complicated.
> I think this should just be basically:
>
> bool
> fhandler_socket::get_r_no_interrupt ()
> {
>   return winsock2_active;
> }
>
> You don't have to worry about non_blocking or returning the base
class
> because you know that it is not intended to be called for the
non_blocking
> case and you know that sockets are "slow" devices.  So I think
this should
> only be gated on whether we're lucky enough to be using
winsock2.

I realised that when I wrote it but I had some sort of aesthetic
criteria reaction: like not relying on the caller to be doing the
right thing; or, like making the change as precise as possible.

Also if the setting of the NOEINTR flag is going to overridden
completely like this, perhaps set_r_no_interrupt() ought to be
virtual and overridden in fhandler_socket to generate an error,
just in case someone one day calls that and expects it to have
some effect?

In other words, you're right and I'm just being my usual pedantic
self :-)  See attached.

// Conrad


------=_NextPart_000_08E0_01C2383C.3195A880
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 172

2002-07-30  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* fhandler.h (fhandler_socket::ready_for_read): New method.
	* select.cc (fhandler_socket::ready_for_read): Ditto.

------=_NextPart_000_08E0_01C2383C.3195A880
Content-Type: text/plain;
	name="get_r_no_interrupt.patch.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="get_r_no_interrupt.patch.txt"
Content-length: 1351

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
@@ -110,6 +110,12 @@
     cfree (sun_path);
 }
=20
+bool
+fhandler_socket::get_r_no_interrupt ()
+{
+  return winsock2_active;
+}
+
 void
 fhandler_socket::set_connect_secret ()
 {

------=_NextPart_000_08E0_01C2383C.3195A880--

