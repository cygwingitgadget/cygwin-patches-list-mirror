Return-Path: <cygwin-patches-return-2640-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 1048 invoked by alias); 12 Jul 2002 21:13:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1019 invoked from network); 12 Jul 2002 21:13:21 -0000
Message-ID: <002901c229e9$3ec34aa0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
Subject: cygwin.din
Date: Fri, 12 Jul 2002 14:13:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0026_01C229F1.A016A150"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00088.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0026_01C229F1.A016A150
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 887

I've been looking at cygwin.din (again) for a couple of reasons.
While I was there I noticed a couple of issues and I've attached a
patch for one (obvious?) typo.

i) The entries for read(2) are:

    _read
    read = read

  I've included a patch to make this:

    _read
    read = _read

  (this crept in at 1.49, June this year, by the looks of it).

ii) There's a rather suspicious entry in this file:

    barfly = write

  Uh? or am I missing a joke here?

iii) How should I go about adding the new SysV IPC entry points?
Rob added some as `shmat' etc. (i.e. just one entry, no
underscore) but should these instead follow the `read' pattern
above (i.e. as two entries, one with a leading underscore)?

iv) More generally, why are there these two symbols (with and
without the leading underscore) anyhow?  Any pointers for some
information on this gratefully received.

// Conrad


------=_NextPart_000_0026_01C229F1.A016A150
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 89

2002-07-12  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* cygwin.din (read): Fix typo.


------=_NextPart_000_0026_01C229F1.A016A150
Content-Type: application/octet-stream;
	name="din.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="din.patch"
Content-length: 597

Index: cygwin.din=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v=0A=
retrieving revision 1.53=0A=
diff -u -r1.53 cygwin.din=0A=
--- cygwin.din	2 Jul 2002 08:44:54 -0000	1.53=0A=
+++ cygwin.din	12 Jul 2002 18:52:39 -0000=0A=
@@ -615,7 +615,7 @@=0A=
 initstate=0A=
 setstate=0A=
 _read=0A=
-read =3D read=0A=
+read =3D _read=0A=
 readdir=0A=
 _readdir =3D readdir=0A=
 readlink=0A=

------=_NextPart_000_0026_01C229F1.A016A150--

