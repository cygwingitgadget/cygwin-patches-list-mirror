Return-Path: <cygwin-patches-return-3880-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30432 invoked by alias); 24 May 2003 13:38:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30419 invoked from network); 24 May 2003 13:38:08 -0000
X-Originating-IP: [62.21.237.84]
X-Originating-Email: [mdvpost@hotmail.com]
From: "Micha Nelissen" <mdvpost@hotmail.com>
To: "Corinna Vinschen" <cygwin-patches@cygwin.com>
Subject: More debug info for write function in fhandler_console
Date: Sat, 24 May 2003 13:38:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0137_01C3220A.782A95E0"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Message-ID: <BAY1-DAV49zUSxvjPkQ00028010@hotmail.com>
X-OriginalArrivalTime: 24 May 2003 13:38:07.0314 (UTC) FILETIME=[B58F3320:01C321F9]
X-SW-Source: 2003-q2/txt/msg00107.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0137_01C3220A.782A95E0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 147

Hi,

This added debug info makes output of write function much clearer, because
it can skip character or sometimes it displays them twice.

Micha.

------=_NextPart_000_0137_01C3220A.782A95E0
Content-Type: application/octet-stream;
	name="cygwin_dbginfo.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cygwin_dbginfo.patch"
Content-length: 897

Index: fhandler_console.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_console.cc,v=0A=
retrieving revision 1.110=0A=
diff -u -p -r1.110 fhandler_console.cc=0A=
--- fhandler_console.cc	8 Apr 2003 21:19:33 -0000	1.110=0A=
+++ fhandler_console.cc	21 May 2003 14:14:41 -0000=0A=
@@ -1483,7 +1544,7 @@ fhandler_console::write (const void *vsr=0A=
=0A=
   while (src < end)=0A=
     {=0A=
-      debug_printf ("at %d(%c) state is %d", *src, isprint (*src) ? *src :=
 ' ',=0A=
+      debug_printf ("at index=3D%2d char=3D%3d(%c) state=3D%d", src-((unsi=
gned char*)vsrc), *src, isprint (*src) ? *src : 32,=0A=
 		    dev_state->state_);=0A=
       switch (dev_state->state_)=0A=
 	{=0A=

------=_NextPart_000_0137_01C3220A.782A95E0
Content-Type: application/octet-stream;
	name="cygwin_dbginfo.changelog"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cygwin_dbginfo.changelog"
Content-length: 103

2003-05-21  Micha Nelissen  <mdvpost@hotmail.com>

* fhandler_console.cc (write): clearer debug info.


------=_NextPart_000_0137_01C3220A.782A95E0--
