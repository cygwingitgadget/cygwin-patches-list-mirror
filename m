Return-Path: <cygwin-patches-return-1570-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 30433 invoked by alias); 10 Dec 2001 23:23:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30417 invoked from network); 10 Dec 2001 23:23:57 -0000
Message-ID: <E1740305C340D411AC5500B0D020FF7A010656F2@stmail01.good.com>
From: Victor Tsou <vtsou@good.com>
To: "'cygwin-patches@cygwin.com '" <cygwin-patches@cygwin.com>
Subject: [PATCH] Serial code stack corruption
Date: Fri, 02 Nov 2001 15:55:00 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C181D1.88FACB90"
X-SW-Source: 2001-q4/txt/msg00102.txt.bz2

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C181D1.88FACB90
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C181D1.88FACB90"


------_=_NextPart_001_01C181D1.88FACB90
Content-Type: text/plain
Content-length: 425


WaitCommEvent was called in overlapped mode with a pointer to a stack
variable passed in for lpEvtMask. When the asynchronous request completes in
the future, the function might no longer be in scope. In such cases, data on
the stack is erroneously overwritten with the event mask.

This patch cancels the WaitCommEvent request by calling SetCommMask. This is
the only documented method of cancelling the eventmask update.


------_=_NextPart_001_01C181D1.88FACB90
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable
Content-length: 982

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3DUS-ASCII">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 5.5.2653.12">
<TITLE>[PATCH] Serial code stack corruption</TITLE>
</HEAD>
<BODY>
<BR>

<P><FONT SIZE=3D2>WaitCommEvent was called in overlapped mode with a pointe=
r to a stack variable passed in for lpEvtMask. When the asynchronous reques=
t completes in the future, the function might no longer be in scope. In suc=
h cases, data on the stack is erroneously overwritten with the event mask.<=
/FONT></P>

<P><FONT SIZE=3D2>This patch cancels the WaitCommEvent request by calling S=
etCommMask. This is the only documented method of cancelling the eventmask =
update.</FONT></P>

<P><FONT FACE=3D"Arial" SIZE=3D2 COLOR=3D"#000000"></FONT><FONT FACE=3D"Ari=
al" SIZE=3D2 COLOR=3D"#000000"></FONT><FONT FACE=3D"Arial" SIZE=3D2 COLOR=
=3D"#000000"></FONT>&nbsp;

</BODY>
</HTML>=

------_=_NextPart_001_01C181D1.88FACB90--

------_=_NextPart_000_01C181D1.88FACB90
Content-Type: application/octet-stream;
	name="ChangeLog"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ChangeLog"
Content-length: 192

2001-12-10  Victor Tsou  <vtsou@good.com>=0A=
=0A=
	* fhandler_serial.cc (fhandler_serial::raw_read): Cancel WaitCommEvent=0A=
	  operation on exit.=0A=
	* select.cc (peek_serial): Ditto.=0A=

------_=_NextPart_000_01C181D1.88FACB90
Content-Type: application/octet-stream;
	name="fhandler_serial.cc-patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="fhandler_serial.cc-patch"
Content-length: 275

--- fhandler_serial.cc-orig	Mon Dec 10 14:01:09 2001=0A=
+++ fhandler_serial.cc	Mon Dec 10 14:13:55 2001=0A=
@@ -148,6 +148,7 @@ fhandler_serial::raw_read (void *ptr, si=0A=
     }=0A=
=20=0A=
 out:=0A=
+  SetCommMask(get_handle (), 0);=0A=
   return tot;=0A=
 }=0A=
=20=0A=

------_=_NextPart_000_01C181D1.88FACB90
Content-Type: application/octet-stream;
	name="select.cc-patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="select.cc-patch"
Content-length: 729

--- select.cc-orig	Mon Dec 10 14:01:08 2001=0A=
+++ select.cc	Mon Dec 10 14:04:52 2001=0A=
@@ -862,6 +862,14 @@ struct serialinf=0A=
     select_record *start;=0A=
   };=0A=
=20=0A=
+struct AutoReleasePort=0A=
+  {=0A=
+    AutoReleasePort(HANDLE _h) { this->h =3D h; }=0A=
+    ~AutoReleasePort() { SetCommMask (h, 0); }=0A=
+  private:=0A=
+    HANDLE h;=0A=
+  };=0A=
+=0A=
 static int=0A=
 peek_serial (select_record *s, bool)=0A=
 {=0A=
@@ -878,6 +886,7 @@ peek_serial (select_record *s, bool)=0A=
   HANDLE h;=0A=
   set_handle_or_return_if_not_open (h, s);=0A=
   int ready =3D 0;=0A=
+  AutoReleasePort _(h);=0A=
=20=0A=
   if (s->read_selected && s->read_ready || (s->write_selected && s->write_=
ready))=0A=
     {=0A=

------_=_NextPart_000_01C181D1.88FACB90--
