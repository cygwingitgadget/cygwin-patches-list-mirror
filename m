Return-Path: <cygwin-patches-return-1991-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 1906 invoked by alias); 19 Mar 2002 03:15:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1879 invoked from network); 19 Mar 2002 03:15:09 -0000
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Subject: Console lseek fix
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Date: Mon, 18 Mar 2002 19:41:00 -0000
Message-ID: <FC169E059D1A0442A04C40F86D9BA760014C45@itdomain003.itdomain.net.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <arch-dev@regexps.com>,
	<cygwin-patches@cygwin.com>
X-SW-Source: 2002-q1/txt/msg00348.txt.bz2

The following patch allows arch's with-ftp command to run under cygwin.

Chris, any objections?

ChangeLog:
2002-03-15  Robert Collins  <rbtcollins@hotmail.com>

	* fhandler.h (fhandler_termios::lseek): Override lseek.
	* fhandler_termios.cc (fhandler_termios::lseek): Implement this.


Index: fhandler.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.110
diff -u -p -r1.110 fhandler.h
--- fhandler.h	2002/02/28 14:25:53	1.110
+++ fhandler.h	2002/03/19 03:13:13
@@ -657,6 +657,7 @@ class fhandler_termios: public fhandler_
   void fixup_after_fork (HANDLE);
   void fixup_after_exec (HANDLE parent) { fixup_after_fork (parent); }
   void echo_erase (int force =3D 0);
+  virtual __off64_t lseek (__off64_t, int);
 };
=20
 enum ansi_intensity
Index: fhandler_termios.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler_termios.cc,v
retrieving revision 1.25
diff -u -p -r1.25 fhandler_termios.cc
--- fhandler_termios.cc	2002/03/05 08:15:25	1.25
+++ fhandler_termios.cc	2002/03/19 03:13:13
@@ -345,3 +345,10 @@ fhandler_termios::fixup_after_fork (HAND
   this->fhandler_base::fixup_after_fork (parent);
   fork_fixup (parent, get_output_handle (), "output_handle");
 }
+
+__off64_t
+fhandler_termios::lseek (__off64_t, int)=20
+{
+  set_errno (ESPIPE);
+  return -1;=20
+}
