Return-Path: <cygwin-patches-return-1868-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18033 invoked by alias); 18 Feb 2002 22:20:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17959 invoked from network); 18 Feb 2002 22:20:40 -0000
Message-ID: <000201c1b8ca$74cd7110$f400a8c0@mchasecompaq>
From: "Michael A Chase" <mchase@ix.netcom.com>
To: <cygwin-patches@cygwin.com>
Subject: [PATCH]Correct setup.exe log file line endings
Date: Mon, 18 Feb 2002 15:00:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0005_01C1B886.B9B1A4C0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q1/txt/msg00225.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0005_01C1B886.B9B1A4C0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Content-length: 500

The log_save() currently writes "'" instead of "\n" at the end of log lines
that don't already have "\n" at the end.
--
Mac :})
** I normally forward private questions to the appropriate mail list. **
Ask Smarter: http://www.tuxedo.org/~esr/faqs/smart-questions.htm
Give a hobbit a fish and he eats fish for a day.
Give a hobbit a ring and he eats fish for an age.

ChangeLog:

2002-02-18  Michael A Chase <mchase@ix.netcom.com>

    * log.cc (log_save): Put "\n" at end of log lines instead of "'".

------=_NextPart_000_0005_01C1B886.B9B1A4C0
Content-Type: application/octet-stream;
	name="cinstall-mac-020218-1.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cinstall-mac-020218-1.patch"
Content-length: 360

--- log.cc-0	Mon Feb 18 11:19:22 2002=0A=
+++ log.cc	Mon Feb 18 13:58:51 2002=0A=
@@ -106,7 +106,7 @@ log_save (int babble, String const &file=0A=
 	  char *tstr =3D l->msg.cstr();=0A=
 	  f->write (tstr, strlen (tstr));=0A=
 	  if (tstr[strlen (tstr) - 1] !=3D '\n')=0A=
-	    f->write ("'\n", 1);=0A=
+	    f->write ("\n", 1);=0A=
 	}=0A=
     }=0A=
=20=0A=

------=_NextPart_000_0005_01C1B886.B9B1A4C0--

