Return-Path: <cygwin-patches-return-3415-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10435 invoked by alias); 17 Jan 2003 07:08:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10420 invoked from network); 17 Jan 2003 07:08:12 -0000
Message-ID: <001a01c2bdf7$31cbd950$6501a8c0@tcurtiss2>
From: "Troy Curtiss" <tcurtiss@qcpi.com>
To: <cygwin-patches@cygwin.com>
Subject: 230.4Kbps serial support - patch #2
Date: Fri, 17 Jan 2003 07:08:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0017_01C2BDBC.83146B50"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-SW-Source: 2003-q1/txt/msg00064.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0017_01C2BDBC.83146B50
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 609

Chris,
  This patch rounds out the 230.4Kbps support in
fhandler_serial::tcsetattr() - this check probably should have been there
all along, but now catches any invalid DCB parameters (ie. trying to set an
invalid bitrate for a given port) and returns w/ errno = EINVAL as POSIX
dictates.  Can you review and check this in before 1.3.19 is released?
Thanks,

-Troy

2003-01-16  Troy Curtiss <troyc@usa.net>

 * fhandler_serial.cc (fhandler_serial::tcsetattr): return w/ errno = EINVAL
 if SetCommState() fails w/ invalid DCB parameter (eg. will catch attempts
 to set bitrates not supported by a given port.)

------=_NextPart_000_0017_01C2BDBC.83146B50
Content-Type: application/octet-stream;
	name="ser_230k4_patch2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ser_230k4_patch2"
Content-length: 1110

Index: cygwin/fhandler_serial.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_serial.cc,v=0A=
retrieving revision 1.40=0A=
diff -u -p -r1.40 fhandler_serial.cc=0A=
--- cygwin/fhandler_serial.cc	10 Jan 2003 12:32:46 -0000	1.40=0A=
+++ cygwin/fhandler_serial.cc	17 Jan 2003 06:37:03 -0000=0A=
@@ -725,8 +725,13 @@ fhandler_serial::tcsetattr (int action,=20=0A=
=20=0A=
   state.fAbortOnError =3D TRUE;=0A=
=20=0A=
-  if (memcmp (&ostate, &state, sizeof (state)) !=3D 0)=0A=
-    SetCommState (get_handle (), &state);=0A=
+  if ((memcmp (&ostate, &state, sizeof (state)) !=3D 0) &&=0A=
+      !SetCommState (get_handle (), &state))=0A=
+    {=0A=
+      /* SetCommState() failed, invalid DCB param (EINVAL in POSIX)*/=0A=
+      set_errno (EINVAL);=0A=
+      return -1;=0A=
+    }=0A=
=20=0A=
   set_r_binary ((t->c_iflag & IGNCR) ? 0 : 1);=0A=
   set_w_binary ((t->c_oflag & ONLCR) ? 0 : 1);=0A=

------=_NextPart_000_0017_01C2BDBC.83146B50--
