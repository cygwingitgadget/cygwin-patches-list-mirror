Return-Path: <cygwin-patches-return-2592-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 32677 invoked by alias); 3 Jul 2002 14:23:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32652 invoked from network); 3 Jul 2002 14:23:44 -0000
Message-ID: <027001c2229d$825a96e0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
Subject: Backwards?
Date: Wed, 03 Jul 2002 07:23:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_026D_01C222A5.E342F6C0"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00040.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_026D_01C222A5.E342F6C0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 1428

Yesterday the following fragment of code from tty.cc confused me
because it used small_print rather than system_printf (speedily fixed
by Chris).  Now I'm confused because I don't understand the logic:

  if (wincap.has_security ()
       && cygserver_running == CYGSERVER_OK
       && (SetKernelObjectSecurity (hMainProc,
            ACL_SECURITY_INFORMATION,
            get_null_sd ()) == FALSE))
    small_printf ("Can't set process security, %E");

The call to SetKernelObjectSecurity was in the file before the
cygserver changes were added, i.e. the code used to be (before the
first cygwin_daemon merge):

  if ((iswinnt) &&
      (SetKernelObjectSecurity (hMainProc,
               DACL_SECURITY_INFORMATION,
			               get_null_sd ()) == FALSE))
    small_printf ("Can't set process security, %E");

On that basis, shouldn't the test for cygserver be reversed:

    if (... && cygserver != CYGSERVER_OK && ...)

i.e. if cygserver isn't running, act as before?

I don't understand quite this code is trying to achieve or why but,
assuming it's wrong, I've attached a patch to reverse the test. I've
checked this on the cygwin_daemon branch, both with and without
cygserver running, and can see no difference (this is with both
processes running as the same user tho').

If someone could confirm / deny / explain this or even just wave their
hands around a bit and waffle, it would make me happier :-)

// Conrad


------=_NextPart_000_026D_01C222A5.E342F6C0
Content-Type: application/octet-stream;
	name="tty.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="tty.patch"
Content-length: 879

Index: tty.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/tty.cc,v=0A=
retrieving revision 1.36=0A=
diff -u -r1.36 tty.cc=0A=
--- tty.cc	3 Jul 2002 03:20:50 -0000	1.36=0A=
+++ tty.cc	3 Jul 2002 14:16:32 -0000=0A=
@@ -399,7 +399,7 @@=0A=
   /* FIXME: we shold NOT set the security wide open when the=0A=
      daemon is running=0A=
    */=0A=
-  if (wincap.has_security () && cygserver_running=3D=3DCYGSERVER_OK &&=0A=
+  if (wincap.has_security () && cygserver_running!=3DCYGSERVER_OK &&=0A=
       (SetKernelObjectSecurity (hMainProc, DACL_SECURITY_INFORMATION,=0A=
 			       get_null_sd ()) =3D=3D FALSE))=0A=
     system_printf ("Can't set process security, %E");=0A=

------=_NextPart_000_026D_01C222A5.E342F6C0
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 156

2002-07-03  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* tty.cc (tty::common_init): Reverse logic of cygserver check in
	call to SetKernelObjectSecurity.

------=_NextPart_000_026D_01C222A5.E342F6C0--

