Return-Path: <cygwin-patches-return-2758-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27917 invoked by alias); 31 Jul 2002 12:43:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27899 invoked from network); 31 Jul 2002 12:43:21 -0000
Message-ID: <09e301c2388d$c90be7a0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <07f001c2381e$43118070$6132bc3e@BABEL> <20020731002910.GD17985@redhat.com> <086701c2382f$2c6b19b0$6132bc3e@BABEL> <20020731012133.GB21134@redhat.com> <08e301c23833$d05627f0$6132bc3e@BABEL> <20020731020213.GC21291@redhat.com> <20020731115336.F3921@cygbert.vinschen.de>
Subject: Re: Performance: fhandler_socket and ready_for_read()
Date: Wed, 31 Jul 2002 05:43:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_09E0_01C23896.2A8D2C20"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00206.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_09E0_01C23896.2A8D2C20
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 601

"Corinna Vinschen" <cygwin-patches@cygwin.com> wrote:
> I agree.  Just setting the flag is cleaner than overriding the
method
> while the flag is still set to a wrong value, isn't it?

It is, especially now that I look at this in the, umm, early
afternoon light after a good, umm, night's sleep (tho' no coffee
or breakfast yet, so no guarantees).

Summarising last night's twisty little thread, this patch just
sets the NOEINTR flag for sockets if winsock2 is available, which
should keep us all happy.  And it makes the get_r_no_interrupt
method non-virtual again too.  Just in case :-)

// Conrad


------=_NextPart_000_09E0_01C23896.2A8D2C20
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 171

2002-07-31  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* fhandler.h (fhandler_base::get_r_no_interrupt): Make non-virtual.
	* net.cc (fdsock): Call set_r_no_interrupt.


------=_NextPart_000_09E0_01C23896.2A8D2C20
Content-Type: text/plain;
	name="set_r_no_interrupt.patch.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="set_r_no_interrupt.patch.txt"
Content-length: 1457

Index: fhandler.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.131
diff -u -r1.131 fhandler.h
--- fhandler.h	31 Jul 2002 00:26:36 -0000	1.131
+++ fhandler.h	31 Jul 2002 12:18:45 -0000
@@ -209,7 +209,7 @@
=20
   int get_default_fmode (int flags);
=20
-  virtual bool get_r_no_interrupt () { return FHISSETF (NOEINTR); }
+  bool get_r_no_interrupt () { return FHISSETF (NOEINTR); }
   void set_r_no_interrupt (int b) { FHCONDSETF (b, NOEINTR); }
=20
   bool get_close_on_exec () { return FHISSETF (CLOEXEC); }
Index: net.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/net.cc,v
retrieving revision 1.118
diff -u -r1.118 net.cc
--- net.cc	6 Jul 2002 11:16:07 -0000	1.118
+++ net.cc	31 Jul 2002 12:18:46 -0000
@@ -511,6 +511,7 @@
   fhandler_socket *fh =3D (fhandler_socket *) cygheap->fdtab.build_fhandle=
r (fd, FH_SOCKET, name);
   fh->set_io_handle ((HANDLE) soc);
   fh->set_flags (O_RDWR | O_BINARY);
+  fh->set_r_no_interrupt (winsock2_active);
   debug_printf ("fd %d, name '%s', soc %p", fd, name, soc);
   return fh;
 }

------=_NextPart_000_09E0_01C23896.2A8D2C20--

