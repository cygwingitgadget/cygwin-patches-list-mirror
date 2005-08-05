Return-Path: <cygwin-patches-return-5606-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17008 invoked by alias); 5 Aug 2005 13:01:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16974 invoked by uid 22791); 5 Aug 2005 13:01:14 -0000
Received: from service.sh.cvut.cz (HELO service.sh.cvut.cz) (147.32.127.214)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Fri, 05 Aug 2005 13:01:14 +0000
Received: from localhost (localhost [127.0.0.1])
	by service.sh.cvut.cz (Postfix) with ESMTP id B0E2C1A32FD
	for <cygwin-patches@cygwin.com>; Fri,  5 Aug 2005 15:01:12 +0200 (CEST)
Received: from service.sh.cvut.cz ([127.0.0.1])
	by localhost (service [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 09869-08; Fri, 5 Aug 2005 15:01:11 +0200 (CEST)
Received: from logout.sh.cvut.cz (logout.sh.cvut.cz [147.32.127.203])
	by service.sh.cvut.cz (Postfix) with ESMTP id C91271A3302;
	Fri,  5 Aug 2005 15:01:11 +0200 (CEST)
Received: from amber2 (amber2.sh.cvut.cz [147.32.123.10])
	by logout.sh.cvut.cz (Postfix) with SMTP
	id 090B23C309; Fri,  5 Aug 2005 15:01:17 +0200 (CEST)
Message-ID: <000e01c599bd$c0c19d30$0a7b2093@amber2>
From: "Vaclav Haisman" <V.Haisman@sh.cvut.cz>
To: <cygwin-patches@cygwin.com>
Subject: fhandler_tty_slave::tcflush() in fhandler_tty.cc
Date: Fri, 05 Aug 2005 13:01:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_000B_01C599CE.83F4D320"
X-SW-Source: 2005-q3/txt/msg00061.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_000B_01C599CE.83F4D320
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Content-length: 298

fhandler_tty_slave::tcflush() is IMHO still wrong. The result of comparison 
is bool and bool converted to int is either 1 or 0. The following patch 
should cure it.

VH


2005-08-05  Vaclav Haisman  <v.haisman@sh.cvut.cz>

 * fhandler_tty.cc (fhandler_tty_slave::tcflush): Return either 0
 or -1.

------=_NextPart_000_000B_01C599CE.83F4D320
Content-Type: application/octet-stream;
	name="fhandler_tty.cc.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="fhandler_tty.cc.diff"
Content-length: 785

Index: fhandler_tty.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_tty.cc,v=0A=
retrieving revision 1.142=0A=
diff -u -p -d -r1.142 fhandler_tty.cc=0A=
--- fhandler_tty.cc	6 Jul 2005 20:05:01 -0000	1.142=0A=
+++ fhandler_tty.cc	5 Aug 2005 12:51:11 -0000=0A=
@@ -1051,7 +1051,7 @@ fhandler_tty_slave::tcflush (int queue)=0A=
     {=0A=
       size_t len =3D UINT_MAX;=0A=
       read (NULL, len);=0A=
-      ret =3D ((int) len) >=3D 0;=0A=
+      ret =3D ((int) len) >=3D 0 ? 0 : -1;=0A=
     }=0A=
   if (queue =3D=3D TCOFLUSH || queue =3D=3D TCIOFLUSH)=0A=
     {=0A=

------=_NextPart_000_000B_01C599CE.83F4D320--
